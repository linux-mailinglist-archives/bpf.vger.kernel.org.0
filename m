Return-Path: <bpf+bounces-50008-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E33A215AE
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 01:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 628907A15C4
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 00:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FEF3398B;
	Wed, 29 Jan 2025 00:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vo2MhWIu"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6136D155C8C
	for <bpf@vger.kernel.org>; Wed, 29 Jan 2025 00:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738111011; cv=none; b=flk8p+wfjIhBnbBbGfB1s5R6ogijqwEWZQCqvUqJWzKDKyN2sBVA9B8uTajVmD/ipNMzK1vOBHR89LWlGt/UNsygKSW/4D1ogQt9GAWUx/uT9lQPQKVSVwDB6/EZ87Xn/4+trHXGExTlwAEZ7CCK8OtYbwhshxzuMk5M5qw91Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738111011; c=relaxed/simple;
	bh=BvflY9ZJgLT8GK71Vf3t40ymigycEOgSdWxbDIEo/50=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=e3B+wYNxCg/Zj6ebFCWxkc3zOb1+/N/c74gQDKhhQeROO2WnO2EEVTOFlYcfiH2XmHqaij60uk9hFIsp3HySgTg89sQmRGjza9nANfikMbwkUTFV79VGX5fGmP6pCXIDsbIWLe17BrATVJzXCFMLvTqWqSGhkJXLW7HN8s0xSCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vo2MhWIu; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738111002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BvflY9ZJgLT8GK71Vf3t40ymigycEOgSdWxbDIEo/50=;
	b=vo2MhWIucuDx9N3eK1xznV69rHhfzzkionjso/3kiteA5auCtc9Kjrn0FyX7EeK/voMmVj
	FqNEMNUyzIziwwm95VZ2L39fvp5mbdCpsDw6AJm8ox8g1kZXaIrms27DLax4PLw9YXZH8m
	memF63g0wyrwDAabSacanUbEkoeIOe4=
Date: Wed, 29 Jan 2025 00:36:40 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Message-ID: <36780a0c327fe6fe0fee1c05ba04368e46d30a37@linux.dev>
TLS-Required: No
Subject: Re: [PATCH 1/2] s390: fgraph: Fix to remove
 ftrace_test_recursion_trylock()
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, "Steven Rostedt"
 <rostedt@goodmis.org>, "Heiko Carstens" <hca@linux.ibm.com>, "Sven
 Schnelle" <svens@linux.ibm.com>
Cc: "Jiri Olsa" <olsajiri@gmail.com>, "Masami Hiramatsu"
 <mhiramat@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev"
 <agordeev@linux.ibm.com>, "Christian Borntraeger"
 <borntraeger@linux.ibm.com>, "Andrii Nakryiko"
 <andrii.nakryiko@gmail.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-s390@vger.kernel.org, "bpf"
 <bpf@vger.kernel.org>
In-Reply-To: <173807817692.1854334.2985776940754607459.stgit@devnote2>
References: <173807816551.1854334.146350914633413330.stgit@devnote2>
 <173807817692.1854334.2985776940754607459.stgit@devnote2>
X-Migadu-Flow: FLOW_OUT

January 28, 2025 at 7:29 AM, "Masami Hiramatsu (Google)" <mhiramat@kernel=
.org> wrote:



>=20
>=20From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20
>=20Fix to remove ftrace_test_recursion_trylock() from ftrace_graph_func(=
)
>=20
>=20because commit d576aec24df9 ("fgraph: Get ftrace recursion lock in
>=20
>=20function_graph_enter") has been moved it to function_graph_enter_regs=
()
>=20
>=20already.
>=20
>=20Reported-by: Jiri Olsa <olsajiri@gmail.com>
>=20
>=20Closes: https://lore.kernel.org/all/Z5O0shrdgeExZ2kF@krava/
>=20
>=20Fixes: d576aec24df9 ("fgraph: Get ftrace recursion lock in function_g=
raph_enter")
>=20
>=20Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20
>=20Tested-by: Jiri Olsa <jolsa@kernel.org>
>=20
>=20[...]

Hi Masami,

Can confirm this patch fixes missed/kprobe_recursion BPF selftests on s39=
0x:
https://github.com/kernel-patches/vmtest/actions/runs/13021621468/job/363=
24248903

Tested-by: Ihor Solodrai <ihor.solodrai@linux.dev>

Thanks!

