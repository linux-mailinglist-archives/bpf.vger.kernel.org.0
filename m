Return-Path: <bpf+bounces-72374-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D503C115D4
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 21:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AD6504E350E
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 20:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8133F2E5427;
	Mon, 27 Oct 2025 20:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TK/1lvPV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CCD2E11DC;
	Mon, 27 Oct 2025 20:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761596396; cv=none; b=r5XjayOQGhAMORq7qso7ct9d8njVe+JnpCogVckAB+4RhExkUtyorr8YISxTMYbl7wmkHu0dMXhPry1B2HFBbIEc7ag9tCE42HYa1Wyk03Tnffznam+HXvj8qnNKhyHUlNLA2MOs61m44UvjrGBrdjlP58SG3iG9dGdt4NJyirM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761596396; c=relaxed/simple;
	bh=jdB4YQDx38o3RWEVrgZJRRJdTY8gR6msi8lansOQMY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wp35cpPuOUZhNUwWai/IgGPEs8Z+NsZ/ohqPnutH2Cg4AI+EOwHqz7PiyST9da+JpiczwS/hJ68IA9Y4NQ99+TB2oCqIz1NtkFo1MFIrlxUOSd3+3hkJfX1wpNHecdXdPPEK/HUIJAzVKTI30durL2UKibz7wO8My4YAm0G9avs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TK/1lvPV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B6CC4CEF1;
	Mon, 27 Oct 2025 20:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761596395;
	bh=jdB4YQDx38o3RWEVrgZJRRJdTY8gR6msi8lansOQMY0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TK/1lvPVloQmwe/67C6AWRQsn4OVdcXE9YdR3f6NrfnErrxKknzylwRA997vpJT6j
	 3dOPaUqL2KNgARRvqopde0IdAHP9+9JenRikszALa51zylCKroBB9rt3CT+rA25Joi
	 8n51K2W8tAKdRJF4BWIi4g4MPyBmM0Zz8kqYS8bFB/cad1xoDbLgb2Z3gLjnHbGur7
	 vhDfOmJWdyp+OBA5xNbjRWnXxaOF7aTY3v8XznyynHsWcqTOw77+T9Q+DfQE9Ql4wd
	 cG9vh+kadwCGf4+NrNkV/m63vvzxYNSqqkK2hSzlkSmuSYY6QZKzLkJarvTWiIxwf8
	 R2/L0HdhTcYCw==
Date: Mon, 27 Oct 2025 13:19:52 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: bot+bpf-ci@kernel.org
Cc: jolsa@kernel.org, mhiramat@kernel.org, rostedt@goodmis.org, 
	song@kernel.org, peterz@infradead.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, yhs@fb.com, songliubraving@fb.com, 
	andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org, 
	eddyz87@gmail.com, yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH 1/3] Revert "perf/x86: Always store regs->ip in
 perf_callchain_kernel()"
Message-ID: <v53j2leswscyunqmrj5zvr3bsdafxlze5z3yp4hvsd6epbvdvm@njx4yhpkqoiz>
References: <20251027131354.1984006-2-jolsa@kernel.org>
 <8227ad3af501bb982231ef00ac5e970a0a12c9d64e07ea3f3d37100ec7e3f1cc@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8227ad3af501bb982231ef00ac5e970a0a12c9d64e07ea3f3d37100ec7e3f1cc@mail.kernel.org>

On Mon, Oct 27, 2025 at 01:52:18PM +0000, bot+bpf-ci@kernel.org wrote:
> Does this revert re-introduce the BPF selftest failure that was fixed in
> 2019? The test tools/testing/selftests/bpf/prog_tests/stacktrace_map_raw_tp.c
> still exists in the kernel tree.

I have the same question.  And note there may be subtle differences
between the frame pointer and ORC unwinders.  The testcase would need to
pass for both.

-- 
Josh

