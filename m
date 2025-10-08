Return-Path: <bpf+bounces-70594-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 32430BC576C
	for <lists+bpf@lfdr.de>; Wed, 08 Oct 2025 16:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ACB5C34A65D
	for <lists+bpf@lfdr.de>; Wed,  8 Oct 2025 14:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FE02EBBBC;
	Wed,  8 Oct 2025 14:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhaCNuNP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AEC2EBB96
	for <bpf@vger.kernel.org>; Wed,  8 Oct 2025 14:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759934464; cv=none; b=X8PYACRaA4GVqackaWaReds7W9ZLk8WK1dbuIJTIRdlsCPY72jDbWmtkLz0AttAd6gF5juDRY9gtPYeAIImyI0Jv242NNLrDobAtK/qGi4dV0S0yHDk0PqcHwr0OTwLM13eaUh41+9FaAlGZLQS/E3ygyPJiirQ7c+zyCDELFSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759934464; c=relaxed/simple;
	bh=vHtHumejN87ncgya2ViWzvqch41xHhCK9RHyEy9NXFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aSH1ho5gt6WfDRfrpsC4B0i9v1CuZK/jllopjKnIhG8nIJ5w+mTINcUm+5stMKZ385FwP/BZi8r0f4mTx0OPdmB51EggaAzkyGpLdNZ/pps099+K6iqhiAaAa/8n/sPlQWnVfp5hN2dDUPpS5Ghm4M82hFwyX6dM3zvVdciJlNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhaCNuNP; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-78af9ebe337so5095476b3a.1
        for <bpf@vger.kernel.org>; Wed, 08 Oct 2025 07:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759934462; x=1760539262; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XRgXZBDqFKfDqLPTjTiL4KlNwfATNNhaPH2ClvCy9+g=;
        b=RhaCNuNPm/Daj/eJYGaVERBTnTuSQ0eH6665Yjtn5DNLtjLXZNmPyNJH8LeOC3AtKO
         70UNXk8fY8KDtFJqOuHr/j7ALWn4cv2qhcZKLj8XLIKD3unlPu8H9uUiqxIc+Q06xzV6
         /N1+gNXFCQ7sp6wAXASY9CAAyelrfGlEXrR2ghtf5RTB0zvEtDeQqvA2uz1AehobIlcc
         jUV/v9gay/LfMbNRPiS+08CwHTTm9R7Lu/zGe9wGxpM8Vsi2LRB9qNMbtHWoU3Z2N1zG
         AFMDE0L1xuif+R6u1ROneshCqVi7FdbNGOVwFFgfopxE7zwR4c0G8ZgagiIa2nQPFs3A
         nftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759934462; x=1760539262;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XRgXZBDqFKfDqLPTjTiL4KlNwfATNNhaPH2ClvCy9+g=;
        b=hjdxF1T4m1SA1RowmF8rU7iMMO2N2L/A13PXyHzI3K83Jwu7IZk65RkYUulF68LVYo
         FzlSCNvXpDonqcYIIr1vdk0WZt2iIiUh4Z2hO/pZOmG2YEw6hnzBgQgEquEloxj4+Fg6
         ORgleMqa/fUM9CL2ZAp33fCbqdxBRtLQnIBGuQ60Sj9QDQQwqGrVj4N7TBIdR87imEGy
         vNdor+tphxMH483vcOrV5Vkzqwn6GaZh88KQ24wdCjWCclzyEJWu+Z1J5SuH9+VlVqkx
         PBpgJFm+rfDccCn9SLdKttu4QGY/m+Dsfk1Sio5+YFuqiFn346EgA7b40vmKn51ixCO+
         bhlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOzwUBBziUm3M+O14MGJ0dVprjgaWU2D/Xns3Ezls2XY6NSo2flJUcwVokfxcQutERsWo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2njvZrO4s4m6u0a+w0MerIL8v61ZSvYW3aKkO4EfVGkvL2xc+
	IhZ2KxPVR/JDIVWPsLL3KaSK62E67HllUf252X7h39wqm40PTleK1x3S
X-Gm-Gg: ASbGncvy29RjjyLmmnzwyoUT7BR4EBEnewXz0ifa0M9EeuJID7SoGK9HXYaxPfaHHnB
	X8oR4qhEEUY/6yPymi4b5F74ToBeZ9bfQk8hQJbFCS2/RIy71EXxt4n618DfPDqmKtvDGEb7b3s
	ie8CAZAxIkbxZ+F++7vnvMsEDJUdCcbnfDENwdaH1PEqk/ZgFt7SeL97h/d32KBaO3m6ZwwpOum
	lN4ORIcvyetd+VqRLusaXFDKmtvRHzcYe+HnPxrIlRXdh2a6MiQi1Af3ccuEm0FPrOqNHcg6My3
	ftJvQ/yrj6KMSfq3iJEM6A/mrAz+KeWbdtoOrrSpv++j1qVxc8uILJQ/4uB4Qnk7qP1DZ1bqmT+
	zp2EOPB+caFdHOLheJMj2TTq+OAh7IFkj0IYOo/e7O3JEXYe4luQCPXcBNXE=
X-Google-Smtp-Source: AGHT+IGSyyuPMEa9ur5aJQiYNGUh201mREentuTgFoSL+6iYa1/r7WdugU0gxZJgmxiXoNAAFCxmjA==
X-Received: by 2002:a05:6a20:2584:b0:2e5:655c:7f8f with SMTP id adf61e73a8af0-32da83e6319mr5293800637.46.1759934462272;
        Wed, 08 Oct 2025 07:41:02 -0700 (PDT)
Received: from [172.20.10.4] ([117.20.154.54])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01f9daf3sm19043382b3a.8.2025.10.08.07.40.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 07:41:01 -0700 (PDT)
Message-ID: <7f28937c-121a-4ea8-b66a-9da3be8bccad@gmail.com>
Date: Wed, 8 Oct 2025 22:40:57 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC bpf-next 1/3] bpf: report probe fault to BPF stderr
To: Menglong Dong <menglong.dong@linux.dev>,
 Menglong Dong <menglong8.dong@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, jiang.biao@linux.dev
References: <20250927061210.194502-1-menglong.dong@linux.dev>
 <20250927061210.194502-2-menglong.dong@linux.dev>
 <CAADnVQJAdAxEOWT6avzwq6ZrXhEdovhx3yibgA6T8wnMEnnAjg@mail.gmail.com>
 <3571660.QJadu78ljV@7950hx>
Content-Language: en-US
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <3571660.QJadu78ljV@7950hx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2025/10/7 14:14, Menglong Dong wrote:
> On 2025/10/2 10:03, Alexei Starovoitov wrote:
>> On Fri, Sep 26, 2025 at 11:12 PM Menglong Dong <menglong8.dong@gmail.com> wrote:
>>>
>>> Introduce the function bpf_prog_report_probe_violation(), which is used
>>> to report the memory probe fault to the user by the BPF stderr.
>>>
>>> Signed-off-by: Menglong Dong <menglong.dong@linux.dev>

[...]

>>
>> Interesting idea, but the above message is not helpful.
>> Users cannot decipher a fault_ip within a bpf prog.
>> It's just a random number.
>
> Yeah, I have noticed this too. What useful is the
> bpf_stream_dump_stack(), which will print the code
> line that trigger the fault.
>
>> But stepping back... just faults are common in tracing.
>> If we start printing them we will just fill the stream to the max,
>> but users won't know that the message is there, since no one
>
> You are right, we definitely can't output this message
> to STDERR directly. We can add an extra flag for it, as you
> said below.
>
> Or, maybe we can introduce a enum stream_type, and
> the users can subscribe what kind of messages they
> want to receive.
>
>> expects it. arena and lock errors are rare and arena faults
>> were specifically requested by folks who develop progs that use arena.
>> This one is different. These faults have been around for a long time
>> and I don't recall people asking for more verbosity.
>> We can add them with an extra flag specified at prog load time,
>> but even then. Doesn't feel that useful.
>
> Generally speaking, users can do invalid checking before
> they do the memory reading, such as NULL checking. And
> the pointer in function arguments that we hook is initialized
> in most case. So the fault is someting that can be prevented.
>
> I have a BPF tools which is writed for 4.X kernel and kprobe
> based BPF is used. Now I'm planing to migrate it to 6.X kernel
> and replace bpf_probe_read_kernel() with bpf_core_cast() to
> obtain better performance. Then I find that I can't check if the
> memory reading is success, which can lead to potential risk.
> So my tool will be happy to get such fault event :)
>
> Leon suggested to add a global errno for each BPF programs,
> and I haven't dig deeply on this idea yet.
>

Yeah, as we discussed, a global errno would be a much more lightweight
approach for handling such faults.

The idea would look like this:

DEFINE_PER_CPU(int, bpf_errno);

__bpf_kfunc void bpf_errno_clear(void);
__bpf_kfunc void bpf_errno_set(int errno);
__bpf_kfunc int bpf_errno_get(void);

When a fault occurs, the kernel can simply call
'bpf_errno_set(-EFAULT);'.

If users want to detect whether a fault happened, they can do:

bpf_errno_clear();
header = READ_ONCE(skb->network_header);
if (header == 0 && bpf_errno_get() == -EFAULT)
        /* handle fault */;

This way, users can identify faults immediately and handle them gracefully.

Furthermore, these kfuncs can be inlined by the verifier, so there would
be no runtime function call overhead.

Thanks,
Leon

