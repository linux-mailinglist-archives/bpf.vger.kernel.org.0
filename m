Return-Path: <bpf+bounces-28645-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 235D88BC4B6
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 01:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20629B20F6A
	for <lists+bpf@lfdr.de>; Sun,  5 May 2024 23:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A120614037D;
	Sun,  5 May 2024 23:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mEZA2dnC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A81374CB;
	Sun,  5 May 2024 23:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714951125; cv=none; b=Yh8ZA5LowMKu7SqaQQsQCL9kteJtGDAMW/3h/4DNRm3vsady5sXRpCg9qNSshJt5WOzFcz4Sb6G8Cep1BeGM9//dWuaPFaVc8G6hMxxjPjufNrhJkVNUafLjnwGLjTJJIFVVWH9ANFbaGoG/y3wY14k8Dl4ECa/XZ0mfj9doDoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714951125; c=relaxed/simple;
	bh=QMSm7gaIeCSBJ9AJO+66XOh2Au8JkP9LSoqn5IaB/9A=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Sxlr4pL7xxxzaQ4CUEHNz/GHR8ngqtbivpd6Sz7C0wTzGqauXiTQGyR0IPvmGBlvXHTR2i3iiiqT3d+Sd3dFfqO1FbnzV0xwX8JLYDG4pxAXa7vZbWpFuclZQ4W1dS0Y6yLfueYzlW6EmdCcz5goztCL5t0shdy2IxzSpgEeqOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mEZA2dnC; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6f44dc475f4so746396b3a.2;
        Sun, 05 May 2024 16:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714951123; x=1715555923; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=LhtBH+zVyaq0jwB0WYt/7fS9n7RE1Ufjplzj1peE8As=;
        b=mEZA2dnCrxxMvE0DQ+4TjByOI91bTSQQgC10JQMjCIja9epj6oXhfCUghS6YjuFHVn
         B7Ir4HLlDDjST63tz7AKzXIwNTpwe8vDK6b5IIJCGK6GIKZ1WmM/4dl/vXS1DpCfXCOk
         dbPKoQHBLsMcLh1yEZCsYhaw31lH8OfhgDf6Xhs2yN3eVlGZ2eIiqeud24D9zDOx60LB
         Yg2qF38S9L5WnKMeW2MRLoCBrhSTtpK9o+6SflOi7n0WuG0yuBjaIE8lU4ROYusB62Qm
         OFXFzRwiL7Gd4C5/szUPt1Lp3nJyu9dylPIROjA/RUl9Wk8SBd/23TCfyBh1N/g0WfRx
         DOfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714951123; x=1715555923;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LhtBH+zVyaq0jwB0WYt/7fS9n7RE1Ufjplzj1peE8As=;
        b=Z8IYTV5UnCwV8l5WUH2IOgkmsYbgOjhXUS260gVbsRKD0Wvzf1vb9TzAh6ezgYYlhU
         aCjds4uA+SnxTEigka1R4rXOAZS0HQQnPlHRJ72wvNaVEXghZZ3NPpjhGxrxMXw1aoJA
         Nte/2i8//k9Lku2JTmIw9IcvzLt5jaUTYhqEAuomF2Eu2IaiTlOS7u1AG9y1Fwkco1KF
         txvJgov+DXSNzFRTiraXgXI8d8bEhaMxt5B1Vx0LzBsHfkiALs4jxgS069HLd25mHyxQ
         0AmqtKRBY4apjJvYhlkInR9VxbvNa/7f3ic0MKg3dgffrRsBewv0quNcuDWQgmmfwBa8
         7LBQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9L9adZqq1jjjsYWhApW4P69fD/3cyYQjeekMU8hhIZHZXnWajuzOECcIW6l2tGqMOI+/DTxNhOQ7PBPrIgQb6rSRSQeZ0GpNIXq7OO5NUZAfq2K0suZyo9H7XMcIfKs9m
X-Gm-Message-State: AOJu0YyCbspw0K7noohAD7fDKfAXs9RLT03AJ734vEYkz75h657ApxXk
	UTQTvfZEWB9t90nZYcQ3xpe9p32pWgPK5Fq16DsayHgB38z2WN0K6lQM41Vf
X-Google-Smtp-Source: AGHT+IGhg2JNE2Pvb9EwWEOu9e9/ZpZX0ZQ0u9i6x9vpUbIw0DzfUJ4PPZuLYIXQ9r4W0EK/rWLOvQ==
X-Received: by 2002:a05:6a00:3d06:b0:6e7:20a7:9fc0 with SMTP id lo6-20020a056a003d0600b006e720a79fc0mr9987637pfb.34.1714951123078;
        Sun, 05 May 2024 16:18:43 -0700 (PDT)
Received: from [192.168.7.110] ([190.196.101.184])
        by smtp.gmail.com with ESMTPSA id jw12-20020a056a00928c00b006f4669f0b2asm2223562pfb.134.2024.05.05.16.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 16:18:42 -0700 (PDT)
From: Camila Alvarez Inostroza <cam.alvarez.i@gmail.com>
X-Google-Original-From: Camila Alvarez Inostroza <calvarez@macbook-pro-de-camila.local>
Date: Sun, 5 May 2024 19:18:39 -0400 (-04)
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
cc: Camila Alvarez <cam.alvarez.i@gmail.com>, 
    Alexei Starovoitov <ast@kernel.org>, 
    Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, 
    syzbot+d2a2c639d03ac200a4f1@syzkaller.appspotmail.com
Subject: Re: [PATCH] fix array-index-out-of-bounds in
 bpf_prog_select_runtime
In-Reply-To: <CAADnVQ+Y5k0XMytXo9CLGYDUnVNXcgtz+2mTLUdS-yWV7JDjeQ@mail.gmail.com>
Message-ID: <43a0853d-e7f3-702b-e7c4-f360ae1e3a70@macbook-pro-de-camila.local>
References: <20240505014641.203643-1-cam.alvarez.i@gmail.com> <CAADnVQ+Y5k0XMytXo9CLGYDUnVNXcgtz+2mTLUdS-yWV7JDjeQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1612698177-1714951122=:93655"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1612698177-1714951122=:93655
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT



On Sun, 5 May 2024, Alexei Starovoitov wrote:

> On Sat, May 4, 2024 at 6:49 PM Camila Alvarez <cam.alvarez.i@gmail.com> wrote:
>>
>> The error indicates that the verifier is letting through a program with
>> a stack depth bigger than 512.
>>
>> This is due to the verifier not checking the stack depth after
>> instruction rewrites are perfomed. For example, the MAY_GOTO instruction
>> adds 8 bytes to the stack, which means that if the stack at the moment
>> was already 512 bytes it would overflow after rewriting the instruction.
>
> This is by design. may_goto and other constructs like bpf_loop
> inlining can consume a few words above 512 limit.
>

Is this the only case where the verifier should allow the stack to go over 
the 512 limit? If that's the case, maybe we could use the extra stack 
depth to store how much the rewrites affect the stack depth? This would 
only be used to obtain the correct interpreter when 
CONFIG_BPF_JIT_ALWAYS_ON is not set.
That would allow choosing the interpreter by considering the stack depth 
before the rewrites.

>> The fix involves adding a stack depth check after all instruction
>> rewrites are performed.
>>
>> Reported-by: syzbot+d2a2c639d03ac200a4f1@syzkaller.appspotmail.com
>
> This syzbot report is likely unrelated.
> It says that it bisected it to may_goto, but it has this report
> before may_goto was introduced, so bisection is incorrect.
>
> pw-bot: cr

I can see that may_goto was introduced on march 6th, and the first report 
was on march 13th. Is there any report I'm missing?

>
>> Signed-off-by: Camila Alvarez <cam.alvarez.i@gmail.com>
>> ---
>>  kernel/bpf/verifier.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 63749ad5ac6b..a9e23b6b8e8f 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -21285,6 +21285,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
>>         if (ret == 0)
>>                 ret = do_misc_fixups(env);
>>
>> +        /* max stack depth verification must be done after rewrites as well */
>> +        if (ret == 0)
>> +                ret = check_max_stack_depth(env);
>> +
>>         /* do 32-bit optimization after insn patching has done so those patched
>>          * insns could be handled correctly.
>>          */
>> --
>> 2.34.1
>>
>
--0-1612698177-1714951122=:93655--

