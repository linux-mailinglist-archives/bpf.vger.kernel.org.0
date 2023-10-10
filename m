Return-Path: <bpf+bounces-11785-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 431F17BF243
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 07:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C7A21C20C8A
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 05:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E2A63A5;
	Tue, 10 Oct 2023 05:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XeYgTckY"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7622591;
	Tue, 10 Oct 2023 05:36:53 +0000 (UTC)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B54A3;
	Mon,  9 Oct 2023 22:36:50 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-57ba5f05395so3252951eaf.1;
        Mon, 09 Oct 2023 22:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696916209; x=1697521009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HxPeL0C+Y3Y/1hk3+9IBpqeI+/GCvB0Z13DTFDfj3zI=;
        b=XeYgTckYI9rVokBrP7Vw3osVqlitW8yy3iORwzCoP/5NmzcA5gmklxMyl5ohvRqk8w
         9jFvO0hTJy3oZLJKhBLbPAWzX0jFPa87wY2dXFviqTUTHNFSFJe3xk7TycZeYVg5VB5l
         l+V7J/dqQNaI8lUx+pAbwHMXHbkA5YPZBdSqXG6WM/cXYQfuxJET/3XqgQ5TNAkcAVca
         lcgAvVOFv8ywyyTGh2WAp6IellQk1kM9KtQB+/jXi+uxgVARGzBuSPwU7ZW9d7aBjTcI
         4nJFh1D2rPvWmkT19aQcgLBNoQAjWm8ZmKqh3f6OnkYwa8vAhAJX9jwILTBADErV2G6A
         qBWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696916209; x=1697521009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HxPeL0C+Y3Y/1hk3+9IBpqeI+/GCvB0Z13DTFDfj3zI=;
        b=LHm0nrW3EyHTDoWr+Ngoc4JCxDbgU2BWH4CASP3xqI7tRuzpzcHZKyzvXcUotezh3h
         HrMA12wzXs+guH7BcbXpPbf2YHEMKNQbTa6VU8Z/1CLUxuhJdlq65VQrUTdRopHQU3jf
         vPaOarqJSvQ3KI3aOTTLfHZRKgNQ5OlEF2Il4OqnOHlpq68MfYyOLcOg/FzKAG90OLvm
         SohmNVCQApwYhb5WguFbssOJQAHoPw+7XwYphV50Xnpgrmd0eblDgLxvgt+jvf4Z6kaB
         mF5lwGOGf1yaSAZGzpDZf5KtOO4rC+NxwUHYD/Ppi4921gotqkohKJpIhSEX2Af+MqM/
         we+Q==
X-Gm-Message-State: AOJu0YyIl7tcs20mWIJjqx8qaqpjY5o6L7W6uOlPtCuRicGVmsyyYiKn
	XJsoRu1YSFGYkLMxUhZY7mw=
X-Google-Smtp-Source: AGHT+IGVITk6ghppGEIR0epCJ9k1ie+8fp1lFE2qEIVc/XhwaoCwdWcUyyRPNHl+Plh8vShoDkbRqQ==
X-Received: by 2002:a05:6358:93a3:b0:135:acfd:8786 with SMTP id h35-20020a05635893a300b00135acfd8786mr18918260rwb.3.1696916209068;
        Mon, 09 Oct 2023 22:36:49 -0700 (PDT)
Received: from pek-lxu-l1.wrs.com ([111.198.228.56])
        by smtp.gmail.com with ESMTPSA id z2-20020a17090a540200b0026b70d2a8a2sm9239963pjh.29.2023.10.09.22.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 22:36:48 -0700 (PDT)
From: Edward AD <twuufnxlz@gmail.com>
To: syzbot+225bfad78b079744fd5e@syzkaller.appspotmail.com
Cc: bpf@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] media: imon: fix stall in worker_thread
Date: Tue, 10 Oct 2023 13:36:41 +0800
Message-ID: <20231010053640.2034061-2-twuufnxlz@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <0000000000003495bf060724994a@google.com>
References: <0000000000003495bf060724994a@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
	HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

syzbot report:
rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 1-....
 } 2682 jiffies s: 16081 root: 0x2/.
rcu: blocking rcu_node structures (internal RCU debug):

Sending NMI from CPU 0 to CPUs 1:
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
NMI backtrace for cpu 1
CPU: 1 PID: 5131 Comm: kworker/1:5 Not tainted 6.6.0-rc4-syzkaller-00012-gce36c8b14987 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
Workqueue: events nsim_dev_trap_report_work
RIP: 0010:io_serial_in+0x76/0xb0 drivers/tty/serial/8250/8250_port.c:417
Code: 60 35 c6 fc 89 e9 41 d3 e6 48 83 c3 40 48 89 d8 48 c1 e8 03 42 80 3c 38 00 74 08 48 89 df e8 51 b1 20 fd 44 03 33 44 89 f2 ec <0f> b6 c0 5b 41 5e 41 5f 5d c3 89 e9 80 e1 07 38 c1 7c ad 48 89 ef
RSP: 0018:ffffc900001efed8 EFLAGS: 00000002
RAX: 1ffffffff2443700 RBX: ffffffff9221bd60 RCX: 0000000000000000
RDX: 00000000000003fd RSI: 0000000000000000 RDI: 0000000000000020
RBP: 0000000000000000 R08: ffffffff84c7d646 R09: 1ffff110039be046
R10: dffffc0000000000 R11: ffffed10039be047 R12: dffffc0000000000
R13: 0000000000002703 R14: 00000000000003fd R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fcd51aff0f0 CR3: 000000000d130000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 serial_in drivers/tty/serial/8250/8250.h:117 [inline]
 serial_lsr_in drivers/tty/serial/8250/8250.h:139 [inline]
 wait_for_lsr drivers/tty/serial/8250/8250_port.c:2089 [inline]
 serial8250_console_fifo_write drivers/tty/serial/8250/8250_port.c:3374 [inline]
 serial8250_console_write+0x110e/0x1820 drivers/tty/serial/8250/8250_port.c:3452
 console_emit_next_record kernel/printk/printk.c:2910 [inline]
 console_flush_all+0x7ff/0xec0 kernel/printk/printk.c:2966
 console_unlock+0x13b/0x4d0 kernel/printk/printk.c:3035
 vprintk_emit+0x508/0x720 kernel/printk/printk.c:2307
 dev_vprintk_emit+0x2ae/0x330 drivers/base/core.c:4849
 dev_printk_emit+0xdd/0x120 drivers/base/core.c:4860
 _dev_warn+0x122/0x170 drivers/base/core.c:4916
 usb_rx_callback_intf0+0x156/0x190 drivers/media/rc/imon.c:1771
 __usb_hcd_giveback_urb+0x371/0x530 drivers/usb/core/hcd.c:1650
 dummy_timer+0x8aa/0x3210 drivers/usb/gadget/udc/dummy_hcd.c:1987
 call_timer_fn+0x17a/0x580 kernel/time/timer.c:1700
 expire_timers kernel/time/timer.c:1751 [inline]
 __run_timers+0x64f/0x860 kernel/time/timer.c:2022
 run_timer_softirq+0x67/0xf0 kernel/time/timer.c:2035
 __do_softirq+0x2ab/0x908 kernel/softirq.c:553
 invoke_softirq kernel/softirq.c:427 [inline]
 __irq_exit_rcu+0xf1/0x1b0 kernel/softirq.c:632
 irq_exit_rcu+0x9/0x20 kernel/softirq.c:644
 sysvec_apic_timer_interrupt+0x95/0xb0 arch/x86/kernel/apic/apic.c:1074
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
RIP: 0010:jhash2 include/linux/jhash.h:129 [inline]
RIP: 0010:hash_stack lib/stackdepot.c:322 [inline]
RIP: 0010:__stack_depot_save+0x64/0x650 lib/stackdepot.c:382
Code: 00 43 8d 34 00 46 8d 34 c5 7b 71 f5 75 83 fe 04 72 70 44 89 f5 44 89 f0 4c 89 fa 03 02 03 6a 04 44 03 72 08 44 89 f7 c1 c7 04 <44> 29 f0 31 c7 41 01 ee 29 fd 89 fb c1 c3 06 31 eb 44 01 f7 89 d9
RSP: 0018:ffffc900043df6b8 EFLAGS: 00000a07
RAX: 00000000062d8798 RBX: 00000000fe584f8b RCX: 00000000838c8150
RDX: ffffc900043df758 RSI: 0000000000000004 RDI: 00000000385a93f7
RBP: 000000006c0b3f46 R08: 000000000000000b R09: ffffffff813da4e7
R10: 0000000000000002 R11: ffff888026631dc0 R12: 0000000000000820
R13: 0000000000000001 R14: 000000007385a93f R15: ffffc900043df710
 kasan_save_stack mm/kasan/common.c:46 [inline]
 kasan_set_track+0x61/0x70 mm/kasan/common.c:52
 __kasan_slab_alloc+0x66/0x70 mm/kasan/common.c:328
 kasan_slab_alloc include/linux/kasan.h:188 [inline]
 slab_post_alloc_hook+0x67/0x3d0 mm/slab.h:762
 slab_alloc_node mm/slub.c:3478 [inline]
 kmem_cache_alloc_node+0x148/0x330 mm/slub.c:3523
 __alloc_skb+0x181/0x420 net/core/skbuff.c:640
 alloc_skb include/linux/skbuff.h:1286 [inline]
 nsim_dev_trap_skb_build drivers/net/netdevsim/dev.c:748 [inline]
 nsim_dev_trap_report drivers/net/netdevsim/dev.c:805 [inline]
 nsim_dev_trap_report_work+0x250/0xa90 drivers/net/netdevsim/dev.c:850
 process_one_work kernel/workqueue.c:2630 [inline]
 process_scheduled_works+0x90f/0x1400 kernel/workqueue.c:2703
 worker_thread+0xa5f/0xff0 kernel/workqueue.c:2784
 kthread+0x2d3/0x370 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
raw-gadget.5 gadget.4: ignoring, device is not running
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored

Invalid protocol requests should not be processed in
usb_rx_callback_intf0().

Reported-and-tested-by: syzbot+225bfad78b079744fd5e@syzkaller.appspotmail.com
Signed-off-by: Edward AD <twuufnxlz@gmail.com>
---
 drivers/media/rc/imon.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/rc/imon.c b/drivers/media/rc/imon.c
index 74546f7e3469..3830fabf113a 100644
--- a/drivers/media/rc/imon.c
+++ b/drivers/media/rc/imon.c
@@ -1770,6 +1770,8 @@ static void usb_rx_callback_intf0(struct urb *urb)
 	default:
 		dev_warn(ictx->dev, "imon %s: status(%d): ignored\n",
 			 __func__, urb->status);
+		if (urb->status == -EPROTO)
+			return;
 		break;
 	}
 
-- 
2.25.1


