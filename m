Return-Path: <bpf+bounces-8168-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73998782FBD
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 19:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 800841C20936
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 17:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5029D312;
	Mon, 21 Aug 2023 17:56:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997088F4E
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 17:56:04 +0000 (UTC)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906F4114;
	Mon, 21 Aug 2023 10:56:01 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-579de633419so42713807b3.3;
        Mon, 21 Aug 2023 10:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692640561; x=1693245361;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1IL6PsZ9OIW8CBBVXv2ehcLQIm+WWtIFnIzb/l+zpLk=;
        b=TWX7lffBPct1qvlfW3qU9Ap9Fg+KRhbsxXOv7jRclmTBu71TCxzsEsYYbjQjJA4Ss4
         vn1V1eHrwyaARc2LpByLVKfJgL5I+fCN/NybF/u0YkAKX/vKR31O3ontvFJHl7dfID+5
         LWDlgKai40GlUrsrnYpn2TzJZ7xBkIvRxkBOWAGQuIignlF81HU7qzipy2/86MeWWxyc
         yeJao7ezJh5JmqPdxyfpgJuEmMHJnwDHPM982ScwWsXgtHy6cJKsGJ1bshzRBoDpxpQ7
         R9B1DvxlEjG2gDp1BerJrsZtjBgyE0kwmeMLSnDBV+RnMHJ9Dp5FjAEY0isgktZj/FaQ
         xBBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692640561; x=1693245361;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1IL6PsZ9OIW8CBBVXv2ehcLQIm+WWtIFnIzb/l+zpLk=;
        b=ZXdtvZ9TG8E2t34d1k2qkkwDwOb4biv29j638/BKVJ6/hU8+Wu8uHVZVRdtBNfDM94
         X7prhiJBidQsH5u0rZNn5RfQFp/TBvv0nppVHauTUbzKtUsyS8Ab46DpdTsNqUMevBa/
         bF1ydHldJFIudk0itK5pc0SPm8sCZBxJqrD0YrSMXS3ImqUcvhayAZpvadjsqqMwYWDB
         5rP4kHz88oEO7AEqCbt4NNjvOnjXQHsOv3JpQCc54BJdPiW/6Fp9sdACc2NXRZLrQShy
         vYBnbrtCJ0FF/mkS5edldBLn8FZdUB4Ed44CBhfV2pmyRf5Ft3uCe8CXtNflszt/Ehs+
         KYrw==
X-Gm-Message-State: AOJu0Yy4CcDJDR5JsO1R6hlXreyimoZUDAerh6xMPhPRlZc8XZ5KJg05
	+adFuaBR+mJqUCgIyNfa8DE=
X-Google-Smtp-Source: AGHT+IGEBqzSbRI4exsGEK9v4MJmiN2lyZ9CEzVrmeK5vIqQRgEDCF/LuTfgi61qPIk74i3RmrApcw==
X-Received: by 2002:a0d:ea91:0:b0:57a:6a2c:f4dd with SMTP id t139-20020a0dea91000000b0057a6a2cf4ddmr7888075ywe.36.1692640560176;
        Mon, 21 Aug 2023 10:56:00 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:62f2:baa4:a7c0:4986? ([2600:1700:6cf8:1240:62f2:baa4:a7c0:4986])
        by smtp.gmail.com with ESMTPSA id h129-20020a0dc587000000b00589f4021f84sm2370008ywd.37.2023.08.21.10.55.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 10:55:59 -0700 (PDT)
Message-ID: <e0c71c5c-09e6-d94e-6db3-3acf3ee502d6@gmail.com>
Date: Mon, 21 Aug 2023 10:55:58 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] bpf: task_group_seq_get_next: cleanup the usage of
 next_thread()
To: Oleg Nesterov <oleg@redhat.com>, Yonghong Song <yhs@fb.com>,
 Kui-Feng Lee <kuifeng@fb.com>, Andrii Nakryiko <andrii@kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
 Martin KaFai Lau <martin.lau@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20230821150909.GA2431@redhat.com>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <20230821150909.GA2431@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/21/23 08:09, Oleg Nesterov wrote:
> 1. find_pid_ns() + get_pid_task() under rcu_read_lock() guarantees that we
>     can safely iterate the task->thread_group list. Even if this task exits
>     right after get_pid_task() (or goto retry) and pid_alive() returns 0 >
>     Kill the unnecessary pid_alive() check.

This function will return next_task holding a refcount, and release the
refcount until the next time calling the same function. Meanwhile,
the returned task A may be killed, and its next task B may be
killed after A as well, before calling this function again.
However, even task B is destroyed (free), A's next is still pointing to
task B. When this function is called again for the same iterator,
it doesn't promise that B is still there.

Does that make sense to you?

> 
> 2. next_thread() simply can't return NULL, kill the bogus "if (!next_task)"
>     check.
> 
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>   kernel/bpf/task_iter.c | 7 -------
>   1 file changed, 7 deletions(-)
> 
> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index c4ab9d6cdbe9..4d1125108014 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c
> @@ -75,15 +75,8 @@ static struct task_struct *task_group_seq_get_next(struct bpf_iter_seq_task_comm
>   		return NULL;
>   
>   retry:
> -	if (!pid_alive(task)) {
> -		put_task_struct(task);
> -		return NULL;
> -	}
> -
>   	next_task = next_thread(task);
>   	put_task_struct(task);
> -	if (!next_task)
> -		return NULL;
>   
>   	saved_tid = *tid;
>   	*tid = __task_pid_nr_ns(next_task, PIDTYPE_PID, common->ns);

