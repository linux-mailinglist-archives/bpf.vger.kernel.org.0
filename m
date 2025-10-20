Return-Path: <bpf+bounces-71462-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DDABF3C38
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 23:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51A433A67D1
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 21:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF151E511;
	Mon, 20 Oct 2025 21:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="Ul3eNP2H"
X-Original-To: bpf@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061F329C325
	for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 21:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760995973; cv=none; b=ObKzI0C6HLnhCQo34dSVNwwD59nlv7gXyPtV/jnUBKkc3GtKigcnWx9BfTi+N/sgZGD44INUpeFzyRblK4kc08UZaFtBAeXw7VRR+1DH5XEKbmkJNnBj8kMzSo2+Zi2yjfAhntHCxp3vaknYhKlP+YuNdlQG2B42qVJZMWRmsCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760995973; c=relaxed/simple;
	bh=eHrECkEM63rtKZMGjxIdCIgrX3X5T3yvP2VGN/8TBC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u3yy/YgQpqLij9S0atCNTBqDTEybOqDsoIHKfZcdi6c4g7wUKghLhyDzLXBjHp7lUZTvPhxTEmmsxrl6qZBG60IEmAL6CR6dz3bCnBZwFW+gLXbElQ2a4QU0kkJkSaC2s2On3fZM/GIfBenEmymVSJgMf5ewN+R8wM2Ze7rzU0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=Ul3eNP2H; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id D1F9814C2D3;
	Mon, 20 Oct 2025 23:32:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1760995961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4ZjkqLkuqKJhoX3v2GjdOYI+aXyKqxwW3WOtRg6xSvU=;
	b=Ul3eNP2HUSrgqCNdGr1xlu9nSwOnNir9p8ZdumPy4C0v0LOOlyPtR5i0GmIUqo1zQxaOMD
	FOfWI+0kT8djgZa95A5qUqlA8RQAv+UZgZMwPEikLFp3w5UR64Hl//xLVqC211CCLU7f07
	gT6Nei35etr0hPLVWvuc2me0EzBs3svFUP6nf9wNl55tpytqsR6GbHiwB3XWsbfzgX695G
	l1wYWN67EKn+9F/+jU5lhAQXPOHKlJiYC1wy2KRCKsOr23DlldOipUU1qPsw15OLNpl3CY
	KJik/WzVx4V+xXQmOU2B5ONCjIsJV3eueYqywKP+cuNzqRqdbrle1to48YR/PQ==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id ab0b83ce;
	Mon, 20 Oct 2025 21:32:37 +0000 (UTC)
Date: Tue, 21 Oct 2025 06:32:22 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Song Liu <song@kernel.org>
Cc: Tingmao Wang <m@maowtm.org>, v9fs@lists.linux.dev,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	bpf <bpf@vger.kernel.org>
Subject: Re: 9P change breaks bpftrace running in qemu+9p?
Message-ID: <aPaqZpDtc_Thi6Pz@codewreck.org>
References: <CAHzjS_u_SYdt5=2gYO_dxzMKXzGMt-TfdE_ueowg-Hq5tRCAiw@mail.gmail.com>
 <e0c7cd4e-4183-40a8-b90d-12e9e29e9890@maowtm.org>
 <CAHzjS_sXdnHdFXS8z5XUVU8mCiyVu+WnXVTMxhyegBFRm6Bskg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHzjS_sXdnHdFXS8z5XUVU8mCiyVu+WnXVTMxhyegBFRm6Bskg@mail.gmail.com>

Song Liu wrote on Mon, Oct 20, 2025 at 12:40:23PM -0700:
> I am running qemu 9.2.0 and bpftrace v0.24.0. I don't think anything is
> very special here.

I don't reproduce either (qemu 9.2.4 and bpftrace v0.24.1, I even went
and installed vmtest to make sure), trying both my branch and a pristine
v6.18-rc2 kernel -- what's the exact commit you're testing and could you
attach your .config ?

Thanks,
-- 
Dominique Martinet | Asmadeus

