Return-Path: <bpf+bounces-47783-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA3AA0000C
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 21:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 202C03A05E1
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 20:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6781B5EBC;
	Thu,  2 Jan 2025 20:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TAbWrNBq"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCA942AA2;
	Thu,  2 Jan 2025 20:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735850196; cv=none; b=Si0TCyaogDtlg6UzPxeOnlsGglm4kR5kbbFmowgSIQokpuUZ/wuzwxHVzjx6WZFrwG9FTBV4w++XD9SMgrj9/G20w7z0up9cHXW3w4sANr3k4DntnAvVMGsmep5VmoVFdkksty2BHNoK9WrMxeUNSbRGehe/f5F9xpwhQSdG6Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735850196; c=relaxed/simple;
	bh=5GyXVVOlTnJnlME5hkAdMxFe8KMuNpx5m+7zdyqsjiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bME96nadYrLEZRmCexUwsKo9kulRDrElX3FRFP+B3tD7/XbQdmzS2yH/SOS7LzBLybD4SzF+0romb3/wiMJqIVvgvSgayuJ2307LfV2d0VuwOYY32ftgkuNeiaNhtDWqfoT0bmglKCQS9Kzg39wQorh5f9Hf1tTrEd7VpYOVi2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TAbWrNBq; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fIlMFo+Nf2y0ZaYgdHxU9FFxkak6xbLnfFzk0qkmCkw=; b=TAbWrNBqAA+7J6pNUMwtGGSyYg
	Vvu03LFrUQSe5SEeBxrewjTyfuqeWoeLMy73sgRxG9m8FeVs2rnO9STdua/tvo6jBIaaMxX+CrNn1
	E0+R9eMpmrzQsxkFJab+4ilk0VlZof9wuj5goXmMPtnhpLwdVJ4ZXRlBohoD5rhs5Y2FKaeCe8nBc
	G6G7kDbf+5XLvNL6fKGVJw0hX/AO2LATihE1rNgfwuwwUaPDqmSJmQCjcommyRdSF96V4sa2QuXcy
	SPi/+c8cOe/jz906bPLwVtpgback5wM0o+PYkxdlLiEnPifcMgvD6eeTxmM1zjCz7idbqRVCawfSW
	OwIkX0Gg==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tTRvd-00000008FEH-48Dr;
	Thu, 02 Jan 2025 20:36:26 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 48B443005D6; Thu,  2 Jan 2025 21:36:25 +0100 (CET)
Date: Thu, 2 Jan 2025 21:36:25 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org, bpf <bpf@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Zheng Yejian <zhengyejian1@huawei.com>,
	Martin Kelly <martin.kelly@crowdstrike.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH 14/14] scripts/sorttable: ftrace: Do not add weak
 functions to available_filter_functions
Message-ID: <20250102203625.GF7274@noisy.programming.kicks-ass.net>
References: <20250102185845.928488650@goodmis.org>
 <20250102190105.506164167@goodmis.org>
 <20250102194814.GA7274@noisy.programming.kicks-ass.net>
 <20250102145501.3e821c56@gandalf.local.home>
 <20250102202404.GD7274@noisy.programming.kicks-ass.net>
 <20250102153016.7fc5e443@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250102153016.7fc5e443@gandalf.local.home>

On Thu, Jan 02, 2025 at 03:30:16PM -0500, Steven Rostedt wrote:
> On Thu, 2 Jan 2025 21:24:04 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > It is not. If kallsyms is fixed, you can use that to tell which
> > fentry/mcount sites are 'invalid'.
> 
> I can't use kallsyms for valid tests at boot up. Even with a binary search,
> it's still rather slow. The ftrace table is created at early boot, even
> before scheduling (it's needed before you can enable boot time function
> tracing), so any slow down in creating that table slows down the boot, and
> people will notice.

I'm not sure I understand, up until you've started userspace, nobody
cares about those weird indexes.

