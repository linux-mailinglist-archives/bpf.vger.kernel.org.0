Return-Path: <bpf+bounces-40038-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D525397AD97
	for <lists+bpf@lfdr.de>; Tue, 17 Sep 2024 11:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB085B2D0EA
	for <lists+bpf@lfdr.de>; Tue, 17 Sep 2024 08:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7490B178397;
	Tue, 17 Sep 2024 08:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QImpsccI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF58C1581F4
	for <bpf@vger.kernel.org>; Tue, 17 Sep 2024 08:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726563228; cv=none; b=VD32OZYDxa3oygX5OHxX3UnpxFdpGreJDs/fdAiibnuuPQjj2Yc3adeJua0OFuMxCXWXRdohO4P1xl4r3+rtwGiFMSK4Y/eT7R3hMOnIcDohbiqnhnwEQzKsEj/d1yemx/pytn/osGnGUiptPsNSrJ7HbdOTGW/0N+1h6Xpd28M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726563228; c=relaxed/simple;
	bh=skLrtyK0eT6/Ajs9UVLMuMeZqcwkstEY2lJx6uWBhH0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Uw86tAXyix04QlVt+79Irhu/QBx4iHsrkduWJWp76ZakSUzi5VnPFcO/nHkarxe4ZV7PGjKrZY3rwkYKl6/iAtWm2pwoU64tkD8qxoYgC+6gmFi0ShCsqI8xWuBCj/HamOdT3IOqLQuH3B6BxLnzf7o0jtXMEqIpokCxZuOAyzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QImpsccI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B2B7C4CEC5;
	Tue, 17 Sep 2024 08:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726563227;
	bh=skLrtyK0eT6/Ajs9UVLMuMeZqcwkstEY2lJx6uWBhH0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=QImpsccIvEf4A8k7H6Blt2//B6ymk070f6vUN0QxBLwlFkYheFzVkKUeWFtMobIMy
	 06EzwYq51DMSK4tfcWSfGS0cl1pWJ5NG9oyYk1Jb/qt00tcc5lOC96ZVlczeWenk0+
	 3Jox5pqUwD/bRpRCJsTpaPDrJgSqy7tW275HOkFCnLzC9BPFL9Qh6eYQzgclDwOfPj
	 t9XpEP+FVwlMI/90y7+AMCLnIlmdc5jAY26pifPDtdrJAOxrxRg02FSy9h3mrGYNi/
	 +IYwoD6mW1BvzCwj0hC6VGRIxrx8YpBbOFCf/zNPBZahLYwA3rQIb2Z+OSeDbXQAyZ
	 9Ig7qF9mdDe2g==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Ihor Solodrai <ihor.solodrai@pm.me>, bpf@vger.kernel.org
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, mykolal@fb.com
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: set vpath in Makefile to
 search for skels
In-Reply-To: <20240916195919.1872371-2-ihor.solodrai@pm.me>
References: <20240916195919.1872371-1-ihor.solodrai@pm.me>
 <20240916195919.1872371-2-ihor.solodrai@pm.me>
Date: Tue, 17 Sep 2024 10:53:43 +0200
Message-ID: <871q1iek4o.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ihor Solodrai <ihor.solodrai@pm.me> writes:

> Auto-dependencies generated for %.test.o files refer to skels using
> filenames as opposed to full paths. This requires make to be able to
> link this name to an actual path, because not all generated skels are
> put in the working directory.
>
> In the original patch [1], this was mitigated by this target:
>
> $(notdir %.skel.h): $(TRUNNER_OUTPUT)/%.skel.h
> 	@true
>
> This turned out to be insufficient.
>
> First, %.lskel.h and %.subskel.h were missed, because a typical
> selftests/bpf build could find these files in the working directory.
> This error was detected by an out-of-tree build [2].
>
> Second, even with missing rules added, this target causes unnecessary
> rebuilds in the out-of-tree case, as X.skel.h is searched for in the
> working directory, and not in the $(OUTPUT).
>
> Using vpath directive [3] is a better solution. Instead of introducing
> a separate target (X.skel.h in addition to $(TRUNNER_OUTPUT)/X.skel.h),
> make is instructed to search for skels in the output, which allows make
> to correctly detect that skel has already been generated.
>
> [1]: https://lore.kernel.org/bpf/VJihUTnvtwEgv_mOnpfy7EgD9D2MPNoHO-MlANeL=
IzLJPGhDeyOuGKIYyKgk0O6KPjfM-MuhtvPwZcngN8WFqbTnTRyCSMc2aMZ1ODm1T_g=3D@pm.m=
e/
> [2]: https://lore.kernel.org/bpf/CIjrhJwoIqMc2IhuppVqh4ZtJGbx8kC8rc9PHhAI=
U6RccnWT4I04F_EIr4GxQwxZe89McuGJlCnUk9UbkdvWtSJjAsd7mHmnTy9F8K2TLZM=3D@pm.m=
e/
> [3]: https://www.gnu.org/software/make/manual/html_node/Selective-Search.=
html
>
> Reported-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>

As you point out, there are rebuilds triggered for the bpf "install"
target. Now rebuild are better than failures. Thanks for the fix!

Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>

