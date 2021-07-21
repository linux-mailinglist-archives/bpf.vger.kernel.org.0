Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB8EF3D144E
	for <lists+bpf@lfdr.de>; Wed, 21 Jul 2021 18:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbhGUP6T (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Jul 2021 11:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbhGUP6R (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Jul 2021 11:58:17 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059AAC061575
        for <bpf@vger.kernel.org>; Wed, 21 Jul 2021 09:38:54 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id u1so2891749wrs.1
        for <bpf@vger.kernel.org>; Wed, 21 Jul 2021 09:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=qUp/hbe9LbIcAazlkz7Tc/uHNcSrR5NC/lxU1KgZVXk=;
        b=Z9Y8ZluN9wBZoRUhS/Ki597CyB4ritDT9tYSCg4ThTsTJEARZBlgbSv0W3sgLhcvYD
         GVnGT14AAlOEJdwb/Dtm1T/QnyIb+3lNFsYDsOvdmYIHuHoADWsIm45hHP1oftMpdsc0
         LF1BOPihLuflhqwLAiwj2bXiCGk2vs9Ny4n8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=qUp/hbe9LbIcAazlkz7Tc/uHNcSrR5NC/lxU1KgZVXk=;
        b=pHr8C6ThBWnWpOyHF0CVhqBMmHMvI2ccP2AK+/mFRP4i8xu4FozvuVg0qbwTbifHgw
         RLU6S3SsrtSd491XmKCcouIl4n9Abe6bDn4OUaN3mjcwgR2G/X7yyawI5J9PZ2O4hhc4
         nnfYAm0rO7k/eYgtzl5kMB6NOos3n2Q7kndiyDXeweGW8CDWrJldSzOW5Mlbk4xtrT+V
         Rw2K/eR686BSPZEdmZ+UxRhJzfYG8qbeNcIO2LpvBO/8pQxRrWe64mrGgPLQ8aE9o0e2
         eTGM/0EF7esoF3S/nPuaBmysTjbUzraLJVJ+bk0Y5iKGvMyBWy68PHMNADP2g9FOYuU/
         32dQ==
X-Gm-Message-State: AOAM532uagSCos2uHw6gQr1O71VaOFMTkJ12d2yMKAErm8CRkayugySL
        tbBOX8pTpZmGhb6OFHTk33QwcA==
X-Google-Smtp-Source: ABdhPJxzadLuuDAP25k4CLQBeMAWjFLJERpvFEPZvgUWeVLVBz+RbsTURmB6iCxIOMjmoQDGegBxkw==
X-Received: by 2002:a5d:568d:: with SMTP id f13mr44124982wrv.380.1626885532635;
        Wed, 21 Jul 2021 09:38:52 -0700 (PDT)
Received: from cloudflare.com (79.191.186.228.ipv4.supernova.orange.pl. [79.191.186.228])
        by smtp.gmail.com with ESMTPSA id o19sm389685wmc.12.2021.07.21.09.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 09:38:52 -0700 (PDT)
References: <20210719214834.125484-1-john.fastabend@gmail.com>
User-agent: mu4e 1.1.0; emacs 27.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     daniel@iogearbox.net, xiyou.wangcong@gmail.com,
        alexei.starovoitov@gmail.com, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH bpf 0/3] sockmap fixes picked up by stress tests
In-reply-to: <20210719214834.125484-1-john.fastabend@gmail.com>
Date:   Wed, 21 Jul 2021 18:38:51 +0200
Message-ID: <87r1frr59g.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 19, 2021 at 11:48 PM CEST, John Fastabend wrote:
> Running stress tests with recent patch to remove an extra lock in sockmap
> resulted in a couple new issues popping up. It seems only one of them
> is actually related to the patch:
>
> 799aa7f98d53 ("skmsg: Avoid lock_sock() in sk_psock_backlog()")
>
> The other two issues had existed long before, but I guess the timing
> with the serialization we had before was too tight to get any of
> our tests or deployments to hit it.
>
> With attached series stress testing sockmap+TCP with workloads that
> create lots of short-lived connections no more splats like below were
> seen on upstream bpf branch.
>
> [224913.935822] WARNING: CPU: 3 PID: 32100 at net/core/stream.c:208 sk_stream_kill_queues+0x212/0x220
> [224913.935841] Modules linked in: fuse overlay bpf_preload x86_pkg_temp_thermal intel_uncore wmi_bmof squashfs sch_fq_codel efivarfs ip_tables x_tables uas xhci_pci ixgbe mdio xfrm_algo xhci_hcd wmi
> [224913.935897] CPU: 3 PID: 32100 Comm: fgs-bench Tainted: G          I       5.14.0-rc1alu+ #181
> [224913.935908] Hardware name: Dell Inc. Precision 5820 Tower/002KVM, BIOS 1.9.2 01/24/2019
> [224913.935914] RIP: 0010:sk_stream_kill_queues+0x212/0x220
> [224913.935923] Code: 8b 83 20 02 00 00 85 c0 75 20 5b 5d 41 5c 41 5d 41 5e 41 5f c3 48 89 df e8 2b 11 fe ff eb c3 0f 0b e9 7c ff ff ff 0f 0b eb ce <0f> 0b 5b 5d 41 5c 41 5d 41 5e 41 5f c3 90 0f 1f 44 00 00 41 57 41
> [224913.935932] RSP: 0018:ffff88816271fd38 EFLAGS: 00010206
> [224913.935941] RAX: 0000000000000ae8 RBX: ffff88815acd5240 RCX: dffffc0000000000
> [224913.935948] RDX: 0000000000000003 RSI: 0000000000000ae8 RDI: ffff88815acd5460
> [224913.935954] RBP: ffff88815acd5460 R08: ffffffff955c0ae8 R09: fffffbfff2e6f543
> [224913.935961] R10: ffffffff9737aa17 R11: fffffbfff2e6f542 R12: ffff88815acd5390
> [224913.935967] R13: ffff88815acd5480 R14: ffffffff98d0c080 R15: ffffffff96267500
> [224913.935974] FS:  00007f86e6bd1700(0000) GS:ffff888451cc0000(0000) knlGS:0000000000000000
> [224913.935981] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [224913.935988] CR2: 000000c0008eb000 CR3: 00000001020e0005 CR4: 00000000003706e0
> [224913.935994] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [224913.936000] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [224913.936007] Call Trace:
> [224913.936016]  inet_csk_destroy_sock+0xba/0x1f0
> [224913.936033]  __tcp_close+0x620/0x790
> [224913.936047]  tcp_close+0x20/0x80
> [224913.936056]  inet_release+0x8f/0xf0
> [224913.936070]  __sock_release+0x72/0x120
>
> John Fastabend (3):
>   bpf, sockmap: zap ingress queues after stopping strparser
>   bpf, sockmap: on cleanup we additionally need to remove cached skb
>   bpf, sockmap: fix memleak on ingress msg enqueue
>
>  include/linux/skmsg.h | 54 ++++++++++++++++++++++++++++---------------
>  net/core/skmsg.c      | 37 +++++++++++++++++++++--------
>  2 files changed, 62 insertions(+), 29 deletions(-)

Except for the uninitialized memory read reported by 0-day CI, this
series LGTM. Feel free to add my stamp to v2:

Acked-by: Jakub Sitnicki <jakub@cloudflare.com>
