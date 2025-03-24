Return-Path: <bpf+bounces-54598-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B782EA6D5B4
	for <lists+bpf@lfdr.de>; Mon, 24 Mar 2025 09:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E681189088A
	for <lists+bpf@lfdr.de>; Mon, 24 Mar 2025 08:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9340925C6E1;
	Mon, 24 Mar 2025 08:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DM4NMmIb"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170CE1F5FD;
	Mon, 24 Mar 2025 08:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742803340; cv=none; b=aHrV0g9Bq6pYPQSgsoMqAiLyrONkrjXqRdtrxwnQNS53SVRaUDU3/UdnKaZIDqTyQu/ejZs6cWjhNdtQA1Xk62EJ/DwXWMzFbbSiW4BRQ7mnbo1XIFsAcbxhonKgzsmkWIvRdG9CBVTvF9NkFMT0Jmasi6+/+cJv2TgWUdZV2uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742803340; c=relaxed/simple;
	bh=scM71kld/MmM4wT+ZwiTAAvyTqTjkA5Mvn78eu7N+ZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ScUwsLLqruSi1Xk3JSZcWfqJHExUlYPYFT5w2R79nfe7ehD5A9l8N4ezykn+BOqfZEQcttZpJNVAHfqKLIAbzKVPimGm077rgSV5Bp/ZtDzQPuOsI206kLbjrf9qT55ofowy8nXx7pO1L5Q00ocDNEAaIazNTYE6rAyMk8g2y54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DM4NMmIb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B31C4CEDD;
	Mon, 24 Mar 2025 08:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742803338;
	bh=scM71kld/MmM4wT+ZwiTAAvyTqTjkA5Mvn78eu7N+ZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DM4NMmIbthsG92cWfCItu89soE/S3k21YeqELHjcwc4ogmrYIUtNfTt/G0lXKWU9t
	 ENH7SSghR6Uv6CPvMYp//JmFkoD91+mQHLKYozM2+R1mmxPgXCE4kmQAQgHaEuDxHv
	 uXZrM6gLBPX2ifpb8LOs4Rug3n86vyEKBxDUty2nKwmkSAHfFUgrv7rVyAltXhLKAv
	 sbMVT5miq/pZEziLLKQPxnLOqpujvySW20Yg0MbjFm0MZtaWqayspObyLKef96To5P
	 mU2so0yhK2/2bKOCp1OYf+6nsnQRBKVOud0nKQdFULI+9APbGs8gyaGGYX9bjFf7Av
	 FNinqEMOLa/5Q==
Date: Mon, 24 Mar 2025 09:02:12 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org,
	bpf@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>,
	Greg Thelen <gthelen@google.com>,
	Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] x86/alternatives: remove false sharing in
 poke_int3_handler()
Message-ID: <Z-ERhIEtrVpTIdJb@gmail.com>
References: <20250323072511.2353342-1-edumazet@google.com>
 <Z-B_R737uM31m6_K@gmail.com>
 <CANn89i+fmyJ8p=vBpwBy38yhVMCJv8XjrTkrXSUnSGedboCM_Q@mail.gmail.com>
 <Z-EGvjhkg6llyX24@gmail.com>
 <CANn89iL8o0UZTpomaT1oaMxRTBv1YdaXZGwXQn3H0dDO81UyGA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iL8o0UZTpomaT1oaMxRTBv1YdaXZGwXQn3H0dDO81UyGA@mail.gmail.com>


* Eric Dumazet <edumazet@google.com> wrote:

> Do you have a specific case in mind that I can test on these big 
> platforms ?

No. I was thinking of large-scale kprobes or ftrace patching - but you 
are right that the text_mutex should naturally serialize all the 
write-side code here.

Mind adding your second round of test results to the changelog as well, 
which improved per call overhead from 36 to 28 nsecs?

Thanks,

	Ingo

