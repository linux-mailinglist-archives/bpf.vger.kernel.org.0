Return-Path: <bpf+bounces-47712-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE719FEB35
	for <lists+bpf@lfdr.de>; Mon, 30 Dec 2024 22:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD055188315D
	for <lists+bpf@lfdr.de>; Mon, 30 Dec 2024 21:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2867519CCEA;
	Mon, 30 Dec 2024 21:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="LqShUXhT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wTCgSQmy"
X-Original-To: bpf@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0586C19CC3A
	for <bpf@vger.kernel.org>; Mon, 30 Dec 2024 21:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735595862; cv=none; b=ij3i2jwuGVH9gWOpN7mgpbBo+nm08Pwwp0q3zKG+ODlZX65ZTPolaru0E7wackPDhgg/XOC64AwfwRiphICIwnwuXAI47K0tXnq68wVvgwSih1Hna1atvjYnABA7FdmpGsBxerCquJk6+hI6gWwcLg2bnAvkuJPwB5DBdh+RABI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735595862; c=relaxed/simple;
	bh=CbyDHRCD1VSNFS7Ju0wJz9GOBDfkZFx8uy8c4UxVhaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DlR8huJHcSvVXC9JtYOQ8Yn2c5fStCs9XLtpunm014fnpXeAJyZiLQaDKGKStVFHzGVDNDbgiyybrIqiSpsyG8YS35MZ+09KAPSfZVHEKkBUBYLcyrM54caFyQIWfUYP+ED6UdE58OjGMxLepopYzKYhh6ZvoHvTptFLgNu0ai0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=LqShUXhT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wTCgSQmy; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 0DC2013801F5;
	Mon, 30 Dec 2024 16:57:40 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 30 Dec 2024 16:57:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1735595860;
	 x=1735682260; bh=GdZGQ5x4zqmU0COVIDT1K5G904zj8BBWWBBn4LB1b9o=; b=
	LqShUXhTH9Xj7IiLMxBSvVTancV0jee5oXGStbzY2VshnrYonsktMEFtaKIt60la
	6Dv9DmxLuVTg425rETYwdzh54MpwBWNIHaDtx0mx38M4dTJpfQmyUh+96OieDYpi
	h8wi3rBG6mWv8gER7bBsb90cdYwyGd5H3uEnAmcsgI98STaGrXT27h9br5SYmCEj
	pNBJDTI/PL2KD24zfdsmPDSlchXquC27NJLUOAch2PG5blQKXnQ4HjvVaOmWAAAT
	cGXpme3k810XO8AZB8oPnFUjfCpbAk1dl72fJ0IHCEzb+BA1Qkzith/V5WFDwwx+
	Z6pScjsdrugvf9e7Zvxs4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735595860; x=
	1735682260; bh=GdZGQ5x4zqmU0COVIDT1K5G904zj8BBWWBBn4LB1b9o=; b=w
	TCgSQmyS+H9n9teDjqKixmVVSMuOkyH6BPX0cKkj4++TZ1ojXJqYN4PTSEHBqq/d
	4CA8DFH01lFKm7BU0jk/7yfcAGC8iFgpB3L8833fejUQBs+yvpw5lGLtslKxf/ra
	gmm0m6PjESX1AgsJlC6MXpWQ0ByNtOS4wb29+JIVPPuCFVYRP+U788QaAAVQfedi
	xEM05+LGN+CRJG7FHd3fGhURhc911o6h4KqTlNnFou8UQWzrMokjDhavCL5JmmnP
	Rw8T4Uc0Wont0Rv1QHSzGW87Xsk/uugnDg9fKyq0pNvgdwPIBpPgp0qKBG0pUGj+
	jHEvyJVCLOfn6ebXJarDQ==
X-ME-Sender: <xms:UxdzZzF8-0ybtsTCLAXyICN50foMzINA23jBSXAcA0XoMGJio3-ANg>
    <xme:UxdzZwUDyvujVMu_mV1gPKaVDe6JN7scQ1mBtEQ2AxgOMu6o9TNiMzASgf3bIYW7R
    bb9HmADKW0ZdjAGOg>
X-ME-Received: <xmr:UxdzZ1IftsngAAK78i0OUYuT3tmQCH2DyRuKdK87cnt4o7SPAoBnN-pVSad24OIfenTsgzJVPoQYlHVJQE_NKdJ5xGKvwynTKqR9uL2D2Ik9lA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddviedgudehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenfghrlhcuvffnffculdejtddmnecujfgurhepfffhvfevuffk
    fhggtggugfgjsehtkefstddttdejnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguh
    esugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnheptdfgueeuueekieekgfeiueek
    ffelteekkeekgeegffevtddvjeeuheeuueelfeetnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihiidpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghlvgigvghird
    hsthgrrhhovhhoihhtohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghpfhesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhlshgrsehkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:UxdzZxFuKsNvpcGlEBikeEsCUW523EVG1tyh8bRqMSEes9xuVcYYLg>
    <xmx:UxdzZ5Xn46mhJe91izG7fgDenVTRNMTjp1cA3EQFXghwMkQJDHFUPQ>
    <xmx:UxdzZ8MUXEz-t-o74-Gnt9GtPALp1NW2pT5NCEueXBJnVrW9iObEPA>
    <xmx:UxdzZ42aPe5fkgGn4__5q-_NttKpvE8RWk8BckOdzPGPLHwePSjOuw>
    <xmx:VBdzZ8QvmwuVSzVrgFKrM_HskyPIZt11XhLtjdWhqVRR3Pvh_ej3ui3K>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Dec 2024 16:57:39 -0500 (EST)
Date: Mon, 30 Dec 2024 14:57:37 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>
Subject: Re: d_path() truncates at front of path?
Message-ID: <ckti37h2n255zvavctgr56ant2qry66s4gsg5etxkx6rnakb4y@jd42efjvahmr>
References: <pv3zr55lja6lumu7iilsdtbujd6yq6qxsrxssifeqh6tmcmzii@5kkyaajllr65>
 <CAADnVQJra9fJ5v4oB2zkfoqnk25w0u-gfC-0yesx0ZNP-BXyjA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJra9fJ5v4oB2zkfoqnk25w0u-gfC-0yesx0ZNP-BXyjA@mail.gmail.com>

On Mon, Dec 30, 2024 at 12:49:45PM -0800, Alexei Starovoitov wrote:
> On Mon, Dec 30, 2024 at 12:46 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> >
> > Hi,
> >
> > I was poking around bpftrace test suite and noticed that our d_path()
> > wrapper is truncating at the beginning of the path. See [0] for an
> > example.
> >
> > bpftrace codegen doesn't do anything fancy here. And I see in the kernel
> > d_path() implementation there's some prepend logic going on.
> >
> > I wanted to confirm this is the expected behavior. And if so, whether it
> > should be documented.
> 
> This is expected behavior when the buffer is too small.
> bpftrace may react to the -ENAMETOOLONG error code in such a case.

Got it, thanks. I've sent a patch to document this in uapi/bpf.h. Seems
like a good thing to do.

