Return-Path: <bpf+bounces-36112-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A75942510
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 05:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49A262826AA
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 03:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EBA17BC9;
	Wed, 31 Jul 2024 03:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2HsWDmV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FB2C2FD;
	Wed, 31 Jul 2024 03:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722396715; cv=none; b=eYqyOq3AjgtUPQxbR6aZRGIJV7XFGB55gwXfO6SddkRZ5rYWLROrwYecsk8dTwZpelhkcgbjnAd0VbvjtC5IeIrxkiHk3ge5kHldrHvdSl5+UNs58D0YQovi+BXKaM2CFIF2VcHtI2Rg+ZMHGL2k0gml6+/27F5hh9z1AEGlCfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722396715; c=relaxed/simple;
	bh=XvXFo1dDg3mz3aL0RNU5/2TG9CgPF8HCQws1wDTWoVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JCx72zkrDnKcvUcBpGzmPKsKKwqmffpmM0HjfsmS0cxHIS5hMBpxLzCkBmZiXMRtWlhUGkjZVpAPp6CmXJ1Gw7aPdzLMNhrZa8LgkfASUJubamdcnaiU6jOxCSw1eMPDmX65GaFXUqeSKCTjrK1PzPEEbKjwp4Q+LclIWMxlPvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j2HsWDmV; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fc611a0f8cso36623445ad.2;
        Tue, 30 Jul 2024 20:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722396713; x=1723001513; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ibnjRw7H0Wws8DNw89t3KjRGp/go3YY1y6G2vXkkQQU=;
        b=j2HsWDmVLPsna0rZeRYvXX/X8Wz8DngBNPTGcB2QDC8KIyisjjnGX2cBA03Pi/wdHJ
         5JlEPqzhM6wd0vKRPgXuGwJeMEhN7QHRqz6PmaYE24gCkRUa701b/GoLnfw19HwDnjdl
         4EExvsNaKtaRjwHqMexnegwLqQwNVAwAxvySQaUkFRntlNk0nU6OF5ohy+AsyGfQ14zd
         4EOD4kdyzfzoK5FBR5V6K5X8SCZ+y37EUnfB6y7vR58FR7eTFUg5urf7wa8/+WiNQoQ5
         gwmPnVjVOoXAOgSTN1tjmAeHwPkUGJysQGe0jdlvelqhuNxgbAu9PU9OWC72uwZC8mOM
         Lo0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722396713; x=1723001513;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ibnjRw7H0Wws8DNw89t3KjRGp/go3YY1y6G2vXkkQQU=;
        b=K06XzEDzLhELWlQdLR4hh2r3YWe06rpPkbjyp/QFxCFCwCyYP7LThrJErs0d/AeiLI
         YeFgYC82l5fC49JrcLWKGHGfo7/+AkHf4s/OiXxyzy37YZwunzaanO4mf8Jlu+X1TT/t
         L7ibctFs1EgZ23KyHQdp6q86AC5eWDPojYih+TY1w90tu07auwBEO2o0ckHh0MAyE7Wm
         cZlukDxhhAvPUw8uzXo00F2kp3C3PIrtF1SQbPwdqQvzN1Osgw4xuYwdSdboyQtYpy7D
         DJ8TTxhiHTV6U/Wqa4LSWi+PpM1/xMQm6zeSE0KIasTBQLj6lWyc300a5mfSX11U4y7A
         dinQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOdpnkYJ2VL1bJ/ZTpHylTJ/j+27WtVgt4//so3MGdC3hjNAOmHai5afoqW82GMjjiHzQUCvoyZ3ZDaYXJexanPr5eeyDWKOshX5HaSV+jDt5XVCg1yJUC2tVSzn6APFAY
X-Gm-Message-State: AOJu0YyvqiWZX/LTPZNRQln02P7JgqghIb9Jvwl9pz51tT4pj+f9I6Rc
	FAW1oZXVyKLWLh+88xOy7+wmT1agjby9KZDYXHKsJC0dKfO84n8L
X-Google-Smtp-Source: AGHT+IEaoekWqJwTIjl8+48w6QbeFW4fvuEfA0KB5bPiO0nbnwJb8v1psWAv/ZPfpaREA1ziY9/0sg==
X-Received: by 2002:a17:902:d488:b0:1fb:3107:ec45 with SMTP id d9443c01a7336-1ff048dcb7dmr116698195ad.54.1722396713005;
        Tue, 30 Jul 2024 20:31:53 -0700 (PDT)
Received: from [10.22.68.119] ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ff9086sm109827265ad.302.2024.07.30.20.31.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 20:31:52 -0700 (PDT)
Message-ID: <951159c7-08b1-4b15-9dd7-e1a6589ce2ce@gmail.com>
Date: Wed, 31 Jul 2024 11:31:47 +0800
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
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <CAEf4BzbzM85_946eB95e9U6stknBh4ucLMKVo5SEqUsihe4K1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 31/7/24 01:28, Andrii Nakryiko wrote:
> On Mon, Jul 29, 2024 at 8:32 PM Leon Hwang <hffilwlqm@gmail.com> wrote:
>>
>>
>>
>> On 30/7/24 05:01, Andrii Nakryiko wrote:
>>> On Fri, Jul 26, 2024 at 9:04 PM Leon Hwang <hffilwlqm@gmail.com> wrote:
>>>>
>>>>
>>>>
>>>> On 2024/7/27 08:12, Andrii Nakryiko wrote:
>>>>> On Thu, Jul 25, 2024 at 7:57 PM Leon Hwang <hffilwlqm@gmail.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>
>> [...]
>>
>>>>>>
>>>>>> Is it OK to add a tracepoint here? I think tracepoint is more generic
>>>>>> than retsnoop-like way.
>>>>>
>>>>> I personally don't see a problem with adding tracepoint, but how would
>>>>> it look like, given we are talking about vararg printf-style function
>>>>> calls? I'm not sure how that should be represented in such a way as to
>>>>> make it compatible with tracepoints and not cause any runtime
>>>>> overhead.
>>>>
>>>> The tracepoint is not about vararg printf-style function calls.
>>>>
>>>> It is to trace the reason why it fails to bpf_check_attach_target() at
>>>> attach time.
>>>>
>>>
>>> Oh, that changes things. I don't think we can keep adding extra
>>> tracepoints for various potential reasons that BPF prog might be
>>> failing to verify.
>>>
>>> But there is usually no need either. This particular code already
>>> supports emitting extra information into verifier log, you just have
>>> to provide that. This is done by libbpf automatically, can't your
>>> library of choice do the same (if BPF program failed).
>>>
>>> Why go to all this trouble if we already have a facility to debug
>>> issues like this. Note every issue is logged into verifier log, but in
>>> this case it is.
>>>
>>
>> Yeah, it is unnecessary to add tracepoint here, as we are able to trace
>> the log message in bpf_log() arguments with retsnoop.
> 
> My point was that you don't even need retsnoop, you can just ask for
> verifier log directly, that's the main way to understand and debug BPF
> program verification/load failures.
> 

Nope. It is not about BPF program verification/load failures. It is
about freplace program attach failures instead.

As for freplace program, it can attach to a different target from the
target at load time, since commit 4a1e7c0c63e0 ("bpf: Support attaching
freplace programs to multiple attach points").

This patch tries to provide a better way to figure out the reason why a
freplace program fails to attach.

For example:

tcp_connect.c:

#include "vmlinux.h"
#include <bpf/bpf_helpers.h>

static __noinline int
stub_handler_static(void)
{
    bpf_printk("freplace, stub handler static\n");

    return 0;
}

__noinline int
stub_handler(void)
{
    bpf_printk("freplace, stub handler\n");

    return 0;
}

SEC("kprobe/tcp_connect")
int k_tcp_connect(struct pt_regs *ctx)
{
    stub_handler_static();

    return stub_handler();
}

char __license[] SEC("license") = "GPL";

freplace.c:

#include "vmlinux.h"
#include <bpf/bpf_helpers.h>

SEC("freplace/stub_handler")
int freplace_handler(void)
{
    bpf_printk("freplace, replaced handler\n");

    return 0;
}

char __license[] SEC("license") = "GPL";

And, here's pseudo C code snippet with libbpf to show attach failure:

tcp_skel = tcp_connect__open_and_load();
prog_fd = tcp_skel->progs.k_tcp_connect;
freplace_skel = freplace__open();
freplace_prog = freplace_skel->progs.freplace_handler;
err = bpf_program__set_attach_target(freplace_prog, prog_fd,
"stub_handler");
err = freplace__load(freplace_skel);
freplace_link = bpf_program__attach_freplace(freplace_prog, prog_fd,
"stub_handler_static");

freplace_link will be -EINVAL because stub_handler_static() is not a
global function, as we have figured out.

With this patch, "stub_handler_static() is not a global function" will
be printed in dmesg. But we should not pollute dmesg with such message.

If there's the tracepoint that I mentioned previously,
"stub_handler_static() is not a global function" can be retrieved by the
tracepoint.

Thanks,
Leon

