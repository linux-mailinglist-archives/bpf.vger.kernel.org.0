Return-Path: <bpf+bounces-22588-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1118615D6
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 16:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FCDC1C2433C
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 15:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03087823DB;
	Fri, 23 Feb 2024 15:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4veCoWG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DF7823D7
	for <bpf@vger.kernel.org>; Fri, 23 Feb 2024 15:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708702253; cv=none; b=oM3/3aiQchGwfUn4rbovirIR97pIGix+JiUz9HvQgd9uTg9q9fV1BZ1caw3hwTuXpwOEsNo2VoeAusC2hU19ctlvNhubcb2IYs8GV8c5P1jIa7vcN1S2EWlyDBpAYXRSDS5hevEoo/Y4I2yToNGbFolytbVNGebg9NgwL29C05k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708702253; c=relaxed/simple;
	bh=rVbnM/5eDfohz3QT9cfq7zFQ5YmxVyUMY6WzUIETNdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nH0LZcKiz9CxuzdL6BO+Zt3cKrKjE6NUgl23OaW6EYOC3L6QaCyHFFwssoM6TrqtuicIuUfZ59KdWm8+bgo53Ww4l1/Xp7p9RgOqiAMGlGpe0MpP6hpaTZz3PF1aQ2Jl5KUsmhON9Zz/ZUpA7kwAEwzHxos5gxeCFkg6Tl6j3tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T4veCoWG; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3bba50cd318so316979b6e.0
        for <bpf@vger.kernel.org>; Fri, 23 Feb 2024 07:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708702251; x=1709307051; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0X4hUA5cKI6/CQiLoxEQeuEnn3NNM/yeXUI05XyG4L8=;
        b=T4veCoWGsL+w5aCdxPPgXfdzkh2CJZhU+y7C3lsfRpyF774yrMip17+ACD8b56+FkC
         atvJgKakf1Hq+cQhHcsftEdAF+30vhgZ6WCIqYs7urT8dL32AIqBDKie0XxbwM5XNfic
         jEyx54JMg1SeCZxk7dD/J/1p8+HBxRDBK1uY8tQSVeYF6bfOrLxZoWGLpQuMLaA3aPnP
         9ck3FB0ijFLIAT76XuBtDU1rsdQs4jOHVqUjl5L5O8F720mW0iSHqBkm3IdxKYveRDdo
         xzaQlq43Fajnd4xDsbRfScY2KcyRfV45SAlNFnFGhnHO0hkfOt5M35DuVMYK0ejMdblh
         BaPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708702251; x=1709307051;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0X4hUA5cKI6/CQiLoxEQeuEnn3NNM/yeXUI05XyG4L8=;
        b=GQ2MgXmaGb7HH46/XhAO8e+QQITxrS0GRSmS8x1a9U6e+oe5cOOyUFTwEkP4x4Q0bH
         o20lTdCBakOrdMIi+/uhqwX40N9J/osEXdSZ29zh58ST1cT1S4WTvwwEz8FelY9qfEk/
         HtAsTMPzjLPkiYsIP0aNOJgsjQJkxKVV79vMYSlCBLhXcKj10oWGapMbN73+vHoMCPOy
         w0pGcRb5DEQSJuGq4vcg0c4ELC1GplRDAzEgQQ+p1yUexazlEC0UbQpqXjOWVlLd0NlR
         gNyW835oBGQo4/SPr3U2QSoggF8YAqx1sGprF0q/bPHGH+OFwvPlVu/baUjNKb/G9K96
         UHFw==
X-Forwarded-Encrypted: i=1; AJvYcCU7cbUYg9MzVrQptF2DBAUr4xw6hmJH5B7c2s2cHbVpqXS9I3UeMQZ+OYXwgnhHuNGKXzP7Cp2JYLNnRsf8hizp67R/
X-Gm-Message-State: AOJu0YzS8BUn0jLK5YC0mRtrHekK2e3IpLI272uUFl1xLiZmeRs+xts9
	rJ5HWoHvgVcH7E9+U2LPG9JgOgJisAazrtz+EeE8u0GX2Sika1nN
X-Google-Smtp-Source: AGHT+IHkPuRLWjIGSVd+Bb+0zQ8+/LlPriYRQY8bE0NNrvl7/LIwMtfbCMgqxj0E1Mxjfr0jPVXg7A==
X-Received: by 2002:a05:6870:7906:b0:21f:a0e6:c45b with SMTP id hg6-20020a056870790600b0021fa0e6c45bmr196695oab.11.1708702251190;
        Fri, 23 Feb 2024 07:30:51 -0800 (PST)
Received: from [192.168.11.208] (220-136-196-149.dynamic-ip.hinet.net. [220.136.196.149])
        by smtp.gmail.com with ESMTPSA id 8-20020a630c48000000b005dc36761ad1sm12459146pgm.33.2024.02.23.07.30.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 07:30:50 -0800 (PST)
Message-ID: <1fdb4ba0-5b91-419a-960c-a26de0e51c25@gmail.com>
Date: Fri, 23 Feb 2024 23:30:45 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/2] bpf, x64: Fix tailcall hierarchy
Content-Language: en-US
To: Pu Lehui <pulehui@huawei.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 maciej.fijalkowski@intel.com, jakub@cloudflare.com, iii@linux.ibm.com,
 hengqi.chen@gmail.com, kernel-patches-bot@fb.com
References: <20240222085232.62483-1-hffilwlqm@gmail.com>
 <20240222085232.62483-2-hffilwlqm@gmail.com>
 <8a3111a0-b190-437f-979e-393f0c890bf1@huawei.com>
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <8a3111a0-b190-437f-979e-393f0c890bf1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024/2/23 12:06, Pu Lehui wrote:
> 
> 
> On 2024/2/22 16:52, Leon Hwang wrote:

[SNIP]

>>   }
>>   @@ -575,6 +574,54 @@ static void emit_return(u8 **pprog, u8 *ip)
>>       *pprog = prog;
>>   }
>>   +DEFINE_PER_CPU(u32, bpf_tail_call_cnt);
> 
> Hi Leon, the solution is really simplifies complexity. If I understand
> correctly, this TAIL_CALL_CNT becomes the system global wise, not the
> prog global wise, but before it was limiting the TCC of entry prog.
> 

Correct. It becomes a PERCPU global variable.

But, I think this solution is not robust enough.

For example,

time      prog1           prog1
==================================>
line              prog2

this is a time-line on a CPU. If prog1 and prog2 have tailcalls to run,
prog2 will reset the tail_call_cnt on current CPU, which is used by
prog1. As a result, when the CPU schedules from prog2 to prog1,
tail_call_cnt on current CPU has been reset to 0, no matter whether
prog1 incremented it.

The tail_call_cnt reset issue happens too, even if PERCPU tail_call_cnt
moves to 'struct bpf_prog_aux', i.e. one kprobe bpf prog can be
triggered on many functions e.g. cilium/pwru. However, this moving is
better than this solution.

I think, my previous POC of 'struct bpf_prog_run_ctx' would be better.
I'll resend it later, with some improvements.

Thanks,
Leon

