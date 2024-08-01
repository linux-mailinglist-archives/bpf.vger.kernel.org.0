Return-Path: <bpf+bounces-36222-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98798944A1D
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 13:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FCA82812E2
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 11:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466F4188007;
	Thu,  1 Aug 2024 11:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gtrawONR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC8D3E47B;
	Thu,  1 Aug 2024 11:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722510593; cv=none; b=mAE57Ae3+YRlSjUihwupiG5+3cZk7qSEcR4JTkbJJJ4d8BxFyBbFqtGb/J8rfAsbUXwQbvdmUox64Htp2AV59jaCb7PdAvI/dDo8x+nDDbZwZf7n1aFiEZuZwP42eyo09T48S/s2ydYMiT0WO27JxZKo6NoTvPYC3+X/NH7TK30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722510593; c=relaxed/simple;
	bh=Tkr+0LmplctIJG2HNiQFbL7y9ESXyYg5tdT1gX4Kgu0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EmgV6EbBz+trENNO8AFZvGodmK/O0Dygp4kmu0MuwLbFY+ksrPuBKIFciWPztZNB1GDNCNA1JW77si2cR4A2lA89OyDcWEsKTQ1RPB5dhYNQod8H/YlU52ZS5/8t10xkODCGVhOL8c0oce30X9V+vr73xZ9COnbshapGpdbaLVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gtrawONR; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f01e9f53e3so98686671fa.1;
        Thu, 01 Aug 2024 04:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722510590; x=1723115390; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gpHH7T9uobv6qNWmesdtQRhL0VPExa+eo/fetJnH16U=;
        b=gtrawONRxKSlayukjcA+wusHd5YdU/nUR1E4Hax/jokK5KMqEpBOK7w7YlMAaOadV4
         EIhTIkha1MFg2NS049ceZ+AzjPSD15KIkxFlacrRzo3yjRlLYHvV6BCf/FKNWPtsGt6o
         xJC4ggaM+rqypllLFfrZUdTsBb1L0OPuUhvbMeA/pOA8jMxKw96ifGMsVsVuymqqnz6K
         pWmloU4V+MasDjowHQwvpzdUi/B7we8kuK+zVsXzlCdB4yTuFVOlb+YYXd1+4jrRnexK
         lcgIG/mFo3P/+/2x8qIi6y12ns4x3/jPUXbXtfqp5WZE8OM8JaIuFwpzc1D70PyCii2z
         sMKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722510590; x=1723115390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gpHH7T9uobv6qNWmesdtQRhL0VPExa+eo/fetJnH16U=;
        b=rNOhRPvwHfw+WuUZGiu9cg+mj/fveImrca/zK/Er8BJTk3kyfD2fZhvoKJ6ei+pHg9
         BfJiQ0jg6rspjDbIyQvMjsf2TYMGCNzIUj8uvHWGRF6PRRDxXxUyScxQLT3W/nP6siwQ
         pZTQw8p/+dY3/GVgpGdcSE6UUEobAFIw+rhpHF1MVX34otB7wPC3gmy7cN7C/ZWWIlJ0
         TMVc3f1Zpyvpt+NxMil98cXDher/Vf5mHebrLS8V1WvtMIkLTGKW2R+RV1DwDW+gvuxr
         Y9D/eZO1J3jL/rbd+rZ6NY1Whg/hhCg+EjCgyvm/TWfooclP8O9OdS4i4fRLAFQ3vq1A
         0Wog==
X-Forwarded-Encrypted: i=1; AJvYcCV9dGD3giChdLJ+38tbiP5j4RnrZvK6E0oeDk2aWZgMxhucYnczSgNrBdxA82UEZm5E0dT/Pj/ZZ3ywfmkNCjUipmupwx4Q2w8c4q2N3SgVrc8D6BwkC4sBtJz1GLkpi3xA
X-Gm-Message-State: AOJu0YzwMSb4tynB3wfNsSQl63/MrbNpBp71G4jOeKGqdtGofYdtQtLt
	t/r2EW5ngamz4HRZza+bdv0wGPyu+umqfREtUfLzMmmKH3bgXLu6HOOcIA==
X-Google-Smtp-Source: AGHT+IEbJLspOVEgNhoIgc0/tGa2JjWkX5qaksmn1Z2Lr6ZOJxyMU4ZqGUqmun+ul+jiwpAiQPGL+w==
X-Received: by 2002:a2e:9819:0:b0:2ef:1b1b:7f42 with SMTP id 38308e7fff4ca-2f153399871mr19318041fa.36.1722510589807;
        Thu, 01 Aug 2024 04:09:49 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad41b30sm880070066b.111.2024.08.01.04.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 04:09:49 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 1 Aug 2024 13:09:47 +0200
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, peterz@infradead.org,
	oleg@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	paulmck@kernel.org
Subject: Re: [PATCH 2/8] uprobes: revamp uprobe refcounting and lifetime
 management
Message-ID: <Zqts-5hac4_H-lrC@krava>
References: <20240731214256.3588718-1-andrii@kernel.org>
 <20240731214256.3588718-3-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731214256.3588718-3-andrii@kernel.org>

On Wed, Jul 31, 2024 at 02:42:50PM -0700, Andrii Nakryiko wrote:

SNIP

>  static void put_uprobe(struct uprobe *uprobe)
>  {
> -	if (refcount_dec_and_test(&uprobe->ref)) {
> -		/*
> -		 * If application munmap(exec_vma) before uprobe_unregister()
> -		 * gets called, we don't get a chance to remove uprobe from
> -		 * delayed_uprobe_list from remove_breakpoint(). Do it here.
> -		 */
> -		mutex_lock(&delayed_uprobe_lock);
> -		delayed_uprobe_remove(uprobe, NULL);
> -		mutex_unlock(&delayed_uprobe_lock);
> -		kfree(uprobe);
> -	}
> +	if (!refcount_dec_and_test(&uprobe->ref))
> +		return;
> +
> +	write_lock(&uprobes_treelock);
> +
> +	if (uprobe_is_active(uprobe))
> +		rb_erase(&uprobe->rb_node, &uprobes_tree);
> +
> +	write_unlock(&uprobes_treelock);
> +
> +	/*
> +	 * If application munmap(exec_vma) before uprobe_unregister()
> +	 * gets called, we don't get a chance to remove uprobe from
> +	 * delayed_uprobe_list from remove_breakpoint(). Do it here.
> +	 */
> +	mutex_lock(&delayed_uprobe_lock);
> +	delayed_uprobe_remove(uprobe, NULL);
> +	mutex_unlock(&delayed_uprobe_lock);

we should do kfree(uprobe) in here, right?

I think this is fixed later on when uprobe_free_rcu is introduced

SNIP

> @@ -1159,27 +1180,16 @@ struct uprobe *uprobe_register(struct inode *inode,
>  	if (!IS_ALIGNED(ref_ctr_offset, sizeof(short)))
>  		return ERR_PTR(-EINVAL);
>  
> - retry:
>  	uprobe = alloc_uprobe(inode, offset, ref_ctr_offset);
>  	if (IS_ERR(uprobe))
>  		return uprobe;
>  
> -	/*
> -	 * We can race with uprobe_unregister()->delete_uprobe().
> -	 * Check uprobe_is_active() and retry if it is false.
> -	 */
>  	down_write(&uprobe->register_rwsem);
> -	ret = -EAGAIN;
> -	if (likely(uprobe_is_active(uprobe))) {
> -		consumer_add(uprobe, uc);
> -		ret = register_for_each_vma(uprobe, uc);
> -	}
> +	consumer_add(uprobe, uc);
> +	ret = register_for_each_vma(uprobe, uc);
>  	up_write(&uprobe->register_rwsem);
> -	put_uprobe(uprobe);
>  
>  	if (ret) {
> -		if (unlikely(ret == -EAGAIN))
> -			goto retry;

nice, I like getting rid of this.. so far lgtm ;-)

jirka


>  		uprobe_unregister(uprobe, uc);
>  		return ERR_PTR(ret);
>  	}
> @@ -1286,15 +1296,19 @@ static void build_probe_list(struct inode *inode,
>  			u = rb_entry(t, struct uprobe, rb_node);
>  			if (u->inode != inode || u->offset < min)
>  				break;
> +			u = try_get_uprobe(u);
> +			if (!u) /* uprobe already went away, safe to ignore */
> +				continue;
>  			list_add(&u->pending_list, head);
> -			get_uprobe(u);
>  		}
>  		for (t = n; (t = rb_next(t)); ) {
>  			u = rb_entry(t, struct uprobe, rb_node);
>  			if (u->inode != inode || u->offset > max)
>  				break;
> +			u = try_get_uprobe(u);
> +			if (!u) /* uprobe already went away, safe to ignore */
> +				continue;
>  			list_add(&u->pending_list, head);
> -			get_uprobe(u);
>  		}
>  	}
>  	read_unlock(&uprobes_treelock);
> @@ -1752,6 +1766,12 @@ static int dup_utask(struct task_struct *t, struct uprobe_task *o_utask)
>  			return -ENOMEM;
>  
>  		*n = *o;
> +		/*
> +		 * uprobe's refcnt has to be positive at this point, kept by
> +		 * utask->return_instances items; return_instances can't be
> +		 * removed right now, as task is blocked due to duping; so
> +		 * get_uprobe() is safe to use here.
> +		 */
>  		get_uprobe(n->uprobe);
>  		n->next = NULL;
>  
> @@ -1894,7 +1914,10 @@ static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs)
>  		}
>  		orig_ret_vaddr = utask->return_instances->orig_ret_vaddr;
>  	}
> -
> +	 /*
> +	  * uprobe's refcnt is positive, held by caller, so it's safe to
> +	  * unconditionally bump it one more time here
> +	  */
>  	ri->uprobe = get_uprobe(uprobe);
>  	ri->func = instruction_pointer(regs);
>  	ri->stack = user_stack_pointer(regs);
> -- 
> 2.43.0
> 

