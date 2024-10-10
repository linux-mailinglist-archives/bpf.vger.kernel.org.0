Return-Path: <bpf+bounces-41509-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6E49979A4
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 02:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9776285084
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 00:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFAE11712;
	Thu, 10 Oct 2024 00:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XOtR3avt"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E924C144;
	Thu, 10 Oct 2024 00:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728520414; cv=none; b=ZcGwN0Erd1qvB7rsPqkIOJ8D8x0PPJ336Xghrs9ZkYxQRVsyACYdz8hiNk5gFSu6OW2CZ8PTcccLPAK9XEA2JoDyP1QTe/KQb7b49o3Ws9NrSaFy2KOiK7ISxjo3BxoUm9Rn/DFiHam1v7djrdfkS7turJ3I3zLoyiE08uttqh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728520414; c=relaxed/simple;
	bh=IqcTrKiwdbZHhepDa3OiHZSbNeCni10R4bqSzlR+NCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jrfzjh6sBN+/SmArSrQOH3/XTI8hAimGLT9Hku/zpVEiKrgwvNEAl1mSaYW1dWTto81c8AXJY0WjyxeTsiGxogtbILpA5No0HxWHQQ6HJjL3d4PrtcSiAC7IzJE9deFAvu6SU1Pccr0jOJrLH95wp9jR1A2i/U3/e54L/k8uNL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XOtR3avt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A59D9C4CEC3;
	Thu, 10 Oct 2024 00:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728520413;
	bh=IqcTrKiwdbZHhepDa3OiHZSbNeCni10R4bqSzlR+NCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XOtR3avtr5Y27qwqeQNHH1lyP1O1eKGCqx44DvflLLWrh8Og1bdpvmD3/v1kSFNXT
	 xOJHsMx2HpSrUCtwmbtY5wZEUWjmtlhYFcEqBbbOsppeJ5oSkIhUOSayHjEnSTjyip
	 y62h7aNdhvNqRuJeVvSNcIvTHnAhnsLUWCsJLMMi8OcKACLDy09hzY0UKuLMY6Sf6V
	 CIDR5lU+R31E/Sui7GYUhSeYnhpioMKepLa2RRcyh4quLAAAWjmYPLqiTzWoa7gLgj
	 FVpXYVPGLL+uIQDUbfSSc1GRIZO9Uh01dTCQR7z4n+3DchoQwtkJ0x+Sd7oQTPnhrc
	 v+XOs0RRJTK7Q==
Date: Wed, 9 Oct 2024 17:33:31 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Juri Lelli <juri.lelli@redhat.com>, bpf <bpf@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"Jose E. Marchesi" <jose.marchesi@oracle.com>
Subject: Re: NULL pointer deref when running BPF monitor program (6.11.0-rc1)
Message-ID: <20241010003331.gsanhvqyl5g2kgiq@treble.attlocal.net>
References: <CAADnVQL2ChR5hGAXoV11QdMjN2WwHTLizfiAjRQfz3ekoj2iqg@mail.gmail.com>
 <20240816101031.6dd1361b@rorschach.local.home>
 <Zr-ho0ncAk__sZiX@krava>
 <20240816153040.14d36c77@rorschach.local.home>
 <ZsMwyO1Tv6BsOyc-@krava>
 <20240819113747.31d1ae79@gandalf.local.home>
 <ZsRtOzhicxAhkmoN@krava>
 <20240820110507.2ba3d541@gandalf.local.home>
 <Zv11JnaQIlV8BCnB@krava>
 <Zwbqhkd2Hneftw5F@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zwbqhkd2Hneftw5F@krava>

On Wed, Oct 09, 2024 at 10:41:42PM +0200, Jiri Olsa wrote:
> > AFAICS we'd need to do roughly:
> >   - for each tracepoint we'd need to interpret one of the functions
> >     where TP_fast_assign macro gets unwinded:
> >       perf_trace_##call
> >       trace_custom_event_raw_event_##call
> >       trace_event_raw_event_##call
> >   - we can't tell at this point which argument is kernel object,
> >     so we'd need to check all arguments (assuming we can get their count)
> >   - store argument info (if it has null check) into some elf tables and
> >     use those later in bpf verifier
> >   - it's all arch specific 
> > 
> > on first look it seems hard and fragile (given it's arch specific)
> > but I might be easily wrong with above.. do you have an idea on how
> > this could work?
> 
> Hi Josh,
> we'd like to have information on which of tracepoint's arguments can be NULL
> 
> Steven had an idea that objtool could help with that by doing something like
> what's described above.. would you have any thoughts on that?

Objtool doesn't know anything about function arguments, I'm not sure how
this could be done unless I'm missing something.

-- 
Josh

