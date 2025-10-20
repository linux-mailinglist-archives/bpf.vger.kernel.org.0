Return-Path: <bpf+bounces-71389-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BC1BF0F86
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 14:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 257E8407034
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 11:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86081305960;
	Mon, 20 Oct 2025 11:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MmkU7qmw"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EBB2641C3
	for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 11:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760961539; cv=none; b=Sx3FZtmDbvB0mQsGjnWHhsGb5t8+j0t3gTxMXPxWsqpE2lMfZ8FTfKLeN075giZov6Ag8QWrlPQxcWGrGf/afECL0Y++15pWb2O2983RUObE6+ZhZVM2qv+vnpswbb7yBmWeBkTrlcls3mW9f7eCZQVtoNRXMOQ2WC4g/WivYXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760961539; c=relaxed/simple;
	bh=prBsS/3TdnqRdZW7jgJaElFuOWg9kNn6hLTHuRKrO4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DFAl2BPOtvCNwBg03+aeWvuo5Nl0lt3syTxZ3tXtrg2FTNzN2uoQRAN7ufDSYpmlUAcbqmGCHVeX+eQiepvE3jdZS9+IyBxY9ytyGrF/bhOu5mgyS4mUC6TotFI83hNhi/3Qp/JebngGyHYeZ6RQ2dXXyPS4vjZ1o1YqJLIyXL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MmkU7qmw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760961536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3DGWABDIIB0dwmhK6Y7TeY6zhcql3nAwcUWHRom4zEg=;
	b=MmkU7qmwmztaS+EXaTxdSUt4G+mHq/mXvspn6c4EM1XpvyKqtJqiIbKPcfTMiuc4f2LFA2
	7uL7HK/17p394llxTba0UOAzrUZ/CeRjqbtE2+BqSyWPnLpY+NtPlrScn7o7zttbIhdy1E
	22ZnwW3gw54M9+3WnizVhzVlcEUxwHI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-7hH3-YcXOKuTI8zXK7LB5A-1; Mon, 20 Oct 2025 07:58:55 -0400
X-MC-Unique: 7hH3-YcXOKuTI8zXK7LB5A-1
X-Mimecast-MFC-AGG-ID: 7hH3-YcXOKuTI8zXK7LB5A_1760961534
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47108163eeaso20781275e9.3
        for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 04:58:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760961534; x=1761566334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3DGWABDIIB0dwmhK6Y7TeY6zhcql3nAwcUWHRom4zEg=;
        b=nZO1mIqw59aYE5KA4K8lLdMNJ4d3w0yazPBK709TgEN/wDzHDTGij+OFZsbEmrHTi9
         PqsXtx6ocbmLRAJx996KRMaoVU6WnJA3kJCSsKty6knoFvGw7e3i0yRCnMMrRdWoK5ko
         BzGSDlbmFmPOMKCEtbKLdpAV8b6JuTDtnC7O9H9aTJJ/VyPfRiej27X0IQ4WErbxdxj6
         f859YojEWNxQMtX++xbzpAJPOGkjNU3dqxkUJWIfYLja4c4EdlfBFVJsRlkHc7/jL83X
         2BrWswScw6o/+4mai7n4idK4XoJuwd7WtPkMpJ91zuJfdMdsUfGOieFBH1CEzncPpDpK
         guZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaxg0mA/VdtMhIhTkrEgutKbkM6jhCnW0pRM6k1iXH1bt6U+d2pIoRjxkN0FH++JF3pDk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzeq3eXkpanrzU7Xo8n1j7D0cMz60+eAKa6v4BdZZurKlHu8p4V
	MUj7iEUfyc+z84LQKIIoJRe+wT+6di2dcDbyK6Wdn9a9p3AekwhOUkNEZ8EiRmKQmsUR9ESNF9Z
	7CnfYfCsBYhqW2dcNlIfnCrFchs1v4NN0LmJ9CBuD/ldATXHa3Fj3fg==
X-Gm-Gg: ASbGnct0oGRGykgF5FPzb9nqqJkuipredr2umcaXpcZYxvb7VcA0bLitCXk85IYDNmj
	9d8RhBxhzBnm1kfUKclnG+LNJ28gB7JUr0mAVc9RSm3tRmQLWUV/jGmwtndRkX1MkMaUGFzjAvO
	tC4jUic1rMFPprbJrvTykj1yZmFxnS4fsemz5/Yxd7TScSTAvB8brqqQVkATzdoffXZBOBG/DsS
	vanvThZjQzhYs6cysVB0z9YwL0TcOjnM4LkRjv36yd+hEziCBTShHxzoM5RWC3IoDYyhdfXzgy1
	xswFTu69mVvZLKdiJvVvzDE5FTY0cdBnUPhZKkdZP3jmgDL0XGGROW0F7yPeTz+HwkQYHV5DFnH
	TgtUcwINhMOQo2AWwHMJWTchjJDtoSBQ=
X-Received: by 2002:a05:600c:828a:b0:46e:39e1:fc3c with SMTP id 5b1f17b1804b1-4711787617amr91944605e9.5.1760961533609;
        Mon, 20 Oct 2025 04:58:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3bJRkDnTNsDoLX27C6wNA7H7qPmCVso88dp9ehs0+zp2XESQa1XmzDa+Csu2dj2eVZorh8A==
X-Received: by 2002:a05:600c:828a:b0:46e:39e1:fc3c with SMTP id 5b1f17b1804b1-4711787617amr91944415e9.5.1760961533236;
        Mon, 20 Oct 2025 04:58:53 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([176.206.13.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144c900asm229469775e9.16.2025.10.20.04.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 04:58:52 -0700 (PDT)
Date: Mon, 20 Oct 2025 13:58:50 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joelagnelf@nvidia.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luigi De Matteis <ldematteis123@gmail.com>
Subject: Re: [PATCH 06/14] sched_ext: Add a DL server for sched_ext tasks
Message-ID: <aPYj-iOdvgUYQFpn@jlelli-thinkpadt14gen4.remote.csb>
References: <20251017093214.70029-1-arighi@nvidia.com>
 <20251017093214.70029-7-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017093214.70029-7-arighi@nvidia.com>

Hi!

On 17/10/25 11:25, Andrea Righi wrote:
> From: Joel Fernandes <joelagnelf@nvidia.com>
> 
> sched_ext currently suffers starvation due to RT. The same workload when
> converted to EXT can get zero runtime if RT is 100% running, causing EXT
> processes to stall. Fix it by adding a DL server for EXT.
> 
> A kselftest is also provided later to verify:
> 
> ./runner -t rt_stall
> ===== START =====
> TEST: rt_stall
> DESCRIPTION: Verify that RT tasks cannot stall SCHED_EXT tasks
> OUTPUT:
> TAP version 13
> 1..1
> ok 1 PASS: CFS task got more than 4.00% of runtime
> 
> [ arighi: drop ->balance() now that pick_task() has an rf argument ]
> 
> Cc: Luigi De Matteis <ldematteis123@gmail.com>
> Co-developed-by: Andrea Righi <arighi@nvidia.com>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
>  kernel/sched/core.c     |  3 +++
>  kernel/sched/deadline.c |  2 +-
>  kernel/sched/ext.c      | 51 +++++++++++++++++++++++++++++++++++++++--
>  kernel/sched/sched.h    |  2 ++
>  4 files changed, 55 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 096e8d03d85e7..31a9c9381c63f 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8679,6 +8679,9 @@ void __init sched_init(void)
>  		hrtick_rq_init(rq);
>  		atomic_set(&rq->nr_iowait, 0);
>  		fair_server_init(rq);
> +#ifdef CONFIG_SCHED_CLASS_EXT
> +		ext_server_init(rq);
> +#endif
>  
>  #ifdef CONFIG_SCHED_CORE
>  		rq->core = rq;
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 0680e0186577a..3c1fd2190949e 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1504,7 +1504,7 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
>  	 * The fair server (sole dl_server) does not account for real-time

Fair server is not alone anymore. :))

Please update the comment as well.

>  	 * workload because it is running fair work.
>  	 */
> -	if (dl_se == &rq->fair_server)
> +	if (dl_se->dl_server)
>  		return;
>  
>  #ifdef CONFIG_RT_GROUP_SCHED

...

> @@ -1487,6 +1499,11 @@ static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int deq_flags
>  	sub_nr_running(rq, 1);
>  
>  	dispatch_dequeue(rq, p);
> +
> +	/* Stop the server if this was the last task */
> +	if (rq->scx.nr_running == 0)
> +		dl_server_stop(&rq->ext_server);
> +

Do we want to use the delayed stop behavior for scx-server as we have
for fair-server? Wonder if it's a matter of removing this explicit stop
and wait for a full period to elapse as we do for fair. It should reduce
timer reprogramming overhead for scx as well.

Thanks,
Juri


