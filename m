Return-Path: <bpf+bounces-9197-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13AD6791A61
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 17:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA8CB280FAB
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 15:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739BAC14C;
	Mon,  4 Sep 2023 15:16:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0FCAD5F
	for <bpf@vger.kernel.org>; Mon,  4 Sep 2023 15:16:02 +0000 (UTC)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB8AAF
	for <bpf@vger.kernel.org>; Mon,  4 Sep 2023 08:16:00 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c1f8aaab9aso11966375ad.1
        for <bpf@vger.kernel.org>; Mon, 04 Sep 2023 08:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693840560; x=1694445360; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zOeGLH4QL+ncHZB/AywMP3FHI0OzIpWPc9Zdw8LtY4s=;
        b=UV7uYrsbKkMXDkQ34zkmrkYKlH3prhBOxC3viir+QAUzQRvUvT7YauVbJ1faquwgPM
         vFvngYTC/a0UEXdAbqowsr85SfqenPuQcoe2Q27iLlnPCE/zqT0KyqZDPZJ/IpzoHRvS
         11z89zMcOR8hF4zLxF7tBW68d+smip7KoD4jqT5Z44Ne1lApjYNHUqkxtwT3CIxlenc0
         /r/tR2KEDhR0EOUZWOAIKyvbmVnSGu/ja7+qcjHSaUox8RiGuKMamqb6bTSdg9tLK0dd
         v/ZDlt3Bnihk+jPVArvuaAnjmjTsbZWJBOlMZ7KSZAptl2H2cpKuCe/by+9LJYfFX1b1
         GsTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693840560; x=1694445360;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zOeGLH4QL+ncHZB/AywMP3FHI0OzIpWPc9Zdw8LtY4s=;
        b=eYxgaw+AotIca04QFJDDjI3TI+F9PhgsBZ3pER9RGYVJ9/Q4kt8LI9jiaNZEMtv3ef
         TR/o/dAsGn7bZ1ckV33Mpbp7P/EMtRbnHJPh2Dx9Qo8FdT2I+Lotx19Zju8GkmL/MQkl
         CAFSRD41a2wEz+Og1QeVSrvlLFWdJBcMQDQot+nuG08V131Ywl/R0nEwtmKlUFBZu/bS
         A8wkiuE1dTxv80FfOAOf3fMu3fCysuQzz64bnMXWuQnxxl5WrHOfhLPNNILlzIWZXibC
         b6uJd2wBbfSkCZm51P3Cto3xmI2ei5ipB9sbMR5USAdVNYeUuzc4lmYfMlXMZJifMldF
         ZwPA==
X-Gm-Message-State: AOJu0Ywae+VzJvCMjqlmNsXrS8ngH5Ycfss5sM+g2faFsjJglEg1ZTIC
	a2htC2GFob4MWwUiei6KJhM=
X-Google-Smtp-Source: AGHT+IF0ZpJBn0iS6LChphJLK/pExuQqzXM7o4cywFEKpfjfCuUzlDSk4U3oe6YQYKpTBk/g2YpE4w==
X-Received: by 2002:a17:903:2452:b0:1c0:c1d7:64ae with SMTP id l18-20020a170903245200b001c0c1d764aemr13356411pls.43.1693840559906;
        Mon, 04 Sep 2023 08:15:59 -0700 (PDT)
Received: from [192.168.1.12] (bb116-14-95-136.singnet.com.sg. [116.14.95.136])
        by smtp.gmail.com with ESMTPSA id iz15-20020a170902ef8f00b001bdd719874esm7766013plb.168.2023.09.04.08.15.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 08:15:59 -0700 (PDT)
Message-ID: <6203dd01-789d-f02c-5293-def4c1b18aef@gmail.com>
Date: Mon, 4 Sep 2023 23:15:55 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [RFC PATCH bpf-next v4 0/4] bpf, x64: Fix tailcall infinite loop
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, maciej.fijalkowski@intel.com
Cc: song@kernel.org, jakub@cloudflare.com, bpf@vger.kernel.org
References: <20230903151448.61696-1-hffilwlqm@gmail.com>
 <aa14035136254ce08bd605242173432394103abd.camel@linux.ibm.com>
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <aa14035136254ce08bd605242173432394103abd.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
	HK_RANDOM_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/9/4 21:10, Ilya Leoshkevich wrote:
> On Sun, 2023-09-03 at 23:14 +0800, Leon Hwang wrote:
>> This patch series fixes a tailcall infinite loop on x64.
>>
>> From commit ebf7d1f508a73871 ("bpf, x64: rework pro/epilogue and
>> tailcall
>> handling in JIT"), the tailcall on x64 works better than before.
>>
>> From commit e411901c0b775a3a ("bpf: allow for tailcalls in BPF
>> subprograms
>> for x64 JIT"), tailcall is able to run in BPF subprograms on x64.
>>
>> From commit 5b92a28aae4dd0f8 ("bpf: Support attaching tracing BPF
>> program
>> to other BPF programs"), BPF program is able to trace other BPF
>> programs.
>>
>> How about combining them all together?
>>
>> 1. FENTRY/FEXIT on a BPF subprogram.
>> 2. A tailcall runs in the BPF subprogram.
>> 3. The tailcall calls the subprogram's caller.
>>
>> As a result, a tailcall infinite loop comes up. And the loop would
>> halt
>> the machine.
>>
>> As we know, in tail call context, the tail_call_cnt propagates by
>> stack
>> and rax register between BPF subprograms. So do in trampolines.
>>
>> How did I discover the bug?
>>
>> From commit 7f6e4312e15a5c37 ("bpf: Limit caller's stack depth 256
>> for
>> subprogs with tailcalls"), the total stack size limits to around
>> 8KiB.
>> Then, I write some bpf progs to validate the stack consuming, that
>> are
>> tailcalls running in bpf2bpf and FENTRY/FEXIT tracing on bpf2bpf[1].
>>
>> At that time, accidently, I made a tailcall loop. And then the loop
>> halted
>> my VM. Without the loop, the bpf progs would consume over 8KiB stack
>> size.
>> But the _stack-overflow_ did not halt my VM.
>>
>> With bpf_printk(), I confirmed that the tailcall count limit did not
>> work
>> expectedly. Next, read the code and fix it.
>>
>> Finally, unfortunately, I only fix it on x64 but other arches. As a
>> result, CI tests failed because this bug hasn't been fixed on s390x.
>>
>> Some helps on s390x are requested.
> 
> I will take a look, thanks for letting me know.

Great.

> I noticed there was something peculiar in this area when implementing
> the trampoline:
> 
> 	 * Note 1: The callee can increment the tail call counter, but
> 	 * we do not load it back, since the x86 JIT does not do this
> 	 * either.>
> but I thought that this was intentional.

I do think so.

But wait, should we load it back?

Let me show a demo:

struct {
	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
	__uint(max_entries, 4);
	__uint(key_size, sizeof(__u32));
	__uint(value_size, sizeof(__u32));
} jmp_table SEC(".maps");

static __noinline
int subprog_tail_01(struct __sk_buff *skb)
{
	if (load_byte(skb, 0))
		bpf_tail_call_static(skb, &jmp_table, 1);
	else
		bpf_tail_call_static(skb, &jmp_table, 0);
	return 1;
}

static __noinline
int subprog_tail_23(struct __sk_buff *skb)
{
	if (load_byte(skb, 0))
		bpf_tail_call_static(skb, &jmp_table, 3);
	else
		bpf_tail_call_static(skb, &jmp_table, 2);
	return 1;
}

int count0 = 0;

SEC("tc")
int classifier_01(struct __sk_buff *skb)
{
	count0++;
	return subprog_tail_01(skb);
}

int count1 = 0;

SEC("tc")
int classifier_23(struct __sk_buff *skb)
{
	count1++;
	return subprog_tail_23(skb);
}

static __noinline
int subprog_tailcall(struct __sk_buff *skb, int index)
{
	volatile int retval = 0;
	bpf_tail_call(skb, &jmp_table, index);
	return retval;
}

SEC("tc")
int entry(struct __sk_buff *skb)
{
	subprog_tailcall(skb, 0);
	subprog_tailcall(skb, 2);

	return 0;
}

Finally, count0 is 33. And count1 is 33, too. It breaks the
MAX_TAIL_CALL_CNT limit by the way tailcall in subprog.

From 04fd61ab36ec065e ("bpf: allow bpf programs to tail-call other bpf
programs"):
The chain of tail calls can form unpredictable dynamic loops therefore
tail_call_cnt is used to limit the number of calls and currently is set
to 32.

It seems like that MAX_TAIL_CALL_CNT limits the max tailcall hierarchy
layers.

So, should we load it back?

Thanks,
Leon

