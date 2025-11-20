Return-Path: <bpf+bounces-75210-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AA5C76B05
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 00:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4A77B4E5A02
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 23:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142AB314D37;
	Thu, 20 Nov 2025 23:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sAwJ992o"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91ACD30F534
	for <bpf@vger.kernel.org>; Thu, 20 Nov 2025 23:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763682817; cv=none; b=AMxq5eqhIvpoQq8A1k5Uj447KiZvd9ew2b5r5Jspbin7ltRtMI87k5S7cHyf2k1TvsiP5iW+upJVEXueYGkkjDB9nz77XgDZH2oXQjig2xSswUSQsJkgHjpCza4FHUa8GR5YDA1zPpJfm1Z+URNDVs6arzX3I4aPL/Q8nGoBncA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763682817; c=relaxed/simple;
	bh=6MkpqLYBeUtZW2FisGc29Gg2U3zosEG3DPmCkwUavL4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=V3CndSWdTVNGbS1txP4fhV4fra9vR57tAc/dVn8FdDLG+YEYbmNhFKU9ecDFp8fm/PAKR54hfdb2VnmrWB7rkjk3IhktDlCJYtgSLasklPJUb8EJeWkJiJ5rd4xNs1DopfMnNrjZ+dfENpne3atp/9I4KHXvgCaXAV5Ybh37NFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sAwJ992o; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1bb340a3-2225-46e8-95a9-1923d737442c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763682811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/yO+eS6R173QWAxVtikFMZODumfxV4GmJp16Uo4SFO8=;
	b=sAwJ992oVvr+0FVjRwdDxSvSj+Vekrsc7lpXfNVaf24N5KssbfOguyBij04j6fsTa+4TVM
	TWCHXk4vYZ1mkHiIm/zwXBj+amjITZIkBuYFnMvp71aDIRwTz4ucT3NLUGpgDLIvnPpSNa
	96SuYf5qxSFz4U8i+B6CHBDdHXO7YsQ=
Date: Thu, 20 Nov 2025 15:53:23 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH v7 3/7] tools/resolve_btfids: Add --btf_sort option
 for BTF name sorting
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Donglin Peng <dolinux.peng@gmail.com>, ast@kernel.org,
 andrii.nakryiko@gmail.com, eddyz87@gmail.com
Cc: zhangxiaoqin@xiaomi.com, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Donglin Peng <pengdonglin@xiaomi.com>,
 Alan Maguire <alan.maguire@oracle.com>, Song Liu <song@kernel.org>
References: <20251119031531.1817099-1-dolinux.peng@gmail.com>
 <20251119031531.1817099-4-dolinux.peng@gmail.com>
 <854f468a-d178-40f4-aa03-e19ff82a1a35@linux.dev>
Content-Language: en-US
In-Reply-To: <854f468a-d178-40f4-aa03-e19ff82a1a35@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/20/25 1:34 PM, Ihor Solodrai wrote:
> On 11/18/25 7:15 PM, Donglin Peng wrote:
>> From: Donglin Peng <pengdonglin@xiaomi.com>
>>
>> This patch introduces a new --btf_sort option that leverages libbpf's
>> btf__permute interface to reorganize BTF layout. The implementation
>> sorts BTF types by name in ascending order, placing anonymous types at
>> the end to enable efficient binary search lookup.
>>
>> [...]
>>
>> +}
>> +
>> +static int update_btf_section(const char *path, const struct btf *btf,
> 
> Hi Dongling.
> 
> Thanks for working on this, it's a great optimization. Just want to
> give you a heads up that I am preparing a patchset changing
> resolve_btfids behavior.
> 
> In particular, instead of updating the .BTF_ids section (and now with
> your and upcoming changes the .BTF section) *in-place*, resolve_btfids
> will only emit the data for the sections. And then it'll be integrated
> into vmlinux with objcopy and linker. We already do a similar thing
> with .BTF for vmlinux [1].
> 
> For your patchset it means that the parts handling ELF update will be
> unnecessary.
> 
> Also I think the --btf_sort flag is unnecessary. We probably want
> kernel BTF to always be sorted in this way. And if resolve_btfids will
> be handling more btf2btf transformation, we should avoid adding a
> flags for every one of them.

The same applies to --distilled_base.

AFAIU we always want to do it, so there is not need for the
flag. Unless there is a strong use case for generating module BTF
*without* the distilled base that I am not aware of.

Maybe an explicit "--kmodule" flag would be appropriate?..
For resolve_btfids, is it reasonable to assume it's a module if --base
is passed in?

Andrii, Eduard, wdyt?

> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/scripts/link-vmlinux.sh#n110
> 
> 

