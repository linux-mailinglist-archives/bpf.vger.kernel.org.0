Return-Path: <bpf+bounces-9062-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB2C78EE45
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 15:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABBAD1C20ABA
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 13:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319911171B;
	Thu, 31 Aug 2023 13:13:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE64D11713
	for <bpf@vger.kernel.org>; Thu, 31 Aug 2023 13:13:24 +0000 (UTC)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF4410F0
	for <bpf@vger.kernel.org>; Thu, 31 Aug 2023 06:13:01 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bf48546ccfso5228155ad.2
        for <bpf@vger.kernel.org>; Thu, 31 Aug 2023 06:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693487581; x=1694092381; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dg0mv6wz9YAbvEDcqMaitcv0IaqT81YbYJpEkNvvvWE=;
        b=GHXfEgPCVDkE3p1ggesImCIR2AT6GM+n8CyvSrDUwn2RkEdUadiroetpM1UFLD5lvJ
         HooZuuPUBQl83lGenB9D//uIPVqLS8AWe5WrvW5xpHPHYp6GqrKh+rCu3Aw2+v9jiE3l
         JFQBsMDnun3Uc9pgecPOqgTlT+z2lRLaPV1e/Kcmt42f5I826ZioGRncCh/gcU5Dmd53
         iySkjreMFu2KBRYWPVwXJrgvKCmO917MC4bSzbiVVxwGF6UAh4g/gRT4fqgFmwKRTw/6
         EgYmgZyt8pzU6w8h7SQQiilimYtEMR8b3/6ElLZFU24u+KZA2M77jYCT9XM35dAgah2q
         twhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693487581; x=1694092381;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dg0mv6wz9YAbvEDcqMaitcv0IaqT81YbYJpEkNvvvWE=;
        b=I3ruUI6ehuNK7d6pWJ7U+T0KTm0EVyB/rDPhKlSSifVrHsPQCftJ5TLmEUOn9oAJAT
         yxGr5pv4goL8UQhmKwzbRngzadSA63X9Ayb5T2LocbOFk6f05qrOxK15q4MkjTeoJrzY
         7f8lbhaxxgjUuZ3M6F+AZX9Z4HE8LdzjbQZTmoSc27dQBeIflDFtAWFlQLfbcw82sPNK
         Tblp7NekvODZwm4iaV9meY1gWC/1XZ6A9RScqSVdon/r2PCYrg0VtgfuQ657zhgOyUyn
         0eeQHxrp+jflyip+LGPqZolauhsH46mvvAUkw7P4q21hVh3tYK9AJQSWSWB6iuSg8gNW
         TKnA==
X-Gm-Message-State: AOJu0Yyfxa7YghmrPtFHr7drC3eMO1dC4IDBAAouiWrHy9wu852E8V3b
	mLqT8zkJ0mUl/pqgZU3u60c=
X-Google-Smtp-Source: AGHT+IFO2CJ7D06ogu+d/gMN82Cl8O6Ny5rRyHDQC74gWMZ6ko7Rfkr1uYX7RQALRILIg70MN1diIw==
X-Received: by 2002:a17:902:d30d:b0:1b8:9195:1dd8 with SMTP id b13-20020a170902d30d00b001b891951dd8mr4702190plc.51.1693487581018;
        Thu, 31 Aug 2023 06:13:01 -0700 (PDT)
Received: from [192.168.1.12] (bb116-14-95-136.singnet.com.sg. [116.14.95.136])
        by smtp.gmail.com with ESMTPSA id w10-20020a170902e88a00b001bdd512df9csm1230906plg.74.2023.08.31.06.12.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Aug 2023 06:13:00 -0700 (PDT)
Message-ID: <e573b963-891f-0c7e-42d7-c876fa416a8a@gmail.com>
Date: Thu, 31 Aug 2023 21:12:57 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [RFC PATCH bpf-next v3 1/2] bpf, x64: Fix tailcall infinite loop
Content-Language: en-US
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, song@kernel.org,
 bpf@vger.kernel.org
References: <20230825145216.56660-1-hffilwlqm@gmail.com>
 <20230825145216.56660-2-hffilwlqm@gmail.com> <ZOjrviql/e/14X4a@boxer>
 <238be72c-2a19-f675-83cb-18051937d8fd@gmail.com> <ZO/HjKo+x6SU4vXa@boxer>
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <ZO/HjKo+x6SU4vXa@boxer>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
	HK_RANDOM_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/8/31 06:49, Maciej Fijalkowski wrote:
> On Sat, Aug 26, 2023 at 12:03:12PM +0800, Leon Hwang wrote:
>>
>>
>> On 2023/8/26 01:58, Maciej Fijalkowski wrote:
>>> On Fri, Aug 25, 2023 at 10:52:15PM +0800, Leon Hwang wrote:
>>>> From commit ebf7d1f508a73871 ("bpf, x64: rework pro/epilogue and tailcall
>>>> handling in JIT"), the tailcall on x64 works better than before.
>>>>
>>>> From commit e411901c0b775a3a ("bpf: allow for tailcalls in BPF subprograms
>>>> for x64 JIT"), tailcall is able to run in BPF subprograms on x64.
>>>>
>>>> From commit 5b92a28aae4dd0f8 ("bpf: Support attaching tracing BPF program
>>>> to other BPF programs"), BPF program is able to trace other BPF programs.
>>>>
>>>> How about combining them all together?
>>>>
>>>> 1. FENTRY/FEXIT on a BPF subprogram.
>>>> 2. A tailcall runs in the BPF subprogram.
>>>> 3. The tailcall calls itself.
>>>
>>> I would be interested in seeing broken asm code TBH :)
>>>
>>>>
>>>> As a result, a tailcall infinite loop comes up. And the loop would halt
>>>> the machine.
>>>>
>>>> As we know, in tail call context, the tail_call_cnt propagates by stack
>>>> and rax register between BPF subprograms. So do it in trampolines.
>>>>
>>>> Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
>>>> ---
>>>>  arch/x86/net/bpf_jit_comp.c | 32 ++++++++++++++++++++++++++------
>>>>  include/linux/bpf.h         |  5 +++++
>>>>  kernel/bpf/trampoline.c     |  4 ++--
>>>>  kernel/bpf/verifier.c       | 30 +++++++++++++++++++++++-------
>>>>  4 files changed, 56 insertions(+), 15 deletions(-)
>>>>

[SNIP]

>>>>  
>>>> +	if (tgt_prog && tgt_prog->aux->tail_call_reachable) {
>>>> +		subprog = find_subprog_index(tgt_prog, btf_id);
>>>> +		tr->flags = subprog > 0 ? BPF_TRAMP_F_TAIL_CALL_CTX : 0;
>>>> +	}
>>>
>>> I kinda forgot trampoline internals so please bear with me.
>>> Here you are checking actually...what? That current program is a subprog
>>> of tgt prog? My knee jerk reaction would be to propagate the
>>> BPF_TRAMP_F_TAIL_CALL_CTX based on just tail_call_reachable, but I need
>>> some more time to get my head around it again, sorry :<
>>
>> Yeah, that current program must be a subprog of tgt prog.
>>
>> For example:
>>
>> tailcall_subprog() {
>>   bpf_tail_call_static(&jmp_table, 0);
>> }
>>
>> tailcall_prog() {
>>   tailcall_subprog();
>> }
>>
>> prog() {
>>   bpf_tail_call_static(&jmp_table, 0);
>> }
>>
>> jmp_table populates with tailcall_prog().
>>
>> When do fentry on prog(), there's no tail_call_cnt for fentry to
>> propagate. As we can see in emit_prologue(), fentry runs before
>> initialising tail_call_cnt.
>>
>> When do fentry on tailcall_prog()? NO, it's impossible to do fentry on
>> tailcall_prog(). Because the tailcall 'jmp' skips the fentry on
>> tailcall_prog().
>>
>> And, when do fentry on tailcall_subprog(), fentry has to propagate
>> tail_call_cnt properly.
>>
>> In conclusion, that current program must be a subprog of tgt prog.
> 
> Verifier propagates the info about tail call usage through whole call
> chain on a given prog so this doesn't really matter to me where do we
> attach fentry progs. All I'm saying is:
> 
> 	if (tgt_prog && tgt_prog->aux->tail_call_reachable)
> 		tr->flags = BPF_TRAMP_F_TAIL_CALL_CTX;
> 
> should be just fine. I might be missing something but with above your
> selftest does not hang my system.

I think it's unnecessary to propagate tail call usage info when do
fentry on prog(), which is the entry of the whole tail call context. If
do propagate in this case, it's meaningless to execute two extra
instructions.

I confirm that the above selftest is able to hang VM. I copy test_progs
along with tailcall*.bpf.o to another VM, which is Ubuntu 22.04.3 with
kernel 5.15.0-82-generic, then run ./test_progs -t tailcalls. And then
the VM hangs.

Here's the Ubuntu 22.04.3 VM info:
# uname -a
Linux hwang 5.15.0-82-generic #91-Ubuntu SMP Mon Aug 14 14:14:14 UTC
2023 x86_64 x86_64 x86_64 GNU/Linux

Thanks,
Leon

