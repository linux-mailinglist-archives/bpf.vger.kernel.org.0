Return-Path: <bpf+bounces-32947-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DC3915869
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 23:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A178F1F26C02
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 21:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46251A08A6;
	Mon, 24 Jun 2024 21:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7FgOqGc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24568FBEF;
	Mon, 24 Jun 2024 21:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719262874; cv=none; b=MZ802hMHiN4fwaGKLITjQP4AXip279qEUkoALAHOm1JD/6sH8DSpvPXeu5hdIP70kXCOj4fi/3aFIahcF2NYmzqiAyN4ebEB76RRWKQKa4ii8r3UegiArXxhNer+cPUwn3gmiDdHjes6KrFCXCE6pUpBJrOl0ULhTJ3zY+jg45s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719262874; c=relaxed/simple;
	bh=YvIsZSEKLKEUGIZFOgyBnHsquu0aId1WPfl7qNtp86k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BfP7wULgy8AwM3Pl2CHsnFDDwQvkjOvI9ontkfNkFuwOS+/eZQDr1z1jvKHpRlMsm9WtFHrVj9DitKiLvgzQY9JDXld35iZwDlE3DLgVGHah9x3pOUhuN99BXoUQG2zejgBxGK5vjtj25FPST8yQtyrOaluNcBbDexxQ7MpOGSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X7FgOqGc; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fa244db0b2so14563645ad.3;
        Mon, 24 Jun 2024 14:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719262872; x=1719867672; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rsrj1rTdRJbKWl2kT5e83ANXLHH3004GFG4NvofAvXs=;
        b=X7FgOqGcRiC0YLok7+nAD7Bem1TgOMHq2ydF/ZkKxOc918OtrlbCjSkO3mcxMfrAKC
         JdvNCzfgEMPyoRDWsOFMSnJg3CGgGStJ9qOFl4X46tHyfKib7w+c0LmdPzymRk18EdZU
         TtAJES3klmN/8pjcU+4WqyL2nX4HTa1S86RGgtZFnouIOUCeN+aFj+h5OEhh4K7oOk9Y
         igiKedI3H12gHycMqjxzLp25cLuw38fZ+/X8D7ymWOs1AseP1l0GOS1GWf1OdV1eM9iG
         L3NwZ5yoSUQEfPNoAsC+Z9eZV1MVJPMo8fn8z26KHIJ86L1MdrhlWlwsdGHFTYB2QUz6
         Fukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719262872; x=1719867672;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rsrj1rTdRJbKWl2kT5e83ANXLHH3004GFG4NvofAvXs=;
        b=X3gcOdr8AOkIREY+roJ8kb+oHJ9w8WI3z+sXKNVV4HHssTgAliaMGbLRsroxwim8/j
         NTp8l+ARgNcKP9+PsE8k8n8zPxh8BnQ/7disMFtKwOTE8UwOw93+Xk6ysQ3S2g9vJVBA
         nHQ/HM3ERhOr+irTeOWm3Z4snbUgr9Ug/hmI2rzP08GiMauPeVDb7Otr2eIjF4CZ7fXH
         XTodtpqDRDcHBz/01VUdGUEk7EMm12cdfh1R+D3jbwAPAFqITwqVA4gWHy597nBtC/Q2
         wjgplJu4qxuNFa8xki9uc/HyeNx7bJIAxdv+A22LDG2bJqkHbf9xUFZ2BSzytnXD0HKB
         5eRg==
X-Forwarded-Encrypted: i=1; AJvYcCU9Gv48oXZAI079zsZ5eM/kxXtGIZzbc4fDjDoVF2ITjmaB6aCJvIbO97fml1otILwBH+4PnfqWjOD27JQqeaFP7JrnDIrHg16ayD8iJJSgg7b9O9a6G48yAnL1SKJq7x6D
X-Gm-Message-State: AOJu0Yyl5ip5wN2TEB6SM3LzIPmfTepy3mDgFGYX1+NoedxH4Zryq1Xi
	oVBLn8bUa0xoi7AQN5fUF2T2/vgXNAFPqYV+nt688yCIIZQcsbT0
X-Google-Smtp-Source: AGHT+IEpEkStMOhd7WwxP5wtmmwDIJhd/3Nj8gO4bbZUT8Pc8pVHGL0DfvOR9UPkiEvjumZPPuk4+Q==
X-Received: by 2002:a17:902:d2cc:b0:1f7:1b97:e911 with SMTP id d9443c01a7336-1fa158d0cfamr88161435ad.2.1719262872229;
        Mon, 24 Jun 2024 14:01:12 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb3c591bsm67031385ad.165.2024.06.24.14.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 14:01:11 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 24 Jun 2024 11:01:10 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
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
Subject: Re: [PATCH sched_ext/for-6.11] sched, sched_ext: Replace
 scx_next_task_picked() with sched_class->switch_class()
Message-ID: <ZnnelpsfuVPK7rE2@slm.duckdns.org>
References: <87ed8sps71.ffs@tglx>
 <CAHk-=wg3RDXp2sY9EXA0JD26kdNHHBP4suXyeqJhnL_3yjG2gg@mail.gmail.com>
 <87bk3wpnzv.ffs@tglx>
 <CAHk-=wiKgKpNA6Dv7zoLHATweM-nEYWeXeFdS03wUQ8-V4wFxg@mail.gmail.com>
 <878qz0pcir.ffs@tglx>
 <CAHk-=wg88k=EsHyGrX9dKt10KxSygzcEGdKRYRTx9xtA_y=rqQ@mail.gmail.com>
 <CAHk-=wgjbNLRtOvcmeEUtBQyJtYYAtvRTROBy9GHeF1Quszfgg@mail.gmail.com>
 <ZnRptXC-ONl-PAyX@slm.duckdns.org>
 <ZnSp5mVp3uhYganb@slm.duckdns.org>
 <20240624085927.GE31592@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624085927.GE31592@noisy.programming.kicks-ass.net>

Hello, Peter.

On Mon, Jun 24, 2024 at 10:59:27AM +0200, Peter Zijlstra wrote:
> > @@ -5907,7 +5907,10 @@ restart:
> >  	for_each_active_class(class) {
> >  		p = class->pick_next_task(rq);
> >  		if (p) {
> > -			scx_next_task_picked(rq, p, class);
> > +			const struct sched_class *prev_class = prev->sched_class;
> > +
> > +			if (class != prev_class && prev_class->switch_class)
> > +				prev_class->switch_class(rq, p);
> 
> I would much rather see sched_class::pick_next_task() get an extra
> argument so that the BPF thing can do what it needs in there and we can
> avoid this extra code here.

Hmm... but here, the previous class's ->pick_next_task() might not be called
at all, so I'm not sure how that'd work. For context, sched_ext is using
this to tell the BPF scheduler that it lost a CPU to a higher priority class
(be that RT or CFS) os that the BPF scheduler can respond if necessary (e.g.
punting tasks that were queued on that CPU somewhere else and so on).

Imagine a case where a sched_ext task was running but then a RT task wakes
up on the CPU. We'd enter the scheduling path, RT's pick_next_task() would
return the new RT task to run. We now need to tell the BPF scheduler that we
lost the CPU to the RT task but haven't called its pick_next_task() yet.

Thanks.

-- 
tejun

