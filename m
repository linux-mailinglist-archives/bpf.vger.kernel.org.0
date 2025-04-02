Return-Path: <bpf+bounces-55132-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6819A78AC9
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 11:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF6C33B323B
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 09:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D06C23534A;
	Wed,  2 Apr 2025 09:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XeP3TIPx"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8354B20E00B
	for <bpf@vger.kernel.org>; Wed,  2 Apr 2025 09:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743585092; cv=none; b=RGZRdnpYp6AVYFo0LGVfb52T8ouVgWW2rS4MBUhnAVze925a9I8fl5nK1Cw5LgB1kwS8CRVFYrpOKJuG3Uxx0DRyN0V0FS1GpT4x/m8DQ/HzSH4I2N9HhiwilMVMMQ2dNrWSzo6VndooOz6RJeDOEmmWjOcsQ807rGMitmifzJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743585092; c=relaxed/simple;
	bh=Yo3Uj0gHf68WyvPx4QTQefreVtZCT2gX8H7vKp++RbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c6+N6RGwLeVLa3eAxU/mP7J+TVnyxfMxYe28H2mKnGVtXtKdceiI7v9PgtNtGWq7uhlMHHewovObf4Y5JLIT5aBMvMAMe5UYgu/E7D0IWPqDtTWP2hBBQuSN0DiCZmCiwA2r+fgSML54hOg2UdwbQnH+98Wbz/i+IHtV5K808yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XeP3TIPx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743585089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hm3ESw+VEPzW8BvEtq/Lx9EWVv8F/fGANnkaGWIk/Sk=;
	b=XeP3TIPx9kj2Ggpot/dW/I9jr7eH+rXfyY9UMeYLUJ2TsFJV4k+1E9KXizMdU3XUD92lhU
	6p9Zogy+Qbdtyff944oRQeM93P9tHBiqWY3+/1nD9IEHL3KiTat4f5BlzcCZc/uCjKQicA
	w1536C6hplpMhbK6rnCpvwYlTomOvT8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-457-svO_NquNMX26qd0WEGJtKQ-1; Wed,
 02 Apr 2025 05:11:26 -0400
X-MC-Unique: svO_NquNMX26qd0WEGJtKQ-1
X-Mimecast-MFC-AGG-ID: svO_NquNMX26qd0WEGJtKQ_1743585084
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9D955180AF55;
	Wed,  2 Apr 2025 09:11:24 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.34.147])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 6C5FD3001D0E;
	Wed,  2 Apr 2025 09:11:21 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  2 Apr 2025 11:10:49 +0200 (CEST)
Date: Wed, 2 Apr 2025 11:10:45 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Peter Ziljstra <peterz@infradead.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Sebastian Sewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>, Jiri Olsa <jolsa@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: uprobe splat in PREEMP_RT
Message-ID: <20250402091044.GB22091@redhat.com>
References: <CAADnVQLLOHZmPO4X_dQ+cTaSDvzdWHzA0qUqQDhLFYL3D6xPxg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQLLOHZmPO4X_dQ+cTaSDvzdWHzA0qUqQDhLFYL3D6xPxg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Add Peter.

I never understood why __seqprop_preemptible() returns false.
Stupid question, perhaps

	--- x/include/linux/seqlock.h
	+++ x/include/linux/seqlock.h
	@@ -213,12 +213,11 @@ static inline unsigned __seqprop_sequenc
	 
	 static inline bool __seqprop_preemptible(const seqcount_t *s)
	 {
	-	return false;
	+	return true;
	 }
	 
	 static inline void __seqprop_assert(const seqcount_t *s)
	 {
	-	lockdep_assert_preemption_disabled();
	 }
	 
	 #define __SEQ_RT	IS_ENABLED(CONFIG_PREEMPT_RT)

makes more sense?

Then we can remove the no longer necessary preempt_disable()'s
before write_seqcount_begin() in other users of seqcount_t.

Oleg.

On 04/01, Alexei Starovoitov wrote:
>
> Hi,
>
> caught the following splat running uprobe tests in PREEMPT_RT
>
> [  101.862206] ------------[ cut here ]------------
> [  101.862212] WARNING: CPU: 0 PID: 16 at include/linux/seqlock.h:221
> ri_timer+0x235/0x320
> [  101.862226] Modules linked in:
> [  101.862233] CPU: 0 UID: 0 PID: 16 Comm: ktimers/0 Not tainted
> 6.14.0-12141-g1d0ec9988088 #22 PREEMPT_RT
> [  101.862240] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> [  101.862243] RIP: 0010:ri_timer+0x235/0x320
> [  101.862249] Code: 5d 41 5e 41 5f e9 5b f5 b7 ff 65 f7 05 a8 95 ff
> 04 ff ff ff 7f 0f 85 ad fe ff ff 65 8b 05 57 cf ff 04 85 c0 0f 84 9e
> fe ff ff <0f> 0b e9 97 fe ff ff e8 df 7b b8 ff 84 c0 0f 85 43 fe ff ff
> e8 52
> [  101.862253] RSP: 0018:ffffc9000010fb80 EFLAGS: 00010202
> [  101.862257] RAX: 0000000000000001 RBX: ffffffff819c8889 RCX: 0000000000000001
> [  101.862260] RDX: 0000000000000000 RSI: ffffffff819c8889 RDI: ffff8881f6a33910
> [  101.862262] RBP: ffff888105a1da18 R08: 000000000000000a R09: 000000000000000a
> [  101.862265] R10: ffffc9000010f987 R11: 0000000000000000 R12: 1ffff92000021f78
> [  101.862267] R13: 0000000000000000 R14: ffffffff819c8860 R15: 0000000000000000
> [  101.862292] FS:  0000000000000000(0000) GS:ffff88827005e000(0000)
> knlGS:0000000000000000
> [  101.862316] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  101.862319] CR2: 00007fffffffe000 CR3: 0000000109d67004 CR4: 00000000003706f0
> [  101.862322] Call Trace:
> [  101.862325]  <TASK>
> [  101.862333]  ? free_ret_instance+0x180/0x180
> [  101.862338]  call_timer_fn+0x14c/0x3c0
> [  101.862345]  ? lock_release+0xb6/0x250
> [  101.862353]  ? detach_if_pending+0x310/0x310
> [  101.862363]  ? _raw_spin_unlock_irq+0x28/0x40
> [  101.862371]  ? lockdep_hardirqs_on_prepare+0xa7/0x170
> [  101.862380]  __run_timers+0x58a/0x980
> [  101.862385]  ? free_ret_instance+0x180/0x180
> [  101.862396]  ? timer_shutdown_sync+0x20/0x20
> [  101.862402]  ? lock_acquire+0x123/0x2b0
> [  101.862408]  ? run_timer_softirq+0x11a/0x220
> [  101.862414]  ? do_raw_spin_lock+0x11e/0x240
> [  101.862419]  ? spin_bug+0x230/0x230
> [  101.862422]  ? rtlock_slowlock_locked+0x50a0/0x50a0
> [  101.862433]  run_timer_softirq+0x122/0x220
> [  101.862503]  handle_softirqs.isra.0+0x136/0x610
> [  101.862518]  run_ktimerd+0x47/0xe0
> [  101.862524]  smpboot_thread_fn+0x30f/0x8a0
> [  101.862531]  ? schedule+0xe2/0x390
> [  101.862537]  ? sort_range+0x20/0x20
> [  101.862541]  kthread+0x3ac/0x770
> [  101.862547]  ? rt_read_trylock+0x1d0/0x1d0
> [  101.862554]  ? kthread_is_per_cpu+0xc0/0xc0
> [  101.862560]  ? lock_release+0xb6/0x250
> [  101.862570]  ? kthread_is_per_cpu+0xc0/0xc0
> [  101.862574]  ret_from_fork+0x31/0x70
> [  101.862580]  ? kthread_is_per_cpu+0xc0/0xc0
> [  101.862586]  ret_from_fork_asm+0x11/0x20
> [  101.862604]  </TASK>
> [  101.862606] irq event stamp: 13032
> [  101.862608] hardirqs last  enabled at (13034): [<ffffffff8150094a>]
> vprintk_store+0x72a/0x850
> [  101.862613] hardirqs last disabled at (13035): [<ffffffff8150061d>]
> vprintk_store+0x3fd/0x850
> [  101.862615] softirqs last  enabled at (12922): [<ffffffff8136e049>]
> run_ktimerd+0x69/0xe0
> [  101.862618] softirqs last disabled at (12928): [<ffffffff813ef4bf>]
> smpboot_thread_fn+0x30f/0x8a0
> [  101.862621] ---[ end trace 0000000000000000 ]---
>
> Looks like write_seqcount_begin(&utask->ri_seqcount);
> use in ri_timer() needs a fix ?
>


