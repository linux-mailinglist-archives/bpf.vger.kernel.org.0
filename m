Return-Path: <bpf+bounces-57999-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D54BAB31E2
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 10:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B89DE3AA60F
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 08:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F24259C9E;
	Mon, 12 May 2025 08:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkIJKLqw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E0E258CD5;
	Mon, 12 May 2025 08:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747039302; cv=none; b=Wahq7IFXlMb7ohQXNiBP4os1GJxgoleHEs4Ijhpslfm15THZSDBgthSpkw4181x/vYfNYIPUMvKHp2P/FsK6OZK2aOXqeXvcvyEas7vXDcDVKIRcHffARfKQ6Ycvx5KszWC+LXYjYT8yIOi1u5b2DphhiToPiJO6YLNVIolijqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747039302; c=relaxed/simple;
	bh=hqBX+xGfNElrgdTW9eIfxPqbLZN2mU7X2qWEDWx5qdQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MDRe0tzlvnXnzGcsPJMWvAyquG1MgymAPE/ojPPutrif4lxlputQiilXXcdPLUa8MDWCwcESne9fAQNlYIaSn3vEylXASrDGpOoheVykGNsBsstXJYtwnpOiktslLDPoQiRjJCvrvpyQvGYMyV8Gh03DFmM9VcRSBpyKYePn6Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nkIJKLqw; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-73c17c770a7so4974120b3a.2;
        Mon, 12 May 2025 01:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747039300; x=1747644100; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UmmPAcPe/c87F8AEMy+drk6M/wujfqyOh/FDo+55s0k=;
        b=nkIJKLqwXU46fNebqkdXtCu4zdNou0trugsv8c/j8akxiF+BNmC5ICrOpZkFyaI4Hp
         qVsaYQBfgEtSGzp93v6qnrcoC/Pelwmu9OUg39XC1JyE+EFXPU96pT39RJ+D2PADtiDM
         HJIUljR0qj12oY4jFyX/k+FfiyCHmjYOuCspyaL3yq1yYJ7VrLplm3R8tU0PraWMLPVt
         V7ohNJcC6lTFYa6D7+K58N+oCBSuw0MeGbppwSPFna2BCCtatt4xNs9oijlKP+FfgPuX
         4ZRLDHzhKKeBmu72O8jXpeDr2b/c/8ggxnHhv2K6YFgwy8+weigLzQCpVdrksbTvlEcz
         9RHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747039300; x=1747644100;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UmmPAcPe/c87F8AEMy+drk6M/wujfqyOh/FDo+55s0k=;
        b=TWuAzYJbKhdiZ84uiIzXMHPmA+zz0Yajun/9Y2EmM849OxnnG2pCu9h4FNbxBZBvy6
         3708AACv6kS7ecqDMM40zKvhcMvyN7QUWkOM1Hy29A/pZymFMBHowUl0z8iqbjaf5Wi7
         vaJYGFDdV5Laozkd0at61wNQEHgZrK06/55B7apX0mKJAjXlvakLKcex1SINAUy3+J72
         xsN/eULQhAdPtkalXpcw34bOAOFFDpBz5CZa5tPAPsGAHFftnGAHqPbrYp7YaJ97Be/Q
         ENIU7Pgl7QVrx8mxU3iTgrt2PwoFrLht1tf/mlAeOHpgP5svbbYp5bzAEjFWVQwvg2J0
         vp9w==
X-Forwarded-Encrypted: i=1; AJvYcCVPmCjI7FxUFZE3nzGdoHqjDOD0rMKGTmXNgZoM/OdacblNEChE0lSglWp+cON6XaxaZJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVIJ3YNFnD1gUHoGf6C+qXwhYbAqa8DRmrqx4Rhsi7jKwfgIQ3
	qkOA2+79WADk83W2VyJbwqRYEVA/7Asbm9XkWQt3kIZOd10G8+eL
X-Gm-Gg: ASbGncv+PE4V9aC8gNRNfg2lgnz34uZwXDORYtmexvczMPmc2SIlcXW2sWRwDFk6C+8
	aQppxdSIJJUSgb9ATzvNAAWvdW07MzRt6MOMsHe8uXj1prCJxVjUyWJfGdtO0K72e2qc6DRVdUh
	GIG/fr0sDty46If0T0YPhN5jUIau/wydgJ2uroAJRcG4GV7GMljiSzDs8UMw+jPIrSysD9wg7CZ
	MgJ6gy0mgT0gJBmyYipREw6+voc/oKg/iS2bKlBsQEwH0h/dlTZ1Lb/rsazunU5eI6OoNEmO015
	VwzdcuVmzgFAcIEO9kIss5Ucjy7DRtfY0KyOP5LJjj5iVhF96ymOaSXG/E7WBPYF7Qj9ulEXyi9
	5sOEjtYcTP/waz04VnA==
X-Google-Smtp-Source: AGHT+IHK+FP+VA1MzFOQX4DTYugWnrHSfZgtJ+QmwPItd1tXwd4DhHAHN4Yl/t1egY/IQgtiLexm1A==
X-Received: by 2002:a05:6a00:181f:b0:736:a8db:93b4 with SMTP id d2e1a72fcca58-7423ba8738bmr17113330b3a.2.1747039299781;
        Mon, 12 May 2025 01:41:39 -0700 (PDT)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237a89b11sm5409297b3a.163.2025.05.12.01.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 01:41:39 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Mon, 12 May 2025 01:41:36 -0700
To: Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>
Cc: dwarves@vger.kernel.org, bpf@vger.kernel.org,
	Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH dwarves v2] dwarf_loader: Fix skipped encoding of
 function BTF on 32-bit systems
Message-ID: <aCG0QKuwuOpGrZgs@kodidev-ubuntu>
References: <Z/+HZ3w2KmbK5OAi@kodidev-ubuntu>
 <20250502070318.1561924-1-tony.ambardar@gmail.com>
 <D9QOFW6WEIT0.2AJBVJINZRRBV@bootlin.com>
 <aB2Q3ylln95YFTCD@kodidev-ubuntu>
 <D9RHP83CJA32.1LGMU4SC9QJ1K@bootlin.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D9RHP83CJA32.1LGMU4SC9QJ1K@bootlin.com>

On Fri, May 09, 2025 at 10:33:50AM +0200, Alexis Lothoré wrote:
> On Fri May 9, 2025 at 7:21 AM CEST, Tony Ambardar wrote:
> > Hi Alexis,
> >
> > On Thu, May 08, 2025 at 11:38:06AM +0200, Alexis Lothoré wrote:
> >> Hello,
> 
> [...]
> 
> > Nice! I notice bootlin has worked on several BPF testing contributions,
> > and was wondering if your build is some new standard buildroot/yocto
> > config tailored for BPF testing, and what archs it might support? Reason
> > for asking is I have a large stack of WIP patches for enabling use of
> > test_progs across 64/32-bit archs and cross-compilation, and I'm keen to
> > see other examples of configs, root images, etc. (especially for 32-bit)
> > At the moment I'm targeting 32-bit armhf support to make progress..
> 
> No,  that's really a custom, minimal setup that I am using, based on
> buildroot. My workflow is roughly the following:
> - use buildroot to download an arm64 toolchain and build a minimal rootfs.
>   No specific defconfig used, it is a configuration from scratch, with
>   additional tools for development and debugging
> - configure a kernel for arm64 testing:
> $ cat tools/testing/selftest/bpf/{config,config.vm,config.aarch64} >
> .config
> - use the toolchain downloaded by buildroot to build the kernel
> - build the selftests with the same toolchain (so I am cross-building those
>   directly from my host, I am not really using vmtest)
> - run all of those in qemu, and run the selftests directly with test_progs
>   in there

Understood, and thanks for the details. I basically do the same, with only a
couple of differences intended to ease adding armhf as a bpf-ci target
eventually:

 - use the Ubuntu arm cross-toolchain to build on x86_64
 - use mkrootfs tools from bpf-ci to make a Debian Bookworm rootfs

Take care,
Tony

> 
> Alexis
> 
> -- 
> Alexis Lothoré, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
> 

