Return-Path: <bpf+bounces-69662-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE16B9DD8B
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 09:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D3783B17A8
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 07:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882042E8DFF;
	Thu, 25 Sep 2025 07:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gTeDEMsW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DDF2E1C7B;
	Thu, 25 Sep 2025 07:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758785178; cv=none; b=VcmqfPUp7hqyg4I6/LO999kIVBBZhKgoBUNSdrLHglipDS5/hiXffPD2YjXPDP8Ac5Yrwarxnv8EbQGLWqXWCr7aKydJvbRE7l4f4eCPH3l0KjrYYgyaYgZGZtxfNAsSUbpJ1jCaBbvuwCqIfXzmzOS5LRpeRJ+WNJCwwdsRJAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758785178; c=relaxed/simple;
	bh=+yd6rsd28BeAAqsc5pELVRISkApsjlmKRpoE7ReettI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LHbTzjsnoMyTmojgG40hAIRffCP9wkHdmWTi7UkUhl6y0jYysp3YIZSF3Ehg1Pw0NjBkRZ3VKpiolt1gMEXFIkhKcYXI8BMbbQNqdLb1GHxsAcCEOFQQMa4SJOgHHEW5EpNU6qUy55rqnEu6vm0FsWKhwa3c2qwrWuN9tf2aXgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gTeDEMsW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6801CC4CEF0;
	Thu, 25 Sep 2025 07:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758785177;
	bh=+yd6rsd28BeAAqsc5pELVRISkApsjlmKRpoE7ReettI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gTeDEMsWNsp7af5nppLhY7sKS0HsE7m6hF5KSW+1N1gsggY61CQNy/FteB2Mgxqws
	 Yr77w3xaJvNXYr32Dhv4Qysb/OfqJJ6dW75Vw6F+XpnyIJtwGpqnTrgrtqJriJGy0j
	 PlqUN9ZdtlY1zE6OcOCo1OdRp9SwEXvs5TB633b/EH/9oleYWJOlSvCkjbPBIF88b4
	 mymMWDf+GzgmO2Ltscf4peIUFrf45gVs8VaLhAO/Wqh9CUbPrtl98hwqm+FeaFBN12
	 fonVz8HdId74VAD1YQUa8mGsrC3Gf1aEpDAnZ7J8Fo12iX7UxqgY5x/pIhPfdUYqkb
	 vNBtOlwnB2s9w==
Date: Thu, 25 Sep 2025 03:26:11 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Menglong Dong
 <menglong8.dong@gmail.com>, jolsa@kernel.org, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, kees@kernel.org, samitolvanen@google.com,
 rppt@kernel.org, luto@kernel.org, ast@kernel.org, andrii@kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2 1/2] tracing: fgraph: Protect return handler from
 recursion loop
Message-ID: <20250925032611.52475590@batman.local.home>
In-Reply-To: <20250925003410.de2ef839f6ef3921ee08a955@kernel.org>
References: <175852291163.307379.14414635977719513326.stgit@devnote2>
	<175852292275.307379.9040117316112640553.stgit@devnote2>
	<20250925003410.de2ef839f6ef3921ee08a955@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Sep 2025 00:34:10 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Hi Steve,
> 
> Can you pick this ? Or I will do?

I'll take it. I'm currently pulling in patches now anyway. Although,
while I'm traveling, I'm a bit slow at it.

Thanks,

-- Steve

