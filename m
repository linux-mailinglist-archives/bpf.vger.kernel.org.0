Return-Path: <bpf+bounces-33151-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6174C917F9A
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 13:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDA5D1F26E2E
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 11:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17218148FE3;
	Wed, 26 Jun 2024 11:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ay8bDe+c"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A8479CE;
	Wed, 26 Jun 2024 11:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719401228; cv=none; b=AZLREdc0Zijc8R3pB2uinUOdVrQkk+y/3hLsR6ueckEiC+0IP/sCTKUF7UF9S1xwV6CvsE3hzUe+XBH8Szje4v2s8wbnwiPi71ygtvcELS6ghiVrgwoE0UOwF+Gs1BAR0Mf6qc9cgOXm1onnZDR9EoES39+cJy9tfQzN0wuyYkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719401228; c=relaxed/simple;
	bh=KwdgGKKP+0hBaa8xY11hyl9LdTWxcBsHIXLIb1rjsoI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tm5/WMjXA+B8YbOo5YuRRAq78vtBjjIIhTPGpH/UEwXmIm4w2vRn7S6TDgVfuopP0CBMDaXfq/mEeGHCoUDgnmbEUIKXcP+bWtUFWD/FpdCGj0eXu++BGmnQNXu9pa1smzJmHYBkOROSevYDgpqrgnClpCAaA0kfhqWP8IZLt0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ay8bDe+c; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a72420e84feso546659166b.0;
        Wed, 26 Jun 2024 04:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719401225; x=1720006025; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=32147Wd81QPPxA7RUo5Ydca3GRbb3yWdnXAnVTXWZxk=;
        b=ay8bDe+cTWvTh9b0uGvEaYaZ1RyhwRdYepjZ9PZ/2JrKAop+JZaMgygUmI5tDxJN/3
         2mhm9hzxh5CltnZA0R2TZDXmhqQ+fM5G1oPvkOd+ugrzUBD2GPM3IvCUsPnTtA1wSIyg
         FhMM2wP3L6ksXtNhWqwlInaTtc+YD4FhS03G1o9qOdL6NG2ncN9sOeoftcJhoghyri8D
         WHCMCQd9kgne+uGUzbVmIdDb6szUzuCAv9L+rSfUP7lzS+ny7zruyAHn9Ih/Q9D8uFes
         z3UEKf3RwrQHd6OhV/MWLQxJZRvVjtkOwigTlZZEd3+bWqtEMNeTUDM+CiprFklvDAcC
         qEHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719401225; x=1720006025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=32147Wd81QPPxA7RUo5Ydca3GRbb3yWdnXAnVTXWZxk=;
        b=gITKEqCBI6zY283ae9trqTpAAnjLfzNZUEZJ4CXhz+SwYhNF21s+MPx+/5MMv+BI9f
         a1ZQ2nZnqbcMC6/sqH787tR5pf86aIQlgVvqr82wRqL7f2C43C2L1xsKMQRunInzZJaG
         TA/dm7tVkaRojfF921kHmn5u0tCX559FfQup8yYyS37Gj+uYAYP/5JRTbJvIx4H9lqoS
         Aoo6ke+eqh8Ci5wU4PaEzJOeTlNQiorQDlQlrRv/RVxYuhdc6sQysyGscTwK8QZs/KqU
         2GgH8zYy++ccwvnJGLURh0j91uCH9Z5BxNr8mySs+sh8FbNmU8rf0vJo6NVAhIZDzJ35
         tOVA==
X-Forwarded-Encrypted: i=1; AJvYcCX+a4/XLBK472fUw35TNQZVqWTV2ARlkIWYqdi+TX1F2S4srkpZ70LBCEWKWv0aWiC+i3jxG0QGhQtOfSlv/2fl0jiA
X-Gm-Message-State: AOJu0YxXdGfrt7XtnHBtNzS65YJT27MXBAN7qV0YUc1HtrC/LZLdnYkJ
	547YqhdORkIR35OvTUdjaK7fFSdDU89n2+EmZSyxNlLNBOmMpnwR
X-Google-Smtp-Source: AGHT+IHwlIkPhILSjJKKwguFh9k1/TDmOniodDZirdZYVLLT/e/KxnDBdFe8XzuQqqxeoUeiX68QHQ==
X-Received: by 2002:a17:906:5849:b0:a6f:4d6b:c77a with SMTP id a640c23a62f3a-a7245b8515dmr876605566b.13.1719401225106;
        Wed, 26 Jun 2024 04:27:05 -0700 (PDT)
Received: from krava (net-93-147-243-244.cust.vodafonedsl.it. [93.147.243.244])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fe077369dsm495740566b.68.2024.06.26.04.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 04:27:04 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 26 Jun 2024 13:27:01 +0200
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org, oleg@redhat.com, peterz@infradead.org,
	mingo@redhat.com, bpf@vger.kernel.org, paulmck@kernel.org,
	clm@meta.com
Subject: Re: [PATCH 06/12] uprobes: add batch uprobe register/unregister APIs
Message-ID: <Znv7BZGwdEunAETt@krava>
References: <20240625002144.3485799-1-andrii@kernel.org>
 <20240625002144.3485799-7-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625002144.3485799-7-andrii@kernel.org>

On Mon, Jun 24, 2024 at 05:21:38PM -0700, Andrii Nakryiko wrote:

SNIP

> +	for (i = 0; i < cnt; i++) {
> +		uc = get_uprobe_consumer(i, ctx);
> +
> +		/* Each consumer must have at least one set consumer */
> +		if (!uc || (!uc->handler && !uc->ret_handler))
> +			return -EINVAL;
> +		/* Racy, just to catch the obvious mistakes */
> +		if (uc->offset > i_size_read(inode))
> +			return -EINVAL;
> +		if (uc->uprobe)
> +			return -EINVAL;
> +		/*
> +		 * This ensures that copy_from_page(), copy_to_page() and
> +		 * __update_ref_ctr() can't cross page boundary.
> +		 */
> +		if (!IS_ALIGNED(uc->offset, UPROBE_SWBP_INSN_SIZE))
> +			return -EINVAL;
> +		if (!IS_ALIGNED(uc->ref_ctr_offset, sizeof(short)))
> +			return -EINVAL;
> +	}
>  
> -	down_write(&uprobe->register_rwsem);
> -	consumer_add(uprobe, uc);
> -	ret = register_for_each_vma(uprobe, uc);
> -	if (ret)
> -		__uprobe_unregister(uprobe, uc);
> -	up_write(&uprobe->register_rwsem);
> +	for (i = 0; i < cnt; i++) {
> +		uc = get_uprobe_consumer(i, ctx);
>  
> -	if (ret)
> -		put_uprobe(uprobe);
> +		uprobe = alloc_uprobe(inode, uc->offset, uc->ref_ctr_offset);
> +		if (IS_ERR(uprobe)) {
> +			ret = PTR_ERR(uprobe);
> +			goto cleanup_uprobes;
> +		}
> +
> +		uc->uprobe = uprobe;
> +	}
> +
> +	for (i = 0; i < cnt; i++) {
> +		uc = get_uprobe_consumer(i, ctx);
> +		uprobe = uc->uprobe;
> +
> +		down_write(&uprobe->register_rwsem);
> +		consumer_add(uprobe, uc);
> +		ret = register_for_each_vma(uprobe, uc);
> +		if (ret)
> +			__uprobe_unregister(uprobe, uc);
> +		up_write(&uprobe->register_rwsem);
> +
> +		if (ret) {
> +			put_uprobe(uprobe);
> +			goto cleanup_unreg;
> +		}
> +	}
> +
> +	return 0;
>  
> +cleanup_unreg:
> +	/* unregister all uprobes we managed to register until failure */
> +	for (i--; i >= 0; i--) {
> +		uc = get_uprobe_consumer(i, ctx);
> +
> +		down_write(&uprobe->register_rwsem);
> +		__uprobe_unregister(uc->uprobe, uc);
> +		up_write(&uprobe->register_rwsem);
> +	}
> +cleanup_uprobes:

when we jump here from 'goto cleanup_uprobes' not all of the
consumers might have uc->uprobe set up

perhaps we can set cnt = i - 1 before the goto, or just check uc->uprobe below


> +	/* put all the successfully allocated/reused uprobes */
> +	for (i = cnt - 1; i >= 0; i--) {

curious, any reason why we go from the top here?

thanks,
jirka

> +		uc = get_uprobe_consumer(i, ctx);
> +
> +		put_uprobe(uc->uprobe);
> +		uc->uprobe = NULL;
> +	}
>  	return ret;
>  }
>  
>  int uprobe_register(struct inode *inode, struct uprobe_consumer *uc)
>  {
> -	return __uprobe_register(inode, uc->offset, uc->ref_ctr_offset, uc);
> +	return uprobe_register_batch(inode, 1, uprobe_consumer_identity, uc);
>  }
>  EXPORT_SYMBOL_GPL(uprobe_register);
>  
> -- 
> 2.43.0
> 

