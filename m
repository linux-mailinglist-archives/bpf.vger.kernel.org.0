Return-Path: <bpf+bounces-45015-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A02D89CFD72
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 10:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B40FB26E9B
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 09:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C493F193425;
	Sat, 16 Nov 2024 09:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O+GYhW7a";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f+WHAsRb"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD1217E010;
	Sat, 16 Nov 2024 09:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731748868; cv=none; b=E2g5y8Y9q79CCGzbe7/ELDCa88q9EM5Pqh1Y7rnzG5CMc9dspKzSQ1A5An2Yq29+8+78/6jRqrFwo3QS84ODX/BPvNMqKlVzKzGBvutUy96Pw5Kr+BkicGb20qBIOCtLja/h3ksfrAwD/ykj+4dbmTi7z9GRfnWWsIIJJ4s/u4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731748868; c=relaxed/simple;
	bh=O3UHc88BGrmZuWFLUNX/RVuv+mk344kjI4vqIwUHweE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=har/dxUUlGTxQIDwd5eCRIPuodRz+sctj9iKg8jkKPEXBXeeU533bLHPMZrcaUCN8BnAL1BMnIGYZB3SDrLEhM6dxwO0DPCK8cXrecFZJGcHw7dAYfvQ/UR3KltFnzuokpxaA/3UBOA/VoaJloOm6nySOusMIab4QRG3+pVjxGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O+GYhW7a; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f+WHAsRb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 16 Nov 2024 10:21:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731748864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vi1SW15jCJWLD4Kn5RiukUXN1MOkzbVBJehxjUb37tY=;
	b=O+GYhW7ajMIM6MvyAF7F6i8Q1oaP6DvsRA62MtIrzVYvmp7u8x1f0u3eYl9+qlExJMyXx1
	Dl6fculZZAHpZ8KgwSybnYMiv7M2zYL930KEwFHza6qNo1xm0S1TMDA9c1U9NQ1di3reMK
	i7uX5gNpOBHKgVDIi8hOLLrMDxCnpHthhcRoKSVg1pWaU7VkRHN06zFMoWsdkLtSwzJDzd
	38tVSNbHSla53qbDDT95FdVzcf0B3fjX21yWhMmI0mj0LkxtSLj4C90XTCO9biGCnuFdf8
	q+YNV13fho1YGiJRtRHy6j5Q1jaYp/h0G94j38MvW4gD6ZA1qBfBV7X20UTHNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731748864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vi1SW15jCJWLD4Kn5RiukUXN1MOkzbVBJehxjUb37tY=;
	b=f+WHAsRbOJKR+C3r1TBYrCwtn2Q605d1MK9RIf3aKwG+IcpkUDq9J5Ww7WfrlSCmv4jmCF
	GPgwRh/gmoIHSbCw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Kunwu Chan <kunwu.chan@linux.dev>, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, clrkwllms@kernel.org, rostedt@goodmis.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	syzbot+b506de56cbbb63148c33@syzkaller.appspotmail.com,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Subject: Re: [PATCH] bpf: Convert lpm_trie::lock to 'raw_spinlock_t'
Message-ID: <20241116092102.O_30pj9W@linutronix.de>
References: <20241108063214.578120-1-kunwu.chan@linux.dev>
 <87v7wsmqv4.ffs@tglx>
 <1e5910b1-ea54-4b7a-a68b-a02634a517dd@linux.dev>
 <87sersyvuc.ffs@tglx>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <87sersyvuc.ffs@tglx>

On 2024-11-15 23:29:31 [+0100], Thomas Gleixner wrote:
> IIRC, BPF has it's own allocator which can be used everywhere.

Thomas Wei=C3=9Fschuh made something. It appears to work. Need to take a
closer look.

> Thanks,
>=20
>         tglx

Sebastian

