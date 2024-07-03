Return-Path: <bpf+bounces-33720-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 364DB924D15
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 03:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1C16283858
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 01:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F94E2107;
	Wed,  3 Jul 2024 01:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u8XCyyFl"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A179F621;
	Wed,  3 Jul 2024 01:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719969116; cv=none; b=h4SIzL60Tkimu9dqLtkBqSDNyOeNEXC8m2YIQ7gDyd8sr89+/jLzo0IlwNi6vbZVLSOPCAx9NlnXDv/2wubQtUloCWdPgFJtTpPk+pMPDB5R6cUTTtHCZks3wket/DoQVnMgHI8U4S1a7hGKAs+XIPaPe6bN/ycv6cCNA2F2o08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719969116; c=relaxed/simple;
	bh=FOInugq3Bs8wKxJEdi/NQCIH6wZP8qlhK38ZRjYYe0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=juU/fXyrE+KDZy6wumBA8AA9NpvLh7JyAkbC7Z0QrjczVPOD2RPmrHpxZPY8vnQEU1ksVGSP5ngxqKIhwTd3Xdee4Z6ZPqCyqMuOmwIwGPRs84d2aISKHTmYgtxwU2ODdPmPKcdVo1d2clhVyefo6HMro8ofu4thOS3BFWwtmKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u8XCyyFl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA8BC116B1;
	Wed,  3 Jul 2024 01:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719969116;
	bh=FOInugq3Bs8wKxJEdi/NQCIH6wZP8qlhK38ZRjYYe0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u8XCyyFlIB/6u5hqrAkAwGzJT6FzrIwZp6LURsvQCQr0xaYZx22+gz+HHOwZVYwM3
	 kq7q/otBXO01Wwbp2GgBejTFnLct/Kfr1CtziwWtMPT8BoILsBA8jP6Ua5x+Bl3x+P
	 enj+Q7isg2tg+DWF95/8VvAZfTQxs4hs8iwmplQYQXwpsKHC12P0VhFiZzFPnv9ql3
	 seeQtF8COWYE+jZVe10Is7HAScArtPgfs1EysWjGouHrQk72fv2LwgOxiRs36xN+R8
	 5TiCAtpxf/Is36PKlPu1tdbBp17mWAHXS8SY7MAlzJTASuSyXGBLtbsuBMnVf/NGP0
	 vPwJ3SiSS4Nuw==
Date: Tue, 2 Jul 2024 18:11:53 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
	peterz@infradead.org, rostedt@goodmis.org, mhiramat@kernel.org,
	x86@kernel.org, mingo@redhat.com, tglx@linutronix.de,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, rihams@fb.com,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2] perf,x86: avoid missing caller address in stack
 traces captured in uprobe
Message-ID: <20240703011153.jfg6jakxaiedyrom@treble>
References: <20240702171858.187562-1-andrii@kernel.org>
 <20240702233554.slj6kh7dn2mc2w4n@treble>
 <20240702233902.p42gfhhnxo2veemf@treble>
 <CAEf4BzZ1GexY6uhO2Mwgbd7DgUnpMeTR2R37G5_5vdchQUAvjA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEf4BzZ1GexY6uhO2Mwgbd7DgUnpMeTR2R37G5_5vdchQUAvjA@mail.gmail.com>

On Tue, Jul 02, 2024 at 05:06:14PM -0700, Andrii Nakryiko wrote:
> > > Should it also check for ENDBR64?
> > >
> 
> Sure, I can add a check for endbr64 as well. endbr64 probably can be
> used not just at function entry, is that right? So it might be another
> case of false positive (which I think is ok, see below).

Yeah, at least theoretically they could happen in the middle of a
function for implementing C switch jump tables.

> > > When compiled with -fcf-protection=branch, the first instruction of the
> > > function will almost always be ENDBR64.  I'm not sure about other
> > > distros, but at least Fedora compiles its binaries like that.
> >
> > BTW, there are some cases (including leaf functions and some stack
> > alignment sequences) where a "push %rbp" can happen inside a function.
> > Then it would presumably add a bogus trace entry.  Are such false
> > positives ok?
> 
> I think such cases should be rare. People mostly seem to trace user
> function entry/exit, rarely if ever they trace something within the
> function, except for USDT cases, where it will be a nop instruction
> that they trace.
> 
> In general, even with false positives, I think it's overwhelmingly
> better to get correct entry stack trace 99.9% of the time, and in the
> rest 0.01% cases it's fine having one extra bogus entry (but the rest
> should still be correct), which should be easy for humans to recognize
> and filter out, if necessary.

Agreed, this is a definite improvement overall.

BTW, soon there will be support for sframes instead of frame pointers,
at which point these checks should only be done for the frame pointer
case.

-- 
Josh

