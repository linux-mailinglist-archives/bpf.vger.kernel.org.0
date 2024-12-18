Return-Path: <bpf+bounces-47274-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CD99F6EB3
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 21:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65E911891D88
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 20:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9179A1ACEA9;
	Wed, 18 Dec 2024 20:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="JCVVG6e9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81129155C87
	for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 20:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734552447; cv=none; b=OjoJnX7O043Hw8EasBAJ10av68MQ4itEwYdYpNKn6QCGWIKQoBnsjRkV312qzFTwYcWVr0XpSMxP7gwUv2lNVofcAV7xi9YXRC94jfIUgZ7BBygLCwGe02r8UZLRANV+UD2MuNSZmQmOqgRNZh8X6g1shrdoQp4V/E4XhE/SHK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734552447; c=relaxed/simple;
	bh=reNb33p8ZFNMasAvm6MxHiUhws5MHyDY0tODggGoNGM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bu+O6jw62aWZr91pnfrdVdbXx/ysAVdp6JQNU8hyRt/0jC/etPtwTDzxIQIZkSIpyZPE909NZLeJYVlbe/syxi7kVbYE40YwaN5JOSRVe/fG3cCwPvPas27wRNZ/a4lmYPbvX+XcsKNnfBKy/BngVId6+G/ntCmr/XsVPflTzSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=JCVVG6e9; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1734552438; x=1734811638;
	bh=reNb33p8ZFNMasAvm6MxHiUhws5MHyDY0tODggGoNGM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=JCVVG6e9y4fYNXturutAHhVeZAEjK2L02cWipB2vbje9r/DqjX3bko4nCbI5Yg/SJ
	 J2o/3QNUranTVNWThhGTmZCSG+y0O0A/83ugH+0OiIxEmF8FwLoWoO7jjKtcyPIoRd
	 pnFiztGiMO9KE92zV4n5yi8nQxjCQYP05YrsxMja9Y892BGTHMW4BDrMbDcUsRXGrt
	 wA4cV+c8wXEfpAiGjiPLcSkAazoaBDSDeIJQsQt6ftAst9/iTOq8puU33o+4ELYDuR
	 34Byovoo6Z1Rq8I3ilXludVEPwLgrHmrZSRshoDtc8Z4HtkPuATHlsv2bske/kI/FO
	 Yjfk5OG6nWVJw==
Date: Wed, 18 Dec 2024 20:07:11 +0000
To: dwarves@vger.kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, acme@kernel.org, alan.maguire@oracle.com, andrii@kernel.org, mykolal@fb.com, bpf@vger.kernel.org
Subject: Re: [PATCH dwarves v2 07/10] btf_encoder: introduce btf_encoding_context
Message-ID: <C82bYTvJaV4bfT15o25EsBiUvFsj5eTlm17933Hvva76CXjIcu3gvpaOCWPgeZ8g3cZ-RMa8Vp0y1o_QMR2LhPB-LEUYfZCGuCfR_HvkIP8=@pm.me>
In-Reply-To: <af9404ef750f152afb20b2883aad3b9fc5e5a2dc.camel@gmail.com>
References: <20241213223641.564002-1-ihor.solodrai@pm.me> <20241213223641.564002-8-ihor.solodrai@pm.me> <09f6bc335380ca73d365566de7af8f2e73ac9cfd.camel@gmail.com> <735014fda88330d2124f4956cc9a0507f47176db.camel@gmail.com> <yKpaq5zO0TcrAm1v3p4yd2D9ic0jGUQM0CUSg6CU_31_S1mX7SDljMf36ayteEV2O_MTE2eJkUuu3JoJWPQyIxHibe2zz1W3Uq_RzqiyPVY=@pm.me> <CAEf4BzZ-chyzJzCdW0AwjaxhO+yfUCO=Dcu+7=m96Ccyq94Y8g@mail.gmail.com> <af9404ef750f152afb20b2883aad3b9fc5e5a2dc.camel@gmail.com>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 803acab5a85656a3bb36705c01b3e4f7ac96d446
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi everyone.

I had a discussion off-list with Eduard and Andrii and we came to an
agreement on the next iteration of this series.

Patches #3 and #7 will be changed: since there is only one encoder
now, there is no reason to maintain global state, such as list of
btf_encoders and list of elf_functions structs and corresponding
locks. Refactoring about separating elf_functions from btf_encoder
will largely remain, but the object itself will live in the
btf_encoder.

Patch #10 (dwarf_loader workers) will be modified to use only one
conditional variable as Eduard suggested [1].

Andrii and I also ran a bunch of experiments to understand why after a
certain point adding more threads noticeably slows down the
processing. It turns out that with the number of jobs growing, the
dwarf loading threads start competing for memory allocation in
cu__zalloc. This can be partially mitigated by setting a larger
obstack chunk size. I will add a relevant patch in the next version of
the series.

[1] https://lore.kernel.org/dwarves/58dc053c9d47a18124d8711604b08acbc640034=
0.camel@gmail.com


