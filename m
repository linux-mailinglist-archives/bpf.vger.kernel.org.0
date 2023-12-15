Return-Path: <bpf+bounces-17931-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5C7813F86
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 02:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52678283F15
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 01:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB484805;
	Fri, 15 Dec 2023 01:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AeldpVZq"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22ADF7E4
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 01:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ffc2c128-33b7-4599-8ca4-122521da52ab@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702605561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pg/7sdWQn9efhIXM5pI6MGJhm8+O5D3sVtRGM6gorT4=;
	b=AeldpVZq5tLyM5uHhsH9jjKs5Wprt80CpzUb0P4Zl00B7++mXtjeC5j+oHpASEiKb4znp7
	3Y1xF9h99m7zBAYhlVI7/5otNwusiqDwWz6xnkRN/D7bpSlWXvHALe9/MOfqWxmJuJf1i6
	MvecMAIog5a+HQQthbY4KKq/2aaFY7k=
Date: Thu, 14 Dec 2023 17:59:13 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v13 02/14] bpf: get type information with
 BPF_ID_LIST
Content-Language: en-US
To: thinker.li@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 drosen@google.com
References: <20231209002709.535966-1-thinker.li@gmail.com>
 <20231209002709.535966-3-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231209002709.535966-3-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/8/23 4:26 PM, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> Get ready to remove bpf_struct_ops_init() in the future. By using
> BPF_ID_LIST, it is possible to gather type information while building

s/BPF_ID_LIST/BTF_ID_LIST.

The same for the patch subject.

> +BTF_ID_LIST(st_ops_ids)
> +BTF_ID(struct, module)


