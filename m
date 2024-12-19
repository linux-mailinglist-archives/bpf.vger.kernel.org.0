Return-Path: <bpf+bounces-47322-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8939F7D77
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 15:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BF15189252D
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 14:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D18225786;
	Thu, 19 Dec 2024 14:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CB0tROWH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446F722576A;
	Thu, 19 Dec 2024 14:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734620374; cv=none; b=FRKqUW4LFzyKjzcjHGHa6dAJkOJnZFc2mRbwfhermAJxkvCO1VXU3DAxvdG/k3YQnEUFBmOQ28PUQ/HQU+r9V9rcmkOpprvc2HoW73NDsB02H6Eg/4t9yxAshGK8KLQitNx6w2C6vmsK/xnZ7VNp1pVnUbWXq1KzZvb6iMk1r3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734620374; c=relaxed/simple;
	bh=vjythmSyRdHjZT7fDyjZK0lucFvBoXwSsqndYSrO8gM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HH/Y8DZgG85G8WtVTaa5wW/zJU/ntfWVcrscMLQV9xaSZnn2bTFVbBvycK2v2+QAiPJg5MyrNOFd+7IFsx31UPMN39P4imu1h0rh8ynoFAULymN4izZMEkIw8603oxT4CzD8mhV9Jxu5VLDmwDEOMqRQwafjFTAM6NSqd+Ji/YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CB0tROWH; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa6aee68a57so143013966b.3;
        Thu, 19 Dec 2024 06:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734620370; x=1735225170; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=58SmSb+AjvhL+9AMydEia//cCAs9UurU8Q24Mq0HaTg=;
        b=CB0tROWHwCDwN4/dMktCJAlnb9cx62umeaZycMxPc02E7J3K+oaCDpU/oL4VE6lsy4
         OE8VymimOa6LtDkAoZ2Ia+v8+2mby1lRXhVyAOcafV5inAisnIuzD0zpzEfnM3ywRFNo
         LNtjF7augQLS1eS/bwav8IbUY4JkDcQIz4UFHi7IwMj0uPo9/sQnH1i0IP8B0mEffQBb
         tJjPQO8XnuRioyNqOIXslRkUxIVqj4BxLs6JEY7DYYlYLTtwULOUWu7A1fFvaDYkY+CS
         gpCR3T2f7ZHTfmEWgtVi8bHfmGGRHJastyEOZVdWU2romeUuUItJTVwX6zNT8DE9priK
         6wnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734620370; x=1735225170;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=58SmSb+AjvhL+9AMydEia//cCAs9UurU8Q24Mq0HaTg=;
        b=wSzHDMnwOR0NBDtA8gDPauDrDcIoIw1RwsuLh0kuBoR3jtHPEZHWQDuVXS/BG+R9Yc
         lFfnVWs/UQd8PGvhefoli0e/1c9tJaFr2v2vRAuc1yiWJzfjeazUb0Nz+gH6yZg05GeJ
         A85dp+yW9xCKrMJ6ZJCiLxFwp0OJsB3qxYBdoeVGnEww1Rkm86ftcxjabtHd4MSCTx5z
         7I86H8TlJFfiYQUVTm4GOdn6YJq8U+KpDyfC2FMwG2X65x7WZc6YV/Pyt4aKjtCkuQa1
         6vR/J8NFi2OFN/2B7j64pL9XsNtUm31LHnX5wf9X8hnduaBS0eBTiUrzWnCl3iTccsNu
         7G/A==
X-Forwarded-Encrypted: i=1; AJvYcCVdToYb1M/jUn82pzh4afie4VKokiEaGWzETXmTYPUPFR5xtL/z9nr6kS6vq2t0hM2TPpM=@vger.kernel.org, AJvYcCXMd6jh3dts5OvnHUp8vRSz4qwIGII282rW7Pg4252DFbpwPzOzZ8sTZgndbSgIqKjHApn9TCUTwg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyTrWId38hEDTVEgg7VCIciPpZIqwjIS6BV/5VbTpiqH/bXRg6v
	Ft+gMHs1GWaboIRvN9S80prHO4i/VEb90YoDGtxbgd5ESB4l6I4I6/sNxw==
X-Gm-Gg: ASbGnctRJDtJdqgEQE+845aHMQnZ0U47Y56J37ElL1EA2Mp1AMgFK138WJyWcGDplfF
	chk1sPuIyOtOCAix/cP1hMDHOdAZM0nQ3wJKm42lJDFF3yoG4GIDpTfzEjp3ECJAe+1erJCJ1T9
	+UwsqcYk1NjMFAP6ekDz8eIYEclVL//lYIklvXU8h4n9gzIYE+VY50zy5Bh+tdr6+g1aZ+amJwJ
	4/Xg9a+dT8EBLI6JNxCgxahqM8bLySbwjHPaqhZ0L4QZZiH9e94DSbb8edDzB+WfX3t8EDyMlAK
	HW03+ivFfuVIylIBGt4F7k3fNRELUw==
X-Google-Smtp-Source: AGHT+IEJA42cOJTgNjQn/YAzHviBfR0tRlcnmttrjq5daNdVb/aXZf67U5BLmnNEVjeY7uHlL2+QZg==
X-Received: by 2002:a17:907:c16:b0:aa6:7e6b:4984 with SMTP id a640c23a62f3a-aabf490828emr566991566b.42.1734620370283;
        Thu, 19 Dec 2024 06:59:30 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0e894d8csm73974866b.53.2024.12.19.06.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 06:59:30 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 19 Dec 2024 15:59:28 +0100
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Ihor Solodrai <ihor.solodrai@pm.me>, dwarves@vger.kernel.org,
	acme@kernel.org, alan.maguire@oracle.com, andrii@kernel.org,
	mykolal@fb.com, bpf@vger.kernel.org
Subject: Re: [PATCH dwarves v2 10/10] dwarf_loader: multithreading with a
 job/worker model
Message-ID: <Z2Q00ANdHmjFkd3f@krava>
References: <20241213223641.564002-1-ihor.solodrai@pm.me>
 <20241213223641.564002-11-ihor.solodrai@pm.me>
 <58dc053c9d47a18124d8711604b08acbc6400340.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58dc053c9d47a18124d8711604b08acbc6400340.camel@gmail.com>

On Mon, Dec 16, 2024 at 04:57:33PM -0800, Eduard Zingerman wrote:

SNIP

> >  	}
> >  
> > -	if (dcus->conf->thread_exit &&
> > -	    dcus->conf->thread_exit(dcus->conf, dthr->data) != 0)
> > +	if (dcus->error)
> >  		goto out_abort;
> >  
> >  	return (void *)DWARF_CB_OK;
> > @@ -3566,29 +3736,29 @@ out_abort:
> >  	return (void *)DWARF_CB_ABORT;
> >  }
> 
> There is no real need to use two conditional variables to achieve what is done here.
> The "JOB_DECODE" item is already used as a "ticket" to do the decoding.
> So it is possible to "emit" a fixed amount of tickets and alternate their state
> between "decode"/"steal", w/o allocating new tickets.
> This would allow to remove "job_taken" conditional variable and decode counters.
> E.g. as in the patch below applied on top of this patch-set.

+1 , looks much easier

jirka

> 
> ---
> 
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index 6d22648..40ad27d 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -3453,23 +3453,10 @@ struct dwarf_cus {
>  static struct {
>  	pthread_mutex_t mutex;
>  	pthread_cond_t job_added;
> -	pthread_cond_t job_taken;
>  	/* next_cu_id determines the next CU ready to be stealed
>  	 * This enforces the order of CU stealing.
>  	 */
>  	uint32_t next_cu_id;
> -	/* max_decoded_cus is a soft limit on the number of JOB_STEAL
> -	 * jobs currently in the queue (this number is equal to the
> -	 * number of decoded CUs held in memory). It's soft, because a
> -	 * worker thread may finish decoding it's current CU after
> -	 * this limit has already been reached. In such situation,
> -	 * JOB_STEAL with this CU is still added to the queue,
> -	 * although a worker will not pick up a new JOB_DECODE.
> -	 * So the real hard limit is max_decoded_cus + nr_workers.
> -	 * This variable indirectly limits the memory usage.
> -	 */
> -	uint16_t max_decoded_cus;
> -	uint16_t nr_decoded_cus;
>  	struct list_head jobs;
>  } cus_processing_queue;
>  
> @@ -3489,10 +3476,7 @@ static void cus_queue__init(uint16_t max_decoded_cus)
>  {
>  	pthread_mutex_init(&cus_processing_queue.mutex, NULL);
>  	pthread_cond_init(&cus_processing_queue.job_added, NULL);
> -	pthread_cond_init(&cus_processing_queue.job_taken, NULL);
>  	INIT_LIST_HEAD(&cus_processing_queue.jobs);
> -	cus_processing_queue.max_decoded_cus = max_decoded_cus;
> -	cus_processing_queue.nr_decoded_cus = 0;
>  	cus_processing_queue.next_cu_id = 0;
>  }
>  
> @@ -3500,7 +3484,6 @@ static void cus_queue__destroy(void)
>  {
>  	pthread_mutex_destroy(&cus_processing_queue.mutex);
>  	pthread_cond_destroy(&cus_processing_queue.job_added);
> -	pthread_cond_destroy(&cus_processing_queue.job_taken);
>  }
>  
>  static inline void cus_queue__inc_next_cu_id(void)
> @@ -3520,12 +3503,10 @@ static void cus_queue__enqueue_job(struct cu_processing_job *job)
>  	/* JOB_STEAL have higher priority, add them to the head so
>  	 * they can be found faster
>  	 */
> -	if (job->type == JOB_STEAL) {
> +	if (job->type == JOB_STEAL)
>  		list_add(&job->node, &cus_processing_queue.jobs);
> -		cus_processing_queue.nr_decoded_cus++;
> -	} else {
> +	else
>  		list_add_tail(&job->node, &cus_processing_queue.jobs);
> -	}
>  
>  	pthread_cond_signal(&cus_processing_queue.job_added);
>  	pthread_mutex_unlock(&cus_processing_queue.mutex);
> @@ -3537,45 +3518,28 @@ static struct cu_processing_job *cus_queue__dequeue_job(void)
>  	struct list_head *pos, *tmp;
>  
>  	pthread_mutex_lock(&cus_processing_queue.mutex);
> -	while (list_empty(&cus_processing_queue.jobs))
> -		pthread_cond_wait(&cus_processing_queue.job_added, &cus_processing_queue.mutex);
> -
> -	/* First, try to find JOB_STEAL for the next CU */
> +retry:
>  	list_for_each_safe(pos, tmp, &cus_processing_queue.jobs) {
>  		job = list_entry(pos, struct cu_processing_job, node);
>  		if (job->type == JOB_STEAL && job->cu->id == cus_processing_queue.next_cu_id) {
> -			list_del(&job->node);
> -			cus_processing_queue.nr_decoded_cus--;
>  			dequeued_job = job;
>  			break;
>  		}
> -	}
> -
> -	/* If no JOB_STEAL is found, check if we are allowed to decode
> -	 * more CUs.  If not, it means that the CU with next_cu_id is
> -	 * still being decoded while the queue is "full". Wait.
> -	 * job_taken will signal that another thread was able to pick
> -	 * up a JOB_STEAL, so we might be able to proceed with JOB_DECODE.
> -	 */
> -	if (dequeued_job == NULL) {
> -		while (cus_processing_queue.nr_decoded_cus >= cus_processing_queue.max_decoded_cus)
> -			pthread_cond_wait(&cus_processing_queue.job_taken, &cus_processing_queue.mutex);
> -
> -		/* We can decode now. */
> -		list_for_each_safe(pos, tmp, &cus_processing_queue.jobs) {
> -			job = list_entry(pos, struct cu_processing_job, node);
> -			if (job->type == JOB_DECODE) {
> -				list_del(&job->node);
> -				dequeued_job = job;
> -				break;
> -			}
> +		if (job->type == JOB_DECODE) {
> +			/* all JOB_STEALs are added to the head, so no viable JOB_STEAL available */
> +			dequeued_job = job;
> +			break;
>  		}
>  	}
> -
> -	pthread_cond_signal(&cus_processing_queue.job_taken);
> +	/* No jobs or only steals out of order */
> +	if (!dequeued_job) {
> +		pthread_cond_wait(&cus_processing_queue.job_added, &cus_processing_queue.mutex);
> +		goto retry;
> +	}
> +	list_del(&dequeued_job->node);
>  	pthread_mutex_unlock(&cus_processing_queue.mutex);
>  
> -	return dequeued_job;
> +	return job;
>  }
>  
>  static struct dwarf_cu *dwarf_cus__create_cu(struct dwarf_cus *dcus, Dwarf_Die *cu_die, uint8_t pointer_size)
> @@ -3700,14 +3664,8 @@ static void *dwarf_loader__worker_thread(void *arg)
>  				break;
>  			}
>  
> -			/* Create and enqueue a new JOB_STEAL for this decoded CU */
> -			struct cu_processing_job *steal_job = calloc(1, sizeof(*steal_job));
> -
> -			steal_job->type = JOB_STEAL;
> -			steal_job->cu = cu;
> -			cus_queue__enqueue_job(steal_job);
> -
> -			/* re-enqueue JOB_DECODE so that next CU is decoded from DWARF */
> +			job->type = JOB_STEAL;
> +			job->cu = cu;
>  			cus_queue__enqueue_job(job);
>  			break;
>  
> @@ -3715,11 +3673,10 @@ static void *dwarf_loader__worker_thread(void *arg)
>  			if (cus__steal_now(dcus->cus, job->cu, dcus->conf) == LSK__STOP_LOADING)
>  				goto out_abort;
>  			cus_queue__inc_next_cu_id();
> -			/* Free the job struct as it's no longer
> -			 * needed after CU has been stolen.
> -			 * dwarf_loader work for this CU is done.
> -			 */
> -			free(job);
> +			/* re-enqueue JOB_DECODE so that next CU is decoded from DWARF */
> +			job->type = JOB_DECODE;
> +			job->cu = NULL;
> +			cus_queue__enqueue_job(job);
>  			break;
>  
>  		default:
> @@ -3742,10 +3699,10 @@ static int dwarf_cus__process_cus(struct dwarf_cus *dcus)
>  	pthread_t workers[nr_workers];
>  	struct cu_processing_job *job;
>  
> -	cus_queue__init(nr_workers * 4);
> +	cus_queue__init(nr_workers);
>  
>  	/* fill up the queue with nr_workers JOB_DECODE jobs */
> -	for (int i = 0; i < nr_workers; i++) {
> +	for (int i = 0; i < nr_workers * 4; i++) {
>  		job = calloc(1, sizeof(*job));
>  		job->type = JOB_DECODE;
>  		/* no need for locks, workers were not started yet */
> 
> 

