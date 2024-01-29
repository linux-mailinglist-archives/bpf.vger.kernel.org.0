Return-Path: <bpf+bounces-20609-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFB6840B05
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 17:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CD7628D453
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 16:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4A9155A31;
	Mon, 29 Jan 2024 16:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="VOm+VMpz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yb9+nKKm"
X-Original-To: bpf@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F8D155A22;
	Mon, 29 Jan 2024 16:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706544799; cv=none; b=RTi38lYErZum4Cxmvr6jzas6OhSIbpqO4tO3zgtjJ5W6V2UPMd6E1LdBCFxhoBVqQe9bZ4nfMZg3z7aqJFkXarPWsIUkhjVf7EHzaZYV2g//K+Y32eQClJ1V9gTpiPOWpigrrQKbuTUOD4dCNHmheikZHLo2b7Bf9lSfyrzYrdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706544799; c=relaxed/simple;
	bh=U5knNVeSUC02Kp52IYtCJFDsNCRfi5Zfl/yaznZobHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EniYrJKwrSJHV/07F5bkY1c/YPly0d22vzfV2g6BqcDMqXJTVnpLafq4sr4JtE+LRHiiwfcNmBfc5bYvHGneKHlP6B7j7Ta0YuVCwDha3GzNiXBHz7rlxB6zD6651I4dVHoyBq812nLydTtA2LTP3rdhDiAKdLeEQX8W/9el0WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=VOm+VMpz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yb9+nKKm; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 83E815C015C;
	Mon, 29 Jan 2024 11:13:16 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 29 Jan 2024 11:13:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1706544796; x=1706631196; bh=NWhpZ4Anx6
	A8C8PAGZ4L9Hr5r5a+wvYAeeIbNmcd0qU=; b=VOm+VMpzkv3+IsNZJ4sSO3Rhkm
	1+Se7H6xOwopyi+D+1iV2XGPZNUXXk2219B5xWo8eRFBD0jEfx/w+xXYlRBp7sHw
	HPA/Nbyfr80uufvyxzxpihct1FuYHvf6jz9PILZvgHDOMKj2Yt/OsDwJE6sct6NN
	no3YxTYXrL8z0z2C9Hb3se69ZWKg6VduZsQgKD2HXmz2yeTJnwqn6uwv5T3JyvnX
	FFzMVIbsTR4d3y9wS0YSYQH5lfdhgpoUQb9Vc8l0sqCyuocygVZHoZGp8JN01R1p
	USaxulmlmJ9f6TZ72iWh5C+jUcWB9DqNjU9QX6LmUBzb6rsdUo5fe/JhDo8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706544796; x=1706631196; bh=NWhpZ4Anx6A8C8PAGZ4L9Hr5r5a+
	wvYAeeIbNmcd0qU=; b=yb9+nKKmeF6edNDEM1qJkq8963omb38gnHL78bXBIEgJ
	mkzw3Hcu5Uq0tFTI4c5f0P7/iPZnZRrr6niOi7Au+80HNFi7MVBg0RkQ59cscuVx
	YGi7tsjXOUVlL/2c76E06Og6kWLeR7mN3SEutmJpG452DgD+Aiy3ggvSyQu7kExD
	gPTgk56208mjASRYNmmpg4FF1QwcygRQSdaHGBx4ti2DAnLPcKw3IsYd0GB3h2AA
	Nmaq/Jvou7wny6YubLw8dKkRpGfzhcRpnwhwZebVPVQxkyDkPkHWy6481WcY3K83
	WghA6RY9gaFz7c1d03lKcbWZ1BrPBbRwUUQSTz7oIA==
X-ME-Sender: <xms:nM63ZTAPoFX3KNffT1rBQ3rx_K3AD6BBPKK508KUr0OHFxySHAGTQA>
    <xme:nM63ZZizASsqB3pGgiMra1uurC9WOcN5ygDyO_Z7Kx8TtLZhCWUhMz0QeXj9ZlUj0
    aBahjpvdXRfBC5Fxw>
X-ME-Received: <xmr:nM63ZelflC7YE6_uhoOjA22N6xiwymfb2EgcdG1Grt9XYuSvaaRu4Hx-Y6w0qOsKWqArwaCI7V9lRJuXkiD6hERdDayzrylhq9Mh58Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtgedgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdljedtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdfstddt
    tddvnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqne
    cuggftrfgrthhtvghrnhepvdefkeetuddufeeigedtheefffekuedukeehudffudfffffg
    geeitdetgfdvhfdvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:nM63ZVyYB-Grv--dv8mYLQrpsJULhNM6ywbwmXama-kK9jn1cvPbBg>
    <xmx:nM63ZYRLMhw5PJmUgH1X9qOfKiF7uOi04LAm0aIx-YYAUzxRKlq6Hw>
    <xmx:nM63ZYZb2ccjU8IwfwIxUnY-0L3SaROyc9mf9fOK99k_ZwEp9RgGcw>
    <xmx:nM63ZRAEp0tooN094oLEfrN1wuFgTtfBiSikXjMDlxz33Ogid7uyQw>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jan 2024 11:13:14 -0500 (EST)
Date: Mon, 29 Jan 2024 09:13:13 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: quentin@isovalent.com, daniel@iogearbox.net, ast@kernel.org, 
	andrii@kernel.org, alexei.starovoitov@gmail.com, alan.maguire@oracle.com, 
	memxor@gmail.com, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpftool: Support dumping kfunc prototypes from
 BTF
Message-ID: <spuzs32tv6v5czb76gstpvisv2xkfzz2scqw4hmqncflhxoj66@hie6m7pctfdo>
References: <373d86f4c26c0ebf5046b6627c8988fa75ea7a1d.1706492080.git.dxu@dxuuu.xyz>
 <ZbeV5adWhiNZu5xj@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbeV5adWhiNZu5xj@krava>

Hi Jiri,

On Mon, Jan 29, 2024 at 01:11:17PM +0100, Jiri Olsa wrote:
> On Sun, Jan 28, 2024 at 06:35:33PM -0700, Daniel Xu wrote:
> > This patch enables dumping kfunc prototypes from bpftool. This is useful
> > b/c with this patch, end users will no longer have to manually define
> > kfunc prototypes. For the kernel tree, this also means we can drop
> > kfunc prototypes from:
> > 
> >         tools/testing/selftests/bpf/bpf_kfuncs.h
> >         tools/testing/selftests/bpf/bpf_experimental.h
> > 
> > Example usage:
> > 
> >         $ make PAHOLE=/home/dxu/dev/pahole/build/pahole -j30 vmlinux
> > 
> >         $ ./tools/bpf/bpftool/bpftool btf dump file ./vmlinux format c | rg "__ksym;" | head -3
> >         extern void cgroup_rstat_updated(struct cgroup * cgrp, int cpu) __ksym;
> >         extern void cgroup_rstat_flush(struct cgroup * cgrp) __ksym;
> >         extern struct bpf_key * bpf_lookup_user_key(u32 serial, u64 flags) __ksym;
> 
> hi,
> I'm getting following declaration for bpf_rbtree_add_impl:
> 
> 	extern int bpf_rbtree_add_impl(struct bpf_rb_root * root, struct bpf_rb_node * node, bool (struct bpf_rb_node *, const struct bpf_rb_node *)* less, void * meta__ign, u64 off) __ksym; 
> 
> and it fails to compile with:
> 
> 	In file included from skeleton/pid_iter.bpf.c:3:
> 	./vmlinux.h:164511:141: error: expected ')'
> 	 164511 | extern int bpf_rbtree_add_impl(struct bpf_rb_root * root, struct bpf_rb_node * node, bool (struct bpf_rb_node *, const struct bpf_rb_node *)* less, void * meta__ign, u64 off) __ksym;
> 		|                                                                                                                                             ^
> 	./vmlinux.h:164511:31: note: to match this '('
> 	 164511 | extern int bpf_rbtree_add_impl(struct bpf_rb_root * root, struct bpf_rb_node * node, bool (struct bpf_rb_node *, const struct bpf_rb_node *)* less, void * meta__ign, u64 off) __ksym;
> 
> looks like the btf_dumper_type_only won't dump function pointer argument
> properly.. I guess we should fix that, but looking at the other stuff in
> vmlinux.h like *_ops struct we can print function pointers properly, so
> perhaps another way around is to use btf_dumper interface instead

Ah, crap, looks like between all the branch switching I didn't build
vmlinux with kfunc annotations. Having fixed that, I can repro this
build failure.

I'll take a look and see what the best way to fix this is.

Given that end to end the whole flow basically works, should we start
working on merging patches?

Thanks,
Daniel

[..]

