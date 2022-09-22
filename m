Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DADB35E573C
	for <lists+bpf@lfdr.de>; Thu, 22 Sep 2022 02:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbiIVAUg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Sep 2022 20:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiIVAUg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Sep 2022 20:20:36 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5DA9F19D
        for <bpf@vger.kernel.org>; Wed, 21 Sep 2022 17:20:34 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id sd10so9053859ejc.2
        for <bpf@vger.kernel.org>; Wed, 21 Sep 2022 17:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=IeEGGK+1GV5JKUXLnfp4GqOg1sWEzS+O95MNxdWvHug=;
        b=B3wfLvNY9RkBLNXL0ssTjWZGJffdp6pgSj9+q66AbHAKQh5L/ifynr0T7E6g2KNtxd
         8IrQT91Y4vnMuGapbomKz4iab4tZ8amCNSBmePEjumelPyz+0Y4NZCbOWb9PJUwquXmM
         WW+gOkDOaZpb8KEuYptdv8g1GBolsxsB8lvd/gYXHwUpwbKgR5JUl43ccW2nT+/vrJjv
         hBtZzfbC/Xf6r8jfohkUiNAFKkRICA9CnrD4fFh4bXJ6zid6gVK65SXRTsiynvSrgL76
         1qUBGR1GdOFU3ahuWmU3F2I1oPAObmGDv+54A+PrPhzYPqWk5UGeePzgeEYnAvjwNmOF
         UJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=IeEGGK+1GV5JKUXLnfp4GqOg1sWEzS+O95MNxdWvHug=;
        b=K0they5RN8gquv82i1tU4BZZJe9ay5n9jPXXYhrIeVBqb7rxROVCVHhEdLlrS9NvjG
         5Z8TtO54kvU5xcg3l1RP7w/J27CFjf2u3lU9+LkMSDqEWpCWEyGAXfn0DE+FrvUllV1F
         nELHzaYJjBzz0vqH6WBYap1CNqD8XIGCwZNeKLAvIDi/NDrplErlhxcZbtiIHji+jYbv
         ZFf4H9aU6nMSMoHrsCRr0DRyZ72Sa2nxO0vbc8GdTgEqLId/OpkC5C6I2v6okNhA7tEP
         dXFZFUTHnwuWIq45gCf4ix+L4ZVa9CiRcYg6Jh0iKqsWe94DJd5f5IfhUthQzPzlLj1+
         YrQA==
X-Gm-Message-State: ACrzQf0EjRMiKdwf3CZP8GkqR2a90sHlOm8R2sJwiLb7N+f10VIysUWG
        cu2QvqrbwBimXhAJwIlaXOlWhkXdLj0CHuHfjjU=
X-Google-Smtp-Source: AMsMyM48x8NMVwDBG/K0I8Ag0Aw64O3YocmwWk3HSrvx1Fb77A7YX2mpWAmy35esfHH8skzDGjiTXQjPlMF2d0AUcRg=
X-Received: by 2002:a17:907:2bd8:b0:770:77f2:b7af with SMTP id
 gv24-20020a1709072bd800b0077077f2b7afmr601295ejc.545.1663806032758; Wed, 21
 Sep 2022 17:20:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220911122328.306188-1-shmulik.ladkani@gmail.com> <20220911122328.306188-3-shmulik.ladkani@gmail.com>
In-Reply-To: <20220911122328.306188-3-shmulik.ladkani@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 21 Sep 2022 17:20:21 -0700
Message-ID: <CAEf4BzZE+JBDBaMzWa86zuFp67KUa41gGGcJVGW26qguFjmO4w@mail.gmail.com>
Subject: Re: [PATCH v7 bpf-next 2/4] bpf: Support setting variable-length
 tunnel options
To:     Shmulik Ladkani <shmulik@metanetworks.com>
Cc:     bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Paul Chaignon <paul@isovalent.com>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Sep 11, 2022 at 5:23 AM Shmulik Ladkani
<shmulik@metanetworks.com> wrote:
>
> Existing 'bpf_skb_set_tunnel_opt' allows setting tunnel options given
> an option buffer (ARG_PTR_TO_MEM) and the compile-time fixed buffer
> size (ARG_CONST_SIZE).
>
> However, in certain cases we wish to set tunnel options of dynamic
> length.
>
> For example, we have an ebpf program that gets geneve options on
> incoming packets, stores them into a map (using a key representing
> the incoming flow), and later needs to assign *same* options to
> reply packets (belonging to same flow).
>
> This is currently imposssible without knowing sender's exact geneve
> options length, which unfortunately is dymamic.
>
> Introduce 'bpf_skb_set_tunnel_opt_dynptr'.
>
> This is a variant of 'bpf_skb_set_tunnel_opt' which gets a bpf dynamic
> pointer (ARG_PTR_TO_DYNPTR) parameter whose data points to the options
> buffer to set.
>
> Signed-off-by: Shmulik Ladkani <shmulik.ladkani@gmail.com>
>
> ---
> v3: Avoid 'inline' for the __bpf_skb_set_tunopt helper function
> v4: change API to be based on bpf_dynptr, suggested by John Fastabend <john.fastabend@gmail.com>
> v6: Remove superfluous 'len' from bpf_skb_set_tunnel_opt_dynptr API
>     (rely on dynptr's internal size), suggested by Andrii Nakryiko <andrii.nakryiko@gmail.com>
> ---
>  include/uapi/linux/bpf.h       | 11 +++++++++++
>  net/core/filter.c              | 31 +++++++++++++++++++++++++++++--
>  tools/include/uapi/linux/bpf.h | 11 +++++++++++
>  3 files changed, 51 insertions(+), 2 deletions(-)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 3df78c56c1bf..ba12f7e1ccb6 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -5387,6 +5387,16 @@ union bpf_attr {
>   *     Return
>   *             Current *ktime*.
>   *
> + * long bpf_skb_set_tunnel_opt_dynptr(struct sk_buff *skb, struct bpf_dynptr *opt)
> + *     Description
> + *             Set tunnel options metadata for the packet associated to *skb*
> + *             to the option data pointed to by the *opt* dynptr.
> + *
> + *             See also the description of the **bpf_skb_get_tunnel_opt**\ ()
> + *             helper for additional information.
> + *     Return
> + *             0 on success, or a negative error in case of failure.
> + *
>   */
>  #define __BPF_FUNC_MAPPER(FN)          \
>         FN(unspec),                     \
> @@ -5598,6 +5608,7 @@ union bpf_attr {
>         FN(tcp_raw_check_syncookie_ipv4),       \
>         FN(tcp_raw_check_syncookie_ipv6),       \
>         FN(ktime_get_tai_ns),           \
> +       FN(skb_set_tunnel_opt_dynptr),  \
>         /* */
>
>  /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> diff --git a/net/core/filter.c b/net/core/filter.c
> index e872f45399b0..1c652936ef86 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -4674,8 +4674,7 @@ static const struct bpf_func_proto bpf_skb_set_tunnel_key_proto = {
>         .arg4_type      = ARG_ANYTHING,
>  };
>
> -BPF_CALL_3(bpf_skb_set_tunnel_opt, struct sk_buff *, skb,
> -          const u8 *, from, u32, size)
> +static u64 __bpf_skb_set_tunopt(struct sk_buff *skb, const u8 *from, u32 size)
>  {
>         struct ip_tunnel_info *info = skb_tunnel_info(skb);
>         const struct metadata_dst *md = this_cpu_ptr(md_dst);
> @@ -4690,6 +4689,22 @@ BPF_CALL_3(bpf_skb_set_tunnel_opt, struct sk_buff *, skb,
>         return 0;
>  }
>
> +BPF_CALL_3(bpf_skb_set_tunnel_opt, struct sk_buff *, skb,
> +          const u8 *, from, u32, size)
> +{
> +       return __bpf_skb_set_tunopt(skb, from, size);
> +}
> +
> +BPF_CALL_2(bpf_skb_set_tunnel_opt_dynptr, struct sk_buff *, skb,
> +          struct bpf_dynptr_kern *, ptr)
> +{
> +       const u8 *from = bpf_dynptr_get_data(ptr);
> +
> +       if (unlikely(!from))
> +               return -EFAULT;
> +       return __bpf_skb_set_tunopt(skb, from, bpf_dynptr_get_size(ptr));
> +}
> +
>  static const struct bpf_func_proto bpf_skb_set_tunnel_opt_proto = {
>         .func           = bpf_skb_set_tunnel_opt,
>         .gpl_only       = false,
> @@ -4699,6 +4714,14 @@ static const struct bpf_func_proto bpf_skb_set_tunnel_opt_proto = {
>         .arg3_type      = ARG_CONST_SIZE,
>  };
>
> +static const struct bpf_func_proto bpf_skb_set_tunnel_opt_dynptr_proto = {
> +       .func           = bpf_skb_set_tunnel_opt_dynptr,
> +       .gpl_only       = false,
> +       .ret_type       = RET_INTEGER,
> +       .arg1_type      = ARG_PTR_TO_CTX,
> +       .arg2_type      = ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_LOCAL,

being able to accept only DYNPTR_TYPE_LOCAL is quite limiting. We have
RINGBUF type, as well as soon we'll have MALLOC type. Even with SKB
and XDP types there is a linear area that kernel accept directly.

So if feels better to not specify exact type, accept any type, and
then have internal kernel helpers that will return you direct memory
pointer, if it is readable (i.e., for skb/xdp that would mean data
points to linear part).

So basically exactly the same behavior as bpf_dynptr_data() BPF helper.

Also note that dynptr is now CAP_BPF-only, so you might want to make
sure that your new helper is also CAP_BPF-guarded?

> +};
> +
>  static const struct bpf_func_proto *
>  bpf_get_skb_set_tunnel_proto(enum bpf_func_id which)
>  {
> @@ -4719,6 +4742,8 @@ bpf_get_skb_set_tunnel_proto(enum bpf_func_id which)
>                 return &bpf_skb_set_tunnel_key_proto;
>         case BPF_FUNC_skb_set_tunnel_opt:
>                 return &bpf_skb_set_tunnel_opt_proto;
> +       case BPF_FUNC_skb_set_tunnel_opt_dynptr:
> +               return &bpf_skb_set_tunnel_opt_dynptr_proto;
>         default:
>                 return NULL;
>         }
> @@ -7798,6 +7823,7 @@ tc_cls_act_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>         case BPF_FUNC_skb_get_tunnel_opt:
>                 return &bpf_skb_get_tunnel_opt_proto;
>         case BPF_FUNC_skb_set_tunnel_opt:
> +       case BPF_FUNC_skb_set_tunnel_opt_dynptr:
>                 return bpf_get_skb_set_tunnel_proto(func_id);
>         case BPF_FUNC_redirect:
>                 return &bpf_redirect_proto;
> @@ -8145,6 +8171,7 @@ lwt_xmit_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>         case BPF_FUNC_skb_get_tunnel_opt:
>                 return &bpf_skb_get_tunnel_opt_proto;
>         case BPF_FUNC_skb_set_tunnel_opt:
> +       case BPF_FUNC_skb_set_tunnel_opt_dynptr:
>                 return bpf_get_skb_set_tunnel_proto(func_id);
>         case BPF_FUNC_redirect:
>                 return &bpf_redirect_proto;
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 3df78c56c1bf..ba12f7e1ccb6 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -5387,6 +5387,16 @@ union bpf_attr {
>   *     Return
>   *             Current *ktime*.
>   *
> + * long bpf_skb_set_tunnel_opt_dynptr(struct sk_buff *skb, struct bpf_dynptr *opt)
> + *     Description
> + *             Set tunnel options metadata for the packet associated to *skb*
> + *             to the option data pointed to by the *opt* dynptr.
> + *
> + *             See also the description of the **bpf_skb_get_tunnel_opt**\ ()
> + *             helper for additional information.
> + *     Return
> + *             0 on success, or a negative error in case of failure.
> + *
>   */
>  #define __BPF_FUNC_MAPPER(FN)          \
>         FN(unspec),                     \
> @@ -5598,6 +5608,7 @@ union bpf_attr {
>         FN(tcp_raw_check_syncookie_ipv4),       \
>         FN(tcp_raw_check_syncookie_ipv6),       \
>         FN(ktime_get_tai_ns),           \
> +       FN(skb_set_tunnel_opt_dynptr),  \
>         /* */
>
>  /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> --
> 2.37.3
>
