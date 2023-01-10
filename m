Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5FA6642E2
	for <lists+bpf@lfdr.de>; Tue, 10 Jan 2023 15:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238676AbjAJOLF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Jan 2023 09:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238755AbjAJOKa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Jan 2023 09:10:30 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0F58E9A7
        for <bpf@vger.kernel.org>; Tue, 10 Jan 2023 06:09:59 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-476e643d1d5so155292437b3.1
        for <bpf@vger.kernel.org>; Tue, 10 Jan 2023 06:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7M3QCJlBvTFvZDQvYqYTWIjwoUyJYqA77dSxM/qWCns=;
        b=Qa+GEvrc746eK1wTj7SXsMcC40nJCd3sBmsJEv0upVF7S0Xh3DcWEHQED99xAiosXi
         vXd0oQn+WhQV/YuQ6zYiwWdUMEGBJHI+Zqaz5MxJut3FU9Iywk8oaUTqjjd24TPl231z
         Fp5plZMsclY5fCEh+NFJKHphLkLpWEdsKqG7JTUXwa8TMSayES0HPpCFlnA4IfppcjJ+
         nXz8jCZeDotI92DdlCer6D8WyrlcX5WAqtxHE4JGH6NzDl0hPGlIO1Ov+TpIp3TyJf90
         WH1aE3KAOn3a2An9tOyVFAFjvJeuL+hojSCO8w4hWXTQ7O46Y7ZHZ0B0AlnKbYog9WwP
         BvDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7M3QCJlBvTFvZDQvYqYTWIjwoUyJYqA77dSxM/qWCns=;
        b=qCa5IN+ZeGKtD+psQJtejp4MRTSdKfW4RlC4A7oOaQt8CTE3ys4C5xCRN+XZ5njrjE
         m8LBZkRD+avPXyJ2+n+PHpE7VUf82Z56orbsucUu2kZ3bBiO7o4I9T3nNgWQXs/h0VFF
         fttpi6yOc+PTp/LdY5pk4jR29+Y6jMZqo/k2wyUuNvcP/b8p3x73kkgYtLJ9efzXCDCF
         VSF1iFGgHX8bquSuGvEilEfLAKufWkhaw3GnlsAkkAs5HRfzHx6Y32otswR/bzch0gwY
         HvKPiXUNMSy+Han+yV0v3HBHT3/h6dAeXKMnrWkRXMslSo9OGCshSVrHkcBWLd+Q/Abr
         5x2A==
X-Gm-Message-State: AFqh2kpXfSbJuB7Dt65hHlYtk54TT00bvsRl8HmCnQACHMcjN1ZaVU4b
        fKBJIYxOQbTkre8M5zE4WamSEi2S4K+ZpRNylTwLUQ==
X-Google-Smtp-Source: AMrXdXtry6fdC28oHUg7TmvsxwLUVOg4SzRVmIVcFek5DzAls9lDKmpJ4xXi5ac2gOrghJrMzejtfubK+Mshe415AVY=
X-Received: by 2002:a81:46d6:0:b0:3f6:489a:a06f with SMTP id
 t205-20020a8146d6000000b003f6489aa06fmr1904869ywa.470.1673359798253; Tue, 10
 Jan 2023 06:09:58 -0800 (PST)
MIME-Version: 1.0
References: <cover.1672976410.git.william.xuanziyang@huawei.com>
 <7e9ca6837b20bea661248957dbbd1db198e3d1f8.1672976410.git.william.xuanziyang@huawei.com>
 <Y7h8yrOEkPuHkNpJ@google.com> <CA+FuTSdZ+za55p1kKOcGby89F_ybRhAfy2cG0R+Y00yaJTbVkg@mail.gmail.com>
 <4d0e5f2b-d088-58f4-d86d-00aa444d77c0@huawei.com> <CA+FuTSeE-S9_Uc6Cqs=EqYZd-K6kj=Ex4sudNx7u8HMLcrereQ@mail.gmail.com>
 <d6c60481-18a4-acfe-23a5-6950e2b3d5cd@huawei.com>
In-Reply-To: <d6c60481-18a4-acfe-23a5-6950e2b3d5cd@huawei.com>
From:   Willem de Bruijn <willemb@google.com>
Date:   Tue, 10 Jan 2023 09:09:21 -0500
Message-ID: <CA+FuTSe+=Vmn+UJftVYrMuaqs90scYXnDsX77z02+KT7SZLHrQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Add ipip6 and ip6ip decap support for bpf_skb_adjust_room()
To:     "Ziyang Xuan (William)" <william.xuanziyang@huawei.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
        jolsa@kernel.org, sdf@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> I think you prefer like this:

Yes, this looks good to me. A few comments inline.

> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -2644,6 +2644,11 @@ union bpf_attr {
>   *               Use with BPF_F_ADJ_ROOM_ENCAP_L2 flag to further specify the
>   *               L2 type as Ethernet.
>   *
> + *              * **BPF_F_ADJ_ROOM_DECAP_L3_IPV4**,
> + *                **BPF_F_ADJ_ROOM_DECAP_L3_IPV6**:
> + *                Indicates the new IP header version after decapsulate the
> + *                outer IP header.
> + *
>   *             A call to this helper is susceptible to change the underlying
>   *             packet buffer. Therefore, at load time, all checks on pointers
>   *             previously done by the verifier are invalidated and must be
> @@ -5803,6 +5808,8 @@ enum {
>         BPF_F_ADJ_ROOM_ENCAP_L4_UDP     = (1ULL << 4),
>         BPF_F_ADJ_ROOM_NO_CSUM_RESET    = (1ULL << 5),
>         BPF_F_ADJ_ROOM_ENCAP_L2_ETH     = (1ULL << 6),
> +       BPF_F_ADJ_ROOM_DECAP_L3_IPV4    = (1ULL << 7),
> +       BPF_F_ADJ_ROOM_DECAP_L3_IPV6    = (1ULL << 8),
>  };
>
>  enum {
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 43cc1fe58a2c..0bbe5e67337c 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -3381,13 +3381,17 @@ static u32 bpf_skb_net_base_len(const struct sk_buff *skb)
>  #define BPF_F_ADJ_ROOM_ENCAP_L3_MASK   (BPF_F_ADJ_ROOM_ENCAP_L3_IPV4 | \
>                                          BPF_F_ADJ_ROOM_ENCAP_L3_IPV6)
>
> +#define BPF_F_ADJ_ROOM_DECAP_L3_MASK   (BPF_F_ADJ_ROOM_DECAP_L3_IPV4 | \
> +                                        BPF_F_ADJ_ROOM_DECAP_L3_IPV6)
> +
>  #define BPF_F_ADJ_ROOM_MASK            (BPF_F_ADJ_ROOM_FIXED_GSO | \
>                                          BPF_F_ADJ_ROOM_ENCAP_L3_MASK | \
>                                          BPF_F_ADJ_ROOM_ENCAP_L4_GRE | \
>                                          BPF_F_ADJ_ROOM_ENCAP_L4_UDP | \
>                                          BPF_F_ADJ_ROOM_ENCAP_L2_ETH | \
>                                          BPF_F_ADJ_ROOM_ENCAP_L2( \
> -                                         BPF_ADJ_ROOM_ENCAP_L2_MASK))
> +                                         BPF_ADJ_ROOM_ENCAP_L2_MASK) | \
> +                                        BPF_F_ADJ_ROOM_DECAP_L3_MASK)
>
>  static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
>                             u64 flags)
> @@ -3501,6 +3505,7 @@ static int bpf_skb_net_shrink(struct sk_buff *skb, u32 off, u32 len_diff,
>         int ret;
>
>         if (unlikely(flags & ~(BPF_F_ADJ_ROOM_FIXED_GSO |
> +                              BPF_F_ADJ_ROOM_DECAP_L3_MASK |
>                                BPF_F_ADJ_ROOM_NO_CSUM_RESET)))
>                 return -EINVAL;
>
> @@ -3519,6 +3524,14 @@ static int bpf_skb_net_shrink(struct sk_buff *skb, u32 off, u32 len_diff,
>         if (unlikely(ret < 0))
>                 return ret;
>
> +       /* Match skb->protocol to new outer l3 protocol */
> +       if (skb->protocol == htons(ETH_P_IP) &&
> +           flags & BPF_F_ADJ_ROOM_DECAP_L3_IPV6)
> +               skb->protocol = htons(ETH_P_IPV6);
> +       else if (skb->protocol == htons(ETH_P_IPV6) &&
> +                flags & BPF_F_ADJ_ROOM_DECAP_L3_IPV4)
> +               skb->protocol = htons(ETH_P_IP);
> +
>         if (skb_is_gso(skb)) {
>                 struct skb_shared_info *shinfo = skb_shinfo(skb);
>
> @@ -3597,6 +3610,10 @@ BPF_CALL_4(bpf_skb_adjust_room, struct sk_buff *, skb, s32, len_diff,
>                      proto != htons(ETH_P_IPV6)))
>                 return -ENOTSUPP;
>
> +       if (unlikely(shrink && flags & BPF_F_ADJ_ROOM_DECAP_L3_IPV4 &&
> +                    flags & BPF_F_ADJ_ROOM_DECAP_L3_IPV6))
> +               return -EINVAL;
> +

parentheses and can use mask:

  if (shrink && (flags & .._MASK == .._MASK)

also should fail if the flags are passed but shrink is false.

>         off = skb_mac_header_len(skb);
>         switch (mode) {
>         case BPF_ADJ_ROOM_NET:
> @@ -3608,6 +3625,16 @@ BPF_CALL_4(bpf_skb_adjust_room, struct sk_buff *, skb, s32, len_diff,
>                 return -ENOTSUPP;
>         }
>
> +       if (shrink) {
> +               if (proto == htons(ETH_P_IP) &&
> +                   flags & BPF_F_ADJ_ROOM_DECAP_L3_IPV6) {
> +                       len_min = sizeof(struct ipv6hdr);
> +               } else if (proto == htons(ETH_P_IPV6) &&
> +                          flags & BPF_F_ADJ_ROOM_DECAP_L3_IPV4) {
> +                       len_min = sizeof(struct iphdr);
> +               }
> +       }
> +

No need to test proto first?

>         len_cur = skb->len - skb_network_offset(skb);
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 464ca3f01fe7..041361bc6ccf 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -2644,6 +2644,11 @@ union bpf_attr {
>   *               Use with BPF_F_ADJ_ROOM_ENCAP_L2 flag to further specify the
>   *               L2 type as Ethernet.
>   *
> + *              * **BPF_F_ADJ_ROOM_DECAP_L3_IPV4**,
> + *                **BPF_F_ADJ_ROOM_DECAP_L3_IPV6**:
> + *                Indicates the new IP header version after decapsulate the
> + *                outer IP header.
> + *
>   *             A call to this helper is susceptible to change the underlying
>   *             packet buffer. Therefore, at load time, all checks on pointers
>   *             previously done by the verifier are invalidated and must be
> @@ -5803,6 +5808,8 @@ enum {
>         BPF_F_ADJ_ROOM_ENCAP_L4_UDP     = (1ULL << 4),
>         BPF_F_ADJ_ROOM_NO_CSUM_RESET    = (1ULL << 5),
>         BPF_F_ADJ_ROOM_ENCAP_L2_ETH     = (1ULL << 6),
> +       BPF_F_ADJ_ROOM_DECAP_L3_IPV4    = (1ULL << 7),
> +       BPF_F_ADJ_ROOM_DECAP_L3_IPV6    = (1ULL << 8),
>  };
>
>  enum {
>
