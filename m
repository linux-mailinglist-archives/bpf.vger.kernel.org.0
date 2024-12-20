Return-Path: <bpf+bounces-47466-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A55829F9A6B
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 20:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBB9F168963
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 19:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CD92206B9;
	Fri, 20 Dec 2024 19:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="PsMXLZWq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669AF2210FD
	for <bpf@vger.kernel.org>; Fri, 20 Dec 2024 19:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734722813; cv=none; b=QxjujWaZ1pLCg9WX2X1Zj4eo7ARaL/jNZc1hNNQlVMLFN9v5VYQLezOxRVQLmVYoTCelrddYCGrpAkq5CjWlnLDesf18mmTUOQAFQ+TFeHjJBTxMKeIsQrmzo5acBAXrhf4GCU+9bqyis/8hr5i/x1IFHc9AFXTSrebpDMVbDl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734722813; c=relaxed/simple;
	bh=c8/zr+fvkJF+E98GVJuv8TRQsQI9s4l99RhBuh+tMIk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UDgRNAC1eia/rTVSQthlNm+/ZUXyruL3qyX6FYd2jlB6rVST53s0VO2m+hv1hcqRCDl5rYTncF0P5tKaBiC4rRQZSTXco/fVtJvclyPtRpn8xe+dsDFUc+VBWYdAEdmqBSxGxtNI421XcJZCXUhnw27Q8jAC0mb7pSrw3NVFfn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=PsMXLZWq; arc=none smtp.client-ip=79.135.106.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1734722804; x=1734982004;
	bh=c8/zr+fvkJF+E98GVJuv8TRQsQI9s4l99RhBuh+tMIk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=PsMXLZWqujGpAZyp8eJgJ/hYzDk82eDTfZF79HpaS/pkT+/rsKChdThJsK07tiAd4
	 9+R7kETkI/rraiSs805rKDHgEmFsnNqQPsmjv9ZQuagd+kphA0AWRrZGbXiq493uJt
	 +2UrdD9eP7pK+d1UAXpv/109upA7hblzV5DDlanx1yeb51CD1UNwRYBWElI1pBqVDn
	 deQyAZNe0U3htRjh3LNGNtBGEoVXk1GzXJrZ5Vt17R2ib1I/ckbmwhwaR+7YeYywuQ
	 bVWeB0uW56VIXGLH2pwpAPWXaQ18ouaDb75wFQytJKlCQFQ0G1rChsZSKeQEzu4mRl
	 bVFtP1Uk7uUCA==
Date: Fri, 20 Dec 2024 19:26:37 +0000
To: Tejun Heo <tj@kernel.org>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: David Vernet <void@manifault.com>, sched-ext@meta.com, kernel-team@meta.com, linux-kernel@vger.kernel.org, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH sched_ext/for-6.13-fixes] sched_ext: Fix invalid irq restore in scx_ops_bypass()
Message-ID: <hzCmjmGwkKFxQBCFWB4lo3HRGK-vWCBZq1DQNcNEuYkTOT8r5cw_K4ir7gDnGl0REqjD_hnExw9Mkbra0_uObLzMXdRwOb7l8dNuAx_ddvA=@pm.me>
In-Reply-To: <ouIylyHgXTVZ9RiyVeHZ26YXQLKMEKHoOVPWIgpWRDD2FL2RDwwUEocaj4LMpMR3PjbwpPuxEnJAjMeD4e7LnWIAYvIbGC5BPvPGtzyumYk=@pm.me>
References: <20241209152924.4508-1-void@manifault.com> <qC39k3UsonrBYD_SmuxHnZIQLsuuccoCrkiqb_BT7DvH945A1_LZwE4g-5Pu9FcCtqZt4lY1HhIPi0homRuNWxkgo1rgP3bkxa0donw8kV4=@pm.me> <Z1n9v7Z6iNJ-wKmq@slm.duckdns.org> <SJEarr1ol1z7N83mqHJjBmpXcXgHNnnuORHfziWINcHBQCJzY0RczexPKxdq_vE5cDYPeO3bx1RdsNhLqw5UYI40HSX9cPZ9rdmebYwwAP8=@pm.me> <HdoCQccNk3GZdnPx5w1vuAfOMMgtWeUgrUhn_e8B-hyRrWoOPakTGcoI3Q4-QmK_44msuvivoRUykxxeB82uR-S3enkmFaQl2t6Zgu-Nq6Y=@pm.me> <Z2MV001RfiG7DNqj@slm.duckdns.org> <ouIylyHgXTVZ9RiyVeHZ26YXQLKMEKHoOVPWIgpWRDD2FL2RDwwUEocaj4LMpMR3PjbwpPuxEnJAjMeD4e7LnWIAYvIbGC5BPvPGtzyumYk=@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: eeb4f3691654f088b6fdd5c2874dda915043581e
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thursday, December 19th, 2024 at 2:51 PM, Ihor Solodrai <ihor.solodrai@p=
m.me> wrote:

> [...]
>=20
> Tejun, can you elaborate on what you're looking for in the logs?
> My understanding is that QEMU prints some of the dmesg messages.
> QEMU output is available in raw logs.

I made changes to the CI scripts to explicitly dump dmesg in case of a fail=
ure.
It looks like most of that log was already printed.

Job: https://github.com/kernel-patches/bpf/actions/runs/12436924307/job/347=
26070343

Raw log: https://productionresultssa11.blob.core.windows.net/actions-result=
s/a10f57cb-19e3-487a-9fb0-69742cfbef1b/workflow-job-run-4c580b44-6466-54d8-=
b922-6f707064e5ca/logs/job/job-logs.txt?rsct=3Dtext%2Fplain&se=3D2024-12-20=
T19%3A34%3A55Z&sig=3DkQ09k9r01VtP4p%2FgYvvCmm2FUuOHfsLjU3ARzks4xmE%3D&ske=
=3D2024-12-21T07%3A00%3A50Z&skoid=3Dca7593d4-ee42-46cd-af88-8b886a2f84eb&sk=
s=3Db&skt=3D2024-12-20T19%3A00%3A50Z&sktid=3D398a6654-997b-47e9-b12b-9515b8=
96b4de&skv=3D2024-11-04&sp=3Dr&spr=3Dhttps&sr=3Db&st=3D2024-12-20T19%3A24%3=
A50Z&sv=3D2024-11-04=20

Search for "dmesg start".

> [...]

