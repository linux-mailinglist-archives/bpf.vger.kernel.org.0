Return-Path: <bpf+bounces-33112-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA983917519
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 01:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 762C7281D5E
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 23:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5D617FACA;
	Tue, 25 Jun 2024 23:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pae8S5O5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929FA1494DE;
	Tue, 25 Jun 2024 23:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719359860; cv=none; b=fsEis2t6mPLrldg7L8EeISPwtp4E1vk1AOb4AKoWVU0Rx2QJUHs3wTtkG4eRSckH3DhELJFqFmVKv0F0rttY5xMGC+3E0aCUfSkb9vicRF8xH4cwhKeRPmlUlR67RsnN/8lSkEpAcDqlDs3+63R0//RhJRv1X5CGpJnL534zbOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719359860; c=relaxed/simple;
	bh=svY7Io4CAu8UU1sbgi+9W3r7Nf78vQERKds4nXyFfis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MktSl0GXV806Za5nk7sYYCVMxIFvQ9UEghpeyZ56oZDUlBf8JwRXLTG2hGSe9wf6f3JrDCjoKwiXHcirVraGwnpc6UX6/JPJPcFTFGVQpG3/C4P+tvhsXp6CzpseG2/E5ub+U/J+/FCD2y7Q2d7f8vLL/4MgjSPvrE5C4ZOa0aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pae8S5O5; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70683d96d0eso1985233b3a.0;
        Tue, 25 Jun 2024 16:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719359859; x=1719964659; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/XaDjMmgTWJFFQ5BGgjN3NJiFtRfzFQBhoByXHcRJwg=;
        b=Pae8S5O59Wf5QBjP4g+RvYrc1m6a3cPEwst4ruZDmlZ67uSsbig4JAJhjgiTmDSB6j
         NEppycz1L9CGTM0TBfsjbI9tC0MPQS/sYT88PClpRQJ9vFAsxGEL82p1AmCVdUCk7d42
         8/h9ie8zsARGovkbQ5zY15m8hWRa0lpU2PvWxZrWtRSu6o9CkXaQPKULBtHaCznUnXeQ
         +ao79PHHhAkcaK5zlKoHSO6+H6fk8Gh/0A/llVGHVkVKSyT2IKM3C1LtJibTmJRdpy4t
         5wzUz9/F6FJqFh/IsjFIqedjmCP6fhSSNMCOXxnMYwBoGf/Wy+Jf+YXI30CuzDL52LH2
         Hpaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719359859; x=1719964659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/XaDjMmgTWJFFQ5BGgjN3NJiFtRfzFQBhoByXHcRJwg=;
        b=fTMQ3pmJknSBvfRhduPo5nOjrbrV+pbmpB7HPXPgWXwSe4H1QrUdZaxRvoJWe1IaZJ
         ikyUcfJPOlDkVyFRlpCD+TnEzNCuLHC6eFESPfiJcKSCnye4iEhAL3nSI+RVX3WU7EOF
         YYa1i0DhLi7d0fAb2lP/kYOeKoN2qUGXXTbeR9H0y/uG3EYBMxf9Ci8AZsPTEvrOK6O/
         JZlgC61ox3VIsD80QzyJeyNNrkWSWcxvcqveGm+3tZSglMdnJORqIRuktMU+ACQz704S
         eQtkhMvCwM1ftdjjckYkt3dTGQjTG8fiASOTY1XHFtYJHQa+7X45lp+Tw703qxw2Qqus
         kc2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUgetguzS48ipmTLZKWUY7/DMB5lFwNph5IOAlGnY+1Kg+laLCHzaO6r1MXvvl6I25Zpl0QZ1322FGV0ErFGFuk7fq87dgtmliXu8M8lgJZ77TyA5xhMGiMGvFSAmmLNy4e
X-Gm-Message-State: AOJu0YxVZ07ZL0Sg4QSyVC576+wNz2cBngqpEMWNd8I+j/fAOvHbMGHn
	+y7jLMFJ9g92rFfuyRAxDfipOi1tZo+H90M2igFBAkkKyV5DgSE9
X-Google-Smtp-Source: AGHT+IFN4kWX0An43oSO3GkwzGJk2cCKemfRjeNPEKVQcyzy6+3zE6/xSIkz7JdzYhuczTnzL9SH7g==
X-Received: by 2002:a05:6a20:c49b:b0:1be:cea:d381 with SMTP id adf61e73a8af0-1be0cead4c0mr238722637.18.1719359858755;
        Tue, 25 Jun 2024 16:57:38 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb6db388sm87285525ad.229.2024.06.25.16.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 16:57:38 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 25 Jun 2024 13:57:37 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: torvalds@linux-foundation.org, mingo@redhat.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
	joshdon@google.com, brho@google.com, pjt@google.com,
	derkling@google.com, haoluo@google.com, dvernet@meta.com,
	dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com,
	changwoo@igalia.com, himadrics@inria.fr, memxor@gmail.com,
	andrea.righi@canonical.com, joel@joelfernandes.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 04/39] sched: Add sched_class->reweight_task()
Message-ID: <ZntZcRgm-zok7kyb@slm.duckdns.org>
References: <20240501151312.635565-1-tj@kernel.org>
 <20240501151312.635565-5-tj@kernel.org>
 <20240624102331.GI31592@noisy.programming.kicks-ass.net>
 <ZnoIRnCZaN_oHQ6N@slm.duckdns.org>
 <20240625072954.GQ31592@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625072954.GQ31592@noisy.programming.kicks-ass.net>

On Tue, Jun 25, 2024 at 09:29:54AM +0200, Peter Zijlstra wrote:
> On Mon, Jun 24, 2024 at 01:59:02PM -1000, Tejun Heo wrote:
> 
> > Were you trying to say that if the idle policy were to implement
> > ->reweight_task(), it wouldn't be called?
> 
> This. IDLE really is FAIR but with a really small weight.

Oh, right, I got confused (again) by the idle class and SCHED_IDLE. Will
fix.

Thanks.

-- 
tejun

