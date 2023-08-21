Return-Path: <bpf+bounces-8186-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B95C7833A4
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 22:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E87B1280E51
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 20:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A20611715;
	Mon, 21 Aug 2023 20:32:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84E88C0F
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 20:32:57 +0000 (UTC)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE63493;
	Mon, 21 Aug 2023 13:32:55 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6bcb5df95c5so3029954a34.1;
        Mon, 21 Aug 2023 13:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692649975; x=1693254775;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NbrQZALcwelsR0+pvsw61deeIy/FCIz1GAgR66KHWmg=;
        b=egKdjIRhpxyg8iN0QRzuS6Alha5+f/VaFUqchHHD6jfCtAp3x9MA8eZiBl4y2pCIy5
         bFwevCLsoUubQR10lbDjQA6jvmxqaUR8tLU78r5coD2aDc9NIPxwYlaWNE13JYDPiQmN
         IBDw9Y+ZlmS6JiZz4qHwbSd7BL7O9cj86BmrJN3irBA+BanG9qOql9Rmly1f/FhTE5i6
         mxkyrhkvX+jU0sWDI+Mc4vaJL6z3aB9T4fht99sOy2hrPrP+gFoXRQtLVX/gaYvaoZjL
         54Q4hYAOOKjfDBYdigrkMKX68Q5m4JkqYsg50nJd33lKbXYxRoVIzBY2+kfJGSYry7OO
         DbWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692649975; x=1693254775;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NbrQZALcwelsR0+pvsw61deeIy/FCIz1GAgR66KHWmg=;
        b=Rb3yJp8kMZg8x2B/0WBMT7ZJbwuOqxljE7LWJR8VqgnILLTtMVtDeHgyi+e4FQsBGr
         ODcOCdNCK6pO3mvqYNs2noPUFtOYCjCv5/toOwnxqKRBz0vBWjBRY4iA8B1p0rFJfgDA
         0rb4gYCvS85AhC9yTZ+kvpe60mAzGTetKI1dgAUoeMOeILO93FSoYNjxHDUVHyn3lQGh
         6IqsJ5x+x+fTR7JORYmMPwNNizcI8a0udJXaXGwxiwRrolws4qi37sIpyhHVzBwkzigp
         Ig1/GGwx65VgWCbcMs9z7gElxGjN+g71Ub6vUYiwVzhOOIyZO5xL9G+yczK5nwEqqk7N
         yzqw==
X-Gm-Message-State: AOJu0YwDIBcKmNF5bsClal1bmGqQUBA3dlJrbubofcVp94UZXOx4v3SS
	pHjEhR/XaPEZ7l2M0A458lI=
X-Google-Smtp-Source: AGHT+IGUgPFwmKXAYXr/la+GiBRfxull/T9LtwRdHDu4ETDbiaOPIC0JJXkAHLEDBBq0J7WL3QKyrQ==
X-Received: by 2002:a05:6870:2182:b0:1ba:9e70:a1d4 with SMTP id l2-20020a056870218200b001ba9e70a1d4mr10577394oae.54.1692649975147;
        Mon, 21 Aug 2023 13:32:55 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:62f2:baa4:a7c0:4986? ([2600:1700:6cf8:1240:62f2:baa4:a7c0:4986])
        by smtp.gmail.com with ESMTPSA id r123-20020a0dcf81000000b0057087e7691bsm2418539ywd.56.2023.08.21.13.32.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 13:32:54 -0700 (PDT)
Message-ID: <17b47be9-d3bd-e475-906b-26b73eb920bd@gmail.com>
Date: Mon, 21 Aug 2023 13:32:53 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] bpf: task_group_seq_get_next: cleanup the usage of
 get/put_task_struct
Content-Language: en-US
To: Oleg Nesterov <oleg@redhat.com>, Yonghong Song <yhs@fb.com>,
 Kui-Feng Lee <kuifeng@fb.com>, Andrii Nakryiko <andrii@kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
 Martin KaFai Lau <martin.lau@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20230821150909.GA2431@redhat.com>
 <20230821200311.GA22497@redhat.com>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <20230821200311.GA22497@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/21/23 13:03, Oleg Nesterov wrote:
> get_pid_task() makes no sense, the code does put_task_struct() soon after.
> Use find_task_by_pid_ns() instead of find_pid_ns + get_pid_task and kill
> kill put_task_struct(), this allows to do get_task_struct() only once
> before return.
> 
> While at it, kill the unnecessary "if (!pid)" check in the "if (!*tid)"
> block, this matches the next usage of find_pid_ns() + get_pid_task() in
> this function.
> 
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>   kernel/bpf/task_iter.c | 12 ++----------
>   1 file changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index 4d1125108014..1589ec3faded 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c
> @@ -42,9 +42,6 @@ static struct task_struct *task_group_seq_get_next(struct bpf_iter_seq_task_comm
>   	if (!*tid) {
>   		/* The first time, the iterator calls this function. */
>   		pid = find_pid_ns(common->pid, common->ns);
> -		if (!pid)
> -			return NULL;
> -
>   		task = get_pid_task(pid, PIDTYPE_TGID);
>   		if (!task)
>   			return NULL;
> @@ -66,17 +63,12 @@ static struct task_struct *task_group_seq_get_next(struct bpf_iter_seq_task_comm
>   		return task;
>   	}
>   
> -	pid = find_pid_ns(common->pid_visiting, common->ns);
> -	if (!pid)
> -		return NULL;
> -
> -	task = get_pid_task(pid, PIDTYPE_PID);
> +	task = find_task_by_pid_ns(common->pid_visiting, common->ns);
>   	if (!task)
>   		return NULL;
>   
>   retry:
>   	next_task = next_thread(task);
> -	put_task_struct(task);

It called get_task_struct() against this task to hold a refcount at the
previous time calling this function. When will it release the refcount?

>   
>   	saved_tid = *tid;
>   	*tid = __task_pid_nr_ns(next_task, PIDTYPE_PID, common->ns);
> @@ -88,7 +80,6 @@ static struct task_struct *task_group_seq_get_next(struct bpf_iter_seq_task_comm
>   		return NULL;
>   	}
>   
> -	get_task_struct(next_task);
>   	common->pid_visiting = *tid;
>   
>   	if (skip_if_dup_files && task->files == task->group_leader->files) {
> @@ -96,6 +87,7 @@ static struct task_struct *task_group_seq_get_next(struct bpf_iter_seq_task_comm
>   		goto retry;
>   	}
>   
> +	get_task_struct(next_task);
>   	return next_task;
>   }
>   

