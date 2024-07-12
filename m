Return-Path: <bpf+bounces-34617-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA19792F49A
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 06:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 146E1B229AA
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 04:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64ACC1119A;
	Fri, 12 Jul 2024 04:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="sYnCDp70"
X-Original-To: bpf@vger.kernel.org
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A1617552
	for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 04:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720758124; cv=none; b=oHiGrf6FcN4FrE3oc//cM/eBXTc+CGzweEZCH2RQNoE6m1txkirbiOB+TvsZMgKlXpcdvnnRNNE/fmYbRsgLnZlc4+bFoItwyPPZ7Jgo6zQ9i7Dqmvxs8zJ8ik3F4l0vX+o6zQ4V5J5jkIilPfOZq0Bra/GjC1fq25wPa+alOq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720758124; c=relaxed/simple;
	bh=RlskR0Jjtk6nozWQJHK2Us15no5ftCFmFfi+t/dO8y8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M7kuCNQPPPpd9neEaeVcZ7MoQo+4Pp24CQcnK2F5Rn0tTvjELSVNBNUPkieBaGQZPuZGbp3fuYAC8faKktkpW7NwiIPOsIr3XaV0zfrI2Ozki8LJwNbp50lF8W1rRlZHOudppEVXUQtC0m/6Tryr/R4NYmUx+NAuaq01NGUkCY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=sYnCDp70; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1720758108; x=1721017308;
	bh=z5ac4a9ea4TYWSppbYxfbAD3GKLmFqs4IHGexxHA3HY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=sYnCDp70rTc9Zczqka7BnI8k08R7DAaycesnl/Lg3vDH16XntOxkmTfeywXJB/cl1
	 uMq2D7X0AdjRV8bsiCc0RRYT2adOGsW32Se1jFLbUqD/2Neerjl5QgCHZiYmE6J2bB
	 7IuLlR4e6Qsavsb+0m7Qfe+3fN82ldCTURUijJBCKFmRHYRVBRSr9h6zWPeiZEEGYp
	 p+LzPeMdFupvgqQcMyavN/uRrTGHw4RKJdn1QDsdIq1a9IsWOGbQBb24txogiKOo86
	 nUvAybOaD6x1Iut6BgQQDGuEnduIvriGCYr1c7UKJNTiWPcaBmYkxuR9B5C9/7hfMQ
	 hwuBmKSaYQ7SA==
Date: Fri, 12 Jul 2024 04:21:43 +0000
To: Eduard Zingerman <eddyz87@gmail.com>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "ast@kernel.org" <ast@kernel.org>, "andrii@kernel.org" <andrii@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>, "mykolal@fb.com" <mykolal@fb.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: use auto-dependencies for test objects
Message-ID: <gSoCpn9qV5K0hRvrvYlrw2StRntsvZcrUuDfkZUh1Ang9E6yZ9XJGYDuIP9iCuM2YTVhSEzEXCteQ94_0uIUjx_mXwupFJt64NJaiMr99a0=@pm.me>
In-Reply-To: <3586ffa2dfbee094aaa8a76ab5f570df37ef4b35.camel@gmail.com>
References: <Naz7DRaOm6WPfVO0YqehujmRBSUi1RDWI6XYE-9zcqusFHfJ9VXevAlYMbcYORj2r8277pIQlbO5qHcpBrJpbeHAscLS9eo1AoKlkEiwt5k=@pm.me> <17b05c0408489fd5ca474ae8ba3b7a3cc376f484.camel@gmail.com> <3586ffa2dfbee094aaa8a76ab5f570df37ef4b35.camel@gmail.com>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 98ffa96f54c5488edd07db517edc65232033fdbf
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thursday, July 11th, 2024 at 7:21 PM, Eduard Zingerman <eddyz87@gmail.co=
m> wrote:

[...]

> After some investigation it turned out that behaviour is specific to LLVM=
.
> Under certain not yet clear conditions clang writes .d file after writing=
 .o file.
> For example:
>=20
> {llvm} 19:15:59 bpf$ rm ringbuf.test.o; make `pwd`/ringbuf.test.o; ls -l =
--time-style=3Dfull-iso `pwd`/ringbuf.test.{o,d}
> TEST-OBJ [test_progs] ringbuf.test.o
> -rw-rw-r-- 1 eddy eddy 1947 2024-07-11 19:16:01.059016929 -0700 /home/edd=
y/work/bpf-next/tools/testing/selftests/bpf/ringbuf.test.d
> -rw-rw-r-- 1 eddy eddy 160544 2024-07-11 19:16:01.055016909 -0700 /home/e=
ddy/work/bpf-next/tools/testing/selftests/bpf/ringbuf.test.o
>=20
> Note that ringbuf.test.d is newer than ringbuf.test.o.
> This happens on each 10 or 20 run of the command.
> Such behaviour clearly defies the reason for dependency files generation.
>=20
> The decision for now is to avoid specifying .d files as direct dependenci=
es
> of the .o files and use order-only dependencies instead.
> The make feature for reloading included makefiles would take care
> of correctly re-specifying dependencies.

Eduard, thank you for testing.

I was able to reproduce the problem you've noticed using LLVM 19.

As far as I understand, direct dependency is not reliable here because
it implicitly expects %.d files to always be older than %.o files.

There are two possible situations when a given %.test.o must be built.

If %.test.d does not exist, then the include will be empty.  However,
because there is a target for %.test.d and a dependency on it, all the
%.bpf.o and skels will be built. And by the time CC %.test.o happens,
all its dependencies are ready. This is true for %.test.d both as
direct and order only dependency.

If %.test.d exists, then make included it and there is an additional
target for a particular %.test.o with concrete dependencies, which are
built as necessary. And the explicit %.test.d doesn't trigger, because
the file is up-to-date (which is exactly what we want).

In the second case, if %.test.d prerequisite is not order only, and
%.test.d sometimes happens to be newer than %.test.o (this is the case
for clang, but not for gcc), make would run CC again, which may update
%.d again and create a loop.

I think making %.test.d an order only prerequisite is the right fix
here, because we clearly can not expect that all compiler versions
will output %.d before %.o (even though it makes sense).

I will send v2 of the patch shortly.


