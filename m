Return-Path: <bpf+bounces-9553-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B35B97990F8
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 22:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB9821C20CB9
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 20:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2908C30FA6;
	Fri,  8 Sep 2023 20:26:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE4130F96
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 20:26:25 +0000 (UTC)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815EC8E
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 13:26:24 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-41513d2cca7so76711cf.0
        for <bpf@vger.kernel.org>; Fri, 08 Sep 2023 13:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694204783; x=1694809583; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O2/KkuHa1swKMHIuQVh5aWKxZfJHHCKni8ZMZOLEOSY=;
        b=52kHZN+LmpuAJxUCxY/SGS9DLA0GMqSRNGzhUqNVJc3XzcR2Jlm0jwm5DQ2lueHeTl
         zNbS/4yFpvF6RpeT/OGdG6UICcy9GRfwijtN2wv8WOxIYT7lraBE0BwvNQgTZwA+1pRP
         p+jzevo0uF6OeOMYLDgHIqcL92UB0EMge128AznRuh3qbAzqcwggr/y1ITwxnJIFours
         aJKnEVDI1ldO/M8r4Hdyxhcdw+3Hh7du77yG/KemjBcdPvBHaJEsR2hiToAtka0L90tM
         phdtbKGqgWQ1qHmS+GNHbtEw4PiHLg28mpEUqwgJzpIY6wu/C/1g2JpiJnNd9Ol0+t5w
         UF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694204783; x=1694809583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O2/KkuHa1swKMHIuQVh5aWKxZfJHHCKni8ZMZOLEOSY=;
        b=PIHAo7kOHOGfNpexReBb4JMJQkufg+lRkNO6oBFs7hJVDcREtrH9KLjmcQwEWWs7UI
         uBwf9jf5aftFllCqRhx81EHJtWgpSNqZHPnK56TG0d1Zs2dbyDe/umtrQF4jiceBUmxz
         mJ6KZG0rbaJaW4TfvVY/0qeF2a5RxXZ5jPH0e6rU/3tnFr/AYrq/P73zPo8836MCFgqW
         n8PILDPHbCXPLNHZNH8W6rH7EsUwxtaoCDtF4c4t0BSz07JdBRfGIF2NJW7EL9n0BZg5
         SGbCsFNQKM+6Vgia4N3anw9tYV23JU0sh2oPb8w8mTfmB6xX4e8hvT1p9yqgeKgsw4ct
         HB6g==
X-Gm-Message-State: AOJu0YzqJJXdhY/anncwSvs1HenyWnF2ck4gzS/TuLADz77RcwvrqX7C
	fUJ3ArgqVCuB7VSfL1ZJJvyJxeEGUGUnDY82GquHfA==
X-Google-Smtp-Source: AGHT+IFZjC7Hd3ciCfpZuPYvhyAq+pZqpicznN6efwlyFKifdG5lIRGL3afr3p5ttECeps228YagcBHCDe6gqTofe9s=
X-Received: by 2002:a05:622a:309:b0:410:9cfe:339 with SMTP id
 q9-20020a05622a030900b004109cfe0339mr325721qtw.3.1694204783388; Fri, 08 Sep
 2023 13:26:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABk29NuQ4C-w_JA-zev796Nr_vx932qC4_OcdH=gMM6HZ_r4WQ@mail.gmail.com>
 <33f06fa6-2f4d-4e50-a87e-0d6604d3c413@paulmck-laptop>
In-Reply-To: <33f06fa6-2f4d-4e50-a87e-0d6604d3c413@paulmck-laptop>
From: Josh Don <joshdon@google.com>
Date: Fri, 8 Sep 2023 13:26:11 -0700
Message-ID: <CABk29Nva+c6oBZra6srWGcfxMEquOP30dReM-PgW_Wh+zKiBuQ@mail.gmail.com>
Subject: Re: BPF memory model
To: paulmck@kernel.org
Cc: Hao Luo <haoluo@google.com>, davemarchevsky@meta.com, Tejun Heo <tj@kernel.org>, 
	David Vernet <dvernet@meta.com>, Neel Natu <neelnatu@google.com>, 
	Jack Humphries <jhumphri@google.com>, bpf@vger.kernel.org, ast@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 8, 2023 at 1:43=E2=80=AFAM Paul E. McKenney <paulmck@kernel.org=
> wrote:
>
> On Thu, Sep 07, 2023 at 03:00:56PM -0700, Josh Don wrote:
> > Has there been any further interest in supporting additional
> > kernel-style atomics in BPF that you know of?
>
> This is one of the first that I have heard of.  ;-)
>
> But what BPF programs are you running that are seeing excessive
> synchronization overhead?  That will tell us which operations to
> start with.  (Or maybe it is time to just add the full Linux-kernel
> atomic-operations kitchen sink, but that would not normally be the way
> to bet.)

I'm writing BPF programs for scheduling (ie. sched_ext), so these are
getting invoked in hot paths and invoked concurrently across multiple
cpus (for example, pick_next_task, enqueue_task, etc.). The kernel is
responsible for relaying ground truth, userspace makes O(ms)
scheduling decisions, and BPF makes O(us) scheduling decisions.
BPF-BPF concurrency is possible with spinlocks and RMW, BPF-userspace
can currently only really use RMW. My line of questioning is more
forward looking, as I'm preemptively thinking of how to ensure
kernel-like scheduling performance, since BPF spinlock or RMW is
sometimes overkill :) I would think that barrier() and smp_mb() would
probably be the minimum viable set (at least for x86) that people
would find useful, but maybe others can chime in.

> > And on a different BPF note, one thing I wasn't sure about was the
> > ability of the cpu to reorder loads and stores across the BPF program
> > call boundary. For example, could the load of "z" in the BPF program
> > below be reordered before the store to x in the kernel? I'm sure that
> > no compiler barrier is ever necessary here since the BPF program is
> > compiled separately from the kernel, but I'm not sure whether a
> > hardware barrier is necessary.
> > <kernel>
> > x =3D 3
> > call_bpf();
> >   <bpf>
> >   int y =3D z;
>
> Given that a major goal of BPF is the ability to add low-overhead
> programs to code on fastpaths, I would not expect any implicit barriers
> in that case.  Consider for example counting the number of calls to a
> "hot" function in the Linux kernel, in which case adding full ordering
> would incur unacceptable performance degradation.  I would instead
> expect that the BPF program would need to add explicit barriers or
> ordered RMW operations.

Yep, that was my expectation as well. On the plus, this gives the
flexibility of only adding barriers where they are really needed.

Best,
Josh

