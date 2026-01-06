Return-Path: <bpf+bounces-77932-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C8172CF6FC3
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 08:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 46C123019364
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 07:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD242594B9;
	Tue,  6 Jan 2026 07:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cc49FAWw"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14695309DDD
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 07:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767683475; cv=none; b=pfqz6v+lL8S+zq6A4GZXZGl55PO/NMY96k5+AfofVdzKnIwTDgVgIC8FWNc4ypiGLmeKHrKGbFi5g0FWjLwZE6YI5dqdKkORhuiMYYDH6URUbVXl6Q4AdAbembDe6fkGIYFbXS+ziYDP7z6LIfa9qWFfleW3trANFhEpMRvNV9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767683475; c=relaxed/simple;
	bh=jgYT2i2P8pq8bGbZujUvHKcViMZU3Be7fZYMxAfYbXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pg/y5xEIAXZ9LHaeMN10Leu4fuAUvDyXHOWlBQumVrnqxb+Wi8YEEGZ2Lq/NsO4yQQ3SqnsG2Wp4UXWadhTAQCnM463NOKz4YJpIQmAeVc8bNwzJ7ROJuUpoiNoOXrgGzs1OtPTW0xVE727ctEZWjg6wgBIHXphQ5AayNx7MOX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cc49FAWw; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767683470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=28Qq+QjhKkT5nfjUH+D1PH1rbkZ7V1ioFFTYQ1iPwgU=;
	b=cc49FAWwNKaH2uW4saGfL4zWbZkhA4871Jj8iwYrE0p4jq7BeF6Hdrjgojul0PLWXfJRxB
	JGGL2hrRJQ01UEGGLE1vEPig3cBLMHKgOQK5dDrEoYMxqMhJ4jxyY/iTcshI0cHqVrg62b
	a2w6WpVM38VJLv5Y7iW+B8jFz7ilgoo=
From: Menglong Dong <menglong.dong@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Menglong Dong <menglong8.dong@gmail.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
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
Subject: Re: [PATCH bpf-next v6 00/10] bpf: fsession support
Date: Tue, 06 Jan 2026 15:10:53 +0800
Message-ID: <8625659.T7Z3S40VBb@7940hx>
In-Reply-To:
 <CAADnVQ+EzgMEXAN9oJ8asRj_WYOZh2VQOKDJz8mhkqehr7f=3g@mail.gmail.com>
References:
 <20260104122814.183732-1-dongml2@chinatelecom.cn> <3389151.aeNJFYEL58@7940hx>
 <CAADnVQ+EzgMEXAN9oJ8asRj_WYOZh2VQOKDJz8mhkqehr7f=3g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/1/6 12:20 Alexei Starovoitov <alexei.starovoitov@gmail.com> write:
> On Mon, Jan 5, 2026 at 7:05=E2=80=AFPM Menglong Dong <menglong.dong@linux=
=2Edev> wrote:
> >
> > On 2026/1/6 05:20 Andrii Nakryiko <andrii.nakryiko@gmail.com> write:
> > > On Sun, Jan 4, 2026 at 4:28=E2=80=AFAM Menglong Dong <menglong8.dong@=
gmail.com> wrote:
> > > >
> > > > Hi, all.
> > > >
> > [......]
> > > > Maybe it's possible to reuse the existing bpf_session_cookie() and
> > > > bpf_session_is_return(). First, we move the nr_regs from stack to s=
truct
> > > > bpf_tramp_run_ctx, as Andrii suggested before. Then, we define the =
session
> > > > cookies as flexible array in bpf_tramp_run_ctx like this:
> > > >     struct bpf_tramp_run_ctx {
> > > >         struct bpf_run_ctx run_ctx;
> > > >         u64 bpf_cookie;
> > > >         struct bpf_run_ctx *saved_run_ctx;
> > > >         u64 func_meta; /* nr_args, cookie_index, etc */
> > > >         u64 fsession_cookies[];
> > > >     };
> > > >
> > > > The problem of this approach is that we can't inlined the bpf helper
> > > > anymore, such as get_func_arg, get_func_ret, get_func_arg_cnt, etc,=
 as
> > > > we can't use the "current" in BPF assembly.
> > > >
> > >
> > > We can, as Alexei suggested on your other patch set. Is this still a
> > > valid concern?
> >
> > Yeah, with the support of BPF_MOV64_PERCPU_REG, it's much easier
> > now.
> >
> > So what approach should I use now? Change the prototype of
> > bpf_session_is_return/bpf_session_cookie, as Alexei suggested, or
> > use the approach here? I think both works, and I'm a little torn
> > now. Any suggestions?
>=20
> I think adding 'void *ctx' to existing kfuncs makes tramp-based
> kfuncs faster, since less work needs to be done to store/read
> the same data from run_ctx/current.
> So that's my preference.

Okay, I'll implement it this way in the next version.

Thanks!
Menglong Dong





