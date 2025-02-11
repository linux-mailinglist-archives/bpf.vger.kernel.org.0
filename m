Return-Path: <bpf+bounces-51160-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CA5A3112D
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 17:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62368161568
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 16:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3D8253B43;
	Tue, 11 Feb 2025 16:24:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D49826BDAB;
	Tue, 11 Feb 2025 16:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739291050; cv=none; b=W6s0M1MAUx8fTe8XS7CWdn4fyks/eSwxWwkePmVwcA8NxMhwPPRehiQ/Q61HViEZAu8brf+LQW1Q+otwsy6ohCmaGPTbzinqGrBz0kshqo/2ViGxsqytNq1MK3QZP7ykWxzq5ffGxtwIHBTrz7oxSNabn2UxMvt/FrS6BiGo+oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739291050; c=relaxed/simple;
	bh=fOJNLFXheFs3t97+oDIWKPx50/a6xFugJurvSYY4P0U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nbk3zBE/z4wDcQW+I4Bt5zv4GCSkWMKVDR0nMy89yrqVTWZGtC60ZwoyHplZw6W/rcyGkGQgXeqFBpL6P/sK5Utvx2G5rst6yJWemGmUVduQ3IZBDrGt0diDvkZm7Wkff5KhzzRmTQso4jgx1DIf/CXWuYQxCU11/qj4bRlPP4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FD20C4CEDD;
	Tue, 11 Feb 2025 16:24:08 +0000 (UTC)
Date: Tue, 11 Feb 2025 11:24:13 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: alexei.starovoitov@gmail.com, x86@kernel.org, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 dongml2@chinatelecom.cn, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [RFC PATCH] x86: add function metadata support
Message-ID: <20250211112413.4c43a9ca@gandalf.local.home>
In-Reply-To: <CADxym3YzTc8wyAndNP4OpK8JSLWkpCAMgJox49ioUBXrov1h=w@mail.gmail.com>
References: <20250210104034.146273-1-dongml2@chinatelecom.cn>
	<20250210180528.01118537@gandalf.local.home>
	<CADxym3YzTc8wyAndNP4OpK8JSLWkpCAMgJox49ioUBXrov1h=w@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Feb 2025 20:03:38 +0800
Menglong Dong <menglong8.dong@gmail.com> wrote:


> 
> Another beneficiary can be ftrace. For now, all the kernel functions that
> are enabled by dynamic ftrace will be added to a filter hash. And hash
> lookup will happen when then traced functions are called, which has an
> impact on the performance, see
> __ftrace_ops_list_func() -> ftrace_ops_test(). With the per-function metadata
> support, we can store the information that if the ftrace ops is enabled on the
> kernel function to the metadata.

Note, ftrace only uses ftrace_ops_list if there's more than one callback
attached to the same function. Otherwise it calls directly to a single
trampoline, and is rather efficient. No meta data needed.

> > Arm64 and other archs add meta data before the functions too. Can we have
> > an effort to perhaps share these methods?  
> 
> I have not done research on arm64 yet. AFAIK, arm64 insn is 16-bytes aligned,
> so the way we process can be a little different here, as making kernel function
> non 16-bytes aligned can have a huge influence.

Arm64 already uses the meta data before every function. That's where it
stores a pointer to the ftrace_ops. So in ftrace, when there's a single
callback attached to a function in arm64, it jumps to a ftrace trampoline,
that will reference the function's meta data to find the ftrace_ops to use
for that callback.

If more than one callback is attached to the same function, then it acts
just like x86 and does the loop.

-- Steve

