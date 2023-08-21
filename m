Return-Path: <bpf+bounces-8183-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43342783391
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 22:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2308280F5B
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 20:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75ED11733;
	Mon, 21 Aug 2023 20:24:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962FB11729
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 20:24:08 +0000 (UTC)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B51FE3;
	Mon, 21 Aug 2023 13:24:07 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d776e1f181bso655006276.3;
        Mon, 21 Aug 2023 13:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692649446; x=1693254246;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a9DMAMrtIpnMqNo+FLHLK8ZcgXNwUBz98EDAXfME1O4=;
        b=bK3OrDeNnJy1hVq4bY50sNFZsg4NZOMNo55kgjLnSXa4CMcPOOxLYVoBliGq2CbgpW
         DBRS2Z8L79M45Cjh32kemBQAZGkSpeTX4OPCKdqA/lx6f8J2Rb8IfrKPpZFOVUkyu2c2
         guoJpTXxHKVeMVvgR0oyxoa07i7Fks7qRTt5/1AMXhMQow6Z/HlWzNmxHOHxoUb2sFlY
         VC0g5mukE/M4u3PrXPfN2mpDbugOFmj75fJPAJqgXynHcVsg0ToW5CSmlY3sKHJSvA7t
         SqnYKsl94tZomd2doq8pEY1GK9/GvBsJgj43t+UoQ9DBzIbv2bOAhu3Ior2n6z1zrRx+
         zNgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692649446; x=1693254246;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a9DMAMrtIpnMqNo+FLHLK8ZcgXNwUBz98EDAXfME1O4=;
        b=PWrlWvR3S9oT1Sk2R+7TkaoEWvlgc98BCJtXShEslXyknQ19OrKb8AfXaWcTJKY5ZT
         6Lynv5zM+ENTM2aQiOYB4O6Ru8AkozWmfuvLeN5ySYxTLtuXc3xhoNV7C5HmGcfrltBT
         rxLSJsjI/CyKZP1T2D96Zhhal9rliIYIE1S6/uP/AXGmqP9pKa1RkT2OpQ9f5zaDNOZa
         TmJxQXqcVi4VjqH9wt5QiHRfXeAhkEUc8gDJ17RDtnuMsaBRj9egBkJb/TuV7UCa8qOb
         ha3tBA9tJk3hSx/ZTuXTKP7Uhqlfv2TdxPZURhPmEoga78kTrFP6jUDd9pEjTdVOhfK9
         mI6A==
X-Gm-Message-State: AOJu0Yx4Y0W/RhbVK0RZv8xgHHupsRrCVQ/45eBmLkU88hXPyV7kHJ7w
	gMPcnv2Jy9kf7rbjESKOn8c=
X-Google-Smtp-Source: AGHT+IFzAgzgQMi6E7c9/99wpYP97SCh/zmEcxHB86fE3bmUpsPpr4j+k7Pa3CX0IV2myAxrgJHLdw==
X-Received: by 2002:a25:aa32:0:b0:d21:18a9:eddb with SMTP id s47-20020a25aa32000000b00d2118a9eddbmr8398887ybi.11.1692649446470;
        Mon, 21 Aug 2023 13:24:06 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:62f2:baa4:a7c0:4986? ([2600:1700:6cf8:1240:62f2:baa4:a7c0:4986])
        by smtp.gmail.com with ESMTPSA id e3-20020a258743000000b00d749a394c87sm968757ybn.16.2023.08.21.13.24.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 13:24:06 -0700 (PDT)
Message-ID: <8c0db9b3-9342-35e2-cd5b-934789f9744d@gmail.com>
Date: Mon, 21 Aug 2023 13:24:04 -0700
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
Content-Language: en-US
To: Oleg Nesterov <oleg@redhat.com>
Cc: Yonghong Song <yhs@fb.com>, Kui-Feng Lee <kuifeng@fb.com>,
 Andrii Nakryiko <andrii@kernel.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Martin KaFai Lau <martin.lau@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20230821150909.GA2431@redhat.com>
 <e0c71c5c-09e6-d94e-6db3-3acf3ee502d6@gmail.com>
 <20230821183443.GA12526@redhat.com>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <20230821183443.GA12526@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/21/23 11:34, Oleg Nesterov wrote:
> On 08/21, Kui-Feng Lee wrote:
>>
>>
>> On 8/21/23 08:09, Oleg Nesterov wrote:
>>> 1. find_pid_ns() + get_pid_task() under rcu_read_lock() guarantees that we
>>>     can safely iterate the task->thread_group list. Even if this task exits
>>>     right after get_pid_task() (or goto retry) and pid_alive() returns 0 >
>>>     Kill the unnecessary pid_alive() check.
>>
>> This function will return next_task holding a refcount, and release the
>> refcount until the next time calling the same function. Meanwhile,
>> the returned task A may be killed, and its next task B may be
>> killed after A as well, before calling this function again.
>> However, even task B is destroyed (free), A's next is still pointing to
>> task B. When this function is called again for the same iterator,
>> it doesn't promise that B is still there.
> 
> Not sure I understand...
> 
> OK, if we have a task pointer with incremented refcount and do not hold
> rcu lock, then yes, you can't remove the pid_alive() check in this code:
> 
> 	rcu_read_lock();
> 	if (pid_alive(task))
> 		do_something(next_thread(task));
> 	rcu_read_unlock();
> 
> because task and then task->next can exit and do call_rcu(delayed_put_task_struct)
> before we take rcu_read_lock().
> 
> But if you do something like
> 
> 	rcu_read_lock();
> 
> 	task = find_task_in_some_rcu_protected_list();
> 	do_something(next_thread(task));
> 
> 	rcu_read_unlock();
> 
> then next_thread(task) should be safe without pid_alive().
> 
> And iiuc task_group_seq_get_next() always does
> 
> 	rcu_read_lock();	// the caller does lock/unlock
> 
> 	task = get_pid_task(pid, PIDTYPE_PID);
> 	if (!task)
> 		return;
> 	
> 	next_task = next_thread(task);
> 
> 	rcu_read_unlock();
> 
> Yes, both task and task->next can exit right after get_pid_task(), but since
> can only happen after we took rcu_read_lock(), delayed_put_task_struct() can't
> be called until we drop rcu lock.
> 
> What have I missed?

Then, it makes sense to me! Thank you for the explanation.

> 
> Oleg.
> 

