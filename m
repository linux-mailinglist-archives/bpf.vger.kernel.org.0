Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F445751D9
	for <lists+bpf@lfdr.de>; Thu, 14 Jul 2022 17:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240355AbiGNPeQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jul 2022 11:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240189AbiGNPeI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 11:34:08 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D752215FF8
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 08:34:06 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id r191so2792115oie.7
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 08:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l1s02NmT06ZtbH7uKtLSfhho+IMosk3J9PhK8LUL6jE=;
        b=vnrHsVvSxYoC3+qZ9wCruM/9Y5ABTDHR/mh3vIs2pjkLObQh2+4Afr2DW9Q2/akUb5
         VogVH4yZAmCnW0VgLQZYi5ZQF7Y0lan2QdXDGenPmsCc6wQvg/U568dNjygGFAQIv/JL
         GjdIOiBJG0LCR4bfWHx0kG4snLdU7/vyZgwWnO+DhaPenyIzJQgU++6fpBNMco0TViCP
         A0cYeGRBItYoomx625QyuBETc+HyO55GcxxQRHcwfs6rs2Vuvr5aQU6Xmxwf3+pN2r1L
         CsIzgwfxDKrHVMhzgzp9QvkoYKff+U5L5geHfd51FCoubR/5JKaPlfYWu6dCDA8pkdl3
         1pFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l1s02NmT06ZtbH7uKtLSfhho+IMosk3J9PhK8LUL6jE=;
        b=n4YgvuNfGhOtysd5svEPNZPNW862WfpnjlA3zG5wAL4gSHiNX6BV05X2iuh0qCo+9a
         pz010dzJ0hFqPpnJyKND7XWCazMtkpNWZMEfQWpv0wuvseW8fN+AyRLOD79gDbCQdH6P
         I/5d8mvI0mHdk2baYJjMLO7m59+q8qwdb1T+3bErwWrH+5K2Yi1QvqbTtxI9BfBiXwN3
         IOOF+LoLekph6JkWwuCVtxfKO4rkHAMRWAsXiJOinQ4Lzo4xStwOEzeEi6nizm8kPz4s
         OMjt9fw4ptnb0GzdNhFX+BzpiFok/OkkdSnOgwPX1hexfDPBisF4rV77OmbjTSiIkyOV
         yk+g==
X-Gm-Message-State: AJIora+3EU9fHJI0yBHzb/3x3I78Y5mePIMWvrkcRUha6sMZl2ygOcFN
        GXVlgPGWcejELz6FmQTNS69kLG53LGbJk+K7LyZj0Q==
X-Google-Smtp-Source: AGRyM1uRUv5nQZEv6jykoozOiPFmebzZNmQuoTPC+AlLy8MD2AQ9HOD8s1HFJf1EOBj78Wo84FMoC9oRWB96R9gxDhA=
X-Received: by 2002:a54:4618:0:b0:326:9f6e:edc6 with SMTP id
 p24-20020a544618000000b003269f6eedc6mr4474919oip.2.1657812846279; Thu, 14 Jul
 2022 08:34:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220713111430.134810-1-toke@redhat.com> <CAM0EoM=Pz_EWHsWzVZkZfojoRyUgLPVhGRHq6aGVhdcLC2YvHw@mail.gmail.com>
 <CAA93jw7SsxOqOE8YJOLikkzSsNQuBqdkGLreoD-DDgQM4n-9sg@mail.gmail.com>
In-Reply-To: <CAA93jw7SsxOqOE8YJOLikkzSsNQuBqdkGLreoD-DDgQM4n-9sg@mail.gmail.com>
From:   Jamal Hadi Salim <jhs@mojatatu.com>
Date:   Thu, 14 Jul 2022 11:33:55 -0400
Message-ID: <CAM0EoMmHi=R2bwGQC9aUh+xjpCHWGu3oXhE_1BVvcZbOfx7bSA@mail.gmail.com>
Subject: Re: [RFC PATCH 00/17] xdp: Add packet queueing and scheduling capabilities
To:     Dave Taht <dave.taht@gmail.com>
Cc:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Mykola Lysenko <mykolal@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Freysteinn Alfredsson <freysteinn.alfredsson@kau.se>,
        Cong Wang <xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 14, 2022 at 10:56 AM Dave Taht <dave.taht@gmail.com> wrote:
>
> In general I feel a programmable packet pacing approach is the right
> way forward for the internet as a whole.
>
> It lends itself more easily and accurately to offloading in an age
> where it is difficult to do anything sane within a ms on the host
> cpu, especially in virtualized environments, in the enormous dynamic
> range of kbits/ms to gbits/ms between host an potential recipient [1]
>
> So considerations about what is easier to offload moving forward vs
> central cpu costs should be in this conversation.
>

If you know your hardware can offload - there is a lot less to worry about.
You can let the synchronization be handled by hardware. For example,
if your hardware can do strict priority scheduling/queueing you really
should bypass the kernel layer, set appropriate metadata (skb prio)
and let the hw handle it. See the HTB offload from Nvidia.
OTOH, EDT based approaches are the best for some lightweight
approach which takes advantage of simple hardware
features (like timestamps, etc).

cheers,
jamal
