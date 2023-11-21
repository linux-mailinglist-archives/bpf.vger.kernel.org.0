Return-Path: <bpf+bounces-15597-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1A47F37CE
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 22:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C5411C20906
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 21:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846C95103A;
	Tue, 21 Nov 2023 21:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Byq3H9b+"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070871A3
	for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 13:03:57 -0800 (PST)
Message-ID: <49538852-1ca0-49bb-86c2-cb1b95739b91@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1700600636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a/EP9bzttwvfqDFCQaIFuoHqmW27VAkLQXuTgHfmiVs=;
	b=Byq3H9b+AoLk5RvWFliQvg4zfpk8qhapUx89tnpGIFwWrXV/XSXLuo3Ohl/x0S6eg0Xt4J
	HJJIwKGzryBe2AgabM5IgbaiEYCsY829eLoVKylXnxeRoZyjiF61Gcxi+b0XXVrVbPa59S
	3NckR3O2FNurL1MLuTYFG7Q5pEXbgaA=
Date: Tue, 21 Nov 2023 13:03:49 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/2] bpf: bring back removal of dev-bound id from
 idr
Content-Language: en-US
To: Stanislav Fomichev <sdf@google.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, song@kernel.org,
 yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
 jolsa@kernel.org, bpf@vger.kernel.org
References: <20231114045453.1816995-1-sdf@google.com>
 <20231114045453.1816995-3-sdf@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231114045453.1816995-3-sdf@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/13/23 8:54 PM, Stanislav Fomichev wrote:
> Commit ef01f4e25c17 ("bpf: restore the ebpf program ID for BPF_AUDIT_UNLOAD
> and PERF_BPF_EVENT_PROG_UNLOAD") stopped removing program's id from
> idr when the offloaded/bound netdev goes away. I was supposed to
> take a look and check in [0], but apparently I did not.
> 
> The purpose of idr removal is to avoid BPF_PROG_GET_NEXT_ID returning
> stale ids for the programs that have a dead netdev. This functionality

What may be wrong if BPF_PROG_GET_NEXT_ID returns the id?
e.g. If the prog is pinned somewhere, it may be useful to know a prog is still 
loaded in the system.

Does the fixes mean to be for the bpf tree instead?

> is verified by test_offload.py, but we don't run this test in the CI.
> 
> Introduce new bpf_prog_remove_from_idr which takes care of correctly
> dealing with potential double idr_remove() via separate skip_idr_remove
> flag in the aux.
> 
> Verified by running the test manually:
> test_offload.py: OK
> 
> 0: https://lore.kernel.org/all/CAKH8qBtyR20ZWAc11z1-6pGb3Hd47AQUTbE_cfoktG59TqaJ7Q@mail.gmail.com/
> 
> Fixes: ef01f4e25c17 ("bpf: restore the ebpf program ID for BPF_AUDIT_UNLOAD and PERF_BPF_EVENT_PROG_UNLOAD")
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> ---
>   include/linux/bpf.h  |  2 ++
>   kernel/bpf/offload.c |  3 +++
>   kernel/bpf/syscall.c | 15 +++++++++++----
>   3 files changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 4001d11be151..d2aa4b59bf1e 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1414,6 +1414,7 @@ struct bpf_prog_aux {
>   	bool xdp_has_frags;
>   	bool exception_cb;
>   	bool exception_boundary;
> +	bool skip_idr_remove;
>   	/* BTF_KIND_FUNC_PROTO for valid attach_btf_id */
>   	const struct btf_type *attach_func_proto;
>   	/* function name for valid attach_btf_id */
> @@ -2049,6 +2050,7 @@ void bpf_prog_inc(struct bpf_prog *prog);
>   struct bpf_prog * __must_check bpf_prog_inc_not_zero(struct bpf_prog *prog);
>   void bpf_prog_put(struct bpf_prog *prog);
>   
> +void bpf_prog_remove_from_idr(struct bpf_prog *prog);
>   void bpf_prog_free_id(struct bpf_prog *prog);
>   void bpf_map_free_id(struct bpf_map *map);
>   


