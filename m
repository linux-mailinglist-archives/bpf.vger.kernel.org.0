Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 633EA37BF9A
	for <lists+bpf@lfdr.de>; Wed, 12 May 2021 16:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhELOQ0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 May 2021 10:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbhELOPZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 May 2021 10:15:25 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A2AC06138F
        for <bpf@vger.kernel.org>; Wed, 12 May 2021 07:14:14 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id k10so3996765ejj.8
        for <bpf@vger.kernel.org>; Wed, 12 May 2021 07:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B8+dsnVGPf7hsY+HQXduPDAnUEDSpNmU6uRk4M3oaqs=;
        b=c917zy549w9VdfbQA59q0ZGjmJzDalQGHwIAgrrORe6nhbyLpIm0hOhpfbR2lf56Do
         H4sq4JTjpYYzjFFtG0b3QjgOoRtfJPFdkjU9BzxOynd4sqh1WtoW8wGUXVi+Q6m6w22i
         kFeD/tXYufp88NZZwKtwHsIma/lW4Qxa4v5H11u4IUqDvj7C/BJPM/XGh4ma0/LydrAn
         utQySur7OvheW+UY9CJyqdC8EuH9SEGAQfSNUx682LoK/ZuEvSs5agLzdXj+D8v3A7OW
         mjja+ixSxQt/u0Qwy5OKTNtrwqxTXmk9tq3TKUOb1PkTmGMm2EiTX2wT/ZqpiDoRlZNg
         hYAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B8+dsnVGPf7hsY+HQXduPDAnUEDSpNmU6uRk4M3oaqs=;
        b=SzpBi5ptaysCSZ1zSKlJwYMy9Os2YVhJp4ykrEk3+U9G69+aCnZg242DSMFkzOhYLC
         woIWSD65lLjFmQm8xeRT2O7aZJgeao7Eyk4oOtfhPv1uvc5yAttRR/+/k6CIi9urOfCw
         PAkRWwVZtDSR9bNCYcKQbRsVq67R/CJLaJIPSBjh8spsjMPQ8MVXvWWjSg9t/w6vNXGu
         Dqulyi71JBPagKHSO9ee9NkJl33V/B9toOyz+PLlrcYU3wryklfMnTx4bJURGcEY+KNQ
         EWLDwpHYdOcgRjmpuoNiD3F2L2cr40nHhrvlCfd62+3EXXCJHIBcJFbQTMv/S7+IYpMm
         cbdA==
X-Gm-Message-State: AOAM533V3o/zeYhoFh5TFPwV95W9S9GqrfgSmVkrFUxvfzr6zj+hK06+
        Z0XOFdZ7UeiIlLFk4GVUfYjZvG6uGI1sNg==
X-Google-Smtp-Source: ABdhPJzCULg9SmIuGe6QVHUvqQDGGNC/+KR41PAA8PSlk57RutYD9Mmjh+ksry8qTp48G4EJSnvPlA==
X-Received: by 2002:a17:906:ae8f:: with SMTP id md15mr38278305ejb.244.1620828853408;
        Wed, 12 May 2021 07:14:13 -0700 (PDT)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id x18sm14690971eju.45.2021.05.12.07.14.11
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 May 2021 07:14:11 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id j3-20020a05600c4843b02901484662c4ebso3116206wmo.0
        for <bpf@vger.kernel.org>; Wed, 12 May 2021 07:14:11 -0700 (PDT)
X-Received: by 2002:a1c:ba05:: with SMTP id k5mr7661497wmf.169.1620828850704;
 Wed, 12 May 2021 07:14:10 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20210512074058epcas2p35536c27bdfafaa6431e164c142007f96@epcas2p3.samsung.com>
 <1620714998-120657-1-git-send-email-dseok.yi@samsung.com> <1620804453-57566-1-git-send-email-dseok.yi@samsung.com>
In-Reply-To: <1620804453-57566-1-git-send-email-dseok.yi@samsung.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Wed, 12 May 2021 10:13:32 -0400
X-Gmail-Original-Message-ID: <CA+FuTSdOvfdeEPffem6ZDyMzu7yqWxBZrVi2S2wgwjBwqpqquA@mail.gmail.com>
Message-ID: <CA+FuTSdOvfdeEPffem6ZDyMzu7yqWxBZrVi2S2wgwjBwqpqquA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] bpf: check for BPF_F_ADJ_ROOM_FIXED_GSO when bpf_skb_change_proto
To:     Dongseok Yi <dseok.yi@samsung.com>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 12, 2021 at 3:41 AM Dongseok Yi <dseok.yi@samsung.com> wrote:
>
> In the forwarding path GRO -> BPF 6 to 4 -> GSO for TCP traffic, the
> coalesced packet payload can be > MSS, but < MSS + 20.
> bpf_skb_proto_6_to_4 will upgrade the MSS and it can be > the payload
> length. After then tcp_gso_segment checks for the payload length if it
> is <= MSS. The condition is causing the packet to be dropped.
>
> tcp_gso_segment():
>         [...]
>         mss = skb_shinfo(skb)->gso_size;
>         if (unlikely(skb->len <= mss))
>                 goto out;
>         [...]
>
> Allow to upgrade/downgrade MSS only when BPF_F_ADJ_ROOM_FIXED_GSO is
> not set.
>
> Signed-off-by: Dongseok Yi <dseok.yi@samsung.com>

Acked-by: Willem de Bruijn <willemb@google.com>
