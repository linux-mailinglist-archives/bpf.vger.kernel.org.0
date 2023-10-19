Return-Path: <bpf+bounces-12642-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBDC7CEE0E
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 04:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 034A5281E21
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 02:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3669A55;
	Thu, 19 Oct 2023 02:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I2ww7MKP"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE50C80C
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 02:28:35 +0000 (UTC)
Received: from out-204.mta0.migadu.com (out-204.mta0.migadu.com [IPv6:2001:41d0:1004:224b::cc])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3059810F
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 19:28:33 -0700 (PDT)
Message-ID: <44b8676b-fe0e-5f32-508e-7c223fd63213@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1697682511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=clJ9Nu0JgpNXbvQUMAOdiItRY8qKRJVlS2NtOr0Voew=;
	b=I2ww7MKPI1gNCO3rENcHALVLpJ13UG6kP7NZKKKinqU0edIMj7XrDy1c7TE8cPvjd0/xdO
	pDTXAmZ9w0PiuSdcF3xTDoXaGu08gkno6ekYBXCBNdGHY+jcjOp805xHrnybmIe5tXMzhc
	FZoSGiS+dPyfFVBAMKHOI+ZdK+E9RKY=
Date: Wed, 18 Oct 2023 19:28:26 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 2/9] bpf: add struct_ops_tab to btf.
Content-Language: en-US
To: thinker.li@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 drosen@google.com
References: <20231017162306.176586-1-thinker.li@gmail.com>
 <20231017162306.176586-3-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231017162306.176586-3-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 10/17/23 9:22 AM, thinker.li@gmail.com wrote:
> +const struct bpf_struct_ops **btf_get_struct_ops(struct btf *btf, u32 *ret_cnt)
> +{
> +	if (!btf)
> +		return NULL;
> +	if (!btf->struct_ops_tab)
> +		return NULL;
> +
> +	*ret_cnt = btf->struct_ops_tab->cnt;
> +	return (const struct bpf_struct_ops **)btf->struct_ops_tab->ops;

Is it possible that the module is already gone here? If that is the case, the 
st_ops pointer probably cannot be used?

