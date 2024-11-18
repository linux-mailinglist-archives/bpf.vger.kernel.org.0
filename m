Return-Path: <bpf+bounces-45100-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C059D1498
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2024 16:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 078B328321C
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2024 15:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D7D1B6D08;
	Mon, 18 Nov 2024 15:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SqtfVqUq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F+FobWr1"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8031991C8
	for <bpf@vger.kernel.org>; Mon, 18 Nov 2024 15:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731944347; cv=none; b=GyG+e1SVHiLp3Ejw7kY72J0KREqU5eo+3n5zbr0G8Uv7Rhgm4gcS2FzqggDa+Sit3brK9rfWTS0oZeTcv5hazl9TNqsSSEhUIsWzyU3Zghn8YcnU5hbvNjmIg6bJTkuWY+1BcD+9foWNksBC51DUMPfxkybqdInHyirWw4x/UcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731944347; c=relaxed/simple;
	bh=7D2QAZYnZAuxgpCeEhIi/xRhIOlJchj6qRK4hg9mWd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d4Hjf3qdbNIB52yo0M4XGh8sVSZC4DGq/G1XVrjFJFLSrFOVIZiXu9NDAih5O5YWbCTK2xYC5ItZoj9TWeVLTxozpL7qWudFJVq6fgGb/1eGx5jiqyUpsBE20rx97uGIoPmF+g/HD3gbgm4D4m2TTexlek+5EYqu2yKCtSvKlMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SqtfVqUq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F+FobWr1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 18 Nov 2024 16:39:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731944342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7D2QAZYnZAuxgpCeEhIi/xRhIOlJchj6qRK4hg9mWd0=;
	b=SqtfVqUqiNYu1tRyKi+7pjxkBGgcDkQpBcyvkoy6cYb4J4lHusk2U7XSiCEJEfG8K9xrn2
	2xU5EugCtY1WeXeL7Qs9SklQ+WZUCRrFzsvzs8cfWWoNbK1XfI15gz/Bdr62GRCjsYmoXA
	AZ7gL4rHWdizA0KPb/Ft3j3doYi+yHAps2+VGoddLrjDhLnOG7VI2pQThvN9T5FmSAKaKu
	lTGHLgibPuvFA5ZfzR7lcEbNaAgdIHQeHLOtyJviTpkbjxQ+w2o+oStRAPQ3Sm3nF8tKkd
	IjPZrTObATya869+KvaTntTXb83jUVBQBxzTwCRQsWE2iFPeF37yr7W+I79eMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731944342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7D2QAZYnZAuxgpCeEhIi/xRhIOlJchj6qRK4hg9mWd0=;
	b=F+FobWr164vsnY6Kl/F4t6bz+UMVupw3D14R1tdlS0eklA/XnWRddmYXAnuT21F0MjgWAa
	D4cYdBRwH70hc7AQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	houtao1@huawei.com, xukuohai@huawei.com
Subject: Re: [PATCH bpf-next 00/10] Fixes for LPM trie
Message-ID: <20241118153901.izwoXYhc@linutronix.de>
References: <20241118010808.2243555-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241118010808.2243555-1-houtao@huaweicloud.com>

On 2024-11-18 09:07:58 [+0800], Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
>=20
> Hi,
Hi,

> Please see individual patches for more details. Comments are always
> welcome.

This might be a coincidence but it seems I get

| helper_fill_hashmap(282):FAIL:can't update hashmap err: Unknown error -12
| test_maps: test_maps.c:1379: __run_parallel: Assertion `status =3D=3D 0' =
failed.

more often with the series when I do ./test_maps. I never managed to
pass the test with series while it passed on v6.12. I'm not blaming the
series, just pointing this out it might be known=E2=80=A6

In 08/10 you switch the locks to raw_spinlock_t. I was a little worried
that a lot of elements will make the while() loop go for a long time. Is
there a test for this? I run into "test_progs -a map_kptr" and noticed
something else=E2=80=A6

Sebastian

