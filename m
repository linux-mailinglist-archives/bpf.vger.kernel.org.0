Return-Path: <bpf+bounces-45183-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1359D27F5
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 15:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03DF7B2881E
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 14:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DE51CCB23;
	Tue, 19 Nov 2024 14:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2Z7QYPEo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j96Bsgkb"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D331CC14A
	for <bpf@vger.kernel.org>; Tue, 19 Nov 2024 14:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732025731; cv=none; b=HA6R9CJV5IdB3084sPEpkVDjmQrLW2P9oZ0Otzg7J48Ozxl7vHJd+QofKedg9Cb6MZmTJ6GAHwkQLwjWRtIJ0wzld/A4a8FVnDMfXgvFZawYaO13y026Rp8lZyVheeBFoChfsa7P6Bo3Dzvc/PbEEKo1Sird3vLEMahZq+Uvqu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732025731; c=relaxed/simple;
	bh=fgeng2/hLioU9Dll8rVvWGyGfeeZ9EL/GBoYglDhaB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k8as5yjYi2pMI6yMpy+yG24Xo+yoSdJmoLGmJBjf6KciKS4aqaIVTZ0GVGSonnHGSEYtJG1j0/iGa8tLwFi2tclKtJVamgC7YqpkfVfl63fQo1PNeKAqLLwntZccYfKLUpZNvjc/KIULIWkUzh7RE5FR1Lw/wsfse2js0LDKy/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2Z7QYPEo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j96Bsgkb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 19 Nov 2024 15:15:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732025727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fgeng2/hLioU9Dll8rVvWGyGfeeZ9EL/GBoYglDhaB4=;
	b=2Z7QYPEoUS6V+3vAsIrGFwWH5suiR0WOaYvpIBVtlEuaJmO74VAmITyLmcSCr7ukc/JeH5
	hx64Q/eGqOUp6FLiBh5TUElF+7j8R5JOGF5kwG8ccPqKLmlD2TGI+CyFxTKd8NTH0Kh9qC
	4ni4Ezzk/NWRRSexForEc3DEuwuPzySM+JicglHDDDQFTRPZ52zoF+ajNzx8bN8IktYUbL
	T8S6jG8Y/A96dkYM7HCT3KWv9/Ket8WKJ+VLWryS2mcqknTw8WQLk+X6YZWcE7NVOY05J3
	wCw2ekQJl7GbOE8K8fLDzhosw9CYRqxfjfyujVOpoWnL8GlbpVt0TMUGChtMrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732025727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fgeng2/hLioU9Dll8rVvWGyGfeeZ9EL/GBoYglDhaB4=;
	b=j96Bsgkbwvtua4QpnxdQu3Wst+9FQuDGel7CpuQZvHtjc60P6pBFf2OHWmA/xiGl1Oh7oM
	2WTxpkOWyDhleKCg==
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
Message-ID: <20241119141525.M8SVAUF-@linutronix.de>
References: <20241118010808.2243555-1-houtao@huaweicloud.com>
 <20241118153901.izwoXYhc@linutronix.de>
 <6919992c-179e-300e-9f5f-dc3a8a7bdaf3@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <6919992c-179e-300e-9f5f-dc3a8a7bdaf3@huaweicloud.com>

On 2024-11-19 09:35:51 [+0800], Hou Tao wrote:
> Hi Sebastian,
Hi Hou,

> On 11/18/2024 11:39 PM, Sebastian Andrzej Siewior wrote:
> > On 2024-11-18 09:07:58 [+0800], Hou Tao wrote:
> >> From: Hou Tao <houtao1@huawei.com>
> >>
> >> Hi,
> > Hi,
> >
> >> Please see individual patches for more details. Comments are always
> >> welcome.
> > This might be a coincidence but it seems I get
> >
> > | helper_fill_hashmap(282):FAIL:can't update hashmap err: Unknown error=
 -12
> > | test_maps: test_maps.c:1379: __run_parallel: Assertion `status =3D=3D=
 0' failed.
> >
> > more often with the series when I do ./test_maps. I never managed to
> > pass the test with series while it passed on v6.12. I'm not blaming the
> > series, just pointing this out it might be known=E2=80=A6
>=20
> Thanks for the information. 12 is ENOMEM, so the hash map failed to
> allocate an element for it. There are multiple possible reasons for ENOME=
M:
>=20
> 1) something is wrong for bpf mem allocator. E.g., it could not refill
> the free list timely. It may be possible when running under RT, because
> the irq work is threaded under RT.

right. forgot to switch that one off. I had it for the initial test=E2=80=A6

> 2) the series causes the shortage of memory (e.g., It uses a lot memory
> then free these memory, but the reclaim of the memory is slow)

> Could you please share the kernel config file and the VM setup, so I
> could try to reproduce the problem ?

I very much thing this is due to the RT switch. The irq-work and
testcase run on different CPUs so=E2=80=A6

> > In 08/10 you switch the locks to raw_spinlock_t. I was a little worried
> > that a lot of elements will make the while() loop go for a long time. Is
> > there a test for this? I run into "test_progs -a map_kptr" and noticed
> > something else=E2=80=A6
>=20
> The concern is the possibility of hard-lockup, right ? The total time
Not lockup but spending a "visible amount of time" for the lookup.

> used for update or deletion is decided by the max_prefixlen. The typical
> use case will use 32 or 128 as the max_prefixlen. The max value of
> max_prefixlen is LPM_DATA_SIZE_MAX * 8 =3D 2048, I think the loop time
> will be fine. Will try to construct some test cases for it.

Okay, thank you.

Sebastian

