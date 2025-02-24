Return-Path: <bpf+bounces-52365-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0762CA42644
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 16:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DE9B1886E36
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 15:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA9D19AA56;
	Mon, 24 Feb 2025 15:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W15ouCed"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F0119C54E;
	Mon, 24 Feb 2025 15:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740410661; cv=none; b=CNXCxExf6Yjnzkm6PoKlzAWQyV78SRRlVf0CyULw8K6Zu+thFMbjH3QCv6VTvhe0bAuvBS2LJdAmIJjKS30qZZRcLriKSpUegn+Pyv0FHgdXBne3SaeuA7D2BX5XaCP26SITTf/8stNuoNdy4fgK7CgMRmdIS74VRo6ZVi5dd5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740410661; c=relaxed/simple;
	bh=+JH9WFIVg0ke/75TFC25dWturzu4JHdGKnJIyiQPccM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q/you+aBKq7dJ+joVq+ka63Vta0b+TqWcsrafvCIsufliUBu9YXAJGJ/JFvGys7H2y6O//iTzYkwEmSBIxJ0TZQYrfNxI+9tXratBApyO3YHEZUwGQfD4WTiXTb54yXOCVbM6yTZxsIqJd1Y5E2mAoQlAoLsMN2BLrqgVHZLm+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W15ouCed; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-abb81285d33so874841866b.0;
        Mon, 24 Feb 2025 07:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740410658; x=1741015458; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=90b7JTu64HyQeEwAMfpKEcwfZyjyUK0IOy6HdZ/FyAs=;
        b=W15ouCedxAj7B9Oa5TVxKG8joKlxu/lhNekNMTWhqfNuN+JP/nW4gdxExLVipl0RPr
         sbQZej8tAM0TD0vnBz3hArfOJwztMyGnyuqcqUukykIz5uVTZnNDLP07sO4wgwqNahm+
         +q0TFUpnNzGk+ObxqrpFeL745qb02VbtH5OF+6jb3TDgGnVcvFdn1hWDZ3L3TEUMPXEp
         M1yxX8jQJyMTN14cnrxmLhPAiuby010XsWB/RAS4hutxX4E5Z7umwryAPp5P2UpmlYi9
         DYQCvxKR7HOVe49YDqj8Lfpgn1V5F3lz5k1mBfTZyNQ79tfiCmMFylyDwVZIFHa/zJIR
         Q92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740410658; x=1741015458;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=90b7JTu64HyQeEwAMfpKEcwfZyjyUK0IOy6HdZ/FyAs=;
        b=R9BtLimFQCXkt+eEE/HB8sCIHh6ITD7J6JIjHKbNtElp7X2TZRv7CmEhzR5M3QB5PX
         dQPCUkf2A0ISqes9hU+eWQqWBlPFBCC9vO6mgJIF3LIFIwPiMr2e8y31x8R+C9/7p2Sa
         C0aDOdX5Pim0DHVQc/k8Ou6DibqZPsRe34rvkQao/ssa/p5cAjvbTopRB6o/bcifRU+K
         SigGrfoy/BnBAuD+i4UQZ6K4PiVgQXsqvxRxXh0xhOjpz6OJXlEjeSpdTg8GIiqp3KvY
         HeXQ/qG0lnfahYPOYNu1F0RaeA93v8WC2O+lNZKBSjsJc+bBJKdonPG125sbAeb60GZ5
         LImg==
X-Forwarded-Encrypted: i=1; AJvYcCULYRHg1mzgd9qrXrKI8NmjZtnAFyPbwoUYaLxAwjRgUQiDmcG9a8wynShtXu3dOaU/Rw0eRA8w/HEfRTxV@vger.kernel.org, AJvYcCVEuaxg5OY02XCRsjG8aXOVZdY/pK5G92n5fFJVX3YGas1l8QykNyZWt3+oIicIBYfyK13Qpvdywa0hEvRW@vger.kernel.org, AJvYcCW1KewY0vtk7QWlhjCN/aQkinmx32IXC8VTGF8XUBLKYVKAy5/FwJoaeyeanbYlVUidYDjv4BdauZ6L5oY=@vger.kernel.org, AJvYcCWUMVlEgFo9MAJdTHiBdbxArf0ffsLQNZYqUOh/Grf3rbW3Bh/LwReNnnq8HqYRvyiylWJROXKwCVtugmU=@vger.kernel.org, AJvYcCWXCaNE4z3FfBRU70v/zq5Ghf1NV8uNTswumP/CYY9tHmFilQaVzgKhhj9jC4i54gnylIeiA3S7@vger.kernel.org, AJvYcCXXhh6AatyGWOPXNTc7BqJEN694h0uWNgvL6vkiggzGpgoelWe1Ef66cOQ8cXank89mzhSsUKZARDOEidAJFWw=@vger.kernel.org, AJvYcCXyhGM6EHEGJtY/vH05kw3A4G4u6stNHN1scl3tEnxaB4gnb8A5R9JdrnkJZsbNc77CCcE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/GHpGs480zr2aVtxqVHV5ZZTsGBV8AsyzYLFK5kHcxyEvjwFd
	edYlEPVXr7KOpbTs3UA2yfavnNrdXBCHdkjSGgInTFsACWUP3Pmu
X-Gm-Gg: ASbGncucznpWvUSFF2v5t2s03hDCiGIyhu90jbdvbzusOgUwm9Bp14x9lwA0KiG+Mj1
	LuAZ0+6mM1X1lRz341+/rShWIV/AAhy0E47B3jHfhCJbufwS3/t7NzReUBQ7Eoe5uH+61y7fyWR
	F6EjkWe+jTvWOa+deBD4mQbNIcaeuVrr+uLY+Zw1G7DU3T8mw0oh/QMsURuxCcMyhht3gT+e7Se
	L69W6LqNvHwsO2snAsbQFouBRGG33s/UNXHXhjv8H0J52QD6inqTaPxvvFEj0cl3jG4Kj/bxlF6
	ur7Okl1C7eG4qnKRPtc++EE2YAk=
X-Google-Smtp-Source: AGHT+IFuxTp/JUjRKgHm6bk8HGglm4eMoWBRrY8PM6xIIRBJOeg9hhqPfUM+m5fxkbKuGg8YC/F0FQ==
X-Received: by 2002:a17:907:c29:b0:ab7:86ae:4bb8 with SMTP id a640c23a62f3a-abc09a0bc37mr1270641566b.23.1740410658075;
        Mon, 24 Feb 2025 07:24:18 -0800 (PST)
Received: from [192.168.1.100] ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb9f8442c0sm1531734566b.150.2025.02.24.07.24.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 07:24:17 -0800 (PST)
Message-ID: <d080a2d6-9ec7-1c86-4cf4-536400221f68@gmail.com>
Date: Mon, 24 Feb 2025 16:24:14 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 03/17] x86: Replace open-coded parity calculation with
 parity8()
To: Kuan-Wei Chiu <visitorckw@gmail.com>, tglx@linutronix.de,
 Ingo Molnar <mingo@redhat.com>, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, jk@ozlabs.org, joel@jms.id.au, eajames@linux.ibm.com,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, dmitry.torokhov@gmail.com,
 mchehab@kernel.org, awalls@md.metrocast.net, hverkuil@xs4all.nl,
 miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
 louis.peens@corigine.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, parthiban.veerasooran@microchip.com,
 arend.vanspriel@broadcom.com, johannes@sipsolutions.net,
 gregkh@linuxfoundation.org, jirislaby@kernel.org, yury.norov@gmail.com,
 akpm@linux-foundation.org, mingo@kernel.org
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
 <20250223164217.2139331-4-visitorckw@gmail.com>
Content-Language: en-US
From: Uros Bizjak <ubizjak@gmail.com>
In-Reply-To: <20250223164217.2139331-4-visitorckw@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 23. 02. 25 17:42, Kuan-Wei Chiu wrote:
> Refactor parity calculations to use the standard parity8() helper. This
> change eliminates redundant implementations and improves code
> efficiency.

The patch improves parity assembly code in bootflag.o from:

   58:	89 de                	mov    %ebx,%esi
   5a:	b9 08 00 00 00       	mov    $0x8,%ecx
   5f:	31 d2                	xor    %edx,%edx
   61:	89 f0                	mov    %esi,%eax
   63:	89 d7                	mov    %edx,%edi
   65:	40 d0 ee             	shr    %sil
   68:	83 e0 01             	and    $0x1,%eax
   6b:	31 c2                	xor    %eax,%edx
   6d:	83 e9 01             	sub    $0x1,%ecx
   70:	75 ef                	jne    61 <sbf_init+0x51>
   72:	39 c7                	cmp    %eax,%edi
   74:	74 7f                	je     f5 <sbf_init+0xe5>
   76:

to:

   54:	89 d8                	mov    %ebx,%eax
   56:	ba 96 69 00 00       	mov    $0x6996,%edx
   5b:	c0 e8 04             	shr    $0x4,%al
   5e:	31 d8                	xor    %ebx,%eax
   60:	83 e0 0f             	and    $0xf,%eax
   63:	0f a3 c2             	bt     %eax,%edx
   66:	73 64                	jae    cc <sbf_init+0xbc>
   68:

which is faster and smaller (-10 bytes) code.

Reviewed-by: Uros Bizjak <ubizjak@gmail.com>

Thanks,
Uros.

> 
> Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
> Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
>   arch/x86/kernel/bootflag.c | 18 +++---------------
>   1 file changed, 3 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/x86/kernel/bootflag.c b/arch/x86/kernel/bootflag.c
> index 3fed7ae58b60..314ff0e84900 100644
> --- a/arch/x86/kernel/bootflag.c
> +++ b/arch/x86/kernel/bootflag.c
> @@ -8,6 +8,7 @@
>   #include <linux/string.h>
>   #include <linux/spinlock.h>
>   #include <linux/acpi.h>
> +#include <linux/bitops.h>
>   #include <asm/io.h>
>   
>   #include <linux/mc146818rtc.h>
> @@ -20,26 +21,13 @@
>   
>   int sbf_port __initdata = -1;	/* set via acpi_boot_init() */
>   
> -static int __init parity(u8 v)
> -{
> -	int x = 0;
> -	int i;
> -
> -	for (i = 0; i < 8; i++) {
> -		x ^= (v & 1);
> -		v >>= 1;
> -	}
> -
> -	return x;
> -}
> -
>   static void __init sbf_write(u8 v)
>   {
>   	unsigned long flags;
>   
>   	if (sbf_port != -1) {
>   		v &= ~SBF_PARITY;
> -		if (!parity(v))
> +		if (!parity8(v))
>   			v |= SBF_PARITY;
>   
>   		printk(KERN_INFO "Simple Boot Flag at 0x%x set to 0x%x\n",
> @@ -70,7 +58,7 @@ static int __init sbf_value_valid(u8 v)
>   {
>   	if (v & SBF_RESERVED)		/* Reserved bits */
>   		return 0;
> -	if (!parity(v))
> +	if (!parity8(v))
>   		return 0;
>   
>   	return 1;

