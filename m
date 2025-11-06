Return-Path: <bpf+bounces-73824-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B9DC3AD61
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 13:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1F672348A9C
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 12:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C1F2C0F8E;
	Thu,  6 Nov 2025 12:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tnWSirdF"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD79309EF9
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 12:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762431306; cv=none; b=Xv3cklrxmtufrO6SFBE4sbQ8EC0wF6C3YskllzP8LjLkHct8K6P1wqMTEE4NfbN0smwqENdDZnGof2qpjK+xAIC5+NjuEkjCnIsB/2qAzgaQX7WNM4zaTj/HsZthNmPdEOYAeh9aTcQx69jSaakOQroWcCiRnKeKBugjeEWXlbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762431306; c=relaxed/simple;
	bh=eesYonv8VDWpDiw9NEHAmnwjEfPu25SCd58POVgRTe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sryQJy0UqC/oQBNwjKna6I57vibNKXJ9ZjLsZiiwBSyQLKYND7mcekD9tLyzhHik0tBY6Z2wkS4UU9pxsbZaMCpWnLgriYW/knnl7ibwcnPiuEOl2A5o2G5BUbblduGATfsAzJQCHHAo9nf9kB689TOKvSqQk7SAiidKDuAsw1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tnWSirdF; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762431301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eesYonv8VDWpDiw9NEHAmnwjEfPu25SCd58POVgRTe4=;
	b=tnWSirdFFSVXM/0R3H3QU2mNgbWL80tcOOVOs8i481KTTl14rVX3G6d67N2+maOdHGRIIx
	bxVqPvb1fPzBnZjlNde5Sr8T1phS2vyLE/mnE9B+pKq/U0EhlbG+YQAk5hvmlQIiu9/B7l
	BXPCfJ1/R/BxJgace2+tqyfM5djOovU=
From: Menglong Dong <menglong.dong@linux.dev>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Menglong Dong <menglong8.dong@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Matt Bobrowski <mattbobrowski@google.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Leon Hwang <leon.hwang@linux.dev>, jiang.biao@linux.dev,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Subject:
 Re: [PATCH bpf-next v3 4/7] bpf,x86: add tracing session supporting for
 x86_64
Date: Thu, 06 Nov 2025 20:14:46 +0800
Message-ID: <3660175.iIbC2pHGDl@7950hx>
In-Reply-To:
 <CAADnVQ+ZuQS_RSFL8ThrDkZwSygX2Rx49LBAcMpiv3y4nnYunQ@mail.gmail.com>
References:
 <20251026030143.23807-1-dongml2@chinatelecom.cn>
 <CAEf4BzZcrWCyC3DhNoefJsWNUhE46_yu0d3XyJZttQ8sRRpyag@mail.gmail.com>
 <CAADnVQ+ZuQS_RSFL8ThrDkZwSygX2Rx49LBAcMpiv3y4nnYunQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/11/6 06:00, Alexei Starovoitov wrote:
> On Wed, Nov 5, 2025 at 9:30=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, Nov 4, 2025 at 6:43=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Tue, Nov 4, 2025 at 4:40=E2=80=AFPM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
[......]
> > >
> > > Instead of all that I have a different suggestion...
> > >
> > > how about we introduce this "session" attach type,
> > > but won't mess with trampoline and whole new session->nr_links.
> > > Instead the same prog can be added to 'fentry' list
> > > and 'fexit' list.
> > > We lose the ability to skip fexit, but I'm still not convinced
> > > it's necessary.
> > > The biggest benefit is that it will work for existing JITs and trampo=
lines.
> > > No new complex asm will be necessary.
> > > As far as writable session_cookie ...
> > > let's add another 8 byte space to bpf_tramp_run_ctx
> > > and only allow single 'fsession' prog for a given kernel function.
> > > Again to avoid changing all trampolines.
> > > This way the feature can be implemented purely in C and no arch
> > > specific changes.
> > > It's more limited, but doesn't sound that the use case for multiple
> > > fsession-s exist. All this is on/off tracing. Not something
> > > that will be attached 24/7.
> >
> > I'd rather not have a feature at all, than have a feature that might
> > or might not work depending on circumstances I don't control. If
> > someone happens to be using fsession program on the same kernel
> > function I happen to be tracing (e.g., with retsnoop), random failure
> > to attach would be maddening to debug.
>=20
> fentry won't conflict with fsession. I'm proposing
> the limit of fsession-s to 1. Due to stack usage there gotta be

I think Andrii means that the problem is the limiting the fsession to
1, which can make we attach fail if someone else has already attach
it.

If we want to limit the stack usage, I think what we should limit is
the count of the fsession progs that use session cookie, rather the
count of the fsessions.

I understand your idea that add the prog to both fentry and fexit list
instead of introducing a BPF_TRAMP_SESSION in the progs_hlist.
However, we still have to modify the arch stuff, as we need to store the
"bpf_fsession_return". What's more, it's a little complex to add a prog
to both fentry and fexit list, as bpf_tramp_link doesn't support such
operation.

So I think it's more clear to keep current logic. As Andrii suggested,
we can reuse the nr_args, and no more room will be used on the
stack, except the session cookies.

As for the session cookies, how about we limit its number? For example,
only 4 session cookies are allowed to be used on a target, which
I think should be enough.

I can remove the "fexit skipping" part to make the trampoline simpler
if you prefer, which I'm OK, considering the optimization I'm making
to the origin call in x86_64.

Therefore, the logic won't be complex, just reserve the room for the
session cookies and the call to invoke_bpf().

Thanks!
Menglong Dong

> a limit anyway. I say, 32 is really the max. which is 256 bytes
> for cookies plus all the stack usage for args, nr_args, run_ctx, etc.
> Total of under 512 is ok.
> So tooling would have to deal with the limit regardless.
>=20





