Return-Path: <bpf+bounces-65735-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A39B27AF4
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 10:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08682620CD3
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 08:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B968246798;
	Fri, 15 Aug 2025 08:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5JAoE2z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7AD10E0;
	Fri, 15 Aug 2025 08:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755246524; cv=none; b=JgdjhH3WxZrHeqCalsh+rt/UYUyEH+ALJdtb4cAe9QUTpqDG1rLRYF3IY9sw675lE1LBKAdvKw5+cu5jHqwLhXurlYXP0Z7AiSiHZA6jOq7yNJ5vA5VngZwgr7dQzJzNWIKatTR2Vvb6WpSEcLfxX+Rr46pvG/Q3g+5IOjl+XyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755246524; c=relaxed/simple;
	bh=NN6C5l0rVunPBrtoVVaud5WgDSIvEVNhjhOIo8RFW00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=exdCKOncm3xua8ns4c7HLefyu6cmM0iOyamCn/Uii65xXrq5C2uPpXbDt8LMwtqUi9t5pKE8II6Vk7CZxbKzAxHGh72rMf2si3pnIxlIW0OTzJC+yiR24mqMb6fNGH6ETXlNkVeRE7FBNgu4nC7sZe6Dkrf33ayviQVBXfhhIN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5JAoE2z; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b47156b3b79so1326089a12.0;
        Fri, 15 Aug 2025 01:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755246522; x=1755851322; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PfRZT3luDRUVJDud4XE6LTrUmu/cuJxbL82BBBAAuco=;
        b=f5JAoE2zJ8/3t+cWv9M5WyCWaBBnlJvHkzjQYM3UQs6wATwD0WcHyteGAlu2ocpCp8
         LCPgyqnaeJhRusqe8qvRUL4xsbkZiQ9cBQ2PVPCif5BBiXbmkM04RwIJX8t3FRiknqz/
         RfIc4LZ8FcQ5+MTpFjFem3mVIwP2Vp8JglAEIr6/NVy4cazGFHLjo7+FnECrv/36sQKB
         1OvtNMbSX9OR9XMFHW1PMNbTS3HOiAlgmTsp8HzZuKMuHbV5fI2tLScaulInAxrtp+Jf
         o3bWmRjRdSXR/hdhvZiFwj6td8st4UbhLHm3yqb9bTtNSZMGYL6PPLdLeP1EsB16AaaG
         Ul8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755246522; x=1755851322;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PfRZT3luDRUVJDud4XE6LTrUmu/cuJxbL82BBBAAuco=;
        b=Ui9oRBPbyAvtsoW9ZmWcN5mJGHG7e6OYuNmqWhJvBjKiiotzHT9kz0yGofzW86V9S6
         9bQcLY37x416EvDToMCS21tLJ7EQiechERLIBYsVuQumEHi3AAaFGdS3rY/F+Dd7ivtL
         fbXsYe4ingRUp/3VbxZcvRSdZod2GMvQOBC8dNHXcw9F/UDuuWk79zdwFbg4WON744Nk
         DzdEYsgO1ZwpWbSuRG7asjLcFRC9v8nYWNchAqofQKzrij6bHZbvLDTdrbqG2GShUMPM
         nopQhrsCn4KlbKjEqErhy+Lq/UBko3ie8r+9Tht+Xj0Md5VT/Q3Ss72r9YBbmfExbWpG
         zfTw==
X-Forwarded-Encrypted: i=1; AJvYcCUU6/kUVG91fwexuWSL0Y3a7DWDoSJ/dnCRlXjZhJd7F+H1YmGdn12nBVizBCPw/riqfNEgHMD5Hen2Lvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVPi8obqKJ7NdXWrv1rQ3Z0eMbpdT3km0WCdJNWdYSSTqnbxth
	11PZO2GmBVsHNgNt4p0XlFfdnxzY3bLTMpOavQxbwdbYA5Lh/JgjeiLe
X-Gm-Gg: ASbGnctbC6xJzpIvT6TIJO1esGySAzhykvipj7z/uWLVqQ6gvUNVEqyui7WdZBLOyVd
	JeVlag76JSQuMbfVaFKvDzReODzFjHDPd6NK4z7PMI48H4QlclKtbA6b/3sSM/sxfML0UefOsiB
	Fr5+vmENMO4E8Ymw2hcs3h30BE9Z5PsO+5A+rzoU3opOfOaIq5UbaD/OkGlo8Zq61ZB1/chZz0c
	u9KXPoOKG3R5d2xoGtE6OETQzVEoEpP6Phfu1jpiqzoUhGpFfDNkGtpz/JcEHXhtfx8pXXSDl9x
	gBwme6OAKWa73uiIeD32MBUI63Plt2JW+t5FKqLQv1Qx59AvQuprwx8O8HQfXpZKjp6goBphQex
	KxJPW7TBHUHAplJTbwrql0BNS0yk1KUwIO3o=
X-Google-Smtp-Source: AGHT+IGn0aYWmBZAoWhh9Os2/5vPmDMjXyG9fAC2ArGZXBHisz1NrRDiecrq8Kzfdj3zT8cZ/2UddA==
X-Received: by 2002:a17:902:cccb:b0:243:b81:ac14 with SMTP id d9443c01a7336-2446bd273c6mr22434045ad.11.1755246521844;
        Fri, 15 Aug 2025 01:28:41 -0700 (PDT)
Received: from [10.22.68.127] ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446cb07554sm9121345ad.56.2025.08.15.01.28.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Aug 2025 01:28:41 -0700 (PDT)
Message-ID: <26657aee-588e-41c1-9208-316916e3ce58@gmail.com>
Date: Fri, 15 Aug 2025 16:28:36 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] x86,ibt: Use UDB instead of 0xEA
To: Peter Zijlstra <peterz@infradead.org>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Kees Cook <kees@kernel.org>, alyssa.milburn@intel.com,
 scott.d.constable@intel.com, Joao Moreira <joao@overdrivepizza.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Sami Tolvanen <samitolvanen@google.com>,
 Nathan Chancellor <nathan@kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, ojeda@kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20250814111732.GW4067720@noisy.programming.kicks-ass.net>
 <CAADnVQLyahEsFereM_-Y-MUdWm2mLHNKfffwNKX5Fvy+EaH-Nw@mail.gmail.com>
 <20250815075708.GB3419281@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <20250815075708.GB3419281@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 15/8/25 15:57, Peter Zijlstra wrote:
> On Fri, Aug 15, 2025 at 08:42:39AM +0300, Alexei Starovoitov wrote:
>> On Thu, Aug 14, 2025 at 2:17 PM Peter Zijlstra <peterz@infradead.org> wrote:
>>>
>>> Hi!
>>>
>>> A while ago FineIBT started using the instruction 0xEA to generate #UD.
>>> All existing parts will generate #UD in 64bit mode on that instruction.
>>>
>>> However; Intel/AMD have not blessed using this instruction, it is on
>>> their 'reserved' list for future use.
>>>
>>> Peter Anvin worked the committees and got use of 0xD6 blessed, and it
>>> will be called UDB (per the next SDM or so).
>>>
>>> Reworking the FineIBT code to use UDB wasn't entirely trivial, and I've
>>> had to switch the hash register to EAX in order to free up some bytes.
>>>
>>> Per the x86_64 ABI, EAX is used to pass the number of vector registers
>>> for varargs -- something that should not happen in the kernel. More so,
>>> we build with -mskip-rax-setup, which should leave EAX completely unused
>>> in the calling convention.
>>
>> rax is used to pass tail_call count.
>> See diagram in commit log:
>> https://lore.kernel.org/all/20240714123902.32305-2-hffilwlqm@gmail.com/
>> Before that commit rax was used differently.
>> Bottom line rax was used for a long time to support bpf_tail_calls.
>> I'm traveling atm. So cc-ing folks for follow ups.
> 
> IIRC the bpf2bpf tailcall doesn't use CFI at the moment. But let me
> double check.
> 
> So emit_cfi() is called at the very start of emit_prologue() and
> __arch_prepare_bpf_trampoline() in the BPF_TRAMP_F_INDIRECT case.
> 
> Now, emit_prologue() starts with the CFI bits, but the tailcall lands at
> X86_TAIL_CALL_OFFSET, at which spot we only have EMIT_ENDBR(), nothing
> else. So RAX should be unaffected at that point.
> 
> So, AFAICT, we're good on that point. It is just the C level indirect
> function call ABI that is affected, BPF internal conventions are
> unaffected.
> 

RAX is used for propagating tail_call_cnt_ptr from caller to callee for
bpf2bpf+tailcall on x86_64.

Before the aforementioned commit, RAX is used for propagating
tail_call_cnt from caller to callee for the case.

Thanks,
Leon


