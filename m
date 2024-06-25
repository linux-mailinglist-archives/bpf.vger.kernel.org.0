Return-Path: <bpf+bounces-33107-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FBE9174B3
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 01:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 784212816C6
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 23:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8640117D36F;
	Tue, 25 Jun 2024 23:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfL2+5NX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941F217F4F5;
	Tue, 25 Jun 2024 23:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719358210; cv=none; b=WLUbb0n4iCaKwym+fj7ECgDgrtivJa6CUMbvYodN/IcKDvlH+DTK9XemOuguazlH2AiLucKe721p2nFGopnrPfJlIw1Rnl1Yh9SpHN84UPHP3F/7L+5q9arjhOHyAzTu/x0hPj/DF87PcqzXm7ctKdq4y2pRATGrhN75tyNBzx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719358210; c=relaxed/simple;
	bh=EdQ43ki7esE0wPqQpZa2Dp3OIXrQAt9pbnNqgxA//D0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qcKCmqD6QG1SLzaiHrSFhyuhlHs1eOH9I1HUPXPF076b1OW0cG5W8/h/WQISoypn/zdSoNh3GtBs7UV9iAysjvFNwhmAf65Zafh+60wkQnwY3qicKS54+RLjlGBt4GhEXtO+zSct7dWiRWPQjEBGFQavs0P6saZzyXuaUM7ZunM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lfL2+5NX; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-36dd6110186so24447975ab.0;
        Tue, 25 Jun 2024 16:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719358208; x=1719963008; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bg3kMKMGnal53yHNsg+SreZBLvYQLXx98xwiRMCFFNA=;
        b=lfL2+5NX9nR+5Uj7Ohu57IbR+Nv67FoV/XoOEcLpdil00a4hG5McSPvRPG759FnsLc
         hQ6+PcZz/09emU5QGD9G19RL0IMajADyCHkJ8njFNmslCGH83zsVZhYpE1lPNF+31F+U
         NBXh3jLIeb1UQHcGRCJhVdv8/c8Ax0QS9rXtX+H3AZeyPSO2wA+yLDOhjpJP8CEpNzeP
         BwxfLNhm97wnI6vvBsfXXTtN7YZLZlXItLynT+WG2nn8BdLcewDQt+uHXmbhAfREjr0d
         wEY9CSRebwzs6WOV5u4ADVcGQDjCrV24XzMHB8+QoaGNyIK3Q4Tz+Sp30uvwgc+2MFVj
         L8CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719358208; x=1719963008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bg3kMKMGnal53yHNsg+SreZBLvYQLXx98xwiRMCFFNA=;
        b=gd5Ry2m9VG/LMOqXhTqaWj4Z/Sn+heUZ30N3XPk0AYVtFvCwpZXqCqTcla5wsuB1bn
         mVFYmjn6j+NBL8BZfRS9pRnoUA5+HNpQ/y3BgYJk/ldAva2AwuKKQwDrK+P6LsBjN/Mq
         EHfgRFhGfrfrMQzntZ7BXViamHuRhO5gd9AwU3jw9TPXyG7w1G/sOkfFhbqdOjLdgBXt
         6JK7BhkCsn2VVgWyMV2ZjIo1H1FQqv946M2JEiPdezua9DBxYAeb8yS2wTuj/sEnG9Xz
         i3uN2Hf50Tp2cJXPlgDoFtwvirWTPkfx0leOE5n6KAVrTYhCZWd/JHUPclaLFDch8PPc
         056g==
X-Forwarded-Encrypted: i=1; AJvYcCV8nfbh3jQfYptF0XZA8aWmUWUKNCk/+iQNf7/pnrIqfeknP6XFrjPxqnNL8Tp2+wpGBEpilgAKtEtMLGS7kalCVvIp4NeAPDO1qGOgAzL/J+UMQAlGi1Z/FWJPqxbbkCXN
X-Gm-Message-State: AOJu0Yy24ibS5AbVCwpoxJU9qEiQuGdxbfUNl85NCj6ENgW+DoV1Eg8A
	GEL9emAkSbaL5yvLIPhYypsQpVmOsWODxzC0mrjfxSkJnulz7NQi
X-Google-Smtp-Source: AGHT+IGSHnWYqJlhWTBSynscPCVm1/oLGIvq0751iKJquimCnh1PVP7AIh6Zd8bcFWRpbdw5qEGH+A==
X-Received: by 2002:a05:6602:341e:b0:7eb:8730:a304 with SMTP id ca18e2360f4ac-7f3a7532c36mr972240739f.8.1719358207643;
        Tue, 25 Jun 2024 16:30:07 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7066c7fb9casm6721624b3a.94.2024.06.25.16.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 16:30:07 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 25 Jun 2024 13:30:05 -1000
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
Message-ID: <ZntS_eM2reaszYcj@slm.duckdns.org>
References: <87bk3wpnzv.ffs@tglx>
 <CAHk-=wiKgKpNA6Dv7zoLHATweM-nEYWeXeFdS03wUQ8-V4wFxg@mail.gmail.com>
 <878qz0pcir.ffs@tglx>
 <CAHk-=wg88k=EsHyGrX9dKt10KxSygzcEGdKRYRTx9xtA_y=rqQ@mail.gmail.com>
 <CAHk-=wgjbNLRtOvcmeEUtBQyJtYYAtvRTROBy9GHeF1Quszfgg@mail.gmail.com>
 <ZnRptXC-ONl-PAyX@slm.duckdns.org>
 <ZnSp5mVp3uhYganb@slm.duckdns.org>
 <20240624085927.GE31592@noisy.programming.kicks-ass.net>
 <ZnnelpsfuVPK7rE2@slm.duckdns.org>
 <20240625074935.GR31592@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625074935.GR31592@noisy.programming.kicks-ass.net>

Hello,

On Tue, Jun 25, 2024 at 09:49:35AM +0200, Peter Zijlstra wrote:
> > Imagine a case where a sched_ext task was running but then a RT task wakes
> > up on the CPU. We'd enter the scheduling path, RT's pick_next_task() would
> > return the new RT task to run. We now need to tell the BPF scheduler that we
> > lost the CPU to the RT task but haven't called its pick_next_task() yet.
> 
> Bah, I got it backwards indeed. But in this case, don't you also need
> something in pick_task() -- the whole core scheduling thing does much
> the same.

Yes, indeed we do, but because we're dispatching from the balance path, the
cpu_acquire method is being called from there. Because who was running on
the CPU before us is less interesting, @prev is not passed into
cpu_acquire() but if that becomes necessary, it's already available there
too.

Thanks.

-- 
tejun

