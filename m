Return-Path: <bpf+bounces-53162-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4714A4D311
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 06:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 631D9188EBFF
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 05:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04ECA1F4706;
	Tue,  4 Mar 2025 05:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KI4+xIvh"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8771DDA1E;
	Tue,  4 Mar 2025 05:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741066762; cv=none; b=W2ir8RstyfNKdvFsdddKhV162vFhSwtRpBYR7IJbpHB9BeDStTb5kseXK24N6aOgwHwLEGD1I+46QKAwMmMk96iy1t3+8oMGKb3Co88iSoQO80geHzy7Sr4+0dqytZ1E0t9GhEzvTzEiNtdWeC9OoK5Oe2ckoct7yFqvhzirHlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741066762; c=relaxed/simple;
	bh=2vz+NB5tMxF1OWCpg7OqhukUuWLyPzvtudHFIO52pkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZUhzUVB/qcI3u9lp4y1iVdu1oMeWDoke3gEmo+fphn9zHcQ3zAbHl0O1ZPIv4d+qcelmO+ZLNlob+t+oLIJWeILeIRvVb42YWD7aXo9EKA62dNx15c3HpzBlOpQV49R/OA2GXDWpEXd2y50vceZ6x5iCkHHm+ry9U+PH0x8btTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KI4+xIvh; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=asZ89NjLYjHfpBcFWEra+PaQAUWjYIbeIoGtB844wqU=; b=KI4+xIvhaN+WFJ+4I3OIv62vvW
	vvKgZwD3kEbvhNNJATfeF6I4m7fCegtkQTp8i3I5SFGvEv22YX6iMKoMOWHX5z3Unsddyi1zYtIjs
	VqpSz/ZPd87FpUk6SIFQNqJ17zkZY/z6aRtPQD0GG1Fo97OC0zO6ggAu9bWDyvwuYlb/MswaYJMTF
	hdy+/BECalKSARmBXTkt402mzuu0FtAnoEx1A/bGYuEz3ASzKn+7niILzVlIGB7at291z8Vl2OGOA
	C+RP/g7y2QM60NNY2k5KwYcSh7hX3SKzJTGqbTPDUlVToDMf/ozWe2RfhMAe2wJAemg8eg3+xq7gh
	OLKQnWFA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tpKzZ-00000000FmI-2xOE;
	Tue, 04 Mar 2025 05:38:57 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8ED6630049D; Tue,  4 Mar 2025 06:38:53 +0100 (CET)
Date: Tue, 4 Mar 2025 06:38:53 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: rostedt@goodmis.org, mark.rutland@arm.com, alexei.starovoitov@gmail.com,
	catalin.marinas@arm.com, will@kernel.org, mhiramat@kernel.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
	jolsa@kernel.org, davem@davemloft.net, dsahern@kernel.org,
	mathieu.desnoyers@efficios.com, nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com, morbo@google.com,
	samitolvanen@google.com, kees@kernel.org, dongml2@chinatelecom.cn,
	akpm@linux-foundation.org, riel@surriel.com, rppt@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	netdev@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v4 1/4] x86/ibt: factor out cfi and fineibt offset
Message-ID: <20250304053853.GA7099@noisy.programming.kicks-ass.net>
References: <20250303132837.498938-1-dongml2@chinatelecom.cn>
 <20250303132837.498938-2-dongml2@chinatelecom.cn>
 <20250303165454.GB11590@noisy.programming.kicks-ass.net>
 <CADxym3aVtKx_mh7aZyZfk27gEiA_TX6VSAvtK+YDNBtuk_HigA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADxym3aVtKx_mh7aZyZfk27gEiA_TX6VSAvtK+YDNBtuk_HigA@mail.gmail.com>

On Tue, Mar 04, 2025 at 09:10:12AM +0800, Menglong Dong wrote:
> Hello, sorry that I forgot to add something to the changelog. In fact,
> I don't add extra 5-bytes anymore, which you can see in the 3rd patch.
> 
> The thing is that we can't add extra 5-bytes if CFI is enabled. Without
> CFI, we can make the padding space any value, such as 5-bytes, and
> the layout will be like this:
> 
> __align:
>   nop
>   nop
>   nop
>   nop
>   nop
> foo: -- __align +5
> 
> However, the CFI will always make the cfi insn 16-bytes aligned. When
> we set the FUNCTION_PADDING_BYTES to (11 + 5), the layout will be
> like this:
> 
> __cfi_foo:
>   nop (11)
>   mov $0x12345678, %reg
>   nop (16)
> foo:
> 
> and the padding space is 32-bytes actually. So, we can just select
> FUNCTION_ALIGNMENT_32B instead, which makes the padding
> space 32-bytes too, and have the following layout:
> 
> __cfi_foo:
>   mov $0x12345678, %reg
>   nop (27)
> foo:

*blink*, wtf is clang smoking.

I mean, you're right, this is what it is doing, but that is somewhat
unexpected. Let me go look at clang source, this is insane.


