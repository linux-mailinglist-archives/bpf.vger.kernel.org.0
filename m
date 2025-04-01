Return-Path: <bpf+bounces-55079-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F881A77C77
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 15:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8661518886C2
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 13:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31378204588;
	Tue,  1 Apr 2025 13:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYEP/DUC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1671E47A9;
	Tue,  1 Apr 2025 13:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743515024; cv=none; b=VBtlL3AVY6GYf185Kj2GeHrOS+hhKFh9Ueh5dJ6Ml8TpGod0EM4zg1JJ7irT+Al3AjgKCGkPcPYVUIGA3LarrgRWzfgPQNh2Hojs4aKNI34x4uNOdHZAh2UlKh7aEX4cpK+rfLmUTi3ofUShB0e3rYMgxKZWHLuJdB4zKmwQomg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743515024; c=relaxed/simple;
	bh=/XqH24T1UoWaPhBz8M5OaT7C5pYQ/AAk+jMoh6kLQd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N9zwtAeXROmpr3S6jSEsUlHdUSCXxwz4Dcx21BKOJY2Wy2ve0E/fi5ns9PUjZrHKp7LiBnOf/MqJlhznBIPA5lcXmJW196SMj50ZOn8XFswt3A+5dvaPeGQMR9SHl3yuAHvyxkSB8U37JrQaN/5zbGYH7oMZTtZlt4d3M0o/4Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IYEP/DUC; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e614da8615so21331a12.1;
        Tue, 01 Apr 2025 06:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743515021; x=1744119821; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n9k81anO66yjYvY4gnaQKZ5zJIvEUBEC3H/18Pl1WPU=;
        b=IYEP/DUC1UGkqAOTyoCf6N1q+U15L5u9gqwCwAvv7Ei7gMDkgY1HcEHuZAWk+vVZM5
         iBTPKFXZQEa2k1iVsHnRU8KHEEGt6TyjeOYJXAzpYhIIw1CvK8/GNYFhIOHnAXisApO+
         8dgTxcqCiClJpd0aqeR9T6fnNqmU+HJMP6sAtGGatZje7wSS/nzzFPx9wabaLyYJg9Hp
         v474Z47wHG23cmECMK9zcgdZrqH6pk0a9r30NutFr6z7QR8f3KBq+7oNurGshS//pm2P
         MOcDtTiNcpCdDbsrBZumofiJwm2uR2OkIsNsynUIwNagb3mDHmRXkVI1QDm+0a06BlDP
         hzfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743515021; x=1744119821;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n9k81anO66yjYvY4gnaQKZ5zJIvEUBEC3H/18Pl1WPU=;
        b=R1TnEG4QWM+Mt30bRmhJ78J7Yq5IhdtApxtR4568BekgWUNrxgbG2kUmJcn16k98jZ
         MRGHJe4MQWy3RL8YuLwiLDtHugScUQ7Lz3X6ESoWn9aYSN98HeZWROj0MopVEnVtXCsH
         A29jQLOR+yZt7sxpdcDHwBySDz0XS3FK5OdzVKkTkIt/8eKWbHDzmRJeCaYXkEZT158w
         35d8oOip4PajfiNMlpqrd/t7FqRUMDjUD6CbEs2v7qx/tqJvVy75WWIzCFfJKerR3kL+
         hgfZn3Rg0epLx5R4fh0/gT7QNQo5QwhigQc9gbe7tKtt59+QGiQmdYa8XiRPhqJiwkqI
         uIJQ==
X-Forwarded-Encrypted: i=1; AJvYcCURtS1f/8oxkIE30j8LuWbXC8L4K8dWbGRCVr9gnXSn8LkxXaEnervcwGvyr0HLwM/Vxpp69C3wrA==@vger.kernel.org, AJvYcCVOjoZWIBVzipreGssij6gFGAzlVH1QU6RT0tdJRIvtwxCQ8boScGGMVSSkq2czviZ5uAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YylKvWBSRtu+usTavbNwj2xpMWpsa8LRp80C8N1yvpKmHtbNAsm
	bODsxyIpMGkPrmKU93Av+ms1VxKZKLZGAkehpJf1njZ4TkVSCPx6
X-Gm-Gg: ASbGnct4LqDrbZdbUOVpM4rktfM/UMxDIZkd3NCY0ymzFnxvoACJ4fUZSvQBE14lmUJ
	oVx4JR56dklBx8tINt+gPDvHNXU8aanYwbBEUiNR+z958uKReHa+02CeIvnnALX+gerVpzKGmKR
	YggpcP1eRvIfYw+6Ztnz51F8h5GN5N89rrEJSoTfDKI7r0F/b7xtxHtP+Gjko7W9FuX/o2z0wic
	nEVdHetfcHaaY7KK4wx3SIxtURb/xoL7U5le5zKCDUiypm+twDmKEMkR9xECoCu3azESFaw6kxN
	KPLwFkWYqSWiGJa7
X-Google-Smtp-Source: AGHT+IHFaradrAoomxFRZJTv3LOtY734zK/BCxChTnYHlDir8PF5lPFlAeHVEwKf47oc7IDYvO+blw==
X-Received: by 2002:a05:6402:210e:b0:5e0:4c25:1491 with SMTP id 4fb4d7f45d1cf-5edc44e4379mr15300584a12.7.1743515020793;
        Tue, 01 Apr 2025 06:43:40 -0700 (PDT)
Received: from m4.lan ([2a0b:f4c2:1::1])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5edc17e006fsm7035574a12.68.2025.04.01.06.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 06:43:40 -0700 (PDT)
Sender: Domenico Andreoli <domenico.andreoli.it@gmail.com>
Received: from cavok by m4.lan with local (Exim 4.96)
	(envelope-from <cavok@localhost>)
	id 1tzbty-000YuJ-1E;
	Tue, 01 Apr 2025 15:43:38 +0200
Date: Tue, 1 Apr 2025 15:43:38 +0200
From: Domenico Andreoli <domenico.andreoli@linux.com>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>, dwarves@vger.kernel.org,
	bpf@vger.kernel.org, acme@kernel.org, andrii@kernel.org,
	eddyz87@gmail.com, mykolal@fb.com, kernel-team@meta.com
Subject: Re: [PATCH dwarves] dwarf_loader: fix termination on BTF encoding
 error
Message-ID: <Z-vtiuRaolc91Nkc@localhost>
References: <20250328174003.3945581-1-ihor.solodrai@linux.dev>
 <27afc430-face-4013-9b87-4168f38b6b23@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27afc430-face-4013-9b87-4168f38b6b23@oracle.com>

On Tue, Apr 01, 2025 at 01:57:25PM +0100, Alan Maguire wrote:
> On 28/03/2025 17:40, Ihor Solodrai wrote:
> > When BTF encoding thread aborts because of an error, dwarf loader
> > worker threads get stuck in cus_queue__enqdeq_job() at:
> > 
> >     pthread_cond_wait(&cus_processing_queue.job_added, &cus_processing_queue.mutex);
> > 
> > To avoid this, introduce an abort flag into cus_processing_queue, and
> > atomically check for it in the deq loop. The flag is only set in case
> > of a worker thread exiting on error. Make sure to pthread_cond_signal
> > to the waiting threads to let them exit too.
> > 
> > In cus__process_file fix the check of an error returned from
> > dwfl_getmodules: it may return a positive number when a
> > callback (cus__process_dwflmod in our case) returns an error.
> > 
> > Link: https://lore.kernel.org/dwarves/Z-JzFrXaopQCYd6h@localhost/
> > 
> > Reported-by: Domenico Andreoli <domenico.andreoli@linux.com>
> > Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> 
> Thanks for the fix! I've tested this with the problematic module+vmlinux
> BTF and the previously-hanging pahole goes on to fail as expected; also
> run it through the work-in-progress CI, building and testing on x86_64
> and aarch64, no issues found. If anyone else has a chance to ack or test
> it, that would be great. Thanks!

Tested-by: Domenico Andreoli <domenico.andreoli@linux.com>

I rebuilt the Debian package with that patch applied and it then started
to fail consistently because of the extra c++ symbols.

When I use the switch --lang_exclude=rust,c++11, it works without
errors.

Thank you Alan and Ihor for the fast support!

Dom

> 
> Alan
> 
> > ---
> >  dwarf_loader.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> > 
> > diff --git a/dwarf_loader.c b/dwarf_loader.c
> > index 84122d0..e1ba7bc 100644
> > --- a/dwarf_loader.c
> > +++ b/dwarf_loader.c
> > @@ -3459,6 +3459,7 @@ static struct {
> >  	 */
> >  	uint32_t next_cu_id;
> >  	struct list_head jobs;
> > +	bool abort;
> >  } cus_processing_queue;
> >  
> >  enum job_type {
> > @@ -3479,6 +3480,7 @@ static void cus_queue__init(void)
> >  	pthread_cond_init(&cus_processing_queue.job_added, NULL);
> >  	INIT_LIST_HEAD(&cus_processing_queue.jobs);
> >  	cus_processing_queue.next_cu_id = 0;
> > +	cus_processing_queue.abort = false;
> >  }
> >  
> >  static void cus_queue__destroy(void)
> > @@ -3535,8 +3537,9 @@ static struct cu_processing_job *cus_queue__enqdeq_job(struct cu_processing_job
> >  		pthread_cond_signal(&cus_processing_queue.job_added);
> >  	}
> >  	for (;;) {
> > +		bool abort = __atomic_load_n(&cus_processing_queue.abort, __ATOMIC_SEQ_CST);
> >  		job = cus_queue__try_dequeue();
> > -		if (job)
> > +		if (job || abort)
> >  			break;
> >  		/* No jobs or only steals out of order */
> >  		pthread_cond_wait(&cus_processing_queue.job_added, &cus_processing_queue.mutex);
> > @@ -3653,6 +3656,9 @@ static void *dwarf_loader__worker_thread(void *arg)
> >  
> >  	while (!stop) {
> >  		job = cus_queue__enqdeq_job(job);
> > +		if (!job)
> > +			goto out_abort;
> > +
> >  		switch (job->type) {
> >  
> >  		case JOB_DECODE:
> > @@ -3688,6 +3694,8 @@ static void *dwarf_loader__worker_thread(void *arg)
> >  
> >  	return (void *)DWARF_CB_OK;
> >  out_abort:
> > +	__atomic_store_n(&cus_processing_queue.abort, true, __ATOMIC_SEQ_CST);
> > +	pthread_cond_signal(&cus_processing_queue.job_added);
> >  	return (void *)DWARF_CB_ABORT;
> >  }
> >  
> > @@ -4028,7 +4036,7 @@ static int cus__process_file(struct cus *cus, struct conf_load *conf, int fd,
> >  
> >  	/* Process the one or more modules gleaned from this file. */
> >  	int err = dwfl_getmodules(dwfl, cus__process_dwflmod, &parms, 0);
> > -	if (err < 0)
> > +	if (err)
> >  		return -1;
> >  
> >  	// We can't call dwfl_end(dwfl) here, as we keep pointers to strings
> 
> 

-- 
rsa4096: 3B10 0CA1 8674 ACBA B4FE  FCD2 CE5B CF17 9960 DE13
ed25519: FFB4 0CC3 7F2E 091D F7DA  356E CC79 2832 ED38 CB05

