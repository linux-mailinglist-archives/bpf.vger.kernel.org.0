Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 731A219FF9
	for <lists+bpf@lfdr.de>; Fri, 10 May 2019 17:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbfEJPR6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 May 2019 11:17:58 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38941 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727374AbfEJPR5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 May 2019 11:17:57 -0400
Received: by mail-ot1-f65.google.com with SMTP id r7so1416879otn.6
        for <bpf@vger.kernel.org>; Fri, 10 May 2019 08:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q0AdmB2Ribb69WZgIXem/aSFpim7bXdsvKjI28i23gE=;
        b=rZqCvDmT0+AXssSXGnAA9AJw4wXWq874vYPoin+DMy3r6gawNMT7DWg6746jroDd/x
         sShBCQugXHw07kkMFceLr/UxI/pxoZ5WZtwQ4UbYA6fQJvyA4a/wVn+YBudMiG+YRTO9
         pyBj7zp8vJV5aGsfXO35kFOT1AzQt8+v17OrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q0AdmB2Ribb69WZgIXem/aSFpim7bXdsvKjI28i23gE=;
        b=ue1GNR+uSvumDthtZy7+8XcA13NIPHC+0avfuwS5cEZftPP5jJsDXr5tqBEotGsoy2
         DHKbPoPfmzPgK3VdvzyR/0z0EpSxIdT347Y6mKkgZKC5v1hQ9VHgUxybHss4P3iWgIgg
         J9qlMtAlG8758q5hPn0xuuQqeyQMpjiNH5AXJPjokPgelCVLPneWSoSa1zAzqyuBDRle
         o+yUxbKjSpXqtwMXs6FlGLYfPaWF9FtZRdmkh5OAW7vz2ov3tk6s/swcag4msjatLxoe
         jPdwqcc0jY2X1B7DuEdUBpXL7uQldBtU/2UYvwOdNxI0pKZmycdZwWc02gxdmRdStN4+
         ZTrQ==
X-Gm-Message-State: APjAAAV42w9pI8o1RoCbXq/qZhqA3tEKa8cdKBXWpCqVqsOJQNFmcmM0
        n05G8Hjf7UKdZCSFvjo9mYoIGExW2nvw2/jiFm5c/A==
X-Google-Smtp-Source: APXvYqyFt5GxmW1MZA2favbnaGcALb5mA4MoHVzSPHzcHbrwxbVk/7uXhgi8vvAQlXavsk2qquYwokltZ6a5lIXnf1M=
X-Received: by 2002:a9d:5e15:: with SMTP id d21mr7540040oti.138.1557501476705;
 Fri, 10 May 2019 08:17:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190510043723.3359135-1-andriin@fb.com> <CACAyw9_9Q4CPzPm-ikMyMMmWR56u+5c7RpW-7o0YBG5JoheF2A@mail.gmail.com>
 <CAEf4BzafBqC63EW8Pf8Du4McL9veOU_SUOHoE9_94zTv9r1XJg@mail.gmail.com>
In-Reply-To: <CAEf4BzafBqC63EW8Pf8Du4McL9veOU_SUOHoE9_94zTv9r1XJg@mail.gmail.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Fri, 10 May 2019 16:17:45 +0100
Message-ID: <CACAyw99Rpmn1=jgOJfbvBsTfTn2txK1mFcbYhMCtLq1_OtD7Pw@mail.gmail.com>
Subject: Re: [PATCH bpf] libbpf: detect supported kernel BTF features and
 sanitize BTF
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andriin@fb.com>,
        Networking <netdev@vger.kernel.org>, bpf@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@fb.com>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 10 May 2019 at 15:16, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> On Fri, May 10, 2019 at 2:46 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
> >
> > On Fri, 10 May 2019 at 05:37, Andrii Nakryiko <andriin@fb.com> wrote:
> > >
> > > Depending on used versions of libbpf, Clang, and kernel, it's possible to
> > > have valid BPF object files with valid BTF information, that still won't
> > > load successfully due to Clang emitting newer BTF features (e.g.,
> > > BTF_KIND_FUNC, .BTF.ext's line_info/func_info, BTF_KIND_DATASEC, etc), that
> > > are not yet supported by older kernel.
> >
> > For sys_bpf, we ignore a zero tail in struct bpf_attr, which gives us
> > backwards / forwards compatibility
> > as long as the user doesn't use the new fields.
> > Do we need a similar mechanism for BTF? Is it possible to discard
> > unknown types at load time?
>
> Unfortunately, unknown BTF types can be intermixed with older, known
> BTF types, so it's not as simple as trimming at the end of data. Also,
> to skip some type, you have to know which kind of type is it, as we
> don't explicitly encode the length of BTF type descriptor. So it's
> just impossible to do from kernel side.

That's a really good point. I stumbled on the same problem when writing a BTF
PoC in Go. Doesn't this mean that libbpf itself suffers from this
problem as well?
If I upgrade my clang, it might emit BTF that libbpf can't understand, and we're
back to square one.

Would it be possible to add such type_length to the format?

>
> >
> > >
> > > This patch adds detection of BTF features and sanitizes BPF object's BTF
> > > by substituting various supported BTF kinds, which have compatible layout:
> > >   - BTF_KIND_FUNC -> BTF_KIND_TYPEDEF
> > >   - BTF_KIND_FUNC_PROTO -> BTF_KIND_ENUM
> > >   - BTF_KIND_VAR -> BTF_KIND_INT
> > >   - BTF_KIND_DATASEC -> BTF_KIND_STRUCT
> > >
> > > Replacement is done in such a way as to preserve as much information as
> > > possible (names, sizes, etc) where possible without violating kernel's
> > > validation rules.
> > >
> > > Reported-by: Alexei Starovoitov <ast@fb.com>
> > > Signed-off-by: Andrii Nakryiko <andriin@fb.com>
> > > ---
> > >  tools/lib/bpf/libbpf.c | 185 ++++++++++++++++++++++++++++++++++++++++-
> > >  1 file changed, 184 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > index 11a65db4b93f..0813c4ad5d11 100644
> > > --- a/tools/lib/bpf/libbpf.c
> > > +++ b/tools/lib/bpf/libbpf.c
> > > @@ -128,6 +128,10 @@ struct bpf_capabilities {
> > >         __u32 name:1;
> > >         /* v5.2: kernel support for global data sections. */
> > >         __u32 global_data:1;
> > > +       /* BTF_KIND_FUNC and BTF_KIND_FUNC_PROTO support */
> > > +       __u32 btf_func:1;
> > > +       /* BTF_KIND_VAR and BTF_KIND_DATASEC support */
> > > +       __u32 btf_datasec:1;
> > >  };
> > >
> > >  /*
> > > @@ -1021,6 +1025,81 @@ static bool section_have_execinstr(struct bpf_object *obj, int idx)
> > >         return false;
> > >  }
> > >
> > > +static void bpf_object__sanitize_btf(struct bpf_object *obj)
> > > +{
> > > +#define BTF_INFO_ENC(kind, kind_flag, vlen) \
> > > +       ((!!(kind_flag) << 31) | ((kind) << 24) | ((vlen) & BTF_MAX_VLEN))
> > > +#define BTF_INT_ENC(encoding, bits_offset, nr_bits) \
> > > +       ((encoding) << 24 | (bits_offset) << 16 | (nr_bits))
> > > +
> > > +       bool has_datasec = obj->caps.btf_datasec;
> > > +       bool has_func = obj->caps.btf_func;
> > > +       struct btf *btf = obj->btf;
> > > +       struct btf_type *t;
> > > +       int i, j, vlen;
> > > +       __u16 kind;
> > > +
> > > +       if (!obj->btf || (has_func && has_datasec))
> > > +               return;
> > > +
> > > +       for (i = 1; i <= btf__get_nr_types(btf); i++) {
> > > +               t = (struct btf_type *)btf__type_by_id(btf, i);
> > > +               kind = BTF_INFO_KIND(t->info);
> > > +
> > > +               if (!has_datasec && kind == BTF_KIND_VAR) {
> > > +                       /* replace VAR with INT */
> > > +                       t->info = BTF_INFO_ENC(BTF_KIND_INT, 0, 0);
> > > +                       t->size = sizeof(int);
> > > +                       *(int *)(t+1) = BTF_INT_ENC(0, 0, 32);
> > > +               } else if (!has_datasec && kind == BTF_KIND_DATASEC) {
> > > +                       /* replace DATASEC with STRUCT */
> > > +                       struct btf_var_secinfo *v = (void *)(t + 1);
> > > +                       struct btf_member *m = (void *)(t + 1);
> > > +                       struct btf_type *vt;
> > > +                       char *name;
> > > +
> > > +                       name = (char *)btf__name_by_offset(btf, t->name_off);
> > > +                       while (*name) {
> > > +                               if (*name == '.')
> > > +                                       *name = '_';
> > > +                               name++;
> > > +                       }
> > > +
> > > +                       vlen = BTF_INFO_VLEN(t->info);
> > > +                       t->info = BTF_INFO_ENC(BTF_KIND_STRUCT, 0, vlen);
> > > +                       for (j = 0; j < vlen; j++, v++, m++) {
> > > +                               /* order of field assignments is important */
> > > +                               m->offset = v->offset * 8;
> > > +                               m->type = v->type;
> > > +                               /* preserve variable name as member name */
> > > +                               vt = (void *)btf__type_by_id(btf, v->type);
> > > +                               m->name_off = vt->name_off;
> > > +                       }
> > > +               } else if (!has_func && kind == BTF_KIND_FUNC_PROTO) {
> > > +                       /* replace FUNC_PROTO with ENUM */
> > > +                       vlen = BTF_INFO_VLEN(t->info);
> > > +                       t->info = BTF_INFO_ENC(BTF_KIND_ENUM, 0, vlen);
> > > +                       t->size = sizeof(__u32); /* kernel enforced */
> > > +               } else if (!has_func && kind == BTF_KIND_FUNC) {
> > > +                       /* replace FUNC with TYPEDEF */
> > > +                       t->info = BTF_INFO_ENC(BTF_KIND_TYPEDEF, 0, 0);
> > > +               }
> > > +       }
> > > +#undef BTF_INFO_ENC
> > > +#undef BTF_INT_ENC
> > > +}
> > > +
> > > +static void bpf_object__sanitize_btf_ext(struct bpf_object *obj)
> > > +{
> > > +       if (!obj->btf_ext)
> > > +               return;
> > > +
> > > +       if (!obj->caps.btf_func) {
> > > +               btf_ext__free(obj->btf_ext);
> > > +               obj->btf_ext = NULL;
> > > +       }
> > > +}
> > > +
> > >  static int bpf_object__elf_collect(struct bpf_object *obj, int flags)
> > >  {
> > >         Elf *elf = obj->efile.elf;
> > > @@ -1164,8 +1243,10 @@ static int bpf_object__elf_collect(struct bpf_object *obj, int flags)
> > >                         obj->btf = NULL;
> > >                 } else {
> > >                         err = btf__finalize_data(obj, obj->btf);
> > > -                       if (!err)
> > > +                       if (!err) {
> > > +                               bpf_object__sanitize_btf(obj);
> > >                                 err = btf__load(obj->btf);
> > > +                       }
> > >                         if (err) {
> > >                                 pr_warning("Error finalizing and loading %s into kernel: %d. Ignored and continue.\n",
> > >                                            BTF_ELF_SEC, err);
> > > @@ -1187,6 +1268,8 @@ static int bpf_object__elf_collect(struct bpf_object *obj, int flags)
> > >                                            BTF_EXT_ELF_SEC,
> > >                                            PTR_ERR(obj->btf_ext));
> > >                                 obj->btf_ext = NULL;
> > > +                       } else {
> > > +                               bpf_object__sanitize_btf_ext(obj);
> > >                         }
> > >                 }
> > >         }
> > > @@ -1556,12 +1639,112 @@ bpf_object__probe_global_data(struct bpf_object *obj)
> > >         return 0;
> > >  }
> > >
> > > +static int try_load_btf(const char *raw_types, size_t types_len,
> > > +                       const char *str_sec, size_t str_len)
> > > +{
> > > +       char buf[1024];
> > > +       struct btf_header hdr = {
> > > +               .magic = BTF_MAGIC,
> > > +               .version = BTF_VERSION,
> > > +               .hdr_len = sizeof(struct btf_header),
> > > +               .type_len = types_len,
> > > +               .str_off = types_len,
> > > +               .str_len = str_len,
> > > +       };
> > > +       int btf_fd, btf_len;
> > > +       __u8 *raw_btf;
> > > +
> > > +       btf_len = hdr.hdr_len + hdr.type_len + hdr.str_len;
> > > +       raw_btf = malloc(btf_len);
> > > +       if (!raw_btf)
> > > +               return -ENOMEM;
> > > +
> > > +       memcpy(raw_btf, &hdr, sizeof(hdr));
> > > +       memcpy(raw_btf + hdr.hdr_len, raw_types, hdr.type_len);
> > > +       memcpy(raw_btf + hdr.hdr_len + hdr.type_len, str_sec, hdr.str_len);
> > > +
> > > +       btf_fd = bpf_load_btf(raw_btf, btf_len, buf, 1024, 0);
> > > +       if (btf_fd < 0) {
> > > +               free(raw_btf);
> > > +               return 0;
> > > +       }
> > > +
> > > +       close(btf_fd);
> > > +       free(raw_btf);
> > > +       return 1;
> > > +}
> > > +
> > > +#define BTF_INFO_ENC(kind, kind_flag, vlen) \
> > > +       ((!!(kind_flag) << 31) | ((kind) << 24) | ((vlen) & BTF_MAX_VLEN))
> > > +#define BTF_TYPE_ENC(name, info, size_or_type) (name), (info), (size_or_type)
> > > +#define BTF_INT_ENC(encoding, bits_offset, nr_bits) \
> > > +       ((encoding) << 24 | (bits_offset) << 16 | (nr_bits))
> > > +#define BTF_TYPE_INT_ENC(name, encoding, bits_offset, bits, sz) \
> > > +       BTF_TYPE_ENC(name, BTF_INFO_ENC(BTF_KIND_INT, 0, 0), sz), \
> > > +       BTF_INT_ENC(encoding, bits_offset, bits)
> > > +#define BTF_PARAM_ENC(name, type) (name), (type)
> > > +#define BTF_VAR_SECINFO_ENC(type, offset, size) (type), (offset), (size)
> > > +static int bpf_object__probe_btf_func(struct bpf_object *obj)
> > > +{
> > > +       const char strs[] = "\0int\0x\0a";
> > > +       /* void x(int a) {} */
> > > +       __u32 types[] = {
> > > +               /* int */
> > > +               BTF_TYPE_INT_ENC(1, BTF_INT_SIGNED, 0, 32, 4),  /* [1] */
> > > +               /* FUNC_PROTO */                                /* [2] */
> > > +               BTF_TYPE_ENC(0, BTF_INFO_ENC(BTF_KIND_FUNC_PROTO, 0, 1), 0),
> > > +               BTF_PARAM_ENC(7, 1),
> > > +               /* FUNC x */                                    /* [3] */
> > > +               BTF_TYPE_ENC(5, BTF_INFO_ENC(BTF_KIND_FUNC, 0, 0), 2),
> > > +       };
> > > +       int res;
> > > +
> > > +       res = try_load_btf((char *)types, sizeof(types), strs, sizeof(strs));
> > > +       if (res < 0)
> > > +               return res;
> > > +       if (res > 0)
> > > +               obj->caps.btf_func = 1;
> > > +       return 0;
> > > +}
> > > +
> > > +static int bpf_object__probe_btf_datasec(struct bpf_object *obj)
> > > +{
> > > +       const char strs[] = "\0x\0.data";
> > > +       /* static int a; */
> > > +       __u32 types[] = {
> > > +               /* int */
> > > +               BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),  /* [1] */
> > > +               /* VAR x */                                     /* [2] */
> > > +               BTF_TYPE_ENC(1, BTF_INFO_ENC(BTF_KIND_VAR, 0, 0), 1),
> > > +               BTF_VAR_STATIC,
> > > +               /* DATASEC val */                               /* [3] */
> > > +               BTF_TYPE_ENC(3, BTF_INFO_ENC(BTF_KIND_DATASEC, 0, 1), 4),
> > > +               BTF_VAR_SECINFO_ENC(2, 0, 4),
> > > +       };
> > > +       int res;
> > > +
> > > +       res = try_load_btf((char *)&types, sizeof(types), strs, sizeof(strs));
> > > +       if (res < 0)
> > > +               return res;
> > > +       if (res > 0)
> > > +               obj->caps.btf_datasec = 1;
> > > +       return 0;
> > > +}
> > > +#undef BTF_INFO_ENC
> > > +#undef BTF_TYPE_ENC
> > > +#undef BTF_INT_ENC
> > > +#undef BTF_TYPE_INT_ENC
> > > +#undef BTF_PARAM_ENC
> > > +#undef BTF_VAR_SECINFO_ENC
> > > +
> > >  static int
> > >  bpf_object__probe_caps(struct bpf_object *obj)
> > >  {
> > >         int (*probe_fn[])(struct bpf_object *obj) = {
> > >                 bpf_object__probe_name,
> > >                 bpf_object__probe_global_data,
> > > +               bpf_object__probe_btf_func,
> > > +               bpf_object__probe_btf_datasec,
> > >         };
> > >         int i, ret;
> > >
> > > --
> > > 2.17.1
> > >
> >
> >
> > --
> > Lorenz Bauer  |  Systems Engineer
> > 25 Lavington St., London SE1 0NZ
> >
> > www.cloudflare.com



-- 
Lorenz Bauer  |  Systems Engineer
25 Lavington St., London SE1 0NZ

www.cloudflare.com
