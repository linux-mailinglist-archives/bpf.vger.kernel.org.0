Return-Path: <bpf+bounces-51063-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 650CAA2FE04
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 00:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2F081882C94
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 23:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D9925A2D3;
	Mon, 10 Feb 2025 23:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tNgDqcQI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25837253F17;
	Mon, 10 Feb 2025 23:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739228401; cv=none; b=ktWp8hzHAoPp5DSMzcO8fTV1D+9C88S5TODPhilsH3/OMcGsYNBE6ZSTLoyk84I5T+CTh7GEu0jaiVTwNBf4KmRiV+ebDJoRnF31BHkF5pJAI6V8mJyw84wS64a1GoQx/cV0idiuA8+OenCNBovSsm/gokhWUVAbkINBecpvryw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739228401; c=relaxed/simple;
	bh=0rE+Rn4+R24XrXxcmvhHlop4eurRlCyPiJsC0nhoALc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U8OBuwuOYVAO2H59pGUoGCXvZe2SHe0ZBtHtungbzRgEKCNunxVwp279/b5Pl3cA7bB96TRwFdWBpB65oOEt5lXkroKTV9UJyhjq3rtXoQK1O7tw9Z2HRHhe4OLEP/vID+1lFv/0a8Mf0067amZd01alXE4o5JwdIq1nou2BR58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tNgDqcQI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DEA6C4CED1;
	Mon, 10 Feb 2025 23:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739228400;
	bh=0rE+Rn4+R24XrXxcmvhHlop4eurRlCyPiJsC0nhoALc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tNgDqcQIjZkOdmh03xA88KIcIu6LXxfP8MRXXNXmzwj4eThqSbW8oEjmyP9M4jXUf
	 1xqLWo/scGS6ImZBo7TNQgZTZuK8pDahX7t6rYUoHwER/jaQKMzC4YbJCTepxnBEUV
	 +CuhoHbVnnNmfjKKKavOabfyMDGqAB8e8LEEXrF4kNIX9c27pKaPBbO/DNod/KhW9f
	 uLlFrja3vdjLsPICCRFXSGVEBnY4tjwN9VVe5XD8KGcEegELAcf2jDHy/PYsi4WeoI
	 u+c1cyheDPBeehiRrvU8NtULdAxmOgkLIHTo9jqTziMVzquppwui/niCB1WLTLoYbp
	 3Sze9qUfy649g==
Date: Mon, 10 Feb 2025 15:00:00 -0800
From: Kees Cook <kees@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eyal Birger <eyal.birger@gmail.com>, stable@vger.kernel.org,
	Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	x86@kernel.org, bpf@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
	Deepak Gupta <debug@rivosinc.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH bpf-next] uprobes: Harden uretprobe syscall trampoline
 check
Message-ID: <202502101459.3B6568A@keescook>
References: <20250209220515.2554058-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250209220515.2554058-1-jolsa@kernel.org>

On Sun, Feb 09, 2025 at 11:05:15PM +0100, Jiri Olsa wrote:
> Jann reported [1] possible issue when trampoline_check_ip returns
> address near the bottom of the address space that is allowed to
> call into the syscall if uretprobes are not set up.
> 
> Though the mmap minimum address restrictions will typically prevent
> creating mappings there, let's make sure uretprobe syscall checks
> for that.
> 
> [1] https://lore.kernel.org/bpf/202502081235.5A6F352985@keescook/T/#m9d416df341b8fbc11737dacbcd29f0054413cbbf
> Cc: Kees Cook <kees@kernel.org>
> Cc: Eyal Birger <eyal.birger@gmail.com>
> Cc: stable@vger.kernel.org
> Reported-by: Jann Horn <jannh@google.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Thanks for this!

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

