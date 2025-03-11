Return-Path: <bpf+bounces-53782-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2D1A5B6D8
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 03:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98A523A7129
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 02:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B2E1E7640;
	Tue, 11 Mar 2025 02:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xV9cfByi"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833DC1DE3B1
	for <bpf@vger.kernel.org>; Tue, 11 Mar 2025 02:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741660874; cv=none; b=n/DbL4TW+628/DR7zvAB9CYtnnOFYpl2qirGBDNzTG7L562iAUnO6pmGoR2jJH2sfYOULXyVgVi9ppphDg6jvkxJ+7mTpLnnwEeZDjBbsDgHCpI+ExaBUWpsP6WBk9fBHaVen5WN72wReLuYe+QY9SXupbTu414CvIaegMGlM8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741660874; c=relaxed/simple;
	bh=0pm1fePTm7G0XJi7y002OsLfXtKgeGZdHTmxeWdCqmM=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=TzIU3aZgsgeSN8APytphdxlJGgrcvjMhwtD+kiFtn0P3E0i+TZfgYzUOXRrHnbKseOlLgKJR9TPiDWjIQHVv2xCZkLYcqpE8WjjjazEe0HFnzThayj0xywZOkHHh3Wm83A/vaqMTYAsw3EgTHyyOAwxWFG8Qf+WEPEiraqbXl7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xV9cfByi; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741660869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v7KTxRCe5CRgFWS/jGr8eo1qIx08PKlHq3z+yRzjOLI=;
	b=xV9cfByiHSPehD1bxzdSWP0skWLRKJr3bQpMqEXsbiPy64Xf4KhzQP4uciO5Fz6Tl+rbhN
	iL76NPipoYn/PqNfkwFI20oBKKVIgmAD8JHoeCrQiE7fstGAMXKLkoUJS3+d9WKjZ1BHuD
	5KSsMa6B2Y6ylV/ekzs72Szya+DYx9M=
Date: Tue, 11 Mar 2025 02:41:07 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <821170d2c5d570ca7961e7f91169110dcce5449c@linux.dev>
TLS-Required: No
Subject: Re: [PATCH bpf-next v1 1/2] bpftool: Add -Wformat-signedness flag to
 detect format errors
To: "Quentin Monnet" <qmo@kernel.org>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, linux-kernel@vger.kernel.org, ast@kernel.org,
 davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 mrpre@163.com, "Arnaldo Carvalho de Melo" <acme@kernel.org>
In-Reply-To: <654713e8-f4ce-4742-8165-f73838ea8d16@kernel.org>
References: <20250310142037.45932-1-jiayuan.chen@linux.dev>
 <20250310142037.45932-2-jiayuan.chen@linux.dev>
 <654713e8-f4ce-4742-8165-f73838ea8d16@kernel.org>
X-Migadu-Flow: FLOW_OUT

March 10, 2025 at 23:49, "Quentin Monnet" <qmo@kernel.org> wrote:

>=20
>=202025-03-10 22:20 UTC+0800 ~ Jiayuan Chen <jiayuan.chen@linux.dev>
>=20
>=20>=20
>=20> This commit adds the -Wformat-signedness compiler flag to detect an=
d
> >=20
>=20>  prevent printf format errors, where signed or unsigned types are
> >=20
>=20>  mismatched with format specifiers. This helps to catch potential i=
ssues at
> >=20
>=20>  compile-time, ensuring that our code is more robust and reliable. =
With
> >=20
>=20>  this flag, the compiler will now warn about incorrect format strin=
gs, such
> >=20
>=20>  as using %d with unsigned types or %u with signed types.
> >=20
>=20>=20=20
>=20>=20
>=20>  Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> >=20
>=20
> Acked-by: Quentin Monnet <qmo@kernel.org>
>=20
>=20Thanks for that. Have you looked into enabling the flag along with th=
e
>=20
>=20other EXTRA_WARNINGS in tools/scripts/Makefile.include? It would be
>=20
>=20ideal to have it there, but I suppose it raises too many warnings acr=
oss
>=20
>=20tools/? (I didn't try myself.) No objection to taking it in bpftool o=
nly.
>=20

Thanks=20for reminding me of these.

I tried adding it to Makefile.include, and indeed there were a lot of war=
nings,
but this part is not part of bpftool. I'll take a look later and try to e=
nable this
options to fix these warnings as well. For now, I'll only fix the warning=
s related
to bpftool and these changes can also be easily synced to the bpftool on =
github.

> > ---
> >=20
>=20>  tools/bpf/bpftool/Makefile | 2 +-
> >=20
>=20>  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
>=20>=20=20
>=20>=20
>=20>  diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefi=
le
> >=20
>=20>  index dd9f3ec84201..d9f3eb51a48f 100644
> >=20
>=20>  --- a/tools/bpf/bpftool/Makefile
> >=20
>=20>  +++ b/tools/bpf/bpftool/Makefile
> >=20
>=20>  @@ -71,7 +71,7 @@ prefix ?=3D /usr/local
> >=20
>=20>  bash_compdir ?=3D /usr/share/bash-completion/completions
> >=20
>=20>=20=20
>=20>=20
>=20>  CFLAGS +=3D -O2
> >=20
>=20>  -CFLAGS +=3D -W -Wall -Wextra -Wno-unused-parameter -Wno-missing-f=
ield-initializers
> >=20
>=20>  +CFLAGS +=3D -W -Wall -Wextra -Wformat-signedness -Wno-unused-para=
meter -Wno-missing-field-initializers
> >=20
>=20
> Nit: This line is becoming long enough that I'd consider moving each
>=20
>=20flag to its own line, for better reading:
>=20
>=20 CFLAGS +=3D -W
>=20
>=20 CFLAGS +=3D -Wall
>=20
>=20 CFLAGS +=3D -Wextra
>=20
>=20 CFLAGS +=3D -Wformat-signedness
>=20
>=20 ...
OK=EF=BC=8CI will do this.

