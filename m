Return-Path: <bpf+bounces-42392-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D37B79A39F3
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 11:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A1A01F2520F
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 09:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC8B1E4929;
	Fri, 18 Oct 2024 09:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qmon.net header.i=@qmon.net header.b="q8W7Yhkm"
X-Original-To: bpf@vger.kernel.org
Received: from outbound.soverin.net (outbound.soverin.net [185.233.34.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E7615666D
	for <bpf@vger.kernel.org>; Fri, 18 Oct 2024 09:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.233.34.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729243585; cv=none; b=iZD/PceWWzVHowCVNEAiSJzalTQn5KceUvKmm1t0PpPeZdebJAl/nFNP2gfV7Z0IsvAdfN4AoIY75Td2m2zeyMcLygTfIPlG4NuftDT3fqBPfWxBKAmdr8x6+BwVN/GCarYCfrmuSBibr0wHO9EU0s7HQjQLOSyW7cFsafTfurw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729243585; c=relaxed/simple;
	bh=2yX1lm0JYjYVXiUqlaYCdC0HijCE78w6eJElY9PLoro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M8eW4XSk5ACJZslbBkHt3KLx4eXOvieHk9fnAkQZI3SNl3as5sVjBY29gLDx/xIoZp3BAhBz7CZBoO4ghM8TqnmgpFPpRXp229iAXvNUc7sELe+x46YGc+Nm1YmkvRCA0hlqxYVNZv+HR2TY45OMSTnjKwR38BwyfgTtyKlurNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qmon.net; spf=pass smtp.mailfrom=qmon.net; dkim=pass (2048-bit key) header.d=qmon.net header.i=@qmon.net header.b=q8W7Yhkm; arc=none smtp.client-ip=185.233.34.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qmon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qmon.net
Received: from smtp.soverin.net (unknown [10.10.4.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by outbound.soverin.net (Postfix) with ESMTPS id 4XVJy00GvGz4R;
	Fri, 18 Oct 2024 09:17:28 +0000 (UTC)
Received: from smtp.soverin.net (smtp.soverin.net [10.10.4.99]) by soverin.net (Postfix) with ESMTPSA id 4XVJxy6ww6z5r;
	Fri, 18 Oct 2024 09:17:26 +0000 (UTC)
Authentication-Results: smtp.soverin.net;
	dkim=pass (2048-bit key; unprotected) header.d=qmon.net header.i=@qmon.net header.a=rsa-sha256 header.s=soverin1 header.b=q8W7Yhkm;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qmon.net; s=soverin1;
	t=1729243047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0o1sDQ0CXar23qbhsbLkS5of90qvzdckiER1AtNWjAY=;
	b=q8W7YhkmeREahtSSzugE7vJU4kFrZM85xXqg6fc26D8Huz92UOzjA+QrvL/EiajZyu3Lr5
	3WSF4TaFoNlxtWwoustuj9YivSnVB2ZqjWXzPr67PTmKnWwW8Omjwj7arvFc++nH5L3joz
	1Dj0Fb9Vj4YYyRWWAvUPcKbY/WAh/DihGxkFV2AI+nIfhrGr27RB0f03Zu1CaSQakUhEMF
	WwMSCZhJhuUJjYQ+Ftsy29XnWeGOgdmQ7XBkGOMuXFqCBDaCPg3LyVjyZ65xS8fTloRuj0
	6dz80s1OzeJX2yNuAZl3e2D9i8RePppIaEp+DooZbAzvWHEos6lJmiKck2H9Ig==
Message-ID: <2bef35eb-a8a7-4569-a814-40ad60851d73@qmon.net>
Date: Fri, 18 Oct 2024 10:17:25 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/3] bpftool: Prevent setting duplicate
 _GNU_SOURCE in Makefile
To: Viktor Malik <vmalik@redhat.com>, bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>
References: <cover.1729233447.git.vmalik@redhat.com>
 <820bd20ea460548828ae9a50f5bdbad0700591e5.1729233447.git.vmalik@redhat.com>
From: Quentin Monnet <qmo@qmon.net>
Content-Language: en-GB
In-Reply-To: <820bd20ea460548828ae9a50f5bdbad0700591e5.1729233447.git.vmalik@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spampanel-Class: ham

2024-10-18 08:49 UTC+0200 ~ Viktor Malik <vmalik@redhat.com>
> When building selftests with CFLAGS set via env variable, the value of
> CFLAGS is propagated into bpftool Makefile (called from selftests
> Makefile). This makes the compilation fail as _GNU_SOURCE is defined two
> times - once from selftests Makefile (by including lib.mk) and once from
> bpftool Makefile (by calling `llvm-config --cflags`):
> 
>     $ CFLAGS="" make -C tools/testing/selftests/bpf
>     [...]
>     CC      /bpf-next/tools/testing/selftests/bpf/tools/build/bpftool/btf.o
>     <command-line>: error: "_GNU_SOURCE" redefined [-Werror]
>     <command-line>: note: this is the location of the previous definition
>     cc1: all warnings being treated as errors
>     [...]
> 
> Filter out -D_GNU_SOURCE from the result of `llvm-config --cflags` in
> bpftool Makefile to prevent this error.
> 
> Signed-off-by: Viktor Malik <vmalik@redhat.com>

I am not aware of any extension in use in bpftool that would require the
use of -D_GNU_SOURCE, so I suppose it's fine to remove it
unconditionally, even when it's not in CFLAGS before we append the flags
from llvm-config. Thanks!

Acked-by: Quentin Monnet <qmo@kernel.org>

