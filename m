Return-Path: <bpf+bounces-78010-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 17223CFB2A7
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 22:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 75A6930499E8
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 21:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6432D541B;
	Tue,  6 Jan 2026 21:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZ1L//W2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2539528CF5F;
	Tue,  6 Jan 2026 21:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767736413; cv=none; b=R8sac3zVGhf27XD0Q6PkdV3pSp2ZrBchwn265MFBr3Vfg4WDUtkc7qIwlCbt1weQqVqQjJQkbmJI2qV6Cer4J7iYWFsGDkNUOH7EIavyKQ0D+G9AH9cmCjkTGrhIPs8SKmZkQrb2sY+TDd0cJoQPTA9YyquqLaN131GfuCDg/aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767736413; c=relaxed/simple;
	bh=GObAdJ8JSSfAmBfeC4r2nqnb8UXYLYnbOK+COY+zM1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jWnA1oEwgp3hIfmHjhapIRecmivre4uEKNJXoGBmgpvRCcZLTtJc/z4UxIaz2rTby4zASNDblkoq0BZBAe2l6krHPMeK1vWIVLmrtXXEYaqNK8zQp/eWhvrRc4MPTjtWtTd0L53x6u1EUxBSKELOWWV3tg/4fmKntuovv1RKD+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZ1L//W2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A654C19421;
	Tue,  6 Jan 2026 21:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767736412;
	bh=GObAdJ8JSSfAmBfeC4r2nqnb8UXYLYnbOK+COY+zM1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XZ1L//W2d0e2UtEKVm9WsJ88bEVwUM/JNx7/iJXbtprNYHBP//xGYokXhGf5A7J6+
	 UjffmNClpX1H6WRuI25PUfIsmOUh8B309V20aOElJeB7RcUq4xRZO6gRz+ikFYGSfI
	 VLSAyvr/WmwfIHPh+D4N94/61nTTb8ZaBdHqAMqk7Odlh45erz36xf6d21MMG3TyxA
	 7BZOs9I4SG8exu79wb6iMWrlgWuPV1QefE+HD3sLI9Vg7LlW/re/tzpM/4QszgnDoK
	 CTmGF7A4N1a8C/pEHJSnH6KgAVlvP4lVwTo3lxDnykORG9Cz0FA9OR7FzoyXLm9JZJ
	 YcVvs7xx1Wfwg==
Date: Tue, 6 Jan 2026 14:53:27 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH bpf-next] scripts/gen-btf.sh: Disable LTO when generating
 initial .o file
Message-ID: <20260106215327.GA1957425@ax162>
References: <20260105-fix-gen-btf-sh-lto-v1-1-18052ea055a9@kernel.org>
 <ff8187bd-0bae-4b49-8844-6c975a2e79c6@linux.dev>
 <20260105234605.GB1276749@ax162>
 <6908562f-4a99-44ea-bffb-19f33fcffe83@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6908562f-4a99-44ea-bffb-19f33fcffe83@linux.dev>

On Mon, Jan 05, 2026 at 05:06:49PM -0800, Ihor Solodrai wrote:
> I got curious and did a little experiment. Basically, I ran perf stat
> on this part of gen-btf.sh:
> 
> 	echo "" | ${CC} ${CLANG_FLAGS} ${KBUILD_CFLAGS} -c -x c -o ${btf_data} -
> 	${OBJCOPY} --add-section .BTF=${ELF_FILE}.BTF \
> 		--set-section-flags .BTF=alloc,readonly ${btf_data}
> 	${OBJCOPY} --only-section=.BTF --strip-all ${btf_data}
> 
> Replacing ${CC} command with:
> 
> 	${OBJCOPY} --strip-all "${ELF_FILE}" ${btf_data} 2>/dev/null
> 
> for comparison.
> 
> TL;DR is that using ${CC} is:
>   * about 1.5x faster than GNU objcopy --strip-all .tmp_vmlinux1
>   * about 16x (!) faster than llvm-objcopy --strip-all .tmp_vmlinux1
> 
> With obvious caveats that this is a particular machine (Threadripper
> PRO 3975WX), toolchain etc:
>   * clang version 21.1.7
>   * gcc (GCC) 15.2.1 20251211
> 
> This is bpf-next (a069190b590e) with BPF CI-like kconfig.

Oof, that difference between GNU and LLVM's objcopy implementations...
At the same time, it was only a little over a second for llvm-objcopy.
Maybe that gets worse if more is built into the kernel to the point
where it is untenable but maybe it is worth the reduced complexity? That
said, my patch is pretty simple (and a follow up for KBUILD_CPPFLAGS if
needed would be equally simple), your testing demonstrates that there
is some performance improvement, and I cannot imagine there being any
other bugs of this nature in this area going forward. I have no real
strong opinion, I just need my builds to finish :)

Cheers,
Nathan

