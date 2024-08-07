Return-Path: <bpf+bounces-36619-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DE894B072
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 21:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59D911C216D0
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 19:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AB8144313;
	Wed,  7 Aug 2024 19:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jo3xCgv3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525DC14388F;
	Wed,  7 Aug 2024 19:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723058792; cv=none; b=T9A0/juYjn04gl+THWX9brjKQkhU0LJO4tQAhiU6mbLRwZoO7hrAh9Qzm2SXTZBpBlHMgDW42gX6hMIqsc8GvJUpBOpaPljJLVQXAiLWBSj9KVEAX9qYvRPnV0R64AZuie02VOy7vm1Bwn3duFolQqhVqrDh27TlevKUZbP6NT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723058792; c=relaxed/simple;
	bh=CA+AqtCxKzZ/+gGVIGdLjXmQD5y7yrWwE0ykjd+chsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pLbl8oLrEzL1BMcVOdDyBjTfp7HfEeg9i+WQW5gcpOGkrpLp68dfMC6CESztViM1OUHUj7kD/LKj+mXvoh7e1VochYAfb52/6TRPBXtw3mM4sv/mGNjdDLxv3RHDfyMt3p0lAR9lj6HVVBgoeCymM/PvqfIjIPlI//9kpSn3zKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jo3xCgv3; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-76cb5b6b3e4so145055a12.1;
        Wed, 07 Aug 2024 12:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723058790; x=1723663590; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ntigGfQd6n61p5RxDaD02kcMehzdaU2EBhDH68tO7ZU=;
        b=Jo3xCgv3ASWP418UCIu3BdqPBHQ4qnP5ii1wPugAM1kAfy5IDhRFcCPWziXZXYm1yI
         A53G4UfcMV3lM0GUtNCLs0OnAB7nJtgUMk9yROg1v84qliHRxQzuQPoscPwM5fgm1bsn
         1XnZcoIJEeqmKIlORq8F/bMUZJ4gFPH2D37kpDNP01RucrIx8ZNjd1+/8RvWuWR51sBm
         ZSyINmJubXGK2hwuOM4jkBhhW7UfeUqewC2ubWhA9WlqCF0CGV/lOB6zyINrLgCSvScg
         7wM3TJRKN92ewYqSXWJ/OeqqIoJIXDgQn1dtHVWmgGAifVjYJPzorR+MEd2iHkdHCSgA
         dFrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723058790; x=1723663590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ntigGfQd6n61p5RxDaD02kcMehzdaU2EBhDH68tO7ZU=;
        b=sSGyPJmwrmuH/UVe1BGR1/nXgIIyRgyPMr0m6R84IjxXGF7tJXmjvw7PMEXChm5v6r
         4n5DbZz3AAe/LT5uXUKOId+z+UCAjodgsQIWvFzwvIRdwQGxlNyBUDKsR5wJva6psBMf
         BMejmSGu5V5PL3RFh3IKrOMv3WyKdrUjC+/p2nD+srXfGVr+OAisdJO142xSFA1H6IlR
         ujVo9R5Yd5EntDKyBjoAkm/wGfNWbkf7p45KB3RUWJrhA9ONZpDv0yeotIVRdkJmc3dg
         ZqJ4CaybKuC3TATgN6fgjFiA9ZM5IgwCJSjrOPCzeFM4+roq6Gzxno4ML9y+Qib7KEjh
         Dp0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVUxzjeJRSOrclo9ARvS9Wtlp35p0/WnYDoPlwERdqu0fLBs0otLoGKtVDppCIs8xHZsr6ZHiMILIL5GzlefvAmBA47DR0ghghBRX2J+reuTOU2+bODKSz+yty2IGoN6sT+
X-Gm-Message-State: AOJu0Yx2BbZjHaAhmWqg56ys/PgEPKA1ex/Bx7oDgNXzBBI/TBytmwLZ
	/MfUjbEvfZN7tquBNQZasGnEp5zoxfzmIlZIXEKxrd7YkrGrH4iM
X-Google-Smtp-Source: AGHT+IH3GllPy2U80SQLB51JljrID3T6rPeN67ItMms+EZ9HQDEQQMz0wkn6OzDaDy6sBS8b0OAl4Q==
X-Received: by 2002:a05:6a21:478a:b0:1c3:b102:bdfb with SMTP id adf61e73a8af0-1c6996283cdmr20628864637.43.1723058790480;
        Wed, 07 Aug 2024 12:26:30 -0700 (PDT)
Received: from localhost (dhcp-72-235-129-167.hawaiiantel.net. [72.235.129.167])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b764fb53dasm8534450a12.65.2024.08.07.12.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 12:26:29 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 7 Aug 2024 09:26:28 -1000
From: Tejun Heo <tj@kernel.org>
To: Phil Auld <pauld@redhat.com>
Cc: torvalds@linux-foundation.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
	joshdon@google.com, brho@google.com, pjt@google.com,
	derkling@google.com, haoluo@google.com, dvernet@meta.com,
	dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com,
	changwoo@igalia.com, himadrics@inria.fr, memxor@gmail.com,
	andrea.righi@canonical.com, joel@joelfernandes.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 09/30] sched_ext: Implement BPF extensible scheduler class
Message-ID: <ZrPKZMvrl6kGFzo-@slm.duckdns.org>
References: <20240618212056.2833381-1-tj@kernel.org>
 <20240618212056.2833381-10-tj@kernel.org>
 <20240807191004.GB47824@pauld.westford.csb>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807191004.GB47824@pauld.westford.csb>

Hello, Phil.

On Wed, Aug 07, 2024 at 03:11:08PM -0400, Phil Auld wrote:
> On Tue, Jun 18, 2024 at 11:17:24AM -1000 Tejun Heo wrote:
> > Implement a new scheduler class sched_ext (SCX), which allows scheduling
> > policies to be implemented as BPF programs to achieve the following:
> > 
> 
> I looks like this is slated for v6.12 now?  That would be good. My initial
> experimentation with scx has been positive.

Yeap and great to hear.

> I just picked one email, not completely randomly.
> 
> > - Both enable and disable paths are a bit complicated. The enable path
> >   switches all tasks without blocking to avoid issues which can arise from
> >   partially switched states (e.g. the switching task itself being starved).
> >   The disable path can't trust the BPF scheduler at all, so it also has to
> >   guarantee forward progress without blocking. See scx_ops_enable() and
> >   scx_ops_disable_workfn().
> 
> I think, from a supportability point of view, there needs to be a pr_info, at least,
> in each of these places, enable and disable, with the name of the scx scheduler. It
> looks like there is at least a pr_error for when one gets ejected due to misbehavior.
> But there needs to be a record of when such is loaded and unloaded.

Sure, that's not difficult. Will do so soon.

Thanks.

-- 
tejun

