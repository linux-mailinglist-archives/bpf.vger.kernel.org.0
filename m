Return-Path: <bpf+bounces-32219-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AEF9097D6
	for <lists+bpf@lfdr.de>; Sat, 15 Jun 2024 13:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7B111C21144
	for <lists+bpf@lfdr.de>; Sat, 15 Jun 2024 11:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0F5328A0;
	Sat, 15 Jun 2024 11:01:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655624C89
	for <bpf@vger.kernel.org>; Sat, 15 Jun 2024 11:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718449262; cv=none; b=DAxdt4TiZVo82DfI19vaEFKMOULudEqSU/e1yy6fsS05o3i7lFL4AvHXJXpxqABtrWQVFAdaz/gv52ZCW60KYMXhZYnWBNAD7Q/tBArSu9ijYqAbKmRq2ssViVzDRBr+M+ar1/qnORQZUbGdsvDqqpfL1hXw30PFYduA2C29YSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718449262; c=relaxed/simple;
	bh=xsumvJvuxgihS5R5Mrp/KmnZUYzsd1QNZgPP5crQUrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C2xQJ4tlWn9tN/U5VTHCa66X9cNFSpCgv73SBhviGs7Evvbp6iSeXXvRKErevVVdXmqhF+1qh4ejINaLyyrhLELYbB8qaE5X6S5ip1B8etlGm8weF/BxNheHe5Qk+AiKodaS7e1kXLppH8dtgZDSreCIbQdaTNOF3WU16j1Rd5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav112.sakura.ne.jp (fsav112.sakura.ne.jp [27.133.134.239])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 45FAxt3S067998;
	Sat, 15 Jun 2024 19:59:55 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav112.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav112.sakura.ne.jp);
 Sat, 15 Jun 2024 19:59:55 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav112.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 45FAxtv3067995
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 15 Jun 2024 19:59:55 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <79d32963-de38-49cf-a03f-f6f5f4fbb462@I-love.SAKURA.ne.jp>
Date: Sat, 15 Jun 2024 19:59:53 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpf: don't call mmap_read_trylock() from IRQ context
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@amazon.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <4b875158-1aa7-402e-8861-860a493c49cd@I-love.SAKURA.ne.jp>
 <3e9b2a54-73d4-48cb-a510-d17984c97a45@I-love.SAKURA.ne.jp>
 <52d3d784-47ad-4190-920b-e5fe4673b11f@I-love.SAKURA.ne.jp>
 <CAADnVQLB6Zt1QjW+BeUmQJnWzGeCr7b2r0KKfygsJPzo0Rq+4A@mail.gmail.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAADnVQLB6Zt1QjW+BeUmQJnWzGeCr7b2r0KKfygsJPzo0Rq+4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello.

On 2024/06/15 1:40, Alexei Starovoitov wrote:
> On Fri, Jun 14, 2024 at 8:15 AM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>> "inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage." upon unlock from IRQ work
>> was reported at https://syzkaller.appspot.com/bug?extid=40905bca570ae6784745 .
> 
> imo the issue is elsewhere. syzbot reports:
> local_lock_acquire include/linux/local_lock_internal.h:29 [inline]
>  __mmap_lock_do_trace_released+0x9c/0x620 mm/mmap_lock.c:243
>  __mmap_lock_trace_released include/linux/mmap_lock.h:42 [inline]
> 
> it complains about:
> local_lock(&memcg_paths.lock);
> in TRACE_MMAP_LOCK_EVENT.
> which looks like a false positive.

Commit 2b5067a8143e ("mm: mmap_lock: add tracepoints around lock
acquisition") introduced TRACE_MMAP_LOCK_EVENT() macro as below.

#define TRACE_MMAP_LOCK_EVENT(type, mm, ...)                                   \
       do {                                                                   \
               const char *memcg_path;                                        \
               preempt_disable();                                             \
               memcg_path = get_mm_memcg_path(mm);                            \
               trace_mmap_lock_##type(mm,                                     \
                                      memcg_path != NULL ? memcg_path : "",   \
                                      ##__VA_ARGS__);                         \
               if (likely(memcg_path != NULL))                                \
                       put_memcg_path_buf();                                  \
               preempt_enable();                                              \
       } while (0)

Commit d01079f3d0c0 ("mm/mmap_lock: remove dead code for !CONFIG_TRACING
configurations") moved the location of this macro.

Commit 832b50725373 ("mm: mmap_lock: use local locks instead of disabling
preemption") replaced preempt_disable() with local_lock(&memcg_paths.lock)
based on an argument that preempt_disable() has to be avoided because
get_mm_memcg_path() might sleep if PREEMPT_RT=y.

The local_lock() macro is defined as

  #define local_lock(lock)		__local_lock(lock)

in include/linux/local_lock.h and __local_lock() macro is defined as

  #define __local_lock(lock)					\
  	do {							\
  		preempt_disable();				\
  		local_lock_acquire(this_cpu_ptr(lock));		\
  	} while (0)

if PREEMPT_RT=n or

  #define __local_lock(__lock)					\
  	do {							\
  		migrate_disable();				\
  		spin_lock(this_cpu_ptr((__lock)));		\
  	} while (0)

if PREEMPT_RT=y in include/linux/local_lock_internal.h .
Note that the difference between preempt_disable() and migrate_disable().

Commit d01079f3d0c0 ("mm/mmap_lock: remove dead code for !CONFIG_TRACING
configurations") by error replaced local_lock() with preempt_disable(),
and commit e904c2ccf9b5 ("mm: mmap_lock: fix disabling preemption
directly") replaced preempt_disable() with local_lock().



Now, syzbot started reporting

  inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.

and

  inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.

messages, for local_lock() does not disable IRQ.

I think we can replace local_lock() with local_lock_irqsave() like

diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
index 1854850b4b89..1901ad22ccbd 100644
--- a/mm/mmap_lock.c
+++ b/mm/mmap_lock.c
@@ -156,14 +156,15 @@ static inline void put_memcg_path_buf(void)
 #define TRACE_MMAP_LOCK_EVENT(type, mm, ...)                                   \
 	do {                                                                   \
 		const char *memcg_path;                                        \
-		local_lock(&memcg_paths.lock);                                 \
+		unsigned long flags;                                           \
+		local_lock_irqsave(&memcg_paths.lock, flags);                  \
 		memcg_path = get_mm_memcg_path(mm);                            \
 		trace_mmap_lock_##type(mm,                                     \
 				       memcg_path != NULL ? memcg_path : "",   \
 				       ##__VA_ARGS__);                         \
 		if (likely(memcg_path != NULL))                                \
 			put_memcg_path_buf();                                  \
-		local_unlock(&memcg_paths.lock);                               \
+		local_unlock_irqrestore(&memcg_paths.lock, flags);             \
 	} while (0)
 
 #else /* !CONFIG_MEMCG */

because local_lock_irqsave() is defined as

  #define local_lock_irqsave(lock, flags)	__local_lock_irqsave(lock, flags)

in include/linux/local_lock.h and __local_lock_irqsave() macro is defined as

  #define __local_lock_irqsave(lock, flags)			\
  	do {							\
  		local_irq_save(flags);				\
  		local_lock_acquire(this_cpu_ptr(lock));		\
  	} while (0)

if PREEMPT_RT=n or

  #define __local_lock_irqsave(lock, flags)			\
  	do {							\
  		typecheck(unsigned long, flags);		\
  		flags = 0;					\
  		__local_lock(lock);				\
  	} while (0)

if PREEMPT_RT=y in include/linux/local_lock_internal.h .



But a fundamental question arises here; why do we need to hold
memcg_paths.lock here, for as of commit 44ef20baed8e ("Merge tag
's390-6.10-4' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux"),
"git grep -nF memcg_paths" indicates that memcg_paths.lock is used within
only TRACE_MMAP_LOCK_EVENT() macro.

  mm/mmap_lock.c:48:static DEFINE_PER_CPU(struct memcg_path, memcg_paths) = {
  mm/mmap_lock.c:63:              memcg_path = per_cpu_ptr(&memcg_paths, cpu);
  mm/mmap_lock.c:101:             rcu_assign_pointer(per_cpu_ptr(&memcg_paths, cpu)->buf, new);
  mm/mmap_lock.c:135:     struct memcg_path *memcg_path = this_cpu_ptr(&memcg_paths);
  mm/mmap_lock.c:152:     local_sub(MEMCG_PATH_BUF_SIZE, &this_cpu_ptr(&memcg_paths)->buf_idx);
  mm/mmap_lock.c:159:             local_lock(&memcg_paths.lock);                                 \
  mm/mmap_lock.c:166:             local_unlock(&memcg_paths.lock);                               \

That is, what is the reason we can't revert commit 832b50725373 and
make the TRACE_MMAP_LOCK_EVENT() macro to branch directly like below?

diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
index 1854850b4b89..1e440c7d48e6 100644
--- a/mm/mmap_lock.c
+++ b/mm/mmap_lock.c
@@ -153,19 +153,35 @@ static inline void put_memcg_path_buf(void)
 	rcu_read_unlock();
 }
 
+#ifndef CONFIG_PREEMPT_RT
 #define TRACE_MMAP_LOCK_EVENT(type, mm, ...)                                   \
 	do {                                                                   \
 		const char *memcg_path;                                        \
-		local_lock(&memcg_paths.lock);                                 \
+		preempt_disable();                                             \
 		memcg_path = get_mm_memcg_path(mm);                            \
 		trace_mmap_lock_##type(mm,                                     \
 				       memcg_path != NULL ? memcg_path : "",   \
 				       ##__VA_ARGS__);                         \
 		if (likely(memcg_path != NULL))                                \
 			put_memcg_path_buf();                                  \
-		local_unlock(&memcg_paths.lock);                               \
+		preempt_enable();                                              \
 	} while (0)
 
+#else
+#define TRACE_MMAP_LOCK_EVENT(type, mm, ...)                                   \
+	do {                                                                   \
+		const char *memcg_path;                                        \
+		migrate_disable();                                             \
+		memcg_path = get_mm_memcg_path(mm);                            \
+		trace_mmap_lock_##type(mm,                                     \
+				       memcg_path != NULL ? memcg_path : "",   \
+				       ##__VA_ARGS__);                         \
+		if (likely(memcg_path != NULL))                                \
+			put_memcg_path_buf();                                  \
+		migrate_enable();                                              \
+	} while (0)
+#endif
+
 #else /* !CONFIG_MEMCG */
 
 int trace_mmap_lock_reg(void)

Is the reason because &buf[idx] in get_memcg_path_buf() might become out of
bounds due to preemption in normal context if PREEMPT_RT=y ? If so, can't we
add "idx >=0 && idx < CONTEXT_COUNT" check into get_memcg_path_buf() and
return NULL if preemption (or interrupt or recursion if any) exhausted the per
cpu buffer?

  /*
   * How many contexts our trace events might be called in: normal, softirq, irq,
   * and NMI.
   */
  #define CONTEXT_COUNT 4


