Return-Path: <bpf+bounces-18012-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 909A3814D9B
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 17:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B40EE1C213D1
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 16:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFB83FB06;
	Fri, 15 Dec 2023 16:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZzhHLR8v"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983B83FE2F
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 16:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c61810a0-4b62-415f-abb7-45868fc91d16@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702659190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ok+C5c9H0utsCjxaPkaS8ekHB1S17mlSukSyo99M1PE=;
	b=ZzhHLR8vv31wFH0zo7fzfMBOgz/lVXgmsGXabJ/4JPoDdzLX+fhL/XsLSTFAieFxuH8iGR
	KNJqEYBZ5zs7+2K4jNFqahT1g3A1e2l/cwh0MV//XdjHOOgr3s6jbFqqIZ0o0u3LJYnAx7
	dEH2ECP/NLq4SVGOClVttiW/dAnQu9A=
Date: Fri, 15 Dec 2023 08:53:02 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/1] bpf: Include pid, uid and comm in audit
 output
Content-Language: en-GB
To: Dave Tucker <dave@dtucker.co.uk>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Yafang Shao <laoar.shao@gmail.com>
References: <CAADnVQJi1mezWL6BKn=Vw4quev3pgLOW9q3Yz9GF=LjzZoHp6g@mail.gmail.com>
 <20231215143836.993858-1-dave@dtucker.co.uk>
 <db4e55b7-83e1-4ec8-b10d-cfc9be3771c7@linux.dev>
 <ACEF8947-8BE1-429C-AB6E-FE20CFB8CE8D@dtucker.co.uk>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <ACEF8947-8BE1-429C-AB6E-FE20CFB8CE8D@dtucker.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 12/15/23 8:38 AM, Dave Tucker wrote:
>
>> On 15 Dec 2023, at 15:24, Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>>
>> On 12/15/23 6:38 AM, Dave Tucker wrote:
>>> Current output from auditd is as follows:
>>>
>>> time->Wed Dec 13 21:39:24 2023
>>> type=BPF msg=audit(1702503564.519:11241): prog-id=439 op=LOAD
>>>
>>> This only tells you that a BPF program was loaded, but without
>>> any context. If we include the prog-name, pid, uid and comm we get
>>> output as follows:
>>>
>>> time->Wed Dec 13 21:59:59 2023
>>> type=BPF msg=audit(1702504799.156:99528): op=UNLOAD prog-id=50092
>>> prog-name="test" pid=27279 uid=0 comm="new_name"
>>>
>>> With pid, uid a system administrator has much better context
>>> over which processes and user loaded which eBPF programs.
>>> comm is useful since processes may be short-lived.
>>>
>>> Signed-off-by: Dave Tucker <dave@dtucker.co.uk>
>>> ---
>>>
>>> Changes:
>>>
>>> v1->v2:
>>>    - Move 'op' to the front of the audit messages
>>>    - Add 'prog-name' to the audit messages
>>>    - Replace deprecated in_irq() with in_hardirq()
>>>    - Remove in_irq() check from bpf_audit_prog since it's always called
>>>      from the task context
>> Is this true? For condition '(in_hardirq() || irqs_disabled())
>> ', the context will be the task context. But what about nmi and
>> softirq? The context maynot be the task context, right?
> You’re right, my mistake.
>
>> Not sure whether this is relevant or not. There was a discussion
>> in the past about the above condition. See
>>   https://lore.kernel.org/bpf/a93079f2-fcd4-e3ef-3b92-92d443b8e8c6@meta.com/
>>
>> The recommended change was
>>
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c index a75c54b6f8a3..11df562e481b 100644 --- a/kernel/bpf/syscall.c +++ b/kernel/bpf/syscall.c @@ -2147,7 +2147,7 @@ static void __bpf_prog_put(struct bpf_prog *prog)           struct bpf_prog_aux *aux = prog->aux;
>>
>>          if (atomic64_dec_and_test(&aux->refcnt)) {
>> - if (in_irq() || irqs_disabled()) { + if (!in_interrupt()) {                           INIT_WORK(&aux->work, bpf_prog_put_deferred);
>>                          schedule_work(&aux->work);
>>                  } else {
> include/linux/preempt.h says that in_interrupt is also deprecated.
> The condition could also be expressed as in_task().

Okay, I see. in_interrupt() probably means !in_task(). The key issue
is in vfree()
===
void vfree(const void *addr)
{
         struct vm_struct *vm;
         int i;

         if (unlikely(in_interrupt())) {
                 vfree_atomic(addr);
                 return;
         }

         BUG_ON(in_nmi());
         kmemleak_free(addr);
         might_sleep();
...
===
where if in interrupt, vfree is atomic() and otherwise, it is not.
So if for task context, there are cases in the kernel where
__bpf_prog_put() is inside rcu critical section and this might
cause the problem. But since this is true for a couple of cases,
so it has not been a big issue yet...

>
>> If the above change was true, then audit will not be able to
>> get any meaning task specific information, you might need to
>> gather such informaiton before hand.
> Hmmm. Would storing that information in bpf_prog_aux work?

I think this is more reliable and actually you might get more
useful information, considering once going to kthread, you will
lose task related information.

>
> - Dave
>
>>
>>>    - Only populate pid, uid and comm if not in a kthread
>>>
>>>   kernel/bpf/syscall.c | 27 ++++++++++++++++++++++-----
>>>   1 file changed, 22 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>>> index 06320d9abf33..fbbaf3b8ad48 100644
>>> --- a/kernel/bpf/syscall.c
>>> +++ b/kernel/bpf/syscall.c
>>> @@ -35,6 +35,7 @@
>>>   #include <linux/rcupdate_trace.h>
>>>   #include <linux/memcontrol.h>
>>>   #include <linux/trace_events.h>
>>> +#include <linux/uidgid.h>
>>>     #include <net/netfilter/nf_bpf_link.h>
>>>   #include <net/netkit.h>
>>> @@ -2110,18 +2111,34 @@ static void bpf_audit_prog(const struct bpf_prog *prog, unsigned int op)
>>>   {
>>>    struct audit_context *ctx = NULL;
>>>    struct audit_buffer *ab;
>>> + const struct cred *cred;
>>> + char comm[sizeof(current->comm)];
>>>      if (WARN_ON_ONCE(op >= BPF_AUDIT_MAX))
>>>    return;
>>>    if (audit_enabled == AUDIT_OFF)
>>>    return;
>>> - if (!in_irq() && !irqs_disabled())
>>> - ctx = audit_context();
>>> +
>>> + ctx = audit_context();
>>>    ab = audit_log_start(ctx, GFP_ATOMIC, AUDIT_BPF);
>>>    if (unlikely(!ab))
>>>    return;
>>> - audit_log_format(ab, "prog-id=%u op=%s",
>>> -  prog->aux->id, bpf_audit_str[op]);
>>> +
>>> + audit_log_format(ab, "op=%s prog-id=%u",
>>> +  bpf_audit_str[op], prog->aux->id);
>>> + audit_log_format(ab, " prog-name=");
>>> + audit_log_untrustedstring(ab, prog->aux->name ?: "(none)");
>>> +
>>> + if (current->mm) {
>>> + cred = current_cred();
>>> + audit_log_format(ab, " pid=%u uid=%u",
>>> +  task_pid_nr(current),
>>> +  from_kuid(&init_user_ns, cred->uid));
>>> + audit_log_format(ab, " comm=");
>>> + audit_log_untrustedstring(ab, get_task_comm(comm, current));
>>> + } else {
>>> + audit_log_format(ab, " pid=? uid=? comm=?");
>>> + }
>>>    audit_log_end(ab);
>>>   }
>>>   @@ -2212,7 +2229,7 @@ static void __bpf_prog_put(struct bpf_prog *prog)
>>>    struct bpf_prog_aux *aux = prog->aux;
>>>      if (atomic64_dec_and_test(&aux->refcnt)) {
>>> - if (in_irq() || irqs_disabled()) {
>>> + if (in_hardirq() || irqs_disabled()) {
>>>    INIT_WORK(&aux->work, bpf_prog_put_deferred);
>>>    schedule_work(&aux->work);
>>>    } else {
>

