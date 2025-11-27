Return-Path: <bpf+bounces-75645-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A62DDC8EB0F
	for <lists+bpf@lfdr.de>; Thu, 27 Nov 2025 15:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0518D4E0265
	for <lists+bpf@lfdr.de>; Thu, 27 Nov 2025 14:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA57332903;
	Thu, 27 Nov 2025 14:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=mpi-sp.org header.i=@mpi-sp.org header.b="Cyj7kTQr";
	dkim=pass (4096-bit key) header.d=mpi-sp.org header.i=@mpi-sp.org header.b="Cyj7kTQr"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.mpi-sp.org (smtp.mpi-sp.org [141.5.46.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BD61A9F97
	for <bpf@vger.kernel.org>; Thu, 27 Nov 2025 14:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.5.46.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764252377; cv=none; b=ProN57+Kgi44rUc2kjU/TUi3S+iK9BWef5ZStkIdBXD4r4VZMc68Cqb3PIIkBF97+TDoZAuiqQlRWvDb7ZIeFR283V5LC+b5PtWJDRlEHFC++H4bLzlKjxz59/TEFKPRBp4bxjbR8COHg6j+yyjgOmqcIc/M7xhb9lb21ZLMnZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764252377; c=relaxed/simple;
	bh=7hO0VyY4lhh8DPfAn9+jt8eiwgdRQkC1GLUaR0cPEk8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=l22bqQ0QVm7Vt757khgvyro4PknWDTs68VV5f7VUgHsH4+N+rcrMsCLDO6w/x4U5OXPyGq1rkMk56rW4yqgsUKX/+9LU+PN3lf49/i8+6mcaSmFHt48BGSdOVPGhX/bdXGMeRcBqxWWawrk19rgfHgkLMdQ/2CMgDGQ5FyLNhOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mpi-sp.org; spf=pass smtp.mailfrom=mpi-sp.org; dkim=pass (4096-bit key) header.d=mpi-sp.org header.i=@mpi-sp.org header.b=Cyj7kTQr; dkim=pass (4096-bit key) header.d=mpi-sp.org header.i=@mpi-sp.org header.b=Cyj7kTQr; arc=none smtp.client-ip=141.5.46.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mpi-sp.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpi-sp.org
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mpi-sp.org; s=202211;
	t=1764251954; bh=7hO0VyY4lhh8DPfAn9+jt8eiwgdRQkC1GLUaR0cPEk8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Cyj7kTQrdl5Qw/u9YZp92tHoNx4vzN+NP9Jn+4Fn5MsrgrTafzK5JqL+Fc3Bv0FpP
	 /lUSWYucbBve4g405TqQB51YkcAwevjP0givJY1Tx1KGYsc+Y3ir6kmR0nKdnuAfyE
	 7RxuFm8DpuHaeFk9ObqepymDI7PZz+NOaPQUcowuH6AM60LrNXPNNnGNbV0Y/b7Z2e
	 4h64jbmgTuRbdtS5KSP1urqWSE7J31GlSxzDGJrbKBTSvU3PnBPcxsWoqu0WOQn++l
	 GoNCg0I09I/JM75ocziOUnNyEFyXn4c9qa+T3eBeo5JivBhF0um62BhG7s9LqLIQ+s
	 sst1JzKcltofYZrE7hlR117sOXGbsW11ofo8k4i2AvbygmqVh9bnixhTfOFThZorbg
	 xLbACmlENz5umc8YLiPiSqYi9EPGMz1ugQguanWGrsmGPwhodz3A+qB0DhreUSyNTO
	 hJ2MzpG5jFwgoImg/KifkEp3IkVtmSxrFZefxHCZUIM5iZ5pty2Bbm6wxXQKWx0WLY
	 zfLZj68baMmyiP6iRYGXXelfculp7B2YtxvuYOnl259yfL+QasnC01GRUez+GSkzg0
	 Fy776gV6A1GzPewY/dtl8kGnqcuYFlKry6vBShCd/jGvKMCFVqOKzO6jMjOJ8+fhL2
	 xLUI+oKprPFmZz5FXdiF6big=
Received: from smtp.mpi-sp.org (localhost [127.0.0.1])
	by smtp.mpi-sp.org (Postfix) with ESMTP id A8457880328;
	Thu, 27 Nov 2025 14:59:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mpi-sp.org; s=202211;
	t=1764251954; bh=7hO0VyY4lhh8DPfAn9+jt8eiwgdRQkC1GLUaR0cPEk8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Cyj7kTQrdl5Qw/u9YZp92tHoNx4vzN+NP9Jn+4Fn5MsrgrTafzK5JqL+Fc3Bv0FpP
	 /lUSWYucbBve4g405TqQB51YkcAwevjP0givJY1Tx1KGYsc+Y3ir6kmR0nKdnuAfyE
	 7RxuFm8DpuHaeFk9ObqepymDI7PZz+NOaPQUcowuH6AM60LrNXPNNnGNbV0Y/b7Z2e
	 4h64jbmgTuRbdtS5KSP1urqWSE7J31GlSxzDGJrbKBTSvU3PnBPcxsWoqu0WOQn++l
	 GoNCg0I09I/JM75ocziOUnNyEFyXn4c9qa+T3eBeo5JivBhF0um62BhG7s9LqLIQ+s
	 sst1JzKcltofYZrE7hlR117sOXGbsW11ofo8k4i2AvbygmqVh9bnixhTfOFThZorbg
	 xLbACmlENz5umc8YLiPiSqYi9EPGMz1ugQguanWGrsmGPwhodz3A+qB0DhreUSyNTO
	 hJ2MzpG5jFwgoImg/KifkEp3IkVtmSxrFZefxHCZUIM5iZ5pty2Bbm6wxXQKWx0WLY
	 zfLZj68baMmyiP6iRYGXXelfculp7B2YtxvuYOnl259yfL+QasnC01GRUez+GSkzg0
	 Fy776gV6A1GzPewY/dtl8kGnqcuYFlKry6vBShCd/jGvKMCFVqOKzO6jMjOJ8+fhL2
	 xLUI+oKprPFmZz5FXdiF6big=
Received: from imap.mpi-sp.org (imap.mpi-sp.org [10.100.1.36])
	by smtp.mpi-sp.org (Postfix) with ESMTPSA id 68E4788009C;
	Thu, 27 Nov 2025 14:59:14 +0100 (CET)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 27 Nov 2025 14:59:14 +0100
From: "syeda-mahnur.asif" <syeda-mahnur.asif@mpi-sp.org>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net
Subject: Re: Sanitizer flags an eBPF bug
In-Reply-To: <cd5e012f7d365821707c9788bf382e3b@mpi-sp.org>
References: <cd5e012f7d365821707c9788bf382e3b@mpi-sp.org>
Message-ID: <da6b0f1c28c53e9e39ce3e949b0885c2@mpi-sp.org>
X-Sender: syeda-mahnur.asif@mpi-sp.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP

Hi,

Just wondering if there is any update on this?

Best regards,
Mahnur

On 2025-11-03 15:02, syeda-mahnur.asif wrote:
> Hi,
> 
> I've been playing around with eBPF and have sanitizers enabled, a "BUG: 
> Invalid wait context" is thrown in some specific instances:
> 1. The eBPF program is of Tracing type
> 2. Ringbuf helper functions are used.
> 3. The program is attached to perf_event related symbols in the kernel.
> 
> I'm attaching a folder with two instances of such programs and the info 
> dumped by the sanitizer. The attached files for each instance include:
> 1. bpf_prog(x).c
> 2. bpf_prog(x).o - object file that is compiled with "clang-16 -O2 -g 
> -target bpf -c bpf_progx.c -o bpf_progx.o" and loaded by libbpf (v1.6)
> 3. trig(x).c - File in C that is compiled as a binary and when executed 
> causes the bpf program to run
> 4. dump(x).txt - Sanitizer dump
> 5. vmlinux.h - Specific vmlinux file used in compiling the ebpf program 
> object files
> 
> Happy to provide any other additional info that might be relevant.
> 
> Best regards,
> Mahnur

