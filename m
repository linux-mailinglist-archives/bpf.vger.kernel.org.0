Return-Path: <bpf+bounces-17062-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15184809706
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 01:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD9D2282081
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 00:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096E7372;
	Fri,  8 Dec 2023 00:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIh5cGTz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083EF30F3;
	Thu,  7 Dec 2023 16:16:32 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-5c66418decaso1123416a12.3;
        Thu, 07 Dec 2023 16:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701994592; x=1702599392; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fYaCvNQnFX8gSshhD0U4TjEw0tlZoDuU2wJUbPArFf8=;
        b=WIh5cGTz09wSE4+SUXHkBH+VTwBndYOxGzkeozcvyKdfK/K3Fsu0armv9KwvSU+vYW
         Uk7gEKBCTVZVBqnDIFp72D4fB1eBzO6FfQa2N+2AUMNai86Wogqznr/AkKTqgqe5wmwI
         Wqj4VIjlNyCz5uVP+USRejBrsW75pY4YVNNEM7DPOnx7LhFGBMg/UFf3+FBc8cUzgtRU
         as7lglpHrB7/0l/ehUbCYm5ibcQLtBzTpPCQNx6y79yV5Cz0LuN10CQamYsD0vYGqJiY
         3mLp58cVQ2QnhWC2ZeGSNwb+g+S3lmYmgC7Jy70JjTMdhGiF6iD+50bEG9e7GuUZTKPG
         Bwmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701994592; x=1702599392;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fYaCvNQnFX8gSshhD0U4TjEw0tlZoDuU2wJUbPArFf8=;
        b=w6XjlQtxBkiQZhKs1cunCI1AKhoGNv2mACktOFhN/quAb/g9eXpuvKHDkzyKH+39u7
         4qa1rKlJGEsQ9Hd0101F3kERG+5J5msZgS++Wmls+If1l2z2tiGjP78ry9bKkEhLjFoj
         1pdLi1UL24QtuN6b+ZU/upMt1agy25PCkj1acaCAugp6CbS3tTYg2i9NlQLfCgIn4Uik
         UggcBAL1HIi7zwAyBWTBmMKGWnpk3uOQ8qBPDQ2FFFCC5pIB5/T74MNB0mkhO3hw5gto
         /zE5u+cPhYkNd1/ayxPfbThxCi5ZFJnWdYLTpqrQhX5JsU+e1mSvurBL3rfRGX2vn2ac
         1UuQ==
X-Gm-Message-State: AOJu0Yx9pLpVC7DqHUqob5eCwQ44Sj4oX/VYdSrhjLAS+MlPzGOlHHyv
	HZI47Zw4wXGpJUjl3jp4Ar0=
X-Google-Smtp-Source: AGHT+IFy9HbQWTNcyN32kK0LC8FOvXZMYftP3rKNMYn/O6vKj3WIQqEzLjU+hOsNMtxdAsDBVSv4eA==
X-Received: by 2002:a17:903:191:b0:1d0:a53e:263a with SMTP id z17-20020a170903019100b001d0a53e263amr3271941plg.109.1701994592059;
        Thu, 07 Dec 2023 16:16:32 -0800 (PST)
Received: from localhost (dhcp-72-253-202-210.hawaiiantel.net. [72.253.202.210])
        by smtp.gmail.com with ESMTPSA id ba1-20020a170902720100b001d09c539c95sm403131plb.90.2023.12.07.16.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 16:16:31 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 7 Dec 2023 14:16:30 -1000
From: Tejun Heo <tj@kernel.org>
To: Changwoo Min <multics69@gmail.com>
Cc: kernel-dev@igalia.com, andrea.righi@canonical.com, andrii@kernel.org,
	ast@kernel.org, bpf@vger.kernel.org, brho@google.com,
	bristot@redhat.com, bsegall@google.com, changwoo@igalia.com,
	daniel@iogearbox.net, derkling@google.com, dietmar.eggemann@arm.com,
	dschatzberg@meta.com, dskarlat@cs.cmu.edu, dvernet@meta.com,
	haoluo@google.com, himadrics@inria.fr, joshdon@google.com,
	juri.lelli@redhat.com, kernel-team@meta.com,
	linux-kernel@vger.kernel.org, martin.lau@kernel.org,
	memxor@gmail.com, mgorman@suse.de, mingo@redhat.com,
	peterz@infradead.org, pjt@google.com, riel@surriel.com,
	rostedt@goodmis.org, torvalds@linux-foundation.org,
	vincent.guittot@linaro.org, vschneid@redhat.com
Subject: Re: [PATCH] scx: set p->scx.ops_state using atomic_long_set_release
Message-ID: <ZXJgXqQlHc1mgd1m@slm.duckdns.org>
References: <20231111024835.2164816-13-tj@kernel.org>
 <20231207020459.117365-1-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207020459.117365-1-changwoo@igalia.com>

Hello,

On Thu, Dec 07, 2023 at 11:04:59AM +0900, Changwoo Min wrote:
> p->scx.ops_state should be updated using the release semantics,
> atomic_long_set_release(), because it is read using
> atomic_long_read_acquire() at ops_dequeue() and wait_ops_state().
> ---
>  kernel/sched/ext.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 53ee906aa2b6..3a40ca2007b6 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -881,7 +881,7 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
>  	qseq = rq->scx.ops_qseq++ << SCX_OPSS_QSEQ_SHIFT;
>  
>  	WARN_ON_ONCE(atomic_long_read(&p->scx.ops_state) != SCX_OPSS_NONE);
> -	atomic_long_set(&p->scx.ops_state, SCX_OPSS_QUEUEING | qseq);
> +	atomic_long_set_release(&p->scx.ops_state, SCX_OPSS_QUEUEING | qseq);

atomic_long_load_acquire() are used when waiting the transitions out of
QUEUEING and DISPATCHING states. ie. the interlocking between writer and
reader is necessary only when transitioning out of those states. In the
above, @p is going into QUEUEING and release/acquire isn't necessary.
Selectively using them is kinda subtle but it's less confusing to keep it
that way, I think.

Thanks.

-- 
tejun

