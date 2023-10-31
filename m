Return-Path: <bpf+bounces-13754-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4737DD73E
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 21:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25FB91F216B0
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 20:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC23225D1;
	Tue, 31 Oct 2023 20:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="H+Hv2s1i"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8DB1D69C
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 20:46:01 +0000 (UTC)
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88376E4
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 13:46:00 -0700 (PDT)
Message-ID: <ab5a1dcf-7a3f-bc42-a73c-292911d54c18@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1698785157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=POA7nvemuy8WQWxGdl6qCMZwRNtOAMEBu7/eAPxC3Ho=;
	b=H+Hv2s1iyku2yipucvbLIo6IiscjH4Rco6F9NGfCjdwIdXl1rKDTRnmF2ZbAuFpjB6yTXU
	mRRgC+Yv7al4wrPhoqc6lUvyJ6Zy74EzfqmMFaeweA7xsy5pHlg4uLj1G46lo+u9MHR5pI
	mwxjAdfUhvQcj7/c7sxCWOgFa5U8wcA=
Date: Tue, 31 Oct 2023 13:45:50 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Subject: Re: [PATCH bpf-next v8 00/10] Registrating struct_ops types from
 modules
To: thinker.li@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 drosen@google.com
References: <20231030192810.382942-1-thinker.li@gmail.com>
Content-Language: en-US
In-Reply-To: <20231030192810.382942-1-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 10/30/23 12:28 PM, thinker.li@gmail.com wrote:
> Changes from v5:
> 
>   - As the 2nd patch, we introduce "bpf_struct_ops_desc". This change
>     involves moving certain members of "bpf_struct_ops" to
>     "bpf_struct_ops_desc", which becomes a part of
>     "btf_struct_ops_tab". This ensures that these members remain
>     accessible even when the owner module of a "bpf_struct_ops" is
>     unloaded.
> 
>   - Correct the order of arguments when calling
>      in the 3rd patch.
> 
>   - Remove the owner argument from bpf_struct_ops_init_one(). Instead,
>     callers should fill in st_ops->owner.
> 
>   - Make sure to hold the owner module when calling
>     bpf_struct_ops_find() and bpf_struct_ops_find_value() in the 6th
>     patch.
> 
>   - Merge the functions register_bpf_struct_ops_btf() and
>     register_bpf_struct_ops() into a single function and relocate it to
>     btf.c for better organization and clarity.
> 
>   - Undo the name modifications made to find_kernel_btf_id() and

The find_kernel_attach_btf_id name change is still in patch 8. tbh, I don't have 
a strong preference on the name here. Could it be in a separate patch for naming 
cleanup or at least mention it in the commit message?



