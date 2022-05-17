Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32206529604
	for <lists+bpf@lfdr.de>; Tue, 17 May 2022 02:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233498AbiEQA3A (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 May 2022 20:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbiEQA26 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 May 2022 20:28:58 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39C734B91
        for <bpf@vger.kernel.org>; Mon, 16 May 2022 17:28:57 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id e3so17759178ios.6
        for <bpf@vger.kernel.org>; Mon, 16 May 2022 17:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zUZjsIdZIpprm3W33ZtGDmPerjP3wsIJmoZ3IdLVo3s=;
        b=SIQjJrm+Zc8viSFnjOFjP0EUrzu3ZMm2yD2WQnGh6F4M1y+6uUrOPJkyEfElHk0LVj
         T4woLmDG/0Hdp1fQbkqp7zg37b2H6nBTlPKDEdyXkE/4SitpqtB17z/wSDDzTIRxnF3Z
         4qNf/076MfmLw2IXObOIk9EvKv0T5FIDT/0mI7GZlHhFiyr9yFEe+KuDhdBdyG7e//2p
         /D9W6VMpcpnO56kJM08HWebD3l2OojznXOqXn0o4bhXyDdycFzabQEXlreBHFMFoCkPs
         qC0zKEH5l1VcvfZ8kHON5l0sIUrt6zj0qw+AB0VySWyShdLqyD3gnOQZmWJfKj1E/85C
         6AQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zUZjsIdZIpprm3W33ZtGDmPerjP3wsIJmoZ3IdLVo3s=;
        b=LxenwzIi4SnafT/s475CprCGF5Uajp2VjPeQ/IUzsWvVeC3yW2Rspg3Ge8B3on4HM2
         V9Yh8YIOXNSlNYFU765OUrmEvXSJUGaq3sfMME6j+TMTXwU3t++TL2f8BG729jiixOO5
         S8c34hp0MymXG0EpYC8dIgTnYjsS2fyrY14swQ+CYPppCpKVkh3ceQDXrDYn4KQuVU0Z
         +xWdhM/kZYsJ7flkq+BFCpQKzmf72CLKMr+9iM1jBtM3ydlcEvjZ+poUDvHk+VhQNB+h
         nAN367V3cLX65lesTSm5WyTcqfpJFequiTbL0PKiFBbHMaj8lMBnVvc/8cF3y1pL48bJ
         Efow==
X-Gm-Message-State: AOAM530zhmPvjWaPNWnjJ8TZRZ+ZPS0yyRGxc/PpjZxV6tEVTBYFK6lG
        uYFr+VAMydwzeu5N3zI2q2p1tEXECHbq8eWjaJM=
X-Google-Smtp-Source: ABdhPJyqJd9BSdOwQo93jGFONTwfkff4zMyVXs7Iwx3HNoxUvH6qMU2wjDHWuxTU4jcYynDfF0p4L+wunjsIX52YuG4=
X-Received: by 2002:a05:6602:248f:b0:65a:fb17:7a6b with SMTP id
 g15-20020a056602248f00b0065afb177a6bmr9061028ioe.79.1652747337080; Mon, 16
 May 2022 17:28:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220514031221.3240268-1-yhs@fb.com> <20220514031253.3242578-1-yhs@fb.com>
In-Reply-To: <20220514031253.3242578-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 16 May 2022 17:28:46 -0700
Message-ID: <CAEf4BzYqC8BhUHk=SW-=dLyF=4ZPqYXoo2eBTLcqd1VXjK0xUg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 06/18] libbpf: Add enum64 deduplication support
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, May 13, 2022 at 8:13 PM Yonghong Song <yhs@fb.com> wrote:
>
> Add enum64 deduplication support. BTF_KIND_ENUM64 handling
> is very similar to BTF_KIND_ENUM.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  tools/lib/bpf/btf.c | 55 +++++++++++++++++++++++++++++++++------------
>  tools/lib/bpf/btf.h |  5 +++++
>  2 files changed, 46 insertions(+), 14 deletions(-)
>

[...]

> +static bool btf_equal_enum64_val(struct btf_type *t1, struct btf_type *t2)
> +{
> +       const struct btf_enum64 *m1, *m2;
> +       __u16 vlen = btf_vlen(t1);
> +       int i;
> +
> +       m1 = btf_enum64(t1);
> +       m2 = btf_enum64(t2);
> +       for (i = 0; i < vlen; i++) {
> +               if (m1->name_off != m2->name_off || m1->val_lo32 != m2->val_lo32 ||
> +                   m1->val_hi32 != m2->val_hi32)
> +                       return false;
> +               m1++;
> +               m2++;
> +       }
> +       return true;
> +}
> +
> +/* Check structural equality of two ENUMs. */
> +static bool btf_equal_enum_or_enum64(struct btf_type *t1, struct btf_type *t2)

I find this helper quite confusing. It implies it can compare any enum
or enum64 with each other, but it really allows only enum vs enum and
enum64 vs enum64 (as it should!). Let's keep
btf_equal_enum()/btf_compat_enum() completely intact and add
btf_equal_enum64()/btf_compat_enum64() separately (few lines of
copy-pasted code is totally fine to keep them separate, IMO). See
below.

> +{
> +       if (!btf_equal_common(t1, t2))
> +               return false;
> +
> +       if (btf_is_enum(t1))
> +               return btf_equal_enum32_val(t1, t2);
> +       return btf_equal_enum64_val(t1, t2);
> +}
> +
>  static inline bool btf_is_enum_fwd(struct btf_type *t)
>  {
> -       return btf_is_enum(t) && btf_vlen(t) == 0;
> +       return btf_type_is_any_enum(t) && btf_vlen(t) == 0;
>  }
>
> -static bool btf_compat_enum(struct btf_type *t1, struct btf_type *t2)
> +static bool btf_compat_enum_or_enum64(struct btf_type *t1, struct btf_type *t2)
>  {
>         if (!btf_is_enum_fwd(t1) && !btf_is_enum_fwd(t2))
> -               return btf_equal_enum(t1, t2);
> +               return btf_equal_enum_or_enum64(t1, t2);
>         /* ignore vlen when comparing */
>         return t1->name_off == t2->name_off &&
>                (t1->info & ~0xffff) == (t2->info & ~0xffff) &&
> @@ -3829,6 +3853,7 @@ static int btf_dedup_prep(struct btf_dedup *d)
>                         h = btf_hash_int_decl_tag(t);
>                         break;
>                 case BTF_KIND_ENUM:
> +               case BTF_KIND_ENUM64:
>                         h = btf_hash_enum(t);
>                         break;
>                 case BTF_KIND_STRUCT:
> @@ -3898,15 +3923,16 @@ static int btf_dedup_prim_type(struct btf_dedup *d, __u32 type_id)
>                 break;
>
>         case BTF_KIND_ENUM:
> +       case BTF_KIND_ENUM64:
>                 h = btf_hash_enum(t);
>                 for_each_dedup_cand(d, hash_entry, h) {
>                         cand_id = (__u32)(long)hash_entry->value;
>                         cand = btf_type_by_id(d->btf, cand_id);
> -                       if (btf_equal_enum(t, cand)) {
> +                       if (btf_equal_enum_or_enum64(t, cand)) {

I'd rather have this enum vs enum64 distinction right here:

if ((btf_is_enum(t) && btf_equal_enum(t, cand)) ||
    (btf_is_enum64(t) && btf_equal_enum64(t, cand))) { ... }

>                                 new_id = cand_id;
>                                 break;
>                         }
> -                       if (btf_compat_enum(t, cand)) {
> +                       if (btf_compat_enum_or_enum64(t, cand)) {

and same here with (btf_is_enum && btf_compat_enum) || (btf_is_num64
&& btf_compat_enum64) ?

Basically, I'd like to avoid worrying if we are accidentally mixing
enum and enum64 or not. WDYT?

>                                 if (btf_is_enum_fwd(t)) {
>                                         /* resolve fwd to full enum */
>                                         new_id = cand_id;
> @@ -4211,7 +4237,8 @@ static int btf_dedup_is_equiv(struct btf_dedup *d, __u32 cand_id,
>                 return btf_equal_int_tag(cand_type, canon_type);
>
>         case BTF_KIND_ENUM:
> -               return btf_compat_enum(cand_type, canon_type);
> +       case BTF_KIND_ENUM64:
> +               return btf_compat_enum_or_enum64(cand_type, canon_type);
>

and here we just know whether we need btf_compat_enum vs btf_compat_enum64.


>         case BTF_KIND_FWD:
>         case BTF_KIND_FLOAT:
> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> index a41463bf9060..b22c648c69ff 100644
> --- a/tools/lib/bpf/btf.h
> +++ b/tools/lib/bpf/btf.h
> @@ -531,6 +531,11 @@ static inline bool btf_is_type_tag(const struct btf_type *t)
>         return btf_kind(t) == BTF_KIND_TYPE_TAG;
>  }
>
> +static inline bool btf_type_is_any_enum(const struct btf_type *t)
> +{
> +       return btf_is_enum(t) || btf_is_enum64(t);
> +}
> +
>  static inline __u8 btf_int_encoding(const struct btf_type *t)
>  {
>         return BTF_INT_ENCODING(*(__u32 *)(t + 1));
> --
> 2.30.2
>
