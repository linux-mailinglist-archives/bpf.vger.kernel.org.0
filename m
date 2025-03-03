Return-Path: <bpf+bounces-53227-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F98A4EB81
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 19:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28C2A16D8BB
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 18:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCAC27C15C;
	Tue,  4 Mar 2025 18:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="snAJ488r"
X-Original-To: bpf@vger.kernel.org
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6165C28369E
	for <bpf@vger.kernel.org>; Tue,  4 Mar 2025 18:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741111907; cv=pass; b=DZRAwpqMHR4soFP8mC9Uhj6Q7FUcH1TbYIRv3kC5OrjbVZQlszGcM3Onn3eHJoecf+xgORNtKmvABAF2hVBhrEVFwCDQhmhIcW1e9Zihqq9JiDx1J77D4mE0+jGElKXBeHQ6AwYtupF5KnlpLusJt1iXAsJgbfOwI8i1oN5qjno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741111907; c=relaxed/simple;
	bh=Ve5w4wBza/LR9gEhfks2GNQsd1BGH+h8LS5mlA9F7SA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ivsOxcL0Mzi29LDs6Zb7YC+ixFuxLMCO0M1v1eH5ENkBpMxn2vEKPOp7o2S9/dqlfqynpx8q5xnU8EdtiSLkxGWBYEQeCmZfen1wJFkeEJDOcedcSlL9wjHMeVWRT3EP90YuDEbBx3u6Xp7rBHFoaqSsr58v8N5ej1+Fj2p0/J0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=snAJ488r; arc=none smtp.client-ip=90.155.50.34; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; arc=pass smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id 6EE1840D1F5B
	for <bpf@vger.kernel.org>; Tue,  4 Mar 2025 21:11:44 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6dzR2npczFy26
	for <bpf@vger.kernel.org>; Tue,  4 Mar 2025 17:56:03 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 6AB8642728; Tue,  4 Mar 2025 17:55:58 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=snAJ488r
X-Envelope-From: <linux-kernel+bounces-541259-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=snAJ488r
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 40D9642899
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:19:15 +0300 (+03)
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by fgw2.itu.edu.tr (Postfix) with SMTP id CC3D92DCE0
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:19:14 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DC373AF21A
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 09:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D622E1F12EA;
	Mon,  3 Mar 2025 09:18:45 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8722AD27;
	Mon,  3 Mar 2025 09:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740993523; cv=none; b=eM6oqolG4myHsKW/FXi3/iP9lDXlt9QViMzNoqiSX7sah4EZ+dZFxHqUAynLEcryPivLB3tmdGVhRWlhpe0qPIvWVqTnY/1GC6qS3JpVqxoZNqfFait5OcEAu9a+BgyhgUnpE167JKYuVffzjwrq56F4cc4CTJlCgqCJKZOV9V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740993523; c=relaxed/simple;
	bh=Ve5w4wBza/LR9gEhfks2GNQsd1BGH+h8LS5mlA9F7SA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UqKXyGtJNRz1eN/m5toBrP+H0LG6UpZqMHxlmqZGtTkdnoTbBNBMxBjVD44tWPiySRUlwRX40x9OXoEWyalFGHZ5jfbF6HyGSpFsihysDBYn3WZrkerIcsxXopJ9qweGLJh/B8ni13v8TDbDCLh84uDWlLo58NmmJNyu2Bd6woE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=snAJ488r; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1eCtu+hvRhYstMo2vG0z14zLR3g9gohNHmA5ExvpV9Y=; b=snAJ488rsQoq3hN1Z4FaRaQlQH
	9so+l3wlu5qJyjQKPK8rZIvWFrAiMCWsMVPirTbkAjAwy8KrNZ+PwvGMWz1dS6hh+eqcfMrNpEgYf
	yynraGfpogGIpEsCt74e2Zy1LrJYqjIRw74qWxaCNR4BikDoF52TN5wAe+PgIeHRpZCjkdquHdAm0
	mFMYGA1uwetI3N7IK/WIdZyNOmKr/fSFLOpHijzNTU+/3Z+CQKEh6ksGC9KIGKoHLh1JeC6QxOgHZ
	YL4PwFqb7dsxlsoSUc1CwOwL0YwuDz+NV41FSuuZwjc9FynHG9JVe1DWed11QXALcV2Nh3pHslyBl
	ifQrqumA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tp1wB-0000000BOR4-35ew;
	Mon, 03 Mar 2025 09:18:11 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5935F30049D; Mon,  3 Mar 2025 10:18:11 +0100 (CET)
Date: Mon, 3 Mar 2025 10:18:11 +0100
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
Subject: Re: [PATCH bpf-next v3 1/4] x86/ibt: factor out cfi and fineibt
 offset
Message-ID: <20250303091811.GH5880@noisy.programming.kicks-ass.net>
References: <20250303065345.229298-1-dongml2@chinatelecom.cn>
 <20250303065345.229298-2-dongml2@chinatelecom.cn>
Precedence: bulk
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303065345.229298-2-dongml2@chinatelecom.cn>
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6dzR2npczFy26
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741716559.3526@flyNmymm3qJA0A2oxo15eA
X-ITU-MailScanner-SpamCheck: not spam

On Mon, Mar 03, 2025 at 02:53:42PM +0800, Menglong Dong wrote:
> index c71b575bf229..ad050d09cb2b 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -908,7 +908,7 @@ void __init_or_module noinline apply_seal_endbr(s32 *start, s32 *end, struct mod
>  
>  		poison_endbr(addr, wr_addr, true);
>  		if (IS_ENABLED(CONFIG_FINEIBT))
> -			poison_cfi(addr - 16, wr_addr - 16);
> +			poison_cfi(addr, wr_addr);
>  	}
>  }

If you're touching this code, please use tip/x86/core or tip/master.


