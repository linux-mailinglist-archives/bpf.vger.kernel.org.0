Return-Path: <bpf+bounces-14673-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B3A7E769C
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 02:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55605B21082
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 01:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8629EA6;
	Fri, 10 Nov 2023 01:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cXFGdhHw"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD18EA46
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 01:35:41 +0000 (UTC)
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [IPv6:2001:41d0:1004:224b::ba])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D64F25B8
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 17:35:40 -0800 (PST)
Message-ID: <84874366-e0bd-14ea-755b-c6151f1e28b1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1699580139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r5Zi2W0LH3NZDXKQuZZ2Zp2YOdY9rHPG/cbM/uiXudw=;
	b=cXFGdhHwOBRQZnOefjI78LEexy7/2eR7Ds2EvehVNyKo0I9TObgJEJuFGJoXwzyram/daj
	+ozQSrj27ktdvGFl0dM6pDcFhN2zxDykNWHalZDE1eKh1znVX0GbdyEc8VzQH5B7xfHSyd
	wmZUXPyrkoLgEKKyrJL742lzeICh224=
Date: Thu, 9 Nov 2023 17:35:33 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v11 04/13] bpf: add struct_ops_tab to btf.
Content-Language: en-US
To: thinker.li@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 drosen@google.com
References: <20231106201252.1568931-1-thinker.li@gmail.com>
 <20231106201252.1568931-5-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231106201252.1568931-5-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 11/6/23 12:12 PM, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> Maintain a registry of registered struct_ops types in the per-btf (module)
> struct_ops_tab. This registry allows for easy lookup of struct_ops types
> that are registered by a specific module.
> 
> It is a preparation work for supporting kernel module struct_ops in a
> latter patch. Each struct_ops will be registered under its own kernel
> module btf and will be stored in the newly added btf->struct_ops_tab. The
> bpf verifier and bpf syscall (e.g. prog and map cmd) can find the
> struct_ops and its btf type/size/id... information from
> btf->struct_ops_tab.
> 
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>   include/linux/btf.h |  8 +++++
>   kernel/bpf/btf.c    | 83 +++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 91 insertions(+)
> 
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index c2231c64d60b..07ee6740e06a 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -572,4 +572,12 @@ static inline bool btf_type_is_struct_ptr(struct btf *btf, const struct btf_type
>   	return btf_type_is_struct(t);
>   }
>   
> +#ifdef CONFIG_BPF_JIT

There are many new ifdef CONFIG_BPF_JIT in btf.{h,c}. Could it be avoided? For 
example, having an empty bpf_struct_ops_desc_init() for the not CONFIG_BPF_JIT 
case, is it enough?


> +struct bpf_struct_ops_desc;
> +
> +const struct bpf_struct_ops_desc *
> +btf_get_struct_ops(struct btf *btf, u32 *ret_cnt);
> +
> +#endif /* CONFIG_BPF_JIT */
> +
>   #endif


