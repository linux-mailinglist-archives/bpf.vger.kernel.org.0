Return-Path: <bpf+bounces-72308-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06845C0D359
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 12:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F17240391D
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 11:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5B42FB975;
	Mon, 27 Oct 2025 11:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="un3VL6AQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300F31C861D;
	Mon, 27 Oct 2025 11:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761565265; cv=none; b=pZKpsFm4Iu+LsAa2cVF5pn7WLofH/5k0qVzJbFIJ9Hm5DuAIHeodoVF5R4nLYGVUdIBNFz4yKfBZ3ivol05qpC4riFyiPyrMERtSv/HshgN63xoKWpurKQg2UxfMcBH54LbdJJNZR+ZfiipTzcWa4yZ1Hoqgtvn8p96C7WEdglg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761565265; c=relaxed/simple;
	bh=KBLDXLHbdazlrW+FXL+bXINhZTJc3T5Ew2Au7uGeJfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mx2cFmxU4hoJIk5ipRvbEzgE0Eqrhs49zc76yNQ2Cfqcvm6WLAwFEeMUiOlMtDNEsaM8lT3BYz9W+dWfOxtFuRAh1mkz948qzMjtJGxMSXHOzgmD+cJeqBO5iCw+AgPs7ym3IPc59EN5xZmCD8C+WjflynwGAmRiTf/uoE/jecc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=un3VL6AQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D074FC4CEFF;
	Mon, 27 Oct 2025 11:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761565264;
	bh=KBLDXLHbdazlrW+FXL+bXINhZTJc3T5Ew2Au7uGeJfo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=un3VL6AQQXElrnf9m1O8/0ADO3Fliyzgt8rw/1Roo2+xkfxBRC3F679a7DZV16lWT
	 0G5VENgQdCvcg9+XCgu4FDnqECGek7vpCrkGLwYCowBVFLZwJX1On9XUuPUaM5N/KT
	 GbU7WloJ4e7CznciYgTjRfmLGpjQ5NVnS+mIJ6cxaeYmNOmt/dfsuxSsGN72/cPMT2
	 hq2QWDOws8sv6Q0Jsr/EbxTn+B+FMwGdguHR1/BnBzKCjh4RZB/buH1UWUB2Irwy/L
	 6ZMm9OvgCtGBbzGwo9veuyxNNkpklGs2RtN2UVGeLTp0+CbPTh4217bbxqkOVh9yMn
	 GSQRD10EHS+5g==
Message-ID: <2cb226f8-a67c-4bdb-8c59-507c99a46bab@kernel.org>
Date: Mon, 27 Oct 2025 11:41:01 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] bpftool: Build failure due to opensslv.h
To: Namhyung Kim <namhyung@kernel.org>, bpf@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org
References: <aP7uq6eVieG8v_v4@google.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <aP7uq6eVieG8v_v4@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-10-26 21:01 UTC-0700 ~ Namhyung Kim <namhyung@kernel.org>
> Hello,
> 
> I'm seeing a build failure like below in Fedora 40 and others.  I'm not
> sure if it's reported already but it failed to build perf tools due to
> errors in the bootstrap bpftool.
> 
>     CC      /build/util/bpf_skel/.tmp/bootstrap/sign.o
>   sign.c:16:10: fatal error: openssl/opensslv.h: No such file or directory
>      16 | #include <openssl/opensslv.h>
>         |          ^~~~~~~~~~~~~~~~~~~~
>   compilation terminated.
>   make[3]: *** [Makefile:256: /build/util/bpf_skel/.tmp/bootstrap/sign.o] Error 1
>   make[3]: *** Waiting for unfinished jobs....
>   make[2]: *** [Makefile.perf:1213: /build/util/bpf_skel/.tmp/bootstrap/bpftool] Error 2
>   make[1]: *** [Makefile.perf:289: sub-make] Error 2
>   make: *** [Makefile:76: all] Error 2
> 
> I think it's from the recent signing change.  I'm not familiar with
> openssl but I guess there's a proper feature check for it.  Is this a
> known issue?


Hi Namhyung,

This looks related to the program signing change indeed, commit
40863f4d6ef2 ("bpftool: Add support for signing BPF programs")
introduced a dependency on OpenSSL's development headers for bpftool.
It's not gated behind a feature check. On Fedora, I think the headers
come with openssl-devel, do you have this package installed?

Best regards,
Quentin

