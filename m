Return-Path: <bpf+bounces-48152-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 720CCA04915
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 19:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17DF618869A7
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 18:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926FE1DF25C;
	Tue,  7 Jan 2025 18:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="YLpF1yn6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OHr6NEyP"
X-Original-To: bpf@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CED45027;
	Tue,  7 Jan 2025 18:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736273826; cv=none; b=rAU0LXLGXoc0zqJEWLtap9ckPTCbXnJxWcTAaJxZBt2GrC5aedWA7KnU3O3LJ5yJ78/jWSzZsWwem0MWcTvAYLy2k6ImRADm9xRM55qCfIuNf4yujtom5NbeRQviTgpGSJb262Ey8v4WV8tdVP0dxBJMfomSfJa5449EM8nlKic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736273826; c=relaxed/simple;
	bh=Q4mCkYE5JwAPAUYXO7QAfUyFi16JkVGURfRfI+I+aAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q3Pki4aFYHhT3jmj7qK6AnulX3s5yeng0PgZwFxZt75qfatXbFx/aAB74lvcjnqFlcMP7CQKTRMYyYBPEVh7Did+FNqJ92TnF8ubtJlsmlyVswyeZBtQRjekv7dhA+k/plFborQ83jz1236RrUPhgujbqyY5hd17fhViLIgLdEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=YLpF1yn6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OHr6NEyP; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 9902D1140125;
	Tue,  7 Jan 2025 13:17:02 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 07 Jan 2025 13:17:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1736273822;
	 x=1736360222; bh=GVx5k9zZupmiFbgmpI+fhjmeMdA10WmZjrl3xNiIxbk=; b=
	YLpF1yn66x1Mg6OicLXhbsPNIRQ7SDtT/ruLin4vwrAeTmC3IGJbQH8lRnNfCuNe
	+ZLYJ9Wifo8BwHCe12wj6uUvLqgwmG3LbvIK5tCwdQoBFFVw8ujoq6iEjkL+9g7h
	QHx+INLevpkJmTMdtFoxl6y6kOFvqvlzz9Ue3fevhMx5IX2UiNnYNla+EPtaLI23
	KTZyqrkyGKjoJix47U7YjHA6W/fdY8cLdIOVHQCXN/r2uDB+W65iMdOcm2+UEwR4
	QQ4+K3dz9w7Oi/gEC9x/vIc9xo6FAM4/aWdYmtOXOaEOvb4n/DI1/TffJW8qPD8+
	ltdBIl64B+bOnflyLbJMZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736273822; x=
	1736360222; bh=GVx5k9zZupmiFbgmpI+fhjmeMdA10WmZjrl3xNiIxbk=; b=O
	Hr6NEyPlkjr7mv7OLEDw1Oec8Pwejg42RFxrpBfvntaPtv2eMMlDEKOh8/8ZUlGY
	nGVPgUpYKdmIsvF9jODOvdvG7oz+zvbYKHDRcFsx4pF7cdsAECiCeOpF/eJLHPFu
	4/rRuvv6ki3UZBrWTBWSVM+DJmtows2boJZ9yZHPgU4wpihXQRG2jf+VMpj5JIJD
	L0F5YVSnJ7/hToXARZRuL77Afe4hYyLyPanp6+gl1vViLm2vmyhYoDW76g+dNokS
	KkMEGlrx/twaaRGfd3BkJ5MQkASYtzx3tNpxMQCOEpJxPQz5ZyQFUd8U8XtO0o6w
	l3VbeFhmp5G7AtP+/nZWQ==
X-ME-Sender: <xms:nW99Z0B2BYiY-t1dfdwxW8l5bSDDE3uEQcN0pbqDy73Up7kuKqsR2w>
    <xme:nW99Z2j1hp1Y6ANVasiQ5ZOEH27g-xMZCsbGHFyJXcuC6TDXSrsaEkeS3kTbORJIP
    qNSqfbRXenMB1xUXg>
X-ME-Received: <xmr:nW99Z3lFMrYBHjZXH2HcRmDwY0MxWE4Jex7bT2cH3xp2ZWNa3eclPMD7scMAKjbVLqTkimt_po3iQR21MVF8v4pkxW8i79dUQFscKctJzcTXFQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegvddguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenfghrlhcuvffnffculdejtddmnecujfgurhepfffhvfevuffk
    fhggtggugfgjsehtkefstddttdejnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguh
    esugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnheptdfgueeuueekieekgfeiueek
    ffelteekkeekgeegffevtddvjeeuheeuueelfeetnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihiidpnhgspghr
    tghpthhtohepudejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlrghorghrrd
    hshhgrohesghhmrghilhdrtghomhdprhgtphhtthhopegrlhgvgigvihdrshhtrghrohhv
    ohhithhovhesghhmrghilhdrtghomhdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepvgguugihiiekjeesghhmrghilhdrtghomhdprhgtphht
    thhopegrshhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhesihhogh
    gvrghrsghogidrnhgvthdprhgtphhtthhopehmrghrthhinhdrlhgruheslhhinhhugidr
    uggvvhdprhgtphhtthhopehsohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephi
    honhhghhhonhhgrdhsohhngheslhhinhhugidruggvvh
X-ME-Proxy: <xmx:nW99Z6y2QfwKNrJ4iZwyz5M7t-tQxtwcW89ulnnos2JX4Bi9tKDNsw>
    <xmx:nW99Z5QT7TzeR-uaYp3NCkg5QKhQjiXAv-csa-64KD9gakgKtgv1QQ>
    <xmx:nW99Z1bq3tXQ4YTUxSjMB6JldNesh7Ojh6DUHGne_pBgfqP4G9ef7A>
    <xmx:nW99ZyScWGTO8SQwIYBowp8GSnXon6rMJClemguyFEMU7GscBbCqiA>
    <xmx:nm99Z_F0Jf0WV-wWvNMh7zo1jAvy8d-oMiqWxcnk2YJ7P1H1mB3hgfwF>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jan 2025 13:16:59 -0500 (EST)
Date: Tue, 7 Jan 2025 11:16:58 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eddy Z <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>
Subject: Re: [RFC PATCH bpf-next 1/2] libbpf: Add support for dynamic
 tracepoint
Message-ID: <lvmetlwqho4pinf5ehoyxbvcwsfgno54vnnuj2jzaitllgft5e@kqu4cgfwjghn>
References: <20250105124403.991-1-laoar.shao@gmail.com>
 <20250105124403.991-2-laoar.shao@gmail.com>
 <CAADnVQ+ga1ir9XCDxPiU_-eYzKHTQsiod9Sz4_o3XeqGW2rq4A@mail.gmail.com>
 <CALOAHbD+w3niwBojP=-81Wrqj1V9ppLgTfuZjb=AxXjx51MGRA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbD+w3niwBojP=-81Wrqj1V9ppLgTfuZjb=AxXjx51MGRA@mail.gmail.com>

Hi Yafang,

On Mon, Jan 06, 2025 at 10:32:15AM +0800, Yafang Shao wrote:
> On Mon, Jan 6, 2025 at 8:16 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Sun, Jan 5, 2025 at 4:44 AM Yafang Shao <laoar.shao@gmail.com> wrote:
> > >
> > > Dynamic tracepoints can be created using debugfs. For example:
> > >
> > >    echo 'p:myprobe kernel_clone args' >> /sys/kernel/debug/tracing/kprobe_events
> > >
> > > This command creates a new tracepoint under debugfs:
> > >
> > >   $ ls /sys/kernel/debug/tracing/events/kprobes/myprobe/
> > >   enable  filter  format  hist  id  trigger
> > >
> > > Although this dynamic tracepoint appears as a tracepoint, it is internally
> > > implemented as a kprobe. However, it must be attached as a tracepoint to
> > > function correctly in certain contexts.
> >
> > Nack.
> > There are multiple mechanisms to create kprobe/tp via text interfaces.
> > We're not going to mix them with the programmatic libbpf api.
> 
> It appears that bpftrace still lacks support for adding a kprobe/tp
> and then attaching to it directly. Is that correct?
> What do you think about introducing this mechanism into bpftrace? With
> such a feature, we could easily attach to inlined kernel functions
> using bpftrace.

Is the idea to have some other application create dynamic tracepoints
based on kernel debuginfo?

FWIW bpftrace has some initial support for probing inlined kernel
functions w/ DWARF. I don't believe it's enabled by default yet, though
- there's a few limitations. I'll comment in thread below with more
details.

Thanks,
Daniel

