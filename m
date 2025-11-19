Return-Path: <bpf+bounces-75031-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D1373C6C6E3
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 03:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 88C2F2C7CC
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 02:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBA02C178E;
	Wed, 19 Nov 2025 02:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="psQLFmmW"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD30928C2DD
	for <bpf@vger.kernel.org>; Wed, 19 Nov 2025 02:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763520462; cv=none; b=X1KIMwji+z4XsFXizyCGSisg3bYwbSZ+Q1oD6EaQnVwHvEEBp+zqmJoFJgJTIhbOqbE6PUFfY+KKhpcs0rUnq4koO8S5+IdR+rlAIPcMw54rTMB0QCqwqSDGAR5FuFG0ru1wZXEMgPoh+Y8/53NUV+IZKcsZW/DhsHQGHnbC9Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763520462; c=relaxed/simple;
	bh=8qkxxhQPcQks1IHDKUkvEk1ro7Emwwx0ztqcHyihPFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KTVGrex2I88qPKDZNH4QuNKr0BilGREGPvzfEW+yYnK4fMfjkOyXhAYLTXcv82SV56Rueukc9ubK/PnrG25hDVTc79CzaCtetPMBbz8ZFrBn9ppubpY5hTKgHXhrVewJ4amSH+MRvQJcq+QR68Jbwxwge8sI92CfRnrmJWBpxH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=psQLFmmW; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763520452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8qkxxhQPcQks1IHDKUkvEk1ro7Emwwx0ztqcHyihPFY=;
	b=psQLFmmWtA1TxsXjZoKnUnflhodtiX/TDRqnab2swyoA39b4Y5kN0m9s0ZDCbWHK8nCFmQ
	+dMfB2yCIHoiVOzxb/2M/jq2xfpmfS+zMb6rAz2PWeyB5lKJHyIdKvZEvWH38vFG91gbUp
	G38GmpkvJuZFJtmr+CbhPevSk9i7nMc=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Leon Hwang <leon.hwang@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, jiang.biao@linux.dev,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v3 0/6] bpf trampoline support "jmp" mode
Date: Wed, 19 Nov 2025 10:47:11 +0800
Message-ID: <8606158.T7Z3S40VBb@7950hx>
In-Reply-To:
 <CAADnVQJF5qkT8J=VJW00pPX7=hVdwn2545BzZPEi=mPwFouThw@mail.gmail.com>
References:
 <20251118123639.688444-1-dongml2@chinatelecom.cn>
 <CAADnVQJF5qkT8J=VJW00pPX7=hVdwn2545BzZPEi=mPwFouThw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/11/19 08:28, Alexei Starovoitov wrote:
> On Tue, Nov 18, 2025 at 4:36=E2=80=AFAM Menglong Dong <menglong8.dong@gma=
il.com> wrote:
> >
> > As we can see above, the performance of fexit increase from 80.544M/s to
> > 136.540M/s, and the "fmodret" increase from 78.301M/s to 159.248M/s.
>=20
> Nice! Now we're talking.
>=20
> I think arm64 CPUs have a similar RSB-like return address predictor.
> Do we need to do something similar there?
> The question is not targeted to you, Menglong,
> just wondering.

I did some research before, and I find that most arch
have such RSB-like stuff. I'll have a look at the loongarch
later(maybe after the LPC, as I'm forcing on the English practice),
and Leon is following the arm64.

=46or the other arch, we don't have the machine, and I think
it needs some else help.

Thanks!
Menglong Dong

>=20
>=20





