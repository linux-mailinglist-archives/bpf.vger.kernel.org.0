Return-Path: <bpf+bounces-33769-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D22926091
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 14:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55AB61C22D5C
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 12:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055B516DEAC;
	Wed,  3 Jul 2024 12:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZAXLm+3B";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zXbCiQBW"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDF2177981
	for <bpf@vger.kernel.org>; Wed,  3 Jul 2024 12:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720010372; cv=none; b=Ek21RxzPV0wjJea1rMqQzEKwN34kxZZQsNkQ7VRQn6b0GCLssfARxiiCFfKpVopQ7JuVoDjAw5QQ5rKjNnf9FmVvwCUzqBzgwrlhV54Ub6LL040aHS8Oy4QhfJ1NIlG8WIOI6KvMy/QbODluoDDrD4RnQEHCOiz0lQL2OvyD2nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720010372; c=relaxed/simple;
	bh=NN69YaBeDA1p0oLbLbDb24xTO3JvaD+KEeu+kXmwJGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XR2VGyPkuyS/K5mrPaxQl11F4RjI79ZMr+VEvzzycw8oUf9EMnham1CQSwzF6ssNs7iPWlmOVLjR6QFVfbBMbUBh4kbuBpfZyHA3RGaEvbHkJFEMxAFThIJ6Q2++4pcSjCFvK0mYyoiK7WuGmHb/KS3y78bSIQN4fqjogdDN0eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZAXLm+3B; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zXbCiQBW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 3 Jul 2024 14:39:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720010369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XvVHLGLvmzpDsbtXc7H60xY8m6Vbb/J6ebeEGyuSHJU=;
	b=ZAXLm+3B7peuwqDCMaVOB9fC6IX8jTYYfu0MvUQu+c1xwI0fa2PIlByx6QauCTM7hr9Scd
	/HQruxjwDGgMSJvOoVpLKqy3K0OHM6vnQ/rk3OaGs9nTF4Ediw/stGaeGbL3nEAcnVDfME
	Qiz/i/zqdKYWH67V6b7RZGUEX1eAuVq8ZfSS0LmLZ/eI8wTh8YQtYu47py5L3ZmMSQGgt8
	0/Cpr6MpkPBgkb8upojlEEC/FCvdQFMmEmGcWzLq+G11HvFiMnM/hoYaHsG/n5UeQbK41b
	1u9VvVBHY8p5ZY01dmweCHHqik8zeOwW8NHlWeS5PUucKq0b7EtzSIs++oQR0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720010369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XvVHLGLvmzpDsbtXc7H60xY8m6Vbb/J6ebeEGyuSHJU=;
	b=zXbCiQBWIptyot09Exvb7tDgZSBTS0b/MkMBb3ydDAt/FBdWMZxppGlrL8U5yMFDw3WpGp
	321ECPvxb9r0ndBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v2 bpf-next 3/3] bpf: Implement bpf_check_basics_ok() as
 a macro.
Message-ID: <20240703123927.Xm5AYkQd@linutronix.de>
References: <20240702142542.179753-1-bigeasy@linutronix.de>
 <20240702142542.179753-4-bigeasy@linutronix.de>
 <CAEf4BzYs1bXC1S+nnFLngb03=rcpiCz4-k_Ge=+OvJt9rR5OaA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEf4BzYs1bXC1S+nnFLngb03=rcpiCz4-k_Ge=+OvJt9rR5OaA@mail.gmail.com>

On 2024-07-02 15:26:38 [-0700], Andrii Nakryiko wrote:
> 
> Why not open-code part of it and then have a function for checking length limit:
> 
> if (!filter)
>     return <error>;
> if (!bpf_check_prog_len(flen))
>     return <another-error>;
> 
> It's all local to a single file, no big deal adding a few if
> (!pointer) checks explicitly, IMO. "basics" is super generic and not a
> great name either way.

Okay.

Sebastian

