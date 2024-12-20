Return-Path: <bpf+bounces-47410-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5779F8EE9
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 10:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24DF4166F64
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 09:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDD31A8419;
	Fri, 20 Dec 2024 09:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b38rhq+T"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A2219F471;
	Fri, 20 Dec 2024 09:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734686710; cv=none; b=ABXX/WxBogBez8GPNZ+d5I6wD9rGvjd4k26G4yL25GvPYqL0EN4Xb8ix7q+29LEmgArGyqADnfZClX44Khs0BzZ4t1m5YGvmm02kxAw8c8GxT7F23kJF11FcvjELMqrtaUbs4U6pAUYnejS0+DjXO5zyasT+JycOoZAbi1GRPdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734686710; c=relaxed/simple;
	bh=K7FgU7x/MhJrjp4LGsTkeXWCeWl1nt1MVeFl8CqcXhY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BsFsEg7J/g0oSyIVeombM+L1G3Pe7p8vN/ipm9K2GmPtqJAwFnsVgxTK0Wno2ppNZbAsc0g0hS7OL9IMVyR8maJyddOegWob5HJKDc4fUMxhu80ErFzLmf77ob3RyaVIDWfd7EncY8bLF36hzzrTj5Fee87vzC5tF2oKo6OJ8/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b38rhq+T; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-388cae9eb9fso956866f8f.3;
        Fri, 20 Dec 2024 01:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734686706; x=1735291506; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YJ02lvMh+3l+K8jMARDLOYxNUHzDPXRTK+yzso8mae4=;
        b=b38rhq+TKai7KjNrov1f8rhtb6esG97V5FjhnNCAP+kUAJZupy+10sjg4IG2enm9Gf
         eZ8WukDFNqy4CRArf4N/aWGz2JY+FYIXCCa5qjCEfr+XhDlNAzuQ2OWfGTCzI6LebqiN
         +P0OkHakTqRSSUDOT2nUIvLL6JPn36QQ0MdZiFr2SjyQV+W2wjGb+ujTvyAj7ElTXVVj
         xfc7E6CrbotLDv/oeIJzRbezPa9JxWdbEeFeN471qunDoeGDmhX+Vse2SXoyYpQ3QPKV
         pm5rc6r1dT/1v1HbsOauQw8mVAG3h5pChVdvmLSw/qPxLIc8N3iuevI3ElQmTQEhRPl4
         y7Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734686706; x=1735291506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJ02lvMh+3l+K8jMARDLOYxNUHzDPXRTK+yzso8mae4=;
        b=OQR6U8KnwRFp778sMHyPU298NhiHd6UPmWoafGn1YBQE5uCBkBYdPf9Mf4vWvRWCl1
         czoAtE/XuszPOhoSc0sMg5+LDvDNClc8SV0ZRdqorbHzKsyudbeENGDlAc1up+ZauflM
         Px8vVw/x5ptTlx8KAGXQURh+NgMj46UQKTKuDKdzkK2XOgNU4pFjRlGB66A0hN36uMwE
         48ksPNb12gsMTgTFtkhBrMKjqNmZ+JJJMqY+TvRY1uPBKwsX2VHLWCfW98eAEosmeqio
         jRY+kPXLXn7EgJMXpdwcErxdbQpTYj9PgyiEH3mLdfuZjaEMoFgWqkGp2V+ZBIer/ACc
         7iyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfmNI9p7do/aROYgBk+dw+pIUjuDsf8/XeLGn/rPO5j3vHPxb7DF4HXo9jGBdLpCYmzDnJSTqD4A==@vger.kernel.org, AJvYcCVjGw6gYgIff75Linyptd/9z3L1ndTP9Y1hhJ3CrVlvXZCM5TRXAbNMaZuUyjGk9PQo/zg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlwQazk3o/6Spt/19CD6X09aLCVJmZMcZW4Po+WUDJYngMMquW
	OO0Jfc5HQMOd23+b6U6CfOhS6T0uFVyatBRe2hg+9m5LUvEx/wo3I3MfoQ==
X-Gm-Gg: ASbGncuc32J8j443LfHYzGVPetnII2WFzY0mup4IG4O0tvv9DUPZxqKZmhtwvC3plvB
	JjYMqzcsVuTiVCJNPtmHl/qCqO7Y0ONbX1HSbL05A4ApbeJK5pItDl6BhvkbaCQqd5jyGB/7ADr
	WIx2ZTWu3TGYlLsBwnA/nDipyGnYbbQ9uzwFK/1g5urpshMcC4I/AZjtBxsRGRTsnIKMqTY+vUS
	l0400V1AR6WdEaIbNLI5Ced1tgFdpIxtnFtXKtswtZQ1afasEk6ECx+SxzrUGNFj73dudBzGzNf
	Ds54Uq3Ka0HqQY5pbaftS9DZYLTQQQ==
X-Google-Smtp-Source: AGHT+IFPLalNGQnzldQjCiymOy+iFHHOxICFsrQ++sEbtGTKaNPAm8cj7myFuylVIMkkTYXlVOuThQ==
X-Received: by 2002:a05:6000:481e:b0:382:49f9:74bb with SMTP id ffacd0b85a97d-38a2220120dmr2130765f8f.35.1734686705952;
        Fri, 20 Dec 2024 01:25:05 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436612899f0sm40395355e9.38.2024.12.20.01.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 01:25:05 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 20 Dec 2024 10:25:03 +0100
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: Jiri Olsa <olsajiri@gmail.com>, dwarves@vger.kernel.org,
	acme@kernel.org, alan.maguire@oracle.com, eddyz87@gmail.com,
	andrii@kernel.org, mykolal@fb.com, bpf@vger.kernel.org
Subject: Re: [PATCH dwarves v2 10/10] dwarf_loader: multithreading with a
 job/worker model
Message-ID: <Z2U370eu9uPbSk5F@krava>
References: <20241213223641.564002-1-ihor.solodrai@pm.me>
 <20241213223641.564002-11-ihor.solodrai@pm.me>
 <Z2Q0wU_AOOF0c_NF@krava>
 <Gk0nTkIuEA2FQD6WzNeIq1Hsoj5V2zwmar99_nB5a_Yc96sJLMi3W57sBAr84aUJjUepJkLgVqkOAeXVPvx7B7P0WIgl6qJib2Kw-iGRwaM=@pm.me>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Gk0nTkIuEA2FQD6WzNeIq1Hsoj5V2zwmar99_nB5a_Yc96sJLMi3W57sBAr84aUJjUepJkLgVqkOAeXVPvx7B7P0WIgl6qJib2Kw-iGRwaM=@pm.me>

On Thu, Dec 19, 2024 at 07:31:35PM +0000, Ihor Solodrai wrote:

SNIP

> > 
> > 
> > why '* 4' ?
> 
> This is an arbitrary limit, described in comments.
> 
> If we allow the workers to pick up next cu for decoding as soon as
> it's ready, then the memory usage may greatly increase, if the stealer
> can't keep up with incoming work.
> 
> If we want to avoid this there needs to be a limit on how many
> decoded, but not yet stolen, CUs we allow to hold in memory. When
> this limit is reached the workers will wait for more CUs to get
> stolen.
> 
> N x 4 is a number I picked after trying various values and looking at
> the resulting memory usage.

I think we can pick some number and add reasoning to the comment

> 
> We could make it configurable, but this value doesn't look to me as a
> reasonable user-facing option. Maybe we could add "I don't care about
> memory usage" flag to pahole? wdyt?

--I-don-t-care-about-memory-usage sounds great :-) but I think constant with
some comment will be enough for now and we'll see if we need it in future


> 
> > 
> > > +
> > > + /* fill up the queue with nr_workers JOB_DECODE jobs */
> > > + for (int i = 0; i < nr_workers; i++) {
> > > + job = calloc(1, sizeof(*job));
> > 
> > 
> > missing job != NULL check
> > 
> > > + job->type = JOB_DECODE;
> > > + /* no need for locks, workers were not started yet */
> > > + list_add(&job->node, &cus_processing_queue.jobs);
> > > }
> > > 
> > > - for (i = 0; i < dcus->conf->nr_jobs; ++i) {
> > > - dthr[i].dcus = dcus;
> > > - dthr[i].data = thread_data[i];
> > > + if (dcus->error)
> > > + return dcus->error;
> > > 
> > > - dcus->error = pthread_create(&threads[i], NULL,
> > > - dwarf_cus__process_cu_thread,
> > > - &dthr[i]);
> > > + for (int i = 0; i < nr_workers; ++i) {
> > > + dcus->error = pthread_create(&workers[i], NULL,
> > > + dwarf_loader__worker_thread,
> > > + dcus);
> > > if (dcus->error)
> > > goto out_join;
> > > }
> > > @@ -3596,54 +3766,19 @@ static int dwarf_cus__threaded_process_cus(struct dwarf_cus *dcus)
> > > dcus->error = 0;
> > > 
> > > out_join:
> > > - while (--i >= 0) {
> > > + for (int i = 0; i < nr_workers; ++i) {
> > 
> > 
> > I think you should keep the original while loop to cleanup/wait only for
> > threads that we actually created
> 
> Do you mean in case of an error from pthread_create? Ok.

yes, thanks

jirka

