Return-Path: <bpf+bounces-77490-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E25CE8386
	for <lists+bpf@lfdr.de>; Mon, 29 Dec 2025 22:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A05513016CF7
	for <lists+bpf@lfdr.de>; Mon, 29 Dec 2025 21:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322192E8897;
	Mon, 29 Dec 2025 21:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwpy8BxB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC481E1C02;
	Mon, 29 Dec 2025 21:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767043784; cv=none; b=WHIGSoL5lvDcB15ptwsVnIE6OpadmxLbDZHzHSZzx9uMSjm05LsiuThELQbHZLoljAvkxjputPolwVHTphYFlmAEZl0m0fBG9oOJJG25lAKhabuwAmD4Zj7J9IKKgTR7PupmC8d1UnQM3moAs1nyEhWRC1Tc/cYkjBmfps5xQ2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767043784; c=relaxed/simple;
	bh=mdzCKbdkjkLWAsXYOk3IU5/RIWJOMHNvZN23/seJpxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E8u82K9kgVC/IBZO8SHkHW0yPnuFhaScWiB/tTtoPogntHoqPj1pZis0ABhOzrquPZrx9GmcKy/tJFShTxqx+fJVZsMmb/0WKgl+sC2dM+a4ZRhlj203lkIEq9W3bjkNTeoVEYsSEBfVgwjauALBAGWrHJtR69v1+6jGwevu104=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mwpy8BxB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 551ADC4CEF7;
	Mon, 29 Dec 2025 21:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767043784;
	bh=mdzCKbdkjkLWAsXYOk3IU5/RIWJOMHNvZN23/seJpxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mwpy8BxBsYaMAFRSH+yepMk2DNRlPqIQmpb4qmlcN4FeCRWDoex5RJ48WypSWoH5H
	 WhFCe/JuqBJZqi/CcW029UZI8ytMDDth8tVcp7HQie21o/+M+V4lpqOPY2RMhCEte3
	 O44PO8lHki2fY9mKtqytGTabhTL4cgJGOpLLjz6JjLa+AkRxspv3TRFuJayXF3cGwP
	 6YmeLdhZltLlnQ/gUqY0fVUrv7m9mXGJ4HEEWidU26Ko8Yks8S67K5fKEYLgXlvI2z
	 6t+nOPVoh4sc834ZyJCce8lGavqhOtosTX8IMRA/Y8w+FGHXdxhp3Fd5qIKaFjZm3m
	 /FzZ1fbsfPc3g==
Date: Mon, 29 Dec 2025 14:29:38 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Yonghong Song <yonghong.song@linux.dev>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org, bpf@vger.kernel.org,
	linux-kbuild@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [RFC PATCH v1] module: Fix kernel panic when a symbol st_shndx
 is out of bounds
Message-ID: <20251229212938.GA2701672@ax162>
References: <20251224005752.201911-1-ihor.solodrai@linux.dev>
 <9edd1395-8651-446b-b056-9428076cd830@linux.dev>
 <af906e9e-8f94-41f5-9100-1a3b4526e220@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af906e9e-8f94-41f5-9100-1a3b4526e220@linux.dev>

Hi Ihor,

On Mon, Dec 29, 2025 at 12:40:10PM -0800, Ihor Solodrai wrote:
> I think the simplest workaround is this one: use objcopy from binutils
> instead of llvm-objcopy when doing --update-section.
> 
> There are just 3 places where that happens, so the OBJCOPY
> substitution is going to be localized.
> 
> Also binutils is a documented requirement for compiling the kernel,
> whether with clang or not [1].
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/changes.rst?h=v6.18#n29

This would necessitate always specifying a CROSS_COMPILE variable when
cross compiling with LLVM=1, which I would really like to avoid. The
LLVM variants have generally been drop in substitutes for several
versions now so some groups such as Android may not even have GNU
binutils installed in their build environment (see a recent build
fix [1]).

I would much prefer detecting llvm-objcopy in Kconfig (such as by
creating CONFIG_OBJCOPY_IS_LLVM using the existing check for
llvm-objcopy in X86_X32_ABI in arch/x86/Kconfig) and requiring a working
copy (>= 22.0.0 presuming the fix is soon merged) or an explicit opt
into GNU objcopy via OBJCOPY=...objcopy for CONFIG_DEBUG_INFO_BTF to be
selectable.

> Patching llvm-objcopy would be great, it should be done. But we are
> still going to be stuck with making sure older LLVMs can build the kernel.
> So even if they backport the fix to v21, it won't help us much, unfortunately.

21.1.8 was the last planned 21.x release [2] so I think it is unlikely
that a 21.1.9 would be released for this but we won't know until it is
merged into main. Much agreed on handling the old versions.

[1]: https://lore.kernel.org/20251218175824.3122690-1-cmllamas@google.com/
[2]: https://discourse.llvm.org/t/llvm-21-1-8-released/89144

Cheers,
Nathan

