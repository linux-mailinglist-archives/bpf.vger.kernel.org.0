Return-Path: <bpf+bounces-17937-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B434F813FAF
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 03:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 694C01F22D6E
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 02:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CDD806;
	Fri, 15 Dec 2023 02:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="d9zCFlQ4"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C6C7E4
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 02:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <466399be-c571-48af-8f48-8365689d4d20@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702606937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EAAYsQq6AR6G1Bvu4gtVE3F+g7cVhMYdfEMc9tFxqRk=;
	b=d9zCFlQ4vGyrhlGgQYUOsCwBUYt0vFRyanqXhqXjrxDgu1MQgWg8w97MJSuT5WETy82Hfz
	hL2Z60nYQkgexdSn5Fg/MdOVhsojPccT/1K8JszcZVN3ZwGjmVSjtbSg0yDPcE4iMi2Iad
	h3LFKNCx5Kx0w9wAU1yXm4usysrl1Rg=
Date: Thu, 14 Dec 2023 18:22:09 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v13 04/14] bpf: add struct_ops_tab to btf.
Content-Language: en-US
To: thinker.li@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 drosen@google.com
References: <20231209002709.535966-1-thinker.li@gmail.com>
 <20231209002709.535966-5-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231209002709.535966-5-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/8/23 4:26 PM, thinker.li@gmail.com wrote:
> +const struct bpf_struct_ops_desc *btf_get_struct_ops(struct btf *btf, u32 *ret_cnt)
> +{
> +	if (!btf)
> +		return NULL;
> +	if (!btf->struct_ops_tab)

		*ret_cnt = 0;

unless the later patch checks the return value NULL before using *ret_cnt.
Anyway, better to set *ret_cnt to 0 if the btf has no struct_ops.

The same should go for the "!btf" case above but I suspect the above !btf check 
is unnecessary also and the caller should have checked for !btf itself instead 
of expecting a list of struct_ops from a NULL btf. Lets continue the review on 
the later patches for now to confirm where the above !btf case might happen.

> +		return NULL;
> +
> +	*ret_cnt = btf->struct_ops_tab->cnt;
> +	return (const struct bpf_struct_ops_desc *)btf->struct_ops_tab->ops;
> +}


