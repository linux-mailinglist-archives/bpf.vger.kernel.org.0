Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C2560F58F
	for <lists+bpf@lfdr.de>; Thu, 27 Oct 2022 12:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235128AbiJ0KnC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Oct 2022 06:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235363AbiJ0KnA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Oct 2022 06:43:00 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB248C4C01
        for <bpf@vger.kernel.org>; Thu, 27 Oct 2022 03:42:55 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id kt23so3259711ejc.7
        for <bpf@vger.kernel.org>; Thu, 27 Oct 2022 03:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=UwEt8hRfxBB3NsnqWA2tuJg62l5Ro/EJbAIyFX7nsVg=;
        b=k/M3KXUouLzOK6E+ZKDebmVdbz1B/R9oNhE+1JY0AsP1xq8zxD0P/gtEwwDMiF0jqA
         gH0V9J/Q5aqs3sw9U0cMMV7iW76NeJCtaz4F4IMsmKaoYo9TtbLmHT1gwYHSPxN5jcDp
         ABAmUmitIZPaCAZsM+XLOWz/VZBQvx18DOajs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UwEt8hRfxBB3NsnqWA2tuJg62l5Ro/EJbAIyFX7nsVg=;
        b=Yl+HB1z0WxGayASexQ87VmwprrHf0sqSS4izWNRegFe5zaECikNzhaG+lRBgki7fw1
         l8f1LZEUVp6MY19GDarfsgLFxM2hLad0qcCKwP9a/XpBlC59EDtEDj+v6jjU3rvMKTpz
         iNiLdL8G6ZiZ2b1cjtcRoKluez8R0YrPNuMANPfEdUlM51NPMG2H0dydVI1RXLoFxn1T
         UWZVp2yhz46uUDSoYsnDi+/XDNFermlut3Genl/RPY44Oi9tQgtPXxp49AmoduffFqKh
         NhQ4Cj1dCeGn0mKf8aNxgQb7P0Z65a7z4U81k/F0C0b8rfaepU2/R/6yctjMDlyAc0wk
         JcIA==
X-Gm-Message-State: ACrzQf0f1zm7xtIq0S++DJBosCWKl0h20Yevxay6MzWQXZsvPdKyTJgr
        xcJ8nnZHmXOJuDkoehs7U+AcCQ==
X-Google-Smtp-Source: AMsMyM7NgJ6qWZsUhdDKX6FuzlAJ7oxoyy1aWJCu9RM6EtLnbDiHyBLL+J4K5aw6keskc9hoqusN5g==
X-Received: by 2002:a17:907:7627:b0:78d:b6f5:9f15 with SMTP id jy7-20020a170907762700b0078db6f59f15mr42238305ejc.149.1666867374263;
        Thu, 27 Oct 2022 03:42:54 -0700 (PDT)
Received: from cloudflare.com (79.191.56.44.ipv4.supernova.orange.pl. [79.191.56.44])
        by smtp.gmail.com with ESMTPSA id b18-20020aa7cd12000000b004588ef795easm786815edw.34.2022.10.27.03.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 03:42:53 -0700 (PDT)
References: <20220823133755.314697-1-liujian56@huawei.com>
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
Date:   Thu, 27 Oct 2022 12:36:43 +0200
In-reply-to: <20220823133755.314697-1-liujian56@huawei.com>
Message-ID: <874jvpim37.fsf@cloudflare.com>
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

Liu, John,

On Tue, Aug 23, 2022 at 09:37 PM +08, Liu Jian wrote:
> If the sock is dead, do not access sock's sk_wq in sk_stream_wait_memory
>
> v1->v2:
>   As Jakub's suggested, check sock's DEAD flag before accessing
>   the wait queue.
>
> Liu Jian (2):
>   net: If the sock is dead, do not access sock's sk_wq in
>     sk_stream_wait_memory
>   selftests/bpf: Add wait send memory test for sockmap redirect
>
>  net/core/stream.c                          |  3 +-
>  tools/testing/selftests/bpf/test_sockmap.c | 42 ++++++++++++++++++++++
>  2 files changed, 44 insertions(+), 1 deletion(-)

While testing Cong's fix for the dead lock in sk_psock_backlog [1], I've
noticed that this change introduces a memory accounting issue. See
warnings below.

So what I've proposed is not completely sound. We will need to revisit
it.

[1] https://lore.kernel.org/bpf/Y0xJUc%2FLRu8K%2FAf8@pop-os.localdomain/

--8<--
bash-5.1# uname -r
6.0.0-rc3-00892-g3f8ef65af927
bash-5.1# ./test_sockmap
# 1/ 6  sockmap::txmsg test passthrough:OK
# 2/ 6  sockmap::txmsg test redirect:OK
# 3/ 1  sockmap::txmsg test redirect wait send mem:OK
# 4/ 6  sockmap::txmsg test drop:OK
# 5/ 6  sockmap::txmsg test ingress redirect:OK
# 6/ 7  sockmap::txmsg test skb:OK
# 7/ 8  sockmap::txmsg test apply:OK
# 8/12  sockmap::txmsg test cork:OK
[   46.324023] ------------[ cut here ]------------
[   46.325114] WARNING: CPU: 3 PID: 199 at net/core/stream.c:206 sk_stream_kill_queues+0xd6/0xf0
[   46.326573] Modules linked in:
[   46.327105] CPU: 3 PID: 199 Comm: test_sockmap Not tainted 6.0.0-rc3-00892-g3f8ef65af927 #36
[   46.328406] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1.fc35 04/01/2014
[   46.330000] RIP: 0010:sk_stream_kill_queues+0xd6/0xf0
[   46.330816] Code: 29 5b 5d 31 c0 89 c2 89 c6 89 c7 c3 48 89 df e8 10 14 ff ff 8b 83 70 02 00 00 8b b3 28 02 00 00 85 c0 74 d9 0f 0b 85 f6 74 d7 <0f> 0b 5b 5d 31 c0 89 c2 89 c6 89 c7 c3 0f 0b eb 92 66 0f 1f 84 00
[   46.331889] RSP: 0018:ffffc90000bc7d48 EFLAGS: 00010206
[   46.332186] RAX: 0000000000000000 RBX: ffff88810567dc00 RCX: 0000000000000000
[   46.332583] RDX: 0000000000000000 RSI: 0000000000000fc0 RDI: ffff88810567ddb8
[   46.332991] RBP: ffff88810567ddb8 R08: 0000000000000000 R09: 0000000000000000
[   46.333321] R10: 0000000000000000 R11: 0000000000000000 R12: ffff88810567dc00
[   46.333661] R13: ffff888103894500 R14: ffff888101fdf8e0 R15: ffff88810567dd30
[   46.334074] FS:  00007f420a4d8b80(0000) GS:ffff88813bd80000(0000) knlGS:0000000000000000
[   46.334532] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   46.334881] CR2: 00007f420a4d8af8 CR3: 0000000102e17001 CR4: 0000000000370ee0
[   46.335300] Call Trace:
[   46.335444]  <TASK>
[   46.335573]  inet_csk_destroy_sock+0x4f/0x110
[   46.335832]  tcp_rcv_state_process+0xdcf/0x1140
[   46.336076]  ? tcp_v4_do_rcv+0x77/0x2a0
[   46.336299]  tcp_v4_do_rcv+0x77/0x2a0
[   46.336512]  __release_sock+0x58/0xb0
[   46.336721]  __tcp_close+0x186/0x450
[   46.336883]  tcp_close+0x20/0x70
[   46.337026]  inet_release+0x39/0x80
[   46.337177]  __sock_release+0x37/0xa0
[   46.337341]  sock_close+0x14/0x20
[   46.337486]  __fput+0xa2/0x260
[   46.337622]  task_work_run+0x59/0xa0
[   46.337785]  exit_to_user_mode_prepare+0x185/0x190
[   46.337992]  syscall_exit_to_user_mode+0x19/0x40
[   46.338189]  do_syscall_64+0x42/0x90
[   46.338350]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
[   46.338565] RIP: 0033:0x7f420a618eb7
[   46.338741] Code: ff e8 7d e2 01 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 41 c3 48 83 ec 18 89 7c 24 0c e8 43 cd f5 ff
[   46.339596] RSP: 002b:00007ffd54748df8 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
[   46.339944] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f420a618eb7
[   46.340349] RDX: 0000000000000018 RSI: 00007ffd54748d50 RDI: 0000000000000019
[   46.340753] RBP: 00007ffd54748e40 R08: 00007ffd54748d50 R09: 00007ffd54748d50
[   46.341162] R10: 00007ffd54748d50 R11: 0000000000000246 R12: 00007ffd54749118
[   46.341574] R13: 000000000040d0ad R14: 0000000000474df8 R15: 00007f420a769000
[   46.341927]  </TASK>
[   46.342025] irq event stamp: 206385
[   46.342175] hardirqs last  enabled at (206393): [<ffffffff810f1f82>] __up_console_sem+0x52/0x60
[   46.342546] hardirqs last disabled at (206400): [<ffffffff810f1f67>] __up_console_sem+0x37/0x60
[   46.342965] softirqs last  enabled at (206414): [<ffffffff8107bcc5>] __irq_exit_rcu+0xc5/0x120
[   46.343454] softirqs last disabled at (206409): [<ffffffff8107bcc5>] __irq_exit_rcu+0xc5/0x120
[   46.343951] ---[ end trace 0000000000000000 ]---
[   46.344199] ------------[ cut here ]------------
[   46.344421] WARNING: CPU: 3 PID: 199 at net/ipv4/af_inet.c:154 inet_sock_destruct+0x1a0/0x1d0
[   46.344897] Modules linked in:
[   46.345074] CPU: 3 PID: 199 Comm: test_sockmap Tainted: G        W          6.0.0-rc3-00892-g3f8ef65af927 #36
[   46.345549] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1.fc35 04/01/2014
[   46.346028] RIP: 0010:inet_sock_destruct+0x1a0/0x1d0
[   46.346313] Code: ff 49 8b bc 24 60 02 00 00 e8 cc 1e e9 ff 49 8b bc 24 88 00 00 00 5b 41 5c e9 bc 1e e9 ff 41 8b 84 24 28 02 00 00 85 c0 74 ca <0f> 0b eb c6 4c 89 e7 e8 a4 2d e6 ff e9 50 ff ff ff 0f 0b 41 8b 84
[   46.347370] RSP: 0018:ffffc90000bc7e40 EFLAGS: 00010206
[   46.347670] RAX: 0000000000000fc0 RBX: ffff88810567dd60 RCX: 0000000000000000
[   46.348090] RDX: 0000000000000303 RSI: 0000000000000fc0 RDI: ffff88810567dd60
[   46.348495] RBP: ffff88810567dc00 R08: 0000000000000000 R09: 0000000000000000
[   46.348921] R10: 0000000000000000 R11: 0000000000000000 R12: ffff88810567dc00
[   46.349306] R13: ffff8881001d48e0 R14: ffff88810257a3a8 R15: 0000000000000000
[   46.349717] FS:  00007f420a4d8b80(0000) GS:ffff88813bd80000(0000) knlGS:0000000000000000
[   46.350191] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   46.350531] CR2: 00007f420a4d8af8 CR3: 0000000102e17001 CR4: 0000000000370ee0
[   46.350947] Call Trace:
[   46.351098]  <TASK>
[   46.351246]  __sk_destruct+0x23/0x250
[   46.351599]  inet_release+0x39/0x80
[   46.351835]  __sock_release+0x37/0xa0
[   46.352059]  sock_close+0x14/0x20
[   46.352206]  __fput+0xa2/0x260
[   46.352347]  task_work_run+0x59/0xa0
[   46.352515]  exit_to_user_mode_prepare+0x185/0x190
[   46.352728]  syscall_exit_to_user_mode+0x19/0x40
[   46.352954]  do_syscall_64+0x42/0x90
[   46.353119]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
[   46.353342] RIP: 0033:0x7f420a618eb7
[   46.353498] Code: ff e8 7d e2 01 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 41 c3 48 83 ec 18 89 7c 24 0c e8 43 cd f5 ff
[   46.354284] RSP: 002b:00007ffd54748df8 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
[   46.354601] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f420a618eb7
[   46.354908] RDX: 0000000000000018 RSI: 00007ffd54748d50 RDI: 0000000000000019
[   46.355308] RBP: 00007ffd54748e40 R08: 00007ffd54748d50 R09: 00007ffd54748d50
[   46.355710] R10: 00007ffd54748d50 R11: 0000000000000246 R12: 00007ffd54749118
[   46.356117] R13: 000000000040d0ad R14: 0000000000474df8 R15: 00007f420a769000
[   46.356532]  </TASK>
[   46.356664] irq event stamp: 206837
[   46.356873] hardirqs last  enabled at (206847): [<ffffffff810f1f82>] __up_console_sem+0x52/0x60
[   46.357369] hardirqs last disabled at (206854): [<ffffffff810f1f67>] __up_console_sem+0x37/0x60
[   46.357864] softirqs last  enabled at (206604): [<ffffffff8107bcc5>] __irq_exit_rcu+0xc5/0x120
[   46.358358] softirqs last disabled at (206591): [<ffffffff8107bcc5>] __irq_exit_rcu+0xc5/0x120
[   46.358865] ---[ end trace 0000000000000000 ]---
# 9/ 3  sockmap::txmsg test hanging corks:OK
#10/11  sockmap::txmsg test push_data:OK
#11/17  sockmap::txmsg test pull-data:OK
#12/ 9  sockmap::txmsg test pop-data:OK
#13/ 1  sockmap::txmsg test push/pop data:OK
#14/ 1  sockmap::txmsg test ingress parser:OK
#15/ 1  sockmap::txmsg test ingress parser2:OK
#16/ 6 sockhash::txmsg test passthrough:OK
#17/ 6 sockhash::txmsg test redirect:OK
#18/ 1 sockhash::txmsg test redirect wait send mem:OK
#19/ 6 sockhash::txmsg test drop:OK
#20/ 6 sockhash::txmsg test ingress redirect:OK
#21/ 7 sockhash::txmsg test skb:OK
#22/ 8 sockhash::txmsg test apply:OK
#23/12 sockhash::txmsg test cork:OK
#24/ 3 sockhash::txmsg test hanging corks:OK
#25/11 sockhash::txmsg test push_data:OK
#26/17 sockhash::txmsg test pull-data:OK
#27/ 9 sockhash::txmsg test pop-data:OK
#28/ 1 sockhash::txmsg test push/pop data:OK
#29/ 1 sockhash::txmsg test ingress parser:OK
#30/ 1 sockhash::txmsg test ingress parser2:OK
#31/ 6 sockhash:ktls:txmsg test passthrough:OK
#32/ 6 sockhash:ktls:txmsg test redirect:OK
#33/ 1 sockhash:ktls:txmsg test redirect wait send mem:OK
#34/ 6 sockhash:ktls:txmsg test drop:OK
#35/ 6 sockhash:ktls:txmsg test ingress redirect:OK
#36/ 7 sockhash:ktls:txmsg test skb:OK
#37/ 8 sockhash:ktls:txmsg test apply:OK
#38/12 sockhash:ktls:txmsg test cork:OK
#39/ 3 sockhash:ktls:txmsg test hanging corks:OK
#40/11 sockhash:ktls:txmsg test push_data:OK
#41/17 sockhash:ktls:txmsg test pull-data:OK
#42/ 9 sockhash:ktls:txmsg test pop-data:OK
#43/ 1 sockhash:ktls:txmsg test push/pop data:OK
#44/ 1 sockhash:ktls:txmsg test ingress parser:OK
#45/ 0 sockhash:ktls:txmsg test ingress parser2:OK
Pass: 45 Fail: 0
bash-5.1# [   61.124444] ------------[ cut here ]------------
[   61.125177] page_counter underflow: -15 nr_pages=33
[   61.125905] WARNING: CPU: 2 PID: 50 at mm/page_counter.c:56 page_counter_uncharge+0x6b/0x80
[   61.127071] Modules linked in:
[   61.127508] CPU: 2 PID: 50 Comm: kworker/2:1 Tainted: G        W          6.0.0-rc3-00892-g3f8ef65af927 #36
[   61.128638] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1.fc35 04/01/2014
[   61.129582] Workqueue: events bpf_prog_free_deferred
[   61.130148] RIP: 0010:page_counter_uncharge+0x6b/0x80
[   61.130736] Code: 5c 31 d2 89 d6 89 d7 41 89 d0 c3 80 3d 84 14 d7 01 00 75 18 48 89 ea 48 c7 c7 98 4f 2c 82 c6 05 71 14 d7 01 01 e8 dd 6f 74 00 <0f> 0b 48 c7 03 00 00 00 00 45 31 c0 eb b1 0f 1f 80 00 00 00 00 0f
[   61.132430] RSP: 0018:ffffc900002cfd60 EFLAGS: 00010046
[   61.132896] RAX: 0000000000000000 RBX: ffff888100280120 RCX: 0000000000000000
[   61.133439] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[   61.133898] RBP: 0000000000000021 R08: 0000000000000000 R09: 0000000000000000
[   61.134393] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffffffffffdf
[   61.134890] R13: ffff888100280000 R14: 0000000000000001 R15: ffff888101d8a140
[   61.135382] FS:  0000000000000000(0000) GS:ffff88813bd00000(0000) knlGS:0000000000000000
[   61.135939] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   61.136337] CR2: 000055e7f27926f0 CR3: 0000000002835006 CR4: 0000000000370ee0
[   61.136721] Call Trace:
[   61.136880]  <TASK>
[   61.137043]  drain_stock+0x3b/0x70
[   61.137285]  refill_stock+0x89/0x150
[   61.137547]  refill_obj_stock+0x220/0x340
[   61.137845]  ? __bpf_prog_free+0x44/0x60
[   61.138134]  kfree+0x11e/0x540
[   61.138304]  __bpf_prog_free+0x44/0x60
[   61.138533]  process_one_work+0x238/0x570
[   61.138837]  ? process_one_work+0x570/0x570
[   61.139133]  worker_thread+0x55/0x3c0
[   61.139394]  ? process_one_work+0x570/0x570
[   61.139635]  kthread+0xea/0x110
[   61.139821]  ? kthread_complete_and_exit+0x20/0x20
[   61.140098]  ret_from_fork+0x1f/0x30
[   61.140315]  </TASK>
[   61.140440] irq event stamp: 241492
[   61.140616] hardirqs last  enabled at (241491): [<ffffffff8130a1b6>] memcg_account_kmem+0x46/0x70
[   61.141067] hardirqs last disabled at (241492): [<ffffffff81309c0a>] refill_stock+0xea/0x150
[   61.141558] softirqs last  enabled at (241024): [<ffffffff811497b6>] css_release_work_fn+0xc6/0x2a0
[   61.142054] softirqs last disabled at (241022): [<ffffffff81149799>] css_release_work_fn+0xa9/0x2a0
[   61.142551] ---[ end trace 0000000000000000 ]---

bash-5.1#
