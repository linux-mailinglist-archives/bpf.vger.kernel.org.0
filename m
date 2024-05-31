Return-Path: <bpf+bounces-31013-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 136918D5FF2
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 12:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9978BB2514C
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 10:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44011156644;
	Fri, 31 May 2024 10:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hDklwUDD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6J9SuS3u"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9A115099E
	for <bpf@vger.kernel.org>; Fri, 31 May 2024 10:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717152567; cv=none; b=cTQfGp+yHrL8P8o0FR+DM55waGfBZ0s7pjocmhm1w0wySkApS5JO4kInFg+HR/+NljOEbQct8LkePP38DJzrewP5DekCbmo0H246pWqckISUoE2DNC0s6kXydpX7cZAqAZc8plB+NayfKLVMltNoRNquedS73erMqPJDOkZ9mqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717152567; c=relaxed/simple;
	bh=WJsmCx353XKxalp0ioVF0SKEjMEcSMn4X07U6KlMUrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LLr4I4Gh7nOwh3MFji8utYlRWrz3v3Z13e8P8iH6hNfYj6RePg9526hb7thyLL9J87y4BtPGM9e1TPZmc9MVjk7y+GAVt4QSNhY3fQOTvsE8h/x8ir0Fv9gxpqs1v9zB/RK+t0mcBBXBpucbBcDjviSi031yQjNKVfz6u4BTpAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hDklwUDD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6J9SuS3u; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 31 May 2024 12:49:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717152564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eAWzVImc7Mg3l+3s35u3xT2ggoEPw/Qf+XDe+wYQepg=;
	b=hDklwUDDp2qSgQQ+oDlCe5qGDhO5f1SR/+etbKntr8hxfwWXSawU/Bcc0mSYEiDrdU32gd
	3K5wxuqraBcZeCzIwhFA/kOBLN+Szt97PIN20xGQYrqSVyrdoIB2JaS7SG+W6Va0gjnbuV
	V4GSWjxGvCLADLAmEIOotST5mqra0PQY3fMZoOBUE4JC8Oj5Bv1SvbeZ67xrVZeLThdBJm
	7jRLDi/ZbsihDZtqquzLAHAqXF4MjmttflSiPG28aEvCRACCy3X1EOdRoflo9ZU2B0AVoO
	GkXzddznPrSqJTdqd44F8Ncvx8VHnMz6BfcQ8PTrr/c67/UmmOxCmhoMEz+yWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717152564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eAWzVImc7Mg3l+3s35u3xT2ggoEPw/Qf+XDe+wYQepg=;
	b=6J9SuS3uW+iNNdZtFRz5BP9d4aCpCp1MhMmeUGLx+MpxcSMSdzviGoQ3Puxact934w2XGp
	FEH9BzkcctHzeJCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf] bpf: Make session kfuncs global
Message-ID: <20240531104922.ZgOadg-G@linutronix.de>
References: <20240531101550.2768801-1-jolsa@kernel.org>
 <20240531103931.p4f3YsBZ@linutronix.de>
 <ZlmpoWed0NmeZblH@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZlmpoWed0NmeZblH@krava>

On 2024-05-31 12:42:41 [+0200], Jiri Olsa wrote:
> On Fri, May 31, 2024 at 12:39:31PM +0200, Sebastian Andrzej Siewior wrote:
> > On 2024-05-31 12:15:50 [+0200], Jiri Olsa wrote:
> > > The bpf_session_cookie is unavailable for !CONFIG_FPROBE as reported
> > > by Sebastian [1].
> > > 
> > > Instead of adding more ifdefs, making the session kfuncs globally
> > > available as suggested by Alexei. It's still allowed only for
> > > session programs, but it won't fail the build.
> > 
> > but this relies on CONFIG_UPROBE_EVENTS=y
> > What about CONFIG_UPROBE_EVENTS=n?
> 
> hum, I can't see that.. also I tested it with CONFIG_UPROBE_EVENTS=n,
> the CONFIG_UPROBES ifdef is ended right above this code..

Your patch + v6.10-rc1 + https://breakpoint.cc/config-2024-03-31.xz

> jirka

Sebastian

