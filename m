Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1A4F330154
	for <lists+bpf@lfdr.de>; Sun,  7 Mar 2021 14:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbhCGNox (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 7 Mar 2021 08:44:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:41806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230404AbhCGNo1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 7 Mar 2021 08:44:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A92B650F5;
        Sun,  7 Mar 2021 13:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615124666;
        bh=sGPg0vfNIFZkHRaBoNAGCwQE40We+ivQDUspZldquL4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ieWaLYtKMei3KwTxqrvKkCAiAKAExjkW/ukz6ZrhrK30RW5tFEHEi4dTdxKddcq8D
         QREK8sRCZPGL6I/yiZDJdNajPvhIBAZIt1BeE4kW0/Hk8cDfiWPcOXle6A1toUh9X7
         XiRRMudcdngOrzRu7agm6vkFbCctjMS2602JVeQNRK3oJB8oMUIgqHg5GFpD4U2glr
         SBg8laFNvTqsYF4Mr/rKW18SQxEUNrCSV4fhoIjnh4e5wDHWSoL/g6iU+g2/eT0jt0
         lKYo/gCPyXHlwE3mMxmllTURwqxRwz0CqUVVpOvFwmEHVldcJIAEXpdJfdK2gpxBug
         Q9hqZobshdELA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5CDF140647; Sun,  7 Mar 2021 10:44:21 -0300 (-03)
Date:   Sun, 7 Mar 2021 10:44:21 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH] btf: Add support for the floating-point types
Message-ID: <YETYtWwSFVMDAnCA@kernel.org>
References: <20210306022203.152930-1-iii@linux.ibm.com>
 <CAEf4BzYvawU4jTKwoUagY0Bn0SYNwcSohb-ZAPq_rLvF5qLamg@mail.gmail.com>
 <YETSLwfibXxelBIN@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YETSLwfibXxelBIN@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Sun, Mar 07, 2021 at 10:16:31AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Sat, Mar 06, 2021 at 07:16:08PM -0800, Andrii Nakryiko escreveu:
> > On Fri, Mar 5, 2021 at 6:22 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
> > >
> > > Some BPF programs compiled on s390 fail to load, because s390
> > > arch-specific linux headers contain float and double types.
> > >
> > > Fix as follows:
> > >
> > > - Make DWARF loader fill base_type.float_type.
> > >
> > > - libbpf introduced support for the floating-point types in commit
> > >   986962fade5, so update the libbpf submodule to that version and use
> > >   the new btf__add_float() function in order to emit the floating-point
> > >   types when base_type.float_type is set.
> > >
> > > Example of the resulting entry in the vmlinux BTF:
> > >
> > >     [7164] FLOAT 'double' size=8

> > [PATCH dwarves] would make it a bit clearer that this is pahole patch.

> > But LGTM.
 
> So older versions of bpftool will fail with a .BTF section having this
> new float? I thought it would just skip it emitting a warning? Probably
> not possible as we don't have the record size encoded in a header,
> right?
 
> [acme@five pahole]$ bpftool btf dump file vmlinux | grep -w FLOAT
> [acme@five pahole]$ type pahole
> pahole is /home/acme/bin/pahole
> [acme@five pahole]$ ls -la ~/bin/pahole
> lrwxrwxrwx. 1 acme acme 34 Jan 29 11:00 /home/acme/bin/pahole -> /home/acme/git/pahole/build/pahole
> [acme@five pahole]$ pahole -J vmlinux
> [acme@five pahole]$ bpftool btf dump file vmlinux | grep -w FLOAT | head
> Error: failed to load BTF from vmlinux: Invalid argument
> [acme@five pahole]$
> 
> Perhaps the warning emitted by bpftool should suggest updating the tool
> as it found a record type it doesn't know about?
> 
> /me goes to update bpftool...

Works with the bpftool in bpf-next:

[acme@five pahole]$ bpftool btf dump file vmlinux | grep -w FLOAT | head
[8006] FLOAT 'double' size=8
[acme@five pahole]$

- Arnaldo
 
> - Arnaldo
>  
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > 
> > >  btf_loader.c   | 21 +++++++++++++++++++--
> > >  dwarf_loader.c | 11 +++++++++++
> > >  lib/bpf        |  2 +-
> > >  libbtf.c       | 28 +++++++++++++++++++++++++++-
> > >  4 files changed, 58 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/btf_loader.c b/btf_loader.c
> > > index ec286f4..7cc39aa 100644
> > > --- a/btf_loader.c
> > > +++ b/btf_loader.c
> > > @@ -160,7 +160,7 @@ static struct variable *variable__new(strings_t name, uint32_t linkage)
> > >         return var;
> > >  }
> > >
> > > -static int create_new_base_type(struct btf_elf *btfe, const struct btf_type *tp, uint32_t id)
> > > +static int create_new_int_type(struct btf_elf *btfe, const struct btf_type *tp, uint32_t id)
> > >  {
> > >         uint32_t attrs = btf_int_encoding(tp);
> > >         strings_t name = tp->name_off;
> > > @@ -175,6 +175,20 @@ static int create_new_base_type(struct btf_elf *btfe, const struct btf_type *tp,
> > >         return 0;
> > >  }
> > >
> > > +static int create_new_float_type(struct btf_elf *btfe, const struct btf_type *tp, uint32_t id)
> > > +{
> > > +       strings_t name = tp->name_off;
> > > +       struct base_type *base = base_type__new(name, 0, BT_FP_SINGLE, tp->size * 8);
> > > +
> > > +       if (base == NULL)
> > > +               return -ENOMEM;
> > > +
> > > +       base->tag.tag = DW_TAG_base_type;
> > > +       cu__add_tag_with_id(btfe->priv, &base->tag, id);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > >  static int create_new_array(struct btf_elf *btfe, const struct btf_type *tp, uint32_t id)
> > >  {
> > >         struct btf_array *ap = btf_array(tp);
> > > @@ -397,7 +411,7 @@ static int btf_elf__load_types(struct btf_elf *btfe)
> > >
> > >                 switch (type) {
> > >                 case BTF_KIND_INT:
> > > -                       err = create_new_base_type(btfe, type_ptr, type_index);
> > > +                       err = create_new_int_type(btfe, type_ptr, type_index);
> > >                         break;
> > >                 case BTF_KIND_ARRAY:
> > >                         err = create_new_array(btfe, type_ptr, type_index);
> > > @@ -442,6 +456,9 @@ static int btf_elf__load_types(struct btf_elf *btfe)
> > >                         // BTF_KIND_FUNC corresponding to a defined subprogram.
> > >                         err = create_new_function(btfe, type_ptr, type_index);
> > >                         break;
> > > +               case BTF_KIND_FLOAT:
> > > +                       err = create_new_float_type(btfe, type_ptr, type_index);
> > > +                       break;
> > >                 default:
> > >                         fprintf(stderr, "BTF: idx: %d, Unknown kind %d\n", type_index, type);
> > >                         fflush(stderr);
> > > diff --git a/dwarf_loader.c b/dwarf_loader.c
> > > index b73d786..c5e6681 100644
> > > --- a/dwarf_loader.c
> > > +++ b/dwarf_loader.c
> > > @@ -461,6 +461,16 @@ static struct ptr_to_member_type *ptr_to_member_type__new(Dwarf_Die *die,
> > >         return ptr;
> > >  }
> > >
> > > +static uint8_t encoding_to_float_type(uint64_t encoding)
> > > +{
> > > +       switch (encoding) {
> > > +       case DW_ATE_complex_float:      return BT_FP_CMPLX;
> > > +       case DW_ATE_float:              return BT_FP_SINGLE;
> > > +       case DW_ATE_imaginary_float:    return BT_FP_IMGRY;
> > > +       default:                        return 0;
> > > +       }
> > > +}
> > > +
> > >  static struct base_type *base_type__new(Dwarf_Die *die, struct cu *cu)
> > >  {
> > >         struct base_type *bt = tag__alloc(cu, sizeof(*bt));
> > > @@ -474,6 +484,7 @@ static struct base_type *base_type__new(Dwarf_Die *die, struct cu *cu)
> > >                 bt->is_signed = encoding == DW_ATE_signed;
> > >                 bt->is_varargs = false;
> > >                 bt->name_has_encoding = true;
> > > +               bt->float_type = encoding_to_float_type(encoding);
> > >         }
> > >
> > >         return bt;
> > > diff --git a/lib/bpf b/lib/bpf
> > > index 5af3d86..986962f 160000
> > > --- a/lib/bpf
> > > +++ b/lib/bpf
> > > @@ -1 +1 @@
> > > -Subproject commit 5af3d86b5a2c5fecdc3ab83822d083edd32b4396
> > > +Subproject commit 986962fade5dfa89c2890f3854eb040d2a64ab38
> > > diff --git a/libbtf.c b/libbtf.c
> > > index 9f76283..ccd9f90 100644
> > > --- a/libbtf.c
> > > +++ b/libbtf.c
> > > @@ -227,6 +227,7 @@ static const char * const btf_kind_str[NR_BTF_KINDS] = {
> > >         [BTF_KIND_FUNC_PROTO]   = "FUNC_PROTO",
> > >         [BTF_KIND_VAR]          = "VAR",
> > >         [BTF_KIND_DATASEC]      = "DATASEC",
> > > +       [BTF_KIND_FLOAT]        = "FLOAT",
> > >  };
> > >
> > >  static const char *btf_elf__printable_name(const struct btf_elf *btfe, uint32_t offset)
> > > @@ -367,6 +368,27 @@ static void btf_log_func_param(const struct btf_elf *btfe,
> > >         }
> > >  }
> > >
> > > +static int32_t btf_elf__add_float_type(struct btf_elf *btfe,
> > > +                                      const struct base_type *bt,
> > > +                                      const char *name)
> > > +{
> > > +       int32_t id;
> > > +
> > > +       id = btf__add_float(btfe->btf, name, BITS_ROUNDUP_BYTES(bt->bit_size));
> > > +       if (id < 0) {
> > > +               btf_elf__log_err(btfe, BTF_KIND_FLOAT, name, true, "Error emitting BTF type");
> > > +       } else {
> > > +               const struct btf_type *t;
> > > +
> > > +               t = btf__type_by_id(btfe->btf, id);
> > > +               btf_elf__log_type(btfe, t, false, true,
> > > +                                 "size=%u nr_bits=%u",
> > > +                                 t->size, bt->bit_size);
> > > +       }
> > > +
> > > +       return id;
> > > +}
> > > +
> > >  int32_t btf_elf__add_base_type(struct btf_elf *btfe, const struct base_type *bt,
> > >                                const char *name)
> > >  {
> > > @@ -380,7 +402,11 @@ int32_t btf_elf__add_base_type(struct btf_elf *btfe, const struct base_type *bt,
> > >         } else if (bt->is_bool) {
> > >                 encoding = BTF_INT_BOOL;
> > >         } else if (bt->float_type) {
> > > -               fprintf(stderr, "float_type is not supported\n");
> > > +               if (bt->float_type == BT_FP_SINGLE ||
> > > +                   bt->float_type == BT_FP_DOUBLE ||
> > > +                   bt->float_type == BT_FP_LDBL)
> > > +                       return btf_elf__add_float_type(btfe, bt, name);
> > > +               fprintf(stderr, "Complex, interval and imaginary float types are not supported\n");
> > >                 return -1;
> > >         }
> > >
> > > --
> > > 2.29.2
> > >
> 
> -- 
> 
> - Arnaldo

-- 

- Arnaldo
