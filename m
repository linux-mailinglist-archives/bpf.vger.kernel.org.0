Return-Path: <bpf+bounces-33379-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD8191C8D7
	for <lists+bpf@lfdr.de>; Sat, 29 Jun 2024 00:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FB2228516C
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 22:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4880824BF;
	Fri, 28 Jun 2024 21:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XylFgA3g"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE21180630;
	Fri, 28 Jun 2024 21:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719611858; cv=none; b=uQNxGyEaaqYpEdnZBTp1Aa6HjdXpc3NxlZvpKFbJKtYExKg2lORUnlAuL2AgWa1IuckdAmdFA7Ps3V288TP6ROVCM1dsYwoWMsnpWG3u9pprUFNCroqYasXTfwxOvTDpL2mEkkbWvlya0F9u5UmPmKfuOnFETrBlPoZSKoB9c5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719611858; c=relaxed/simple;
	bh=pkBNNxdwGME+gt5fOTGQSeWDfFp+HDmHZS0KAsyIyps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AHbnJsgofCVVgvbuOB1D8mbkA9DozzQajGyLBzG0JuHz+w4t8sUyBkgDJ2OimXDFAJabNTAhp1nqcRwVQEy9zMYct13RqgNl8Y82TzqGH+oRAZzsHeaIi7b7HdPWky2ZJBJecx0/jmnVd6PQQpEo+t71lRbEucogcv9HYqCgAD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XylFgA3g; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-72b070c377aso828466a12.1;
        Fri, 28 Jun 2024 14:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719611856; x=1720216656; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gc58bCuKD2dmAdeHWtJnck9+Qu0bfD1uCcTjFgbgjiM=;
        b=XylFgA3g0P20fYs6DlZMIBRY/ywmmkTvS/aKypvkvA1hq929aSyck0mbAjFsbaFZ5m
         bJ3J0RMjfi4xtLqryce7poXtn9dXFSa9TmkXlaeCmhMd7GTjg0Jx8L+GmuAwA+4VxGbx
         7lY48xfZOt0IVlD2cRVGQMZMV4dFPm2lxP1gnUf0mS7DxJZ26Nf5/ijcWQvUCyezzjwS
         0RKzoEzwx3OccccHKo5oYpxyPJLyXZeRMLwvZL9BaZ8Jr3UXntKIk7nGKOFwcLbtsnUv
         m5JwRTNMfBQoz3wHNFL/GdFVvEKP0WdGViBJpc/5anI5OH2ZrC30eTSXscX39cAJded1
         SnJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719611856; x=1720216656;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gc58bCuKD2dmAdeHWtJnck9+Qu0bfD1uCcTjFgbgjiM=;
        b=SDq82w4xm+dkN63SLmIJGslzck0YH+ofJR1MDhCzKd5IPzL3/4iOPAcL1tkz0Ob8BX
         Wf4F8NFPUEJL51O4G8dlIUaJJyUntIsic4joPUSvIns4PonwQklRuOUZsVV0M0EYzyOw
         TjpyTaccDKij+564mokgGuokd5fUyf28vfNa4JvKDuvBOCtdAe7yTHxBF/vAoStYzuIL
         nRDc1yyUI8UeP3SkYEkeULahtH2W42lPpST5YlB5uJlPnvWXd5iVwCrqAw/v1RGtRGPQ
         n2jU3+/tRPsMK39dpkQLhGLDqrbbF0qoHNUyROPFI/9G2fH/EyfE9jKMpn/zgpgso8j3
         D5nA==
X-Forwarded-Encrypted: i=1; AJvYcCUCLUtwU0RsUQYh1jApbDgySUlEGye4qAZZ3W6z9agGbGiZzGKNqkHMLnwtAAq+kOfhsz5FRuxXY+jLidN2G0b+JKikPsnehVFIhxuwoA3VEA6aTlf8e6l3R4v97dbFY72G
X-Gm-Message-State: AOJu0YyeLlF9uR4nhMpBg6SqjUJibnViCmSGTBxgfSKaXWE2Bz7brqa9
	+Gk72rNQXwlSQKP5H5s0wUFUhDw5FF2DnNxYwc1CZHfZ+hUXUyL9
X-Google-Smtp-Source: AGHT+IEdNiXTH9w/0VCT4TBCXBZwNF9CYJyeNG2OhBtkqGCor1GK1MVpWTXbhY1OGVb8jMsrB3q6qA==
X-Received: by 2002:a05:6a20:3ca2:b0:1bd:234e:1d40 with SMTP id adf61e73a8af0-1bee48fe3c4mr5253347637.1.1719611855953;
        Fri, 28 Jun 2024 14:57:35 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7080246c8ffsm2123833b3a.62.2024.06.28.14.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 14:57:35 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 28 Jun 2024 11:57:34 -1000
From: Tejun Heo <tj@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
	David Vernet <void@manifault.com>
Subject: Re: [PATCH sched_ext/for-6.11 2/2] sched_ext: Implement
 scx_bpf_consume_task()
Message-ID: <Zn8xzgG4f8vByVL3@slm.duckdns.org>
References: <Zn4BupVa65CVayqQ@slm.duckdns.org>
 <Zn4Cw4FDTmvXnhaf@slm.duckdns.org>
 <CAADnVQJym9sDF1xo1hw3NCn9XVPJzC1RfqtS4m2yY+YMOZEJYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQJym9sDF1xo1hw3NCn9XVPJzC1RfqtS4m2yY+YMOZEJYA@mail.gmail.com>

Hello, Alexei.

On Thu, Jun 27, 2024 at 06:34:14PM -0700, Alexei Starovoitov wrote:
...
> > +__bpf_kfunc bool __scx_bpf_consume_task(unsigned long it, struct task_struct *p)
> > +{
> > +       struct bpf_iter_scx_dsq_kern *kit = (void *)it;
> > +       struct scx_dispatch_q *dsq, *kit_dsq;
> > +       struct scx_dsp_ctx *dspc = this_cpu_ptr(scx_dsp_ctx);
> > +       struct rq *task_rq;
> > +       u64 kit_dsq_seq;
> > +
> > +       /* can't trust @kit, carefully fetch the values we need */
> > +       if (get_kernel_nofault(kit_dsq, &kit->dsq) ||
> > +           get_kernel_nofault(kit_dsq_seq, &kit->dsq_seq)) {
> > +               scx_ops_error("invalid @it 0x%lx", it);
> > +               return false;
> > +       }
> 
> With scx_bpf_consume_task() it's only a compile time protection from bugs.
> Since kfunc doesn't dereference any field in kit_dsq it won't crash
> immediately, but let's figure out how to make it work properly.
> 
> Since kit_dsq and kit_dsq_seq are pretty much anything in this implementation
> can they be passed as two scalars instead ?
> I guess not, since tricking dsq != kit_dsq and
> time_after64(..,kit_dsq_seq) can lead to real issues ?

That actually should be okay. It can lead to real but not crashing issues.
The system integrity is going to be fine no matter what the passed in seq
value is. It can just lead to confusing behaviors from the BPF scheduler's
POV, so it's fine to put the onus on the BPF scheduler.

> Can some of it be mitigated by passing dsq into kfunc that
> was used to init the iter ?
> Then kfunc will read dsq->seq from it instead of kit->dsq_seq ?

I don't quite follow this part. bpf_iter_scx_dsq_new() takes @dsq_id. The
function looks up the matching DSQ and then the iterator remembers the
current dsq->seq which serves as the threshold (tasks queued afterwards are
ignored). ie. The value needs to be copied at that point to guarantee that
iteration ignores tasks that are queued after the iteration started.

> > +       /*
> > +        * Did someone else get to it? @p could have already left $dsq, got
> > +        * re-enqueud, or be in the process of being consumed by someone else.
> > +        */
> > +       if (unlikely(p->scx.dsq != dsq ||
> > +                    time_after64(p->scx.dsq_seq, kit_dsq_seq) ||
> 
> In the previous patch you do:
> (s32)(p->scx.dsq_seq - kit->dsq_seq) > 0
> and here
> time_after64().
> Close enough, but 32 vs 64 and equality difference?

Sorry about the sloppiness. It was originally u64 and then I forgot to
update here after changing them to u32. I'll add a helper for the comparison
and update both sites.

Going back to the sequence number barrier, it's a sort of scoping and one
way to solve it is adding an explicit helper to fetch the target DSQ's
sequence number and then pass it to the consume_task function. ie. sth like:

	barrier_seq = scx_bpf_dsq_seq(dsq_id);
	bpf_for_each(scx_dsq, p, dsq_id, 0) {
		...
		scx_bpf_consume_task(p, dsq_id, barrier_seq);
	}

This should work but it's not as neat in that it now involves three dsq_id
-> DSQ lookups. Also, there's extra subtlety arising from @barrier_seq being
different from the barrier seq that the scx_dsq iterator would be using.

As a DSQ iteration needs to have its own barrier sequence, maybe the answer
is to require passing it in as an explicit parameter. ie.:

	barrier_seq = scx_bpf_dsq_seq(dsq_id);
	bpf_for_each(scx_dsq, p, dsq_id, barrier_seq, 0) {
		...
		scx_bpf_consume_task(p, dsq_id, barrier_seq);
	}

There still are three dsq_id lookups but at least there is just one sequence
number in play. It is more cumbersome tho compared to the current interface:

	bpf_for_each(scx_dsq, p, dsq_id, 0) {
		...
		scx_bpf_consume_task(BPF_FOR_EACH_ITER, p);
	}

What do you think?

Thanks.

-- 
tejun

