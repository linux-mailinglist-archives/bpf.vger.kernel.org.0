Return-Path: <bpf+bounces-36261-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9999C94579D
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 07:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1021E1F235EA
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 05:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2A02E646;
	Fri,  2 Aug 2024 05:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwFKFkdi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50E21CAB3;
	Fri,  2 Aug 2024 05:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722576916; cv=none; b=fOaNf7hz4wHXCwJ22efTUToJLgK2hN3OizeDye/7e0WRRLOrall24IV1vlJMpZK74odoO/gKXUKLv8hShNoxrefsQStUuQvcAnuNLpUVBhTyYHlN4xgPLGbczbXL0kZp8+4Z9xycSP7d0VBgPLmsPavVyQZYDtNrUHt03/1nx1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722576916; c=relaxed/simple;
	bh=ghlFZWY60Vj//MsnCNPZGKvVI1HR5CTWLZ1dS+pGpP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VwVR7U6jIpqBu+SCzz+X9EZee4DgoT9Eoj1RB54fmrPz8GiFv704ie2Q8nhKLtk20O52og2xWZs1DsemM33Wv58s7duGV8W04xx7W2ENFAA4qewJzCe57xarQ+PPNiBpG/l3/IZCwt0P/qPrB750cLBMEqSi3xhzDEwuMv1bKOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UwFKFkdi; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7106cf5771bso814650b3a.2;
        Thu, 01 Aug 2024 22:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722576914; x=1723181714; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TZQoHgAzEUKdf271aj7GmUNsMJGjbJxHx2mZmXNAzV4=;
        b=UwFKFkdiSiYq8MKKsuLDcFP4EdXUEC3g8w/U924z5mY0IfZDFz/EhdlsS0b8GTUT+z
         qkUbJUTqqBfN/LcYIJZrW6Cm7Kcjdy2M0W3Z/uFhlzsBk+/tyLZas38V0utKFnX3DqwX
         p5UzkJmkoyt8uJkDqnGDE7Hue/vCSJwmvkkXagN0ReThcyi4e748gR4TFvWbBcjUsljb
         /dwjSoHaxzdH2yDM2m1Vx4TodT23N/WiMwdBzGtTOTW8IRFqHvTUahfqghNApuUeiaR4
         h7ESEcPqqQmo4X/JqffTBz0Ljjs96p3j0u7THVIDfhrJKHVDyfmF1R9/MPZoEuzwLjgk
         +j4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722576914; x=1723181714;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TZQoHgAzEUKdf271aj7GmUNsMJGjbJxHx2mZmXNAzV4=;
        b=A4s546L3o+fNDjKBBLWBOx/vv7CYk0ufF8DkhU1R6FmrE/Hrg/qePiBVP/n/2Batvg
         m2KOtAcCw/kaqZyHOcDlAOrZXlbgNoSU44Ke792ECp1a9vo7st/lk2/fr2gvYtFPq2Fx
         HqBOwlJzt5QNkajTbe8VqQ5TvaPh8c52igMzJdKLp1kTmcjM3pLBttsn+Qpmy6RhNDUl
         4ThaH9GahpUJ6pwlecVvElZv5PPlOnh/CvN++ICSIbP9q1Q5Xn814MvSGzOjA56amZo+
         KmgXp4ShzMcJn0RR1f9Z0/+7i8TsfM8+SWZDrq7x7m7F1gi308SdZFRQqRwyw6GInJ6t
         DKjw==
X-Forwarded-Encrypted: i=1; AJvYcCX1fpyY4saf+4qNr1iUXC2N7QYA48qleF0fHV1PWASjOiQ/kZsFhOk0X5o/fR57No/vEZey4xn3/8NOTPdIP7ltWsgjP6d/MxJnqmZCJFahwBhFLLKAv+e/w7tw5PcBaOW9
X-Gm-Message-State: AOJu0YzICYUKpBm+ltp2m6yJEFhAXXa0DuxJvx+WEetfJ4QvMozkgqzb
	3EUE0nOc5V9VgU6Ei/zY6IeLdaoa6CgkbfDgMWcz17DqYCimFza3
X-Google-Smtp-Source: AGHT+IFAruCA5WH9Ek0qO5QAEQUPU8dklz3HucAfnEQ8UHFLgTFdD9VWkrdnWQqEGpyFKx3iBKC0Uw==
X-Received: by 2002:a05:6a21:680b:b0:1c4:e365:1ccd with SMTP id adf61e73a8af0-1c699559f71mr2792722637.22.1722576913777;
        Thu, 01 Aug 2024 22:35:13 -0700 (PDT)
Received: from [10.22.68.119] ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff592ad9efsm8179615ad.284.2024.08.01.22.35.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 22:35:13 -0700 (PDT)
Message-ID: <19097c64-7dce-479a-8123-2d0be20a0927@gmail.com>
Date: Fri, 2 Aug 2024 13:35:08 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] bpf: Add bpf_check_attach_target_with_klog
 method to output failure logs to kernel
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, Zheao Li <me@manjusaka.me>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240725051511.57112-1-me@manjusaka.me>
 <08e180da-e841-427d-bed6-3ba8d73e8519@linux.dev>
 <c7952df9-5830-45d3-89bb-b45f2b030e24@gmail.com>
 <6511ce2a-1c7d-497c-aeb6-d4f0b17271ed@linux.dev>
 <2c6b1737-0a96-44ed-afe9-655444121984@gmail.com>
 <CAEf4BzbL0xfdCEYmzfQ4qCWQxKJAK=TwsdS3k=L58AoVyObL3Q@mail.gmail.com>
 <0f5b7717-fad3-4c89-bacf-7a11baf7a9df@gmail.com>
 <CAEf4BzZCz+sLuAUF65SaHqPUemsUb0WBhAhLYoaAs54VfH1V2w@mail.gmail.com>
 <a1ba10df-b521-40f7-941f-ab94b1bf9890@gmail.com>
 <CAEf4BzZhsQeDn8biUnt9WXt6RVcW_PPX76YFyZo6CjEXGKTdDg@mail.gmail.com>
 <9f68005d-511f-4223-af8f-69fb885024a1@gmail.com>
 <CAEf4BzbzM85_946eB95e9U6stknBh4ucLMKVo5SEqUsihe4K1A@mail.gmail.com>
 <951159c7-08b1-4b15-9dd7-e1a6589ce2ce@gmail.com>
 <CAEf4BzbbyojuFSS7xQ3+jZb=dHzOaZfMbtT+WnypW2LPwOUwRw@mail.gmail.com>
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <CAEf4BzbbyojuFSS7xQ3+jZb=dHzOaZfMbtT+WnypW2LPwOUwRw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2/8/24 00:59, Andrii Nakryiko wrote:
> On Tue, Jul 30, 2024 at 8:31 PM Leon Hwang <hffilwlqm@gmail.com> wrote:
>>
>>
>>
>> On 31/7/24 01:28, Andrii Nakryiko wrote:
>>> On Mon, Jul 29, 2024 at 8:32 PM Leon Hwang <hffilwlqm@gmail.com> wrote:
>>>>
>>>>
>>>>
>>>> On 30/7/24 05:01, Andrii Nakryiko wrote:
>>>>> On Fri, Jul 26, 2024 at 9:04 PM Leon Hwang <hffilwlqm@gmail.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 2024/7/27 08:12, Andrii Nakryiko wrote:
>>>>>>> On Thu, Jul 25, 2024 at 7:57 PM Leon Hwang <hffilwlqm@gmail.com> wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>
>>>> [...]
>>>>
>>>>>>>>
>>>>>>>> Is it OK to add a tracepoint here? I think tracepoint is more generic
>>>>>>>> than retsnoop-like way.
>>>>>>>
>>>>>>> I personally don't see a problem with adding tracepoint, but how would
>>>>>>> it look like, given we are talking about vararg printf-style function
>>>>>>> calls? I'm not sure how that should be represented in such a way as to
>>>>>>> make it compatible with tracepoints and not cause any runtime
>>>>>>> overhead.
>>>>>>
>>>>>> The tracepoint is not about vararg printf-style function calls.
>>>>>>
>>>>>> It is to trace the reason why it fails to bpf_check_attach_target() at
>>>>>> attach time.
>>>>>>
>>>>>
>>>>> Oh, that changes things. I don't think we can keep adding extra
>>>>> tracepoints for various potential reasons that BPF prog might be
>>>>> failing to verify.
>>>>>
>>>>> But there is usually no need either. This particular code already
>>>>> supports emitting extra information into verifier log, you just have
>>>>> to provide that. This is done by libbpf automatically, can't your
>>>>> library of choice do the same (if BPF program failed).
>>>>>
>>>>> Why go to all this trouble if we already have a facility to debug
>>>>> issues like this. Note every issue is logged into verifier log, but in
>>>>> this case it is.
>>>>>
>>>>
>>>> Yeah, it is unnecessary to add tracepoint here, as we are able to trace
>>>> the log message in bpf_log() arguments with retsnoop.
>>>
>>> My point was that you don't even need retsnoop, you can just ask for
>>> verifier log directly, that's the main way to understand and debug BPF
>>> program verification/load failures.
>>>
>>
>> Nope. It is not about BPF program verification/load failures. It is
>> about freplace program attach failures instead.
> 
> Ah, my bad, it's at an attach time. Still, I don't think a tracepoint
> for every possible failure will ever work. Perhaps the right approach
> is to wire up bpf_log into attach commands (LINK_CREATE, at least), so
> that the kernel can report back what's the reason for declining
> attachment?
> 

OK. Let me take a try.

Thanks,
Leon

