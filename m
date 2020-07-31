Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECA22348B3
	for <lists+bpf@lfdr.de>; Fri, 31 Jul 2020 17:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbgGaPvt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 31 Jul 2020 11:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727997AbgGaPvt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 31 Jul 2020 11:51:49 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33C7C061574
        for <bpf@vger.kernel.org>; Fri, 31 Jul 2020 08:51:48 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id e64so32083190iof.12
        for <bpf@vger.kernel.org>; Fri, 31 Jul 2020 08:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mWXKa1Sc5p1hrgsJYkTBC6jHOzmU2VYIHQ189M5bCl8=;
        b=o7KPymYNxFeY9UaTPnqxwE+cGBV3EqhUwYGpvHHM7xmfEQ6eSO1wLssKQdqy8cxByp
         c//w87d7janq7ZxBYgkEOZyU4gCifc4X/Zc2mf6p/CnDXCZYDtq6hAL2U8ewjGQMrDz/
         hKKwmBndVPjTLPBL1uUnc5QetF9UX6aqUZvSR1rU8meq1Xsat9LvggGyn4SgVWuAWfJf
         6UbhAjp9QVOYvEZCCD8dThOepYE9APWFu8d4i4RptI+9L3oVk3HOFfw7NY+ocaI7SlUv
         e4MQzNvZhE3mGIviAUd7DFwo35r5Ced1rEmVLPnj2Xcfw7OZSqi0CELQwkGbMfRWDH20
         AePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mWXKa1Sc5p1hrgsJYkTBC6jHOzmU2VYIHQ189M5bCl8=;
        b=Spw1PEjwpCvoGqI1iCOUYoGeg6x8bi6W3zbi8Ee52Oan1J3h0h2arI8Slnm0X2J6yS
         sgkiVhnih0ZmtmjfLQ2ZlzUp9NnEk4NHa4b+58Zn11QJtL5Fdon5fUUsEiQMoZGJ0DP0
         08nkCyNN9SeJqi2Gdv20kNsfBj+uh9uKefTAk92ko1/a4Sn3ETcpqkJ7pZooDEgaH145
         EBGeDEVW3+M4u/ioW3YrJA9Ow5kpVnc5Cg5APIDgT7bmO80w9Hwq1BF9Nv5EzVyrAdhN
         hll6GqjQpmC/J+pQ7AWPoPCfjtWB04bkoFia22TB7YVxhwWeLpPZk+C7OMCsfoO5MCEO
         8i/w==
X-Gm-Message-State: AOAM532555e2gUEWYEzibK+JxQjjLHPf3Jq/Vpnnvn3ZHgnHktQSUBI7
        QERDVP/Rp4sW7H/oXFNBKMtf80JOJ+8brpF/FFmY5A==
X-Google-Smtp-Source: ABdhPJy8TR2k9stPFavLcEBznOdYZ50ocCZzA4WyKUk3uhElv0WUTjILlRKiYWhL72kWmRPCg+awRBwflXIl0wGbKYs=
X-Received: by 2002:a05:6638:2653:: with SMTP id n19mr5797350jat.34.1596210707994;
 Fri, 31 Jul 2020 08:51:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200730205657.3351905-1-kafai@fb.com> <20200730205754.3355160-1-kafai@fb.com>
In-Reply-To: <20200730205754.3355160-1-kafai@fb.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 31 Jul 2020 08:51:36 -0700
Message-ID: <CANn89iLA5vongVK=kgS2creh+BiA821YfiiixkC1wa3QGCmvgg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 9/9] tcp: bpf: Optionally store mac header in TCP_SAVE_SYN
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        kernel-team <kernel-team@fb.com>,
        Lawrence Brakmo <brakmo@fb.com>,
        Neal Cardwell <ncardwell@google.com>,
        netdev <netdev@vger.kernel.org>,
        Yuchung Cheng <ycheng@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 30, 2020 at 1:58 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> This patch is adapted from Eric's patch in an earlier discussion [1].
>
> The TCP_SAVE_SYN currently only stores the network header and
> tcp header.  This patch allows it to optionally store
> the mac header also if the setsockopt's optval is 2.
>
> It requires one more bit for the "save_syn" bit field in tcp_sock.
> This patch achieves this by moving the syn_smc bit next to the is_mptcp.
> The syn_smc is currently used with the TCP experimental option.  Since
> syn_smc is only used when CONFIG_SMC is enabled, this patch also puts
> the "IS_ENABLED(CONFIG_SMC)" around it like the is_mptcp did
> with "IS_ENABLED(CONFIG_MPTCP)".
>
> The mac_hdrlen is also stored in the "struct saved_syn"
> to allow a quick offset from the bpf prog if it chooses to start
> getting from the network header or the tcp header.
>
> [1]: https://lore.kernel.org/netdev/CANn89iLJNWh6bkH7DNhy_kmcAexuUCccqERqe7z2QsvPhGrYPQ@mail.gmail.com/
>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Martin KaFai Lau <kafai@fb.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>
