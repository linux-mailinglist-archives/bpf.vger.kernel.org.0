Return-Path: <bpf+bounces-74915-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C84E6C67BD0
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 07:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1A9774E2EFD
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 06:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5B82E9EA4;
	Tue, 18 Nov 2025 06:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mr8HX4BV"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B420A2E8B91;
	Tue, 18 Nov 2025 06:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763447693; cv=none; b=WX5AsGE6m17heEbIPDeIIsGXv8pUlUCFPOyCwaJ5JD0VsX4Xhgc6z1ym5gzWg4Z9SBo1NZpNxv+fXGjF7IiHfMUJk24qh4FFaoXR8WrrX6Mi/iR3Gw/ooXvdiy2cSJ81/APk5CmD8Jjz2YpZLv4kr/toaQLtNAbmOs3GZ3cY5eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763447693; c=relaxed/simple;
	bh=oKsuM5STjEXOKZ87rh6l1uzTyZMiYw0CkMzFZcifoX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WFOM12+D3RzNVxyO7wvc8i20pKFNV1ACO8yW2v6bTRpTfAzqz+hOH+WONGB4XOXXWAPL5SV67PANWmGDbJPql7GXUcQl66NCRUMNfqR5jbnfWSDim8IHwu2BRBY5ZhxkKKp46bXDi89sIESv2SxkVR43r7TOn2ov1pri0JTSagM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mr8HX4BV; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763447688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oKsuM5STjEXOKZ87rh6l1uzTyZMiYw0CkMzFZcifoX4=;
	b=mr8HX4BVMNFEk+QQ1NoqjZfR+obD/Uz56Lm4Vf0WcvNBRshyO8H2qae8NRtWmTu4m3sBiH
	RF11uxkXFnuEZu8bevWAVHMT66EntaVXyoD2u8E+3I8+nuhB5VDECk8mKmTmolNpnWsQxO
	/DyBawQC6+0jDnmGdwTX81i+JyZnXb0=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
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
Subject: Re: [PATCH bpf-next v2 0/6] bpf trampoline support "jmp" mode
Date: Tue, 18 Nov 2025 14:34:34 +0800
Message-ID: <5027922.GXAFRqVoOG@7950hx>
In-Reply-To:
 <CAADnVQK5U28Wv2tSkymZY6ixCoUrSDoohB5wJmpyZL7t-Czk4w@mail.gmail.com>
References:
 <20251117034906.32036-1-dongml2@chinatelecom.cn>
 <CAADnVQK5U28Wv2tSkymZY6ixCoUrSDoohB5wJmpyZL7t-Czk4w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/11/18 14:31, Alexei Starovoitov wrote:
> On Sun, Nov 16, 2025 at 7:49=E2=80=AFPM Menglong Dong <menglong8.dong@gma=
il.com> wrote:
> >
> > For now, the bpf trampoline is called by the "call" instruction. Howeve=
r,
> > it break the RSB and introduce extra overhead in x86_64 arch.
>=20
> Please include performance numbers in the cover letter when you respin.

Hmm...I included a little performance, do you mean more performance
data? Current description:

As we can see above, the RSB is totally balanced. After the modification,
the performance of fexit increases from 76M/s to 130M/s.

>=20
>=20





