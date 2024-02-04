Return-Path: <bpf+bounces-21165-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6132C849001
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 20:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98DD71F229E4
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 19:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E48250F4;
	Sun,  4 Feb 2024 19:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xQu+D/Rv"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776B124B23
	for <bpf@vger.kernel.org>; Sun,  4 Feb 2024 19:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707073755; cv=none; b=QCeA5xLDDVQ3VQ9axgeeUBf8S8sHNeETg11SwZhROTknIGTSUJNUA6dLt1MYUfPOmaaZM/1OE88mWh/gMMOrlwGj/MDWd/W32M+uucpqFHVO3qq4T8oxMqnxxyVXrlSj2dLH0uC1Cagw+fsTmiKrIge1BelatX9JJsSyOUn6SPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707073755; c=relaxed/simple;
	bh=poeN/gHbfuAU19dHn4MpQP0hYtQxqaZrPK/A++iOCGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L+1hF3vtUDgr66olyu6ayiwZwUF99ibWF+iwEb6GLCogtfH5JPVPKOgdSpyFrqzJI9uv1wK9A61/wowfxrgsXgAlXu7DcJfSAMigaHdstMFtY9OR4QZBpGCPmywddgnmb7s/iQ44qgDZszMFeuFFz9m/4ztpixPyvrs6RJ2SsXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xQu+D/Rv; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d320eb5c-3276-49f9-879a-fb318164d4f1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707073750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zwLKPMKlWbgxSDeGi6Ie4UWueKqHFMGkPx4Rtc7MF4E=;
	b=xQu+D/Rvpu9Yf96AtlTB0f5qoGw5bkSU6EpaWEqHMBkzrRmtv1WYJbv+vEkqO7sL5ONP7o
	Pq8kU7WvNe4Cgy7rexKhScPsRYJ1TEhKdNY6pQHfJSzetmFn0d7bXHR2HUKxoicS/E614r
	xML3LoPhXwwCW95gTNjcpP4nI2mlBWk=
Date: Sun, 4 Feb 2024 11:09:04 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH] bpf: Prevent recursive deadlocks in BPF programs
 attached to spin lock helpers using fentry/ fexit
Content-Language: en-GB
To: Siddharth Chintamaneni <sidchintamaneni@gmail.com>,
 Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>,
 "andrii@kernel.org" <andrii@kernel.org>, "Williams, Dan" <djwillia@vt.edu>,
 "Somaraju, Sai Roop" <sairoop@vt.edu>, "Sahu, Raj" <rjsu26@vt.edu>,
 "Craun, Milo" <miloc@vt.edu>, "sidchintamaneni@vt.edu"
 <sidchintamaneni@vt.edu>
References: <CAE5sdEigPnoGrzN8WU7Tx-h-iFuMZgW06qp0KHWtpvoXxf1OAQ@mail.gmail.com>
 <ZbjAod-tqcjQJrTo@krava>
 <CAE5sdEg6yUc_Jz50AnUXEEUh6O73yQ1Z6NV2srJnef0ZrQkZew@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAE5sdEg6yUc_Jz50AnUXEEUh6O73yQ1Z6NV2srJnef0ZrQkZew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 2/2/24 4:21 PM, Siddharth Chintamaneni wrote:
> On Tue, 30 Jan 2024 at 04:25, Jiri Olsa <olsajiri@gmail.com> wrote:
>> On Wed, Jan 24, 2024 at 10:43:32AM -0500, Siddharth Chintamaneni wrote:
>>> While we were working on some experiments with BPF trampoline, we came
>>> across a deadlock scenario that could happen.
>>>
>>> A deadlock happens when two nested BPF programs tries to acquire the
>>> same lock i.e, If a BPF program is attached using fexit to
>>> bpf_spin_lock or using a fentry to bpf_spin_unlock, and it then
>>> attempts to acquire the same lock as the previous BPF program, a
>>> deadlock situation arises.
>>>
>>> Here is an example:
>>>
>>> SEC(fentry/bpf_spin_unlock)
>>> int fentry_2{
>>>    bpf_spin_lock(&x->lock);
>>>    bpf_spin_unlock(&x->lock);
>>> }
>>>
>>> SEC(fentry/xxx)
>>> int fentry_1{
>>>    bpf_spin_lock(&x->lock);
>>>    bpf_spin_unlock(&x->lock);
>>> }
>> hi,
>> looks like valid issue, could you add selftest for that?
> Hello,
> I have added selftest for the deadlock scenario.
>
>> I wonder we could restrict just programs that use bpf_spin_lock/bpf_spin_unlock
>> helpers? I'm not sure there's any useful use case for tracing spin lock helpers,
>> but I think we should at least try this before we deny it completely
>>
> If we restrict programs (attached to spinlock helpers) that use
> bpf_spin_lock/unlock helpers, there could be a scenario where a helper
> function called within the program has a BPF program attached that
> tries to acquire the same lock.
>
>>> To prevent these cases, a simple fix could be adding these helpers to
>>> denylist in the verifier. This fix will prevent the BPF programs from
>>> being loaded by the verifier.
>>>
>>> previously, a similar solution was proposed to prevent recursion.
>>> https://lore.kernel.org/lkml/20230417154737.12740-2-laoar.shao@gmail.com/
>> the difference is that __rcu_read_lock/__rcu_read_unlock are called unconditionally
>> (always) when executing bpf tracing probe, the problem you described above is only
>> for programs calling spin lock helpers (on same spin lock)
>>
>>> Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@vt.edu>
>>> ---
>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>> index 65f598694d55..8f1834f27f81 100644
>>> --- a/kernel/bpf/verifier.c
>>> +++ b/kernel/bpf/verifier.c
>>> @@ -20617,6 +20617,10 @@ BTF_ID(func, preempt_count_sub)
>>>   BTF_ID(func, __rcu_read_lock)
>>>   BTF_ID(func, __rcu_read_unlock)
>>>   #endif
>>> +#if defined(CONFIG_DYNAMIC_FTRACE)
>> why the CONFIG_DYNAMIC_FTRACE dependency?
> As we described in the self-tests, nesting of multiple BPF programs
> could only happen with fentry/fexit programs when DYNAMIC_FTRACE is
> enabled. In other scenarios, when DYNAMIC_FTRACE is disabled, a BPF
> program cannot be attached to any helper functions.
>> jirka
>>
>>> +BTF_ID(func, bpf_spin_lock)
>>> +BTF_ID(func, bpf_spin_unlock)
>>> +#endif
>>>   BTF_SET_END(btf_id_deny)

Currently, we already have 'notrace' marked to bpf_spin_lock
and bpf_spin_unlock:

notrace BPF_CALL_1(bpf_spin_lock, struct bpf_spin_lock *, lock)
{
         __bpf_spin_lock_irqsave(lock);
         return 0;
}
notrace BPF_CALL_1(bpf_spin_unlock, struct bpf_spin_lock *, lock)
{
         __bpf_spin_unlock_irqrestore(lock);
         return 0;
}

But unfortunately, BPF_CALL_* macros put notrace to the static
inline function ____bpf_spin_lock()/____bpf_spin_unlock(), and not
to static function bpf_spin_lock()/bpf_spin_unlock().

I think the following is a better fix and reflects original
intention:

diff --git a/include/linux/filter.h b/include/linux/filter.h
index fee070b9826e..779f8ee71607 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -566,6 +566,25 @@ static inline bool insn_is_zext(const struct bpf_insn *insn)
  #define BPF_CALL_4(name, ...)  BPF_CALL_x(4, name, __VA_ARGS__)
  #define BPF_CALL_5(name, ...)  BPF_CALL_x(5, name, __VA_ARGS__)
  
+#define NOTRACE_BPF_CALL_x(x, name, ...)                                              \
+       static __always_inline                                                 \
+       u64 ____##name(__BPF_MAP(x, __BPF_DECL_ARGS, __BPF_V, __VA_ARGS__));   \
+       typedef u64 (*btf_##name)(__BPF_MAP(x, __BPF_DECL_ARGS, __BPF_V, __VA_ARGS__)); \
+       notrace u64 name(__BPF_REG(x, __BPF_DECL_REGS, __BPF_N, __VA_ARGS__));         \
+       notrace u64 name(__BPF_REG(x, __BPF_DECL_REGS, __BPF_N, __VA_ARGS__))          \
+       {                                                                      \
+               return ((btf_##name)____##name)(__BPF_MAP(x,__BPF_CAST,__BPF_N,__VA_ARGS__));\
+       }                                                                      \
+       static __always_inline                                                 \
+       u64 ____##name(__BPF_MAP(x, __BPF_DECL_ARGS, __BPF_V, __VA_ARGS__))
+
+#define NOTRACE_BPF_CALL_0(name, ...)  NOTRACE_BPF_CALL_x(0, name, __VA_ARGS__)
+#define NOTRACE_BPF_CALL_1(name, ...)  NOTRACE_BPF_CALL_x(1, name, __VA_ARGS__)
+#define NOTRACE_BPF_CALL_2(name, ...)  NOTRACE_BPF_CALL_x(2, name, __VA_ARGS__)
+#define NOTRACE_BPF_CALL_3(name, ...)  NOTRACE_BPF_CALL_x(3, name, __VA_ARGS__)
+#define NOTRACE_BPF_CALL_4(name, ...)  NOTRACE_BPF_CALL_x(4, name, __VA_ARGS__)
+#define NOTRACE_BPF_CALL_5(name, ...)  NOTRACE_BPF_CALL_x(5, name, __VA_ARGS__)
+
  #define bpf_ctx_range(TYPE, MEMBER)                                            \
         offsetof(TYPE, MEMBER) ... offsetofend(TYPE, MEMBER) - 1
  #define bpf_ctx_range_till(TYPE, MEMBER1, MEMBER2)                             \
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 4db1c658254c..87136e27a99a 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -334,7 +334,7 @@ static inline void __bpf_spin_lock_irqsave(struct bpf_spin_lock *lock)
         __this_cpu_write(irqsave_flags, flags);
  }
  
-notrace BPF_CALL_1(bpf_spin_lock, struct bpf_spin_lock *, lock)
+NOTRACE_BPF_CALL_1(bpf_spin_lock, struct bpf_spin_lock *, lock)
  {
         __bpf_spin_lock_irqsave(lock);
         return 0;
@@ -357,7 +357,7 @@ static inline void __bpf_spin_unlock_irqrestore(struct bpf_spin_lock *lock)
         local_irq_restore(flags);
  }
  
-notrace BPF_CALL_1(bpf_spin_unlock, struct bpf_spin_lock *, lock)
+NOTRACE_BPF_CALL_1(bpf_spin_unlock, struct bpf_spin_lock *, lock)
  {
         __bpf_spin_unlock_irqrestore(lock);
         return 0;


Macros NOTRACE_BPF_CALL_*() could be consolated with BPF_CALL_*() but I think
a separate macro might be easier to understand.

> Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@vt.edu>
> ---
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 65f598694d55..ffc2515195f1 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -20617,6 +20617,10 @@ BTF_ID(func, preempt_count_sub)
>   BTF_ID(func, __rcu_read_lock)
>   BTF_ID(func, __rcu_read_unlock)
>   #endif
> +#ifdef CONFIG_DYNAMIC_FTRACE
> +BTF_ID(func, bpf_spin_lock)
> +BTF_ID(func, bpf_spin_unlock)
> +#endif
>   BTF_SET_END(btf_id_deny)
>
>   static bool can_be_sleepable(struct bpf_prog *prog)
[...]

