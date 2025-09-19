Return-Path: <bpf+bounces-68919-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2F7B887AF
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 10:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 670484E55E0
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 08:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1F52ECEAB;
	Fri, 19 Sep 2025 08:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZAAXb9f8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE992EB5C4;
	Fri, 19 Sep 2025 08:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758271981; cv=none; b=tD9eYKxjQNxWsOtenRQjWyaRBbgv5c7CWpqrNPSDhVj2G5/BwDghw3sHyJNQtIzCy54sxn+jY2/XSMiYMbdqW0rmRyCfQew7jKH/jJQ/wRfo6MKF6+spmAwtfuRb+uY5mWMOZ+rL0jCEuYDS9zD4NDKmWSUvnLAFsODh2gRrfbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758271981; c=relaxed/simple;
	bh=AeZ87+jkSDLR6/2J8IM8zfm+XIxqL6SMk1X+MXIRCvI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=EqWZ8obSencC9tdV5AE/Y6FImdYrU7mA5uBvHLvHWo2FY/FoCtJXkD5UM6H5tN5HF/Bg3dWQ99m35Em4YkJZ9p2ir1J0MxVXq64Sr8LJqk2lPzKh7xQNKP4i4Cns5pHEB+Y6xBhF5zJGs/aMwENHJu7hQNnS1EUVO/5tcuBhssU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZAAXb9f8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C73C4CEF0;
	Fri, 19 Sep 2025 08:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758271981;
	bh=AeZ87+jkSDLR6/2J8IM8zfm+XIxqL6SMk1X+MXIRCvI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZAAXb9f8mgGa7p6xelcGMUA4TpkE09IHcFWyRocmWTPM/JRZOtH6nfqWyQa26iCKC
	 ktjkKwRyYt0xKBmpC6YJX20nSGEo+Dtem4qU1mFRWzkKJ1+dq+oVwIiFB4eCKzf2lt
	 cTVjt79KAsmS1rWlJmZQQHuOrphcmuZuKzj1kcjF9QDMZcborVttBbbeA74VDLDN+p
	 6Ank7w5VgeGWYVFmhAzWVsYwonbHCJZ3QS9pc63pq+wH+zg9EyGZ4YzbV1FZY0ek89
	 6gFQ+xUH7lNY9AsBgxALPtWiM5cZWlyM1TI1Zz8G2AvUMmE2LMInw165P31weXFMKZ
	 g1JSxLM83yPTA==
Date: Fri, 19 Sep 2025 17:52:55 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: peterz@infradead.org, jolsa@kernel.org, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, kees@kernel.org, samitolvanen@google.com,
 rppt@kernel.org, luto@kernel.org, mhiramat@kernel.org, ast@kernel.org,
 andrii@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] x86/ibt: make is_endbr() notrace
Message-Id: <20250919175255.f7c2c77fa03665a42b148046@kernel.org>
In-Reply-To: <20250918120939.1706585-1-dongml2@chinatelecom.cn>
References: <20250918120939.1706585-1-dongml2@chinatelecom.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Sep 2025 20:09:39 +0800
Menglong Dong <menglong8.dong@gmail.com> wrote:

> is_endbr() is called in __ftrace_return_to_handler -> fprobe_return ->
> kprobe_multi_link_exit_handler -> is_endbr.
> 
> It is not protected by the "bpf_prog_active", so it can't be traced by
> kprobe-multi, which can cause recurring and panic the kernel. Fix it by
> make it notrace.

Ah, OK. This is fprobe's issue. fprobe depends on fgraph to check
recursion, but fgraph only detects the recursion in the entry handler.
Thus it happens in the exit handler, fprobe does not check the recursion.

But since the fprobe provides users to register callback at exit, it
should check the recursion in return path too.

Thanks,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

