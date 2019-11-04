Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB76ED774
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2019 03:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbfKDCIM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 3 Nov 2019 21:08:12 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37574 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728227AbfKDCIM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 3 Nov 2019 21:08:12 -0500
Received: by mail-qk1-f196.google.com with SMTP id e187so3396890qkf.4
        for <bpf@vger.kernel.org>; Sun, 03 Nov 2019 18:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=coverfire.com; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=NZjd1aiE9ljfVyAYAzmVOMl1dm7M7bVI1+859Yvsuy4=;
        b=Mn9trFmjs68dJ50ygRmLgqUHFvL0TJmACdy2aoW2tUO3BLClWdSF1qTRAfQRD/Hkrr
         TMgF3WdJGW2WKP6rrgRH4ONQcj+Vjrc16KSroyYRYwWQFSr/iPQr8GlzM6Ith9qMQo8O
         gT8D8y8dp3kiShYRaL2yOK//vS4viogmucdRoJQhmjb0Wkl8FA0lzcNR191wN3htQDz+
         5yPEp98QWhZ9MLZArTjs0Ch/9u1uzBzc5xu4V3iHk0BUV4M+gwSaRF8ikMG4ouDlkkvN
         rLOCD7bI/zjPdZStNDzddlA16eRy9ecHjShjmbx0wn4ut/H/ImOpAEIQjshZ9XvQ1QeH
         JljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=NZjd1aiE9ljfVyAYAzmVOMl1dm7M7bVI1+859Yvsuy4=;
        b=YGYSRdn0xZ9y7L1A80CeLd1/iSZJ3rg4zTAkG9tLAJ+sgGBAdtu8KdvZV9o1u5mG0W
         kaQUNaGQrQBqgbq+Gc2QzHNI3GjkewvsnTSQ4N6L8iumarkaDM/8OZUSGPYVwTdu3IS5
         /S4JI94bPfaIQ/3ih560LBq8xOo789s4vBN4Hrxif0Ef6JY3RIURFROeRpVNTw8tayky
         w1Mhtcfju69itkp6+p/cBT/E2tE2tPit9hhZNr9Yvi4gMAcwdjrHFROz9dE/qqGDJPxF
         N5J/UuKFWduSmXJTL3Ee53Cl4DUlJ6Kutmu9K8Qvkd+YTsye/UodqDzlWvHgUcaWu7+w
         a3vw==
X-Gm-Message-State: APjAAAX5pMVXy4G/TsU4l+qSxW+ES5DOuxV3lQiLF/b8hvVixjMoGL16
        ngvxue9CWSQV8NNVPwbJWLkStQ==
X-Google-Smtp-Source: APXvYqyfHeKPje0Zs+td+720nNdYHowg5XX/TSNKHED/Ko7t6ratKpzO8Pb3oTDD4F8fUFumf1/Opw==
X-Received: by 2002:a37:a00f:: with SMTP id j15mr6707654qke.103.1572833291510;
        Sun, 03 Nov 2019 18:08:11 -0800 (PST)
Received: from localhost.home ([69.41.199.68])
        by smtp.gmail.com with ESMTPSA id x194sm3617001qkb.66.2019.11.03.18.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2019 18:08:10 -0800 (PST)
Message-ID: <82fb2eba56d84887772f9d533faa7bda9e3b2ee4.camel@coverfire.com>
Subject: Re: [Intel-wired-lan] FW: [PATCH bpf-next 2/4] xsk: allow AF_XDP
 sockets to receive packets directly from a queue
From:   dan@coverfire.com
To:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Cc:     bjorn.topel@gmail.com, alexei.starovoitov@gmail.com,
        bjorn.topel@intel.com, bpf@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, maciej.fijalkowski@intel.com,
        magnus.karlsson@intel.com, netdev@vger.kernel.org, toke@redhat.com,
        tom.herbert@intel.com, David Miller <davem@davemloft.net>
Date:   Sun, 03 Nov 2019 21:08:08 -0500
In-Reply-To: <20191031172148.0290b11f@cakuba.netronome.com>
References: <CAJ+HfNigHWVk2b+UJPhdCWCTcW=Eh=yfRNHg4=Fr1mv98Pq=cA@mail.gmail.com>
         <2e27b8d9-4615-cd8d-93de-2adb75d8effa@intel.com>
         <20191031172148.0290b11f@cakuba.netronome.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1 (3.34.1-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 2019-10-31 at 17:21 -0700, Jakub Kicinski wrote:
> 
> My concern was that we want the applications to encode fast path
> logic
> in BPF and load that into the kernel. So your patch works
> fundamentally
> against that goal:

I'm only one AF_XDP user but my main goal is to get packets to
userspace as fast as possible. I don't (currently) need a BPF program
in the path at all. I suspect that many other people that look at
AF_XDP as a DPDK replacement have a similar view.

