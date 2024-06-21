Return-Path: <bpf+bounces-32757-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 120AD912DC5
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 21:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF2942842C3
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 19:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B2317A93E;
	Fri, 21 Jun 2024 19:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JnEVlfBE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F6A4644C;
	Fri, 21 Jun 2024 19:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718997530; cv=none; b=XywncdpovO2gK/zNZKhMc299tQ7SdsT1Z7wlT80cnyEC6GYJfOgXsbgHWTDqrY3VEwEy41fhHoGvTUfR/vDpzaRiqXtWv3df1DuH/wQoz+WXbjoKLVOHK7NBQ4p8Cpi6UKJcnf24aqpM3PpotI+ldUzCyLmGRvS6Vcx5qFC1iVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718997530; c=relaxed/simple;
	bh=4b15RRFLHYTXI8/mWM0eb9a4yFji9qdd7+lhe3DcUqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ibakt+z/WWqU3RY/lhfISKk0pLayz2XiGB/0ixQI9ZCX2R04vWl12WaoQIkrOZtjXPvVuZW32KUU4tYwYSePZe9+oELFg3AwqZoRbc2NzBAVrR+nhDZAYOzjzbb8k/E0PV7S+SO+jnCEHuIQpXQmHXBc7x7LqRyNpq6MpR/2vW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JnEVlfBE; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f6fabe9da3so19666435ad.0;
        Fri, 21 Jun 2024 12:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718997528; x=1719602328; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f3JLZK9KhSNbfEjLOhjGsas4rAhTsCvacjMIXcw3CjM=;
        b=JnEVlfBElQoPjnLLgElcs2HyS8p/gTrEAEjKJCh+K+p0NFRwoQxY/Ntndxs+eLOqbe
         x3eMyfDvRfIjODx8mpHmajQ/frUZCv2PbpG/EkRDMKbvp4cH2IwpMS60jRqqCgeXrYD0
         7sXhMqT0N/3gYxmcembOUwKXhDKeyko/elhRdFn+8FVUGRO5UAUzdBigSt2askDSDvGX
         BW/QMm2yx1V2OCpqQYL9xvGBNhswNYkLsv48eJtA7oYvxTn50pNaMpdyeYF4O9jw+zlV
         aVDip+G7bMTwQE+Vu+8z1tWfORZQbYTO0o+2l3t+6ApcOp6BqeDU6Zzxa6JaR/fyaw7s
         vxHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718997528; x=1719602328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f3JLZK9KhSNbfEjLOhjGsas4rAhTsCvacjMIXcw3CjM=;
        b=f9L6rWNwzL2skwuqLo1oAYIiq3BWAyKNGeZhTIRQ8vgAMpC+CvfcFkwD6NTF4bMtWV
         e807RieGFCq4hvhWHsCa7TPTgTvGiRTwtIwLjm8m5oqSVPihr0eu51J6Il3hHUC/IBYC
         snrwCiNm3KCRWs6z+oD21Ah5VocvYjh12Kl5GyJUT+yGcG2H3xcsAikxXLDnhlsIxs4l
         OLI5yuF8hb0QUdVnEudkiKLL9DDq3TYfd1ttmwH+xd03vpobvnPKimNu6q5WLkX9G8mW
         2cZY/egkjPb1M+W+Rc8IJjq2nYRG1sWyeUegDAohb8sGJZIBvADRtjkBfJO1GpuI4B7D
         gNDg==
X-Forwarded-Encrypted: i=1; AJvYcCVL9nHkUyPYdeLCvOs9ppwkrQNI/rrzcByZZG1XQ/KUi94S7Q38khZrdFws0cwDVjhrdnSjiHBgwt+iIDTE5sQx7duISKleRgu1zTxnbVQ+RiPXOHCO1Uw/hWh/d5Rc4e9b
X-Gm-Message-State: AOJu0YwOBXiG1qPH2E+zS1wcdUYobr/25iG+ZvUOqfls+vJWwM333SjR
	bvgzY7543qnAdwvUNb62AQoeUUWxzhLm0tuUSTRWqMSCzhLLFcYV
X-Google-Smtp-Source: AGHT+IFl/43vk2lPhapGOwGIq/mwHjsv73H3Xw8dv/Xkx2RGTWSRVCMFLRZu45n81+D9RkNu5EejNQ==
X-Received: by 2002:a17:903:248:b0:1f4:b2ce:8dbe with SMTP id d9443c01a7336-1f9aa3eceeamr102143225ad.9.1718997528346;
        Fri, 21 Jun 2024 12:18:48 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb2f042dsm17546935ad.39.2024.06.21.12.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 12:18:48 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 21 Jun 2024 09:18:46 -1000
From: Tejun Heo <tj@kernel.org>
To: Phil Auld <pauld@redhat.com>
Cc: torvalds@linux-foundation.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@kernel.org, joshdon@google.com, brho@google.com,
	pjt@google.com, derkling@google.com, haoluo@google.com,
	dvernet@meta.com, dschatzberg@meta.com, dskarlat@cs.cmu.edu,
	riel@surriel.com, changwoo@igalia.com, himadrics@inria.fr,
	memxor@gmail.com, andrea.righi@canonical.com,
	joel@joelfernandes.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 04/30] sched: Add sched_class->switching_to() and expose
 check_class_changing/changed()
Message-ID: <ZnXSFrn6wNqk21GS@slm.duckdns.org>
References: <20240618212056.2833381-1-tj@kernel.org>
 <20240618212056.2833381-5-tj@kernel.org>
 <20240621165327.GA51310@lorien.usersys.redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621165327.GA51310@lorien.usersys.redhat.com>

Hello, Phil.

On Fri, Jun 21, 2024 at 12:53:27PM -0400, Phil Auld wrote:
> > A new BPF extensible sched_class will have callbacks that allow the BPF
> > scheduler to keep track of relevant task states (like priority and cpumask).
> > Those callbacks aren't called while a task is on a different sched_class.
> > When a task comes back, we wanna tell the BPF progs the up-to-date state
> 
> "wanna" ?   How about "want to"?
> 
> That makes me wanna stop reading right there... :)

Sorry about that. Have been watching for it recently but this log was
written a while ago, so...

> > +/*
> > + * ->switching_to() is called with the pi_lock and rq_lock held and must not
> > + * mess with locking.
> > + */
> > +void check_class_changing(struct rq *rq, struct task_struct *p,
> > +			  const struct sched_class *prev_class)
> > +{
> > +	if (prev_class != p->sched_class && p->sched_class->switching_to)
> > +		p->sched_class->switching_to(rq, p);
> > +}
> 
> Does this really need wrapper? The compiler may help but it doesn't seem to
> but you're doing a function call and passing in prev_class just to do a
> simple check.  I guess it's not really a fast path. Just seemed like overkill.

This doesn't really matter either way but wouldn't it look weird if it's not
symmetric with check_class_changed()?

Thanks.

-- 
tejun

