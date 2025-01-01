Return-Path: <bpf+bounces-47735-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F0C9FF4A4
	for <lists+bpf@lfdr.de>; Wed,  1 Jan 2025 17:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9855D161DA6
	for <lists+bpf@lfdr.de>; Wed,  1 Jan 2025 16:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FCA1E2834;
	Wed,  1 Jan 2025 16:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bEF6A5pC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D4E2942A;
	Wed,  1 Jan 2025 16:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735750583; cv=none; b=Orbp/4akdUoiNzJVxfgpssxIIQQ9GGt/pilXpFP2q973ipEMSAb2QWWca8FMkCm8UGVFlIPB2UOJU711x8JhePLUHr+iXB5RzKWDzA/rhrM22i5+//9MTPnT1cclg21olZWfWTP28xmlJmCZkXluPPSag2y3lO6L/2GOG+c7ViY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735750583; c=relaxed/simple;
	bh=AYLGK7CYjMlr6UJmKDi37vCCzEi5ikMsDJAi9Cw8tp0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qgERa3xPzaGTVlk+quNWCUExqlmF74Ik71qDmva4e/Y/UQnQHXBJh8oS1DNfwMnfjYzbKA5aeXVIYt68eJRC/rZdjepmgrSx/bRYQNe7fjyslQ0bh+/tzRKopx+yn2PaqxH95w3eEm/nvkQqN8FYu45nOw23L5qIJFCbhpai7Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bEF6A5pC; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa6c0dbce1fso1465103366b.2;
        Wed, 01 Jan 2025 08:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735750580; x=1736355380; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dw5MhEyO0jwZXRYwczX4SUuq1WE5w6hVdzps5NO2E2o=;
        b=bEF6A5pC2hmClmBSoo3SYbdfdq21ix/XwPXv8TJWz1mQVlJg5RtLlgzDfqeUdiQ2vE
         XwORKNu6AmfRZTlnWdUpIHnBBywQF7hbDxH0FJyCiI+eDlVQ+X/G5hX+IxxJkzduPJhF
         1xPlwqzCZo+S7IJ0jgBiz3v5pzxpHvlhZ/IKO2n8TDRKnN4iCcTUC1ndKac7AKc/vQCr
         zZ54tNC3YqoSEgT0ls2xDFfqWM+X5NUO01tbHi1wGvpecRxIMStGqpBlL9zMMvhyuHWJ
         qIMmlcr2h1D0aB/eJoooZU8zHinoZmOPIJ8InkQT14/xfaS3RUUY7rI+kVlfNgpstL9/
         Vlew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735750580; x=1736355380;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dw5MhEyO0jwZXRYwczX4SUuq1WE5w6hVdzps5NO2E2o=;
        b=P8zatjnPLj2o7zh4K+6EPyFTtQiTgUDqTN0pzuM/j/Vd8hNPrDIX++4q1CeVhxFAxy
         YXABlCHHKbWJ3uwnEnYlY5noT8epuA/X1JwLY3aMfN6tbGdEc6o9MF1Jgmbs8re4x6dW
         n25GrDoplLXcyKfxC88or7ehkhlCB/1W9YZ8mwleyymfxki8Uo6ccA4bxh7ThgomjGFh
         CeWKlBddm66yTwnQKwEx8HyLGa6uyMEkB4CGMrAqf5PRQeMbXSwV+3jA6IyEtyUnb0gg
         lz6MfIVVTAXlJhuSHjgpudKXMCyg3OAd7R/0x75OnwEdcgssNzoUcR1tx+QWSN3hW8Lq
         dtsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkMPFiP2XMMglWU1pwA0beD/ow4YwgDX/TPDhZ4X+uwgAYV7SvczOQg9q/eQbZqFZ7q7U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0sp6+nllvlVt6VNj0LEJnIkognHHmhN8RZZBubi0ZggMG9tvN
	lgffUWCFd0eZM63W0IQFvxiB/7Sta/hZ7DsbYpYLQQ2fC3KB86RkfAFiwg==
X-Gm-Gg: ASbGncvH3q4NWtRcBWIq7RZCnZCt3wtx88DBsQmM95ddPSAeTmbm3fTmQ+rn18QtWyX
	gWzvWFfI5cGAF2Wm3ACJ3cVEtt9yBMR6/gstdFQTTkoNxKKbAiEZMwdSfZcrXMDgCh6aytz/SgQ
	kolG2WQQmk9944rnFfkafeIpMgBIaBe353zbEeGP/OKFRMXOLBU+WjT8/j8PcCBoArDgEfGJrBx
	5aNShVr5RSDwmIfyCkFsy86DZoyJ6gfjKV2UHLrj8JoCmMTekutt4L4lqhL8FM=
X-Google-Smtp-Source: AGHT+IFuuoevDLddDg4ZwjN42Ff9B+q2duOVCAh8f3uUt8GBwQYfQF00PmlPtX+duG3KQFZGKhjkhQ==
X-Received: by 2002:a05:6402:1590:b0:5d0:d818:559d with SMTP id 4fb4d7f45d1cf-5d81dda6576mr106599092a12.11.1735750579544;
        Wed, 01 Jan 2025 08:56:19 -0800 (PST)
Received: from krava (85-193-35-38.rib.o2.cz. [85.193.35.38])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80675a535sm17370664a12.6.2025.01.01.08.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2025 08:56:19 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 1 Jan 2025 17:56:16 +0100
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: dwarves@vger.kernel.org, acme@kernel.org, alan.maguire@oracle.com,
	eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com,
	bpf@vger.kernel.org
Subject: Re: [PATCH dwarves v3 7/8] dwarf_loader: multithreading with a
 job/worker model
Message-ID: <Z3VzsA8nv4kQj1bH@krava>
References: <20241221012245.243845-1-ihor.solodrai@pm.me>
 <20241221012245.243845-8-ihor.solodrai@pm.me>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241221012245.243845-8-ihor.solodrai@pm.me>

On Sat, Dec 21, 2024 at 01:23:38AM +0000, Ihor Solodrai wrote:

SNIP

> diff --git a/btf_encoder.c b/btf_encoder.c
> index 90f1b9a..7e03ba4 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -1326,7 +1326,7 @@ static void btf_encoder__delete_saved_funcs(struct btf_encoder *encoder)
>  	}
>  }
>  
> -int btf_encoder__add_saved_funcs(bool skip_encoding_inconsistent_proto)
> +static int btf_encoder__add_saved_funcs(bool skip_encoding_inconsistent_proto)
>  {
>  	struct btf_encoder_func_state **saved_fns, *s;
>  	struct btf_encoder *e = NULL;
> @@ -2134,7 +2134,6 @@ int btf_encoder__encode(struct btf_encoder *encoder, struct conf_load *conf)
>  	int err;
>  	size_t shndx;
>  
> -	/* for single-threaded case, saved funcs are added here */
>  	btf_encoder__add_saved_funcs(conf->skip_encoding_btf_inconsistent_proto);

should we check the return value in here? now it's the only caller

SNIP

> -struct dwarf_thread {
> -	struct dwarf_cus	*dcus;
> -	void			*data;
> +/* Multithreading is implemented using a job/worker model.
> + * cus_processing_queue represents a collection of jobs to be
> + * completed by workers.
> + * dwarf_loader__worker_thread is the worker loop, taking jobs from
> + * the queue, executing them and re-enqueuing new jobs as necessary.
> + * Implementation of this queue ensures two constraints:
> + *   * JOB_STEAL jobs for a CU are executed in the order of cu->id, as
> + *     a consequence JOB_STEAL jobs always run one at a time.
> + *   * Initial number of JOB_DECODE jobs in the queue is effectively a
> + *     limit on how many decoded CUs can be held in memory.
> + *     See dwarf_loader__decoded_cus_limit()
> + */
> +static struct {
> +	pthread_mutex_t mutex;
> +	pthread_cond_t job_added;
> +	/* next_cu_id determines the next CU ready to be stealed
> +	 * This enforces the order of CU stealing.
> +	 */
> +	uint32_t next_cu_id;
> +	struct list_head jobs;
> +} cus_processing_queue;
> +
> +enum job_type {
> +	JOB_NONE = 0,

nit, no need for JOB_NONE?

SNIP

> +static struct cu_processing_job *cus_queue__try_dequeue(void)
> +{
> +	struct cu_processing_job *job, *dequeued_job = NULL;
> +	struct list_head *pos, *tmp;
> +
> +	list_for_each_safe(pos, tmp, &cus_processing_queue.jobs) {
> +		job = list_entry(pos, struct cu_processing_job, node);
> +		if (job->type == JOB_STEAL && job->cu->id == cus_processing_queue.next_cu_id) {
> +			dequeued_job = job;
> +			break;
> +		}
> +		if (job->type == JOB_DECODE) {
> +			/* all JOB_STEALs are added to the head, so no viable JOB_STEAL available */
> +			dequeued_job = job;
> +			break;
> +		}
> +	}
> +	/* No jobs or only steals out of order */
> +	if (!dequeued_job)
> +		return NULL;
> +
> +	list_del(&dequeued_job->node);
> +	return job;

IIUC job == dequeued_job at this point, but I think we should return
dequeued_job to be clear

SNIP

> -static void *dwarf_cus__process_cu_thread(void *arg)
> +static struct cu *dwarf_loader__decode_next_cu(struct dwarf_cus *dcus)
>  {
> -	struct dwarf_thread *dthr = arg;
> -	struct dwarf_cus *dcus = dthr->dcus;
>  	uint8_t pointer_size, offset_size;
> +	struct dwarf_cu *dcu = NULL;
>  	Dwarf_Die die_mem, *cu_die;
> -	struct dwarf_cu *dcu;
> +	int err;
>  
> -	while (dwarf_cus__nextcu(dcus, &dcu, &die_mem, &cu_die, &pointer_size, &offset_size) == 0) {
> -		if (cu_die == NULL)
> +	err = dwarf_cus__nextcu(dcus, &dcu, &die_mem, &cu_die, &pointer_size, &offset_size);
> +
> +	if (err < 0)
> +		goto out_error;
> +	else if (err == 1) /* no more CUs */
> +		return NULL;
> +
> +	err = die__process_and_recode(cu_die, dcu->cu, dcus->conf);
> +	if (err)
> +		goto out_error;
> +	if (cu_die == NULL)
> +		return NULL;

should this check be placed before calling die__process_and_recode ?


SNIP

> -static int dwarf_cus__process_cus(struct dwarf_cus *dcus)
> -{
> -	if (dcus->conf->nr_jobs > 1)
> -		return dwarf_cus__threaded_process_cus(dcus);
> -
> -	return __dwarf_cus__process_cus(dcus);
> -}
> -
>  static int cus__merge_and_process_cu(struct cus *cus, struct conf_load *conf,
>  				     Dwfl_Module *mod, Dwarf *dw, Elf *elf,
>  				     const char *filename,
> @@ -3733,7 +3859,8 @@ static int cus__merge_and_process_cu(struct cus *cus, struct conf_load *conf,
>  	if (cu__resolve_func_ret_types_optimized(cu) != LSK__KEEPIT)
>  		goto out_abort;
>  
> -	if (cus__finalize(cus, cu, conf, NULL) == LSK__STOP_LOADING)
> +	cu__finalize(cu, cus, conf);
> +	if (cus__steal_now(cus, cu, conf) == LSK__STOP_LOADING)
>  		goto out_abort;
>  
>  	return 0;
> @@ -3765,7 +3892,8 @@ static int cus__load_module(struct cus *cus, struct conf_load *conf,
>  	}
>  
>  	if (type_cu != NULL) {
> -		type_lsk = cu__finalize(type_cu, cus, conf, NULL);
> +		cu__finalize(type_cu, cus, conf);
> +		type_lsk = cus__steal_now(cus, type_cu, conf);
>  		if (type_lsk == LSK__DELETE) {
>  			cus__remove(cus, type_cu);
>  		}
> @@ -3787,6 +3915,7 @@ static int cus__load_module(struct cus *cus, struct conf_load *conf,
>  			.type_dcu = type_cu ? &type_dcu : NULL,
>  			.build_id = build_id,
>  			.build_id_len = build_id_len,
> +			.nr_cus_created = 0,

should go to the previous patch? if needed at all..

thanks,
jirka

>  		};
>  		res = dwarf_cus__process_cus(&dcus);
>  	}
> diff --git a/dwarves.c b/dwarves.c
> index ae512b9..7c3e878 100644
> --- a/dwarves.c
> +++ b/dwarves.c
> @@ -530,48 +530,6 @@ void cus__unlock(struct cus *cus)
>  	pthread_mutex_unlock(&cus->mutex);
>  }
>  

SNIP

