Return-Path: <bpf+bounces-19501-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9B582C8AF
	for <lists+bpf@lfdr.de>; Sat, 13 Jan 2024 02:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B4B3287493
	for <lists+bpf@lfdr.de>; Sat, 13 Jan 2024 01:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5166011CA1;
	Sat, 13 Jan 2024 01:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="q6W2D3gh"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C521A713
	for <bpf@vger.kernel.org>; Sat, 13 Jan 2024 01:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fcfa92e1-ac0e-4347-8021-99ad5c8d918c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705109063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4bL4S/jroxJgoBeuPGxDevD38iVLhJSNNIyAPOZuboU=;
	b=q6W2D3ghwcXELWP75MDz7TKwhsJ0pRn2KC7h6uKAg23K3L4pPXq97mayvb1oh3usRPIfjR
	Ci00GVfjrJ4EgoFoKE/MCenD+hSpfhx+0FpUNCOgq+6mSJWFTTX6stWzeKX2Ru11uXF+mh
	EP5z/fMhwIWpojSeQEfqfdqxv5+/EDM=
Date: Fri, 12 Jan 2024 17:24:18 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: Minor improvements for bpf_cmp.
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
 kernel-team@fb.com
References: <20240112220134.71209-1-alexei.starovoitov@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240112220134.71209-1-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 1/12/24 2:01 PM, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>
> Few minor improvements for bpf_cmp() macro:
> . reduce number of args in __bpf_cmp()
> . rename NOFLIP to UNLIKELY
> . add a comment about 64-bit truncation in "i" constraint
> . use "ri" constraint for sizeof(rhs) <= 4
> . improve error message for bpf_cmp_likely()
>
> Before:
> progs/iters_task_vma.c:31:7: error: variable 'ret' is uninitialized when used here [-Werror,-Wuninitialized]
>     31 |                 if (bpf_cmp_likely(seen, <==, 1000))
>        |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../bpf/bpf_experimental.h:325:3: note: expanded from macro 'bpf_cmp_likely'
>    325 |                 ret;
>        |                 ^~~
> progs/iters_task_vma.c:31:7: note: variable 'ret' is declared here
> ../bpf/bpf_experimental.h:310:3: note: expanded from macro 'bpf_cmp_likely'
>    310 |                 bool ret;
>        |                 ^
>
> After:
> progs/iters_task_vma.c:31:7: error: invalid operand for instruction
>     31 |                 if (bpf_cmp_likely(seen, <==, 1000))
>        |                     ^
> ../bpf/bpf_experimental.h:324:17: note: expanded from macro 'bpf_cmp_likely'
>    324 |                         asm volatile("r0 " #OP " invalid compare");
>        |                                      ^
> <inline asm>:1:5: note: instantiated into assembly here
>      1 |         r0 <== invalid compare
>        |            ^
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


