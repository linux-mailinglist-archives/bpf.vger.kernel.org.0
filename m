Return-Path: <bpf+bounces-40007-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B4097A827
	for <lists+bpf@lfdr.de>; Mon, 16 Sep 2024 22:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BE1C1C26AF0
	for <lists+bpf@lfdr.de>; Mon, 16 Sep 2024 20:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32EA515DBDD;
	Mon, 16 Sep 2024 20:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="h/JHkmwF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC90D15B122
	for <bpf@vger.kernel.org>; Mon, 16 Sep 2024 20:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726517473; cv=none; b=aMqw3lvulEh7/u3pP3URHYWEkwe1N327f/HwerwDAotKNQrsz3nnnkRCrBeY4DDFMy11QAoxYgXQNb0VO+tDYL9/TsKcrKQ6AvaqzuW6C+GIHsPOITKR7cMhjzL/P9P5DOiIi3aVnhoE9woDbdIgibhN/ukleTa1bLnxDGWxva0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726517473; c=relaxed/simple;
	bh=nZPICZaDRcKqxmDy1T2pTKTCnTaWodG+0CMRQ48Jhtw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qpDstuwHxyt+u6on9vi7sV6GFnhClnCpNgWJwe1AZUeXz/LLR+fhyZj0BwuPSg8YWwfKxMvdGIbXTxEptyYksFTWf1R5tUd8Pp3kFyCTyjJ0aZ6wczyevLNyQdde/XymM7/qfDyYyI9e21/PnALLelbLGpNnzS61EY1guI9v9wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=h/JHkmwF; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1726517470; x=1726776670;
	bh=nZPICZaDRcKqxmDy1T2pTKTCnTaWodG+0CMRQ48Jhtw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=h/JHkmwFPKlSskrQAm62S3/3QKL25xNKuUuq7nHLvwR2JIJy1qfiVS01XsiUHioM9
	 KZ8iTTCDH8Z0sNoqEbMl/NcIXo0yuFEfRJTg97hg5HgNiP3/kL5hJejZyOLnMsnSE9
	 oGX0Q6VUGHMgvy8nCuYNX4cHp4Fz4hsF1i0J7I8DR/Hv6pjN83sThL7nNhjE6oVTBY
	 4Ycl/P14xjAltc6YzgGD8U/ifkiqey+yUuoAT89rV8E4wq6kLDFgeGqmVkUFSecEti
	 d64vtDKSeOLt0NlxZbhYz56mY5Z4SRzhN+tHo6D1OMdZoqFRkgh5EXHYcYTCUK1YrZ
	 N6yVgljDsgMVA==
Date: Mon, 16 Sep 2024 20:11:05 +0000
To: bjorn@kernel.org, bpf@vger.kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, mykolal@fb.com
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: set vpath in Makefile to search for skels
Message-ID: <UY2IgCYyCDAo1dUb99pWVkhJgho4pTlYXWmTQW8aCaElutKzNPXnuPGplCU6AtfXzdBTSaLS-BC5n763EABAgCfVsQ7GIJOXWzti0jzD0a4=@pm.me>
In-Reply-To: <20240916195919.1872371-2-ihor.solodrai@pm.me>
References: <20240916195919.1872371-1-ihor.solodrai@pm.me> <20240916195919.1872371-2-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 38cc05a1b3483c6bac5559c7f7939c2e1c16d5ff
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Monday, September 16th, 2024 at 12:59 PM, Ihor Solodrai <ihor.solodrai@p=
m.me> wrote:

[...]

> ---
> tools/testing/selftests/bpf/Makefile | 9 +++++----
> 1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index df75f1beb731..365740f24d2e 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -622,10 +622,11 @@ $(TRUNNER_BPF_SKELS_LINKED): $(TRUNNER_OUTPUT)/%: $=
$$$(%-deps) $(BPFTOOL) | $(TR
>=20
> # When the compiler generates a %.d file, only skel basenames (not
> # full paths) are specified as prerequisites for corresponding %.o
> -# file. This target makes %.skel.h basename dependent on full paths,
> -# linking generated %.d dependency with actual %.skel.h files.
> -$(notdir %.skel.h): $(TRUNNER_OUTPUT)/%.skel.h
> - @true
> +# file. vpath directives below instruct make to search for skel files
> +# in TRUNNER_OUTPUT, if they are not present in the working directory.
> +vpath %.skel.h $(TRUNNER_OUTPUT)
> +vpath %.lskel.h $(TRUNNER_OUTPUT)
> +vpath %.subskel.h $(TRUNNER_OUTPUT)
>=20
> endif
>=20
> --
> 2.34.1

Hi Bj=C3=B6rn.

It'd be great if you could confirm that this patch works for your
use-case.

Regarding unnecessary rebuilds, you will still see some skels and
bpf.o objects rebuilt on out-of-tree builds. These are related to
$(LINKED_SKELS) in selftests/bpf/Makefile. They are entangled with
%-deps variables, and I couldn't come up with a similar solution for
them quickly. However, there are just a couple of them, and the
rebuild is relatively fast, so I decided to submit a patch that fixes
most of the problem.

Thank you!


