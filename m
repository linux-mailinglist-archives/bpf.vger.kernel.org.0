Return-Path: <bpf+bounces-49527-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A17EA1990C
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 20:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30B113A2D3D
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 19:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F42215F56;
	Wed, 22 Jan 2025 19:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="frJLXGQI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F58214204
	for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 19:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737573010; cv=none; b=ODO9kmVQ7hWcJ+M1CK2gSKp1uDkboHOXw/djEq2M7LHUVZF1t40HDkTA0u5kOSKxsiVRd45J7ggebNs+PuKKCpXH3yVNT+XJfxAKXPbFeM12jmGVBRAmBWH0ScM5fHDMRbhGRdUdV/wKo0J02SzO6RZ2hE4T54jtQcLyfUnb4dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737573010; c=relaxed/simple;
	bh=xtCF0OBP+/WsgOxj6z5vYNs/+u2Qw+z3J4OM1v/RYYo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rD7Ub5r/cbMwjjtTV/QZJKtcHGf2G1CZgrJScXIvc+bQhPfGp2T53iPA81luXz6jdVX1UqyClCf3e0Nc7rg9/Mxx0i8EopivbiZXjoQ9NpE7oQYTe2ItARurMoJhT+Ydh7UXyyHYs5/XH2wgUH53j7Yh5oVlRjX0bZtgymirqlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=frJLXGQI; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1737573006; x=1737832206;
	bh=xtCF0OBP+/WsgOxj6z5vYNs/+u2Qw+z3J4OM1v/RYYo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=frJLXGQI+zRFl2HeW4eKBaQFY60n5peknfoIy0n1ce3jYBO2ZxZljYcnV9whEgH1J
	 HK1m8EMSJHsPFiFRp8zG4ykvS2PuzA0v5V63qyQdThcKQKbRzE3KyQBbXRPm8cB3Rh
	 YDmY28/KpV4shNk21RZ7+khq6rvIqsj6eo5McIQtrUU2CFRk85bt+5lz9kXY/Kb3tu
	 XEFTMij/s4MxyocM/RklJg29kgrUpny8lXOx3ygp6dKfLnEa6ZKZA/F0hGz+fXAEcM
	 t17/T2FCMypSwVif8aGwcYoMYQgxsrjZ8tQ4HY3bR4p3Pcy0Zt/cavqo61bI3vllql
	 KgEPbRHIifQuA==
Date: Wed, 22 Jan 2025 19:10:00 +0000
To: Tejun Heo <tj@kernel.org>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: sched-ext@meta.com, kernel-team@meta.com, linux-kernel@vger.kernel.org, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH sched_ext/for-6.13-fixes] sched_ext: Fix dsq_local_on selftest
Message-ID: <m94EAn-xiPWJ1dRFTqcm6urBNNOPza94BmyYvp_5ti06uAZF0Izg2mBC9rpbc3PEfWWvDf7UyDt1x_2gB-7y3esTH3f54s05QBxcTXh4YhQ=@pm.me>
In-Reply-To: <Z5BMkyJ8I7cth1GH@slm.duckdns.org>
References: <20241209152924.4508-1-void@manifault.com> <qC39k3UsonrBYD_SmuxHnZIQLsuuccoCrkiqb_BT7DvH945A1_LZwE4g-5Pu9FcCtqZt4lY1HhIPi0homRuNWxkgo1rgP3bkxa0donw8kV4=@pm.me> <Z1n9v7Z6iNJ-wKmq@slm.duckdns.org> <SJEarr1ol1z7N83mqHJjBmpXcXgHNnnuORHfziWINcHBQCJzY0RczexPKxdq_vE5cDYPeO3bx1RdsNhLqw5UYI40HSX9cPZ9rdmebYwwAP8=@pm.me> <HdoCQccNk3GZdnPx5w1vuAfOMMgtWeUgrUhn_e8B-hyRrWoOPakTGcoI3Q4-QmK_44msuvivoRUykxxeB82uR-S3enkmFaQl2t6Zgu-Nq6Y=@pm.me> <Z2MV001RfiG7DNqj@slm.duckdns.org> <ouIylyHgXTVZ9RiyVeHZ26YXQLKMEKHoOVPWIgpWRDD2FL2RDwwUEocaj4LMpMR3PjbwpPuxEnJAjMeD4e7LnWIAYvIbGC5BPvPGtzyumYk=@pm.me> <Z2tNK2oFDX1OPp8C@slm.duckdns.org> <QHB1r-3fBPQIaDS8iz26J-zoMbn3O6VLlwlZP1NQdkMzlQTsCX_xrfTPBoGt6SQOGgtg6vN7aXles4CndepTvjIVQ7bVXDBrvPaiRH5R8tc=@pm.me> <Z5BMkyJ8I7cth1GH@slm.duckdns.org>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 370d90952211409affdb552cf4d567efc6def8e1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On Tuesday, January 21st, 2025 at 5:40 PM, Tejun Heo <tj@kernel.org> wrote:

>=20
>=20
> Hello, sorry about the delay.
>=20
> On Wed, Jan 15, 2025 at 11:50:37PM +0000, Ihor Solodrai wrote:
> ...
>=20
> > 2025-01-15T23:28:55.8238375Z [ 5.334631] sched_ext: BPF scheduler "dsp_=
local_on" disabled (runtime error)
> > 2025-01-15T23:28:55.8243034Z [ 5.335420] sched_ext: dsp_local_on: SCX_D=
SQ_LOCAL[_ON] verdict target cpu 1 not allowed for kworker/u8:1[33]
>=20
>=20
> That's a head scratcher. It's a single node 2 cpu instance and all unboun=
d
> kworkers should be allowed on all CPUs. I'll update the test to test the
> actual cpumask but can you see whether this failure is consistent or flak=
y?

I re-ran all the jobs, and all sched_ext jobs have failed (3/3).
Previous time only 1 of 3 runs failed.

https://github.com/kernel-patches/vmtest/actions/runs/12798804552/job/36016=
405680

>=20
> Thanks.
>=20
> --
> tejun

