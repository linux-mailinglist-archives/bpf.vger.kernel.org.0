Return-Path: <bpf+bounces-47128-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0EE89F55B0
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2024 19:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79AD91636E1
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2024 18:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E0F26296;
	Tue, 17 Dec 2024 18:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="QeGv0S3p"
X-Original-To: bpf@vger.kernel.org
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EBE14F9EB
	for <bpf@vger.kernel.org>; Tue, 17 Dec 2024 18:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734458791; cv=none; b=PDDkQyTZXDIRmfMU5R1mzzmjSMbvUqj0EL4gArGIY8ZTl7+63qq4eerBPbmZq9n2E9mQMAAP5gskGe/DY9yIhSRuIctZBGYOiUzQZq0jZxz0IPs5wsoydxMfRpJ8JQXqXTuukJONqyZTsGqz0Y3hoC86qOkQ6I1aIbwzmqHkoV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734458791; c=relaxed/simple;
	bh=qAiWo3OrbDhzimUCrpqTTBcTXZ80X/nvvKANhb3wbaM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A7nRbsHTQKfOBrlG/CN+aAbgFRoYAAxbmHMvATku8y+azZ3Uw/nED30giyIVU15GynoyS5MSxhTv23as+VA/X6oonUbf2/eSI+IrvNDi9AP9YVkuKmlp8z5wk720+tC8eDrmpuNNLbXY5vCi+WF/W/AQUhtXN5WgVcE4iwHxxdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=QeGv0S3p; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1734458787; x=1734717987;
	bh=qAiWo3OrbDhzimUCrpqTTBcTXZ80X/nvvKANhb3wbaM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=QeGv0S3pZJ3k8tbwTtgVZ0q300wrEYcecRyV5QaRy/5lv9XVJJO93y8r5JIpOYHnz
	 PaJyMGE5vn81gCJsCnASsMROG3JU49NVf5YOaN93tMheRQ8nBjsJKoIALEqr6uN0P5
	 OohTJG+rghBiNaQuCo1IvrbrMEscLzc8jVhj1BoTM7nnIhnbcv+qXg/BNUH1jxpvFN
	 9aGKFJfr7NnypOp1MX0ldJRAjoXQj+hu8jy4bagF2/hSJXWRz4/yMuqWk4S1n2Az3u
	 go8jwRyonkoKKDBnIvi+OgiPVLxZvVeMKei3IYnJ2Ui7StPQv+wxz5+iWCKr138DFT
	 71AqNtlqVz1Zg==
Date: Tue, 17 Dec 2024 18:06:22 +0000
To: Eduard Zingerman <eddyz87@gmail.com>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: dwarves@vger.kernel.org, acme@kernel.org, alan.maguire@oracle.com, andrii@kernel.org, mykolal@fb.com, bpf@vger.kernel.org
Subject: Re: [PATCH dwarves v2 07/10] btf_encoder: introduce btf_encoding_context
Message-ID: <yKpaq5zO0TcrAm1v3p4yd2D9ic0jGUQM0CUSg6CU_31_S1mX7SDljMf36ayteEV2O_MTE2eJkUuu3JoJWPQyIxHibe2zz1W3Uq_RzqiyPVY=@pm.me>
In-Reply-To: <735014fda88330d2124f4956cc9a0507f47176db.camel@gmail.com>
References: <20241213223641.564002-1-ihor.solodrai@pm.me> <20241213223641.564002-8-ihor.solodrai@pm.me> <09f6bc335380ca73d365566de7af8f2e73ac9cfd.camel@gmail.com> <735014fda88330d2124f4956cc9a0507f47176db.camel@gmail.com>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 2ab23196b0a513a826d2f9f982c663e586c95598
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Monday, December 16th, 2024 at 7:15 PM, Eduard Zingerman <eddyz87@gmail.=
com> wrote:

>=20
> On Mon, 2024-12-16 at 18:39 -0800, Eduard Zingerman wrote:
>=20
> > On Fri, 2024-12-13 at 22:37 +0000, Ihor Solodrai wrote:
> >=20
> > > Introduce a static struct holding global data necessary for BTF
> > > encoding: elf_functions tables and btf_encoder structs.
> [...]
> >=20
> > After patch #10 "dwarf_loader: multithreading with a job/worker model"
> > from this series I do not understand why this patch is necessary.
> > After patch #10 there is only one BTF encoder, thus:
> > - there is no need to track btf_encoder_list;
> > - elf_functions_list can now be a part of the encoder;
> > - it should be possible to forgo global variable for encoder
> > and pass it as a parameter for each btf_encoder__* func.
> >=20
> > So it seems that this patch should be dropped and replaced by one that
> > follows patch #10 and applies the above simplifications.
> > Wdyt?
>=20
>=20
> Meaning that patch #6 "btf_encoder: switch to shared elf_functions table"
> is not necessary. Strictly speaking, patches 1,2,4 might not be necessary
> as well, but could be viewed as a refactoring.
> Switch to single-threaded BTF encoder significantly changes this patch-se=
t.

Eduard, thanks for the review again.

You are correct: if we focus on the multithreading changes in
dwarf_loader.c and make a decision that there is always a single
btf_encoder, then much of this series can be discarded.

At the same time I think most of the patches are useful. At the very
least they enabled experiments that in the end lead me to the
dwarf_loader changes.

The changes making ELF functions table shared were beneficial in
isolation, because they eliminated unnecessary duplication of
information between encoders, leading to reduced memory usage.

The changes splitting ELF and BTF function information in
btf_encoder.c and simplifying function processing are also good in
isolation.

In my opinion, it's not wise to discard all of that, because it turned
out that a single btf_encoder works better in the use-case we care
about now. Later we might want to revisit parallel BTF encoding. Then
some version of the refactoring changes here will have to be re-done.

So I think it makes sense to land most of this series without
significant re-work. But of course I am biased here, as I wrote most
of the patches, and it's always painful to "throw away" effort.

Let's see what others think.

