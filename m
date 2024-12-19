Return-Path: <bpf+bounces-47321-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8AE29F7D72
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 15:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DE91162E41
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 14:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A88225419;
	Thu, 19 Dec 2024 14:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Onuh7z3h"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A03A41C64;
	Thu, 19 Dec 2024 14:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734620359; cv=none; b=rMPFG6OXLvORhM0OoiB7AlfTpkY2/NaC2wzfUUded65wP/supAR+3k80xSeafbXLkMz4XG5dRRxyIMjGrSsu6B2T8yGqIDEkrccFJit23WoRLQm0DrmvEDpeGz8TADHNCysqbHY8BJkkKwsuJze02TnAHHw1C8NKF6OThFr7YGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734620359; c=relaxed/simple;
	bh=j3s2DKN4yLbMIpIFt56uAT00+nq0srqO0Q/6OUMydec=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kKp+pevwss0uTr1muE7ya5sakx/BKZsTGl9d9R+sJJWBnpSuzST9X/ZNYROWVEleE+3IuJiuPapInk1ijB1yCHASH3AGXjCVGC6e+w8OU37d3i+IVaw+vblVcRZIDJ1fQulWkXRctgpCdoxcZNqC4eNDx2U8DJK9PNQhUnN5Fv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Onuh7z3h; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa689a37dd4so176307966b.3;
        Thu, 19 Dec 2024 06:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734620355; x=1735225155; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fvlSCgBnuHnSPjUz3EOKLTUVn+6VuuuEZ4XGIcz5iXE=;
        b=Onuh7z3hP4CC/A65cDk/Wr4FYq2QLe2cyIeo4z2LVin+mKsPkDWv698hr3GpB9n4+6
         K8C3nVxiTAY+mVg6MinSLqtnF3HinhLvQ2/5sVOypkx2ARd+mcTrpcsPa1r4xhCskSlI
         Dam9cwEWSJq3wUZ2tpEpmvUaBQX+ilONPfyykKr0EZqbXc+W+agSnzanZvnWuksP1qP1
         hVj+IczZwNb93Cckcqb3VKF6lMpheURrzQrnJ4B0dIMxP7luJc8wTRTNMlauiP+pO7py
         jUmEEd+tguQkDUGd6wE5hjlEgdkp8ORwSlN6zbdb1Ldp94CxdRbqkk6MxdbG5F0txZ5z
         m/zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734620355; x=1735225155;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fvlSCgBnuHnSPjUz3EOKLTUVn+6VuuuEZ4XGIcz5iXE=;
        b=cycXdBOgKzsMIpCx75hBf9G/zok2N1KWZW3oP5oUQo96IhfZFZrJ2jQlqPsh5CYRTJ
         CY7szH0Rt3Cv9xPQ1UqcC26kJU/zi7+bwz7SGUaUJHaz+U6//Ail/iYRu9mnU9/jVxp1
         C0pS93EDXSxPkpPn8PZLQ9vsO4bsuCALX7ZJe6mVLAdNpfMNsUOxe8lQlptthHfrrgUj
         CJcNvhQtCY64Hve8HPyPLR0zbW8/NBdmBfvMXxkEwiPf6lm+/sXoC6ka6w1w0FIyOgXu
         XNmxfIv0f5nMAkpqOsnOlxHnRpze3QZIbstzq/s4S0BAoxe6f2Mdr/l4UZjAejujkn+m
         rDPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIfN1ocI28dx6eTNMY+XLkgDbat09kqQeVhIoetLhmJMaLzZYiRkWfBXak5xNOSvXL1zw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyReUtUELRfnbKKssIw1B1EcNmysxwFoMXl7lItBFAvwYFPrQN/
	BjkpSsO/vUvAfqMm97j/aBEQGd/SgaoG2k6+LXz7IJEp3J1iSrdX
X-Gm-Gg: ASbGncvusz4ObUUgUCan9qXCoXtzSg5F6pix/kJjNQ0AhWEjDfVKsccAmq0uSmrImcI
	cAwZSYIqujbYnn4HtzzWjGU3bzv6IZsyA+Vog0MIEzp5itXFbkY5SrWRaJuecgDYrB5Yde30Uls
	ASJQEe19GVurYC5jCJThvTaQRGmcYx6pODBUUyR2w2fSVwgq52eB+cu28cCEaSyfq7sOjZaEac4
	jm1QX7QDwuMowQLsQDG/QUkcnGdNh5ooG0aM7lxC6dbCK3s1TDlrVGfxycCC1tRnqlDrBaXCK1F
	TWZfCV9v1JTWS5VzwiWxL+TXFJn3Xw==
X-Google-Smtp-Source: AGHT+IHM2m0GySO+ZdkKj1gwAMDBbUJgp0WTAVbJ4e586stPy72tOI/kKs87ybY1JI3W3PKXwR5Vfw==
X-Received: by 2002:a17:907:72c8:b0:aa6:af4b:7c90 with SMTP id a640c23a62f3a-aac07b0ca36mr337058566b.58.1734620355202;
        Thu, 19 Dec 2024 06:59:15 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0e82f56csm74503066b.24.2024.12.19.06.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 06:59:14 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 19 Dec 2024 15:59:13 +0100
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: dwarves@vger.kernel.org, acme@kernel.org, alan.maguire@oracle.com,
	eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com,
	bpf@vger.kernel.org
Subject: Re: [PATCH dwarves v2 10/10] dwarf_loader: multithreading with a
 job/worker model
Message-ID: <Z2Q0wU_AOOF0c_NF@krava>
References: <20241213223641.564002-1-ihor.solodrai@pm.me>
 <20241213223641.564002-11-ihor.solodrai@pm.me>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213223641.564002-11-ihor.solodrai@pm.me>

On Fri, Dec 13, 2024 at 10:37:34PM +0000, Ihor Solodrai wrote:

SNIP

> +static void *dwarf_loader__worker_thread(void *arg)
> +{
> +	struct cu_processing_job *job;
> +	struct dwarf_cus *dcus = arg;
> +	bool stop = false;
> +	struct cu *cu;
> +
> +	while (!stop) {
> +		job = cus_queue__dequeue_job();
> +
> +		switch (job->type) {
> +
> +		case JOB_DECODE:
> +			cu = dwarf_loader__decode_next_cu(dcus);
> +
> +			if (cu == NULL) {
> +				free(job);
> +				stop = true;
> +				break;
> +			}
> +
> +			/* Create and enqueue a new JOB_STEAL for this decoded CU */
> +			struct cu_processing_job *steal_job = calloc(1, sizeof(*steal_job));

missing steal_job != NULL check

SNIP

> -static int dwarf_cus__threaded_process_cus(struct dwarf_cus *dcus)
> +static int dwarf_cus__process_cus(struct dwarf_cus *dcus)
>  {
> -	pthread_t threads[dcus->conf->nr_jobs];
> -	struct dwarf_thread dthr[dcus->conf->nr_jobs];
> -	void *thread_data[dcus->conf->nr_jobs];
> -	int res;
> -	int i;
> +	int nr_workers = dcus->conf->nr_jobs > 0 ? dcus->conf->nr_jobs : 1;
> +	pthread_t workers[nr_workers];
> +	struct cu_processing_job *job;
>  
> -	if (dcus->conf->threads_prepare) {
> -		res = dcus->conf->threads_prepare(dcus->conf, dcus->conf->nr_jobs, thread_data);
> -		if (res != 0)
> -			return res;
> -	} else {
> -		memset(thread_data, 0, sizeof(void *) * dcus->conf->nr_jobs);
> +	cus_queue__init(nr_workers * 4);

why '* 4' ?

> +
> +	/* fill up the queue with nr_workers JOB_DECODE jobs */
> +	for (int i = 0; i < nr_workers; i++) {
> +		job = calloc(1, sizeof(*job));

missing job != NULL check

> +		job->type = JOB_DECODE;
> +		/* no need for locks, workers were not started yet */
> +		list_add(&job->node, &cus_processing_queue.jobs);
>  	}
>  
> -	for (i = 0; i < dcus->conf->nr_jobs; ++i) {
> -		dthr[i].dcus = dcus;
> -		dthr[i].data = thread_data[i];
> +	if (dcus->error)
> +		return dcus->error;
>  
> -		dcus->error = pthread_create(&threads[i], NULL,
> -					     dwarf_cus__process_cu_thread,
> -					     &dthr[i]);
> +	for (int i = 0; i < nr_workers; ++i) {
> +		dcus->error = pthread_create(&workers[i], NULL,
> +					     dwarf_loader__worker_thread,
> +					     dcus);
>  		if (dcus->error)
>  			goto out_join;
>  	}
> @@ -3596,54 +3766,19 @@ static int dwarf_cus__threaded_process_cus(struct dwarf_cus *dcus)
>  	dcus->error = 0;
>  
>  out_join:
> -	while (--i >= 0) {
> +	for (int i = 0; i < nr_workers; ++i) {

I think you should keep the original while loop to cleanup/wait only for
threads that we actually created

>  		void *res;
> -		int err = pthread_join(threads[i], &res);
> +		int err = pthread_join(workers[i], &res);
>  
>  		if (err == 0 && res != NULL)
>  			dcus->error = (long)res;
>  	}
>  
> -	if (dcus->conf->threads_collect) {
> -		res = dcus->conf->threads_collect(dcus->conf, dcus->conf->nr_jobs,
> -						  thread_data, dcus->error);
> -		if (dcus->error == 0)
> -			dcus->error = res;
> -	}
> +	cus_queue__destroy();
>  
>  	return dcus->error;
>  }
>  

SNIP

