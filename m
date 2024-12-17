Return-Path: <bpf+bounces-47077-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4909F3F98
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2024 01:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BD1E16456B
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2024 00:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A231B960;
	Tue, 17 Dec 2024 00:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YnEcgDvj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B19168DA;
	Tue, 17 Dec 2024 00:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734397061; cv=none; b=PLfjgBEfolVnW/Mrk0TwTBAzrEDpLhBt65VeNLvK9h8auaS3GFejb7bVE0XOKNL0lPxGs5pNL0cRC+54KUBpzy80G4rNYYmCHNQ0DQNw0g7/92Y4z3powJrO73rVVvF/kxdfd2kYnZgr9mFzB9at7ohA9KiLBImy4l7PXJn83Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734397061; c=relaxed/simple;
	bh=wcgRH0uoYDTznwSz2jFUbenqmI8duUpRKOMkft965Vw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gpf1ouBTlx47tgJVY1WbFoiaTbHe4I3Z0lueTtejSJ9SelpYqPPUt91/G8PK89XLUizsHgftrnYnMRJeXVmYz7jFP3/fj1R0ZEcl4B5gedM57/7kEURsR5RZWTzfX7qq4VB86KOuf9UGPQYvqWalBXg0HMAD0k2leRogjewzII8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YnEcgDvj; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-725c86bbae7so3968433b3a.3;
        Mon, 16 Dec 2024 16:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734397059; x=1735001859; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/A1jHxsnaFQqON91+xgAaO9jnXVSk6MINEQlGarahB4=;
        b=YnEcgDvj1+DpCzS+bKfxL+onDCT6GYXeXZUZnX3pCaC2G0rvb8KwOn/+pxhkjVgnaM
         9/yHOWoV8MgBtN7qihA6sLlmmSx5AgrOVjoFEmNYYGF6OFx4PNjLlE62rRmUO2CJQGi0
         aRP3OrOkuACtuTk589JEWGL/ui6LrEip9Gm768D90tMotxzPJkoPyNSr99KpDIsk5e9n
         O7/+nBYkc7WlVS7p5kzegp+fUgL9Q78Y8XIGXndiJz9yHQCUeDgAYnvMZaIgOvA+zQOV
         uR3J8ANGwQ+jvyzkb3LYYsNDh5RDwXKy0C1MHBieuTZzKJ/ogafOJhj2zu3nG6Ml6wI/
         RlGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734397059; x=1735001859;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/A1jHxsnaFQqON91+xgAaO9jnXVSk6MINEQlGarahB4=;
        b=R0X6VHL8tec5aBb1X4bqToqk0Yu9wLSmGpx9zjo+VFKqxq1UjtlecfS/xMFEfbAkmP
         pSi1NrsPXhTGqb+m0LLWI57odGAb+C3Q+qIXFukQcLqAVpZBzNFTPHAiKQ3YjCHfMjNW
         giclvnUxlgsx/BpdyeHVcWdkO+MV6X5UrivNbPWyg/9D3ee49CZHRIqaaKyj7r+rb4D0
         hkfiSQZFSGfOYeejdrpPdyPOUkAtJgTTxMxGaQl0prig1TKGq1BVfzUB06KFImXvhwXJ
         ZkyeTgjANlQYLagemQtjhR6ljiRpem4SVy5Bnl7orVKNjncMyRWEVCbX2OBGCjljRGb3
         8rlw==
X-Forwarded-Encrypted: i=1; AJvYcCXPwu6YZYkRVdjpT7KremM6lh8/tYRUe6cTZetgO8gl1GQ14vfZyfHwlHM4Dc7/rLmhXpE=@vger.kernel.org, AJvYcCXgYxtNjzBtcqWqkqvrWcrBv4uaPJhn44KmjsWAII0GQz+UC8v5s0ZH9xGZwcp5ncdAEucxXi1MJw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4lweMlM2yFMS6S55iTQFChDEyGDGW19aKoBbA8lO4rtSnKeUu
	xal5n29XJzHJxw6Hf6xHnU85UUPrRpwW3h8bi+ZpPDEJXRsA9Slk
X-Gm-Gg: ASbGnctYR8+2xiwIUIO1iLMICJ7F5wBpnUOWDHW1RKKURQW43OPMelWgOAGU7C0ldP9
	ZPX2oWPH0caFmQAsn9GyF6cmhJ8nPsbeuov2Su7/ZAyhwlpvunHG7/0I626qa811CVejrOZVHow
	rKsyqrHvNSKScg/LnFbMmfuic7498FrhNYq0R1y2xbXIWU9SXqUUrwAnLLqpFzBmPiRuPu3MsKf
	3wcp/T2wCnvXP2SUVTAtCzISCqJzqy1ucFDLxsoMWWif/Sl4/pmCg==
X-Google-Smtp-Source: AGHT+IGiHHKSsjiU4PqE7ERFNBBk77entyvhtxfQEZgqc/V4ZeMXzBNgagC+wlwwTk+B9XWTiX2ulQ==
X-Received: by 2002:a05:6a21:8988:b0:1e3:e77d:1431 with SMTP id adf61e73a8af0-1e3e77d174bmr2744948637.23.1734397058994;
        Mon, 16 Dec 2024 16:57:38 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918bad9c7sm5400407b3a.160.2024.12.16.16.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 16:57:38 -0800 (PST)
Message-ID: <58dc053c9d47a18124d8711604b08acbc6400340.camel@gmail.com>
Subject: Re: [PATCH dwarves v2 10/10] dwarf_loader: multithreading with a
 job/worker model
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@pm.me>, dwarves@vger.kernel.org
Cc: acme@kernel.org, alan.maguire@oracle.com, andrii@kernel.org,
 mykolal@fb.com, 	bpf@vger.kernel.org
Date: Mon, 16 Dec 2024 16:57:33 -0800
In-Reply-To: <20241213223641.564002-11-ihor.solodrai@pm.me>
References: <20241213223641.564002-1-ihor.solodrai@pm.me>
	 <20241213223641.564002-11-ihor.solodrai@pm.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-12-13 at 22:37 +0000, Ihor Solodrai wrote:

[...]

> +static void *dwarf_loader__worker_thread(void *arg)
> +{
> +	struct cu_processing_job *job;
> +	struct dwarf_cus *dcus =3D arg;
> +	bool stop =3D false;
> +	struct cu *cu;
> +
> +	while (!stop) {
> +		job =3D cus_queue__dequeue_job();
> +
> +		switch (job->type) {
> +
> +		case JOB_DECODE:
> +			cu =3D dwarf_loader__decode_next_cu(dcus);
> +
> +			if (cu =3D=3D NULL) {
> +				free(job);
> +				stop =3D true;
> +				break;
> +			}
> +
> +			/* Create and enqueue a new JOB_STEAL for this decoded CU */
> +			struct cu_processing_job *steal_job =3D calloc(1, sizeof(*steal_job))=
;
> +
> +			steal_job->type =3D JOB_STEAL;
> +			steal_job->cu =3D cu;
> +			cus_queue__enqueue_job(steal_job);
> +
> +			/* re-enqueue JOB_DECODE so that next CU is decoded from DWARF */
> +			cus_queue__enqueue_job(job);
> +			break;
> +
> +		case JOB_STEAL:
> +			if (cus__steal_now(dcus->cus, job->cu, dcus->conf) =3D=3D LSK__STOP_L=
OADING)
> +				goto out_abort;
> +			cus_queue__inc_next_cu_id();
> +			/* Free the job struct as it's no longer
> +			 * needed after CU has been stolen.
> +			 * dwarf_loader work for this CU is done.
> +			 */
> +			free(job);
>  			break;
> =20
> -		if (dwarf_cus__process_cu(dcus, cu_die, dcu->cu, dthr->data) =3D=3D DW=
ARF_CB_ABORT)
> +		default:
> +			fprintf(stderr, "Unknown dwarf_loader job type %d\n", job->type);
>  			goto out_abort;
> +		}
>  	}
> =20
> -	if (dcus->conf->thread_exit &&
> -	    dcus->conf->thread_exit(dcus->conf, dthr->data) !=3D 0)
> +	if (dcus->error)
>  		goto out_abort;
> =20
>  	return (void *)DWARF_CB_OK;
> @@ -3566,29 +3736,29 @@ out_abort:
>  	return (void *)DWARF_CB_ABORT;
>  }

There is no real need to use two conditional variables to achieve what is d=
one here.
The "JOB_DECODE" item is already used as a "ticket" to do the decoding.
So it is possible to "emit" a fixed amount of tickets and alternate their s=
tate
between "decode"/"steal", w/o allocating new tickets.
This would allow to remove "job_taken" conditional variable and decode coun=
ters.
E.g. as in the patch below applied on top of this patch-set.

---

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 6d22648..40ad27d 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -3453,23 +3453,10 @@ struct dwarf_cus {
 static struct {
 	pthread_mutex_t mutex;
 	pthread_cond_t job_added;
-	pthread_cond_t job_taken;
 	/* next_cu_id determines the next CU ready to be stealed
 	 * This enforces the order of CU stealing.
 	 */
 	uint32_t next_cu_id;
-	/* max_decoded_cus is a soft limit on the number of JOB_STEAL
-	 * jobs currently in the queue (this number is equal to the
-	 * number of decoded CUs held in memory). It's soft, because a
-	 * worker thread may finish decoding it's current CU after
-	 * this limit has already been reached. In such situation,
-	 * JOB_STEAL with this CU is still added to the queue,
-	 * although a worker will not pick up a new JOB_DECODE.
-	 * So the real hard limit is max_decoded_cus + nr_workers.
-	 * This variable indirectly limits the memory usage.
-	 */
-	uint16_t max_decoded_cus;
-	uint16_t nr_decoded_cus;
 	struct list_head jobs;
 } cus_processing_queue;
=20
@@ -3489,10 +3476,7 @@ static void cus_queue__init(uint16_t max_decoded_cus=
)
 {
 	pthread_mutex_init(&cus_processing_queue.mutex, NULL);
 	pthread_cond_init(&cus_processing_queue.job_added, NULL);
-	pthread_cond_init(&cus_processing_queue.job_taken, NULL);
 	INIT_LIST_HEAD(&cus_processing_queue.jobs);
-	cus_processing_queue.max_decoded_cus =3D max_decoded_cus;
-	cus_processing_queue.nr_decoded_cus =3D 0;
 	cus_processing_queue.next_cu_id =3D 0;
 }
=20
@@ -3500,7 +3484,6 @@ static void cus_queue__destroy(void)
 {
 	pthread_mutex_destroy(&cus_processing_queue.mutex);
 	pthread_cond_destroy(&cus_processing_queue.job_added);
-	pthread_cond_destroy(&cus_processing_queue.job_taken);
 }
=20
 static inline void cus_queue__inc_next_cu_id(void)
@@ -3520,12 +3503,10 @@ static void cus_queue__enqueue_job(struct cu_proces=
sing_job *job)
 	/* JOB_STEAL have higher priority, add them to the head so
 	 * they can be found faster
 	 */
-	if (job->type =3D=3D JOB_STEAL) {
+	if (job->type =3D=3D JOB_STEAL)
 		list_add(&job->node, &cus_processing_queue.jobs);
-		cus_processing_queue.nr_decoded_cus++;
-	} else {
+	else
 		list_add_tail(&job->node, &cus_processing_queue.jobs);
-	}
=20
 	pthread_cond_signal(&cus_processing_queue.job_added);
 	pthread_mutex_unlock(&cus_processing_queue.mutex);
@@ -3537,45 +3518,28 @@ static struct cu_processing_job *cus_queue__dequeue=
_job(void)
 	struct list_head *pos, *tmp;
=20
 	pthread_mutex_lock(&cus_processing_queue.mutex);
-	while (list_empty(&cus_processing_queue.jobs))
-		pthread_cond_wait(&cus_processing_queue.job_added, &cus_processing_queue=
.mutex);
-
-	/* First, try to find JOB_STEAL for the next CU */
+retry:
 	list_for_each_safe(pos, tmp, &cus_processing_queue.jobs) {
 		job =3D list_entry(pos, struct cu_processing_job, node);
 		if (job->type =3D=3D JOB_STEAL && job->cu->id =3D=3D cus_processing_queu=
e.next_cu_id) {
-			list_del(&job->node);
-			cus_processing_queue.nr_decoded_cus--;
 			dequeued_job =3D job;
 			break;
 		}
-	}
-
-	/* If no JOB_STEAL is found, check if we are allowed to decode
-	 * more CUs.  If not, it means that the CU with next_cu_id is
-	 * still being decoded while the queue is "full". Wait.
-	 * job_taken will signal that another thread was able to pick
-	 * up a JOB_STEAL, so we might be able to proceed with JOB_DECODE.
-	 */
-	if (dequeued_job =3D=3D NULL) {
-		while (cus_processing_queue.nr_decoded_cus >=3D cus_processing_queue.max=
_decoded_cus)
-			pthread_cond_wait(&cus_processing_queue.job_taken, &cus_processing_queu=
e.mutex);
-
-		/* We can decode now. */
-		list_for_each_safe(pos, tmp, &cus_processing_queue.jobs) {
-			job =3D list_entry(pos, struct cu_processing_job, node);
-			if (job->type =3D=3D JOB_DECODE) {
-				list_del(&job->node);
-				dequeued_job =3D job;
-				break;
-			}
+		if (job->type =3D=3D JOB_DECODE) {
+			/* all JOB_STEALs are added to the head, so no viable JOB_STEAL availab=
le */
+			dequeued_job =3D job;
+			break;
 		}
 	}
-
-	pthread_cond_signal(&cus_processing_queue.job_taken);
+	/* No jobs or only steals out of order */
+	if (!dequeued_job) {
+		pthread_cond_wait(&cus_processing_queue.job_added, &cus_processing_queue=
.mutex);
+		goto retry;
+	}
+	list_del(&dequeued_job->node);
 	pthread_mutex_unlock(&cus_processing_queue.mutex);
=20
-	return dequeued_job;
+	return job;
 }
=20
 static struct dwarf_cu *dwarf_cus__create_cu(struct dwarf_cus *dcus, Dwarf=
_Die *cu_die, uint8_t pointer_size)
@@ -3700,14 +3664,8 @@ static void *dwarf_loader__worker_thread(void *arg)
 				break;
 			}
=20
-			/* Create and enqueue a new JOB_STEAL for this decoded CU */
-			struct cu_processing_job *steal_job =3D calloc(1, sizeof(*steal_job));
-
-			steal_job->type =3D JOB_STEAL;
-			steal_job->cu =3D cu;
-			cus_queue__enqueue_job(steal_job);
-
-			/* re-enqueue JOB_DECODE so that next CU is decoded from DWARF */
+			job->type =3D JOB_STEAL;
+			job->cu =3D cu;
 			cus_queue__enqueue_job(job);
 			break;
=20
@@ -3715,11 +3673,10 @@ static void *dwarf_loader__worker_thread(void *arg)
 			if (cus__steal_now(dcus->cus, job->cu, dcus->conf) =3D=3D LSK__STOP_LOA=
DING)
 				goto out_abort;
 			cus_queue__inc_next_cu_id();
-			/* Free the job struct as it's no longer
-			 * needed after CU has been stolen.
-			 * dwarf_loader work for this CU is done.
-			 */
-			free(job);
+			/* re-enqueue JOB_DECODE so that next CU is decoded from DWARF */
+			job->type =3D JOB_DECODE;
+			job->cu =3D NULL;
+			cus_queue__enqueue_job(job);
 			break;
=20
 		default:
@@ -3742,10 +3699,10 @@ static int dwarf_cus__process_cus(struct dwarf_cus =
*dcus)
 	pthread_t workers[nr_workers];
 	struct cu_processing_job *job;
=20
-	cus_queue__init(nr_workers * 4);
+	cus_queue__init(nr_workers);
=20
 	/* fill up the queue with nr_workers JOB_DECODE jobs */
-	for (int i =3D 0; i < nr_workers; i++) {
+	for (int i =3D 0; i < nr_workers * 4; i++) {
 		job =3D calloc(1, sizeof(*job));
 		job->type =3D JOB_DECODE;
 		/* no need for locks, workers were not started yet */


