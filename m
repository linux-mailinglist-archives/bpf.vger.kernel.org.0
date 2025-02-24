Return-Path: <bpf+bounces-52439-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DDDA42FAE
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 23:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82FBA17B154
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 22:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B616C207E01;
	Mon, 24 Feb 2025 21:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="oSgE83Ez"
X-Original-To: bpf@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3302D204C2A;
	Mon, 24 Feb 2025 21:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740434378; cv=none; b=cpw2UqT+76NBoR6gIJic6j7/4GP7cXdD6g/WjgjeBi0GzL8ZnOubbK4q4jmyLMd87ZJR0qk2F3DU5G5NOA3/nCp4+JBhmId7TeXUWDVvJB4QufgmH4IjC3iZoO5+bc1ikA9fPzn3JlKIv1ENgObBwJ2xnPc+iF/C71nPxuCGZ5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740434378; c=relaxed/simple;
	bh=mFJLihJkpwqErHdcMQlJt8XTyKO3+wsCZ2aq4cXwkPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nhXhlKNdFApjio9YgtHlPxQTUpN8nvXLfS3JHrn47u3NHk7b7w+HgLuHaqmgE88+5CJZ1txqNDMd9OA4wfmBxkmK035BlGoLShwcUEmWxI+N1qXxGth+eei8GmZuwCLX49BwEECBxy0ITsaEjxFmv/rSa51ljPcbnePViQxJFdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=oSgE83Ez; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [172.27.1.176] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 51OLtSud926291
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 24 Feb 2025 13:55:29 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 51OLtSud926291
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1740434140;
	bh=mGxMwUsqCeYXbcs8sKTNgKdO9jufW4HfcjmafwUUTPQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oSgE83EzgtMz21WmUEJQchEwyeT2+esZ+KWZmZbpMnIxmjSCdKOx7GMtZxtUeuMOb
	 fgxnAP0u+Y7y7qHCRMk2WcPKmHLTS78FSVtYi1r9YtWWKWmJMaiWD3YBVh2jDp2mLE
	 b4BwNub50V8/SEH4tYhg05YnoQDCB66CtxEkgQaSBfQ7RVrhMZ+1NyaFvNQPX6ebJZ
	 edcSTvvAUxlRBSvSoOL6AdT8ofMrNm5Y9/gATbzcdh9cEMD7Xwc6nw3oGlJ+LZeFzO
	 M1iDUz4IaabvYD7h6G8g48ODoiaZf6CPS3zzYla0PFymyTZ7CDau1zbDFk0AveyIiH
	 IGBE0vCJdvVzg==
Message-ID: <e0b1c299-7f19-4453-a1ce-676068601213@zytor.com>
Date: Mon, 24 Feb 2025 13:55:28 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/17] x86: Replace open-coded parity calculation with
 parity8()
To: Uros Bizjak <ubizjak@gmail.com>, Kuan-Wei Chiu <visitorckw@gmail.com>,
        tglx@linutronix.de, Ingo Molnar <mingo@redhat.com>, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, jk@ozlabs.org,
        joel@jms.id.au, eajames@linux.ibm.com, andrzej.hajda@intel.com,
        neil.armstrong@linaro.org, rfoss@kernel.org,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
        dmitry.torokhov@gmail.com, mchehab@kernel.org, awalls@md.metrocast.net,
        hverkuil@xs4all.nl, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, louis.peens@corigine.com, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        parthiban.veerasooran@microchip.com, arend.vanspriel@broadcom.com,
        johannes@sipsolutions.net, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, yury.norov@gmail.com, akpm@linux-foundation.org,
        mingo@kernel.org
Cc: alistair@popple.id.au, linux@rasmusvillemoes.dk,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsi@lists.ozlabs.org,
        dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mtd@lists.infradead.org,
        oss-drivers@corigine.com, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
        brcm80211-dev-list.pdl@broadcom.com, linux-serial@vger.kernel.org,
        bpf@vger.kernel.org, jserv@ccns.ncku.edu.tw,
        Yu-Chun Lin <eleanor15x@gmail.com>
References: <20250223164217.2139331-1-visitorckw@gmail.com>
 <20250223164217.2139331-4-visitorckw@gmail.com>
 <d080a2d6-9ec7-1c86-4cf4-536400221f68@gmail.com>
Content-Language: en-US
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <d080a2d6-9ec7-1c86-4cf4-536400221f68@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/24/25 07:24, Uros Bizjak wrote:
> 
> 
> On 23. 02. 25 17:42, Kuan-Wei Chiu wrote:
>> Refactor parity calculations to use the standard parity8() helper. This
>> change eliminates redundant implementations and improves code
>> efficiency.
> 
> The patch improves parity assembly code in bootflag.o from:
> 
>    58:    89 de                    mov    %ebx,%esi
>    5a:    b9 08 00 00 00           mov    $0x8,%ecx
>    5f:    31 d2                    xor    %edx,%edx
>    61:    89 f0                    mov    %esi,%eax
>    63:    89 d7                    mov    %edx,%edi
>    65:    40 d0 ee                 shr    %sil
>    68:    83 e0 01                 and    $0x1,%eax
>    6b:    31 c2                    xor    %eax,%edx
>    6d:    83 e9 01                 sub    $0x1,%ecx
>    70:    75 ef                    jne    61 <sbf_init+0x51>
>    72:    39 c7                    cmp    %eax,%edi
>    74:    74 7f                    je     f5 <sbf_init+0xe5>
>    76:
> 
> to:
> 
>    54:    89 d8                    mov    %ebx,%eax
>    56:    ba 96 69 00 00           mov    $0x6996,%edx
>    5b:    c0 e8 04                 shr    $0x4,%al
>    5e:    31 d8                    xor    %ebx,%eax
>    60:    83 e0 0f                 and    $0xf,%eax
>    63:    0f a3 c2                 bt     %eax,%edx
>    66:    73 64                    jae    cc <sbf_init+0xbc>
>    68:
> 
> which is faster and smaller (-10 bytes) code.
> 

Of course, on x86, parity8() and parity16() can be implemented very simply:

(Also, the parity functions really ought to return bool, and be flagged 
__attribute_const__.)

static inline __attribute_const__ bool _arch_parity8(u8 val)
{
	bool parity;
	asm("and %0,%0" : "=@ccnp" (parity) : "q" (val));
	return parity;
}

static inline __attribute_const__ bool _arch_parity16(u16 val)
{
	bool parity;
	asm("xor %h0,%b0" : "=@ccnp" (parity), "+Q" (val));
	return parity;
}

In the generic algorithm, you probably should implement parity16() in 
terms of parity8(), parity32() in terms of parity16() and so on:

static inline __attribute_const__ bool parity16(u16 val)
{
#ifdef ARCH_HAS_PARITY16
	if (!__builtin_const_p(val))
		return _arch_parity16(val);
#endif
	return parity8(val ^ (val >> 8));
}

This picks up the architectural versions when available.

Furthermore, if a popcnt instruction is known to exist, then the parity 
is simply popcnt(x) & 1.

	-hpa


