Return-Path: <bpf+bounces-37865-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A59E95B843
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 16:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BF5E1F25AF4
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 14:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979B81CBE89;
	Thu, 22 Aug 2024 14:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNx+qxRI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D2116D4EF;
	Thu, 22 Aug 2024 14:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724336577; cv=none; b=bnCMBgpUkKHowpzCa3cyOpVWFQ1vihmaaX+ZnXvH09WpfQ9VVA76xzACSnotwKyVyP/cpJ4a8bjamFztfnsoduKLGLxWM/DFeAQhlfyd96bGoeqWYOXxGAQEZA6OM6ix1w4L4e6TBbq3clyg1xZl34p9N7TUEuWe0CD599VWcto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724336577; c=relaxed/simple;
	bh=RlK/WiCI7cC2xBe2HeIm5qnzRjy7kA6HBtTcgIK5hiE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YOzXxZqWCISFI50MXPqjVbiS7EwCeCRoSujXXB0oE5NYRd9HB2s4x3QA/dSriCLSIsjpj69lZSB7DNXssKAWbQFY4sY+1XEiv38HYHcjJJa1Zj7y8uOx78tP0LDx7gw43cVoTiqG0BvWhszFykbN/HjryLzSh3YLro1ips1bxOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LNx+qxRI; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a83597ce5beso137804166b.1;
        Thu, 22 Aug 2024 07:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724336574; x=1724941374; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hvFk4KiFQ4jknRyXdpWSIplvO8xMF83nYSG+PUhv9V4=;
        b=LNx+qxRIpVQu+v/CbhCPwcm2X65l2HxnL1m3ndmNqiSYxKgYSWUYD6l8PFg2U9CyYP
         Kq5jd9zILNBLt52Wd8vtadLLahsN7VuDnplcs/+J+ane1YdJ7fnmzngjhpWaDATnEjOb
         +EQ+bZJ2A6uUFA/z6u4FeaWztWMay8/mUwyI2lYk3UJ9A17VhAhs4kDohMUbt8DkpMi5
         I3L9Q9QMWMxneeN98ezIqO/si1vOOfxrlHS10kss2OMBnaMeEZmslwTASq1qvum29jUw
         3LGmcc2m6WqUfqTgNhNLs0syWnY+g1oLqYNrP9IjysnNEZyre//1HoCG1C1MGCEM3KdJ
         iRTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724336574; x=1724941374;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hvFk4KiFQ4jknRyXdpWSIplvO8xMF83nYSG+PUhv9V4=;
        b=NjjT4paiB2euLEqNcHld1P8tHIcgrLIdY0ZIbgtFu5H+605CfIr8hdATjb5X1pLOpT
         I7azPXf6mRZ086eOp3ETbKj915JJxgT63K+Ed+mOoU83n2/5hHhaJCe3uuiG7gP4N2FJ
         1iyCqAxx4o1TNSfXiP4mr3SPwNyFrBuOiBcBEMdc5nAyve6CxqJRFGdu/PQplpktnxht
         pZyExkcVoUW8vGICola9Ov78ej7Kc/VPbioToN1BGJG4EKUqxNJmE3//QNo0sGU3KbpA
         Nz9vNP2JxGf3vKmBrT7wn9MJpw/lhw+pEpUBCfe8XyCAzxITHsElsMHYr02CRCa1Xqcf
         2H2g==
X-Forwarded-Encrypted: i=1; AJvYcCVeoD8q+Hu9QblP0eUIHmx0+NRwfVlFMZ5ERClvF/OIa/95etBkgy14x/SX9N0k6c46U+U=@vger.kernel.org, AJvYcCWmPVM36uop2M1SZK6n+ZaJSmofLOtEfUQu4JSjmHNUlHf2UnzPQ/3l/c/9xb/xiMZrV6vTFnVOxutUdWjn@vger.kernel.org
X-Gm-Message-State: AOJu0YxGQSf+1oUK2vOgt3yps0w7+HCYhwY/1gs5HtBCD7sQGZ5EEmeN
	McHruC7FWJyTWgiAgrE1eGFXO6L9CDF5Rks2QcXeiT8mVgYCOhqg
X-Google-Smtp-Source: AGHT+IF0hmAt6tkNqeAkfXeiDKDltNUNbNaOv2hcoNDEkEIxY1sF68Dk0oiuClfQ1GBKVbEcaxalUA==
X-Received: by 2002:a17:906:6a0e:b0:a80:f646:c9c4 with SMTP id a640c23a62f3a-a868a5aaf28mr301279766b.1.1724336573366;
        Thu, 22 Aug 2024 07:22:53 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f48621esm127706966b.176.2024.08.22.07.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 07:22:52 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 22 Aug 2024 16:22:51 +0200
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, peterz@infradead.org,
	oleg@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	paulmck@kernel.org, willy@infradead.org, surenb@google.com,
	akpm@linux-foundation.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 04/13] uprobes: travers uprobe's consumer list
 locklessly under SRCU protection
Message-ID: <ZsdJuwIuJ-KFA6Rz@krava>
References: <20240813042917.506057-1-andrii@kernel.org>
 <20240813042917.506057-5-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813042917.506057-5-andrii@kernel.org>

On Mon, Aug 12, 2024 at 09:29:08PM -0700, Andrii Nakryiko wrote:

SNIP

> @@ -1125,18 +1103,31 @@ void uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
>  	int err;
>  
>  	down_write(&uprobe->register_rwsem);
> -	if (WARN_ON(!consumer_del(uprobe, uc))) {
> -		err = -ENOENT;
> -	} else {
> -		err = register_for_each_vma(uprobe, NULL);
> -		/* TODO : cant unregister? schedule a worker thread */
> -		if (unlikely(err))
> -			uprobe_warn(current, "unregister, leaking uprobe");
> -	}
> +
> +	list_del_rcu(&uc->cons_node);

hi,
I'm using this patchset as base for my changes and stumbled on this today,
I'm probably missing something, but should we keep the 'uprobe->consumer_rwsem'
lock around the list_del_rcu?

jirka


> +	err = register_for_each_vma(uprobe, NULL);
> +
>  	up_write(&uprobe->register_rwsem);
>  
> -	if (!err)
> -		put_uprobe(uprobe);
> +	/* TODO : cant unregister? schedule a worker thread */
> +	if (unlikely(err)) {
> +		uprobe_warn(current, "unregister, leaking uprobe");
> +		goto out_sync;
> +	}
> +
> +	put_uprobe(uprobe);
> +
> +out_sync:
> +	/*
> +	 * Now that handler_chain() and handle_uretprobe_chain() iterate over
> +	 * uprobe->consumers list under RCU protection without holding
> +	 * uprobe->register_rwsem, we need to wait for RCU grace period to
> +	 * make sure that we can't call into just unregistered
> +	 * uprobe_consumer's callbacks anymore. If we don't do that, fast and
> +	 * unlucky enough caller can free consumer's memory and cause
> +	 * handler_chain() or handle_uretprobe_chain() to do an use-after-free.
> +	 */
> +	synchronize_srcu(&uprobes_srcu);
>  }
>  EXPORT_SYMBOL_GPL(uprobe_unregister);
>  
> @@ -1214,13 +1205,20 @@ EXPORT_SYMBOL_GPL(uprobe_register);
>  int uprobe_apply(struct uprobe *uprobe, struct uprobe_consumer *uc, bool add)
>  {
>  	struct uprobe_consumer *con;
> -	int ret = -ENOENT;
> +	int ret = -ENOENT, srcu_idx;
>  
>  	down_write(&uprobe->register_rwsem);
> -	for (con = uprobe->consumers; con && con != uc ; con = con->next)
> -		;
> -	if (con)
> -		ret = register_for_each_vma(uprobe, add ? uc : NULL);
> +
> +	srcu_idx = srcu_read_lock(&uprobes_srcu);
> +	list_for_each_entry_srcu(con, &uprobe->consumers, cons_node,
> +				 srcu_read_lock_held(&uprobes_srcu)) {
> +		if (con == uc) {
> +			ret = register_for_each_vma(uprobe, add ? uc : NULL);
> +			break;
> +		}
> +	}
> +	srcu_read_unlock(&uprobes_srcu, srcu_idx);
> +
>  	up_write(&uprobe->register_rwsem);
>  
>  	return ret;
> @@ -2085,10 +2083,12 @@ static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
>  	struct uprobe_consumer *uc;
>  	int remove = UPROBE_HANDLER_REMOVE;
>  	bool need_prep = false; /* prepare return uprobe, when needed */
> +	bool has_consumers = false;
>  
> -	down_read(&uprobe->register_rwsem);
>  	current->utask->auprobe = &uprobe->arch;
> -	for (uc = uprobe->consumers; uc; uc = uc->next) {
> +
> +	list_for_each_entry_srcu(uc, &uprobe->consumers, cons_node,
> +				 srcu_read_lock_held(&uprobes_srcu)) {
>  		int rc = 0;
>  
>  		if (uc->handler) {
> @@ -2101,17 +2101,24 @@ static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
>  			need_prep = true;
>  
>  		remove &= rc;
> +		has_consumers = true;
>  	}
>  	current->utask->auprobe = NULL;
>  
>  	if (need_prep && !remove)
>  		prepare_uretprobe(uprobe, regs); /* put bp at return */
>  
> -	if (remove && uprobe->consumers) {
> -		WARN_ON(!uprobe_is_active(uprobe));
> -		unapply_uprobe(uprobe, current->mm);
> +	if (remove && has_consumers) {
> +		down_read(&uprobe->register_rwsem);
> +
> +		/* re-check that removal is still required, this time under lock */
> +		if (!filter_chain(uprobe, current->mm)) {
> +			WARN_ON(!uprobe_is_active(uprobe));
> +			unapply_uprobe(uprobe, current->mm);
> +		}
> +
> +		up_read(&uprobe->register_rwsem);
>  	}
> -	up_read(&uprobe->register_rwsem);
>  }
>  
>  static void
> @@ -2119,13 +2126,15 @@ handle_uretprobe_chain(struct return_instance *ri, struct pt_regs *regs)
>  {
>  	struct uprobe *uprobe = ri->uprobe;
>  	struct uprobe_consumer *uc;
> +	int srcu_idx;
>  
> -	down_read(&uprobe->register_rwsem);
> -	for (uc = uprobe->consumers; uc; uc = uc->next) {
> +	srcu_idx = srcu_read_lock(&uprobes_srcu);
> +	list_for_each_entry_srcu(uc, &uprobe->consumers, cons_node,
> +				 srcu_read_lock_held(&uprobes_srcu)) {
>  		if (uc->ret_handler)
>  			uc->ret_handler(uc, ri->func, regs);
>  	}
> -	up_read(&uprobe->register_rwsem);
> +	srcu_read_unlock(&uprobes_srcu, srcu_idx);
>  }
>  
>  static struct return_instance *find_next_ret_chain(struct return_instance *ri)
> -- 
> 2.43.5
> 

