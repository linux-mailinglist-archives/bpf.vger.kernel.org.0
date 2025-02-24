Return-Path: <bpf+bounces-52446-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47464A42FE5
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 23:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD7C617B120
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 22:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F3920550B;
	Mon, 24 Feb 2025 22:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSJCPTNg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BBF5383;
	Mon, 24 Feb 2025 22:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740435455; cv=none; b=I69DsBChTnmNfeRBRAvrMdnRonb3HGriiNJB2i4VgrcQ+RE3CDHdrKtS2NRqPuFbuJzY2XJdgRrliyVm6sLXcRJGagpnsE5mnesfOmAg9h47CCS2FfF4XIVfcLF6ATfLYvoCS8BXclDd5LNShHcT/fAlrERwT4MIjSJqZpksT+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740435455; c=relaxed/simple;
	bh=fsXk7cQiXABl/mlEd5HYoSOLhw00DiL9RvUkyobxBIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=thjIdZyACJTJZb4lkwxVCtp+qsKJKZnpOBX83h1yhlFCO4o70V7DYpw0mrf4n1336CrJmpaRBTQpNR9a/TTYdVCu5ZYhRCJUo/VsgyEKgM99CrUshBmhsr8QlAJiHMsOrvtwZK0FEtpq1ZMvGVheGB6Q21Rfgr5Fb7kAEJ8Wz/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QSJCPTNg; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22101839807so107242785ad.3;
        Mon, 24 Feb 2025 14:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740435453; x=1741040253; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MIAmGwREzfChZxhZrA3OzxmyUXhIuIWMIVivU3ALR/o=;
        b=QSJCPTNgqJn5+1Kmn4+YsJFUjbK68+I0xGHyhSuCHnrdlmTQFHOyMuYyow7TyI/8b9
         oSL1xsvYOxw2CJP3cO1FdqIptyRTn0PKkJuaibIlK3U2kwAFBejMK0Z923clllySER07
         P9UHSHyHdllIbuK+67PlFxqVPmBiKt4mV2gNGlBHRsBSHE0PQX7U99lclGluo/sNENs8
         QDhp/pfhrdl/eBjKznWXrJy7I7bw5IeszqsLExXMngL0jlk5KU2WmmNFXFFGGaQxqach
         0G4f12uIpl52WJ7a1+VdBsrakGEkXHPZwoe8RI706GZ+8GriutDZL99/5CXvjoDzGUOW
         MLuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740435453; x=1741040253;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MIAmGwREzfChZxhZrA3OzxmyUXhIuIWMIVivU3ALR/o=;
        b=cFdYYOkFr1z+FhW+ExsInt3eCPINfJnrsV6kM/OaC7qYJuc9nGH1GxP/06BG7KT7cz
         W3VGfJTa5PHomzWsMX1wHpJv2ZgTq9kMHMGzTicT0TgDXaoasth95xMoPorAOtnlKvMp
         6wkLbyMYNOAWD9ScpBpQt+RPT+eip4CHl9g8vKLq0XEyZgkG1+MbsoxD1x5Eh3WbvfMY
         1fDsawerInbszDPPdZ7FSVJBohGKvNk8aO2O3BMJyR/7wSrHZGW6Q7ABzbLxUC8NijC7
         mGbLTAYJ1uAyu2gxvJy9yWcjFUWbFea93eM/wt7G6AsgCnJ17RTL8NgE8bn4FtLP4j9S
         meRg==
X-Forwarded-Encrypted: i=1; AJvYcCUNMsFmIVI9aCkMGolehgomnXbnI9IL4mZvHZmgpCKW8ZhHyS6Kfo+bhaz/I03fNoV+7ih8ZUvl@vger.kernel.org, AJvYcCVBL+Jmu8Jnj8WM21BsX0cu9qeho73VRlvbsVNNiyTOcjIGWqo49NejP5RuKsifsBN7U5KjU0eo9nUhB6Cs@vger.kernel.org, AJvYcCVdTlyFpNMhl3kARTfQSmHEaCFzC9eQ8O/bu3cAqxMQoYn3FRgVi/nRLNZW1cSKuEuZ3VTC5P3fI74zWd0=@vger.kernel.org, AJvYcCWhokx6FTMxOBHHBUE2iNrKdIDpTG9EtBHiiKK3lmYZUQO/tdgQ8LU48/Fd4yVA6bxrOgJua7uZuyZ/he0=@vger.kernel.org, AJvYcCX5p3fSN95may0i4GMiz/0bCKAeBV4XoYnWFdt9W0OdQrMtgZXsZBu5/08jVWS9zTQc0jmv+Y/JkU3RsAddqhU=@vger.kernel.org, AJvYcCXhLNARRLMki/vmiR3t7oUbZnhsNcqTe+sMQmfdkRpacn9X7Pq5nnOQA/a1b3W0loW7Y20=@vger.kernel.org, AJvYcCXjMp5HMpVf/x/qsFz3nHDX3dfpej1sD3bVtnqkkKyeU9fu22QJMeaERZa3jWuIlGlpD0fwX5vdmX3HeOnK@vger.kernel.org
X-Gm-Message-State: AOJu0YzXAAG5IWQdT79iJg0WD4dAzva5oJytiAZox8FqlJjqOT6QkL99
	wUXsNru/TaS3ocAR0MasPXZlJfsKDgtJXtWU7OR/x3ozCVmbLocz
X-Gm-Gg: ASbGncvSnOH/81VuNCSnFu/ytb4X23N1wmsJlW92rX9o5fmIkTSepC+u4/8fcCTZ46I
	1qBe5q7Zqw3FKuwleJZxcVTOoYs6IxCYhBViNhU2+j1Gpi5ANg0pPOUqWROyLcu5rRixL5G+mBQ
	lOeLhX+WTQGUdZW7t1Qh9cnZEqrKWm35YrFWQvSeZ/km4vFW9Ug22fyKeSpxiJiV4jK+0cu49Ir
	BI/5bOCVPCeEb7uXYSp8SlOLfRIv4poNqLW0S4KjOX8PAwOYg7GcFFj+Kn2YsdMjS45HtSJ5s3i
	klRkufGvdmLnJjkk0ydlV/ftYo76EuPQz03wxVrCbO+7hYagdg==
X-Google-Smtp-Source: AGHT+IHUNZzOI1ZFK/Wig2ECxEjG2LCeoTVF/IwXlP7H5EbtmMAu2d6RHqgduSyhdb+wHec1lfRRUA==
X-Received: by 2002:a17:903:2a8d:b0:21f:6584:2085 with SMTP id d9443c01a7336-2219ffc4928mr267486635ad.42.1740435452344;
        Mon, 24 Feb 2025 14:17:32 -0800 (PST)
Received: from localhost (maglev-oncall.nvidia.com. [216.228.125.128])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a01fe28sm1125415ad.100.2025.02.24.14.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 14:17:31 -0800 (PST)
Date: Mon, 24 Feb 2025 17:17:29 -0500
From: Yury Norov <yury.norov@gmail.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Uros Bizjak <ubizjak@gmail.com>, Kuan-Wei Chiu <visitorckw@gmail.com>,
	tglx@linutronix.de, Ingo Molnar <mingo@redhat.com>, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, jk@ozlabs.org,
	joel@jms.id.au, eajames@linux.ibm.com, andrzej.hajda@intel.com,
	neil.armstrong@linaro.org, rfoss@kernel.org,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	dmitry.torokhov@gmail.com, mchehab@kernel.org,
	awalls@md.metrocast.net, hverkuil@xs4all.nl,
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	louis.peens@corigine.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	parthiban.veerasooran@microchip.com, arend.vanspriel@broadcom.com,
	johannes@sipsolutions.net, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, akpm@linux-foundation.org, mingo@kernel.org,
	alistair@popple.id.au, linux@rasmusvillemoes.dk,
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
Subject: Re: [PATCH 03/17] x86: Replace open-coded parity calculation with
 parity8()
Message-ID: <Z7zv-c4A76jeMAKf@thinkpad>
References: <20250223164217.2139331-1-visitorckw@gmail.com>
 <20250223164217.2139331-4-visitorckw@gmail.com>
 <d080a2d6-9ec7-1c86-4cf4-536400221f68@gmail.com>
 <e0b1c299-7f19-4453-a1ce-676068601213@zytor.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e0b1c299-7f19-4453-a1ce-676068601213@zytor.com>

On Mon, Feb 24, 2025 at 01:55:28PM -0800, H. Peter Anvin wrote:
> On 2/24/25 07:24, Uros Bizjak wrote:
> > 
> > 
> > On 23. 02. 25 17:42, Kuan-Wei Chiu wrote:
> > > Refactor parity calculations to use the standard parity8() helper. This
> > > change eliminates redundant implementations and improves code
> > > efficiency.
> > 
> > The patch improves parity assembly code in bootflag.o from:
> > 
> >    58:    89 de                    mov    %ebx,%esi
> >    5a:    b9 08 00 00 00           mov    $0x8,%ecx
> >    5f:    31 d2                    xor    %edx,%edx
> >    61:    89 f0                    mov    %esi,%eax
> >    63:    89 d7                    mov    %edx,%edi
> >    65:    40 d0 ee                 shr    %sil
> >    68:    83 e0 01                 and    $0x1,%eax
> >    6b:    31 c2                    xor    %eax,%edx
> >    6d:    83 e9 01                 sub    $0x1,%ecx
> >    70:    75 ef                    jne    61 <sbf_init+0x51>
> >    72:    39 c7                    cmp    %eax,%edi
> >    74:    74 7f                    je     f5 <sbf_init+0xe5>
> >    76:
> > 
> > to:
> > 
> >    54:    89 d8                    mov    %ebx,%eax
> >    56:    ba 96 69 00 00           mov    $0x6996,%edx
> >    5b:    c0 e8 04                 shr    $0x4,%al
> >    5e:    31 d8                    xor    %ebx,%eax
> >    60:    83 e0 0f                 and    $0xf,%eax
> >    63:    0f a3 c2                 bt     %eax,%edx
> >    66:    73 64                    jae    cc <sbf_init+0xbc>
> >    68:
> > 
> > which is faster and smaller (-10 bytes) code.
> > 
> 
> Of course, on x86, parity8() and parity16() can be implemented very simply:
> 
> (Also, the parity functions really ought to return bool, and be flagged
> __attribute_const__.)

There was a discussion regarding return type when parity8() was added.
The integer type was taken over bool with a sort of consideration that
bool should be returned as an answer to some question, like parity_odd().

To me it's not a big deal. We can switch to boolean and describe in
comment what the 'true' means for the parity() function.

