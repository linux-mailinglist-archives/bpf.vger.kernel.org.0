Return-Path: <bpf+bounces-5660-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EB375D823
	for <lists+bpf@lfdr.de>; Sat, 22 Jul 2023 02:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DDC12824C2
	for <lists+bpf@lfdr.de>; Sat, 22 Jul 2023 00:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E1C38B;
	Sat, 22 Jul 2023 00:21:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABB7364;
	Sat, 22 Jul 2023 00:21:14 +0000 (UTC)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609C92106;
	Fri, 21 Jul 2023 17:21:12 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bb84194bf3so79155ad.3;
        Fri, 21 Jul 2023 17:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689985272; x=1690590072;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=37jHSLFgAqYIe1fMBFWz3IsmA+NfaKZptfwfcm9yo38=;
        b=Gs4eA0UV6HBbwJ5hg2BaRyy4uj1qAHyXIBoAkpZE2YrJeKb7/vmAvHyckS7UKpc+Gp
         UPpn9pTN0PAD9YyPyyjzN1fKq1JG+V/Q6Lw9S6GDcfBl4ue7lrPfx5pKv+WjYZXNRGdz
         MGn7sBGlJL1jrve4jBXcVJT++IKNqtq4eFPyVVC0gAGLg4VfjIdDb0AT6OHO5fKldUh5
         3wMu0hTiq4yRl1XorhU82JomavcoCtdriR7o6+AR+6zi12yIidoya/lhEphgFFyNGe6h
         JcX1lumhX9XpjK+wcL6CpMosMvsueJGE7pkVO05sDvFNo5K35AsFhnqXaYALyvtxrZtf
         5PVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689985272; x=1690590072;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=37jHSLFgAqYIe1fMBFWz3IsmA+NfaKZptfwfcm9yo38=;
        b=aaN8f6HzCA/uG2rgidHdcqxzf5Exo4VOOqeo3j0BS/2nXfrfd3TXWgDeJYWu/G0kkF
         hjPQHw2JJ3VE7KAIVLbcxkR6PYcFr8QhYs5G01GzEZWskmEx4MYn/Frvp01id+rvqZ03
         Hu9t6cWLvYaDQkaNWCWA5P+kDTB5ILwIyX+l6Zv3klHFNzQgwmGX6JH0b+xjmV7F3TcR
         0/REywPxptTKFLeGg0cq46wQegZznAUrCPDnKNohRrAc02/+89LA7GsINmb3G4oWuVm0
         0LePYi0OHaN+1hQZwP9OCDJoQEYAJX+K9Mgxn/Vba3H198lraoBTxoTfTZ0TgqTFskaj
         1viQ==
X-Gm-Message-State: ABy/qLad1/r7vSJtn4osmaLVIucZU3GHMq34lESgQJlpODMq563DF8Mt
	ztn1p/hGHzIr8/4e3roTR+o=
X-Google-Smtp-Source: APBJJlFvUvUbyqctdEaJWp5LBniOVhPH/oTRiWJPqf9VtejwknXrcf8LT+ovNOvfvX58H50aeKfJAw==
X-Received: by 2002:a17:903:22c6:b0:1b8:41d4:89f with SMTP id y6-20020a17090322c600b001b841d4089fmr3385302plg.4.1689985271597;
        Fri, 21 Jul 2023 17:21:11 -0700 (PDT)
Received: from [192.168.0.104] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id u3-20020a170902b28300b001b8a897cd26sm4070032plr.195.2023.07.21.17.21.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 17:21:11 -0700 (PDT)
Message-ID: <7e3841ce-011d-5ba6-9dae-7b14e07b5c4b@gmail.com>
Date: Sat, 22 Jul 2023 07:21:05 +0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: Juergen Gross <jgross@suse.com>, Jan Beulich <jbeulich@suse.com>,
 "David S. Miller" <davem@davemloft.net>, sander44 <ionut_n2001@yahoo.com>
Cc: Linux Xen <xen-devel@lists.xenproject.org>,
 Linux BPF <bpf@vger.kernel.org>, Linux Networking <netdev@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Regressions <regressions@lists.linux.dev>
From: Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: UBSAN: index 1 is out of range for type
 'xen_netif_rx_sring_entry [1]'
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

I notice a regression report on Bugzilla [1]. Quoting from it:

> Hi Kernel Team,
> 
> I rebuild today latest version from mainline repo.
> And i notice issue regarding xen-netfront.c.
> 
> Error:
> [    3.477400] ================================================================================
> [    3.477633] UBSAN: array-index-out-of-bounds in drivers/net/xen-netfront.c:1291:3
> [    3.477858] index 1 is out of range for type 'xen_netif_rx_sring_entry [1]'
> [    3.478085] CPU: 0 PID: 700 Comm: NetworkManager Not tainted 6.5.0-rc2-1-generation1 #3
> [    3.478088] Hardware name: Intel Corporation W2600CR/W2600CR, BIOS SE5C600.86B.02.06.0007.082420181029 01/13/2022
> [    3.478090] Call Trace:
> [    3.478092]  <IRQ>
> [    3.478097]  dump_stack_lvl+0x48/0x70
> [    3.478105]  dump_stack+0x10/0x20
> [    3.478107]  __ubsan_handle_out_of_bounds+0xc6/0x110
> [    3.478114]  xennet_poll+0xa94/0xac0
> [    3.478118]  ? generic_smp_call_function_single_interrupt+0x13/0x20
> [    3.478125]  __napi_poll+0x33/0x200
> [    3.478131]  net_rx_action+0x181/0x2e0
> [    3.478135]  __do_softirq+0xd9/0x346
> [    3.478139]  do_softirq.part.0+0x41/0x80
> [    3.478144]  </IRQ>
> [    3.478145]  <TASK>
> [    3.478146]  __local_bh_enable_ip+0x72/0x80
> [    3.478149]  _raw_spin_unlock_bh+0x1d/0x30
> [    3.478151]  xennet_open+0x75/0x160
> [    3.478154]  __dev_open+0x105/0x1d0
> [    3.478156]  __dev_change_flags+0x1b5/0x230
> [    3.478158]  dev_change_flags+0x27/0x80
> [    3.478160]  do_setlink+0x3d2/0x12b0
> [    3.478164]  ? __nla_validate_parse+0x5b/0xdb0
> [    3.478169]  __rtnl_newlink+0x6f6/0xb10
> [    3.478173]  ? rtnl_newlink+0x2f/0x80
> [    3.478177]  rtnl_newlink+0x48/0x80
> [    3.478180]  rtnetlink_rcv_msg+0x170/0x430
> [    3.478183]  ? fib6_clean_node+0xad/0x190
> [    3.478188]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
> [    3.478191]  netlink_rcv_skb+0x5d/0x110
> [    3.478195]  rtnetlink_rcv+0x15/0x30
> [    3.478198]  netlink_unicast+0x247/0x390
> [    3.478200]  netlink_sendmsg+0x25e/0x4e0
> [    3.478202]  sock_sendmsg+0xaf/0xc0
> [    3.478204]  ____sys_sendmsg+0x2a9/0x350
> [    3.478206]  ___sys_sendmsg+0x9a/0xf0
> [    3.478212]  ? _copy_from_iter+0x80/0x4a0
> [    3.478217]  __sys_sendmsg+0x89/0xf0
> [    3.478220]  __x64_sys_sendmsg+0x1d/0x30
> [    3.478222]  do_syscall_64+0x5c/0x90
> [    3.478226]  ? do_syscall_64+0x68/0x90
> [    3.478228]  ? ksys_write+0xe6/0x100
> [    3.478232]  ? exit_to_user_mode_prepare+0x49/0x220
> [    3.478236]  ? syscall_exit_to_user_mode+0x1b/0x50
> [    3.478240]  ? do_syscall_64+0x68/0x90
> [    3.478242]  ? do_syscall_64+0x68/0x90
> [    3.478243]  ? irqentry_exit_to_user_mode+0x9/0x30
> [    3.478246]  ? irqentry_exit+0x43/0x50
> [    3.478248]  ? sysvec_xen_hvm_callback+0x4b/0xd0
> [    3.478250]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [    3.478253] RIP: 0033:0x7f973c244e4d
> [    3.478268] Code: 28 89 54 24 1c 48 89 74 24 10 89 7c 24 08 e8 ca ee ff ff 8b 54 24 1c 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 33 44 89 c7 48 89 44 24 08 e8 fe ee ff ff 48
> [    3.478270] RSP: 002b:00007fff4777f470 EFLAGS: 00000293 ORIG_RAX: 000000000000002e
> [    3.478273] RAX: ffffffffffffffda RBX: 00005583087c6480 RCX: 00007f973c244e4d
> [    3.478274] RDX: 0000000000000000 RSI: 00007fff4777f4c0 RDI: 000000000000000c
> [    3.478276] RBP: 00007fff4777f4c0 R08: 0000000000000000 R09: 0000000000000000
> [    3.478277] R10: 0000000000000000 R11: 0000000000000293 R12: 00005583087c6480
> [    3.478279] R13: 00007fff4777f668 R14: 00007fff4777f65c R15: 0000000000000000
> [    3.478283]  </TASK>
> [    3.478284] ================================================================================
> [    3.685513] ================================================================================
> [    3.685751] UBSAN: array-index-out-of-bounds in drivers/net/xen-netfront.c:485:7
> [    3.686111] index 1 is out of range for type 'xen_netif_tx_sring_entry [1]'
> [    3.686379] CPU: 1 PID: 697 Comm: avahi-daemon Not tainted 6.5.0-rc2-1-generation1 #3
> [    3.686381] Hardware name: Intel Corporation W2600CR/W2600CR, BIOS SE5C600.86B.02.06.0007.082420181029 01/13/2022
> [    3.686385] Call Trace:
> [    3.686388]  <TASK>
> [    3.686391]  dump_stack_lvl+0x48/0x70
> [    3.686399]  dump_stack+0x10/0x20
> [    3.686399]  __ubsan_handle_out_of_bounds+0xc6/0x110
> [    3.686403]  xennet_tx_setup_grant+0x1f7/0x230
> [    3.686403]  ? __pfx_xennet_tx_setup_grant+0x10/0x10
> [    3.686403]  gnttab_foreach_grant_in_range+0x5c/0x100
> [    3.686415]  xennet_start_xmit+0x428/0x990
> [    3.686415]  ? kmem_cache_alloc_node+0x1b1/0x3b0
> [    3.686415]  dev_hard_start_xmit+0x68/0x1e0
> [    3.686415]  sch_direct_xmit+0x10b/0x350
> [    3.686415]  __dev_queue_xmit+0x512/0xda0
> [    3.686439]  ? ___neigh_create+0x6cb/0x970
> [    3.686439]  neigh_resolve_output+0x118/0x1e0
> [    3.686446]  ip_finish_output2+0x181/0x540
> [    3.686450]  ? netif_rx_internal+0x46/0x140
> [    3.686456]  __ip_finish_output+0xb6/0x180
> [    3.686456]  ? dev_loopback_xmit+0x86/0x110
> [    3.686456]  ip_finish_output+0x29/0x100
> [    3.686456]  ip_mc_output+0x95/0x2e0
> [    3.686456]  ? __pfx_ip_finish_output+0x10/0x10
> [    3.686456]  ip_send_skb+0x9f/0xb0
> [    3.686456]  udp_send_skb+0x158/0x380
> [    3.686475]  udp_sendmsg+0xb84/0xf20
> [    3.686475]  ? do_sys_poll+0x3a1/0x5f0
> [    3.686483]  ? __pfx_ip_generic_getfrag+0x10/0x10
> [    3.686483]  inet_sendmsg+0x76/0x80
> [    3.686483]  ? inet_sendmsg+0x76/0x80
> [    3.686483]  sock_sendmsg+0xa8/0xc0
> [    3.686483]  ? _copy_from_user+0x30/0xa0
> [    3.686483]  ____sys_sendmsg+0x2a9/0x350
> [    3.686483]  ___sys_sendmsg+0x9a/0xf0
> [    3.686483]  __sys_sendmsg+0x89/0xf0
> [    3.686483]  __x64_sys_sendmsg+0x1d/0x30
> [    3.686483]  do_syscall_64+0x5c/0x90
> [    3.686483]  ? exit_to_user_mode_prepare+0x49/0x220
> [    3.686483]  ? syscall_exit_to_user_mode+0x1b/0x50
> [    3.686483]  ? do_syscall_64+0x68/0x90
> [    3.686483]  ? syscall_exit_to_user_mode+0x1b/0x50
> [    3.686483]  ? do_syscall_64+0x68/0x90
> [    3.686483]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [    3.686483] RIP: 0033:0x7ff365942e13
> [    3.686483] Code: 8b 15 b9 a1 00 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 28 89 54 24 1c 48
> [    3.686483] RSP: 002b:00007ffc7bf1ca78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> [    3.686483] RAX: ffffffffffffffda RBX: 00005596bd24c900 RCX: 00007ff365942e13
> [    3.686483] RDX: 0000000000000000 RSI: 00007ffc7bf1cb30 RDI: 000000000000000c
> [    3.686483] RBP: 000000000000000c R08: 0000000000000004 R09: 0000000000000019
> [    3.686483] R10: 00007ff365a1ca94 R11: 0000000000000246 R12: 00007ffc7bf1cb30
> [    3.686483] R13: 0000000000000002 R14: 00005596bd235f9c R15: 0000000000000000
> [    3.686483]  </TASK>
> [    3.686483] ================================================================================
> [    3.686858] ================================================================================
> [    3.687190] UBSAN: array-index-out-of-bounds in drivers/net/xen-netfront.c:413:4
> [    3.687501] index 1 is out of range for type 'xen_netif_tx_sring_entry [1]'
> [    3.687800] CPU: 18 PID: 0 Comm: swapper/18 Not tainted 6.5.0-rc2-1-generation1 #3
> [    3.687804] Hardware name: Intel Corporation W2600CR/W2600CR, BIOS SE5C600.86B.02.06.0007.082420181029 01/13/2022
> [    3.687806] Call Trace:
> [    3.687808]  <IRQ>
> [    3.687812]  dump_stack_lvl+0x48/0x70
> [    3.687819]  dump_stack+0x10/0x20
> [    3.687821]  __ubsan_handle_out_of_bounds+0xc6/0x110
> [    3.687827]  xennet_tx_buf_gc+0x34a/0x440
> [    3.687831]  xennet_handle_tx.constprop.0+0x49/0x90
> [    3.687834]  xennet_tx_interrupt+0x32/0x70
> [    3.687837]  __handle_irq_event_percpu+0x4f/0x1b0
> [    3.687842]  handle_irq_event+0x39/0x80
> [    3.687846]  handle_edge_irq+0x8c/0x230
> [    3.687849]  handle_irq_desc+0x40/0x60
> [    3.687851]  generic_handle_irq+0x1f/0x30
> [    3.687854]  handle_irq_for_port+0x8e/0x180
> [    3.687858]  ? _raw_spin_unlock_irqrestore+0x11/0x60
> [    3.687861]  __evtchn_fifo_handle_events+0x221/0x330
> [    3.687866]  evtchn_fifo_handle_events+0xe/0x20
> [    3.687869]  __xen_evtchn_do_upcall+0x72/0xd0
> [    3.687873]  xen_hvm_evtchn_do_upcall+0xe/0x20
> [    3.687876]  __sysvec_xen_hvm_callback+0x53/0x70
> [    3.687880]  sysvec_xen_hvm_callback+0x8d/0xd0
> [    3.687884]  </IRQ>
> [    3.687885]  <TASK>
> [    3.687886]  asm_sysvec_xen_hvm_callback+0x1b/0x20
> [    3.687891] RIP: 0010:pv_native_safe_halt+0xb/0x10
> [    3.687896] Code: 0b 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 eb 07 0f 00 2d 49 cc 33 00 fb f4 <c3> cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 55
> [    3.687898] RSP: 0000:ffffad85c0147e08 EFLAGS: 00000246
> [    3.687901] RAX: ffffffffa00d39a0 RBX: 0000000000000002 RCX: 0000000000000000
> [    3.687902] RDX: 0000000000000002 RSI: ffffffffa14d28e0 RDI: ffff920446abda00
> [    3.687904] RBP: ffffad85c0147e18 R08: 0000000000000000 R09: 0000000000000000
> [    3.687905] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000002
> [    3.687906] R13: 0000000000000002 R14: 0000000000000002 R15: ffffffffa14d29c8
> [    3.687909]  ? __pfx_intel_idle_hlt+0x10/0x10
> [    3.687913]  ? intel_idle_hlt+0xc/0x40
> [    3.687916]  cpuidle_enter_state+0xa0/0x730
> [    3.687920]  cpuidle_enter+0x2e/0x50
> [    3.687924]  call_cpuidle+0x23/0x60
> [    3.687928]  do_idle+0x207/0x260
> [    3.687932]  cpu_startup_entry+0x1d/0x20
> [    3.687934]  start_secondary+0x129/0x160
> [    3.687939]  secondary_startup_64_no_verify+0x17e/0x18b
> [    3.687945]  </TASK>
> [    3.687946] ================================================================================
> [    4.624607] bridge: filtering via arp/ip/ip6tables is no longer available by default. Update your scripts to load br_netfilter if you need this.
> [    4.629153] Bridge firewalling registered
> [    4.745355] Initializing XFRM netlink socket
> [    4.794107] loop8: detected capacity change from 0 to 8
> [    7.104544] rfkill: input handler disabled
> [   26.445163] ================================================================================
> [   26.445171] UBSAN: array-index-out-of-bounds in drivers/net/xen-netfront.c:807:4
> [   26.445175] index 109 is out of range for type 'xen_netif_tx_sring_entry [1]'
> [   26.445178] CPU: 8 PID: 1729 Comm: sshd Not tainted 6.5.0-rc2-1-generation1 #3
> [   26.445180] Hardware name: Intel Corporation W2600CR/W2600CR, BIOS SE5C600.86B.02.06.0007.082420181029 01/13/2022
> [   26.445181] Call Trace:
> [   26.445185]  <TASK>
> [   26.445185]  dump_stack_lvl+0x48/0x70
> [   26.445185]  dump_stack+0x10/0x20
> [   26.445200]  __ubsan_handle_out_of_bounds+0xc6/0x110
> [   26.445206]  xennet_start_xmit+0x932/0x990
> [   26.445211]  dev_hard_start_xmit+0x68/0x1e0
> [   26.445216]  sch_direct_xmit+0x10b/0x350
> [   26.445220]  __dev_queue_xmit+0x512/0xda0
> [   26.445224]  ip_finish_output2+0x261/0x540
> [   26.445225]  __ip_finish_output+0xb6/0x180
> [   26.445225]  ip_finish_output+0x29/0x100
> [   26.445234]  ip_output+0x73/0x120
> [   26.445234]  ? __pfx_ip_finish_output+0x10/0x10
> [   26.445238]  ip_local_out+0x61/0x70
> [   26.445238]  __ip_queue_xmit+0x18d/0x470
> [   26.445238]  ip_queue_xmit+0x15/0x30
> [   26.445238]  __tcp_transmit_skb+0xb39/0xcc0
> [   26.445238]  tcp_write_xmit+0x595/0x1570
> [   26.445238]  ? _copy_from_iter+0x80/0x4a0
> [   26.445256]  __tcp_push_pending_frames+0x37/0x110
> [   26.445259]  tcp_push+0x123/0x190
> [   26.445260]  tcp_sendmsg_locked+0xafe/0xed0
> [   26.445264]  tcp_sendmsg+0x2c/0x50
> [   26.445268]  inet_sendmsg+0x42/0x80
> [   26.445268]  sock_write_iter+0x160/0x180
> [   26.445274]  vfs_write+0x397/0x440
> [   26.445274]  ksys_write+0xc9/0x100
> [   26.445274]  __x64_sys_write+0x19/0x30
> [   26.445274]  do_syscall_64+0x5c/0x90
> [   26.445287]  ? syscall_exit_to_user_mode+0x1b/0x50
> [   26.445290]  ? do_syscall_64+0x68/0x90
> [   26.445290]  ? do_syscall_64+0x68/0x90
> [   26.445294]  ? do_syscall_64+0x68/0x90
> [   26.445294]  ? syscall_exit_to_user_mode+0x1b/0x50
> [   26.445298]  ? do_syscall_64+0x68/0x90
> [   26.445300]  ? exc_page_fault+0x94/0x1b0
> [   26.445302]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [   26.445306] RIP: 0033:0x7f26c4c3d473
> [   26.445318] Code: 8b 15 21 2a 0e 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 28 48 89 54 24 18
> [   26.445321] RSP: 002b:00007ffdee7b5528 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> [   26.445321] RAX: ffffffffffffffda RBX: 0000000000000700 RCX: 00007f26c4c3d473
> [   26.445321] RDX: 0000000000000700 RSI: 000055567032e230 RDI: 0000000000000004
> [   26.445321] RBP: 0000555670313d70 R08: fffffffffffffff0 R09: 0000000000000000
> [   26.445321] R10: 0000000000000000 R11: 0000000000000246 R12: 000055566fcb2768
> [   26.445321] R13: 0000000000000000 R14: 0000000000000004 R15: 000055566fc67a80
> [   26.445332]  </TASK>
> [   26.445333] ================================================================================

See Bugzilla for the full thread and attached dmesg.

Anyway, I'm adding it to regzbot:

#regzbot introduced: 8446066bf8c1f9f https://bugzilla.kernel.org/show_bug.cgi?id=217693

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217693

-- 
An old man doll... just what I always wanted! - Clara

