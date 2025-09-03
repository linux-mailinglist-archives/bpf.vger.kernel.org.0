Return-Path: <bpf+bounces-67253-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B49F3B41546
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 08:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 898B31A811CA
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 06:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D742D876B;
	Wed,  3 Sep 2025 06:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ab7lWTdA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72491F4C85;
	Wed,  3 Sep 2025 06:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756881359; cv=none; b=ShQhaDae+QzJBWPuQmUDGG/diW4Pzn4QxZkxxfxuuEpMGjfeSWyZqs28FWIcSyhJ95iVdIsqwsWCVqz0HAT+kHe4Bu/UIs8ZZX7Fs0T5uZZOTgFJ5xrg/uB/wLDAl6VRDty/zbhomh1fCN7oxarT9qFoSKgXR4ivdlKoj6g5qs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756881359; c=relaxed/simple;
	bh=UTMzuQVzloVO/bJU0/VxUNPURnzSJf47Kqe1+UJzVyM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VbtrsqO+iBalqWixkoNnPM1p+/dqv2E3MENJm6fa5IB5VNPNbhZySiJ6AyQxo7oYTVfUAI87RdAGbDcNbA4CDmhZsFpFpwaE5zrNHDPSc3RBYPG1GpsttAgyqAJNhm6SPvTbKItomyLE2rKR2y2GSSl+YaZBPFMTgeqkEwXKVOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ab7lWTdA; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b02c719a117so460521066b.1;
        Tue, 02 Sep 2025 23:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756881356; x=1757486156; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kFyoMJw6KiFQC6JDcSTadI7EhSdz+gbovd/Nmw8VGsI=;
        b=ab7lWTdA7SNDmxFE9ZXzkNhvk73IlbqBgs1gZqhr9xaqWu5buoJnc9D/05aTJjA4JK
         r/fMNnhqkItyo3WRyeZQe1TNDXbKyvhaRr8sdunHnu/1njeV1EL1ysdRcg/Wt4MZSASC
         jnqM9CFDXSOjkHYR/opYd7hazI3LUm8iK2LTwvuzh8v+5rN1Y+7i3k7bXSxwa4oqP4BB
         lFojdDWxlC1vHCVQHu+mp03MEkDX35zgJv5C3J6QCYlVwIduFCBoufGaZFTm/ogGr/IB
         Pg3wNVcpif7Ar90Pkqmpi4v30zRX2jpPjqvCr+3Nbgs9+EAHE6tYLHv4jKFoD/L+PwDZ
         U30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756881356; x=1757486156;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kFyoMJw6KiFQC6JDcSTadI7EhSdz+gbovd/Nmw8VGsI=;
        b=PFGf+O0KEgFvJ6/8ZUDMNKrkWmruBh7RtNu28vAl8Yg2iaoxg1IHoO/91KXgxsaT4q
         vbVzHc+jurBQErE7ADkcQMyYyIUUcZ8vjdwOQSO5EjGimHhcy1wcEKn2tX7goOk2k13u
         j5N/IKyFMx982vjXAfQG19SlP+1hVzWm5fsc1IF+0Thibmb+GYw5ilp4ZBkOlNHIfdkr
         72pBLeP7SwB+Q4XraJJBJ2S3HHCPOKZn2Zh01hO/i7FWyfgvTfDUPuzMLZfb96Mu5Ns6
         8pUtW4CCaKaAaiqFkMSbAvk6PBaslz3YPA154xKEcasxdORF5xwLXXVtNxl9qV8I2uKQ
         gdrw==
X-Forwarded-Encrypted: i=1; AJvYcCUQHngj7Fe+mOS7LL8jow3gYsz3zqgiimXDcLVJQwdh7r5SF63VfBjRjf22jwsYp4bL52V2cpC15hKkEBgN@vger.kernel.org, AJvYcCWE0XhmeTaLMJioC4XLbY35eQv9sNNVwjRFy+3biVwC9OT3mpVjqk0UQvbVD8128zEQw/E=@vger.kernel.org, AJvYcCXzuusa2p4lWanYGRem+5v0cJOsWc5UaxVQ8JxXfuvMqT8xeMnMzL/lmcTf/x2nW9UjAodwBAJkTtDurVo07mUMGvHe@vger.kernel.org
X-Gm-Message-State: AOJu0YwJQ5JhoxblNDdrpGZ1H/aSnOlxISpVgQESHwMiDwdjq5eYSzUR
	VpsnA0MXkqhnvf8MlYHzFoNIa6Zoxxy4btOm7NeY27OluNfFx3kMuC12
X-Gm-Gg: ASbGncsFdnhKqDJxhCmn+t0TVTOBvwvnIL65vmBccdWkC3QXS2dTfliGSKyfvxohvsr
	3YOSRgQJa47Cj/opDmgMJiwSMbfvCHITynNlmLVL1W5QA8hOEwkeX69nTtKX0/iv+R3vfATtb9V
	M9Mf9fNgV5uo57Tfg6K45kkxCGAqEiloZubFeO7SAdEOMPMDiBFz28D/w/KUBTFJk6+LEi+N/lr
	om9EV8uKjnLSE0IRe3u9G2kcKun/4Q1WnahkBwMz3whVynObCiI0ltCJKZfdw/vp4S08gVsywZL
	TTA64QjN9676GWPw7iPjFsuuQMC86HVquXmjiXJNgSazRRaJ4Mzby4043KezYS7vhzs6KGDcc2x
	rpTaUExoEft4=
X-Google-Smtp-Source: AGHT+IGXl/QxdYQv+E32uj2HADurAuKBG3IRZKyIzyk6ED5cmYez/6lQZIkLkkOKPemVqFpwMRKLYw==
X-Received: by 2002:a17:906:f596:b0:b04:65b4:707 with SMTP id a640c23a62f3a-b0465b40b24mr169370466b.13.1756881356006;
        Tue, 02 Sep 2025 23:35:56 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b04190700a4sm838121166b.63.2025.09.02.23.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 23:35:55 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 3 Sep 2025 08:35:53 +0200
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH perf/core 01/11] uprobes: Add unique flag to uprobe
 consumer
Message-ID: <aLfhyancfP5Na4AN@krava>
References: <20250902143504.1224726-1-jolsa@kernel.org>
 <20250902143504.1224726-2-jolsa@kernel.org>
 <20250903001133.8a02cf5db5ab4fd23c9a334f@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903001133.8a02cf5db5ab4fd23c9a334f@kernel.org>

On Wed, Sep 03, 2025 at 12:11:33AM +0900, Masami Hiramatsu wrote:
> On Tue,  2 Sep 2025 16:34:54 +0200
> Jiri Olsa <jolsa@kernel.org> wrote:
> 
> > Adding unique flag to uprobe consumer to ensure it's the only consumer
> > attached on the uprobe.
> > 
> > This is helpful for use cases when consumer wants to change user space
> > registers, which might confuse other consumers. With this change we can
> > ensure there's only one consumer on specific uprobe.
> 
> nit: Does this mean one callback (consumer) is exclusively attached?
> If so, "exclusive" will be better wording?

yes, exclusive is better, will change

thanks,
jirka

> 
> The logic looks good to me.
> 
> Thanks,
> 
> > 
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  include/linux/uprobes.h |  1 +
> >  kernel/events/uprobes.c | 30 ++++++++++++++++++++++++++++--
> >  2 files changed, 29 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> > index 08ef78439d0d..0df849dee720 100644
> > --- a/include/linux/uprobes.h
> > +++ b/include/linux/uprobes.h
> > @@ -60,6 +60,7 @@ struct uprobe_consumer {
> >  	struct list_head cons_node;
> >  
> >  	__u64 id;	/* set when uprobe_consumer is registered */
> > +	bool is_unique; /* the only consumer on uprobe */
> >  };
> >  
> >  #ifdef CONFIG_UPROBES
> > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > index 996a81080d56..b9b088f7333a 100644
> > --- a/kernel/events/uprobes.c
> > +++ b/kernel/events/uprobes.c
> > @@ -1024,14 +1024,35 @@ static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset,
> >  	return uprobe;
> >  }
> >  
> > -static void consumer_add(struct uprobe *uprobe, struct uprobe_consumer *uc)
> > +static bool consumer_can_add(struct list_head *head, struct uprobe_consumer *uc)
> > +{
> > +	/* Uprobe has no consumer, we can add any. */
> > +	if (list_empty(head))
> > +		return true;
> > +	/* Uprobe has consumer/s, we can't add unique one. */
> > +	if (uc->is_unique)
> > +		return false;
> > +	/*
> > +	 * Uprobe has consumer/s, we can add nother consumer only if the
> > +	 * current consumer is not unique.
> > +	 **/
> > +	return !list_first_entry(head, struct uprobe_consumer, cons_node)->is_unique;
> > +}
> > +
> > +static int consumer_add(struct uprobe *uprobe, struct uprobe_consumer *uc)
> >  {
> >  	static atomic64_t id;
> > +	int ret = -EBUSY;
> >  
> >  	down_write(&uprobe->consumer_rwsem);
> > +	if (!consumer_can_add(&uprobe->consumers, uc))
> > +		goto unlock;
> >  	list_add_rcu(&uc->cons_node, &uprobe->consumers);
> >  	uc->id = (__u64) atomic64_inc_return(&id);
> > +	ret = 0;
> > +unlock:
> >  	up_write(&uprobe->consumer_rwsem);
> > +	return ret;
> >  }
> >  
> >  /*
> > @@ -1420,7 +1441,12 @@ struct uprobe *uprobe_register(struct inode *inode,
> >  		return uprobe;
> >  
> >  	down_write(&uprobe->register_rwsem);
> > -	consumer_add(uprobe, uc);
> > +	ret = consumer_add(uprobe, uc);
> > +	if (ret) {
> > +		put_uprobe(uprobe);
> > +		up_write(&uprobe->register_rwsem);
> > +		return ERR_PTR(ret);
> > +	}
> >  	ret = register_for_each_vma(uprobe, uc);
> >  	up_write(&uprobe->register_rwsem);
> >  
> > -- 
> > 2.51.0
> > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

