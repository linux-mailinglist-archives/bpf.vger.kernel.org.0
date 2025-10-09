Return-Path: <bpf+bounces-70667-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EECF6BC9B75
	for <lists+bpf@lfdr.de>; Thu, 09 Oct 2025 17:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D274F4EA026
	for <lists+bpf@lfdr.de>; Thu,  9 Oct 2025 15:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F18155C97;
	Thu,  9 Oct 2025 15:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JySqrzpB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3548E4C81
	for <bpf@vger.kernel.org>; Thu,  9 Oct 2025 15:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760022948; cv=none; b=PSLDl46rt8/r/QHJITObgbepsewPO7FMAgd524gBEKNxQtBJonWl89LoWAj0MGwnLpTQUEP57TxBxEJOwjJt6U/af7UHznMhPwUmhPNSZklBnNqA15jpQxNRvmPd1JiWX0BVkt/lW9O3iNHo+n7iG8Qgfw2N/2T9Oe7HlR1ZOEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760022948; c=relaxed/simple;
	bh=qshWedy9zOFfj4S/MRqOfZgJWqZsXgvtsuKhKKMr4zs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=fGWreNAxlSpBLR3NrVLFnbEp7heGN8gyuSw7GXcv/XbMbIl61LFr6fc2g873grgsSkKr1tGrdgCiSGeW9Lg4eJTuGBSRz4WceiD5hXosA1Ikpi1whi8FYxjADAE+16umhhMOjGyiVgi3yZ34LaE3LeNfEqDKy5DAxEhrS4yEtH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JySqrzpB; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7841da939deso1016196b3a.2
        for <bpf@vger.kernel.org>; Thu, 09 Oct 2025 08:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760022947; x=1760627747; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QW3441uRfgKwaWkCvF0+xgoQHEkKkpXbASbo2YsQ298=;
        b=JySqrzpBKWSQvVdv4mP/Ji3WoJcaqqnP7i8wF1hAogeKz7ra+/+RSMJzFKDblZLoxm
         kFjQsIeKsyV5envbsisrA4QatiWY+AaCTwSloE4YVAXGRGncre8Et2UZfNdS5YA90Xb4
         GL7168efjd+JP9hduygeWil2mox4I9CMvQ2jYH5jf7T7FREgcXotIoSzJIrkWLFW/y/y
         XIeOUsmEbm3IW8bMM6BEf+N16Wp91W4I+DAohQZE90vswMnoDHvYbahSCrDT1Hq7egwe
         QU7ucfTRnyDMWwJSIswRY0rnimQPj5vOOS+CdtP6PSff2vHJR+YG36V0iDVUv042h4Zk
         8GoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760022947; x=1760627747;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QW3441uRfgKwaWkCvF0+xgoQHEkKkpXbASbo2YsQ298=;
        b=sGzHeD+XDxvzauIDTiotUrqlaV2qx7PPk0RWxG9Coc53pfgm/a/tQaLxfdLTVkMgvE
         EssZ4vFDPjf8lBkn2Vu/+mlfbViD+wLldhI2B+YUIoxnu/mVwRXUoLG+O0FogndeMoxB
         qBzH7nTRtoI+MNH5CWsACmHglQY9wzrjZDandJM9V7/B1BNlLZY5LUKRNfFP4GR6mHXR
         F6oS/+vQiaxArH30MqO8DvZ1FNcChO63KFqPM+zDeDqGrcOaglB7jDXUyvmN7V6ikIr8
         HJza0+rD5OL3VFair+q8+M/tdXMfB+FpM+kpczEJmchwFGsjA75KTKwghld2EcUPvKpZ
         rmBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzE0tz9l0+5hO1RHmBycJfo4pjaLpJHwpeR6ePxST2TjhX7JUjBCD9Htv19jusdt1vXpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjzLHLLMILDmpSVof0Wu7TQVqM18gHIu03bpIsujkAOsxoiSYC
	HfT9vd4SseT8wlp3eHKmOqMDkq4pfUpUkub2crZ496FnOKIcgvHS9NDs
X-Gm-Gg: ASbGncuhlRPgc4HDl9I0yA5xC0CZtYwaSY/C1ECTMTHHQuJYaqyeUapwciBYrgIK2Pl
	EZNVfJqOEw7GYsg6CtQd2f0PlAjVTftA8c6zxODbaAibIU/VZBnczPLqEUcNNUizy+k9IqnNPrU
	mXqOhE6beMJb5UhQMv5/YBsNTyCXWrtJL2aChQL4w/NW3ue9HbnplQs82B+UZdn4owDtpZSOSTE
	U0NOUIXrYXBXqgTDFNqgcrAe8YH+SfELsi8qc3fa6RRhA2kY3B7lQfXEDXEOhbaH+QNfe4Zdkc+
	zmz7aXFwX+cPU4XqD3f27VLpUErwjDnw/vzua7phGPI4ZjZlVLuCv/j7/uKAYlDJy41x+mW8Z7s
	GHpCZ+WNBxvQGcnaj1HDjFeGhSF2aAkyFGGeWqjQXaGFhZaFmycDmGFqwd8G/C2g3kRPPKA==
X-Google-Smtp-Source: AGHT+IGzWj2f7GE9unACisTFXTIm/6m0yZrlPKrykcpQ5kEtz/hxMKqimFAb0PWKVC9eCmlcr6WDoA==
X-Received: by 2002:a05:6a00:464f:b0:781:15b0:bed9 with SMTP id d2e1a72fcca58-79387052040mr11267934b3a.17.1760022946316;
        Thu, 09 Oct 2025 08:15:46 -0700 (PDT)
Received: from [172.20.10.4] ([117.20.154.54])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d09a87asm2637b3a.46.2025.10.09.08.15.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 08:15:45 -0700 (PDT)
Message-ID: <6485d7de-2af6-48d6-b427-66d3697ec2b2@gmail.com>
Date: Thu, 9 Oct 2025 23:15:40 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: bpf_errno. Was: [PATCH RFC bpf-next 1/3] bpf: report probe fault
 to BPF stderr
From: Leon Hwang <hffilwlqm@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Menglong Dong
 <menglong.dong@linux.dev>, Menglong Dong <menglong8.dong@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, jiang.biao@linux.dev
References: <20250927061210.194502-1-menglong.dong@linux.dev>
 <20250927061210.194502-2-menglong.dong@linux.dev>
 <CAADnVQJAdAxEOWT6avzwq6ZrXhEdovhx3yibgA6T8wnMEnnAjg@mail.gmail.com>
 <3571660.QJadu78ljV@7950hx> <7f28937c-121a-4ea8-b66a-9da3be8bccad@gmail.com>
 <CAADnVQLxpUmjbsHeNizRMDkY1a4_gLD0VBFWS8QMYHzpYBs4EQ@mail.gmail.com>
 <CAP01T75TegFO0DrZ=DvpNQBSnJqjn4HvM9OLsbJWFKJwzZeYXw@mail.gmail.com>
 <0adc5d8a299483004f4796a418420fe1c69f24bc.camel@gmail.com>
 <CAP01T77agpqQWY7zaPt9kb6+EmbUucGkgJ_wEwkPFpFNfxweBg@mail.gmail.com>
 <5766a834-3b21-47b0-8793-2673c25ab6b0@gmail.com>
Content-Language: en-US
In-Reply-To: <5766a834-3b21-47b0-8793-2673c25ab6b0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


>>
>> Since we're piling on ideas, one of the other things that I think
>> could be useful in general (and maybe should be done orthogonally to
>> bpf_errno)
>> is making some empty nop function and making it not traceable reliably
>> across arches and invoke it in the bpf exception handler.
> 
> No new traceable function is needed, since ex_handler_bpf itself can
> already be traced via fentry.
> 
> If users really want to detect whether a fault occurred, they could
> attach a program to ex_handler_bpf and record fault events into a map.
> However, this approach would be too heavyweight just to check for a
> simple fault condition.
> 

As ex_handler_bpf can already be traced using fentry, a potential
approach without modifying the kernel would be:

1. In the fentry program:

int is_fault SEC(".percpu.fault");

SEC("fentry/ex_handler_bpf")
int BPF_PROG(f__ex, const struct exception_table_entry *x, struct
pt_regs *regs)
{
    is_fault = 1;
    return 0;
}

2. In the main program:

int is_fault SEC(".percpu.fault");

is_fault = 0;
/* probe read */
if (is_fault)
    /* handle fault */;

The main idea is that both programs share the same ".percpu.fault" map,
so the variable 'is_fault' can be accessed from both sides.

Here, ".percpu.fault" represents a percpu_array map section, which is
expected to be supported in the future.
In the meantime, it can simply be replaced with a regular percpu_array map.

Finally, this approach is conceptually similar to the idea of using a
global errno.

Thanks,
Leon


