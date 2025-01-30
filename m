Return-Path: <bpf+bounces-50127-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 638FEA2314C
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 16:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 457807A2FCB
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 15:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169671EE00A;
	Thu, 30 Jan 2025 15:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZELX68b"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795421E9B03;
	Thu, 30 Jan 2025 15:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738252677; cv=none; b=S3wOnlTOG99cZF4CYxKji5B+TqdEiYAvr/R6PCFTAjlUlFaOHs895N3RiPJegLOJNCqEk8vI1KHbzRUiB1sMpPicg9otLTwUT9WfvdUta7f1y+gKCSmParLCWnH1zuUfW1QFlDH/5Nxoo7vYXXB000H9yJx9nUIXjQ7gCNLpgNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738252677; c=relaxed/simple;
	bh=i8cfMs/k9HJ5wm5pHq74kZZOQOiERYPHzA6jXp4N03Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mvKrdX0PsfShrVqjgBnQ2P/yvjgGUjZwAYe/F+IG70/qcE8vnc7XJQ9QJAaMErhx9pkMzQ+ZkM8SrWY3s7XcE+tjBr+SzG8jgdnWRpqODVovSrMn4JLNpSdJkE6Y1UaF2OY0p+khU2HkSx7SBKOt2FKvmaeYiGcteCdUU9UnPeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZELX68b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D945CC4CED2;
	Thu, 30 Jan 2025 15:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738252676;
	bh=i8cfMs/k9HJ5wm5pHq74kZZOQOiERYPHzA6jXp4N03Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WZELX68b1BuCFZFTBIT8CsfTVp+E2ZrNN2lIxjJ6tyVa9RuX8hvCLlIhnkXR2114P
	 eQnACD+XRvnBaXMLOIm65loKNnxebwjCS9q7AMp1in4a1fpL0bpQX1Btsow7GloeeE
	 I0109i9lEDz3KIeVbkmprvXVJTPlsyfUg0l4ZF67bDcFLHL4m8E3xmO0a4CtfcoVPH
	 534AknVwXmLiPmaj3rPfIfcjohMgeAlceGre0tani0Yt5NZPBOJOzWr8uPkQygz+CB
	 Xq8TvGil3tVyjTuqbu0hDgbwa9wA942lBrXj058azAM3IpsvRfZ+SiChT4izoZ0aoY
	 INpOo2br4hsMw==
Date: Thu, 30 Jan 2025 07:57:52 -0800
From: Kees Cook <kees@kernel.org>
To: Eyal Birger <eyal.birger@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, luto@amacapital.net, wad@chromium.org,
	oleg@redhat.com, mhiramat@kernel.org, andrii@kernel.org,
	alexei.starovoitov@gmail.com, cyphar@cyphar.com,
	songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
	peterz@infradead.org, tglx@linutronix.de, bp@alien8.de,
	daniel@iogearbox.net, ast@kernel.org, andrii.nakryiko@gmail.com,
	rostedt@goodmis.org, rafi@rbk.io, shmulik.ladkani@gmail.com,
	bpf@vger.kernel.org, linux-api@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] seccomp: passthrough uretprobe systemcall without
 filtering
Message-ID: <202501300756.E473D10@keescook>
References: <20250128145806.1849977-1-eyal.birger@gmail.com>
 <202501281634.7F398CEA87@keescook>
 <CAHsH6Gsv3DB0O5oiEDsf2+Go4O1+tnKm-Ab0QPyohKSaroSxxA@mail.gmail.com>
 <Z5s3S5X8FYJDAHfR@krava>
 <CAHsH6GvsGbZ4a=-oSpD1j8jx11T=Y4SysAtkzAu+H4_Gh7v3Qg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHsH6GvsGbZ4a=-oSpD1j8jx11T=Y4SysAtkzAu+H4_Gh7v3Qg@mail.gmail.com>

On Thu, Jan 30, 2025 at 07:05:42AM -0800, Eyal Birger wrote:
> So if we go with the suggestion above, we'll support the theoretical
> __NR_uretprobe_32 for filtered seccomp, but not for strict seccomp, and
> that's ok because strict seccomp is less common?

It's so uncommon I regularly consider removing it entirely. :)

> Personally I'd prefer to limit the scope of this fix to the problem we
> are aware of, and not possible problems should someone decide to reimplement
> uretprobes on different archs in a different way. Especially as this fix needs
> to be backmerged to stable kernels.
> So my personal preference would be to avoid __NR_uretprobe_32 in this patch
> and deal with it if it ever gets implemented.

That's fine, but I want the exception to be designed to fail closed
instead of failing open. I think my proposed future-proof check does
this.

-- 
Kees Cook

