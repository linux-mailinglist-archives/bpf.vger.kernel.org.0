Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D235C33484D
	for <lists+bpf@lfdr.de>; Wed, 10 Mar 2021 20:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbhCJTsz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Mar 2021 14:48:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233882AbhCJTsv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Mar 2021 14:48:51 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DABC061760;
        Wed, 10 Mar 2021 11:48:51 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id b10so19157053ybn.3;
        Wed, 10 Mar 2021 11:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4gnceIpyZ7C//7/RT8AQyDR62pZZ+Z1rM7deN3fsjAM=;
        b=lJl8xdtucqsJXw9ywzGhMFcST4puDlPUMLvcmO0akACmhj2C/a5FlH94LefsRmnpFH
         rXYNkCURWU8qqYteLWwYikLyOepv3uF9pS/Cl7W/o6OE3fL1bUxuAOiDpoxYdGFW/fhT
         IkmqUQ79OPaR6aNs2l1pCaNynLdk+IeOHXTYzZTaFgUYHY5T2cmj7ZtBYP+y8W60ZDbG
         e1EhALg3uFB38QMHYGZvyR14SKW81bZ9D/SYyIdozmboByFMYFX4b4AKZO37QnveMX4j
         LGeo1FyFw1+t8txpZw/BGSfe3zMwUeeWs/9iSK5CQ27Zv15yz6j3hlllZdrAPpz8BVK6
         GJfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4gnceIpyZ7C//7/RT8AQyDR62pZZ+Z1rM7deN3fsjAM=;
        b=uMmtTDYOpvaJPmLBCDPiqOrmmn7z+Veuif9wGJB+8rVW1/GIVrvGCUXamnzdMJ1YUX
         ENmIP8MNhfdQSgLJiHZf379sgfjTQaICrfGk/xPa9ShXsNWEG9t7CwTRkQaIwC39CWOv
         oYDDvaItSICg1xBH/rnxzWHaAvsrIA+yk6KsDaswFZSuyrMh0ixb9fQI7Euo+12i+QbU
         rIj2tiYiyAgKXS9niU1GCjwOAhvFo7HJW2z3D3of+WML+JeAQOaLTBzuuV7sqnva+81K
         A3GcwCuTthqHgjyUJ0Dyw6rXb0eZw3QLbFyizUDxbjyVs9veowIGe1nXfpZlox4qGSjK
         2sOw==
X-Gm-Message-State: AOAM530J6I+8jIsBbOpnMiCaRKM9Ip/hhOnsKQgiSzQx1LI4SJNLCF7k
        j2V4aoaF9PdLJMTRvaBygwJBp0y9GD9j38nZWys=
X-Google-Smtp-Source: ABdhPJw8HBT2NbnwIlmmcWO8h6Q8HOJ9PsKGpK0qEcVf//7ppcBa6XhYZPdsj37tBlvfMKaG4mwcWC9jSNz0VRTMRjA=
X-Received: by 2002:a25:7d07:: with SMTP id y7mr6288740ybc.425.1615405730489;
 Wed, 10 Mar 2021 11:48:50 -0800 (PST)
MIME-Version: 1.0
References: <20210310141517.169698-1-iii@linux.ibm.com>
In-Reply-To: <20210310141517.169698-1-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 10 Mar 2021 11:48:39 -0800
Message-ID: <CAEf4BzbsXAJ5M9fFSVJvGagHP+UDVBMw+QZYsjWr3JtNs_=7tw@mail.gmail.com>
Subject: Re: [PATCH v3 dwarves] btf: Add support for the floating-point types
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andrii Nakryiko <andrii@kernel.org>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 10, 2021 at 6:15 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> Some BPF programs compiled on s390 fail to load, because s390
> arch-specific linux headers contain float and double types.
>
> Fix as follows:
>
> - Make the DWARF loader fill base_type.float_type.
>
> - Introduce the --encode_btf_kind_float command-line parameter, so that
>   pahole could be used to build both the older and the newer kernels.
>
> - libbpf introduced the support for the floating-point types in commit
>   986962fade5, so update the libbpf submodule to that version and use
>   the new btf__add_float() function in order to emit the floating-point
>   types when not in the compatibility mode.
>
> - Make the BTF loader recognize the new BTF kind.
>
> Example of the resulting entry in the vmlinux BTF:
>
>     [7164] FLOAT 'double' size=8
>
> when building with:
>
>     LLVM_OBJCOPY=${OBJCOPY} ${PAHOLE} -J ${1} --encode_btf_kind_float
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>
> v1: https://lore.kernel.org/dwarves/20210306022203.152930-1-iii@linux.ibm.com/
> v1 -> v2: Introduce libbpf compatibility level command-line parameter.
>           The code should now work for both bpf-next/master and
>           v5.12-rc2.
>
> v2: https://lore.kernel.org/dwarves/20210308235913.162038-1-iii@linux.ibm.com/
> v2 -> v3: Use the feature flag (--encode_btf_kind_float) instead of the
>           libbpf version flag.
>
>  btf_loader.c       | 21 +++++++++++++++++++--
>  dwarf_loader.c     | 11 +++++++++++
>  lib/bpf            |  2 +-
>  libbtf.c           | 36 ++++++++++++++++++++++++++++++++++--
>  libbtf.h           |  1 +
>  man-pages/pahole.1 |  5 +++++
>  pahole.c           |  8 ++++++++
>  7 files changed, 79 insertions(+), 5 deletions(-)
>
> diff --git a/btf_loader.c b/btf_loader.c
> index ec286f4..7cc39aa 100644
> --- a/btf_loader.c
> +++ b/btf_loader.c
> @@ -160,7 +160,7 @@ static struct variable *variable__new(strings_t name, uint32_t linkage)
>         return var;
>  }
>
> -static int create_new_base_type(struct btf_elf *btfe, const struct btf_type *tp, uint32_t id)
> +static int create_new_int_type(struct btf_elf *btfe, const struct btf_type *tp, uint32_t id)
>  {
>         uint32_t attrs = btf_int_encoding(tp);
>         strings_t name = tp->name_off;
> @@ -175,6 +175,20 @@ static int create_new_base_type(struct btf_elf *btfe, const struct btf_type *tp,
>         return 0;
>  }
>
> +static int create_new_float_type(struct btf_elf *btfe, const struct btf_type *tp, uint32_t id)
> +{
> +       strings_t name = tp->name_off;
> +       struct base_type *base = base_type__new(name, 0, BT_FP_SINGLE, tp->size * 8);
> +
> +       if (base == NULL)
> +               return -ENOMEM;
> +
> +       base->tag.tag = DW_TAG_base_type;
> +       cu__add_tag_with_id(btfe->priv, &base->tag, id);
> +
> +       return 0;
> +}
> +
>  static int create_new_array(struct btf_elf *btfe, const struct btf_type *tp, uint32_t id)
>  {
>         struct btf_array *ap = btf_array(tp);
> @@ -397,7 +411,7 @@ static int btf_elf__load_types(struct btf_elf *btfe)
>
>                 switch (type) {
>                 case BTF_KIND_INT:
> -                       err = create_new_base_type(btfe, type_ptr, type_index);
> +                       err = create_new_int_type(btfe, type_ptr, type_index);
>                         break;
>                 case BTF_KIND_ARRAY:
>                         err = create_new_array(btfe, type_ptr, type_index);
> @@ -442,6 +456,9 @@ static int btf_elf__load_types(struct btf_elf *btfe)
>                         // BTF_KIND_FUNC corresponding to a defined subprogram.
>                         err = create_new_function(btfe, type_ptr, type_index);
>                         break;
> +               case BTF_KIND_FLOAT:
> +                       err = create_new_float_type(btfe, type_ptr, type_index);
> +                       break;
>                 default:
>                         fprintf(stderr, "BTF: idx: %d, Unknown kind %d\n", type_index, type);
>                         fflush(stderr);
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index b73d786..c5e6681 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -461,6 +461,16 @@ static struct ptr_to_member_type *ptr_to_member_type__new(Dwarf_Die *die,
>         return ptr;
>  }
>
> +static uint8_t encoding_to_float_type(uint64_t encoding)
> +{
> +       switch (encoding) {
> +       case DW_ATE_complex_float:      return BT_FP_CMPLX;
> +       case DW_ATE_float:              return BT_FP_SINGLE;
> +       case DW_ATE_imaginary_float:    return BT_FP_IMGRY;
> +       default:                        return 0;
> +       }
> +}
> +
>  static struct base_type *base_type__new(Dwarf_Die *die, struct cu *cu)
>  {
>         struct base_type *bt = tag__alloc(cu, sizeof(*bt));
> @@ -474,6 +484,7 @@ static struct base_type *base_type__new(Dwarf_Die *die, struct cu *cu)
>                 bt->is_signed = encoding == DW_ATE_signed;
>                 bt->is_varargs = false;
>                 bt->name_has_encoding = true;
> +               bt->float_type = encoding_to_float_type(encoding);
>         }
>
>         return bt;
> diff --git a/lib/bpf b/lib/bpf
> index 5af3d86..986962f 160000
> --- a/lib/bpf
> +++ b/lib/bpf
> @@ -1 +1 @@
> -Subproject commit 5af3d86b5a2c5fecdc3ab83822d083edd32b4396
> +Subproject commit 986962fade5dfa89c2890f3854eb040d2a64ab38
> diff --git a/libbtf.c b/libbtf.c
> index 9f76283..b4391ae 100644
> --- a/libbtf.c
> +++ b/libbtf.c
> @@ -30,6 +30,7 @@
>  struct btf *base_btf;
>  uint8_t btf_elf__verbose;
>  uint8_t btf_elf__force;
> +bool encode_btf_kind_float = false;
>
>  static int btf_var_secinfo_cmp(const void *a, const void *b)
>  {
> @@ -227,6 +228,7 @@ static const char * const btf_kind_str[NR_BTF_KINDS] = {
>         [BTF_KIND_FUNC_PROTO]   = "FUNC_PROTO",
>         [BTF_KIND_VAR]          = "VAR",
>         [BTF_KIND_DATASEC]      = "DATASEC",
> +       [BTF_KIND_FLOAT]        = "FLOAT",
>  };
>
>  static const char *btf_elf__printable_name(const struct btf_elf *btfe, uint32_t offset)
> @@ -367,6 +369,27 @@ static void btf_log_func_param(const struct btf_elf *btfe,
>         }
>  }
>
> +static int32_t btf_elf__add_float_type(struct btf_elf *btfe,
> +                                      const struct base_type *bt,
> +                                      const char *name)
> +{
> +       int32_t id;
> +
> +       id = btf__add_float(btfe->btf, name, BITS_ROUNDUP_BYTES(bt->bit_size));
> +       if (id < 0) {
> +               btf_elf__log_err(btfe, BTF_KIND_FLOAT, name, true, "Error emitting BTF type");
> +       } else {
> +               const struct btf_type *t;
> +
> +               t = btf__type_by_id(btfe->btf, id);
> +               btf_elf__log_type(btfe, t, false, true,
> +                                 "size=%u nr_bits=%u",
> +                                 t->size, bt->bit_size);
> +       }
> +
> +       return id;
> +}
> +
>  int32_t btf_elf__add_base_type(struct btf_elf *btfe, const struct base_type *bt,
>                                const char *name)
>  {
> @@ -379,8 +402,17 @@ int32_t btf_elf__add_base_type(struct btf_elf *btfe, const struct base_type *bt,
>                 encoding = BTF_INT_SIGNED;
>         } else if (bt->is_bool) {
>                 encoding = BTF_INT_BOOL;
> -       } else if (bt->float_type) {
> -               fprintf(stderr, "float_type is not supported\n");
> +       } else if (bt->float_type && encode_btf_kind_float) {
> +               /*
> +                * Encode floats as BTF_KIND_FLOAT if allowed, otherwise (in
> +                * compatibility mode) encode them as BTF_KIND_INT - that's not
> +                * fully correct, but that's what it used to be.
> +                */
> +               if (bt->float_type == BT_FP_SINGLE ||
> +                   bt->float_type == BT_FP_DOUBLE ||
> +                   bt->float_type == BT_FP_LDBL)
> +                       return btf_elf__add_float_type(btfe, bt, name);
> +               fprintf(stderr, "Complex, interval and imaginary float types are not supported\n");
>                 return -1;
>         }
>
> diff --git a/libbtf.h b/libbtf.h
> index 191f586..efded27 100644
> --- a/libbtf.h
> +++ b/libbtf.h
> @@ -35,6 +35,7 @@ extern struct btf *base_btf;
>  extern uint8_t btf_elf__verbose;
>  extern uint8_t btf_elf__force;
>  #define btf_elf__verbose_log(fmt, ...) { if (btf_elf__verbose) printf(fmt, __VA_ARGS__); }
> +extern bool encode_btf_kind_float;
>
>  #define PERCPU_SECTION ".data..percpu"
>
> diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
> index 352bb5e..5677153 100644
> --- a/man-pages/pahole.1
> +++ b/man-pages/pahole.1
> @@ -199,6 +199,11 @@ Path to the base BTF file, for instance: vmlinux when encoding kernel module BTF
>  This may be inferred when asking for a /sys/kernel/btf/MODULE, when it will be autoconfigured
>  to "/sys/kernel/btf/vmlinux".
>
> +.TP
> +.B \-\-encode_btf_kind_float
> +Allow producing BTF_KIND_FLOAT entries in systems where the vmlinux DWARF
> +information has float types.
> +
>  .TP
>  .B \-l, \-\-show_first_biggest_size_base_type_member
>  Show first biggest size base_type member.
> diff --git a/pahole.c b/pahole.c
> index 4a34ba5..e4b0163 100644
> --- a/pahole.c
> +++ b/pahole.c
> @@ -825,6 +825,7 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
>  #define ARGP_just_packed_structs   319
>  #define ARGP_numeric_version       320
>  #define ARGP_btf_base             321
> +#define ARGP_encode_btf_kind_float 322
>
>  static const struct argp_option pahole__options[] = {
>         {
> @@ -1119,6 +1120,11 @@ static const struct argp_option pahole__options[] = {
>                 .key  = ARGP_btf_encode_force,
>                 .doc  = "Ignore those symbols found invalid when encoding BTF."
>         },
> +       {
> +               .name = "encode_btf_kind_float",
> +               .key  = ARGP_encode_btf_kind_float,
> +               .doc  = "Allow producing BTF_KIND_FLOAT entries."


all the pahole's BTF-related (at least few I checked quickly) seem to
start with --btf-<whatever>, so I see no reason to deviate. Let's keep
it grouped under --btf prefix: --btf-gen-floats? Subsequent feature
subsets will go under --btf-gen-something-else?

> +       },
>         {
>                 .name = "structs",
>                 .key  = ARGP_just_structs,
> @@ -1254,6 +1260,8 @@ static error_t pahole__options_parser(int key, char *arg,
>                 base_btf_file = arg;                    break;
>         case ARGP_numeric_version:
>                 print_numeric_version = true;           break;
> +       case ARGP_encode_btf_kind_float:
> +               encode_btf_kind_float = true;           break;
>         default:
>                 return ARGP_ERR_UNKNOWN;
>         }
> --
> 2.29.2
>
