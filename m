Return-Path: <bpf+bounces-65807-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D736B28AA2
	for <lists+bpf@lfdr.de>; Sat, 16 Aug 2025 07:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0831FA24D68
	for <lists+bpf@lfdr.de>; Sat, 16 Aug 2025 05:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513F51DFD9A;
	Sat, 16 Aug 2025 05:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5UBxNQ9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62ECB33EC;
	Sat, 16 Aug 2025 05:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755321545; cv=none; b=Hvl4soB4jKfe/9tNU+GvzhLbAp+dRr1P56YylIQyKFmEeiwokcpI7hw8zetz5DeYsKSIvtIwVOw7xrSMp9Tdru6u2cvTHbbykYHAQxJotzJuWRbOLey9ZwM0Qt+THhwnj2qRvZcZYvkJ7zqscHHxWkOppRZjs6FpUoiEGNs/sNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755321545; c=relaxed/simple;
	bh=Gm64J36QXnfSRLkDe+0+vYNftocOboKLW+Bgxkh8el8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=NjqQZn3VfoVGr2U6FLcP5lMMgXaFR5tCVrZw2XVjMZR1UJYzS2NLPcHX/blBadVzs8It7DWYdSx+l/HiKd2FYiWwi+02JE3TA6eZX5WJhdYSXSuTBgim7YuT8jP+ufvihXtqMQuBYLdMz20N7l5KdmskgVyAe5TlzUJKjw1YN2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M5UBxNQ9; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76e39ec6e05so1413484b3a.2;
        Fri, 15 Aug 2025 22:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755321544; x=1755926344; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hg7l3bbSFZPtoIG+3mgwC3AL7gcWmKd442FKHZEi+xU=;
        b=M5UBxNQ90IfJAuC/CvPcRwAVmtiQrJZwHVfNo4bJIrW2sKDG9urx4e58/r7EWRfmeI
         gAyyQsAlCrrZNJc2C6KcwWYf9/CO0M95eC5ZOPBRLPT4XysVwom13oVdhndHKNrLFDRf
         LQPbdAWQ9KJsc7n3hA2tJKCVFtzv0PjdmJfT0MxCyyAMi6RSIVIool61ZziJMWvdr8Qu
         RhSUyYH7A1LCNzl4mKfZGCUO+bjlyrwE4gBYhLAmN3K95c5NUCC4cRQkHGlWF76fTvoI
         292dDJonjq4V6nkCXz6okMoKC9CxlZ4bENHIyz7F4RkFTGPp3iUH1vNEEPPWSr+uF2Lg
         C4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755321544; x=1755926344;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hg7l3bbSFZPtoIG+3mgwC3AL7gcWmKd442FKHZEi+xU=;
        b=kZjKpJX429btBEFhGMYptxgnIU87SQA79YruKFrfPreeYybs0IpA+Rew8dvXWtF7Z0
         vhZ44elLzEt0xbpWFXo1iM8VaAQGJ8E1SWIZkSm+Xk+BEb7clPgXoyjn/8KH8HekN2it
         TQ8yD4Mg1Ls1KImmacRDO8Ik5sg8u29fQ15zS/pULRh0ezFg6Wu6zKwE5+KHSfhNIkmu
         cmYixvIq3ljyfk6BMqcZrzB3RUTQSffJmM6Gdskx4/6+688x1hGmoOlO586S8yCI/L9j
         7OPr8Hyf5vc+jVGJQ5U3xOAE+ZkF9qonSjU+d1G0qH3DjOyrkAATsBxg+jHNayhH8Snd
         jnfw==
X-Forwarded-Encrypted: i=1; AJvYcCVFKdrw2i/Hseza/r7O3wALZhJ1vUUedsV0mds65WHvauM1RnlKBlKXEp4We0+Nkz4KtGB+xeo7L8o=@vger.kernel.org, AJvYcCVi4WXCu5rRjaXAagPQqC0I/4HhQSaHZdEJB/elODaEhDeRT921WmA93ALMPM2QOUERBF0i5ayxcLolUCiJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwMoT/r1BazNLAp4Q8k7yoJMPoVlbi+fGipinxofz8FyDNBQmWS
	a0ZcAQJARYOoL7bnjlK4uCOZlhSE9SwMMU2AgI+19Oew95Fcoj5AxcED
X-Gm-Gg: ASbGnct1z0WarmnszUaNH2MXHe93HwwQ0E5deOQTYCKwWqF6vMuaj41SMX8Zyj1xZ+w
	Gy6zj6k0Ltm+hYKccIPK2ArZri5Ca67oFfald6Ci/4Fj60ybfGTXYGJWDjfpuG41QRjRMeknSTw
	61SCr2ia6Ez8isfTlMw+vUwx90WWQABbaiRUgJ5M/BJvTBNaJVX1wp2Zywol9l8bDAO5gek0ntQ
	Q+zkwcN0gB/cJ0LhHQhg5/s+g8AfW4UAZbNJ1z94fGeb2smWogj8v/5N/quIuMS9kWnakxIOTEg
	XIJdxAcMF+2FevTy3LSSPwN1heExAGfY1B7x69en0A1nWyXrTWWwO3PmTsJ31bC8//+wHYWI3ud
	8DozvQEvzWHEpksElx5rbgDcFiibUfSgbYZPcNPd9llidVBtHkdkXBaBp5+mph/H/+96x
X-Google-Smtp-Source: AGHT+IFkeW6vUGKadK1tRdBbxQantqRYXD/XkBxSfAysSmRbdkf/hrVXlC5RZ2s3zvce2Tavkp5/7w==
X-Received: by 2002:a05:6a20:2585:b0:240:fe4:10f9 with SMTP id adf61e73a8af0-240d3006933mr7472724637.6.1755321543580;
        Fri, 15 Aug 2025 22:19:03 -0700 (PDT)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b472d602713sm2738470a12.27.2025.08.15.22.19.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Aug 2025 22:19:03 -0700 (PDT)
Message-ID: <773f4968-8ba5-4b1a-8a28-ff513736fa64@gmail.com>
Date: Sat, 16 Aug 2025 14:06:43 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: mchehab+huawei@kernel.org
Cc: bpf@vger.kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
References: <cover.1755256868.git.mchehab+huawei@kernel.org>
Subject: Re: [PATCH 00/11] Fix PDF doc builds on major distros
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <cover.1755256868.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

[-CC most folks]

Hi Mauro,

On Fri, 15 Aug 2025 13:36:16 +0200, Mauro Carvalho Chehab wrote:
> Hi Jon,
> 
> This series touch only on three files, and have a small diffstat:
> 
>    Documentation/Makefile     |    4 -
>    Documentation/conf.py      |  106 +++++++++++++++++++++----------------
>    scripts/sphinx-pre-install |   41 +++++++++++---
>    3 files changed, 96 insertions(+), 55 deletions(-)
> 
> Yet, it took a lot of my time.  Basically, it addresses lots of problems  related
> with building PDF docs:
> 
> - Makefile has a wrong set of definitions for paper size. It was
>   using pre-1.7 Sphinx nomenclature for some conf vars;
> - The LaTeX options a conf.py had lots of issues;
> - Finally, some PDF package dependencies for distros were wrong.
> 
> I wrote an entire testbench to test this and doing builds on every
> platform mentioned at sphinx-pre-install. 
> 
> After the change *most* PDF files are built on *most* platforms. 
> 
> 
> Summary
> =======
>   PASSED - AlmaLinux release 9.6 (Sage Margay) (7 tests)
>   PASSED - Amazon Linux release 2023 (Amazon Linux) (7 tests)
>   FAILED - archlinux (1 tests)
>   PASSED - CentOS Stream release 9 (7 tests)
>   PARTIAL - Debian GNU/Linux 12 (7 tests)
>   PARTIAL - Devuan GNU/Linux 5 (7 tests)
>   PASSED - Fedora release 42 (Adams) (7 tests)
>   PARTIAL - Gentoo Base System release 2.17 (7 tests)
>   PASSED - Kali GNU/Linux 2025.2 (7 tests)
>   PASSED - Mageia 9 (7 tests)
>   PARTIAL - Linux Mint 22 (7 tests)
>   PARTIAL - openEuler release 25.03 (7 tests)
>   PARTIAL - OpenMandriva Lx 4.3 (7 tests)
>   PASSED - openSUSE Leap 15.6 (7 tests)
>   PASSED - openSUSE Tumbleweed (7 tests)
>   PARTIAL - Oracle Linux Server release 9.6 (7 tests)
>   FAILED - Red Hat Enterprise Linux release 8.10 (Ootpa) (7 tests)
>   PARTIAL - Rocky Linux release 8.9 (Green Obsidian) (7 tests)
>   PARTIAL - Rocky Linux release 9.6 (Blue Onyx) (7 tests)
>   FAILED - Springdale Open Enterprise Linux release 9.2 (Parma) (7 tests)
>   PARTIAL - Ubuntu 24.04.2 LTS (7 tests)
>   PASSED - Ubuntu 25.04 (7 tests)
> 
> The failed distros are:
> 
> - archlinux. This is some problem on recent lxc containers. Unrelated
>   with pdf builds;
> - RHEL 8: paywall issue: some packages required by Sphinx require a repository
>   that it is not openly available. I might have using CentOS repos, but, as we're
>   already testing it, I opted not do do it;
> - Springdale 9.2: some broken package dependency.
> 
> Now, if you look at the full logs below, you'll see that some distros come with
> XeLaTeX or LaTeX troubles, causing bigger and/or more complex docs to
> fail. It is possible to fix those, but they depend on addressing distro-specific
> LaTeX issues like increasing maximum memory limits and maximum number
> of idented paragraphs.

No, the trouble is failed conversion of SVG --> PDF by convert(1) + rsvg-convert(1).
Failed conversions trigger huge raw SVG code to be included literally into LaTeX
sources, which results in code listings too huge to be rendered in a page; and
overwhelms xelatex.

IIUC, kfigure.py does such fallbacks of failed PDF conversions.  Mightn't it be
better to give up early in the latexdocs stage?

> It follows full results per distro.

[Ignoring lengthy list of results...]

I think all you need to test build against are the limited list of:

    - arch.pdf
    - core-api.pdf
    - doc-guide.pdf
    - gpu.pdf
    - i2c.pdf
    - RCU.pdf
    - translations.pdf
    - userspace-api.pdf

All of them have figures in SVG, and latexdocs tries to convert them
into PDF.

Probably, recommending Inkscape rather than ImageMagick would be the right
thing, at least where it is provided as a distro package.

Regards,
Akira


