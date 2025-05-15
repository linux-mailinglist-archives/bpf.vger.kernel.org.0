Return-Path: <bpf+bounces-58286-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A314AB859B
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 14:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 811F63B7248
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 12:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F88B298C10;
	Thu, 15 May 2025 12:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="W30hH1L1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1125217BB21
	for <bpf@vger.kernel.org>; Thu, 15 May 2025 12:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747310659; cv=none; b=A15Yv3HW0xHuR8q2lHnB/zZqivCPrYRV/lBZ9Z2bVugbhn6dt+9jdlP6hHrkJeUb/SaUFrqM50VM6uVbmZXteB2uQl3qJ7eJdENkRPNecPxAYW0q7NgxY+roWRjq3kHwNVq48OAkahl+zJuwIwyO55g821pERWHepjIAcmADLY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747310659; c=relaxed/simple;
	bh=EyJpXkdehfh1auuhWF9I8kU2/U0fgbfr4WDdkSgpv4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XPdghDE5Pr09GWMIOxwNftF5qWO/ZWMqE11POkIi08LBHc5MPzxfan0Lohte4NWH75++U9pamWOR95qsDA85BCGQv4upQ+akoD3YDRed++JQ6OVXhSWqKgdLWszl/q+rEnZdGFcVj1N1C6jxV7Ztj5iL9gxsjOCbVzSG3kJyKZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=W30hH1L1; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-441d437cfaaso5258445e9.1
        for <bpf@vger.kernel.org>; Thu, 15 May 2025 05:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1747310655; x=1747915455; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JtVqjc80kK6sCY9kafM0HVeU2C9ROGazwmNlgFnahQM=;
        b=W30hH1L1mHPDaBRDjm823zou2uswuA7JSqIM51CUWXseq6jjmjSeiEy71NwM3dDYFL
         IUyGCr4FRx0mSK5QBeZrgaykfaKDCApAF2kE39K0/bd2cnAioEeLguTThYiaBZ7F36Pw
         wCoyj700BrMBzhS6nyNADKVA/zV3rPrs7/quubdbIqCMgCcinfHLholnKfaPILHOjopZ
         wJ6eX08U/r8qYISPhJcrBjz7RmLOCy+3cvpQYVJ999qp0S3swcYO53ugT7HG6GOX1gge
         Df0YCPdsH5hdQl7iAspMOPp+VAHK4VuXorr4axY/OzP6A+VUpfOKNZxb5CLCajuW03TA
         jwfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747310655; x=1747915455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JtVqjc80kK6sCY9kafM0HVeU2C9ROGazwmNlgFnahQM=;
        b=KPHIqfGCgVcnyPvrNB/lWNPwyIcI2Gdxsdemct0QUKHfB/6XRst2/q56HMegGfavBG
         asPhD2tOyW8MSFyMPNulVo69EYgYLE1pQrC/h3tX2s8Cra4NYhv65so30zhyDZG1U4EC
         HD2bCEUuR0zLGXOUwyOE4WruqokKJ7YGo7/5cwgShwiqR+3RO/z/kJGJeoJ1DGcXxHt1
         wEhnhiHjF5HEnqb2IBZF+GNpOpY61KvTgtziG1wwC+uxtEbaIldC+npC2VbJ77qWUB6n
         5A308t7xPPwvY3Tz3lV6dy78uMHtNblDOgmLKzpQ4jcDEaB7bVd/Uv+yWxxhcFcGgIh1
         1K5g==
X-Forwarded-Encrypted: i=1; AJvYcCXXCGslY35XhcH54OPomTop9GjPvJRsrr9Y2p45nhKzouv1EwFj1Zn8J8V5fSyKXBCB36Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ7muHRYLFC3jUNn7BbWTjAeAkCPiQ/bJ6Sn/PIFsDnbe0uPgm
	bJeP5OVrpJYydXpaOOcC8TyZ2yJMewjV0IKCI/5+A/xoIi7TYL7R7mfQoZ7KxqA=
X-Gm-Gg: ASbGnctnxltdnZI9D5iGz5TUk0eIDw1jK/JsyhT298E5UUn7R6a6LU4ab+xHBEs1vzD
	gf1IF2890H2yuSQ1/0SyfSyoE6tulexcjC2FFyH6jQUgPss9TzcivQqNEtrppxswuaKhmUwX8ar
	raq4XvATr2O4hsiy7CE3zL2U8ecSsR2eB+lwSihzokOqzLwaRq3RthfCoL7+nta8Z7Z0VVwdVPs
	Vqltgmsu4/hjPqLk10cjsn/pvnkjixkyqB9i16scbb9R/f1dHKI64STbTgTO17g1nHezamLmZzU
	JDjWiVm28xzlkJ5WzA90rwG0OMMR0jR2Xq9gKjK6TTmSD/MRsovGuGAcf2tOxFID5lZ18e7yQYA
	2ox7lZon0C0ve7yHHgYLbLBjwZubG7ac9geh2XWeL/u35
X-Google-Smtp-Source: AGHT+IFVleGXWb394vxJ3g1TFClYBJH1ORxzbyUoB3lbpc/3PPg81qikPncaNTT+LnlATVlgCEOW0w==
X-Received: by 2002:a5d:598f:0:b0:3a3:4a1a:de6f with SMTP id ffacd0b85a97d-3a353748601mr2088152f8f.26.1747310655226;
        Thu, 15 May 2025 05:04:15 -0700 (PDT)
Received: from u94a (2001-b011-fa04-b2d3-b2dc-efff-fee8-7e7a.dynamic-ip6.hinet.net. [2001:b011:fa04:b2d3:b2dc:efff:fee8:7e7a])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26e383cdaesm456300a12.33.2025.05.15.05.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 05:04:14 -0700 (PDT)
Date: Thu, 15 May 2025 20:04:06 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Kees Cook <kees@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 6.14 000/197] 6.14.7-rc1 review
Message-ID: <6cratgkqkq4lnln65bqjiqn4vle7uhtlvnmi5r2v3l4lug3g5p@n55v6sogh6x2>
References: <20250512172044.326436266@linuxfoundation.org>
 <g4fpslyse2s6hnprgkbp23ykxn67q5wabbkpivuc3rro5bivo4@sj2o3nd5vwwm>
 <20250515041659.smhllyarxdwp7cav@desk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515041659.smhllyarxdwp7cav@desk>

On Wed, May 14, 2025 at 09:17:45PM -0700, Pawan Gupta wrote:
> On Wed, May 14, 2025 at 07:49:29PM +0800, Shung-Hsi Yu wrote:
> > On Mon, May 12, 2025 at 07:37:30PM +0200, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 6.14.7 release.
> > > There are 197 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > 
> > Running included BPF selftests with a BPF CI fork (i.e. running on
> > GitHub Action x86-64 machines), I observe that that running the BPF
> > selftests now takes about 2x the time (from ~25m to ~50m), and
> > verif_scale_loop3_fail is timing out, taking more than 6 minutes to run
> > compare to the usual single digit second runtime. See [1] for the log.
...
> > Compare to a day before when such behavior wasn't observed[2], the main
> > difference being these additional patches:
...
> Not sure why but this commit seems to related to the failure.
> 
> Below is log of bisecting v6.14.6 and v6.14.7-rc2 with the test:
> 
>   ./tools/testing/selftests/bpf/vmtest.sh -i -- timeout 20 ./test_progs -t verif_scale_loop3_fail
> 
> # good: [e2d3e1fdb530198317501eb7ded4f3a5fb6c881c] Linux 6.14.6
> git bisect good e2d3e1fdb530198317501eb7ded4f3a5fb6c881c
...
> git bisect bad 336f780075f36e0d1181ce44d6d4197e4a22babc
> # bad: [665f26e5de2325e3bca107b632bc2ccac1b9806a] mm: vmalloc: support more granular vrealloc() sizing
> git bisect bad 665f26e5de2325e3bca107b632bc2ccac1b9806a
> # first bad commit: [665f26e5de2325e3bca107b632bc2ccac1b9806a] mm: vmalloc: support more granular vrealloc() sizing

Thanks! Just dawn on me after seeing this that I should try 6.15-rc6 as
well (which has 665f26e5de23), turns out it also reproduce there. I'll
report regression in a separate mail. 

> ...
> > No patches touch BPF's core component, and while the
> > verif_scale_loop3_fail test did time out, the verifier is still
> > correctly rejecting it, so shouldn't have anything to do with
> > kernel/bpf/. The x86/arm64 BPF patches only affect JIT output, and only
> > for cBPF.
> > 
> > In comparison, with 6.12.29-rc1 I don't observe any timeout or increase
> > in runtime[3]. Below is a diff comparing the applied patches in
> > 6.12.29-rc1 and 6.14.7-rc1. Seems like 6.14.7-rc1 does not have the
> > CALL_NOSPEC patches, but I cannot tell whether that is what makes the
> > difference.
> 
> Thats because CALL_NOSPEC patches were already part of v6.14.

Ah yes indeed, sorry about the negligence.

