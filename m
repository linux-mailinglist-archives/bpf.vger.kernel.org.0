Return-Path: <bpf+bounces-33733-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29529925513
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 10:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 914EDB23C96
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 08:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFB8139D0B;
	Wed,  3 Jul 2024 08:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VPCCPUuQ"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7982C8F58;
	Wed,  3 Jul 2024 08:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719994251; cv=none; b=bKoZeKMyVDgRjm5pLDaZBntvPapEDa+PoeckeWVRKGf2hxRTDT0YNjfD+1abgNVHDNKDBzGzyAfDYGvW1ZvY/Kd9+838OCGSsDF68dCt5GqQB2lE8W3NM7tZ6zgT1BmtmbMM8g/FqMrcRC6In9gfwu8T/AlKjtx4QvfH1iEGga8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719994251; c=relaxed/simple;
	bh=M+8DrNcesZ019u8maJwbIQTuAbs1U2yIQw5kRA3Yuww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dHpejCR2tLEctdkkI57GRJp8TGfuXFMb98YD/NfW1syj9WFwQ3AJgFPrZgQQlwKJAPLxMPon0774tGaV6R+ZQ44WbOlOjNtPIhmptF4rm6gG8fw/oyN+N5DTZatxLvfSQh1QyUPxJikGCL+8hUEXSUeYknOMlhH6vlHgS9RhDVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VPCCPUuQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=b8Hsbgm7GAtb3moCzprHJ3ekbcDTBXh/r8LHcSbPqk0=; b=VPCCPUuQr1hhEMSZrVpMM1kjuS
	IKrd3BCqKQbkl0jaD4YPxC3CTt2zDKOFBBcxdhi09cmcFd8NAs/Q9C3YK75QEN/bvTueAVSw3d95L
	BsuY13JOvHrj9SDN1LHR6Wfs217L7BYagJuYo+934far6KWY4l1Dkk/7uWo847KhSzHAUmyhtH0pY
	I4z3TRdRKmYjo/9BgruLyaI2gh6DFXJ1WSbUPZTVBWwOafLceFj2XCb7Mbi/CAgo52oBfccNEP5zt
	4MwQeEnPGOcwttnGlsLeAecwBdDXtevlAxvXOkyI5MND+aBh3UxnK/6VSOm8mHMChh26zuvNBmKwp
	Utj1cksQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOv4c-00000001cUE-3dMU;
	Wed, 03 Jul 2024 08:10:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8010B3006B7; Wed,  3 Jul 2024 10:10:42 +0200 (CEST)
Date: Wed, 3 Jul 2024 10:10:42 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv2 bpf-next 1/9] uprobe: Add support for session consumer
Message-ID: <20240703081042.GM11386@noisy.programming.kicks-ass.net>
References: <20240701164115.723677-1-jolsa@kernel.org>
 <20240701164115.723677-2-jolsa@kernel.org>
 <CAEf4BzZaTNTDauJYaES-q40UpvcjNyDSfSnuU+DkSuAPSuZ8Qw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZaTNTDauJYaES-q40UpvcjNyDSfSnuU+DkSuAPSuZ8Qw@mail.gmail.com>

On Tue, Jul 02, 2024 at 01:51:28PM -0700, Andrii Nakryiko wrote:
> > +static size_t ri_size(int sessions_cnt)
> > +{
> > +       struct return_instance *ri __maybe_unused;
> > +
> > +       return sizeof(*ri) + sessions_cnt * sizeof(ri->sessions[0]);
> 
> just use struct_size()?

Yeah, lets not. This is readable, struct_size() is not.

