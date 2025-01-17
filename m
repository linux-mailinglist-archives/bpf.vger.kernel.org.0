Return-Path: <bpf+bounces-49221-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9FCA15652
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 19:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A0E816340B
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 18:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B011A1A23B7;
	Fri, 17 Jan 2025 18:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="cZOZOLfC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F59119B5B1
	for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 18:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737137357; cv=none; b=Zj9kUS9MIOfcpBAg2o24WC7JCJGCgSIfAHanSLnnweiAdaXl7MSfWxv44QmvjeHbd5LLrKpP3BPHRyDda9P4NzWKsa2IX4hj3x3Lgs3Zye/TtiHe6D6Vy7P6KszlnqHcaaY/1E4N1IS9MLkRjZGuJrXqM41EHw+tuPL2faIDhhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737137357; c=relaxed/simple;
	bh=gkIHo4RjAWudat2q0E8IZ+TR2bYPlk/bm0n3lU7iiVo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yeud3LZCADvkzGEdkWinoteab5AZItkdM8HHv/Xu6CVXYoaz2kvv4DBfwgjhE4RAbrQedPF1oGljH2woNNzB3gLRnjqO1Gunn1g5bxDT2xXr2MwGa81Os8PqiQwoLA/Vw4bqTBV9548leYNWBj4G4uS1Ji6kIleDVKic7PJvl80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=cZOZOLfC; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1737137346; x=1737396546;
	bh=gkIHo4RjAWudat2q0E8IZ+TR2bYPlk/bm0n3lU7iiVo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=cZOZOLfC+exr6mq7l96+44NH5yAdkobZlVPYT/xL06A7bVPeSsyMPeh3pdxqZv6Q8
	 6hjQacjcIpDolMS/Pj8Yk79igmeR2jM+sx+9yOlFmD42zC0FPQ32mffX6MehQ0Nlib
	 smodgJ+FdERGEbm3P3Y86DtDEk1/Ds4xlfS0lYc1VpgSFn8vymvT1sCtWW6fC66pRr
	 8H6ILAApLIhYmbqc8ysnSm36rM4E3LCmO4pN1Jm4mNq+IRw0C2oLOYTRQCNJQV4NTf
	 gXcBK0oXxeS3r5k/M8g2PwQys8BSHDVSNN86X1zFYQlllP2kAD/EDBO9Gh1icJzsfT
	 1dx5pqHCITkkA==
Date: Fri, 17 Jan 2025 18:09:03 +0000
To: Mark Wielaard <mark@klomp.org>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: Andrew Pinski via Gcc <gcc@gcc.gnu.org>, bpf <bpf@vger.kernel.org>, Cupertino Miranda <cupertino.miranda@oracle.com>, "Jose E. Marchesi" <jose.marchesi@oracle.com>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Manu Bretelle <chantra@meta.com>, Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, Yonghong Song <yonghong.song@linux.dev>, David Faust <david.faust@oracle.com>, Andrew Pinski <pinskia@gmail.com>, fche@elastic.org
Subject: Re: Announcement: GCC BPF is now being tested on BPF CI
Message-ID: <V1fpzXpcBqAkD1YFcoPriX4EXsvFHhv6j82pD-zX40n5zdDAwC6k87TV6YNPF1D_Ch1J6TBXq7TNH7R2DAUnn9UXbHSzD5XxTQHlQVHboks=@pm.me>
In-Reply-To: <20250117134434.GC29102@gnu.wildebeest.org>
References: <mMhcrHuvf5fyjPwMa19kug9DHQH9yYcCJXKfaFMXhfQlKIuColex7zg7G6qpPqlfF74-IqzkhpZSlzsgvgikc-u6oQp27dNzFQAAatRaEuU=@pm.me> <20250117134434.GC29102@gnu.wildebeest.org>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 5c7f66fef681cc07d9ebe92e7591e23435ed9b5b
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Friday, January 17th, 2025 at 5:44 AM, Mark Wielaard <mark@klomp.org> wr=
ote:

>=20
>=20
> Hi Ihor,
>=20
> On Thu, Jan 16, 2025 at 08:44:54PM +0000, Ihor Solodrai via Gcc wrote:
>=20
> > An example of successful test run (you have to login to github to see
> > the logs):
> > https://github.com/kernel-patches/bpf/actions/runs/12816136141/job/3573=
6973856
> >=20
> > Currently 2513 of 4340 tests pass for GCC BPF, so a bit more than a hal=
f.
>=20
>=20
> Nice. Could you make the logs public so people don't have to create a
> github account? Or post the results to gcc-testresults@gcc.gnu.org so
> others can easily inspect them. You can also submit them to bunsen of
> course.

Hi Mark,

Well, re-publishing logs somewhere is certainly possible, however
since BPF CI runs on Github Actions there was never a need for
something like this.

When I got the selftests compilation working, I've shared the logs
produced by running the tests individually [1][2] through github. It's
72Mb of logs, and sending them directly to email isn't a good idea.

I don't know what's bunsen. Can you share a pointer?

Thanks.

[1] https://lore.kernel.org/bpf/EYcXjcKDCJY7Yb0GGtAAb7nLKPEvrgWdvWpuNzXm2qi=
6rYMZDixKv5KwfVVMBq17V55xyC-A1wIjrqG3aw-Imqudo9q9X7D7nLU2gWgbN0w=3D@pm.me/
[2] https://github.com/kernel-patches/bpf/blob/8f2e62702ee17675464ab00d97d8=
9d599922de20/tools/testing/selftests/bpf/gcc-bpf-selftests-logs.tgz

>=20
> Thanks,
>=20
> Mark


