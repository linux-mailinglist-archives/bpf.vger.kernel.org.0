Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F0C6CBCB8
	for <lists+bpf@lfdr.de>; Tue, 28 Mar 2023 12:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjC1Kmy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Mar 2023 06:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbjC1Kmw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Mar 2023 06:42:52 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B256184
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 03:42:39 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id h8so47683858ede.8
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 03:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1680000157;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=E67QkEzCNAq47Ml/E7tI+pCsv4ObEgVJOjmaRjPADiI=;
        b=xu3NcJLUNpgyUQzXHi9taAmPBo+H2aI8gVmQcEP6QKGkQ2HEcsIpdQgBGQdRnk5MyW
         +yjq7R2GknuVu0oJMRlNhePhb+gFnPnTrct3ffhofz4eoGYO6BxGweiRFsRRgsEA6LJG
         7cBBwm5WDP4yfeKayokKtl86BSMy+gGPB+/zI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680000157;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E67QkEzCNAq47Ml/E7tI+pCsv4ObEgVJOjmaRjPADiI=;
        b=HJrbDfqv6tfH46OnUeYwJSvoYE/+unvO8guse5U5Fl7Dr47pqbQ6j8ZmLIiDOdJ843
         WHrbsMfr9byCGRzw6XtEIrzwUFVr25E6jsPDrYaiWxaY08RbZQHPs5Lx4eB3eJg3bdYc
         kdsmJJZbsK5qEvvBQ+VHrlKbFtnN6Ay53PaVApStwu5rmLFlmlQqUOjRnyvgsCIq2k/f
         Xrr0+JjgBHpswYm/SF/BzIYlI2/CI7v+0cs1KaWD/VNdHl+L5RRtcGKMOdzmqav3eyhU
         cbXve7nxUHVcnGe4rXl2udbjwhnpHpChnF4eBxuHrmU5lmTRqFHaK3f8dQf9aBCf3LmA
         l+8w==
X-Gm-Message-State: AAQBX9csQB7Fawf/wyO+2Mk7e8IqmIaGiQ7ij2GGM29aMzuz0rwstY0s
        4W+dqwQkHSm64cnk7tVA59Ac4Q==
X-Google-Smtp-Source: AKy350YBl5etg5/17gje+/DGV9caWxDJRdWRcFTJjazHs+7WSosS/63vwpHi+89IBEuVaAHIRRdcmA==
X-Received: by 2002:aa7:c2c8:0:b0:501:cde5:4cc9 with SMTP id m8-20020aa7c2c8000000b00501cde54cc9mr14389480edp.39.1680000157593;
        Tue, 28 Mar 2023 03:42:37 -0700 (PDT)
Received: from cloudflare.com (79.184.147.137.ipv4.supernova.orange.pl. [79.184.147.137])
        by smtp.gmail.com with ESMTPSA id v30-20020a50a45e000000b005021d17d896sm6266731edb.21.2023.03.28.03.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 03:42:37 -0700 (PDT)
References: <20230327175446.98151-1-john.fastabend@gmail.com>
 <20230327175446.98151-2-john.fastabend@gmail.com>
User-agent: mu4e 1.6.10; emacs 28.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     cong.wang@bytedance.com, daniel@iogearbox.net, lmb@isovalent.com,
        edumazet@google.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
        ast@kernel.org, andrii@kernel.org, will@isovalent.com
Subject: Re: [PATCH bpf v2 01/12] bpf: sockmap, pass skb ownership through
 read_skb
Date:   Tue, 28 Mar 2023 12:42:14 +0200
In-reply-to: <20230327175446.98151-2-john.fastabend@gmail.com>
Message-ID: <87y1nh5f8k.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 27, 2023 at 10:54 AM -07, John Fastabend wrote:
> The read_skb hook calls consume_skb() now, but this means that if the
> recv_actor program wants to use the skb it needs to inc the ref cnt
> so that the consume_skb() doesn't kfree the sk_buff.
>
> This is problematic because in some error cases under memory pressure
> we may need to linearize the sk_buff from sk_psock_skb_ingress_enqueue().
> Then we get this,
>
>  skb_linearize()
>    __pskb_pull_tail()
>      pskb_expand_head()
>        BUG_ON(skb_shared(skb))
>
> Because we incremented users refcnt from sk_psock_verdict_recv() we
> hit the bug on with refcnt > 1 and trip it.
>
> To fix lets simply pass ownership of the sk_buff through the skb_read
> call. Then we can drop the consume from read_skb handlers and assume
> the verdict recv does any required kfree.
>
> Bug found while testing in our CI which runs in VMs that hit memory
> constraints rather regularly. William tested TCP read_skb handlers.
>
> [  106.536188] ------------[ cut here ]------------
> [  106.536197] kernel BUG at net/core/skbuff.c:1693!
> [  106.536479] invalid opcode: 0000 [#1] PREEMPT SMP PTI
> [  106.536726] CPU: 3 PID: 1495 Comm: curl Not tainted 5.19.0-rc5 #1
> [  106.537023] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ArchLinux 1.16.0-1 04/01/2014
> [  106.537467] RIP: 0010:pskb_expand_head+0x269/0x330
> [  106.538585] RSP: 0018:ffffc90000138b68 EFLAGS: 00010202
> [  106.538839] RAX: 000000000000003f RBX: ffff8881048940e8 RCX: 0000000000000a20
> [  106.539186] RDX: 0000000000000002 RSI: 0000000000000000 RDI: ffff8881048940e8
> [  106.539529] RBP: ffffc90000138be8 R08: 00000000e161fd1a R09: 0000000000000000
> [  106.539877] R10: 0000000000000018 R11: 0000000000000000 R12: ffff8881048940e8
> [  106.540222] R13: 0000000000000003 R14: 0000000000000000 R15: ffff8881048940e8
> [  106.540568] FS:  00007f277dde9f00(0000) GS:ffff88813bd80000(0000) knlGS:0000000000000000
> [  106.540954] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  106.541227] CR2: 00007f277eeede64 CR3: 000000000ad3e000 CR4: 00000000000006e0
> [  106.541569] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  106.541915] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  106.542255] Call Trace:
> [  106.542383]  <IRQ>
> [  106.542487]  __pskb_pull_tail+0x4b/0x3e0
> [  106.542681]  skb_ensure_writable+0x85/0xa0
> [  106.542882]  sk_skb_pull_data+0x18/0x20
> [  106.543084]  bpf_prog_b517a65a242018b0_bpf_skskb_http_verdict+0x3a9/0x4aa9
> [  106.543536]  ? migrate_disable+0x66/0x80
> [  106.543871]  sk_psock_verdict_recv+0xe2/0x310
> [  106.544258]  ? sk_psock_write_space+0x1f0/0x1f0
> [  106.544561]  tcp_read_skb+0x7b/0x120
> [  106.544740]  tcp_data_queue+0x904/0xee0
> [  106.544931]  tcp_rcv_established+0x212/0x7c0
> [  106.545142]  tcp_v4_do_rcv+0x174/0x2a0
> [  106.545326]  tcp_v4_rcv+0xe70/0xf60
> [  106.545500]  ip_protocol_deliver_rcu+0x48/0x290
> [  106.545744]  ip_local_deliver_finish+0xa7/0x150
>
> Fixes: 04919bed948dc ("tcp: Introduce tcp_read_skb()")
> Reported-by: William Findlay <will@isovalent.com>
> Tested-by: William Findlay <will@isovalent.com>
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
