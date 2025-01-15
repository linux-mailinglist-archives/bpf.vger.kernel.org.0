Return-Path: <bpf+bounces-49002-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A90EAA12F60
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 00:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B6C53A614C
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 23:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA641DDA34;
	Wed, 15 Jan 2025 23:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="BU+YZ6QN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1641DAC95
	for <bpf@vger.kernel.org>; Wed, 15 Jan 2025 23:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736985045; cv=none; b=B0x98FoS8ZNKNO0KUUHALG42mPfP7w24+g3dvUpiCqCIQeN98jT/p1LOWLMxwcsv5uwohOW36oXSXsy0yk/Dw/uOkHhVWQBB5T2E7bEnqSVDC3G4Z34jYLpbm8uOzCNtdQkmZqPclNeEt3rYdTFCrn2AFNdSYyQFNk4UHHi9Fhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736985045; c=relaxed/simple;
	bh=RFhQzB17vU1z4p+uCJUMa54b9nXdNVWPS5TAMJ/GBMk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uh/yJYOzYeMY2D7Ys10/DsWvaGI18uTEBmoU1sqm0w2AExU7Y7zmMvBUw+5gDHx2m2ILWL/xbLXzICS+rXUDWdlZCRw82E+91x27hB9OmwYJPE57coHwVmW7ORLm9WQWs96ZldpV3BAcLQKRRwlpEqTBHb803pOh7fiJ9HnSUtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=BU+YZ6QN; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1736985041; x=1737244241;
	bh=0ZDb49xn5cVCYSIRaKQtj9utIrHS7fpmDyJRZy1IIm4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=BU+YZ6QNQywaqI6OhoYUN+tJ/vtJkh+8HMKOt016r/1KShCJvwNJdMWJ9VWucxnlE
	 JdFIekWBoXd80P+DBbHIVHg/bUjtMK27Ia1YYmnhSjhgXFgTuivfSCOwGZCKUUdCqF
	 aAEKu25HguCULofcqr6U+9l8l/pvvc7I260cqcsJJHypL4dL84wnBDoyq+UjXBYy4L
	 Apda9uW2Q89Bu/JMfwWbmcCQ04laPASYwckIK2i0iVGHZlq3E2S+4ayy0itN96bRJh
	 h/sLVTrD/VguZtifzbPQhgTD8W9tol55Jj6mXODuJknnoQZQwxs57/qXY77AO0VLn1
	 gNduxebV6iaag==
Date: Wed, 15 Jan 2025 23:50:37 +0000
To: Tejun Heo <tj@kernel.org>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: sched-ext@meta.com, kernel-team@meta.com, linux-kernel@vger.kernel.org, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH sched_ext/for-6.13-fixes] sched_ext: Fix dsq_local_on selftest
Message-ID: <QHB1r-3fBPQIaDS8iz26J-zoMbn3O6VLlwlZP1NQdkMzlQTsCX_xrfTPBoGt6SQOGgtg6vN7aXles4CndepTvjIVQ7bVXDBrvPaiRH5R8tc=@pm.me>
In-Reply-To: <Z2tNK2oFDX1OPp8C@slm.duckdns.org>
References: <20241209152924.4508-1-void@manifault.com> <qC39k3UsonrBYD_SmuxHnZIQLsuuccoCrkiqb_BT7DvH945A1_LZwE4g-5Pu9FcCtqZt4lY1HhIPi0homRuNWxkgo1rgP3bkxa0donw8kV4=@pm.me> <Z1n9v7Z6iNJ-wKmq@slm.duckdns.org> <SJEarr1ol1z7N83mqHJjBmpXcXgHNnnuORHfziWINcHBQCJzY0RczexPKxdq_vE5cDYPeO3bx1RdsNhLqw5UYI40HSX9cPZ9rdmebYwwAP8=@pm.me> <HdoCQccNk3GZdnPx5w1vuAfOMMgtWeUgrUhn_e8B-hyRrWoOPakTGcoI3Q4-QmK_44msuvivoRUykxxeB82uR-S3enkmFaQl2t6Zgu-Nq6Y=@pm.me> <Z2MV001RfiG7DNqj@slm.duckdns.org> <ouIylyHgXTVZ9RiyVeHZ26YXQLKMEKHoOVPWIgpWRDD2FL2RDwwUEocaj4LMpMR3PjbwpPuxEnJAjMeD4e7LnWIAYvIbGC5BPvPGtzyumYk=@pm.me> <Z2tNK2oFDX1OPp8C@slm.duckdns.org>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 56d7488ee23df20ae1cf6a9d017504458b29b331
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tuesday, December 24th, 2024 at 4:09 PM, Tejun Heo <tj@kernel.org> wrote=
:

>=20
>=20
> The dsp_local_on selftest expects the scheduler to fail by trying to
> schedule an e.g. CPU-affine task to the wrong CPU. However, this isn't
> guaranteed to happen in the 1 second window that the test is running.
> Besides, it's odd to have this particular exception path tested when ther=
e
> are no other tests that verify that the interface is working at all - e.g=
.
> the test would pass if dsp_local_on interface is completely broken and fa=
ils
> on any attempt.
>=20
> Flip the test so that it verifies that the feature works. While at it, fi=
x a
> typo in the info message.
>=20
> Signed-off-by: Tejun Heo tj@kernel.org
>=20
> Reported-by: Ihor Solodrai ihor.solodrai@pm.me
>=20
> Link: http://lkml.kernel.org/r/Z1n9v7Z6iNJ-wKmq@slm.duckdns.org
> ---
> tools/testing/selftests/sched_ext/dsp_local_on.bpf.c | 5 ++++-
> tools/testing/selftests/sched_ext/dsp_local_on.c | 5 +++--
> 2 files changed, 7 insertions(+), 3 deletions(-)

Hi Tejun.

I've tried running sched_ext selftests on BPF CI today, applying a set
of patches from sched_ext/for-6.13-fixes, including this one.

You can see the list of patches I added here:
https://github.com/kernel-patches/vmtest/pull/332/files

With that, dsq_local_on has failed on x86_64 (llvm-18), although it
passed with other configurations:
https://github.com/kernel-patches/vmtest/actions/runs/12798804552/job/35683=
769806

Here is a piece of log that appears to be relevant:

    2025-01-15T23:28:55.8238375Z [    5.334631] sched_ext: BPF scheduler "d=
sp_local_on" disabled (runtime error)
    2025-01-15T23:28:55.8243034Z [    5.335420] sched_ext: dsp_local_on: SC=
X_DSQ_LOCAL[_ON] verdict target cpu 1 not allowed for kworker/u8:1[33]
    2025-01-15T23:28:55.8246187Z [    5.336139]    dispatch_to_local_dsq+0x=
13e/0x1f0
    2025-01-15T23:28:55.8249296Z [    5.336474]    flush_dispatch_buf+0x13d=
/0x170
    2025-01-15T23:28:55.8252083Z [    5.336793]    balance_scx+0x225/0x3e0
    2025-01-15T23:28:55.8254695Z [    5.337065]    __schedule+0x406/0xe80
    2025-01-15T23:28:55.8257121Z [    5.337330]    schedule+0x41/0xb0
    2025-01-15T23:28:55.8260146Z [    5.337574]    schedule_timeout+0xe5/0x=
160
    2025-01-15T23:28:55.8263080Z [    5.337875]    rcu_tasks_kthread+0xb1/0=
xc0
    2025-01-15T23:28:55.8265477Z [    5.338169]    kthread+0xfa/0x120
    2025-01-15T23:28:55.8268202Z [    5.338410]    ret_from_fork+0x37/0x50
    2025-01-15T23:28:55.8271272Z [    5.338690]    ret_from_fork_asm+0x1a/0=
x30
    2025-01-15T23:28:56.7349562Z ERR: dsp_local_on.c:39
    2025-01-15T23:28:56.7350182Z Expected skel->data->uei.kind =3D=3D EXIT_=
KIND(SCX_EXIT_UNREG) (1024 =3D=3D 64)

Could you please take a look?

Thank you.

>=20
> [...]

