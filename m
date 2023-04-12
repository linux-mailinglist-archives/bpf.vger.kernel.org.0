Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A816E0132
	for <lists+bpf@lfdr.de>; Wed, 12 Apr 2023 23:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjDLVuu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 17:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDLVut (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 17:50:49 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFE949C2
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 14:50:47 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-504a37baf98so2692373a12.1
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 14:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681336246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=un9Tl24FG3lfMXPTE2ViwC3udrxUq3w3TDaXaRkIBg4=;
        b=Iq2/2FlMQgaxQL3IpAEh8zuJ55pd0nzYLVNyCZjPgqPaxoOH2Rd7ipMRyuvIvjvhXP
         kjK3wUkfUN8qtpMra4prf2egp02H4YCfXLNOVBuNAqyMdcHuAXm9vizvMXqJ4zVPIFm+
         53Oozaj7fcTZ4hsT1vnvj/Ry0FKeslja7upHmzoX8W94L16C5CSx14KToO1J86+qhz7p
         LiwCbZm1j47BDXT3nd/Kxp/9STMBL5hjv8eztnGDHMWwD5mbUqYFafzAh+TOe9BgyVkH
         dk3hphDi97BTVcs/18e/4DQzYDipXx6h0XBhXVDAC5J/RnwHJ71D0HdLlDQ3DG9biVZS
         HfBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681336246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=un9Tl24FG3lfMXPTE2ViwC3udrxUq3w3TDaXaRkIBg4=;
        b=Zf7dtC90URxB+VUwiMxWRRVqUaPBat1xalk16lFzuPP3K+/IgDYyIBE2tGn+GedexB
         i7i+7n9dGYPX90xwZGrthbw7QLNE+DSx7YsfZBU7tAw04kevFebqtNkwOAdkeNmuxkvN
         Du4YW/w473pk0k6bDPDfE066ws+LOz45qbL+rQDPzP9wG4n6d0mmTHio0xdU2IunksHE
         0CpUrE7yR84yG/bP6flFCOIqiePyuOrHa/AheQJZjMgKBS4BmKekH4Np/jlPU/LhC8Sg
         MjPPSLqd29AQY7dH5CPTJq5Fe0UPlHrpn3UyVOLhrv0ydhzvwQYBpZT/dOgiLIyiC6zV
         xdMg==
X-Gm-Message-State: AAQBX9ewDytmVqDY7O8S7Ps7+jeFvXHUobDbOEDTU5w3GW/4XgejPSMW
        biXMF/L6ULRXKFgIRs3EIbDWZhujrd4+5M+rKsPbSjbCOp4=
X-Google-Smtp-Source: AKy350aKQwVNROybEXjriwNTuEK8WyEbxWELeQRMDCQCHGHUDXG/UTXVN076HpN3+t2JAJeVNECUmR4g5QphcTJocSk=
X-Received: by 2002:a50:aa9c:0:b0:4fc:f0b8:7da0 with SMTP id
 q28-20020a50aa9c000000b004fcf0b87da0mr103591edc.1.1681336246237; Wed, 12 Apr
 2023 14:50:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230409033431.3992432-1-joannelkoong@gmail.com> <20230409033431.3992432-3-joannelkoong@gmail.com>
In-Reply-To: <20230409033431.3992432-3-joannelkoong@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 12 Apr 2023 14:50:34 -0700
Message-ID: <CAEf4BzahPnJ08-eqh2S_jZ+wca4-DCq5JjFKQOAfgb+oYRqdkg@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 2/5] bpf: Add bpf_dynptr_is_null and bpf_dynptr_is_rdonly
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
        daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Apr 8, 2023 at 8:34=E2=80=AFPM Joanne Koong <joannelkoong@gmail.com=
> wrote:
>
> bpf_dynptr_is_null returns true if the dynptr is null / invalid
> (determined by whether ptr->data is NULL), else false if
> the dynptr is a valid dynptr.
>
> bpf_dynptr_is_rdonly returns true if the dynptr is read-only,
> else false if the dynptr is read-writable.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  kernel/bpf/helpers.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 51b4c4b5dbed..e4e84e92a4c6 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1423,7 +1423,7 @@ static const struct bpf_func_proto bpf_kptr_xchg_pr=
oto =3D {
>  #define DYNPTR_SIZE_MASK       0xFFFFFF
>  #define DYNPTR_RDONLY_BIT      BIT(31)
>
> -static bool bpf_dynptr_is_rdonly(const struct bpf_dynptr_kern *ptr)
> +static bool __bpf_dynptr_is_rdonly(const struct bpf_dynptr_kern *ptr)
>  {
>         return ptr->size & DYNPTR_RDONLY_BIT;
>  }
> @@ -1570,7 +1570,7 @@ BPF_CALL_5(bpf_dynptr_write, const struct bpf_dynpt=
r_kern *, dst, u32, offset, v
>         enum bpf_dynptr_type type;
>         int err;
>
> -       if (!dst->data || bpf_dynptr_is_rdonly(dst))
> +       if (!dst->data || __bpf_dynptr_is_rdonly(dst))
>                 return -EINVAL;
>
>         err =3D bpf_dynptr_check_off_len(dst, offset, len);
> @@ -1626,7 +1626,7 @@ BPF_CALL_3(bpf_dynptr_data, const struct bpf_dynptr=
_kern *, ptr, u32, offset, u3
>         if (err)
>                 return 0;
>
> -       if (bpf_dynptr_is_rdonly(ptr))
> +       if (__bpf_dynptr_is_rdonly(ptr))
>                 return 0;
>
>         type =3D bpf_dynptr_get_type(ptr);
> @@ -2254,7 +2254,7 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct bpf=
_dynptr_kern *ptr, u32 offset
>  __bpf_kfunc void *bpf_dynptr_slice_rdwr(const struct bpf_dynptr_kern *pt=
r, u32 offset,
>                                         void *buffer, u32 buffer__szk)
>  {
> -       if (!ptr->data || bpf_dynptr_is_rdonly(ptr))
> +       if (!ptr->data || __bpf_dynptr_is_rdonly(ptr))

seems like all the uses of __bpf_dynptr_is_rdonly check !ptr->data
explicitly, so maybe move that ptr->data check inside and simplify all
the callers?

Regardless, looks good:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>                 return NULL;
>
>         /* bpf_dynptr_slice_rdwr is the same logic as bpf_dynptr_slice.
> @@ -2322,6 +2322,19 @@ __bpf_kfunc int bpf_dynptr_trim(struct bpf_dynptr_=
kern *ptr, u32 len)
>         return bpf_dynptr_adjust(ptr, 0, len);
>  }
>
> +__bpf_kfunc bool bpf_dynptr_is_null(struct bpf_dynptr_kern *ptr)
> +{
> +       return !ptr->data;
> +}
> +
> +__bpf_kfunc bool bpf_dynptr_is_rdonly(struct bpf_dynptr_kern *ptr)
> +{
> +       if (!ptr->data)
> +               return false;
> +
> +       return __bpf_dynptr_is_rdonly(ptr);
> +}
> +
>  __bpf_kfunc void *bpf_cast_to_kern_ctx(void *obj)
>  {
>         return obj;
> @@ -2396,6 +2409,8 @@ BTF_ID_FLAGS(func, bpf_iter_num_next, KF_ITER_NEXT =
| KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_ITER_DESTROY)
>  BTF_ID_FLAGS(func, bpf_dynptr_trim)
>  BTF_ID_FLAGS(func, bpf_dynptr_advance)
> +BTF_ID_FLAGS(func, bpf_dynptr_is_null)
> +BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
>  BTF_SET8_END(common_btf_ids)
>
>  static const struct btf_kfunc_id_set common_kfunc_set =3D {
> --
> 2.34.1
>
