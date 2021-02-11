Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21671318293
	for <lists+bpf@lfdr.de>; Thu, 11 Feb 2021 01:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhBKAVq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Feb 2021 19:21:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbhBKAVm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Feb 2021 19:21:42 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7BFC06174A
        for <bpf@vger.kernel.org>; Wed, 10 Feb 2021 16:21:02 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id 133so3894175ybd.5
        for <bpf@vger.kernel.org>; Wed, 10 Feb 2021 16:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7FMaQXnAcbdRl+NgRc65AwIkhZ8E9AtoMZ2ntLEsieg=;
        b=o1kH64vRFS9VOfc109FicWENsPMzZZJAXOiF6DpZJxIv4fFM913nYEReoV/b55nMdh
         UTws7/gG/+DP9dvtxp02d4hibw73f+ZSI60TAs5mmw/WOdrklv4L4cFnCAtSh4+eEKrc
         ycV7AFNi+oS87VxHmJIRpCFj/ELYAGLhMIl3e6LrYT/f01eVklEQyIsBZZ9dXTL0qOel
         MU0bfuqrT+8yLZwD0nV+6x5oPSy5XvezGZq/70oSBucAkKBymySHjB2cXXbMEkZPCHIR
         kHqe2oA49UluC0PlTYGtQvfX82RX6bewJDt41Ji5Ao8fyw3cBTdIVuA89yPwqnVJYIMl
         NRHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7FMaQXnAcbdRl+NgRc65AwIkhZ8E9AtoMZ2ntLEsieg=;
        b=AwJ2gwUAulUauxcwfxWz1Fh9rL5qwf2Rufvml+Nx7XF0dLfmf3zJmBEUIfOoPFlk6v
         TrQSee7vxP/UZOE4m2APdDyVCxc1sBetr1wI3Jkw4JFeO9nPqTI47YrBQcaS0tHzALoS
         hX9Uc1NUuDWZ6PTmuaCeEGdYJ+QDWV23QkgUZWy9VM2eBFpMdEaqIRJObT4741XPqdGr
         ofm/iyMxYSVSFuRLmBgfHvgKGaezr4OCyH+iA64mubuNwbM5QwcFV3xJWut6PP33s6Lm
         eu4hlc3/9SmbHLln42I4Fbri10C14PEQPJhxc9lPSfgWGA2XgMUdeIQmMCBX/WB8mQnm
         Ryng==
X-Gm-Message-State: AOAM531FhKGRIToOUwJ1JSE0bHwlDOEwzwdWY6SwmEF57mOreRV0HSNr
        uVrVMqhzP+pl2PKBjHaF6HM5ZJAtzQxXUsAbD1o=
X-Google-Smtp-Source: ABdhPJxlrVZByhaX13CKKamVjhGqbMwU5V+z3DX6mVcmB7enjgjzHlBbcSm4zp+HbCSAV/znEXaCj6wa+LjDzwuu/lM=
X-Received: by 2002:a25:a183:: with SMTP id a3mr7950513ybi.459.1613002861727;
 Wed, 10 Feb 2021 16:21:01 -0800 (PST)
MIME-Version: 1.0
References: <20210210030317.78820-1-iii@linux.ibm.com> <20210210030317.78820-5-iii@linux.ibm.com>
In-Reply-To: <20210210030317.78820-5-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 10 Feb 2021 16:20:50 -0800
Message-ID: <CAEf4BzbdKruSBeyPx5cmmVjRtCjUc9kMjPC2X+gTfWvbwBLj-A@mail.gmail.com>
Subject: Re: [PATCH RFC 4/6] bpf: Add BTF_KIND_FLOAT support
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        bpf <bpf@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 9, 2021 at 7:04 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> On the kernel side, introduce a new btf_kind_operations. It is
> similar to that of BTF_KIND_INT, however, it does not need to
> handle encodings and bit offsets. Do not implement printing, since
> the kernel does not know how to format floating-point values.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  kernel/bpf/btf.c | 101 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 99 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 756a93f534b6..6f27b7b59d77 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -173,8 +173,9 @@
>  #define BITS_ROUNDUP_BYTES(bits) \
>         (BITS_ROUNDDOWN_BYTES(bits) + !!BITS_PER_BYTE_MASKED(bits))
>
> -#define BTF_INFO_MASK 0x8f00ffff
> +#define BTF_INFO_MASK 0x9f00ffff
>  #define BTF_INT_MASK 0x0fffffff
> +#define BTF_FLOAT_MASK 0x000000ff
>  #define BTF_TYPE_ID_VALID(type_id) ((type_id) <= BTF_MAX_TYPE)
>  #define BTF_STR_OFFSET_VALID(name_off) ((name_off) <= BTF_MAX_NAME_OFFSET)
>
> @@ -280,6 +281,7 @@ static const char * const btf_kind_str[NR_BTF_KINDS] = {
>         [BTF_KIND_FUNC_PROTO]   = "FUNC_PROTO",
>         [BTF_KIND_VAR]          = "VAR",
>         [BTF_KIND_DATASEC]      = "DATASEC",
> +       [BTF_KIND_FLOAT]        = "FLOAT",
>  };
>
>  static const char *btf_type_str(const struct btf_type *t)
> @@ -574,6 +576,7 @@ static bool btf_type_has_size(const struct btf_type *t)
>         case BTF_KIND_UNION:
>         case BTF_KIND_ENUM:
>         case BTF_KIND_DATASEC:
> +       case BTF_KIND_FLOAT:
>                 return true;
>         }
>
> @@ -614,6 +617,11 @@ static const struct btf_var *btf_type_var(const struct btf_type *t)
>         return (const struct btf_var *)(t + 1);
>  }
>
> +static u32 btf_type_float(const struct btf_type *t)
> +{
> +       return *(u32 *)(t + 1);
> +}
> +
>  static const struct btf_kind_operations *btf_type_ops(const struct btf_type *t)
>  {
>         return kind_ops[BTF_INFO_KIND(t->info)];
> @@ -1704,6 +1712,7 @@ __btf_resolve_size(const struct btf *btf, const struct btf_type *type,
>                 case BTF_KIND_STRUCT:
>                 case BTF_KIND_UNION:
>                 case BTF_KIND_ENUM:
> +               case BTF_KIND_FLOAT:
>                         size = type->size;
>                         goto resolved;
>
> @@ -1849,7 +1858,7 @@ static int btf_df_check_kflag_member(struct btf_verifier_env *env,
>         return -EINVAL;
>  }
>
> -/* Used for ptr, array and struct/union type members.
> +/* Used for ptr, array struct/union and float type members.
>   * int, enum and modifier types have their specific callback functions.
>   */
>  static int btf_generic_check_kflag_member(struct btf_verifier_env *env,
> @@ -3675,6 +3684,93 @@ static const struct btf_kind_operations datasec_ops = {
>         .show                   = btf_datasec_show,
>  };
>
> +static s32 btf_float_check_meta(struct btf_verifier_env *env,
> +                               const struct btf_type *t,
> +                               u32 meta_left)
> +{
> +       u32 float_data, nr_bits, meta_needed = sizeof(float_data);
> +
> +       if (meta_left < meta_needed) {
> +               btf_verifier_log_basic(env, t,
> +                                      "meta_left:%u meta_needed:%u",
> +                                      meta_left, meta_needed);
> +               return -EINVAL;
> +       }
> +
> +       if (btf_type_vlen(t)) {
> +               btf_verifier_log_type(env, t, "vlen != 0");
> +               return -EINVAL;
> +       }
> +
> +       if (btf_type_kflag(t)) {
> +               btf_verifier_log_type(env, t, "Invalid btf_info kind_flag");
> +               return -EINVAL;
> +       }
> +
> +       float_data = btf_type_float(t);
> +       if (float_data & ~BTF_FLOAT_MASK) {
> +               btf_verifier_log_basic(env, t, "Invalid float_data:%x",
> +                                      float_data);
> +               return -EINVAL;
> +       }
> +
> +       nr_bits = BTF_FLOAT_BITS(float_data);
> +
> +       if (BITS_ROUNDUP_BYTES(nr_bits) > t->size) {

what's the case where nr_bits != t->size * 8 ? Is that even possible in C?

> +               btf_verifier_log_type(env, t, "nr_bits exceeds type_size");
> +               return -EINVAL;
> +       }
> +
> +       btf_verifier_log_type(env, t, NULL);
> +
> +       return meta_needed;
> +}
> +
> +static int btf_float_check_member(struct btf_verifier_env *env,
> +                                 const struct btf_type *struct_type,
> +                                 const struct btf_member *member,
> +                                 const struct btf_type *member_type)
> +{
> +       u64 end_offset_bytes;
> +       u64 end_offset_bits;
> +       u64 offset_bits;
> +       u32 float_data;
> +       u64 size_bits;
> +
> +       float_data = btf_type_float(member_type);
> +       size_bits = BTF_FLOAT_BITS(float_data);
> +       offset_bits = member->offset;
> +       end_offset_bits = offset_bits + size_bits;
> +       end_offset_bytes = BITS_ROUNDUP_BYTES(end_offset_bits);
> +
> +       if (end_offset_bytes > struct_type->size) {
> +               btf_verifier_log_member(env, struct_type, member,
> +                                       "Member exceeds struct_size");
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
> +static void btf_float_log(struct btf_verifier_env *env,
> +                         const struct btf_type *t)
> +{
> +       int float_data = btf_type_float(t);
> +
> +       btf_verifier_log(env,
> +                        "size=%u nr_bits=%u",
> +                        t->size, BTF_FLOAT_BITS(float_data));
> +}
> +
> +static const struct btf_kind_operations float_ops = {
> +       .check_meta = btf_float_check_meta,
> +       .resolve = btf_df_resolve,
> +       .check_member = btf_float_check_member,
> +       .check_kflag_member = btf_generic_check_kflag_member,
> +       .log_details = btf_float_log,
> +       .show = btf_df_show,
> +};
> +
>  static int btf_func_proto_check(struct btf_verifier_env *env,
>                                 const struct btf_type *t)
>  {
> @@ -3808,6 +3904,7 @@ static const struct btf_kind_operations * const kind_ops[NR_BTF_KINDS] = {
>         [BTF_KIND_FUNC_PROTO] = &func_proto_ops,
>         [BTF_KIND_VAR] = &var_ops,
>         [BTF_KIND_DATASEC] = &datasec_ops,
> +       [BTF_KIND_FLOAT] = &float_ops,
>  };
>
>  static s32 btf_check_meta(struct btf_verifier_env *env,
> --
> 2.29.2
>
