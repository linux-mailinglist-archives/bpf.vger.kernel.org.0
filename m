Return-Path: <bpf+bounces-67087-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21237B3DE9F
	for <lists+bpf@lfdr.de>; Mon,  1 Sep 2025 11:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 674B916E95B
	for <lists+bpf@lfdr.de>; Mon,  1 Sep 2025 09:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87EEF2FFDCF;
	Mon,  1 Sep 2025 09:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAo94h+1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA3D2FB628;
	Mon,  1 Sep 2025 09:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756719149; cv=none; b=pebpYM1TcdJqgEzpGxxktjFIbl43VFs6oVi54PW4cNl56dH3wAhlXXJ8HEsYAxUN1Zn7z+l3dZnvNUJUCdO0OEQ58F6zchceaVmQ/3+J9ZCTCC/GUutEFBTglFUfE7FebJJ5vWxTxYpaZ88dNdFUT2NtVGNB/38cv9WGwt6UdRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756719149; c=relaxed/simple;
	bh=VhhYeMrRC/fwBEf0Ah+iiM7Z95AjyWXtGjHLsxUjvkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WHx+8YHLa9io6T4f05PdTWoeL/crL/+/GC5GHCWJc5h4Uk33JMVqItODjeBCN2Ox8NbwaIPjSndp7Pd5INhRHBfhzMkHptXUBvD0ZmbZVtPRQjYlkA9D2UxxvOzY1/k/VCV7QKCzqKulMipD+I1oOSKcQVaX1Kdw1rCDopKEf2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAo94h+1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BB05C4CEF0;
	Mon,  1 Sep 2025 09:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756719148;
	bh=VhhYeMrRC/fwBEf0Ah+iiM7Z95AjyWXtGjHLsxUjvkk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HAo94h+16NWFjhDCZstXk6Rj55lKXvdLQmAFaUON747oEXeDMAIQCbDB4geCtG60B
	 D4IFC30Nok0qrkOKeg96tQVxh97TO2v9lJizUlXPA7G9+KsTi/OcTOt1y5PXW52qIt
	 rTcnAL/LcMiGTL9C8dpIg/BXsRRabxBOpSieJCRkotY/38tZsWPs2L+h2vvpvNpJXF
	 BshAcJUmZkwCj6lA4umPgwyDbCN8Pxc0ZEgEdOOXHivrH/XV2QdWbST8wW4G90XsOt
	 pFC+kwTGm1cJK7baEhiS1olO7Pnn5jvImWSOpMM2/MQw1wcBAobElNfkA8M93aKGvf
	 d/3XambS9ndSA==
Message-ID: <b245b389-e057-40d3-8e2a-7cce5c290c63@kernel.org>
Date: Mon, 1 Sep 2025 10:32:23 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/2] bpftool: Refactor config parsing and add CET
 symbol matching
To: chenyuan_fl@163.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org
Cc: yonghong.song@linux.dev, olsajiri@gmail.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, chenyuan@kylinos.cn
References: <20250829061107.23905-1-chenyuan_fl@163.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20250829061107.23905-1-chenyuan_fl@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-08-29 07:11 UTC+0100 ~ chenyuan_fl@163.com
> From: Yuan CHen <chenyuan@kylinos.cn>
> 
> 1. **Refactor kernel config parsing**  
>    - Moves duplicate config file handling from feature.c to common.c  
>    - Keeps all existing functionality while enabling code reuse  
> 
> 2. **Add CET-aware symbol matching**  
>    - Adjusts kprobe hook detection for x86_64 CET (endbr32/64 prefixes)  
>    - Matches symbols at both original and CET-adjusted addresses  
> 
> Changed in PATCH v4:
> * Refactor repeated code into a function.
> * Add detection for the x86 architecture.
> 
> Changed int PATH v5:
> * Remove detection for the x86 architecture.
> 
>  Changed in PATCH v6:
> * Add new helper patch (1/2) to refactor kernel config reading
> * Use the new read_kernel_config() in CET symbol matching (2/2) to check CONFIG_X86_KERNEL_IBT
> 
> Changed in PATCH v7:
> * Display actual kprobe attachment addresses instead of symbol addresses

Hi Yuan,

Is there any difference between v7 and v8 of your series? They seem
identical, from what I can see.

Quentin

