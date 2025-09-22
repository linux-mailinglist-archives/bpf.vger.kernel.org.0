Return-Path: <bpf+bounces-69178-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C973EB8F2B2
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 08:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FD693AA35D
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 06:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981D5298CD5;
	Mon, 22 Sep 2025 06:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WNIk6U0G"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F6F502BE;
	Mon, 22 Sep 2025 06:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758522990; cv=none; b=rUCCdV2fzIt2gdbMAou9Uz7y/J1NMldze9iBbc7OboMFOqg+dgB1gEc1GjEbnDIOJAVEL6J+UhLjdwl+L9ZIUf9tD+LdchyrlLXYlTSGRUWwbYhzOSiWVw5jMi3VxhtlE05JavDkG+yfzxIkVt1W/1m0mwxkf3WoZWWkbq0uga4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758522990; c=relaxed/simple;
	bh=Nkk7vv3FoyfQLoEQDzzlILC4iakqQ3xqrEL3j+/IUuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y3zQYOH8vFaWiAt77ZsjAz6A2cuHj9cJoZMdulnb/aTwsEZ/qWLrKwrULK092gjiIuihEWVzZatYNG83u6KeMdvjcgW0FBvkPG2wIVBL0R5b6onPwscLY4SCdFQvjs/0ljiNGsN/PPi3aRGpejloHGnRrUeh3kAW6pOL72SI0Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WNIk6U0G; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RxA3MlHODtYadjySPrK4fpG/r9qFnxDUxYQPL9WUGlg=; b=WNIk6U0GHkvjPcU9OHny8r4hw0
	cy5Nex5PcUTdXqo9AO0BHNMXivlWGrVQYxqewosu8+kDmIS5dreN0+Wg/X1cUr+0i5QWH3e4G8Ovl
	Tjo6rK/PqG9EhkQbggehzvTdA/IRuM1zmxVcb2DvYqsFK9On5k2SohZlLy42RdCd+nyvWr9Lnbfu1
	/EM2ssm/smB5BKNFwJ3qQSadm9cq2oFISz0pXvD6wzzAhWp7uTVc7y/U8GWhcg54ntgBOyWNZXC3E
	mudrOgIuKSLjMnQCgRJtzvJDXiwRqXL8u42sHZEnbF+VzIXhyHpnS+TyiXU+D0ZTS00kRhUxsTL7O
	gsTb7JoQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0a9p-00000002ELy-3icu;
	Mon, 22 Sep 2025 06:36:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CDAE6300230; Mon, 22 Sep 2025 08:36:16 +0200 (CEST)
Date: Mon, 22 Sep 2025 08:36:16 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Menglong Dong <menglong8.dong@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Kees Cook <kees@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Mike Rapoport <rppt@kernel.org>, Andy Lutomirski <luto@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH] x86/ibt: make is_endbr() notrace
Message-ID: <20250922063616.GN3245006@noisy.programming.kicks-ass.net>
References: <20250918120939.1706585-1-dongml2@chinatelecom.cn>
 <20250918130543.GM3245006@noisy.programming.kicks-ass.net>
 <CADxym3ae8NGRt70rVO8ZyHa3BvWhczUkRs=dVn=rTRMVzrU9tA@mail.gmail.com>
 <CAADnVQ+hOdOpCR6s_GyO_7xxehCPBHSttidia38P5xFie6yjnw@mail.gmail.com>
 <20250918165935.GB3409427@noisy.programming.kicks-ass.net>
 <CAADnVQLP6-s_dtGpEcnFaVJfDW12rTOS2qk5k0Fyvn=4Gn7gBw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQLP6-s_dtGpEcnFaVJfDW12rTOS2qk5k0Fyvn=4Gn7gBw@mail.gmail.com>

On Thu, Sep 18, 2025 at 10:53:51AM -0700, Alexei Starovoitov wrote:

> > notrace don't help with kprobes in general, only with __fentry__ sites.
> 
> Are you sure ? Last time I checked "notrace" prevents kprobing
> anywhere in that function.

#define notrace                 __attribute__((__no_instrument_function__))

AFAICT that only inhibits the compiler from generating __fentry__ calls.

There is NOKPROBE_SYMBOL() to explicitly exclude kprobes from a symbol.

And we have noinstr, which along with a gazillion code-gen attributes
puts things in a .noinstr.text section and that section is also excluded
from kprobe placement.

