Return-Path: <bpf+bounces-29483-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 995448C28AC
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 18:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E491285AFE
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 16:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBDE172BB5;
	Fri, 10 May 2024 16:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2eShj/Nm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KwVBqgvl"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7261E502;
	Fri, 10 May 2024 16:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715358139; cv=none; b=n+pr9YsXpmCSp1eRbSwjfYRVK/agvMK3LX4Mtg8APOtnG2TrH+YQ/nfmK7IAYD+JVFOat8Fuh9a7hAW0CJBuWeRIpk6yDV58jSNsQf9zLG45GYREq0IggZwKa0ivxqUklp60LRgKYBOyKJ5kekJIjYbZ8SI8Nw2We0JTJTl/l7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715358139; c=relaxed/simple;
	bh=stogIKj8+hYZVSkbsvVvCqugo9i6JwMiNtwTeMU4yKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LT1XnKT5tX/xSEaCN0lMatLT+SXORauT0mn4ObqHJb53npdbHO9fjfIkOiv6QCBkj2wmOnAZ2Vbs/nV3L3xU3O1xmz8/DAtmF5b9akZX7r+J15Vg+pjNgezrcwEjw/tzdlirMJp+buiYqCMDXejs/s1aT+c4uDKYDN7ir71o3kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2eShj/Nm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KwVBqgvl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 10 May 2024 18:22:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715358136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iPtpHGApZXozzh1sZxS1i2Tmk587abOSGlWr8H4ibcg=;
	b=2eShj/NmLmytxxN5WI1wco6aozQn7VY0Hq5nQJEQZS+Cf1yBzGOaDxWKVEi7pePUrfr9dw
	tVjV0yOrPtifsAbZSsS57l952UBPTRowZbp0GYogVxHAwHL2aYqRzO9BDWW7mCttuZt7bR
	sWiweOdtZT01+I20KOeK+XBax6e0nDhTGP68rcM9HGsbcYUseQaOprN8uqB7plAI4Fw9aR
	hA96AmPQsns+Uxn1gT7A4am/O8KeQaaqziq1+8spUrhjoHIXEakWLZDfOkSv2HSpCnKYCj
	OpHZjtQDlV+aIfVgl+Yfyp1oJbNI6oriQCZru3+Bo1qvW9RBaKeeG56M6cTyNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715358136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iPtpHGApZXozzh1sZxS1i2Tmk587abOSGlWr8H4ibcg=;
	b=KwVBqgvlOC0PIW0klVHR8tZ7CORFnwP6nFMqdQ9H1Nyim76TtK+iTU/ZBDsvYFtgpOXcIu
	mmzI0kOmkAOeAoDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Boqun Feng <boqun.feng@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next 14/15 v2] net: Reference bpf_redirect_info via
 task_struct on PREEMPT_RT.
Message-ID: <20240510162214.zNWRKgFU@linutronix.de>
References: <20240503182957.1042122-1-bigeasy@linutronix.de>
 <20240503182957.1042122-15-bigeasy@linutronix.de>
 <87y18mohhp.fsf@toke.dk>
 <CAADnVQJkiwaYXUo+LyKoV96VFFCFL0VY5Jgpuv_0oypksrnciA@mail.gmail.com>
 <20240507123636.cTnT7TvU@linutronix.de>
 <93062ce7-8dfa-48a9-a4ad-24c5a3993b41@kernel.org>
 <20240510162121.f-tvqcyf@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240510162121.f-tvqcyf@linutronix.de>

On 2024-05-10 18:21:24 [+0200], To Jesper Dangaard Brouer wrote:
> The XDP redirect process is two staged:
=E2=80=A6
On 2024-05-07 15:27:44 [+0200], Jesper Dangaard Brouer wrote:
>=20
> I need/want to echo Toke's request to benchmark these changes.

I have:
boxA: ixgbe
boxB: i40e

Both are bigger NUMA boxes. I have to patch ixgbe to ignore the 64CPU
limit and I boot box with only 64CPUs. The IOMMU has been disabled on
both box as well as CPU mitigations. The link is 10G.

The base for testing I have is commit a17ef9e6c2c1c ("net_sched:
sch_sfq: annotate data-races around q->perturb_period") which I used to
rebase my series on top of.

pktgen_sample03_burst_single_flow.sh has been used to send packets and
"xdp-bench drop $nic -e" to receive them.

baseline
~~~~~~~~
boxB -> boxA | gov performance
-t2 (to pktgen)
| receive total 14,854,233 pkt/s        14,854,233 drop/s                0 =
error/s     =20

-t1 (to pktgen)
| receive total 10,642,895 pkt/s        10,642,895 drop/s                0 =
error/s     =20


boxB -> boxA | gov powersave
-t2 (to pktgen)
  receive total 10,196,085 pkt/s        10,196,085 drop/s                0 =
error/s     =20
  receive total 10,187,254 pkt/s        10,187,254 drop/s                0 =
error/s     =20
  receive total 10,553,298 pkt/s        10,553,298 drop/s                0 =
error/s

-t1
  receive total 10,427,732 pkt/s        10,427,732 drop/s                0 =
error/s     =20

=3D=3D=3D=3D=3D=3D
boxA -> boxB (-t1) gov performance
performace:
  receive total 13,171,962 pkt/s        13,171,962 drop/s                0 =
error/s     =20
  receive total 13,368,344 pkt/s        13,368,344 drop/s                0 =
error/s

powersave:
  receive total 13,343,136 pkt/s        13,343,136 drop/s                0 =
error/s     =20
  receive total 13,220,326 pkt/s        13,220,326 drop/s                0 =
error/s     =20

(I the CPU governor had no impact, just noise)

The series applied (with updated 14/15)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
boxB -> boxA | gov performance
-t2:
  receive total  14,880,199 pkt/s        14,880,199 drop/s                0=
 error/s

-t1:
  receive total  10,769,082 pkt/s        10,769,082 drop/s                0=
 error/s     =20

boxB -> boxA | gov powersave
-t2:
 receive total   11,163,323 pkt/s        11,163,323 drop/s                0=
 error/s     =20

-t1:
 receive total   10,756,515 pkt/s        10,756,515 drop/s                0=
 error/s     =20

boxA -> boxB | gov perfomance

 receive total  13,395,919 pkt/s        13,395,919 drop/s                0 =
error/s     =20

boxA -> boxB | gov perfomance
 receive total  13,290,527 pkt/s        13,290,527 drop/s                0 =
error/s


Based on my numbers, there is just noise.  BoxA hit the CPU limit during
receive while lowering the CPU-freq. BoxB seems to be unaffected by
lowing CPU frequency during receive.

I can't comment on anything >10G due to HW limits.

Sebastian

