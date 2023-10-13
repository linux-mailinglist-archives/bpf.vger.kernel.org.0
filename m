Return-Path: <bpf+bounces-12135-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2513A7C83D7
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 12:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DE65B20979
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 10:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89A1134AD;
	Fri, 13 Oct 2023 10:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MA7IdydB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B44E11720;
	Fri, 13 Oct 2023 10:59:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35844C433C9;
	Fri, 13 Oct 2023 10:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697194754;
	bh=xpY34OnoUOumz2tisrgcB13L7F/cK2GUTthY+74xzEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MA7IdydB9XMBk9sMLEkSwxGQk/56pDShTvmcVz/1wyGYXesuQR3NB6G6QAQmWlgSI
	 Xd8mbsqH+QvmFVNh6KcqkJv95/HJjAXQz8QhWaa8MMAhVqSh2k129DV2ot9yvREgI7
	 y8SA/aNmeXuSwKUPWfEr/2sC3YqK3sI0PPYF4qq+RuD7DjTwCKNJ2dxlby/3CP5LMV
	 kZhkVHF16m6lY+jwJGJC82E/vhYNwiYUFWEnMItOqVnf5cwISU2vlamvfA7qOWctBs
	 C9OEHJqQXz1LA59MWX5G9NeCSLVdI4dPc084LThaJp+9PdkwaOX9/rP2t7FGYD0+qu
	 ktFbUyiWxGuBQ==
Date: Fri, 13 Oct 2023 12:59:09 +0200
From: Simon Horman <horms@kernel.org>
To: Edward AD <twuufnxlz@gmail.com>
Cc: syzbot+225bfad78b079744fd5e@syzkaller.appspotmail.com,
	bpf@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] media: imon: fix stall in worker_thread
Message-ID: <20231013105909.GC29570@kernel.org>
References: <0000000000003495bf060724994a@google.com>
 <20231010053640.2034061-2-twuufnxlz@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010053640.2034061-2-twuufnxlz@gmail.com>

On Tue, Oct 10, 2023 at 01:36:41PM +0800, Edward AD wrote:
> syzbot report:
> rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 1-....
>  } 2682 jiffies s: 16081 root: 0x2/.
> rcu: blocking rcu_node structures (internal RCU debug):
> 
> Sending NMI from CPU 0 to CPUs 1:
> imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
> NMI backtrace for cpu 1
> CPU: 1 PID: 5131 Comm: kworker/1:5 Not tainted 6.6.0-rc4-syzkaller-00012-gce36c8b14987 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
> Workqueue: events nsim_dev_trap_report_work
> RIP: 0010:io_serial_in+0x76/0xb0 drivers/tty/serial/8250/8250_port.c:417
> Code: 60 35 c6 fc 89 e9 41 d3 e6 48 83 c3 40 48 89 d8 48 c1 e8 03 42 80 3c 38 00 74 08 48 89 df e8 51 b1 20 fd 44 03 33 44 89 f2 ec <0f> b6 c0 5b 41 5e 41 5f 5d c3 89 e9 80 e1 07 38 c1 7c ad 48 89 ef
> RSP: 0018:ffffc900001efed8 EFLAGS: 00000002
> RAX: 1ffffffff2443700 RBX: ffffffff9221bd60 RCX: 0000000000000000
> RDX: 00000000000003fd RSI: 0000000000000000 RDI: 0000000000000020
> RBP: 0000000000000000 R08: ffffffff84c7d646 R09: 1ffff110039be046
> R10: dffffc0000000000 R11: ffffed10039be047 R12: dffffc0000000000
> R13: 0000000000002703 R14: 00000000000003fd R15: dffffc0000000000
> FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fcd51aff0f0 CR3: 000000000d130000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <NMI>
>  </NMI>
>  <IRQ>
>  serial_in drivers/tty/serial/8250/8250.h:117 [inline]
>  serial_lsr_in drivers/tty/serial/8250/8250.h:139 [inline]
>  wait_for_lsr drivers/tty/serial/8250/8250_port.c:2089 [inline]
>  serial8250_console_fifo_write drivers/tty/serial/8250/8250_port.c:3374 [inline]
>  serial8250_console_write+0x110e/0x1820 drivers/tty/serial/8250/8250_port.c:3452
>  console_emit_next_record kernel/printk/printk.c:2910 [inline]
>  console_flush_all+0x7ff/0xec0 kernel/printk/printk.c:2966
>  console_unlock+0x13b/0x4d0 kernel/printk/printk.c:3035
>  vprintk_emit+0x508/0x720 kernel/printk/printk.c:2307
>  dev_vprintk_emit+0x2ae/0x330 drivers/base/core.c:4849
>  dev_printk_emit+0xdd/0x120 drivers/base/core.c:4860
>  _dev_warn+0x122/0x170 drivers/base/core.c:4916
>  usb_rx_callback_intf0+0x156/0x190 drivers/media/rc/imon.c:1771
>  __usb_hcd_giveback_urb+0x371/0x530 drivers/usb/core/hcd.c:1650
>  dummy_timer+0x8aa/0x3210 drivers/usb/gadget/udc/dummy_hcd.c:1987
>  call_timer_fn+0x17a/0x580 kernel/time/timer.c:1700
>  expire_timers kernel/time/timer.c:1751 [inline]
>  __run_timers+0x64f/0x860 kernel/time/timer.c:2022
>  run_timer_softirq+0x67/0xf0 kernel/time/timer.c:2035
>  __do_softirq+0x2ab/0x908 kernel/softirq.c:553
>  invoke_softirq kernel/softirq.c:427 [inline]
>  __irq_exit_rcu+0xf1/0x1b0 kernel/softirq.c:632
>  irq_exit_rcu+0x9/0x20 kernel/softirq.c:644
>  sysvec_apic_timer_interrupt+0x95/0xb0 arch/x86/kernel/apic/apic.c:1074
>  </IRQ>
>  <TASK>
>  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
> RIP: 0010:jhash2 include/linux/jhash.h:129 [inline]
> RIP: 0010:hash_stack lib/stackdepot.c:322 [inline]
> RIP: 0010:__stack_depot_save+0x64/0x650 lib/stackdepot.c:382
> Code: 00 43 8d 34 00 46 8d 34 c5 7b 71 f5 75 83 fe 04 72 70 44 89 f5 44 89 f0 4c 89 fa 03 02 03 6a 04 44 03 72 08 44 89 f7 c1 c7 04 <44> 29 f0 31 c7 41 01 ee 29 fd 89 fb c1 c3 06 31 eb 44 01 f7 89 d9
> RSP: 0018:ffffc900043df6b8 EFLAGS: 00000a07
> RAX: 00000000062d8798 RBX: 00000000fe584f8b RCX: 00000000838c8150
> RDX: ffffc900043df758 RSI: 0000000000000004 RDI: 00000000385a93f7
> RBP: 000000006c0b3f46 R08: 000000000000000b R09: ffffffff813da4e7
> R10: 0000000000000002 R11: ffff888026631dc0 R12: 0000000000000820
> R13: 0000000000000001 R14: 000000007385a93f R15: ffffc900043df710
>  kasan_save_stack mm/kasan/common.c:46 [inline]
>  kasan_set_track+0x61/0x70 mm/kasan/common.c:52
>  __kasan_slab_alloc+0x66/0x70 mm/kasan/common.c:328
>  kasan_slab_alloc include/linux/kasan.h:188 [inline]
>  slab_post_alloc_hook+0x67/0x3d0 mm/slab.h:762
>  slab_alloc_node mm/slub.c:3478 [inline]
>  kmem_cache_alloc_node+0x148/0x330 mm/slub.c:3523
>  __alloc_skb+0x181/0x420 net/core/skbuff.c:640
>  alloc_skb include/linux/skbuff.h:1286 [inline]
>  nsim_dev_trap_skb_build drivers/net/netdevsim/dev.c:748 [inline]
>  nsim_dev_trap_report drivers/net/netdevsim/dev.c:805 [inline]
>  nsim_dev_trap_report_work+0x250/0xa90 drivers/net/netdevsim/dev.c:850
>  process_one_work kernel/workqueue.c:2630 [inline]
>  process_scheduled_works+0x90f/0x1400 kernel/workqueue.c:2703
>  worker_thread+0xa5f/0xff0 kernel/workqueue.c:2784
>  kthread+0x2d3/0x370 kernel/kthread.c:388
>  ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
>  </TASK>
> imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
> imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
> raw-gadget.5 gadget.4: ignoring, device is not running
> imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
> 
> Invalid protocol requests should not be processed in
> usb_rx_callback_intf0().
> 
> Reported-and-tested-by: syzbot+225bfad78b079744fd5e@syzkaller.appspotmail.com
> Signed-off-by: Edward AD <twuufnxlz@gmail.com>
> ---
>  drivers/media/rc/imon.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/media/rc/imon.c b/drivers/media/rc/imon.c
> index 74546f7e3469..3830fabf113a 100644
> --- a/drivers/media/rc/imon.c
> +++ b/drivers/media/rc/imon.c
> @@ -1770,6 +1770,8 @@ static void usb_rx_callback_intf0(struct urb *urb)
>  	default:
>  		dev_warn(ictx->dev, "imon %s: status(%d): ignored\n",
>  			 __func__, urb->status);
> +		if (urb->status == -EPROTO)
> +			return;
>  		break;
>  	}

Hi Edward,

The code is already switching based on urb->status,
so unless the warning message is really desired,
perhaps this is more appropriate?

diff --git a/drivers/media/rc/imon.c b/drivers/media/rc/imon.c
index 74546f7e3469..0e2f06f2f456 100644
--- a/drivers/media/rc/imon.c
+++ b/drivers/media/rc/imon.c
@@ -1799,6 +1799,7 @@ static void usb_rx_callback_intf1(struct urb *urb)
 
 	switch (urb->status) {
 	case -ENOENT:		/* usbcore unlink successful! */
+	case -EPROTO:		/* XXX: something goes here */
 		return;
 
 	case -ESHUTDOWN:	/* transport endpoint was shut down */

>  
> -- 
> 2.25.1
> 
> 

