Return-Path: <bpf+bounces-64882-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC96B18177
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 14:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BF981AA68C3
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 12:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA34F23C51B;
	Fri,  1 Aug 2025 12:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pwned.life header.i=@pwned.life header.b="Xyp3H310"
X-Original-To: bpf@vger.kernel.org
Received: from mx.nixnet.email (mx.nixnet.email [5.161.67.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D45B2222CB;
	Fri,  1 Aug 2025 12:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.161.67.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754049904; cv=none; b=X9AtSIQU3iwnDeivwSepATGPrwZPIpYRmBBKVqb9j/TWcvBsvUyhLuHk2lJ2tdnBxRL2KQJjnG+0ILRxFSV/reSnAtTsDaXP8PSal+mo+2i48BEUnXN4x848Pvdm6o6+HhtjvL2M3zzzxDy/RC8D/K/yffUw1GLn40ESkjff6vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754049904; c=relaxed/simple;
	bh=CJroq+C4YzlYLxQYxU2/Qhbe761CIfjoXbImkliiNaA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=CVJZhcwYC3Nf5U1JCxuz1XQ7TmnDDvrVauQixh71dCu+qAmvgRnt7eHq1TFcN5pxRzHTDGVs4OwhF8LFMGBieCYYwdJr29lVwGylASsB9RViqnRynOyhQ5+MDWoXPMNgAoI96veayFyJa99ObH92RnGylUl7LV65jgHLwrxUYYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pwned.life; spf=pass smtp.mailfrom=pwned.life; dkim=pass (1024-bit key) header.d=pwned.life header.i=@pwned.life header.b=Xyp3H310; arc=none smtp.client-ip=5.161.67.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pwned.life
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pwned.life
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mx.nixnet.email (Postfix) with ESMTPSA id 58A137D326;
	Fri,  1 Aug 2025 14:04:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pwned.life; s=202002021149;
	t=1754049900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AhPQ34PAQrs3lQQWV914FbKArWwOxAA5okbdCnstF0Q=;
	b=Xyp3H310RcIDGWXHTpuNl7HDErUW64CGZze78KDCRYQF85KvM71rU8hwHmZ9eCW1n5SvM0
	Iw6rHwr+i+XyI3ISIr/TC1rC6A+7xmOILOdZeeFZVPBTrqvtFyodN20xGJnvP0FjJCM4qO
	36X/4aacPAPtgh0CE8oxYNCd01KlOiI=
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 01 Aug 2025 14:04:54 +0200
Message-Id: <DBR2SLKGO5OO.276GT83Y3D6DA@pwned.life>
Cc: <linux-kernel@vger.kernel.org>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "John Fastabend"
 <john.fastabend@gmail.com>, "KP Singh" <kpsingh@kernel.org>, "Stanislav
 Fomichev" <sdf@fomichev.me>, "Hao Luo" <haoluo@google.com>, "Jiri Olsa"
 <jolsa@kernel.org>, "Achill Gilgenast" <fossdd@pwned.life>
Subject: Re: [PATCH] libbpf: avoid possible use of uninitialized mod_len
From: "Achill Gilgenast" <fossdd@pwned.life>
To: "Eduard Zingerman" <eddyz87@gmail.com>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Viktor Malik" <vmalik@redhat.com>, <bpf@vger.kernel.org>
X-Greeting: Hi mom! Look, I'm in somebodys mail client!
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <a74ec917c2e3bf4d756a5ce2745f0f0a2970805a.camel@gmail.com>
 <20250801114613.610070-1-fossdd@pwned.life>
In-Reply-To: <20250801114613.610070-1-fossdd@pwned.life>

On Fri Aug 1, 2025 at 1:46 PM CEST, Achill Gilgenast wrote:
> If not fn_name, mod_len does never get initialized which fails now with
> gcc15 on Alpine Linux edge:
>
> 	libbpf.c: In function 'find_kernel_btf_id.constprop':
> 	libbpf.c:10100:33: error: 'mod_len' may be used uninitialized [-Werror=
=3Dmaybe-uninitialized]
> 	10100 |                 if (mod_name && strncmp(mod->name, mod_name, mod=
_len) !=3D 0)
> 	      |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~
> 	libbpf.c:10070:21: note: 'mod_len' was declared here
> 	10070 |         int ret, i, mod_len;
> 	      |                     ^~~~~~~
>
> Signed-off-by: Achill Gilgenast <fossdd@pwned.life>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Link: https://lore.kernel.org/bpf/20250729094611.2065713-1-fossdd@pwned.l=
ife/

Oops, the subject should've been v2. I forgot to pass -v2 to git
send-email.

