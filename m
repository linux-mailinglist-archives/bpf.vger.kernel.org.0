Return-Path: <bpf+bounces-78823-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 790F8D1C2BD
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 03:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CFE2F3018315
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 02:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8AF32143D;
	Wed, 14 Jan 2026 02:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QLjClJDQ"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6AD320A10
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 02:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768359154; cv=none; b=d4Xisr/M5iLQ9DdMbfdA4jsvUiC+KIeAk26lK0FPJ3TB7nvAEQ5pOx8VfVF6Pje9IOKcW02VkO7z9mXKOJUtrjLpdKOi8Sf1GNk9JU22itJRbzfQu2kSlNrwVrJJzv6L37oBmzmosSS4IMXPrTzvb9AHMqPnoLTyEYmz/zZysxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768359154; c=relaxed/simple;
	bh=n7DJCQaBYJo/dF+7DjAAhohOYcC6OqKmz1TWgUfk4w8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ovaZ7FEIcw+yP+yeTxOR/UHzuvnxVVN4s8FZVU3srLCB2A9hEQ6FTHFR141wOJ1MN9abBgAwq1MvRMW8zHV9Qd1MGvEWTq2J4nicbrT2eX9e9eWyNNEtYDNisl6OTKQUleOORuxjZ3TfME6zMArzBltuSTT42wgyACDk1M7lbBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QLjClJDQ; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768359141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d4WwtQ0fY8xH9388oF0irINq2fp1GmSgtWnqUwNDRtw=;
	b=QLjClJDQqEARsSs1ufhsKWQue2W/acqqOFelG+zD8hTfAgwLCHvM/7+LRIkkf6tVVj65I4
	HV0p3CMx17CDDohD1kCheyJZzpYmxuXpcfQae7LUwxgZ/qWLMw2GT5Un7KgXebB0FE0raS
	7vYWmIFZhCWdtxveltz2KhEWaxXirAI=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 David Ahern <dsahern@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, jiang.biao@linux.dev,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v9 00/11] bpf: fsession support
Date: Wed, 14 Jan 2026 10:52:06 +0800
Message-ID: <117894611.nniJfEyVGO@7940hx>
In-Reply-To:
 <CAADnVQJw6HZHqBs6JRWkHESk=tFQpki9X6TnXBLKgeAhb6FK5w@mail.gmail.com>
References:
 <20260110141115.537055-1-dongml2@chinatelecom.cn>
 <CAADnVQJw6HZHqBs6JRWkHESk=tFQpki9X6TnXBLKgeAhb6FK5w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/1/14 10:28 Alexei Starovoitov <alexei.starovoitov@gmail.com> write:
> On Sat, Jan 10, 2026 at 6:11=E2=80=AFAM Menglong Dong <menglong8.dong@gma=
il.com> wrote:
> >
> q>
> > Changes since v8:
> > * remove the definition of bpf_fsession_cookie and bpf_fsession_is_retu=
rn
> >   in the 4th and 5th patch
> > * rename emit_st_r0_imm64() to emit_store_stack_imm64() in the 6th patch
> >
> > Changes since v7:
> > * use the last byte of nr_args for bpf_get_func_arg_cnt() in the 2nd pa=
tch
> >
> > Changes since v6:
> > * change the prototype of bpf_session_cookie() and bpf_session_is_retur=
n(),
> >   and reuse them instead of introduce new kfunc for fsession.
> >
> > Changes since v5:
> > * No changes in this version, just a rebase to deal with conflicts.
>=20
> When you respin please add lore links to all previous revisions,
> so it's easy to navigate to previous discussions.
> Like:

OK. I'll use it this way in the feature. Thanks for the reminding :)

>=20
> Changes v3->v4:
> ...
> v3: https://...
>=20
> Changes v2->v3:
> ...
> v2: https://...
>=20





