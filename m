Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E013160FC13
	for <lists+bpf@lfdr.de>; Thu, 27 Oct 2022 17:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbiJ0Peh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Oct 2022 11:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236116AbiJ0Pef (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Oct 2022 11:34:35 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B2911476
        for <bpf@vger.kernel.org>; Thu, 27 Oct 2022 08:34:33 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id n12so5659391eja.11
        for <bpf@vger.kernel.org>; Thu, 27 Oct 2022 08:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=6nR7XcB9ZmXi93F9jMzJrl7k6OR8BkMAMebwE3V7of8=;
        b=wuODJXeBFBhUix1cEfXmugee6xxOanaMVdzE/p1cH74Zo7Dzsv3VjnM/WjBUA00a/I
         KX0vyMOd6SzjmPsSYKENlUZIlpKlOGfqdzAAEkZn1QN/xpIma6N2ZRbs/j+yHB+fTsCV
         vaX17AHz8pzOKaHCc2dsOc7+Tpt9fOuobhgDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6nR7XcB9ZmXi93F9jMzJrl7k6OR8BkMAMebwE3V7of8=;
        b=ML+N0YDEdKn0/i5kwgtFYmd6BWq18Iwu1Z6Zes0QTRf+Cr9+zVBgehpvQ09/wGzSa5
         5XaWkaJcMPsj9SDL4/Lc9K/UxWEjSIGhoftAvw/EOfo0C10l47c/g0ZkDnk8L74cVois
         5M4NbXz9v730q3tJy6PPK6nJ+XnDu0ZXPu/WQ+T9a5C14hPYKChTtT1klhqkBaH/2qPk
         jPi6UkkhgSGHkHnVEYPJtpUO5TES5jor/M6Ffe9C1ZIANML7UY4JRKpNNhB/i2zCYQLU
         gXux0sWk4WD6M9wECknIZiMq35b+hznqfcs81MnaDn3bFN9JrHiSKfiMpLLQnrVF2MtD
         1t/Q==
X-Gm-Message-State: ACrzQf3+ItRkA7tVLwTVzColkBWnth/t8IXXZX1uKErEEH3V7Kef4TnW
        BHnla6Cng8mbcLVFNjJns3+9ZQ==
X-Google-Smtp-Source: AMsMyM7nvTRwOmHxDaWWRPv4EIAqvun3fMLioQHpWZeRaejT5XpBcT1HiC6Ms1U8lFc/oAn3DuGEFQ==
X-Received: by 2002:a17:907:2cd8:b0:78e:7fe:a38f with SMTP id hg24-20020a1709072cd800b0078e07fea38fmr43193219ejc.632.1666884871961;
        Thu, 27 Oct 2022 08:34:31 -0700 (PDT)
Received: from cloudflare.com (79.191.56.44.ipv4.supernova.orange.pl. [79.191.56.44])
        by smtp.gmail.com with ESMTPSA id p10-20020a056402500a00b004615e1bbaf4sm1151518eda.87.2022.10.27.08.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 08:34:31 -0700 (PDT)
References: <20220823133755.314697-1-liujian56@huawei.com>
 <874jvpim37.fsf@cloudflare.com>
User-agent: mu4e 1.6.10; emacs 27.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Liu Jian <liujian56@huawei.com>, john.fastabend@gmail.com
Cc:     edumazet@google.com, davem@davemloft.net, yoshfuji@linux-ipv6.org,
        dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com,
        andrii@kernel.org, mykolal@fb.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, shuah@kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 0/2] If the sock is dead, do not access
 sock's sk_wq in sk_stream_wait_memory
Date:   Thu, 27 Oct 2022 17:30:51 +0200
In-reply-to: <874jvpim37.fsf@cloudflare.com>
Message-ID: <87zgdhgu0p.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 27, 2022 at 12:36 PM +02, Jakub Sitnicki wrote:

[...]

> While testing Cong's fix for the dead lock in sk_psock_backlog [1], I've
> noticed that this change introduces a memory accounting issue. See
> warnings below.
>
> So what I've proposed is not completely sound. We will need to revisit
> it.
>
> [1] https://lore.kernel.org/bpf/Y0xJUc%2FLRu8K%2FAf8@pop-os.localdomain/
>
> --8<--
> bash-5.1# uname -r
> 6.0.0-rc3-00892-g3f8ef65af927
> bash-5.1# ./test_sockmap
> # 1/ 6  sockmap::txmsg test passthrough:OK
> # 2/ 6  sockmap::txmsg test redirect:OK
> # 3/ 1  sockmap::txmsg test redirect wait send mem:OK
> # 4/ 6  sockmap::txmsg test drop:OK
> # 5/ 6  sockmap::txmsg test ingress redirect:OK
> # 6/ 7  sockmap::txmsg test skb:OK
> # 7/ 8  sockmap::txmsg test apply:OK
> # 8/12  sockmap::txmsg test cork:OK
> [   46.324023] ------------[ cut here ]------------
> [ 46.325114] WARNING: CPU: 3 PID: 199 at net/core/stream.c:206
> sk_stream_kill_queues+0xd6/0xf0
> [   46.326573] Modules linked in:
> [ 46.327105] CPU: 3 PID: 199 Comm: test_sockmap Not tainted
> 6.0.0-rc3-00892-g3f8ef65af927 #36
> [ 46.328406] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.15.0-1.fc35 04/01/2014
> [   46.330000] RIP: 0010:sk_stream_kill_queues+0xd6/0xf0
> [ 46.330816] Code: 29 5b 5d 31 c0 89 c2 89 c6 89 c7 c3 48 89 df e8 10 14 ff ff
> 8b 83 70 02 00 00 8b b3 28 02 00 00 85 c0 74 d9 0f 0b 85 f6 74 d7 <0f> 0b 5b 5d
> 31 c0 89 c2 89 c6 89 c7 c3 0f 0b eb 92 66 0f 1f 84 00
> [   46.331889] RSP: 0018:ffffc90000bc7d48 EFLAGS: 00010206
> [   46.332186] RAX: 0000000000000000 RBX: ffff88810567dc00 RCX: 0000000000000000
> [   46.332583] RDX: 0000000000000000 RSI: 0000000000000fc0 RDI: ffff88810567ddb8
> [   46.332991] RBP: ffff88810567ddb8 R08: 0000000000000000 R09: 0000000000000000
> [   46.333321] R10: 0000000000000000 R11: 0000000000000000 R12: ffff88810567dc00
> [   46.333661] R13: ffff888103894500 R14: ffff888101fdf8e0 R15: ffff88810567dd30
> [   46.334074] FS:  00007f420a4d8b80(0000) GS:ffff88813bd80000(0000) knlGS:0000000000000000
> [   46.334532] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   46.334881] CR2: 00007f420a4d8af8 CR3: 0000000102e17001 CR4: 0000000000370ee0
> [   46.335300] Call Trace:
> [   46.335444]  <TASK>
> [   46.335573]  inet_csk_destroy_sock+0x4f/0x110
> [   46.335832]  tcp_rcv_state_process+0xdcf/0x1140
> [   46.336076]  ? tcp_v4_do_rcv+0x77/0x2a0
> [   46.336299]  tcp_v4_do_rcv+0x77/0x2a0
> [   46.336512]  __release_sock+0x58/0xb0
> [   46.336721]  __tcp_close+0x186/0x450
> [   46.336883]  tcp_close+0x20/0x70
> [   46.337026]  inet_release+0x39/0x80
> [   46.337177]  __sock_release+0x37/0xa0
> [   46.337341]  sock_close+0x14/0x20
> [   46.337486]  __fput+0xa2/0x260
> [   46.337622]  task_work_run+0x59/0xa0
> [   46.337785]  exit_to_user_mode_prepare+0x185/0x190
> [   46.337992]  syscall_exit_to_user_mode+0x19/0x40
> [   46.338189]  do_syscall_64+0x42/0x90
> [   46.338350]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> [   46.338565] RIP: 0033:0x7f420a618eb7
> [ 46.338741] Code: ff e8 7d e2 01 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 f3
> 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 03 00 00 00 0f 05 <48> 3d 00 f0
> ff ff 77 41 c3 48 83 ec 18 89 7c 24 0c e8 43 cd f5 ff
> [   46.339596] RSP: 002b:00007ffd54748df8 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
> [   46.339944] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f420a618eb7
> [   46.340349] RDX: 0000000000000018 RSI: 00007ffd54748d50 RDI: 0000000000000019
> [   46.340753] RBP: 00007ffd54748e40 R08: 00007ffd54748d50 R09: 00007ffd54748d50
> [   46.341162] R10: 00007ffd54748d50 R11: 0000000000000246 R12: 00007ffd54749118
> [   46.341574] R13: 000000000040d0ad R14: 0000000000474df8 R15: 00007f420a769000
> [   46.341927]  </TASK>
> [   46.342025] irq event stamp: 206385
> [ 46.342175] hardirqs last enabled at (206393): [<ffffffff810f1f82>]
> __up_console_sem+0x52/0x60
> [ 46.342546] hardirqs last disabled at (206400): [<ffffffff810f1f67>]
> __up_console_sem+0x37/0x60
> [ 46.342965] softirqs last enabled at (206414): [<ffffffff8107bcc5>]
> __irq_exit_rcu+0xc5/0x120
> [ 46.343454] softirqs last disabled at (206409): [<ffffffff8107bcc5>]
> __irq_exit_rcu+0xc5/0x120
> [   46.343951] ---[ end trace 0000000000000000 ]---
> [   46.344199] ------------[ cut here ]------------
> [ 46.344421] WARNING: CPU: 3 PID: 199 at net/ipv4/af_inet.c:154
> inet_sock_destruct+0x1a0/0x1d0
> [   46.344897] Modules linked in:
> [ 46.345074] CPU: 3 PID: 199 Comm: test_sockmap Tainted: G W
> 6.0.0-rc3-00892-g3f8ef65af927 #36
> [ 46.345549] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.15.0-1.fc35 04/01/2014
> [   46.346028] RIP: 0010:inet_sock_destruct+0x1a0/0x1d0
> [ 46.346313] Code: ff 49 8b bc 24 60 02 00 00 e8 cc 1e e9 ff 49 8b bc 24 88 00
> 00 00 5b 41 5c e9 bc 1e e9 ff 41 8b 84 24 28 02 00 00 85 c0 74 ca <0f> 0b eb c6
> 4c 89 e7 e8 a4 2d e6 ff e9 50 ff ff ff 0f 0b 41 8b 84
> [   46.347370] RSP: 0018:ffffc90000bc7e40 EFLAGS: 00010206
> [   46.347670] RAX: 0000000000000fc0 RBX: ffff88810567dd60 RCX: 0000000000000000
> [   46.348090] RDX: 0000000000000303 RSI: 0000000000000fc0 RDI: ffff88810567dd60
> [   46.348495] RBP: ffff88810567dc00 R08: 0000000000000000 R09: 0000000000000000
> [   46.348921] R10: 0000000000000000 R11: 0000000000000000 R12: ffff88810567dc00
> [   46.349306] R13: ffff8881001d48e0 R14: ffff88810257a3a8 R15: 0000000000000000
> [   46.349717] FS:  00007f420a4d8b80(0000) GS:ffff88813bd80000(0000) knlGS:0000000000000000
> [   46.350191] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   46.350531] CR2: 00007f420a4d8af8 CR3: 0000000102e17001 CR4: 0000000000370ee0
> [   46.350947] Call Trace:
> [   46.351098]  <TASK>
> [   46.351246]  __sk_destruct+0x23/0x250
> [   46.351599]  inet_release+0x39/0x80
> [   46.351835]  __sock_release+0x37/0xa0
> [   46.352059]  sock_close+0x14/0x20
> [   46.352206]  __fput+0xa2/0x260
> [   46.352347]  task_work_run+0x59/0xa0
> [   46.352515]  exit_to_user_mode_prepare+0x185/0x190
> [   46.352728]  syscall_exit_to_user_mode+0x19/0x40
> [   46.352954]  do_syscall_64+0x42/0x90
> [   46.353119]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> [   46.353342] RIP: 0033:0x7f420a618eb7
> [ 46.353498] Code: ff e8 7d e2 01 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 f3
> 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 03 00 00 00 0f 05 <48> 3d 00 f0
> ff ff 77 41 c3 48 83 ec 18 89 7c 24 0c e8 43 cd f5 ff
> [   46.354284] RSP: 002b:00007ffd54748df8 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
> [   46.354601] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f420a618eb7
> [   46.354908] RDX: 0000000000000018 RSI: 00007ffd54748d50 RDI: 0000000000000019
> [   46.355308] RBP: 00007ffd54748e40 R08: 00007ffd54748d50 R09: 00007ffd54748d50
> [   46.355710] R10: 00007ffd54748d50 R11: 0000000000000246 R12: 00007ffd54749118
> [   46.356117] R13: 000000000040d0ad R14: 0000000000474df8 R15: 00007f420a769000
> [   46.356532]  </TASK>
> [   46.356664] irq event stamp: 206837
> [ 46.356873] hardirqs last enabled at (206847): [<ffffffff810f1f82>]
> __up_console_sem+0x52/0x60
> [ 46.357369] hardirqs last disabled at (206854): [<ffffffff810f1f67>]
> __up_console_sem+0x37/0x60
> [ 46.357864] softirqs last enabled at (206604): [<ffffffff8107bcc5>]
> __irq_exit_rcu+0xc5/0x120
> [ 46.358358] softirqs last disabled at (206591): [<ffffffff8107bcc5>]
> __irq_exit_rcu+0xc5/0x120
> [   46.358865] ---[ end trace 0000000000000000 ]---
> # 9/ 3  sockmap::txmsg test hanging corks:OK

[...]

Actually, we had a fix for these warnings in 9c34e38c4a87 ("bpf,
sockmap: Fix memleak in tcp_bpf_sendmsg while sk msg is full") [1].

But they reappear for me in v5.18-rc1. Trying to bisect what went
wrong...

[1] https://lore.kernel.org/bpf/20220304081145.2037182-3-wangyufen@huawei.com
