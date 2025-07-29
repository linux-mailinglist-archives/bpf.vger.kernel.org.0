Return-Path: <bpf+bounces-64587-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC27B146BC
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 05:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D928F5413D7
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 03:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D702144C9;
	Tue, 29 Jul 2025 03:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PiwpeDY1"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D6E286A9
	for <bpf@vger.kernel.org>; Tue, 29 Jul 2025 03:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753759198; cv=none; b=qZCQTnoVX/8haNm+eO5zNsYXmzpaxKRXzcns6nsmE8e9+bjO9pkPswAHcJLSzFgbmi4RDQiI3c24I7MQASC82Ylr2l8Hrf53zc5ENBKfqvHK+62G4CAvVZmVAh3ZqZy2fGrUNeG+ZE4BZrZkMe3vwqiwq0sdZ5gI3n4JhjS6R3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753759198; c=relaxed/simple;
	bh=rfLkZfNRgVzhPd4eKZPjv4mzfJ2NW8TKmWVYs6DJtGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BTUpbovZpXWu0E1WPqKuFa75Wp+s9GfIjZ1xvo8tVDq2yt6HcMjAJGRpNNXbkrRxeBSyLNhqrkNbK0TtNvjAv89yEZoTX0s2G2+dUJGYGaLeGA8+HiRN5Fv0gbSty64GQZQbZxWSeP7qGahT7X4Q2mPsYg2Jn6hrAIiGAOS1Mkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PiwpeDY1; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f7553b3f-5827-4f50-81a9-9bd0802734b9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753759184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RW898mCt+fN2SNRHEY5+Ml/7rpCL6yX8PIkPWvoow54=;
	b=PiwpeDY1Wih6Kg7VwwjJSKqyljFaWpTLoQCXvpLWya6Dv3ZwLC0viD9BjsBOaMaLfaVD92
	TMUTrpYe+tumajo2sl4KqHts3aPzeQQvrAO2N7JWgEYSVCTH7U41qqmvcKVG9SAlVvoq54
	8um1PupJvMe47FefACHFscngeJpyMxk=
Date: Mon, 28 Jul 2025 20:19:37 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH dwarves v2] btf_encoder: group all function ELF syms by
 function name
To: alan.maguire@oracle.com, olsajiri@gmail.com, dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org, acme@kernel.org, andrii@kernel.org, ast@kernel.org,
 eddyz87@gmail.com, menglong8.dong@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kernel-team@meta.com
References: <20250729020308.103139-1-isolodrai@meta.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20250729020308.103139-1-isolodrai@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/28/25 7:03 PM, Ihor Solodrai wrote:
> btf_encoder collects function ELF symbols into a table, which is later
> used for processing DWARF data and determining whether a function can
> be added to BTF.
> 
> So far the ELF symbol name was used as a key for search in this table,
> and a search by prefix match was attempted in cases when ELF symbol
> name has a compiler-generated suffix.
> 
> This implementation has bugs [1][2], causing some functions to be
> inappropriately excluded from (or included into) BTF.
> 
> Rework the implementation of the ELF functions table. Use a name of a
> function without any suffix - symbol name before the first occurrence
> of '.' - as a key. This way btf_encoder__find_function() always
> returns a valid elf_function object (or NULL).
> 
> Collect an array of symbol name + address pairs from GElf_Sym for each
> elf_function when building the elf_functions table.
> 
> Introduce ambiguous_addr flag to the btf_encoder_func_state. It is set
> when the function is saved by examining the array of ELF symbols in
> elf_function__has_ambiguous_address(). It tests whether there is only
> one unique address for this function name, taking into account that
> some addresses associated with it are not relevant:
>    * ".cold" suffix indicates a piece of hot/cold split
>    * ".part" suffix indicates a piece of partial inline
> 
> When inspecting symbol name we have to search for any occurrence of
> the target suffix, as opposed to testing the entire suffix, or the end
> of a string. This is because suffixes may be combined by the compiler,
> for example producing ".isra0.cold", and the conclusion will be
> incorrect.
> 
> In saved_functions_combine() check ambiguous_addr when deciding
> whether a function should be included in BTF.
> 
> Successful CI run: https://github.com/acmel/dwarves/pull/68/checks
> 
> I manually spot checked some of the ~200 functions from vmlinux (BPF
> CI-like kconfig) that are now excluded: all of those that I checked
> had multiple addresses, and some where static functions from different
> files with the same name.
> 
> [1] https://lore.kernel.org/bpf/2f8c792e-9675-4385-b1cb-10266c72bd45@linux.dev/
> [2] https://lore.kernel.org/dwarves/6b4fda90fbf8f6aeeb2732bbfb6e81ba5669e2f3@linux.dev/
> 
> v1: https://lore.kernel.org/dwarves/98f41eaf6dd364745013650d58c5f254a592221c@linux.dev/
> Signed-off-by: Ihor Solodrai <isolodrai@meta.com>
> [...]

Not sure what's wrong, but it appears this message can't reach
vger.kernel.org, or maybe is spam filtered.

I sent to vger.kernel.org from @meta.com email in the past w/o issues.

Any suggestions?..


