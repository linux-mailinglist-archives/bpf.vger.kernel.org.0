Return-Path: <bpf+bounces-36228-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABA9944DF8
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 16:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E9711F24FA0
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 14:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685381A4F16;
	Thu,  1 Aug 2024 14:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0SYYWVp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D8F16DECD;
	Thu,  1 Aug 2024 14:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722522449; cv=none; b=IMg1JtWy/VBtdUP4CTIRU9MOC2BFCaWfoViyuoReu4Jp9wtf2+S6DxAB4/WVUBfV6c7Gytm6Gy8gZUiRa+wt36OucU3yBRTQiSIWZBFkut8B/fqct39e9ybI0+Nk8uneutarBu5d8lnJGq2wCbo+3pyj1JN8uOk4W+5LKoYn/fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722522449; c=relaxed/simple;
	bh=1eCtyjCb2ulZJKrZXpSy4GAaQXl3s174LMRrlhPrCvA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SvYfGXIxXl+fXW0zy2Y7Q795HDlWkXizWvMW+YqxSbsKolCRZ65PJurzQWMA4257TKe3mbcyeSry/xLljE3exqWonbimdTa6VAu7TncFbL7ulS0EFYs+2qH3kCI50GEPAXUV4zydFxoBw+szjqAK7GXWv+o1CTCHg1QG8J/JhY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0SYYWVp; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3684e8220f9so1210487f8f.1;
        Thu, 01 Aug 2024 07:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722522446; x=1723127246; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mfKbjBr7r6HcdKc0OHBJ+FJnRWwVUcGXiKdD6HFJQMc=;
        b=l0SYYWVpXU7Q3w5GROE4czLMuBG0qRCrNfMmHK6ipc5207lo8I4pgBoucwL7oXbfUn
         VP/SH388RniSngjSDJ1shH+yNv2uLvt37KX27X1SM1AL7UFJhzjI6D5078JYmR05gbmj
         znEWpzHB4Tb03V0E3L/5SytbZVUT3NCAemMKLn4STgIHG42RDVhxfNrls7udFayVH9gR
         WO08VGfsuWjCLKfjLHaEhBG85zcFALkbR6acwj5dodJQqLDwCXG2SQRYfhbAgXcL5II3
         tdCIj2pmII7PkQVQWi4yco2+5ZGnJEUlIpZxXEOkuxt623NUAj8BjAsEoY3GrPdxIbaI
         MuoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722522446; x=1723127246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mfKbjBr7r6HcdKc0OHBJ+FJnRWwVUcGXiKdD6HFJQMc=;
        b=Hh0XRiZjXOQpzpOh0YpPE/KRdHeq9bg0OUtXv5F9MUH6U88P43DPfhBD4aPov/76Aq
         WLQW+o622fKVX5uoZe0uk59l6h5zH2XU+YcWpNJ4Vj37AtuGNw+5KhYlF2lP3ab+skXZ
         S/nAAyOKcMVVPevuZgz9k72+4XjQ952Ob8Bz6Hf0HXtgak6dTygunU16c7Q8NsriOVL0
         E4r3vtfIQZdMObdN4pak3EM3UHqY23hPIspC0QptRXzDq3cj6AbDffUZT+E4VbOP2EwN
         hLZ8Gd8e/bpSwWSJVI1iO05lcGFoo/TrVkSmY7b/BErSFxAs5Xq9eqWy8ykYBO/oGmdr
         c1vg==
X-Forwarded-Encrypted: i=1; AJvYcCXwaY5ZHo+JrK19RVugfQC9zt8EAb4xFOxTVGf0kDFgMggJfks7rREHixh6qgo2094QOWEiHuKP3i90AqXeZtOH8ix0H9ZXtolYr0U6mmFe8Z8o2Zg2w16f0WzO8NJ6mntn
X-Gm-Message-State: AOJu0Yx0V8ZwxRZe3pMnUSXX90RGRFPFE1BFdMPUwSMcKUKZt94miZeA
	2P2KfcrycTBldOYTsN9+VjjS04sWLUA8EUwHA7fAOLUXfPoeEUOk
X-Google-Smtp-Source: AGHT+IFwthUZ5sW7c80c6OwV/xPl71OKvvZGW+mhzAMZR8/ZmM4lkVp1D/y4saHnLynHpvKPRHtIEA==
X-Received: by 2002:adf:b102:0:b0:368:318a:a191 with SMTP id ffacd0b85a97d-36bb359d0ddmr1413042f8f.8.1722522445264;
        Thu, 01 Aug 2024 07:27:25 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367d966csm19610878f8f.38.2024.08.01.07.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 07:27:24 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 1 Aug 2024 16:27:17 +0200
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, peterz@infradead.org,
	oleg@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	paulmck@kernel.org
Subject: Re: [PATCH 5/8] uprobes: travers uprobe's consumer list locklessly
 under SRCU protection
Message-ID: <ZqubRQ3TRsZbV9fo@krava>
References: <20240731214256.3588718-1-andrii@kernel.org>
 <20240731214256.3588718-6-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731214256.3588718-6-andrii@kernel.org>

On Wed, Jul 31, 2024 at 02:42:53PM -0700, Andrii Nakryiko wrote:

SNIP

>  static int __copy_insn(struct address_space *mapping, struct file *filp,
>  			void *insn, int nbytes, loff_t offset)
>  {
> @@ -924,7 +901,8 @@ static bool filter_chain(struct uprobe *uprobe, struct mm_struct *mm)
>  	bool ret = false;
>  
>  	down_read(&uprobe->consumer_rwsem);
> -	for (uc = uprobe->consumers; uc; uc = uc->next) {
> +	list_for_each_entry_srcu(uc, &uprobe->consumers, cons_node,
> +				 srcu_read_lock_held(&uprobes_srcu)) {
>  		ret = consumer_filter(uc, mm);
>  		if (ret)
>  			break;
> @@ -1120,17 +1098,19 @@ void uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
>  	int err;
>  
>  	down_write(&uprobe->register_rwsem);
> -	if (WARN_ON(!consumer_del(uprobe, uc))) {
> -		err = -ENOENT;
> -	} else {
> -		err = register_for_each_vma(uprobe, NULL);
> -		/* TODO : cant unregister? schedule a worker thread */
> -		WARN(err, "leaking uprobe due to failed unregistration");
> -	}
> +
> +	list_del_rcu(&uc->cons_node);

hum, so previous code had a check to verify that consumer is actually
registered in the uprobe, so it'd survive wrong argument while the new
code could likely do things?

> +	err = register_for_each_vma(uprobe, NULL);
> +
>  	up_write(&uprobe->register_rwsem);
>  
> -	if (!err)
> -		put_uprobe(uprobe);
> +	/* TODO : cant unregister? schedule a worker thread */
> +	if (WARN(err, "leaking uprobe due to failed unregistration"))
> +		return;
> +
> +	put_uprobe(uprobe);
> +
> +	synchronize_srcu(&uprobes_srcu);

could you comment on why it's needed in here? there's already potential
call_srcu(&uprobes_srcu, ... ) call in put_uprobe above

thanks,
jirka

