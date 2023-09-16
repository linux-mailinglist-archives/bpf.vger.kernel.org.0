Return-Path: <bpf+bounces-10199-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BAE37A2E11
	for <lists+bpf@lfdr.de>; Sat, 16 Sep 2023 07:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A726728229A
	for <lists+bpf@lfdr.de>; Sat, 16 Sep 2023 05:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911D763CB;
	Sat, 16 Sep 2023 05:32:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9298833DC
	for <bpf@vger.kernel.org>; Sat, 16 Sep 2023 05:32:20 +0000 (UTC)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5661BD0
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 22:32:18 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-76dc77fd024so184065885a.3
        for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 22:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694842337; x=1695447137; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UcvVr43K+W6XErAFXWrbx4c3igL0L/nUHriR9ClmVHk=;
        b=iJaDqG0BJr/SiF7UbGcyGtNhGcBmXAdpgGscZX05dz7Dc92lzZPWMGR4n+c9dJR9GX
         QQYVD4rH7DHrtE4kIcTyduJM/6pV20WqFrEbIQAqndZLXxmrF/N5Ylyw6Y7xcFHsMPV/
         YBMiCFSS5K5ehTzTAtYbxowlnRNDrLQKHfq5QyOAmIEY6SL471jqmUeBq3M9PQzuaLU1
         vASLiT5I0fhOgghhyr0yA8qJGfRPI3ODzngavJqnFJfO5rCJySThT7QrZgtTiO3RKfTy
         e/LQtgUzf3ka1voamHbbFjtjYgVKILrLfpZ13/CeEKvHBDVkeTj96KihpIe12XxFtgk7
         lpsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694842337; x=1695447137;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UcvVr43K+W6XErAFXWrbx4c3igL0L/nUHriR9ClmVHk=;
        b=uU+gqOfr4Ld4eU5gys6ODswo3WV626YMZm0MkS6CxRndI0i6rhjfxtNAGPycKZGqbk
         onvvsouyIKVoGHgnQxCv9TeVxx7WjZXu6J2OBjt051mEE08ovbrxsUImBmA5TVfVaOJ0
         c380aosvU18VsjWSbO3rUiySfXq2JfwZWcWE9ePdC0qfUzsrr6dD19UcnBkFXdT089Wd
         alhgBCQUXwL4Q+t+DRZYBokQwxDqywVzaRGIlvM1FkZOpM55VVMyxVow9nz4IZDAQANj
         6DuNU/jpoBAfihS5ZQi611Lgj+kZwGQMza89/81y4aBvPXEqpR2iKSkW56vAzjtlXGvA
         IlWg==
X-Gm-Message-State: AOJu0YyQFKeV3tpMHEdpd1zUcgBg0UJFsmLmfm5LLcO4CxFr55B5GJyu
	MOXH9bMqjjwbjIve6vwohCc=
X-Google-Smtp-Source: AGHT+IEigcBC0liFL7OdLUrOaxRYdLcYnOOiR0LKSq1cwknoOzOY+cstbTv0yaZIajlog//3hv1umw==
X-Received: by 2002:a05:620a:254e:b0:76c:8d5f:5954 with SMTP id s14-20020a05620a254e00b0076c8d5f5954mr4088445qko.70.1694842337178;
        Fri, 15 Sep 2023 22:32:17 -0700 (PDT)
Received: from [192.168.1.12] (bb116-14-95-136.singnet.com.sg. [116.14.95.136])
        by smtp.gmail.com with ESMTPSA id g7-20020aa78187000000b0068fc9025a08sm3788098pfi.151.2023.09.15.22.32.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 22:32:16 -0700 (PDT)
Message-ID: <7ca37014-fa82-60d8-082e-01da1517fe84@gmail.com>
Date: Sat, 16 Sep 2023 13:32:13 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH bpf-next v2] bpf, x64: Check imm32 first at BPF_CALL in
 do_jit()
Content-Language: en-US
To: Zvi Effron <zeffron@riotgames.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, tglx@linutronix.de, maciej.fijalkowski@intel.com,
 kernel-patches-bot@fb.com
References: <20230914123527.34624-1-hffilwlqm@gmail.com>
 <CAC1LvL3vTzKx8mcObCKbVJFNVjj0DjS=RF+wytryJZYrqnwhBQ@mail.gmail.com>
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <CAC1LvL3vTzKx8mcObCKbVJFNVjj0DjS=RF+wytryJZYrqnwhBQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
	HK_RANDOM_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/9/16 00:29, Zvi Effron wrote:
> On Thu, Sep 14, 2023 at 7:36 AM Leon Hwang <hffilwlqm@gmail.com> wrote:
>>
>> It's unnecessary to check 'imm32' in both 'if' and 'else'.
>>
>> It's better to check it first.
>>
>> Meanwhile, refactor the code for 'offs' calculation.
>>
>> v1 -> v2:
>>  * Add '#define RESTORE_TAIL_CALL_CNT_INSN_SIZE 7'.
>>
>> Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
>> ---
>>  arch/x86/net/bpf_jit_comp.c | 18 +++++++++---------
>>  1 file changed, 9 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index 2846c21d75bfa..fe0393c7e7b68 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
>> @@ -1025,6 +1025,7 @@ static void emit_shiftx(u8 **pprog, u32 dst_reg, u8 src_reg, bool is64, u8 op)
>>  /* mov rax, qword ptr [rbp - rounded_stack_depth - 8] */
>>  #define RESTORE_TAIL_CALL_CNT(stack)                           \
>>         EMIT3_off32(0x48, 0x8B, 0x85, -round_up(stack, 8) - 8)
>> +#define RESTORE_TAIL_CALL_CNT_INSN_SIZE 7
>>
>>  static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image,
>>                   int oldproglen, struct jit_context *ctx, bool jmp_padding)
>> @@ -1629,17 +1630,16 @@ st:                     if (is_imm8(insn->off))
>>                 case BPF_JMP | BPF_CALL: {
>>                         int offs;
>>
> 
> <snip>
> 
>> +                       if (tail_call_reachable)
>>                                 RESTORE_TAIL_CALL_CNT(bpf_prog->aux->stack_depth);
> 
> <snip>
> 
>> +                       offs = (tail_call_reachable ?
>> +                               RESTORE_TAIL_CALL_CNT_INSN_SIZE : 0);
> 
> I'm not sure which is preferred style for the kernel, but this seems like it
> could be replaced with

I'm not sure either.

> 
> int offs = 0;
> ...
> if (tail_call_reachable) {
>     RESTORE_TAIL_CALL_CNT(bpf_prog->aux->stack_depth);
>     offs = RESTORE_TAIL_CALL_CNT_INSN_SIZE;
> }

I considered this way once.

But, I think the code of the patch is more clean.

> 
> which is easier for my brain to follow because it reduces the branches (in C,
> I assume the compiler is smart enough to optimize). It does create an
> unconditional write (of 0) that could otherwise be avoided (unless the compiler
> is also smart enough to optimize that).

I think, as for gcc -O2, there's no diff between these two ways.

Thanks,
Leon

> 
> Also not sure if the performance difference matters here.
> 
>> +                       offs += x86_call_depth_emit_accounting(&prog, func);
>>                         if (emit_call(&prog, func, image + addrs[i - 1] + offs))
>>                                 return -EINVAL;
>>                         break;
>>
>> base-commit: cbb1dbcd99b0ae74c45c4c83c6d213c12c31785c
>> --
>> 2.41.0
>>
>>

