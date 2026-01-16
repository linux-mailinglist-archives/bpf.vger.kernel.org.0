Return-Path: <bpf+bounces-79224-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 656F0D2E0DD
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 09:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA46E30274C3
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 08:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9F5303A26;
	Fri, 16 Jan 2026 08:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="wkvrgnsw"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348CE303A1E
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 08:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768552217; cv=none; b=FuH9YqNSuu7NQFDkK/5+H40nYb97S0VM6/wgjw2+XmIeoHxp97oPu6+3EVIen67+EFQSCPK4SjT7tdBUtgspjSc0w0ich5ZtxyE4GnML0PQkA5Ogp+rPw/B5IEB8HxgIInBdsKIFBATu70RAousi4LyKWUdvjcNL8D+rzf8tXrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768552217; c=relaxed/simple;
	bh=GJpf5ccuoWBkGAI1gkjRq80nB739hRWMCQDkibosQbA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=pTE1B75Z35/tcNwxN/gWLoTnXXPi+cNAuEzavBIKcZLGOKJs1Jhpi3FL8h4UPN/nXFQ54PACnwUEqoef57fDCa6MP3BowCFGmPAxCVBjZzr8phcF8eDo4yuKWI3pSZPaMUj5p6ndq+wHtPxDlBKcmlIUIuw/DDq5BzMynO+szkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=wkvrgnsw; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id B9F6EC1F1F7;
	Fri, 16 Jan 2026 08:29:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7DD5860732;
	Fri, 16 Jan 2026 08:30:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2FC6710B6897B;
	Fri, 16 Jan 2026 09:30:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768552212; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=GJpf5ccuoWBkGAI1gkjRq80nB739hRWMCQDkibosQbA=;
	b=wkvrgnsw6fTzDbFqbeZyxB6IKKuNbd6OcIa55EQdmZsZVTZcD0Si2SI7qVnnC3sA+D3QiI
	M40x8qOgNrTei1oQcOt7uizlrHSSa3plJbugl6vRm+74NGMGlW0W0CDppbRRj1zENP2s54
	rVUFPJeffq3njOwO3bGJ73o+OujtPYP0d1hcMhy1dWlAi5nGybC/xCeVHDABAtLU1HWqzu
	U19WmKA5/1wNk2kYDTx2km2RQyNylo4v4ig2noLuVmEnZT8xHeME7jxaAZir3vq0k+GYZz
	cxS8luKZOsyVIV/HRED7gK+CcvspkptIVAsOb8ClolwPY5kVGZ9rIUnxh5eiIQ==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Jan 2026 09:30:08 +0100
Message-Id: <DFPVFON6H9AQ.3BE95ZHQ3ATOL@bootlin.com>
Subject: Re: [PATCH bpf] selftests/bpf: Support when CONFIG_VXLAN=m
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <martin.lau@linux.dev>,
 <eddyz87@gmail.com>, <song@kernel.org>, <yonghong.song@linux.dev>,
 <john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@fomichev.me>,
 <haoluo@google.com>, <jolsa@kernel.org>, <alexis.lothore@bootlin.com>,
 <bpf@vger.kernel.org>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Alan Maguire" <alan.maguire@oracle.com>, <ast@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260115163457.146267-1-alan.maguire@oracle.com>
In-Reply-To: <20260115163457.146267-1-alan.maguire@oracle.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello,

On Thu Jan 15, 2026 at 5:34 PM CET, Alan Maguire wrote:
> If CONFIG_VXLAN is 'm', struct vxlanhdr will not be in vmlinux.h.
> Add a ___local variant to support cases where vxlan is a module.

Just a naive question: for ebpf selftests, aren't we assuming a
dependency on a "fixed" kernel configuration (ie
tools/testing/selftests/bpf/{config,config.vm,config.<arch}), which
enables most of the features as built-in ?=20

Alexis

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


