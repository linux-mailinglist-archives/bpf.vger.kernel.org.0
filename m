Return-Path: <bpf+bounces-69927-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AB7BA79C0
	for <lists+bpf@lfdr.de>; Mon, 29 Sep 2025 02:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 173421895DFE
	for <lists+bpf@lfdr.de>; Mon, 29 Sep 2025 00:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1232F872;
	Mon, 29 Sep 2025 00:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ByUF+K9l"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAD4A31;
	Mon, 29 Sep 2025 00:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759104150; cv=none; b=L2Y16cDO/7DWzllG3OEWi9jKL8Q+cnL84tfMuMFfT0iYzhYspJGoDIKjTF83hWrJbd866jjfVCGpFEvVosvdeEDSQr9zadWLiwKUOyKP2oz/d8w7IGV1bRH2imNb182yq0hpX5rGiqSWPvse9JLSL96irSbqnDvnT2Ay15SICiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759104150; c=relaxed/simple;
	bh=mELQNEcnEx5dgQTS4wAbH1sZx8mwe7lcH5VGMo0Y+O4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=rABOo6mEtPAP9yQXHcc6HxdNro+Aj0WvIUA157f8zc2FpRv/BH5mvwitQoqdi60oHkOFy+ODgihu5Rizb89oFdL7/loIZ751c+9Let1ZfT3QhAR1iEHwzPzKU55I9VENLZ6xXdzr1Fc2zEmdT6NzLKL1yLNOdAD0pUPcryx0QoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ByUF+K9l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E63F5C4CEF0;
	Mon, 29 Sep 2025 00:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759104150;
	bh=mELQNEcnEx5dgQTS4wAbH1sZx8mwe7lcH5VGMo0Y+O4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ByUF+K9lfBzhT+h53ddtLdmKYS3+ZHhaEP+g3fmav2JPYLuy/yd+udtYE9yhC19nr
	 kQge4fwFvoL+DY6f+pCJQ91POWbAiwrWmk1qV9u1evH4wtDWgqoEUZAFn59NphjGIc
	 Gc7K5SaxLMesdPwXi+t8MieS08FRWFdr7iWoVvZ28G9RKjeVydVzJk0wSL72pWvFFJ
	 P45LJz3Mr3IkcaYnHcv6fOE4htqSFqolkeQau1FR8m9hxtkcOD8Hqn7wQAGCJjvKuv
	 UpUJOT94gj2YrDSxBVsEdK/Jn4JizE0ZBF+Y1qfGbcEWJXCXNtPbB5ePUBRwqwSjYQ
	 z66zuy0ptp0qg==
Date: Mon, 29 Sep 2025 09:02:23 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Menglong Dong
 <menglong8.dong@gmail.com>, jolsa@kernel.org, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, kees@kernel.org, samitolvanen@google.com,
 rppt@kernel.org, luto@kernel.org, ast@kernel.org, andrii@kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2 1/2] tracing: fgraph: Protect return handler from
 recursion loop
Message-Id: <20250929090223.3d32e10978cd3e4af50cc271@kernel.org>
In-Reply-To: <20250928085626.2683c2aa@batman.local.home>
References: <175852291163.307379.14414635977719513326.stgit@devnote2>
	<175852292275.307379.9040117316112640553.stgit@devnote2>
	<20250925003410.de2ef839f6ef3921ee08a955@kernel.org>
	<20250925032611.52475590@batman.local.home>
	<20250927085753.02b55a18@batman.local.home>
	<20250928085626.2683c2aa@batman.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Sep 2025 08:56:26 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sat, 27 Sep 2025 08:57:53 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > Masami, you didn't include linux-trace-kernel mailing list, so it's not in patchwork.
> > 

Oops, that is why it did not work...

> > Can you please resend?
> 
> Never mind, I sent it to Linus already.

Thanks!

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

