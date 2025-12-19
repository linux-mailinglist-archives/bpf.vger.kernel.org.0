Return-Path: <bpf+bounces-77167-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B415CCD10DD
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 18:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7917C30A477C
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 17:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115C03314DB;
	Fri, 19 Dec 2025 17:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rostedt.org header.i=@rostedt.org header.b="i89W3iZP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LY2/uaKA"
X-Original-To: bpf@vger.kernel.org
Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FC9271469;
	Fri, 19 Dec 2025 17:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766163935; cv=none; b=iEwvU6kOmluUrwPUAK25JE6xRMqHtDsASOaMBw174+XL55EpAJDGPuACxkXGuqicLvABiEi1iRJzZRaszMLqDmGBpK8YI9yV5pUX/6tWrQHvncLpnWmX4VuGhERUrs363fDLjsaSeHviYAVGyhZXMgBI/yceBav5gLsMBTMcqsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766163935; c=relaxed/simple;
	bh=9r0jMOYfHxmMxAm7Z9zEgeH3JIm0x1A21QH+gvq+yQg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=stpdtHfwrxrJd9jadmKkCrV72HlAvYattx5Os/cP17CtdVaDxJJIZdqOKyHA37yxdfraZBKArr4o6jt05hHt8n+Zc/ajsLxchHNz2gVl7/GXwoJqT3w0ZWpkvVisH5rny5S58SRGkCgS/oSmWzdRCD0pEHKzOGi1FLt21//XoF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rostedt.org; spf=pass smtp.mailfrom=rostedt.org; dkim=pass (2048-bit key) header.d=rostedt.org header.i=@rostedt.org header.b=i89W3iZP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LY2/uaKA; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rostedt.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rostedt.org
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailflow.phl.internal (Postfix) with ESMTP id B626513800D1;
	Fri, 19 Dec 2025 12:05:30 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 19 Dec 2025 12:05:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rostedt.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1766163930;
	 x=1766171130; bh=t90zsrU4FyVd0irGAsnKMrUlSsMlpndG3PY39kb7iP0=; b=
	i89W3iZPqA4VSQvN8/hyNPCCvRN2mjZS2L0ITuudCbAkq/UGtcTI9ucchJjq/lrO
	XXs91Nag6ROXQZL5YS6OfPKo0SaEVext+fMPPcl95+TpBR+dbhpDqBZHcpGTJU5C
	RKN4PxNv1fipPTIO536cujvC16eleHq+UE9fPu7xhnJX7aaNbX69SrMCcxDTLOqE
	xTaH8kP62hHc3WoSFAqGuE5oKiV5LHFTWJvcf7iy/e+90jkJzOpkVa27U7IZvQ8m
	X1pg/fPjbNfxUXf+YUeix9wB4v/9qQzv/PCTbJbQGeBT0wpIPP02muiEF7tQ5WHV
	82AOhSlDTXEl9WvirEf2lA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766163930; x=
	1766171130; bh=t90zsrU4FyVd0irGAsnKMrUlSsMlpndG3PY39kb7iP0=; b=L
	Y2/uaKAKF/tpxuYb4ZF6HCMYm1HIzjRN/Y/C0/iiM2TXnBOt+tkVWzb2JDc+tsZ6
	6weE8qdaMwxudwroT/txdxb4kZabHJKCszsbbUzbZZhgW2ZK3jbZYPhAUaFvRDzD
	OK8EXZl9A1vrSNdOqJX8d8OAWMNfvMwM+2sE6tnru5qbapSRW+rVdCeS5IvR9G8B
	uHYJSEbRNgKPjZ10DH+aLeGO5gcWx7W1uOQ3a03R5gXUNF141K21D2XQa7kjkOcy
	kYv0yN3ea8UNjLy8ZMvyOOJ9LQx8ZOK4Wd1rgqdS33SrdbQflTnmorhRV20ertqn
	CyNOObvUj8sQApN+M1ZcA==
X-ME-Sender: <xms:2IVFafFKJAjVYFyxR6L-HhWeZcgeFoZ3VBDAovqLauwRT5kxcrhSGQ>
    <xme:2IVFaQS2HvVbWGWAzjtKXPRXMyvpbgbPvXwzeb6mhx4_FzY-MX1gXIMycBs9bgc7K
    GzYwleE1KGFgCLqI6Hem1A5ElzooyomLMChYAxobeBClYvHp0gq7Q>
X-ME-Received: <xmr:2IVFaZpXCIJY-RE5LKmZfifgoeWQFo9_ZAleZrXFwqifEV8GPXi3XSo6vWsM34BTMpZYzpU5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegkeekiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuuh
    hsphgvtghtffhomhgrihhnucdlgeelmdenucfjughrpeffhffvvefukfgjfhfogggtgfes
    thejredtredtvdenucfhrhhomhepufhtvghvvghnucftohhsthgvughtuceoshhtvghvvg
    hnsehrohhsthgvughtrdhorhhgqeenucggtffrrghtthgvrhhnpeefudeugeehtdehiedu
    vddvhefhkefgteeiudfggeelvdefieffiefggefhuedtieenucffohhmrghinhepshihii
    hkrghllhgvrhdrrghpphhsphhothdrtghomhdpghhoohhglhgvrghpihhsrdgtohhmpdhk
    vghrnhgvlhdrohhrghdpghhoohdrghhlnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepshhtvghvvghnsehrohhsthgvughtrdhorhhgpdhnsggp
    rhgtphhtthhopedvfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvhgsrggskh
    grsehsuhhsvgdrtgiipdhrtghpthhtohepshihiigsohhtodgsudehgeeirggugegrleeh
    feefudgsvddutdduvgesshihiihkrghllhgvrhdrrghpphhsphhothhmrghilhdrtghomh
    dprhgtphhtthhopegrshhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegsphhfsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhloh
    hfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhr
    tghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhhouhhtrg
    houdeshhhurgifvghirdgtohhmpdhrtghpthhtohepjhhkrghnghgrshesrhgvughhrght
    rdgtohhm
X-ME-Proxy: <xmx:2IVFaWq5FZyyHovNKReaApxV3MM7PVRIoOqAbPUxtSHdO21_C0eV-Q>
    <xmx:2IVFac2AVaJ2wI1bZZTabZiI_Zp23FlAEuByoLcVVnYK3AurX_9UWQ>
    <xmx:2IVFaSgXZXJbTv8zbQU2CMuCLf9Y0--7cykmRsdTt1oXyIi_FfU2Gg>
    <xmx:2IVFaTnyqeDGZ3L5MpsnLRQqkdOa85uyRJwZu4IysyBfGcTsx0iETg>
    <xmx:2oVFaTT-uvq-Ek_Y3B6-TLfMgL04UTpK8APxLrVzHbBMtCeGlC6i-jVV>
Feedback-ID: id06e481b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Dec 2025 12:05:27 -0500 (EST)
Date: Fri, 19 Dec 2025 12:06:56 -0500
From: Steven Rostedt <steven@rostedt.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: syzbot <syzbot+b1546ad4a95331b2101e@syzkaller.appspotmail.com>,
 ast@kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, houtao1@huawei.com,
 jkangas@redhat.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
 martin.lau@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 sgarzare@redhat.com, syzkaller-bugs@googlegroups.com,
 virtualization@lists.linux.dev, wangfushuai@baidu.com, Linux-RT-Users
 <linux-rt-users@vger.kernel.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, RCU
 <rcu@vger.kernel.org>, "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [syzbot] [net?] [virt?] BUG: sleeping function called from
 invalid context in __bpf_stream_push_str
Message-ID: <20251219120607.7371034e@gandalf.local.home>
In-Reply-To: <fb41c7e1-c8de-40fc-9470-2e742e358ba9@suse.cz>
References: <6936b4b4.a70a0220.38f243.00a2.GAE@google.com>
	<fb41c7e1-c8de-40fc-9470-2e742e358ba9@suse.cz>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Dec 2025 17:11:00 +0100
Vlastimil Babka <vbabka@suse.cz> wrote:

> On 12/8/25 12:21, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    559e608c4655 Merge tag 'ntfs3_for_6.19' of https://github...
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=164fdcc2580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=74c2ec4187efdce
> > dashboard link: https://syzkaller.appspot.com/bug?extid=b1546ad4a95331b2101e
> > compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1446301a580000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=112c3f42580000
> > 
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/7d28798cb263/disk-559e608c.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/239e800627b8/vmlinux-559e608c.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/e89da2cc9887/bzImage-559e608c.xz  
> 
> > The issue was bisected to:
> > 
> > commit 0db4941d9dae159d887e7e2eac7e54e60c3aac87
> > Author: Fushuai Wang <wangfushuai@baidu.com>
> > Date:   Tue Oct 7 07:40:11 2025 +0000
> > 
> >     bpf: Use rcu_read_lock_dont_migrate in bpf_sk_storage.c  
> 
> (came here because reviewing a proposed fix:
> https://lore.kernel.org/all/20251219085755.139846-1-swarajgaikwad1925@gmail.com/
> )
> 
> The bisection result seem weird to me, it changes some usages of
> migrate_disable(); + rcu_read_lock(); to  rcu_read_lock_dont_migrate();
> However with CONFIG_PREEMPT_RCU=y which the syzbot .config has, this should
> be equivalent? (Also I'm not sure the affected paths are even in the backtrace?)
> 
> In either case with CONFIG_PREEMPT_RCU=y, rcu_read_lock() should not be
> disabling preemption?

Correct.

> 
> > 
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10cd3c1a580000
> > final oops:     https://syzkaller.appspot.com/x/report.txt?x=12cd3c1a580000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=14cd3c1a580000
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+b1546ad4a95331b2101e@syzkaller.appspotmail.com
> > Fixes: 0db4941d9dae ("bpf: Use rcu_read_lock_dont_migrate in bpf_sk_storage.c")
> > 
> > BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
> > in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 6128, name: syz.3.73
> > preempt_count: 2, expected: 0
> > RCU nest depth: 1, expected: 1
> > 3 locks held by syz.3.73/6128:
> >  #0: ffff8880493da398 (sk_lock-AF_VSOCK){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1700 [inline]
> >  #0: ffff8880493da398 (sk_lock-AF_VSOCK){+.+.}-{0:0}, at: vsock_connect+0x152/0xd40 net/vmw_vsock/af_vsock.c:1546
> >  #1: ffffffff8d5aeba0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
> >  #1: ffffffff8d5aeba0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:867 [inline]
> >  #1: ffffffff8d5aeba0 (rcu_read_lock){....}-{1:3}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2074 [inline]
> >  #1: ffffffff8d5aeba0 (rcu_read_lock){....}-{1:3}, at: bpf_trace_run9+0x1ec/0x510 kernel/trace/bpf_trace.c:2123
> >  #2: ffff8880b893fd48 (&s->lock_key#14){+.+.}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:44 [inline]
> >  #2: ffff8880b893fd48 (&s->lock_key#14){+.+.}-{3:3}, at: ___slab_alloc+0x12f/0x1400 mm/slub.c:4516
> > Preemption disabled at:
> > [<ffffffff82179f5a>] class_preempt_constructor include/linux/preempt.h:468 [inline]

I think the above is the culprit. But useless because we care about who
called it.

> > [<ffffffff82179f5a>] __migrate_enable include/linux/sched.h:2378 [inline]
> > [<ffffffff82179f5a>] migrate_enable include/linux/sched.h:2429 [inline]
> > [<ffffffff82179f5a>] __slab_alloc+0xea/0x1f0 mm/slub.c:4777  
> 
> Wait, so it's slab code itself disabling preemption, in migrate_enable()?
> But there's guard(preempt)(); so it should be enabled again.

Yeah, I think the migrate_enable() is a red herring, and it doesn't detect
that preemption was enabled again.

> 
> Or is it the limitation of the reporting, that it doesn't know which
> preemptions were re-enabled and which not?
> 
> 
> > CPU: 1 UID: 0 PID: 6128 Comm: syz.3.73 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
> > Call Trace:
> >  <TASK>
> >  dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
> >  __might_resched+0x44b/0x5d0 kernel/sched/core.c:8830
> >  __rt_spin_lock kernel/locking/spinlock_rt.c:48 [inline]
> >  rt_spin_lock+0xc7/0x3e0 kernel/locking/spinlock_rt.c:57
> >  spin_lock include/linux/spinlock_rt.h:44 [inline]
> >  ___slab_alloc+0x12f/0x1400 mm/slub.c:4516
> >  __slab_alloc+0xc6/0x1f0 mm/slub.c:4774
> >  __slab_alloc_node mm/slub.c:4850 [inline]
> >  kmalloc_nolock_noprof+0x1be/0x440 mm/slub.c:5729
> >  bpf_stream_elem_alloc kernel/bpf/stream.c:33 [inline]
> >  __bpf_stream_push_str+0xa8/0x2b0 kernel/bpf/stream.c:50
> >  bpf_stream_stage_printk+0x14e/0x1c0 kernel/bpf/stream.c:306
> >  bpf_prog_report_may_goto_violation+0xc4/0x190 kernel/bpf/core.c:3203
> >  bpf_check_timed_may_goto+0xaa/0xb0 kernel/bpf/core.c:3221
> >  arch_bpf_timed_may_goto+0x21/0x40 arch/x86/net/bpf_timed_may_goto.S:40
> >  bpf_prog_262a74d054ad2993+0x53/0x5f
> >  bpf_dispatcher_nop_func include/linux/bpf.h:1376 [inline]
> >  __bpf_prog_run include/linux/filter.h:723 [inline]
> >  bpf_prog_run include/linux/filter.h:730 [inline]
> >  __bpf_trace_run kernel/trace/bpf_trace.c:2075 [inline]
> >  bpf_trace_run9+0x2de/0x510 kernel/trace/bpf_trace.c:2123
> >  __bpf_trace_virtio_transport_alloc_pkt+0x2d7/0x340 include/trace/events/vsock_virtio_transport_common.h:39

This is a tracepoint, which means it was called with preemption disabled:

#define __DECLARE_TRACE(name, proto, args, cond, data_proto)            \
        __DECLARE_TRACE_COMMON(name, PARAMS(proto), PARAMS(args), PARAMS(data_proto)) \
        static inline void __do_trace_##name(proto)                     \
        {                                                               \
                TRACEPOINT_CHECK(name)                                  \
                if (cond) {                                             \
                        guard(preempt_notrace)();                       \
                        __DO_TRACE_CALL(name, TP_ARGS(args));           \

The tracepoint callback is called here (with preemption disabled).

                }                                                       \
        }  

There's a patch to fix this for RT, but I wasn't planning on sending it
until the next merge window:

  https://lore.kernel.org/linux-trace-kernel/20251216120819.3499e00e@gandalf.local.home/

-- Steve

> >  __do_trace_virtio_transport_alloc_pkt include/trace/events/vsock_virtio_transport_common.h:39 [inline]
> >  trace_virtio_transport_alloc_pkt include/trace/events/vsock_virtio_transport_common.h:39 [inline]
> >  virtio_transport_alloc_skb+0x10af/0x1110 net/vmw_vsock/virtio_transport_common.c:311
> >  virtio_transport_send_pkt_info+0x694/0x10b0 net/vmw_vsock/virtio_transport_common.c:390
> >  virtio_transport_connect+0xa7/0x100 net/vmw_vsock/virtio_transport_common.c:1072
> >  vsock_connect+0xaca/0xd40 net/vmw_vsock/af_vsock.c:1611
> >  __sys_connect_file net/socket.c:2080 [inline]
> >  __sys_connect+0x323/0x450 net/socket.c:2099
> >  __do_sys_connect net/socket.c:2105 [inline]
> >  __se_sys_connect net/socket.c:2102 [inline]
> >  __x64_sys_connect+0x7a/0x90 net/socket.c:2102
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7f0c4d91f749
> > Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007ffd8ed26ac8 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
> > RAX: ffffffffffffffda RBX: 00007f0c4db75fa0 RCX: 00007f0c4d91f749
> > RDX: 0000000000000010 RSI: 0000200000000080 RDI: 0000000000000003
> > RBP: 00007f0c4d9a3f91 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > R13: 00007f0c4db75fa0 R14: 00007f0c4db75fa0 R15: 0000000000000003
> >  </TASK>
> > 
> > 
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > 
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> > 
> > If the report is already addressed, let syzbot know by replying with:
> > #syz fix: exact-commit-title
> > 
> > If you want syzbot to run the reproducer, reply with:
> > #syz test: git://repo/address.git branch-or-commit-hash
> > If you attach or paste a git patch, syzbot will apply it before testing.
> > 
> > If you want to overwrite report's subsystems, reply with:
> > #syz set subsystems: new-subsystem
> > (See the list of subsystem names on the web dashboard)
> > 
> > If the report is a duplicate of another one, reply with:
> > #syz dup: exact-subject-of-another-report
> > 
> > If you want to undo deduplication, reply with:
> > #syz undup
> >   
> 


