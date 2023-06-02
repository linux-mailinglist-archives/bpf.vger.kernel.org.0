Return-Path: <bpf+bounces-1721-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB03C7208BD
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 20:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57E901C2121D
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 18:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F8219E47;
	Fri,  2 Jun 2023 18:02:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD97D332F8
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 18:02:40 +0000 (UTC)
Received: from out-13.mta0.migadu.com (out-13.mta0.migadu.com [91.218.175.13])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC129F
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 11:02:38 -0700 (PDT)
Message-ID: <5abdfec7-99ac-be3a-634c-3eb666538ef4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1685728956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zrGD9OMkGhJtac2x9I9En+gw++jJ6NK7d7RXEiUo6fY=;
	b=fwlZmRSpI5V1nqE1tr6BdKMrLOOdWb0+Xni3pa7m9qvHbL5S8kTk6JyHAwnN66GheaPZxj
	GI0H4WIE0zTLxI9u8C+pFIuuPyNbfPCdiQJsSeoWxrFPFaYRQcHOfGytMrqiEkozwe1Tbl
	cZ4knGRJA9P2KtLhcdFTHSdivFGGYf8=
Date: Fri, 2 Jun 2023 11:02:31 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v2] bpf: Fix UAF in task local storage
Content-Language: en-US
To: KP Singh <kpsingh@kernel.org>
Cc: ast@kernel.org, songliubraving@fb.com, andrii@kernel.org,
 daniel@iogearbox.net, Kuba Piecuch <jpiecuch@google.com>, bpf@vger.kernel.org
References: <20230602002612.1117381-1-kpsingh@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230602002612.1117381-1-kpsingh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 6/1/23 5:26 PM, KP Singh wrote:
> When task local storage was generalized for tracing programs, the
> bpf_task_local_storage callback was moved from a BPF LSM hook
> callback for security_task_free LSM hook to it's own callback. But a
> failure case in bad_fork_cleanup_security was missed which, when
> triggered, led to a dangling task owner pointer and a subsequent
> use-after-free. Move the bpf_task_storage_free to the very end of
> free_task to handle all failure cases.
> 
> This issue was noticed when a BPF LSM program was attached to the
> task_alloc hook on a kernel with KASAN enabled. The program used
> bpf_task_storage_get to copy the task local storage from the current
> task to the new task being created.
> 
> Fixes: a10787e6d58c ("bpf: Enable task local storage for tracing programs")
> Reported-by: Kuba Piecuch <jpiecuch@google.com>
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---
> 
> * v1 -> v2
> 
> Move the bpf_task_storage_free to free_task as suggested by Martin
> 
>   kernel/fork.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index ed4e01daccaa..cb20f9f596d3 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -627,6 +627,7 @@ void free_task(struct task_struct *tsk)
>   	arch_release_task_struct(tsk);
>   	if (tsk->flags & PF_KTHREAD)
>   		free_kthread_struct(tsk);
> +	bpf_task_storage_free(tsk);

Applied. Thanks for the fix.

A followup question, does it need a "notrace" to be added to 
bpf_task_storage_free to ensure no task storage can be recreated?

>   	free_task_struct(tsk);
>   }
>   EXPORT_SYMBOL(free_task);
> @@ -979,7 +980,6 @@ void __put_task_struct(struct task_struct *tsk)
>   	cgroup_free(tsk);
>   	task_numa_free(tsk, true);
>   	security_task_free(tsk);
> -	bpf_task_storage_free(tsk);
>   	exit_creds(tsk);
>   	delayacct_tsk_free(tsk);
>   	put_signal_struct(tsk->signal);


