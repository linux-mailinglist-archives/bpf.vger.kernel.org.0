Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEA558713F
	for <lists+bpf@lfdr.de>; Mon,  1 Aug 2022 21:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234038AbiHATOV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Aug 2022 15:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235027AbiHATNh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Aug 2022 15:13:37 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DC4357CA
        for <bpf@vger.kernel.org>; Mon,  1 Aug 2022 12:12:39 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id m4so302813ejr.3
        for <bpf@vger.kernel.org>; Mon, 01 Aug 2022 12:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SDm1xP3KpXa1q9e5gJR3RdBSkXXop4mo5acE0AiGIWs=;
        b=jdHN4vOUQuOLX7Atd/Lde50dCi+J762fBMClNKYdZ9J3ezABXCjrfX3TK53WBqY8Mz
         FNsVrzHBZkamF0Xtr8Zc0XEaqmMx2vnAILupnjykbvcl9TtvCyFbj9djEgJwhM1Ap1KX
         zsjsJbReLIlRQXHALZUQ+cgjW7UMhQs6gMqzuvC9nYvzxlq41fMTGoEl3qvRqAFU33Tm
         Sa4v0lFVxiIDpLFOSZx7MVRTKpuRiUAvlztwAYoJy1olBlTIENaYR/9+I8nkksslPibr
         +Qst3HAFFPfAUtWioI8ZTKOvGI0ywQlFpXJnWP/oc7FhuLRG7+MNKCT8YSBajp5PGSnE
         1zkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SDm1xP3KpXa1q9e5gJR3RdBSkXXop4mo5acE0AiGIWs=;
        b=WkYZ2ZA3Zu0qRCAHqZMqLIhHCc6PnsLSWp1jxHGFApCg2EJIjHWtX5f2W92PaQ56ln
         0FVFGeoUl/Ohjfxwq2riHrvbSdnhuQITjmsOIyMHhXSKIjacTnAajP7N5hVtmTUxwo6t
         6SF9hq9hLA8z2n26NuLSXIda4lrAmmud4WBQXhJcLH0NY88Av3MSZBAr/NUS+r+XR7So
         tn0FLHPyb1xROw9w3mEIkpW+jo0/fgYjKnyD2ooVDn9NAhLRNl5XwPmAAXXoZqVH4jkj
         kn3+AlJSXYAl46DtzCK95z/XtZQMQlhBB2snDvvohJCQsV15y6GQrSU0cBouNjFMWYV+
         N34Q==
X-Gm-Message-State: AJIora/UHxAT9b3RzCnnc3kh1BdkConX8cVQMFhEsRYtksnExLqT+Cje
        dsYTtdzrRUVSaeJiyHpu2aOGklHeDwQMwQYTDXETbeN7m38=
X-Google-Smtp-Source: AGRyM1skWHbi5BKmmnxJZiXEG789Xg2ydLIiWHsESVQMl7tivA4gEdRodTUm2DQ5diyHjq9CYwT1nccffZl7wcAtfEE=
X-Received: by 2002:a17:907:6e02:b0:72b:9f16:1bc5 with SMTP id
 sd2-20020a1709076e0200b0072b9f161bc5mr14177169ejc.676.1659381157968; Mon, 01
 Aug 2022 12:12:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220726184706.954822-1-joannelkoong@gmail.com> <20220726184706.954822-4-joannelkoong@gmail.com>
In-Reply-To: <20220726184706.954822-4-joannelkoong@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 1 Aug 2022 12:12:26 -0700
Message-ID: <CAADnVQJiA+Ari7_MmBLgNSDPoCY_wmQTdE9oqCX1DGqo6nVXxw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 3/3] selftests/bpf: tests for using dynptrs to
 parse skb and xdp buffers
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
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

On Tue, Jul 26, 2022 at 11:48 AM Joanne Koong <joannelkoong@gmail.com> wrote:
>
>
> -static __always_inline int handle_ipv4(struct xdp_md *xdp)
> +static __always_inline int handle_ipv4(struct xdp_md *xdp, struct bpf_dynptr *xdp_ptr)
>  {
> -       void *data_end = (void *)(long)xdp->data_end;
> -       void *data = (void *)(long)xdp->data;
> +       struct bpf_dynptr new_xdp_ptr;
>         struct iptnl_info *tnl;
>         struct ethhdr *new_eth;
>         struct ethhdr *old_eth;
> -       struct iphdr *iph = data + sizeof(struct ethhdr);
> +       struct iphdr *iph;
>         __u16 *next_iph;
>         __u16 payload_len;
>         struct vip vip = {};
> @@ -90,10 +90,12 @@ static __always_inline int handle_ipv4(struct xdp_md *xdp)
>         __u32 csum = 0;
>         int i;
>
> -       if (iph + 1 > data_end)
> +       iph = bpf_dynptr_data(xdp_ptr, ethhdr_sz,
> +                             iphdr_sz + (tcphdr_sz > udphdr_sz ? tcphdr_sz : udphdr_sz));
> +       if (!iph)
>                 return XDP_DROP;

dynptr based xdp/skb access looks neat.
Maybe in addition to bpf_dynptr_data() we can add helper(s)
that return skb/xdp_md from dynptr?
This way the code will be passing dynptr only and there will
be no need to pass around 'struct xdp_md *xdp' (like this function).

Separately please keep the existing tests instead of converting them.
Either ifdef data/data_end vs dynptr style or copy paste
the whole test into a new .c file. Whichever is cleaner.
