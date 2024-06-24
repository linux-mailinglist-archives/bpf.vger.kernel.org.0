Return-Path: <bpf+bounces-32933-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C48A9156CE
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 20:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08FC128493D
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 18:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDA61A08B6;
	Mon, 24 Jun 2024 18:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VBuaL9pf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928D81A0721;
	Mon, 24 Jun 2024 18:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719255379; cv=none; b=QyoSduk84IkBSeiIJPYppKrLJPtSoTRSXu6PcABU8Ib3oicowgryuwTcUyozVr1l2oz0whYjc3gzh07cRkIptu56CYZwlYZCPetrqzPAAPLUH6/xo/8n1+sCotaUHi5UGa6wXOzvX5z0wgJomhEbJXhLobhtmIzj5Ad+tySq9zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719255379; c=relaxed/simple;
	bh=xzWykK60SWeuWv8mlFYBbhH2xSuh+XD82BU7oEkDhgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uru3x15dD0mrEiIrDOLWCwoHdR38eLP6k0jHxPEwTdqKl7MbYsBD2TI4vZeCLtnEBR7EpfLl0s25y39h/48kPj30W5bpiaz20Gcn/nSX97U1T8qjlyRzRDzEJBySTEirsZjnlLcRySbbnIWPnO9zLayLDNfXhirCeXgdqMF6PfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VBuaL9pf; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f9c6e59d34so39249485ad.2;
        Mon, 24 Jun 2024 11:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719255378; x=1719860178; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8RHKCKNPcVVYDB6DFnBe9nFHPPQRezc1L0JGyN0aqrU=;
        b=VBuaL9pf7QNELQlGwZX7/HrMY6roI9boUF2p8bepWiTFFUYV+CsgRzdoiID5zSa9FU
         B7KVwns0tMOw0RBTV0T4J4vysS2o0xx0w3uDERVpVT00Qwh2gkp6ptw9Tu9fwO/U9WGv
         4LNip/OpZqPASPUtEqUQOZZ8LTuRfTMLmOjLNdjMs8dwzNO2DKlbODA6IOkrt79uVkHe
         7iqLpgi4glhIcXHHw8UlB1HbqKviyn+22y7yYlkmtkSEtyqgi0XakHjl7B2S1EiEdvEG
         dEHDPGg1/EZa+0TuxIwWutQbPu/HCUNiO7gXiqU+SsryndDGYX3GJp4dWvUBCCDomzst
         KRzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719255378; x=1719860178;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8RHKCKNPcVVYDB6DFnBe9nFHPPQRezc1L0JGyN0aqrU=;
        b=KxE28Jx7vAXBOCWJGZRPRVJ83F2pAFAD7UOXNuG6DWW51P0v5I3VZpKpBbp0Dl2fne
         2pfC7+EqEtuLCm8slEAl7J99avTlEWmvWaT5YyctKNlZ5Tqr0bpmxjBSeTakneZzv51A
         XYSeBakgmdHRFncM6TbG7Upn5pGc7lAHcnFWiSLJ5pErr5giq3UdX++coflJECjoMbfN
         586hK4lgs1bQ4Mzu2cTFz2HApg+ujNufOeTz2456kWKJShG7CjABGIjGFa31Vj0aWng7
         AcBgdrlyyvgQCxN9kHDUbXNcYulLJ/woBDkwSDBVLlnSqq0W3CfsW0u9Uedg+29Gx4g+
         VJBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcOTKiJOaMOzPkv8NPe82V0dqWHHw3tgx27Z39v00WcO78USCJQCR/9bwfVNF8S4quEoNV2eOyzkfaw+SRH/SBeGihbbppw8wMfEnoDeZAbENof9hnDVvlKXznT1xQPBCS
X-Gm-Message-State: AOJu0Yxzvvg6UovlDhSNIzj7tuuA2IHtu2rCCbXp6erYs0Fa24g/2bI1
	noHTncpZcNr+NK4fnEs8SqQsQwF91w7Vk67s9rzYRzWWnU4SRlLe
X-Google-Smtp-Source: AGHT+IHhIGHI0M/jutoc7gxfCbikoscoGmR7Ejnyb5zkfPTu+w5tMDBaBUFoyLnDZsj6xpAFBJ6ioQ==
X-Received: by 2002:a17:902:f54b:b0:1f9:b16d:f94f with SMTP id d9443c01a7336-1fa1d62a4e4mr77298635ad.39.1719255377767;
        Mon, 24 Jun 2024 11:56:17 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb9c1a79sm65891285ad.240.2024.06.24.11.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 11:56:17 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 24 Jun 2024 08:56:16 -1000
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
	kernel-team@meta.com, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 07/39] sched: Expose css_tg() and __setscheduler_prio()
Message-ID: <ZnnBUA4_f2b_D82e@slm.duckdns.org>
References: <20240501151312.635565-1-tj@kernel.org>
 <20240501151312.635565-8-tj@kernel.org>
 <20240624111917.GK31592@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624111917.GK31592@noisy.programming.kicks-ass.net>

Hello,

On Mon, Jun 24, 2024 at 01:19:17PM +0200, Peter Zijlstra wrote:
> > -static void __setscheduler_prio(struct task_struct *p, int prio)
> > +void __setscheduler_prio(struct task_struct *p, int prio)
> >  {
> >  	if (dl_prio(prio))
> >  		p->sched_class = &dl_sched_class;
> 
> FWIW this conflicts with patches in tip/sched/core, and did so at the
> time of posting.

Oh yeah, as I noted in another reply, v7 patchset is rebased on top of the
current tip/sched/core and already in linux-next. These are all fixed up
already.

Thanks.

-- 
tejun

