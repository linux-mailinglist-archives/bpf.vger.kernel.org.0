Return-Path: <bpf+bounces-64894-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2193EB18470
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 17:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFA773AC071
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 15:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFD5265284;
	Fri,  1 Aug 2025 15:06:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288394690;
	Fri,  1 Aug 2025 15:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754060815; cv=none; b=h6KuksFMnT74D0o02s1w1QfIiYhfQbtPvV1a4eWEwqtHvlO6xPIPKGMgVOGXe9hugxHvD3DsklQKAAaZeW/y3e2KhhNAd311PhzWh2/bnpD7y+VxEKsEV+whvdhYONkyLtw2UmJAG7LQczA8/1dZNLkUiE/BoutjV7YVaY/ydtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754060815; c=relaxed/simple;
	bh=FeSzmhc+l8wzdVVICiIXjiyry8U2yzJa2vd0Fqm9dao=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EYwnOXnMdlgjEAe6SK2+m2cM/4hNCO/8fpxroqt/tlJ/ZVcDmK/f2s9HHLJ+nqOIPV9lQICzY4jSns+UnuFCRX7tbqAoEjCstcvbY4isBwRQ3osDuqwbKCgsqcXvhpJDiG1IknmFfqhKgso89bS7cU4mSvXY8txZFsXSXNYFTdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 6F5C9134010;
	Fri,  1 Aug 2025 15:06:48 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id 8770F31;
	Fri,  1 Aug 2025 15:06:44 +0000 (UTC)
Date: Fri, 1 Aug 2025 11:07:05 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, KP Singh <kpsingh@kernel.org>
Subject: Re: [PATCH] btf: Simplify BTF logic with use of __free(btf_put)
Message-ID: <20250801110705.373c69b4@gandalf.local.home>
In-Reply-To: <CAADnVQLky+R-tfkGaDo-R_-tJ8E3bmWz8Ug7etgTKsCpfXTSKw@mail.gmail.com>
References: <20250801071622.63dc9b78@gandalf.local.home>
	<CAADnVQLky+R-tfkGaDo-R_-tJ8E3bmWz8Ug7etgTKsCpfXTSKw@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 1rn64c971pqxcscrkufredpxzpd3fbqi
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 8770F31
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19VM1qpXwNmASfQCgcyc9BZ5oAOw62RSyw=
X-HE-Tag: 1754060804-145673
X-HE-Meta: U2FsdGVkX19NRXlTLfJajgaaKHcRPDQbGIFHR8AfWenPZ8ropJguBvV6cD6BLshkrbTZgh/aV5ekzBXhwyjXB3MvO44WkSBtjJ13RtI84pY6Sr5eIXKyIyrUW4NIyrDP2JIgGAG6BIJNj3RLjuZ9Pfn9Nc5bon3UfSAoBJsJdjBDVJmXFppLGqU4K3IPfoCT87xqeofem/GhCiSmeO2fCQ/FFocgPfjyjcvR4srIZRfh/Kj4sA9vEq3fIBlXOqGLftlYq5FazBAqg6pcYCnMday8JWmZChSVtIG5Mo25I56RxAZGLzNCS1b907VFuS0jCenimdQFkwSvT/vLPBa0kN6yUNIQj9PU

On Fri, 1 Aug 2025 08:02:24 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 1d2cf898e21e..480657912c96 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -3788,7 +3788,7 @@ static int btf_parse_kptr(const struct btf *btf, struct btf_field *field,
> >         /* If a matching btf type is found in kernel or module BTFs, kptr_ref
> >          * is that BTF, otherwise it's program BTF
> >          */
> > -       struct btf *kptr_btf;
> > +       struct btf *kptr_btf __free(btf_put) = NULL;  
> 
> Sorry I hate this __free() style.
> It's not a simplification, but an obfuscation of code and logic.

Well, it's becoming more common. But you are in control of this, so it's
your decision. I wanted this just to get rid of the gotos in my code.

-- Steve

