Return-Path: <bpf+bounces-36285-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA71945CF4
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 13:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48E45B21C42
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 11:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72E71DF66F;
	Fri,  2 Aug 2024 11:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlfwhoMB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A836F4AEF6;
	Fri,  2 Aug 2024 11:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722597117; cv=none; b=i9zgbYJuD2/05VJSV8ri607vh7q2Qrp5Zpx/CfJtNAe+jQF9SqFkni8gr8gmiksu9VZ2PIgt11SvjRDSBMkHBgpoCG4/3zRiwlwAlSbz7riv7C48F4QOtcEfxtJ0XLJf+EZ7Ka3tHJY+s8sxwU/G88jsCaXdbPh1fVQB4che2JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722597117; c=relaxed/simple;
	bh=7OsaR23lOaEYrCMGCV8el8IFQB59Lq1Nr2sgHFnnz8Y=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TvWA0l+9h5PehWNjSgXBlfNdmfbXYwlrA1y7T+tOeEq57w0PsfQt2QgfRP4y45hdgr2viv/rCOFgnMazKWcEXG2M8b22f/OyVrUntqDAIra9M9zAKXiKY96/GTgKRgH5gV8TRCmt7M3hTfG9g0lMOo60gcZClTxRbJf07D254Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GlfwhoMB; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-428e3129851so11851995e9.3;
        Fri, 02 Aug 2024 04:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722597114; x=1723201914; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=48NAXfZ/QmkjmYbHuWr6EIhjw/QrEopPm87Bjr9qTPU=;
        b=GlfwhoMBok4hkUCrdO/gBBCXtM4iUnY9Yi07+hFvpP2CEwGQhPk3npshxhEg2Z+4Rx
         v7i88IPutEyzGoDdWxYbwd4hYoIEUjPuQf/hKmSasw0/jNrixlkX3Ff54LdZJknz4RQ6
         x3FUZcJnftvPn+i6lsSJAdw+L8ctpv7S104iMH9sWG9nIQ4UjJawEObd3V0Tllg4Z1l+
         Gof94bw/JIcGQ5Eq1zqRhuxOwP6uyUovHPR0v1dfwCmlou+1t9cij8ARKzyMkBMYDw2h
         YtaRmB+OqcnYs7CbNTUsCLedqqaRukQVr1CPyA0gt7/jG0Lh9/s8Lm+b5BR/0l6BN/DT
         YO3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722597114; x=1723201914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=48NAXfZ/QmkjmYbHuWr6EIhjw/QrEopPm87Bjr9qTPU=;
        b=EYoH7oJ1qYWIgIezVduJrT+YM36wlb2LhSS4kZkjBJf1TC/pKL3ds7US8ayCdSK3cn
         QG8KXd5jM46k0o14Lc4FdlIV8WHEabofYjaRM7+IdAMuzNvcfY7i+arEjzey7u1oQJFj
         E1971NH045/1lmI2PxQEXB6NICQ3s+PTNfZ94R09aJauYM9HamlYV5Dzznu5Bx8maGaG
         4CWuQBk4mJDV/QcwdP3MpkTlH0WQWzMxPBOgzH5QfhH2HX2JU6aPImcx9jA55h8pMovG
         QzwrPu8yXuq/4F+/m1/0cIAaywoBDF3IdFJ/h3E323GXmUJ1YpMTdgk2YTezqnS5xJvU
         oSFw==
X-Forwarded-Encrypted: i=1; AJvYcCWG7BbxRaAqiCMhjMtmkuXSPg2K08gkybhHfJj4wtYRI+2LNqqGtzcBe7eGFCqYM4T79FV7VWFWQVkv1kQgzDyHwJWyEhK3f/hp7TzS8c0Xt+ob02AegtL4IsKEoHWMhNYb
X-Gm-Message-State: AOJu0YyHSQDNaY2XikPNjXiS1Wocl6wsQxgZbTraJB8Pu9O6OAxJygTy
	nZYQdBbAWom/tPL5BXCfd36MHyZXzGE0dM7s2NF144+6awgw4oNN
X-Google-Smtp-Source: AGHT+IFw0uSfbuINtregG6sW8kw8eLeV4U1LDXfEwSUiHejE119Ibt6/cQKJWzM7XcPEVFk6FShtAA==
X-Received: by 2002:a05:600c:4586:b0:428:1a48:d5cf with SMTP id 5b1f17b1804b1-428e6af83bamr19890755e9.9.1722597113524;
        Fri, 02 Aug 2024 04:11:53 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428240b2d65sm59731545e9.0.2024.08.02.04.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 04:11:53 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 2 Aug 2024 13:11:51 +0200
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, peterz@infradead.org,
	oleg@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	paulmck@kernel.org
Subject: Re: [PATCH 2/8] uprobes: revamp uprobe refcounting and lifetime
 management
Message-ID: <Zqy-94c1cAUKoWA4@krava>
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

> -/*
> - * There could be threads that have already hit the breakpoint. They
> - * will recheck the current insn and restart if find_uprobe() fails.
> - * See find_active_uprobe().
> - */
> -static void delete_uprobe(struct uprobe *uprobe)
> -{
> -	if (WARN_ON(!uprobe_is_active(uprobe)))
> -		return;
> -
> -	write_lock(&uprobes_treelock);
> -	rb_erase(&uprobe->rb_node, &uprobes_tree);
> -	write_unlock(&uprobes_treelock);
> -	RB_CLEAR_NODE(&uprobe->rb_node); /* for uprobe_is_active() */
> -}
> -
>  struct map_info {
>  	struct map_info *next;
>  	struct mm_struct *mm;
> @@ -1094,17 +1120,12 @@ void uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
>  	int err;
>  
>  	down_write(&uprobe->register_rwsem);
> -	if (WARN_ON(!consumer_del(uprobe, uc)))
> +	if (WARN_ON(!consumer_del(uprobe, uc))) {
>  		err = -ENOENT;
> -	else
> +	} else {
>  		err = register_for_each_vma(uprobe, NULL);
> -
> -	/* TODO : cant unregister? schedule a worker thread */
> -	if (!err) {
> -		if (!uprobe->consumers)
> -			delete_uprobe(uprobe);

ok, so removing this call is why the consumer test is failing, right?

IIUC the previous behaviour was to remove uprobe from the tree
even when there's active uprobe ref for installed uretprobe

so following scenario will now behaves differently:

  install uretprobe/consumer-1 on foo
  foo {
    remove uretprobe/consumer-1                (A)
    install uretprobe/consumer-2 on foo        (B)
  }

before the removal of consumer-1 (A) would remove the uprobe object
from the tree, so the installation of consumer-2 (b) would create
new uprobe object which would not be triggered at foo return because
it got installed too late (after foo uprobe was triggered)

the behaviour with this patch is that removal of consumer-1 (A) will
not remove the uprobe object (that happens only when we run out of
refs), and the following install of consumer-2 will use the existing
uprobe object so the consumer-2 will be triggered on foo return

uff ;-)

but I think it's better, because we get more hits

jirka

> -		else
> -			err = -EBUSY;
> +		/* TODO : cant unregister? schedule a worker thread */
> +		WARN(err, "leaking uprobe due to failed unregistration");
>  	}
>  	up_write(&uprobe->register_rwsem);
>  
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
>  		uprobe_unregister(uprobe, uc);
>  		return ERR_PTR(ret);

SNIP

