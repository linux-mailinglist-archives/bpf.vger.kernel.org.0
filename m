Return-Path: <bpf+bounces-72271-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E5BC0B1BA
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 21:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DEE8189FBA8
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 20:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA44527467E;
	Sun, 26 Oct 2025 20:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRX+1Lpa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C5523185E
	for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 20:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761509178; cv=none; b=k6s4i88YSFmqlYsVfrHtJuG1LMW1R1OSVk/xIFLklspZAv6HmJeYbLqTVJbJ8AptjoOHSOqLaQXfyyy8TLo7jvtafPXz1Nng4hH7fZ/BL9YutpnL72rW655hLtRaU7LSCvtE5kzLGBtM8cW2xsUHYzRS2h9eSW97WuUbgaRawxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761509178; c=relaxed/simple;
	bh=VrkW14uqGip0Bk2+38JuH4m4s5WOxAyeoaDxqc6rezw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jf0Ju7LjHkf0jpW/cIhF4up98jQe3MjhCIPJbZO4iJh90LbQqrICJkyU25CbJInHAGcR8VXlA+mg47zCXLKwiGaGhScFt3AndAf//MO2Sp1nTPOO4o4YlKA0GCDDDjazSABF5Wn+Cqkn1mnBq/RjUxllZuoWWMOaKi1WSsWdgBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRX+1Lpa; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-27d4d6b7ab5so58009355ad.2
        for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 13:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761509175; x=1762113975; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NLnr/ncBHj2yG+qse5NSNQc2ilWvF/iAF5vKMIBHC4I=;
        b=NRX+1LpaBLlitRafAIda7l07vJP5b2KLnqkE86EUjiboheyXst6K+m0tqwORKsCjeF
         xLF+DOEhJgvTRxKAAvzBA9//mir1QJiiKe5n3cbj/togo8D4hnP7rKcTSdAy4He2B1T7
         onPdktbxPrOyg/iHT2yU5/m1dKKmNbTpdKXJrEGTypzwlQPDZ7WzPIk6WqpUefDmyPdk
         BcpOAMeheDTD9U628EfbgNs4XwyVAWth7AXg6IDsN+SA8r92VDBu0P+KztcJ9Fm4gUSD
         C/LiDtQq7kGvaiUHAFEu45r9B3JAKgjCmbizyUghOSLDjC40yLBNf+J1D1jTe+GldEBr
         fLhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761509175; x=1762113975;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NLnr/ncBHj2yG+qse5NSNQc2ilWvF/iAF5vKMIBHC4I=;
        b=ph4IC0be8yuIa6JW2Gt0XH34M2RF+IIEzsTXrG/1pZ8aM4VD0I+TkplAN8qujP87WI
         RrM4Qj1QPyzptSmfnLIts69beFFdDMYzJ8cVnnWTKjLr7FqG+mvhh6VnplWo6vxXZ91E
         bBukNx0EG197dgR8Xquesd9FHhqVMphx5aHMpEMvd1kTCcSUbs6GrQ0q5uHmzWn704XH
         Twj/6L6xvW2qH3E1js+YPqbYUY74QoiPiPBN0Y/K+H+DMYj481iT8FUg0vrPuq6HHBxR
         mBQWCkTeC+Bn25Yr2/9XVOz24Soqa5MAFxa7HLMVZEkaJTJFN60GfRy57yp4z+yHskAy
         /Y7w==
X-Forwarded-Encrypted: i=1; AJvYcCVTD5PLx1XwPH08x1ynewvXrvh1UBM+S3k/E/Wwgfl8S175vBdyHOefjvPEaAYY6JGpJEg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdc/fiLUnwpggamB1yg5L3OQQJldk7y6imBQgVVxND0r0T50Uu
	5evJtYg+BdgL0eiCiMa0yjqNmqLF6kefvcNiqzows+Dh4RbP10V77S+r
X-Gm-Gg: ASbGncugMWqJ9HpFgopTRKtXHAZbACV9R+RHFV3Oxa8UwndIbDU6gvObHAREcSv1wy0
	LauObIQ5YCJw6SqyZAGWIk9Sv9sJPwYTOw/OwxWck9z7sh6dziN4Tv7TrDNhgUghTcEc2YCpY8/
	2B0L8lzcf3GwqKPgyEfDwLtCss+Un154M8nCq18kJutK8aPUUR40zCDlk3DZEZFFC1mMsWUUSRt
	P4dLW5wYTj/a9ndbuxlOP5dnka0E7YX564JDDH5FqnFQam0oci5Te7e15gLijX/qj9MVZXhPZ8s
	80t4cV+7mZRExqXhbi8gypkwNc56CG53Zx1snYIQTkX8j42YkvzC9ECesIlmCaQUJLJluRYN6Ys
	hHKqFFA7cGJIx+P05mmKBUtKNm2HYqb8IrxHAqph1fM0SttR4A0uKnskn2176f7/rJzKwHUybnz
	oH60Ns8BVp3G86qWADcjzJlWd0nmI=
X-Google-Smtp-Source: AGHT+IEeZ5+5Z7bpIdsGVtc+udutyYjxYW6a5bceAwOzU5KRn9m5dxZq4bxZWwLlRZgCxC+SzyGeog==
X-Received: by 2002:a17:903:3d0c:b0:267:af07:6526 with SMTP id d9443c01a7336-290cb65c541mr451329865ad.55.1761509175229;
        Sun, 26 Oct 2025 13:06:15 -0700 (PDT)
Received: from chandna.localdomain ([106.222.228.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d0987fsm56798615ad.25.2025.10.26.13.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 13:06:14 -0700 (PDT)
Date: Mon, 27 Oct 2025 01:35:57 +0530
From: Sahil Chandna <chandna.sahil@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: syzbot+b0cff308140f79a9c4cb@syzkaller.appspotmail.com,
	andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
	linux-kernel@vger.kernel.org, listout@listout.xyz,
	martin.lau@linux.dev, netdev@vger.kernel.org, sdf@fomichev.me,
	song@kernel.org, syzkaller-bugs@googlegroups.com,
	linux-rt-devel@lists.linux.dev, bigeasy@linutronix.de
Subject: Re: [syzbot] [bpf?] WARNING in bpf_bprintf_prepare (3)
Message-ID: <aP5_JbddrpnDs-WN@chandna.localdomain>
References: <68f6a4c8.050a0220.1be48.0011.GAE@google.com>
 <14371cf8-e49a-4c68-b763-fa7563a9c764@linux.dev>
 <aPklOxw0W-xUbMEI@chandna.localdomain>
 <8dd359dd-b42f-4676-bb94-07288b38fac1@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8dd359dd-b42f-4676-bb94-07288b38fac1@linux.dev>

On Wed, Oct 22, 2025 at 12:56:25PM -0700, Yonghong Song wrote:
>
>
>On 10/22/25 11:40 AM, Sahil Chandna wrote:
>>On Wed, Oct 22, 2025 at 09:57:22AM -0700, Yonghong Song wrote:
>>>
>>>
>>>On 10/20/25 2:08 PM, syzbot wrote:
>>>>Hello,
>>>>
>>>>syzbot found the following issue on:
>>>>
>>>>HEAD commit:    a1e83d4c0361 selftests/bpf: Fix redefinition of 
>>>>'off' as d..
>>>>git tree:       bpf
>>>>console output: 
>>>>https://syzkaller.appspot.com/x/log.txt?x=12d21de2580000
>>>>kernel config: 
>>>>https://syzkaller.appspot.com/x/.config?x=9ad7b090a18654a7
>>>>dashboard link: 
>>>>https://syzkaller.appspot.com/bug?extid=b0cff308140f79a9c4cb
>>>>compiler:       Debian clang version 20.1.8 
>>>>(++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), 
>>>>Debian LLD 20.1.8
>>>>syz repro: https://syzkaller.appspot.com/x/repro.syz?x=160cf542580000
>>>>C reproducer: https://syzkaller.appspot.com/x/repro.c?x=128d5c58580000
>>>>
>>>>Downloadable assets:
>>>>disk image: https://storage.googleapis.com/syzbot-assets/2f6a7a0cd1b7/disk-a1e83d4c.raw.xz
>>>>vmlinux: https://storage.googleapis.com/syzbot-assets/873984cfc71e/vmlinux-a1e83d4c.xz
>>>>kernel image: https://storage.googleapis.com/syzbot-assets/16711d84070c/bzImage-a1e83d4c.xz
>>>>
>>>>The issue was bisected to:
>>>>
>>>>commit 7c33e97a6ef5d84e98b892c3e00c6d1678d20395
>>>>Author: Sahil Chandna <chandna.sahil@gmail.com>
>>>>Date:   Tue Oct 14 18:56:35 2025 +0000
>>>>
>>>>    bpf: Do not disable preemption in bpf_test_run().
>>>>
>>>>bisection log: 
>>>>https://syzkaller.appspot.com/x/bisect.txt?x=172fe492580000
>>>>final oops: https://syzkaller.appspot.com/x/report.txt?x=14afe492580000
>>>>console output: 
>>>>https://syzkaller.appspot.com/x/log.txt?x=10afe492580000
>>>>
>>>>IMPORTANT: if you fix the issue, please add the following tag to 
>>>>the commit:
>>>>Reported-by: syzbot+b0cff308140f79a9c4cb@syzkaller.appspotmail.com
>>>>Fixes: 7c33e97a6ef5 ("bpf: Do not disable preemption in 
>>>>bpf_test_run().")
>>>>
>>>>------------[ cut here ]------------
>>>>WARNING: CPU: 1 PID: 6145 at kernel/bpf/helpers.c:781 
>>>>bpf_try_get_buffers kernel/bpf/helpers.c:781 [inline]
>>>>WARNING: CPU: 1 PID: 6145 at kernel/bpf/helpers.c:781 
>>>>bpf_bprintf_prepare+0x12cf/0x13a0 kernel/bpf/helpers.c:834
>>>
>>>Okay, the warning is due to the following WARN_ON_ONCE:
>>>
>>>static DEFINE_PER_CPU(struct 
>>>bpf_bprintf_buffers[MAX_BPRINTF_NEST_LEVEL], bpf_bprintf_bufs);
>>>static DEFINE_PER_CPU(int, bpf_bprintf_nest_level);
>>>
>>>int bpf_try_get_buffers(struct bpf_bprintf_buffers **bufs)
>>>{
>>>       int nest_level;
>>>
>>>       nest_level = this_cpu_inc_return(bpf_bprintf_nest_level);
>>>       if (WARN_ON_ONCE(nest_level > MAX_BPRINTF_NEST_LEVEL)) {
>>>               this_cpu_dec(bpf_bprintf_nest_level);
>>>               return -EBUSY;
>>>       }
>>>       *bufs = this_cpu_ptr(&bpf_bprintf_bufs[nest_level - 1]);
>>>
>>>       return 0;
>>>}
>>>
>>>Basically without preempt disable, at process level, it is possible
>>>more than one process may trying to take bpf_bprintf_buffers.
>>>Adding softirq and nmi, it is totally likely to have more than 3
>>>level for buffers. Also, more than one process with bpf_bprintf_buffers
>>>will cause problem in releasing buffers, so we need to have
>>>preempt_disable surrounding bpf_try_get_buffers() and
>>>bpf_put_buffers().
>>Right, but using preempt_disable() may impact builds with
>>CONFIG_PREEMPT_RT=y, similar to bug[1]? Do you think local_lock() 
>>could be used here
>
>We should be okay. for all the kfuncs/helpers I mentioned below,
>with the help of AI, I didn't find any spin_lock in the code path
>and all these helpers although they try to *print* some contents,
>but the kfuncs/helpers itself is only to deal with buffers and
>actual print will happen asynchronously.
>
>>as nest level is per cpu variable and local lock semantics can work
>>for both RT and non rt builds ?
>
>I am not sure about local_lock() in RT as for RT, local_lock() could
>be nested and the release may not in proper order. See
>  https://www.kernel.org/doc/html/v5.8/locking/locktypes.html
>
>  local_lock is not suitable to protect against preemption or interrupts on a
>  PREEMPT_RT kernel due to the PREEMPT_RT specific spinlock_t semantics.
>
>So I suggest to stick to preempt_disable/enable approach.
>
>>>
>>>There are some kfuncs/helpers need such preempt_disable
>>>protection, e.g. bpf_stream_printk, bpf_snprintf,
>>>bpf_trace_printk, bpf_trace_vprintk, bpf_seq_printf.
>>>But please double check.
>>>
>>Sure, thanks!

Since these helpers eventually call bpf_bprintf_prepare(),
I figured adding protection around bpf_try_get_buffers(),
which triggers the original warning, should be sufficient.
I tried a few approaches to address the warning as below :

1. preempt_disable() / preempt_enable() around bpf_prog_run_pin_on_cpu()
diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 1b61bb25ba0e..6a128179a26f 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -1021,7 +1021,9 @@ u32 bpf_flow_dissect(struct bpf_prog *prog, struct bpf_flow_dissector *ctx,
   		     (int)FLOW_DISSECTOR_F_STOP_AT_ENCAP);
   	flow_keys->flags = flags;

+	preempt_disable();
   	result = bpf_prog_run_pin_on_cpu(prog, ctx);
+	preempt_enable();

   	flow_keys->nhoff = clamp_t(u16, flow_keys->nhoff, nhoff, hlen);
   	flow_keys->thoff = clamp_t(u16, flow_keys->thoff,
This fixes the original WARN_ON in both PREEMPT_FULL and RT builds.
However, when tested with the syz reproducer of the original bug [1], it
still triggers the expected DEBUG_LOCKS_WARN_ON(this_cpu_read(softirq_ctrl.cnt)) 
warning from __local_bh_disable_ip(), due to the preempt_disable() 
interacting with RT spinlock semantics.
[1] [https://syzkaller.appspot.com/bug?extid=1f1fbecb9413cdbfbef8](https://syzkaller.appspot.com/bug?extid=1f1fbecb9413cdbfbef8)
So this approach avoids the buffer nesting issue, but re-introduces the following issue:
[  363.968103][T21257] DEBUG_LOCKS_WARN_ON(this_cpu_read(softirq_ctrl.cnt))
[  363.968922][T21257] WARNING: CPU: 0 PID: 21257 at kernel/softirq.c:176 __local_bh_disable_ip+0x3d9/0x540
[  363.969046][T21257] Modules linked in:
[  363.969176][T21257] Call Trace:
[  363.969181][T21257]  <TASK>
[  363.969186][T21257]  ? __local_bh_disable_ip+0xa1/0x540
[  363.969197][T21257]  ? sock_map_delete_elem+0xa2/0x170
[  363.969209][T21257]  ? preempt_schedule_common+0x83/0xd0
[  363.969252][T21257]  ? rt_spin_unlock+0x161/0x200
[  363.969269][T21257]  sock_map_delete_elem+0xaf/0x170
[  363.969280][T21257]  bpf_prog_464bc2be3fc7c272+0x43/0x47
[  363.969289][T21257]  bpf_flow_dissect+0x22b/0x750
[  363.969299][T21257]  bpf_prog_test_run_flow_dissector+0x37c/0x5c0

2. preempt_disable() inside bpf_try_get_buffers() and bpf_put_buffers()

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 8eb117c52817..bc8630833a94 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -777,12 +777,14 @@ int bpf_try_get_buffers(struct bpf_bprintf_buffers **bufs)
  {
         int nest_level;

+       preempt_disable();
         nest_level = this_cpu_inc_return(bpf_bprintf_nest_level);
         if (WARN_ON_ONCE(nest_level > MAX_BPRINTF_NEST_LEVEL)) {
                 this_cpu_dec(bpf_bprintf_nest_level);
                 return -EBUSY;
         }
         *bufs = this_cpu_ptr(&bpf_bprintf_bufs[nest_level - 1]);
+       preempt_enable();

         return 0;
  }
@@ -791,7 +793,10 @@ void bpf_put_buffers(void)
  {
         if (WARN_ON_ONCE(this_cpu_read(bpf_bprintf_nest_level) == 0))
                 return;
+
+       preempt_disable();
         this_cpu_dec(bpf_bprintf_nest_level);
+       preempt_enable();
  }
This *still* reproduces the original syz issue, so the protection needs to be 
placed around the entire program run, not inside the helper itself as
in above experiment.

3. Using a per-CPU local_lock
Finally, I tested with a per-CPU local_lock around bpf_prog_run_pin_on_cpu():
+struct bpf_cpu_lock {
+	local_lock_t lock;
+};
+
+static DEFINE_PER_CPU(struct bpf_cpu_lock, bpf_cpu_lock) = {
+	.lock = INIT_LOCAL_LOCK(),
+};
@@ -1021,7 +1030,9 @@ u32 bpf_flow_dissect(struct bpf_prog *prog, struct bpf_flow_dissector *ctx,
                      (int)FLOW_DISSECTOR_F_STOP_AT_ENCAP);
         flow_keys->flags = flags;

+       local_lock(&bpf_cpu_lock.lock);
         result = bpf_prog_run_pin_on_cpu(prog, ctx);
+       local_unlock(&bpf_cpu_lock.lock);

This approach avoid the warning on both RT and non-RT builds, with both the 
syz reproducer. The intention of introducing the per-CPU local_lock is to 
maintain consistent per-CPU execution semantics between RT and non-RT kernels.
On non-RT builds, local_lock maps to preempt_disable()/enable(),
which provides the same semantics as before.
On RT builds, it maps to an RT-safe per-CPU spinlock, avoiding the
softirq_ctrl.cnt issue.

Let me know if you’d like me to run some more experiments on this.

