Return-Path: <bpf+bounces-55931-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1978CA89736
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 10:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E8DB3BA294
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 08:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDE927F750;
	Tue, 15 Apr 2025 08:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/uIJOrO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CE427A934
	for <bpf@vger.kernel.org>; Tue, 15 Apr 2025 08:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744707303; cv=none; b=bukl88jHk2FqDbmewZXLQd4ou3+i8IoBDy7FGskTPUiLI320kczHda3SH22YDrwd51u86tOqHIHit43G4jU929jDjIBPPu9z9urEnlJ0XpS4nZ3K+EpXxAIu/l2M3TQlTN254+sxtQXM60Suk4/+2SyMw2a5GSkr02jtjKhrUyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744707303; c=relaxed/simple;
	bh=RSqWOdoFr0u66m5eQa01m+O5DLVAmNRlh5QbF0HmMXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rT6tmxFv2732dX9zMTs2kM5Gt0edlSuEOnf9vX9UwaA6JY645YyBnxVrP8upvbRcBauAj01FtoWHZJlXADH7rhlpfBKbewXcnkJy0Qcmyckx0OhvCMSnuw5gHW68mKqvBYiIrZDSzLCEvksjJHr2IJsd0FUoOaFJZnxKlxYoqBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f/uIJOrO; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-39c1efc457bso3480194f8f.2
        for <bpf@vger.kernel.org>; Tue, 15 Apr 2025 01:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744707299; x=1745312099; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NaWFPSspZuLK4FBCBF9Z4n8Z4KQi2qnKP4PHZXiiDwo=;
        b=f/uIJOrO4K0ASwshJwyxTv75R1FtRI5zTjg2QdDCABOu19ol5x/4R0LbAPoZLRWS6n
         pbfG7zeakrgVoqWMVsSthHDY7kSkLTKcGvD5LCXF06dZ10495O7MVgz/TIaPJLPNINtF
         DkChAiDXkq2CfbjZMWoiZt1ocyjBPFzUac7rNGpXEHvwRps4aV/kj7v0BQ/zvoUGtobU
         1gasUNUU5qaD1aQDmdBzwcp1QHwLP3x3x2h1DF52P+lP4og/XwSeN6B/43ashKMzRjd5
         VLM3nXXDWg62yUEEHBP2E2kHkOWDIj3KyjGdYB951oDVgRSupCc2BJ0k2TS7HKYrWROr
         MlYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744707299; x=1745312099;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NaWFPSspZuLK4FBCBF9Z4n8Z4KQi2qnKP4PHZXiiDwo=;
        b=uDsmTMjymdUmjXRTDNdhAft+b3gbPHyCL069WoeA8ZRxFOmdJQC8t5HW70Eu4ZBSKr
         ZSQgzZHx9z2D2XEv2udWQKVBV+RcJrH5HzxR0TkGDWw4tBmONmFQVGolL52EjFQp+Yl1
         ee8wDqnOr4x/5Uxq4hmNrFu4D65WKz8kKZM5hsCeXJ27cCNkfOsP3bIO0Aq4FjjxKalu
         qaP7XFTI52SH9cAPGFoaOvRtGBMiTYZRbjXnartvUw73RIWzKGyzVOSoJkZqfmNrFUhe
         sGoVkm2oOvuCsm1OenxYhVf5EBs5x6gSzaMvWkMiWh/Ecqx0Y5CklbDlGwxImr7v77MH
         L0nQ==
X-Gm-Message-State: AOJu0YySYzeVeWL9TjqFlavUx4N+CZmjSfTUJ+tOfviQmc7boFkgsjO/
	wNdK9xOdWSVWWCz80AY4Q1g1ZNwKBuzXNWe8R1/iPi4hcCvxzjTk
X-Gm-Gg: ASbGncs36lNWxiJQ1U3148JYvZjLeVHJ/igQ15yvYG4VC9xogqKLKfr+06fCLTUNkLe
	7I07nbyYM8CzAfPj5w8EUk7PoChh61zZogZb0HX66S5UVWcb379/v929z377wN5uR84RqXS7EXt
	rWLvwQD+x3uMcOCuc73tg3dOL7BQyqLchJNeDem5NlA9LjHi9CRgEv7UbH5qZQ8OoNg5LouAR/3
	FSCerDiXusvAv+26ShFm+l38G7rVdMIretzGZycqGyvyugcHAG4xMoQUq362rXSYY0eE83vG6IO
	dnYoq+KvmPyGx8fZdZNtsV/hzeZ4UXYzU0A+5B854TS3Lv2EE58UG6BjxFlGKbOAyycSiphNTU6
	RBTb4pX45P1bHaH7d46gxBRVWFTimuRwIFr6Mz4YqQEnqxoK5mPjJ1/bkiIqBDHIplCv5cQ==
X-Google-Smtp-Source: AGHT+IHEtXUQK+b0IsoXTcTy6AUsrPVAwie0F8qOWBDqstmBjNH106GtVPYQoJw4MfnvKZkjaqH/RQ==
X-Received: by 2002:a05:6000:1865:b0:39c:1424:2827 with SMTP id ffacd0b85a97d-39ea5200a08mr13114101f8f.15.1744707299327;
        Tue, 15 Apr 2025 01:54:59 -0700 (PDT)
Received: from ?IPV6:2003:ed:7734:bbff:9028:3352:1f33:d30d? (p200300ed7734bbff902833521f33d30d.dip0.t-ipconnect.de. [2003:ed:7734:bbff:9028:3352:1f33:d30d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae963f2bsm13823419f8f.18.2025.04.15.01.54.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 01:54:58 -0700 (PDT)
Message-ID: <13ff2689-a17a-4403-8399-7c04d40e8c93@gmail.com>
Date: Tue, 15 Apr 2025 10:54:57 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: filter: remove dead instructions in filter
 code
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <525d54bc-5259-49f2-acbf-7396bab48dec@gmail.com>
 <CAADnVQ+ip7yB-8deWjHNBQxZHhV1Xi-5gTiYJVRy4gU5+Chkqw@mail.gmail.com>
 <aa2e2b6f-5db8-4ef9-bad9-dddf699afae5@gmail.com>
 <CAADnVQJD1yc=ymX54fjON9ti4DpzOy7M10YE2T1nw750f3FcFQ@mail.gmail.com>
Content-Language: en-US
From: Lion Ackermann <nnamrec@gmail.com>
In-Reply-To: <CAADnVQJD1yc=ymX54fjON9ti4DpzOy7M10YE2T1nw750f3FcFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 4/11/25 5:20 PM, Alexei Starovoitov wrote:
> On Thu, Apr 10, 2025 at 11:24 PM Lion Ackermann <nnamrec@gmail.com> wrote:
>>
>> On 4/10/25 5:05 PM, Alexei Starovoitov wrote:
>>> On Thu, Apr 10, 2025 at 1:32 AM Lion Ackermann <nnamrec@gmail.com> wrote:
>>>>
>>>> It is well-known to be possible to abuse the eBPF JIT to construct
>>>> gadgets for code re-use attacks. To hinder this constant blinding was
>>>> added in "bpf: add generic constant blinding for use in jits". This
>>>> mitigation has one weakness though: It ignores jump instructions due to
>>>> their correct offsets not being known when constant blinding is applied.
>>>> This can be abused to construct "jump-chains" with crafted offsets so
>>>> that certain desirable instructions are generated by the JIT compiler.
>>>> F.e. two consecutive BPF_JMP | BPF_JA codes with an appropriate offset
>>>> might generate the following jumps:
>>>>
>>>>     ...
>>>>     0xffffffffc000f822:    jmp    0xffffffffc00108df
>>>>     0xffffffffc000f827:    jmp    0xffffffffc0010861
>>>>     ...
>>>>
>>>> If those are hit unaligned we can get two consecutive useful
>>>> instructions:
>>>>
>>>>     ...
>>>>     0xffffffffc000f823:    mov    $0xe9000010,%eax
>>>>     0xffffffffc000f828:    xor    $0xe9000010,%eax
>>>>     ...
>>>
>>> Nack.
>>> This is not exploitable.
>>> We're not going to complicate classic bpf because of theoretical concerns.
>>>
>>> pw-bot: cr
>>
>> This is not a theoretical concern, it is actually very practical. Sorry
>> for not making this clearer. I would rather not share full payloads
>> publicly at this point, though.
> 
> Do share.

I am not sure if sharing adds any particular value here. The mitigation
targets the 5-byte-variant of the x86 jmp instruction as stated above.
You would only get more examples of the same instruction.
Also note that the mitigation does not prevent the 2-byte-variant.
Beside jumps, there are a couple of other possible instructions that
allow a 1 byte payload encoding, so I did not bother.

> JIT spraying is nothing new. Blinding only made it harder.
> There are lots of usable gadgets without it as well.
> Turn off JIT completely and nothing changes from security pov.

True, the proposal only has an effect if blinding+jit is enabled. 
Otherwise it's useless.
If that is not good enough to add complexity to the cBPF code, then
I suppose we should take this back to the drawing board?

Thanks,
Lion


