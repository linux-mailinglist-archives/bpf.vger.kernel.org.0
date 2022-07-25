Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10ABC580341
	for <lists+bpf@lfdr.de>; Mon, 25 Jul 2022 19:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236479AbiGYREQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Jul 2022 13:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236106AbiGYREQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Jul 2022 13:04:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F3339DF46
        for <bpf@vger.kernel.org>; Mon, 25 Jul 2022 10:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658768654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WJFOsbX7Y6G6QdsXNVWpRKxVeYxDV/FgyKKB3FpHFo4=;
        b=J86hHy9rkN7414glsslG68JbCBkqRERDu/NjVGUY60GRz9wUu/F57svOuMr5H77BBWAx2C
        gyy8WvevCApxPJyjV/Civ0UGOfMCAtqqNiGnVrKnw+iowMaub8B4aSsxrXA/4Q5xxoZKxi
        LEr1VC4cdZJfFKLJtnUBiPJejhuHk2o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-196-IFnLB8BoO8KIkdxEO45HKA-1; Mon, 25 Jul 2022 13:04:13 -0400
X-MC-Unique: IFnLB8BoO8KIkdxEO45HKA-1
Received: by mail-wm1-f72.google.com with SMTP id v18-20020a05600c215200b003a2fea66b7cso4306583wml.4
        for <bpf@vger.kernel.org>; Mon, 25 Jul 2022 10:04:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=WJFOsbX7Y6G6QdsXNVWpRKxVeYxDV/FgyKKB3FpHFo4=;
        b=2xJ6LZO1nc8o7Wjelu5sFmPnm8U5U7VYbTGd4xDL2rWRZCWRTsfhWJIkpO/Rq7fbcF
         gnNaFBNBGSRZPlIyRiX8GWydr3hxJIWvkx43a8/MbZtA/l9+21P4rH/obsSCJMQxq9ft
         x/TFGYxC035g7tdCiWfm/hD+SHbH2VbKvw4yzIPvvZZtvHd+aGPfCgEUa28UwumUW4YP
         ClyEKBkoF0lrrKIbdG1WxVLLc4iOv4Zmtq9TV3SX3sCkJBQh9qEIF//jWwctMU7SNoZm
         5Yc7wfNJgXvGwE0avS04sY5m1ywrwVH/dLEDfjj1nDlRYXBpypnmFFPsffNzSgTo5/kZ
         LF2g==
X-Gm-Message-State: AJIora96trmhuI3UpqNLUd1LvMoiyk7fM3t0wgRLQajgaEDHSkJPBLyU
        JYzvIShFynZhfZjQP8oHv7yIzVN3ImZxaSPVHcws/wiTIVxRL6Jp75HfHvFbclCiHRVthuqFzut
        tTvAfT4RnUrts
X-Received: by 2002:adf:f88c:0:b0:21e:6d3a:d75c with SMTP id u12-20020adff88c000000b0021e6d3ad75cmr8004215wrp.491.1658768649054;
        Mon, 25 Jul 2022 10:04:09 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sX0JZrFUaWccExNmmino4nmaQ/B0dbaRWmsBvQsM+Eb1iXBEt8fzUySU0LwAxFAAMh2EwFGQ==
X-Received: by 2002:adf:f88c:0:b0:21e:6d3a:d75c with SMTP id u12-20020adff88c000000b0021e6d3ad75cmr8004174wrp.491.1658768648443;
        Mon, 25 Jul 2022 10:04:08 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-104-164.dyn.eolo.it. [146.241.104.164])
        by smtp.gmail.com with ESMTPSA id h8-20020a05600c28c800b003a02f957245sm19101253wmd.26.2022.07.25.10.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 10:04:07 -0700 (PDT)
Message-ID: <25344a46ec6e8c2a7a58141dcd3a2c1ba3c4e961.camel@redhat.com>
Subject: Re: WARNING in inet_sock_destruct
From:   Paolo Abeni <pabeni@redhat.com>
To:     Dipanjan Das <mail.dipanjan.das@gmail.com>, davem@davemloft.net,
        yoshfuji@linux-ipv6.org, dsahern@kernel.org, edumazet@google.com,
        kuba@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     syzkaller@googlegroups.com, fleischermarius@googlemail.com,
        its.priyanka.bose@gmail.com
Date:   Mon, 25 Jul 2022 19:04:06 +0200
In-Reply-To: <CANX2M5YATwY79MLsKLahgv03RMGyDZsQDcnPCWkBz6ALe1VDuQ@mail.gmail.com>
References: <CANX2M5YATwY79MLsKLahgv03RMGyDZsQDcnPCWkBz6ALe1VDuQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

On Fri, 2022-07-22 at 08:22 -0700, Dipanjan Das wrote:
> We would like to report the following bug which has been found by our
> modified version of syzkaller.
> 
> ======================================================
> description: WARNING in inet_sock_destruct
> affected file: net/ipv4/af_inet.c
> kernel version: 5.19-rc6
> kernel commit: 32346491ddf24599decca06190ebca03ff9de7f8
> git tree: upstream
> kernel config: https://syzkaller.appspot.com/text?tag=KernelConfig&x=cd73026ceaed1402
> crash reproducer: attached
> ======================================================
> Crash log:
> ======================================================
> WARNING: CPU: 1 PID: 10818 at net/ipv4/af_inet.c:153
> inet_sock_destruct+0x6d0/0x8e0 net/ipv4/af_inet.c:153
> Modules linked in: uio_ivshmem(OE) uio(E)
> CPU: 1 PID: 10818 Comm: kworker/1:16 Tainted: G           OE
> 5.19.0-rc6-g2eae0556bb9d #2
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.13.0-1ubuntu1.1 04/01/2014
> Workqueue: events mptcp_worker
> RIP: 0010:inet_sock_destruct+0x6d0/0x8e0 net/ipv4/af_inet.c:153
> Code: 21 02 00 00 41 8b 9c 24 28 02 00 00 e9 07 ff ff ff e8 34 4d 91
> f9 89 ee 4c 89 e7 e8 4a 47 60 ff e9 a6 fc ff ff e8 20 4d 91 f9 <0f> 0b
> e9 84 fe ff ff e8 14 4d 91 f9 0f 0b e9 d4 fd ff ff e8 08 4d
> RSP: 0018:ffffc9001b35fa78 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 00000000002879d0 RCX: ffff8881326f3b00
> RDX: 0000000000000000 RSI: ffff8881326f3b00 RDI: 0000000000000002
> RBP: ffff888179662674 R08: ffffffff87e983a0 R09: 0000000000000000
> R10: 0000000000000005 R11: 00000000000004ea R12: ffff888179662400
> R13: ffff888179662428 R14: 0000000000000001 R15: ffff88817e38e258
> FS:  0000000000000000(0000) GS:ffff8881f5f00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020007bc0 CR3: 0000000179592000 CR4: 0000000000150ee0
> Call Trace:
>  <TASK>
>  __sk_destruct+0x4f/0x8e0 net/core/sock.c:2067
>  sk_destruct+0xbd/0xe0 net/core/sock.c:2112
>  __sk_free+0xef/0x3d0 net/core/sock.c:2123
>  sk_free+0x78/0xa0 net/core/sock.c:2134
>  sock_put include/net/sock.h:1927 [inline]
>  __mptcp_close_ssk+0x50f/0x780 net/mptcp/protocol.c:2351
>  __mptcp_destroy_sock+0x332/0x760 net/mptcp/protocol.c:2828
>  mptcp_worker+0x5d2/0xc90 net/mptcp/protocol.c:2586
>  process_one_work+0x9cc/0x1650 kernel/workqueue.c:2289
>  worker_thread+0x623/0x1070 kernel/workqueue.c:2436
>  kthread+0x2e9/0x3a0 kernel/kthread.c:376
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
>  </TASK>

It looks like this is an mptcp-specific issue. I'll try to cook a
patch. Please cc (also) the mptcp ML for this kind (you see and mptcp-
related symbol into the stack trace) of reports, thanks!

Paolo

