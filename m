Return-Path: <bpf+bounces-54055-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 293DEA61504
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 16:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83B4F189CE5D
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 15:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAAE2040A1;
	Fri, 14 Mar 2025 15:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4QpV4H3S";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qo1e9FY+"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D62203719;
	Fri, 14 Mar 2025 15:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741966246; cv=none; b=gZL2P32JEbkJBalPeEVGOWVTZC/PCGW7I6E0esPDJmMy1O+LMk2DlomLY5zPW3Td+JtcG+z5UsyhaCxVEkOWyGjSbv/sLOL0Gx6Y+8ww/pXnQ73w0MzdfBqOmBPvR1w0q7MvTf3FoLL4lZYzca98g6bbT3FkDPYyKPsb44da+Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741966246; c=relaxed/simple;
	bh=hp6urxE+epAIAhklce6pjhBvd4K6E7IDYDCT235fp4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZZpGwTQGh5j7q+Y57rxp5u+4D3xre4EmCjvOK8CfJkn2q0LwnXOUDh3uxhP3ghVbu6Q3WwfwSdkILl4YKn8kewPil+Pmp1hI8nSNVhF898Fjm9Qd6O72f4mu32yEF0LS0hbmn5OTT7o9mwMiJsS1OFrF3NDEHrCXygytzEOiEL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4QpV4H3S; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qo1e9FY+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 14 Mar 2025 16:30:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741966242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rjQlPpuqcqB1XknW/TWsFmZ681LMMWh/c4bbli5+0K8=;
	b=4QpV4H3S6fLnf287x7HnWMpG7Uc9Mci9Cni+zDAfQ+QenBTuzv0mO8AFiaLTrSi8TZ1jgZ
	tcqZSXocYIOaSe5tYxxHJUk1j04c5+hc81xdztd76wVs2oV2rW59AzWAVyqJdO1dYPiRCb
	jfSfLUsFvIxywuK91NurUdVAxkJzPdtSgS3lNSorbn5FL4txaGkHRyzSc9TViI3l7q1ug6
	cPOMbdoYCZLJz8SGAmQHLlUWSHcL2zscWqDt+aQSeppvdTdR3/Ayn0f+UxqiB2EsDU1RIA
	kAW9vvarYPpV/tjYdQYBbW2g3qRSIT6vG4ROwppw66XAXREliWd+QoR7XDI1tQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741966242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rjQlPpuqcqB1XknW/TWsFmZ681LMMWh/c4bbli5+0K8=;
	b=qo1e9FY+MYHE7e5vWUb/krF1KKFjJ1Yak6AGLMEnLHVdY3i2rz70nbB7fL6OegSNA0+I4J
	NiCGGvTPWih/T6Bw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
	Ricardo =?utf-8?Q?Ca=C3=B1uelo?= Navarro <rcn@igalia.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC] Use after free in BPF/ XDP during XDP_REDIRECT
Message-ID: <20250314153041.9BKexZXH@linutronix.de>
References: <20250313183911.SPAmGLyw@linutronix.de>
 <87ecz0u3w9.fsf@toke.dk>
 <20250313203226.47_0q7b6@linutronix.de>
 <871pv0rmr8.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <871pv0rmr8.fsf@toke.dk>

On 2025-03-14 10:21:15 [+0100], Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> Hmm, how about putting the reset (essentially the changes you have
> above) into bpf_prog_run_xdp() itself, before executing the BPF program?

That would be the snippet below. It does work as far as the testcase
goes. It is just and unconditional write which might look like a waste
but given the circumstances=E2=80=A6

While at it, is there anything that ensures that only bpf_prog_run_xdp()
can invoke the map_redirect callback? Mainline only assigns the task
pointer in NAPI callback so any usage outside of bpf_prog_run_xdp() will
lead to a segfault and I haven't seen a report yet so=E2=80=A6

--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -486,7 +486,12 @@ static __always_inline u32 bpf_prog_run_xdp(const stru=
ct bpf_prog *prog,
 	 * under local_bh_disable(), which provides the needed RCU protection
 	 * for accessing map entries.
 	 */
-	u32 act =3D __bpf_prog_run(prog, xdp, BPF_DISPATCHER_FUNC(xdp));
+	struct bpf_redirect_info *ri =3D this_cpu_ptr(&bpf_redirect_info);
+	u32 act;
+
+	ri->map_id =3D INT_MAX;
+	ri->map_type =3D BPF_MAP_TYPE_UNSPEC;
+	act =3D __bpf_prog_run(prog, xdp, BPF_DISPATCHER_FUNC(xdp));
=20
 	if (static_branch_unlikely(&bpf_master_redirect_enabled_key)) {
 		if (act =3D=3D XDP_TX && netif_is_bond_slave(xdp->rxq->dev))
--=20
2.47.2


> -Toke

Sebastian

