Return-Path: <bpf+bounces-13694-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8657DC6AC
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 07:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4476B20FFA
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 06:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D08110783;
	Tue, 31 Oct 2023 06:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Aq783cqI"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CA3360
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 06:41:06 +0000 (UTC)
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7381AC1
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 23:41:03 -0700 (PDT)
Message-ID: <bb7bbfa2-94b1-041d-7255-bb8c7e56e6c7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1698734461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lJm3xLpQzaCUN5yTkvDn+NX51WdmbJQKoitQOdJMyLc=;
	b=Aq783cqIF3iWMchuBCXKawlqExgju9Q4MdNyH6MR56l8eD8TXFiylCs9gLhHhW2OwNmszW
	4LAy096HdGsEHDH87eRCWjh/zWoenvnEbECaiQNHL2gG6+SKMWdxNnKberVSEjNmO+QkXL
	Uok4R/qdCL1yvniP6tZuDJe7aMt9ydU=
Date: Mon, 30 Oct 2023 23:40:57 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v8 02/10] bpf, net: introduce
 bpf_struct_ops_desc.
Content-Language: en-US
To: thinker.li@gmail.com, bpf@vger.kernel.org, ast@kernel.org,
 song@kernel.org, kernel-team@meta.com, andrii@kernel.org, drosen@google.com
Cc: sinquersw@gmail.com, kuifeng@meta.com, netdev@vger.kernel.org
References: <20231030192810.382942-1-thinker.li@gmail.com>
 <20231030192810.382942-3-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231030192810.382942-3-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 10/30/23 12:28 PM, thinker.li@gmail.com wrote:
> +static void bpf_struct_ops_init_one(struct bpf_struct_ops_desc *st_ops_desc,
>   				    struct btf *btf,
>   				    struct bpf_verifier_log *log)

nit. I think this should be renamed to bpf_struct_ops_desc_init() instead. It is 
initializing 'struct bpf_struct_ops_desc' now.


