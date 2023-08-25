Return-Path: <bpf+bounces-8717-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A067891F1
	for <lists+bpf@lfdr.de>; Sat, 26 Aug 2023 00:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B69B281964
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 22:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B050A18B0E;
	Fri, 25 Aug 2023 22:49:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761CA1C02
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 22:49:43 +0000 (UTC)
Received: from out-248.mta0.migadu.com (out-248.mta0.migadu.com [IPv6:2001:41d0:1004:224b::f8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552E41BCC
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 15:49:42 -0700 (PDT)
Message-ID: <344aad78-c664-728c-44f1-e00373c8579c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1693003780; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yyM5CjZdyvP5rbAa1eGoL16wDZDIwfu/Pz/4Vy+B1PI=;
	b=jjI2aEqOzonYps2WFePyrM2cbDxW6eEJ8rQWsedwz5vISS65T3qNCL5Ykplu562yRUsZ06
	b3QiS6m94CigftlW2tRerzt0jL15zxJIs6FGD+SsBLXqDUHEg+fpOxlPGAOm5o7XEJLvKu
	KlV07GP1BzbUGtk8N0Lv/Laf90T2oWI=
Date: Fri, 25 Aug 2023 15:49:35 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH 3/6] bpf: task_group_seq_get_next: fix the
 skip_if_dup_files check
Content-Language: en-US
To: Oleg Nesterov <oleg@redhat.com>, Andrew Morton
 <akpm@linux-foundation.org>, Yonghong Song <yhs@fb.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Kui-Feng Lee <kuifeng@fb.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230825161947.GA16871@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230825161947.GA16871@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/25/23 9:19 AM, Oleg Nesterov wrote:
> Unless I am notally confused it is wrong. We are going to return or
> skip next_task so we need to check next_task-files, not task->files.

Thanks for capturing this. This is indeed an oversight.

Acked-by: Yonghong Song <yonghong.song@linux.dev>

> 
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>   kernel/bpf/task_iter.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index 1589ec3faded..2264870ae3fc 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c
> @@ -82,7 +82,7 @@ static struct task_struct *task_group_seq_get_next(struct bpf_iter_seq_task_comm
>   
>   	common->pid_visiting = *tid;
>   
> -	if (skip_if_dup_files && task->files == task->group_leader->files) {
> +	if (skip_if_dup_files && next_task->files == next_task->group_leader->files) {
>   		task = next_task;
>   		goto retry;
>   	}

