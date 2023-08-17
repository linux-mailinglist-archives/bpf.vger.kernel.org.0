Return-Path: <bpf+bounces-7942-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A768277EE7E
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 02:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CFA2281D0F
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 00:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B854385;
	Thu, 17 Aug 2023 00:56:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34790379
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 00:56:07 +0000 (UTC)
Received: from out-48.mta0.migadu.com (out-48.mta0.migadu.com [91.218.175.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798B3271E
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 17:56:03 -0700 (PDT)
Message-ID: <4950fffc-4c63-a4f1-f35c-5823e1e4238c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1692233761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fLoIrQO+OFjOwlaE9IPxzHue2PAgP4+i1LKP1HI94wM=;
	b=qMzsFpclKW7cfhcJuMc/T2lYwR7L9H8eENr0jg0KNgKuJrocrZctZ8wdN74S0uwn9Xogr/
	2elZjI8xUpVA8YlIOKSxSt4nRIN9eH1bapbeIBM4aVN6lL/gHXcvEPda43zKiEhdf50tbz
	aAR9k/ceuDTPvNSDZ7pfrXbH7mmSar8=
Date: Wed, 16 Aug 2023 17:55:56 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC bpf-next v3 3/5] bpf: Prevent BPF programs from access the
 buffer pointed by user_optval.
Content-Language: en-US
To: thinker.li@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 sdf@google.com, yonghong.song@linux.dev
References: <20230815174712.660956-1-thinker.li@gmail.com>
 <20230815174712.660956-4-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230815174712.660956-4-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/15/23 10:47 AM, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> Since the buffer pointed by ctx->user_optval is in user space, BPF programs
> in kernel space should not access it directly.  They should use
> bpf_copy_from_user() and bpf_copy_to_user() to move data between user and
> kernel space.
> 
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>   kernel/bpf/cgroup.c   | 16 +++++++++--
>   kernel/bpf/verifier.c | 66 +++++++++++++++++++++----------------------
>   2 files changed, 47 insertions(+), 35 deletions(-)
> 
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index b977768a28e5..425094e071ba 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -2494,12 +2494,24 @@ static bool cg_sockopt_is_valid_access(int off, int size,
>   	case offsetof(struct bpf_sockopt, optval):
>   		if (size != sizeof(__u64))
>   			return false;
> -		info->reg_type = PTR_TO_PACKET;
> +		if (prog->aux->sleepable)
> +			/* Prohibit access to the memory pointed by optval
> +			 * in sleepable programs.
> +			 */
> +			info->reg_type = PTR_TO_PACKET | MEM_USER;

Is MEM_USER needed to call bpf_copy_from_user()?

Also, from looking at patch 4, the optval could be changed from user memory to 
kernel memory during runtime. Is it useful to check MEM_USER during the verifier 
load time?

How about just return false here to disallow sleepable prog to use ->optval and 
->optval_end. Enforce sleepable prog to stay with the bpf_dynptr_read/write API 
and avoid needing the optval + len > optval_end check in the sleepable bpf prog. 
WDYT?

Regarding ->optlen, do you think the sleepable prog can stay with the 
bpf_dynptr_size() and bpf_dynptr_adjust() such that no need to expose optlen to 
the sleepable prog also.

> +		else
> +			info->reg_type = PTR_TO_PACKET;
>   		break;
>   	case offsetof(struct bpf_sockopt, optval_end):
>   		if (size != sizeof(__u64))
>   			return false;
> -		info->reg_type = PTR_TO_PACKET_END;
> +		if (prog->aux->sleepable)
> +			/* Prohibit access to the memory pointed by
> +			 * optval_end in sleepable programs.
> +			 */
> +			info->reg_type = PTR_TO_PACKET_END | MEM_USER;
> +		else
> +			info->reg_type = PTR_TO_PACKET_END;
>   		break;


