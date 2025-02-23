Return-Path: <bpf+bounces-52288-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E1FA41188
	for <lists+bpf@lfdr.de>; Sun, 23 Feb 2025 21:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 912957A6527
	for <lists+bpf@lfdr.de>; Sun, 23 Feb 2025 20:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4036D23A9A4;
	Sun, 23 Feb 2025 20:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOwLQwd0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE615383;
	Sun, 23 Feb 2025 20:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740342349; cv=none; b=CsZnXysJimq0Im4hj7scGdMUYV+Bapyup4UAQTfewh1BX6Yf/ipwMR/Ye0j5YQM9grqDXgIAy91cSC4vRLQ37qThiB/oI6Q0S6vxUFjZi2F4ir6ZmONU44vS6OHNIshElNF2aUca4iwofiTIcYsU2Nnaq1bvTI7aWfTP47ylOpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740342349; c=relaxed/simple;
	bh=3yjKIYgRIOVvhYFiwNZ7Mv6DvekS5KCI6HkyIkBNqjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QhN4QEcKdBlbi7g+pYMdRaB2VGCMXPGsuVMp3me5tKXOmjS3YBQCvb31XvxhZ3sgWV8R8vX3VDxNWiDsyPpmY1SN4zEzSg+lSjzaqZ+Rlr9xBf+KIeUo8PoibqpV6TfIv4rpEAtLKjVoN3XeN7lBMid62VMngiCdPLgtXv+5gEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LOwLQwd0; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-abb8d63b447so476933466b.0;
        Sun, 23 Feb 2025 12:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740342346; x=1740947146; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KO/NRoKuG8XetnuWE85hFK1fCgTrWENxYrVqAq/LSbo=;
        b=LOwLQwd0M8LRhLR7CcdbRek0krkmzr4tJ2xMBNYOiJImX6w/9xk+SWXv2lSAOrwWdd
         +oV8Ka9/OSvR/smJVHjO+p6LLiWnOxrcxobJGgqT/ER9HCHJCswk/NYshODNR3V2whqY
         +8W0IGn1fNlSBzUyCXGrtj8lLxIti1Fii0qL5pgmgqzPqlqvh8iiDbyoTTfD4inQCUDE
         diRinKyaElCu9NuYDudVMVYg5XriQOePiCdjbPcPxEgPsrPoxeiTeFx1cLG+5gnV+NGz
         ZYiJ9LkTd5YWFNMt0jyy3BBCxbVxYA6Win+o6Z3ku9nt/VTaUo+l8OCfMa3MhPxj/fgn
         HxSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740342346; x=1740947146;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KO/NRoKuG8XetnuWE85hFK1fCgTrWENxYrVqAq/LSbo=;
        b=FEcMpsoB/YjPSJL/M8nU33bxsFYnJ4L0Njc5eO3ovOCE95qUVI4Ps9B6XhHfSm9ud/
         Mdy3UJiUmvmi7GWVn7daI7ZXqVt+6Me8lzoNMt6EWad+TPyykVpPmE2gxpjHyqqOT+Or
         /0YRexageJZNdTa1TzoWIGJyYyu85H00mf65zdEWuQdzVztDz/T4TLvWkRXHltAIK95N
         lwgBkwjDI9q+3UslhtrU92jgesR4oe5lmQxR2n+MISUF8ZXO4tvNpz3+981RMyRRpCsU
         ATiRiWhULJF+k592zBZOidbtG620IK5vpqzqUsG62iqZpE3qZxk3zbe37IO3Y32p/gHj
         cVEA==
X-Forwarded-Encrypted: i=1; AJvYcCURD/9W5PNUNUfDY6kS5p+l6AJhLr6eOWdJq2md2Vd+xP++U3s0BO9uruUmugsv8dScpTk=@vger.kernel.org, AJvYcCUfsxJjD0AKVL4HewWtKJjpWJGjl7fR1JGDixrQzBNuSDH8RpoQXxYPkbvjK5pBNxnTzwh9PjEyjJ6tbJl1@vger.kernel.org, AJvYcCVNSWNYm8c3auuvf/MlifN1yRiDZA+sXjhLFyPlOnv5tqTC6+Bah8DqWL8qiVUC8CnPfUoUKn/A@vger.kernel.org, AJvYcCVWKRcXyzwQgUBY0ybWdJRZfRHY2pOmd+036ROFck6H/gUsWIwi1DWLkblOI7bWmhzCW6b74C/D/igXO+1GzFE=@vger.kernel.org, AJvYcCVXhQpKQJXjw5/Nm98L0v2S+r44NM/dOPxdhe9Gk5u6SC8qe63KgRaBbWRzHVSFLmFZcxlzs+3DI6RwdT8=@vger.kernel.org, AJvYcCWoiN1r0NC84EsXeCwSlXdpJA3cbW4m5zhznSUnqZx40tJuIaQr272adQ+mjH9ecb8dvQmm56MZRfbxYKs=@vger.kernel.org, AJvYcCXno489TQCns5mk3gcEqf4Di9Sryzgl6r5DxcMmMi1lASdDvz7+aMrg+3e3OfZiI2e4WGZPJRQVRltOS8MX@vger.kernel.org
X-Gm-Message-State: AOJu0YzEmtkMoYXyOxiVQDQ+wtAsYE2k2emxAprGVKGxhDcHurqhYhfi
	gcEjXxykNuN3JjkYHFQ87qbR2yEvcz0btKApnZOD7UT22XEYlbCi
X-Gm-Gg: ASbGncugjrP0Ab07AZ+biXLJg7mpalkI1oW6K4jW58XRfbzi8ip+GfkclXYgXQ0RlCF
	zCV5gRPkyDQEbsZKSmY1+QP87APkECxPm+AHtPc0sGp96n2lt++TPZso1RJuXFezDBVvKW/55ZX
	Hkors6FSNxjvQYp3ZEiEPkgoiUTHYBhq4geGOTnZwsVAu4bf9Ep4jBOhDemQaSjxy7jsq/XJNCd
	6kOP+ww4S070622LbQd3/6b9GthnCvAGftvACbKHy1nkR26MxZlM1tUq5AM49vgzqcHeSOlI6Nl
	39joOLi/kd4RcJb+0YZX1i8pISE=
X-Google-Smtp-Source: AGHT+IEASkBZDUs2HV66FfbppKxrXfiPEOQdWl35/1TkX9MbOUwdnZRhQOYUiSPPWnjZ/EnkcBUtNQ==
X-Received: by 2002:a17:907:1b26:b0:ab7:be81:8944 with SMTP id a640c23a62f3a-abc099b88ccmr1174431166b.6.1740342346244;
        Sun, 23 Feb 2025 12:25:46 -0800 (PST)
Received: from [192.168.1.100] ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbbe74100asm1142813766b.95.2025.02.23.12.25.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Feb 2025 12:25:45 -0800 (PST)
Message-ID: <602e03fd-ce4b-feef-5053-e95834ab35d7@gmail.com>
Date: Sun, 23 Feb 2025 21:25:42 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 00/17] Introduce and use generic parity32/64 helper
To: Kuan-Wei Chiu <visitorckw@gmail.com>, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 jk@ozlabs.org, joel@jms.id.au, eajames@linux.ibm.com,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, dmitry.torokhov@gmail.com,
 mchehab@kernel.org, awalls@md.metrocast.net, hverkuil@xs4all.nl,
 miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
 louis.peens@corigine.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, parthiban.veerasooran@microchip.com,
 arend.vanspriel@broadcom.com, johannes@sipsolutions.net,
 gregkh@linuxfoundation.org, jirislaby@kernel.org, yury.norov@gmail.com,
 akpm@linux-foundation.org
Cc: hpa@zytor.com, alistair@popple.id.au, linux@rasmusvillemoes.dk,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
 linux-fsi@lists.ozlabs.org, dri-devel@lists.freedesktop.org,
 linux-input@vger.kernel.org, linux-media@vger.kernel.org,
 linux-mtd@lists.infradead.org, oss-drivers@corigine.com,
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
 linux-serial@vger.kernel.org, bpf@vger.kernel.org, jserv@ccns.ncku.edu.tw,
 Yu-Chun Lin <eleanor15x@gmail.com>
References: <20250223164217.2139331-1-visitorckw@gmail.com>
Content-Language: en-US
From: Uros Bizjak <ubizjak@gmail.com>
In-Reply-To: <20250223164217.2139331-1-visitorckw@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 23. 02. 25 17:42, Kuan-Wei Chiu wrote:
> Several parts of the kernel contain redundant implementations of parity
> calculations for 32-bit and 64-bit values. Introduces generic
> parity32() and parity64() helpers in bitops.h, providing a standardized
> and optimized implementation.
> 
> Subsequent patches refactor various kernel components to replace
> open-coded parity calculations with the new helpers, reducing code
> duplication and improving maintainability.

Please note that GCC (and clang) provide __builtin_parity{,l,ll}() 
family of builtin functions. Recently, I have tried to use this builtin 
in a couple of places [1], [2], but I had to retract the patches, 
because __builtin functions aren't strictly required to be inlined and 
can generate a library call [3].

As explained in [2], the compilers are able to emit optimized 
target-dependent code (also automatically using popcnt insn when 
avaialble), so ideally the generic parity64() and parity32() would be 
implemented using __builtin_parity(), where the generic library would 
provide a fallback __paritydi2() and __paritysi2() functions, otherwise 
provided by the compiler support library.

For x86, we would like to exercise the hardware parity calculation or 
optimized code sequences involving HW parity calculation, as shown in 
[1] and [2].

[1] https://lore.kernel.org/lkml/20250129205746.10963-1-ubizjak@gmail.com/

[2] https://lore.kernel.org/lkml/20250129154920.6773-2-ubizjak@gmail.com/

[3] 
https://lore.kernel.org/linux-mm/CAKbZUD0N7bkuw_Le3Pr9o1V2BjjcY_YiLm8a8DPceubTdZ00GQ@mail.gmail.com/

Thanks,
Uros.

