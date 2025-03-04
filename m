Return-Path: <bpf+bounces-53175-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5ED0A4D935
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 10:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 688AA3B8D31
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 09:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E666E1FDE03;
	Tue,  4 Mar 2025 09:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sAD73dR4"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486011FCFDA;
	Tue,  4 Mar 2025 09:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741081373; cv=none; b=CEX0z2xoDl2Yxq6EnJgWdEJanYF0noaiarHx7CUDhQg6WMVUAywLN9dHevVscYPzsGsJQxdBPCB4mzcmBCHCUp0wCOtvM73rhLk8Y//NHWADrEyXHJ/IKuJITAQ9XugzzJ6vzseGKJmOwANZwUAsxbrRF4YN3ZFT9KxMxm0trqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741081373; c=relaxed/simple;
	bh=XwmCxjrXcMahsJEKEkslTcjHfUp6QZXWnoexz7Mrfjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FDfqLcRouFy9MPPQA5EvRbrh9AhyOjuHj3JQ97JuAMuYqw2rnDQoWWJaySugKAX29mu2+HHNysbqaihRqQTshwfcS06jyuZx8dMSfQYLoGuwloCVgoDJ18kMnbJsQ7syPmD+0Ln8YlGjuspwCQyhiSB/DH/g0YM4YHMRiTecsxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sAD73dR4; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JV3pZtApgs6TqusViUPy5JRin7FrjXxYFUIaUJ+B9XQ=; b=sAD73dR4uuNhAcshhcuRcesBx+
	eJ/C3bmv3pIIe/mG1mLKwsxL767vF9XoYK+XuLoxcB4ZcWd01zg+ESguKuTlE8fSe3DBCudwCK4QH
	tUYunxwMMarMT59PtDZe7o+MBlfFzUHHgWTAWR/HFTAFBcE2XGKUZOY9ifY73IjijaOidM6spsxSE
	TFf3w0Ou4GRQUfvuK5g12RRqcEKAkz1yfN6u5AVhvvF8TmSgpmxj7ZOfmMqoCfnW2dmEM2XmvjPlQ
	vWR3ZzKEgCa2Xwz1NeUER743p8ylHJVVYcWFyw0T6x121cHcZEOlLl6WIzyfEXcfnVEJRzfC1fAmf
	rCLuWuRQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tpOn8-00000000YOw-0yQv;
	Tue, 04 Mar 2025 09:42:22 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5C1F230049D; Tue,  4 Mar 2025 10:42:20 +0100 (CET)
Date: Tue, 4 Mar 2025 10:42:20 +0100
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
Message-ID: <20250304094220.GC11590@noisy.programming.kicks-ass.net>
References: <20250303132837.498938-1-dongml2@chinatelecom.cn>
 <20250303132837.498938-2-dongml2@chinatelecom.cn>
 <20250303165454.GB11590@noisy.programming.kicks-ass.net>
 <CADxym3aVtKx_mh7aZyZfk27gEiA_TX6VSAvtK+YDNBtuk_HigA@mail.gmail.com>
 <20250304053853.GA7099@noisy.programming.kicks-ass.net>
 <20250304061635.GA29480@noisy.programming.kicks-ass.net>
 <CADxym3bS_6jpGC3vLAAyD20GsR+QZofQw0_GgKT8nN3c-HqG-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADxym3bS_6jpGC3vLAAyD20GsR+QZofQw0_GgKT8nN3c-HqG-g@mail.gmail.com>

On Tue, Mar 04, 2025 at 03:47:45PM +0800, Menglong Dong wrote:
> We don't have to select FUNCTION_ALIGNMENT_32B, so the
> worst case is to increase ~2.2%.
> 
> What do you think?

Well, since I don't understand what you need this for at all, I'm firmly
on the side of not doing this.

What actual problem is being solved with this meta data nonsense? Why is
it worth blowing up our I$ footprint over.

Also note, that if you're going to be explaining this, start from
scratch, as I have absolutely 0 clues about BPF and such.

