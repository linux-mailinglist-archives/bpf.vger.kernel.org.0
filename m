Return-Path: <bpf+bounces-37948-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C54F95CDC9
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 15:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F06B1F21CFD
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 13:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D600186E3A;
	Fri, 23 Aug 2024 13:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+q2XWOe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868D3186601;
	Fri, 23 Aug 2024 13:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724419751; cv=none; b=HBD6mrANQfIKPylJ7uJHy2FXTCM3KlR2g2M3SXdBQsgVWPgcy+iIiwJ06LL+CZpYrTBaQcKzPgXQrIAeIrP/2jjK1IdFvCbnb9HRfphTOa0UZkGFiyVVyaVl8WgIF89lBtcgFVDz7IhC2igwEguJzu8y60FzWoO2VzDCVtllM2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724419751; c=relaxed/simple;
	bh=upfjRbQi5d/9KGxy7xIOWRr855B07eT2IifI7j40eNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sLTFIJoDpj9R7aN4ffLHlCSn+vOG3/E+TkThLYAEtKofvxWg4l5iYgJehlcJJMK9npmt7GieoTzlkFPL5BJ4SaKccsRjnXJT9A7y+vo5MAO4DWdjBZmzUz7tmgW/7cGzEyPqyOa2psWrKlywLzeurZQsV3ZyXXjcYkjUaiGdlY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+q2XWOe; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20223b5c1c0so18479355ad.2;
        Fri, 23 Aug 2024 06:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724419749; x=1725024549; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ryf/2ckFdrYuXbTIE9dYAxnCDBL+jejuPnXrTzRMY+c=;
        b=h+q2XWOegHhjzNYr4JRi0OFyThcMocaM5vLAYhPjBJ+pb2RpkjSf1gEfOxqgmGWbap
         l7KC9IAIfhfwB7DNsIEbRQKENONyqfBegelNj4gMt921QEr4X3qxibfZfRZf/A3vv/IP
         LHNNUU78+XAQsI7Po0kwaaIi2+k2nPk0CxKc2w/jEXbMidKrhT+lOXoGNAjTn1ew3jyB
         NtMav2UP2kDwXWybZ5TeZwHrULekgcbocimu0Jl+VxWOBmZpREZWtTmP3ZRT8KWjQzO6
         IiaxeuYLSzUAPyeQPuhvTgFKDrMU0YhlQjmoYcU0fo6dh8AmvjaxdnDfQJ0VfWCRrXpK
         vLUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724419749; x=1725024549;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ryf/2ckFdrYuXbTIE9dYAxnCDBL+jejuPnXrTzRMY+c=;
        b=Cq9vSjOGANadzSYStpQbi0vbTeSiyoXheMLQpEpjaEpObhQX6fVZHMH3vL+zWz8JuZ
         k2CAa7GzJt+Getk3CCsYdZUp0tITq01zigYbTIAv9RlyyfHarMOvtOg/8krBv2bDWh+5
         UwUTyllmIq/DmLooZO+HAH6GprJ3VhbokzY+WB3tpJmz5x8rvu2DpNk31wPooX/BrYq0
         ejyHlTKSWNMLeUSwDWkMvr/AzV0LC7pAjI+uaaO6wxkqmjSgQyp0qil6MGOl9E76OESz
         sQuhGELTxJ8XEDwl/pXbwrF4fbQb4VbDbOy82QjPowfjkqr/TIzmYWgfHVCY1puwnFa/
         OUMA==
X-Forwarded-Encrypted: i=1; AJvYcCUBy/howGaCLihMNmi30F2lP+CLArJqWlboNbmxMhVefbfZLWaXPSyLTLvsWXfaeFnbOWj1SOAch5ta@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbi9SnudDybpWEE/Crg0puTXpa3N33N3XnySbQ/pFvEoGdTuYR
	xfghGSioSWeWiHg+pIfq3IiiAKwCOd1E0AI4Ba7clna19pBtKdk03F3B4Q==
X-Google-Smtp-Source: AGHT+IERjkHPQy4k2IRLHuU2KxaoQgej00BYeiiSX/I0LCFS7aCBGT0lVu54ZCPsUGyc5cgJ0UtpDA==
X-Received: by 2002:a17:902:fa0f:b0:202:19a0:fcb6 with SMTP id d9443c01a7336-2039e6b455dmr20008115ad.60.1724419748641;
        Fri, 23 Aug 2024 06:29:08 -0700 (PDT)
Received: from [192.168.1.76] (bb219-74-23-111.singnet.com.sg. [219.74.23.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855809d4sm28356265ad.95.2024.08.23.06.29.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 06:29:08 -0700 (PDT)
Message-ID: <b010c646-007c-47e3-b547-414e66567ccf@gmail.com>
Date: Fri, 23 Aug 2024 21:29:03 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Problem testing with S390x under QEMU on x86_64
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Tony Ambardar <tony.ambardar@gmail.com>
Cc: bpf@vger.kernel.org, linux-s390@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>
References: <ZsEcsaa3juxxQBUf@kodidev-ubuntu>
 <180f4c27ebfb954d6b0fd2303c9fb7d5f21dae04.camel@linux.ibm.com>
 <ZsU3GdK5t6KEOr0g@kodidev-ubuntu>
 <aa8fe2731224ffdb6d64a014e3e02740c50010cd.camel@linux.ibm.com>
Content-Language: en-US
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <aa8fe2731224ffdb6d64a014e3e02740c50010cd.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024/8/22 01:28, Ilya Leoshkevich wrote:
> On Tue, 2024-08-20 at 17:38 -0700, Tony Ambardar wrote:
> 
> 
> [...]
> 
>> I used the command line:
>>     ./test_progs -d
>> get_stack_raw_tp,stacktrace_build_id,verifier_iterating_callbacks,tai
>> lcalls
>>
>> which includes the current DENYLIST.s390x as well as 'tailcalls',
>> which
>> is also excluded by the kernel-patches/bpf s390x CI. I note the CI
>> excludes several more tests that seem to work. Any idea why that is?
>>
>> For reference, the issue with 'tailcalls/tailcall_hierarchy_count' is
>> an
>> RCU stall and kernel hang:
>>
>> root@(none):/usr/libexec/kselftests-bpf# ./test_progs -v --debug -n
>> 332/19
>> bpf_testmod.ko is already unloaded.
>> Loading bpf_testmod.ko...
>> Successfully loaded bpf_testmod.ko.
>> test_tailcall_hierarchy_count:PASS:load obj 0 nsec
>> test_tailcall_hierarchy_count:PASS:find entry prog 0 nsec
>> test_tailcall_hierarchy_count:PASS:prog_fd 0 nsec
>> test_tailcall_hierarchy_count:PASS:find jmp_table 0 nsec
>> test_tailcall_hierarchy_count:PASS:map_fd 0 nsec
>> test_tailcall_hierarchy_count:PASS:update jmp_table 0 nsec
>> test_tailcall_hierarchy_count:PASS:find data_map 0 nsec
>> test_tailcall_hierarchy_count:PASS:open fentry_obj file 0 nsec
>> test_tailcall_hierarchy_count:PASS:find fentry prog 0 nsec
>> test_tailcall_hierarchy_count:PASS:set_attach_target subprog_tail 0
>> nsec
>> test_tailcall_hierarchy_count:PASS:load fentry_obj 0 nsec
>> test_tailcall_hierarchy_count:PASS:attach_trace 0 nsec
>> rcu: INFO: rcu_sched self-detected stall on CPU
>> rcu:    0-....: (1 GPs behind) idle=4eb4/1/0x4000000000000000
>> softirq=527/528 fqs=1050
>> rcu:    (t=2100 jiffies g=-379 q=20 ncpus=2)
>> CPU: 0 UID: 0 PID: 84 Comm: test_progs Tainted: G           O      
>> 6.10.0-12706-g853081e84612-dirty #111
>> Tainted: [O]=OOT_MODULE
>> Hardware name: QEMU 8561 QEMU (KVM/Linux)
>> Krnl PSW : 0704f00180000000 000003ffe00f8fca
>> (lock_release+0xf2/0x190)
>>            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:3 PM:0 RI:0
>> EA:3
>> Krnl GPRS: 00000000b298dd12 0000000000000000 000002f23fd767c8
>> 000003ffe1848800
>>            0000000000000001 0000037fe034edbc 0000037fe034fd74
>> 0000000000000001
>>            0700037fe034edc8 000003ffe0249e48 000003ffe1848800
>> 000003ffe19ba7c8
>>            000003ff9f7a7f90 0000037fe034ef00 000003ffe00f8f96
>> 0000037fe034ed78
>> Krnl Code: 000003ffe00f8fbe: a7820300           tmhh    %r8,768
>>            000003ffe00f8fc2: a7840004           brc    
>> 8,000003ffe00f8fca
>>           #000003ffe00f8fc6: ad03f0a0           stosm   160(%r15),3
>>           >000003ffe00f8fca: eb8ff0a80004       lmg    
>> %r8,%r15,168(%r15)
>>            000003ffe00f8fd0: 07fe               bcr     15,%r14
>>            000003ffe00f8fd2: c0e500011057       brasl  
>> %r14,000003ffe011b080
>>            000003ffe00f8fd8: ec26ffa6007e       cij    
>> %r2,0,6,000003ffe00f8f24
>>            000003ffe00f8fde: c01000b78b96       larl   
>> %r1,000003ffe17ea70a
>> Call Trace:
>>  [<000003ffe00f8fca>] lock_release+0xf2/0x190
>> ([<000003ffe00f8f96>] lock_release+0xbe/0x190)
>>  [<000003ffe0249ea4>] __bpf_prog_exit_recur+0x5c/0x68
>>  [<000003ff6001e0b0>] bpf_trampoline_73014444060+0xb0/0xd2
>>  [<000003ff60024d14>] bpf_prog_eb7edc599e93dcc8_entry+0x5c/0xc8
>>  [<000003ff60024d14>] bpf_prog_eb7edc599e93dcc8_entry+0x5c/0xc8
>>  [<000003ff60024d14>] bpf_prog_eb7edc599e93dcc8_entry+0x5c/0xc8
>>  [<000003ff60024d2a>] bpf_prog_eb7edc599e93dcc8_entry+0x72/0xc8
>>  [<000003ff60024d2a>] bpf_prog_eb7edc599e93dcc8_entry+0x72/0xc8
>>  [<000003ff60024d14>] bpf_prog_eb7edc599e93dcc8_entry+0x5c/0xc8
>>  [<000003ff60024d14>] bpf_prog_eb7edc599e93dcc8_entry+0x5c/0xc8
>>  [<000003ff60024d14>] bpf_prog_eb7edc599e93dcc8_entry+0x5c/0xc8
>>  [<000003ffe084ecee>] bpf_test_run+0x216/0x3a8
>>  [<000003ffe084f9cc>] bpf_prog_test_run_skb+0x21c/0x630
>>  [<000003ffe0202ad2>] __sys_bpf+0x7ea/0xbb0
>>  [<000003ffe0203114>] __s390x_sys_bpf+0x44/0
> 
> Thanks for the detailed analysis! I will need to port
> 
> commit 116e04ba1459fc08f80cf27b8c9f9f188be0fcb2
> Author: Leon Hwang <hffilwlqm@gmail.com>
> Date:   Sun Jul 14 20:39:00 2024 +0800
> 
>     bpf, x64: Fix tailcall hierarchy
> 
> to s390x to fix this.
> 

Hi Ilya,

I think you should wait for a while, as I'll fix another tailcall issue
in near future. After fixing the issue, you can port them both in one shot.

Thanks,
Leon


