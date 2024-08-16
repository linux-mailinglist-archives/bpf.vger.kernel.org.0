Return-Path: <bpf+bounces-37388-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8D6955126
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 21:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91FD31C21D8E
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 19:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4CF1C3F25;
	Fri, 16 Aug 2024 18:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EH4AjhEI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4BA1C3789;
	Fri, 16 Aug 2024 18:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723834792; cv=none; b=BuZ1oKi+ueAD7cEmmXbVFheWg8+ms8ytv+TfBwqOS/+rA925a17Y2aoxiI0SZQY758O5PcFqLo9F1HwPVNQH2f9MRrT3iaePNyHLZQYAhheJmS50KIl7yA7wT4ipaZL9hjYEda53nHTw53j8vJs0Cow5u7T9/+VluIv/1LxgyZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723834792; c=relaxed/simple;
	bh=4Yzg7c/CZ85qholpkCUEy4P/KQB6OZ3FeBi5LrWFbbk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q6q/Y1baGiGXGunstiWehQue2nlFSeH3rrS2UITR1XjNU1pRnP+dafczqSc1FHtvzc1ae8H1buoUTZEa1bxYsjUXzw/Ycda8Iemi4vQtoGtc5sM0DTuyz6nWp36O6ueTAGFOyaisUAGCK11/5p0unaxLJqNODAG00ydUFQEeFRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EH4AjhEI; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5bed0a2b1e1so254284a12.3;
        Fri, 16 Aug 2024 11:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723834789; x=1724439589; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CzQwmTCKMwSBGPzG3fts6Mzndf5bNR3dhJ44QZWMkeE=;
        b=EH4AjhEI/uPrcr94s36DYgUdfnzcNOIipY/yQekZXn2q7+ebFFxafLirKuYYWmx9us
         Akg8dvQsIEXrYpOpK2x3UhYKl0PsdwcOpaTnP8OtZf/warQL/ujSc4SPLep2R6M/6qD+
         JoBrQlrQCUFJoKyxsiItHqabvNdaarv7JdVf0Iyr2dJh2Ck90tdJhb35iSg2c2oyxOt2
         2zjtYlTNAkZC443ddX2UzgMI1ib2U6AqeD+JP4MbB9zWApZqwQQOM25sFRxg8aT9AfHq
         F9izsb68StY05IMucMqR62vB1MOcqYuiDqeq/dKH1NBhpiBuNopia9k/0NTyDCQKXZuR
         aEwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723834789; x=1724439589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CzQwmTCKMwSBGPzG3fts6Mzndf5bNR3dhJ44QZWMkeE=;
        b=pWtaPTbcm21WXt6Hd4OtXR+HzuJdk1TcQm58mzUFwnm5rydb81D+xRGTBx8KLj7ALF
         09Ian0V2X5Tyjxtn3JuS+4Giq4lsmSI0afxjZK1Wf5UE+ZCrDBXnSlFX8a/QL/bvJhOH
         S0FAiHxwcQffkT+VIDVG4wLdc8p4+I6v438iCAs5TH8+wp1I6qNmASu5xkHNMb/Mbff2
         epF59W/PZbhh+YlaSwuFH4uSfJg4W53yUmL2oJcOsgWNHa/Vz5gTtgQRG9kbgzilwL5D
         vPhugWbNRTQOyEw4EsSlPS55MnLo27Dtd60BD49bL27eDzYW1ASAb5nIor8ltTaYL3bm
         nOlw==
X-Forwarded-Encrypted: i=1; AJvYcCVYxE6YF5jwVUJ+IFk/f+YlT15WIVchLmyILo/NXOT/KClwhQ0/HRLdVDH0YedCCkDgNa0FtQJ+TANN0nJscEbyAhVBxBjv9FMqKthwAQDkxOFRsKSaDTa1A+MlUkejpUt5
X-Gm-Message-State: AOJu0YwodBpALshHiTEPwC16YPiDcZNBw5s1PKrRw14TXPCXst7iKpJQ
	+XDYz58lfbhIKgM8G6KC+ZVWse2R12WrODmT2tNQe5dNqyJ0Yl+D8bJ7iw==
X-Google-Smtp-Source: AGHT+IHf+p6345HmNRauDr/u0Y2Ee/3wqYffIP4v81nBwT1erADerQ5ygjvzYzA1LeuTGqzQuw54mg==
X-Received: by 2002:a05:6402:3909:b0:5a2:80f:a6dd with SMTP id 4fb4d7f45d1cf-5beca5627a3mr2692542a12.14.1723834789004;
        Fri, 16 Aug 2024 11:59:49 -0700 (PDT)
Received: from krava (ip-94-113-247-30.net.vodafone.cz. [94.113.247.30])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bedb10a56csm302547a12.35.2024.08.16.11.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 11:59:48 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 16 Aug 2024 20:59:47 +0200
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Jiri Olsa <olsajiri@gmail.com>, Juri Lelli <juri.lelli@redhat.com>,
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Artem Savkov <asavkov@redhat.com>,
	"Jose E. Marchesi" <jose.marchesi@oracle.com>
Subject: Re: NULL pointer deref when running BPF monitor program (6.11.0-rc1)
Message-ID: <Zr-ho0ncAk__sZiX@krava>
References: <ZrCZS6nisraEqehw@jlelli-thinkpadt14gen4.remote.csb>
 <ZrECsnSJWDS7jFUu@krava>
 <CAADnVQLMPPavJQR6JFsi3dtaaLHB816JN4HCV_TFWohJ61D+wQ@mail.gmail.com>
 <ZrIj9jkXqpKXRuS7@krava>
 <CAADnVQ+NpPtFOrvD0o2F8npCpZwPrLf4dX8h8Rt96uwM+crQcQ@mail.gmail.com>
 <ZrSh8AuV21AKHfNg@krava>
 <CAADnVQLYxdKn-J2-2iXKKKTg=o6xkKWzV2WyYrnmQ-j62b9STA@mail.gmail.com>
 <Zr3q8ihbe8cUdpfp@krava>
 <CAADnVQL2ChR5hGAXoV11QdMjN2WwHTLizfiAjRQfz3ekoj2iqg@mail.gmail.com>
 <20240816101031.6dd1361b@rorschach.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816101031.6dd1361b@rorschach.local.home>

On Fri, Aug 16, 2024 at 10:10:31AM -0400, Steven Rostedt wrote:
> On Thu, 15 Aug 2024 14:37:18 +0200
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> 
> > > I checked bit more and there are more tracepoints with the same issue,
> > > the first diff stat looks like:
> > >
> > >          include/trace/events/afs.h                            | 44 ++++++++++++++++++++++----------------------
> > >          include/trace/events/cachefiles.h                     | 96 ++++++++++++++++++++++++++++++++++++++++++++++++------------------------------------------------
> > >          include/trace/events/ext4.h                           |  6 +++---
> > >          include/trace/events/fib.h                            | 16 ++++++++--------
> > >          include/trace/events/filelock.h                       | 38 +++++++++++++++++++-------------------
> > >          include/trace/events/host1x.h                         | 10 +++++-----
> > >          include/trace/events/huge_memory.h                    | 24 ++++++++++++------------
> > >          include/trace/events/kmem.h                           | 18 +++++++++---------
> > >          include/trace/events/netfs.h                          | 16 ++++++++--------
> > >          include/trace/events/power.h                          |  6 +++---
> > >          include/trace/events/qdisc.h                          |  8 ++++----
> > >          include/trace/events/rxrpc.h                          | 12 ++++++------
> > >          include/trace/events/sched.h                          | 12 ++++++------
> > >          include/trace/events/sunrpc.h                         |  8 ++++----
> > >          include/trace/events/tcp.h                            | 14 +++++++-------
> > >          include/trace/events/tegra_apb_dma.h                  |  6 +++---
> > >          include/trace/events/timer_migration.h                | 10 +++++-----
> > >          include/trace/events/writeback.h                      | 16 ++++++++--------
> > >
> > > plus there's one case where pointer needs to be checked with IS_ERR in
> > > include/trace/events/rdma_core.h trace_mr_alloc/mr_integ_alloc
> > >
> > > I'm not excited about the '_nullable' argument suffix, because it's lot
> > > of extra changes/renames in TP_fast_assign and it does not solve the
> > > IS_ERR case above
> > >
> > > I checked on the type tag and with llvm build we get the TYPE_TAG info
> > > nicely in BTF:
> > >
> > >         [119148] TYPEDEF 'btf_trace_sched_pi_setprio' type_id=119149
> > >         [119149] PTR '(anon)' type_id=119150
> > >         [119150] FUNC_PROTO '(anon)' ret_type_id=0 vlen=3
> > >                 '(anon)' type_id=27
> > >                 '(anon)' type_id=678
> > >                 '(anon)' type_id=119152
> > >         [119151] TYPE_TAG 'nullable' type_id=679
> > >         [119152] PTR '(anon)' type_id=119151
> > >
> > >         [679] STRUCT 'task_struct' size=15424 vlen=277
> > >
> > > which we can easily check in verifier.. the tracepoint definition would look like:
> > >
> > >         -       TP_PROTO(struct task_struct *tsk, struct task_struct *pi_task),
> > >         +       TP_PROTO(struct task_struct *tsk, struct task_struct __nullable *pi_task),
> > >
> > > and no other change in TP_fast_assign is needed
> > >
> > > I think using the type tag for this is nicer, but I'm not sure where's
> > > gcc at with btf_type_tag implementation, need to check on that  
> > 
> > Unfortunately last time I heard gcc was still far.
> > So we cannot rely on decl_tag or type_tag yet.
> > Aside from __nullable we would need another suffix to indicate is_err.
> > 
> > Maybe we can do something with the TP* macro?
> > So the suffix only seen one place instead of search-and-replace
> > through the body?
> > 
> > but imo above diff stat doesn't look too bad.
> 
> I'm fine with annotation of parameters, but I really don't want this
> being part of the TP_fast_assign() content. What would that look like
> anyway?

best option would be using btf_type_tag annotation, which would look like:

	-       TP_PROTO(struct task_struct *tsk, struct task_struct *pi_task),
	+       TP_PROTO(struct task_struct *tsk, struct task_struct __nullable *pi_task),

but gcc does not support that yet, just clang

so far the only working solution I have is adding '__nullable' suffix
to argument name:

	diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
	index 9ea4c404bd4e..fc46f0b42741 100644
	--- a/include/trace/events/sched.h
	+++ b/include/trace/events/sched.h
	@@ -559,9 +559,9 @@ DEFINE_EVENT(sched_stat_runtime, sched_stat_runtime,
	  */
	 TRACE_EVENT(sched_pi_setprio,
	 
	-	TP_PROTO(struct task_struct *tsk, struct task_struct *pi_task),
	+	TP_PROTO(struct task_struct *tsk, struct task_struct *pi_task__nullable),
	 
	-	TP_ARGS(tsk, pi_task),
	+	TP_ARGS(tsk, pi_task__nullable),
	 
		TP_STRUCT__entry(
			__array( char,	comm,	TASK_COMM_LEN	)
	@@ -574,8 +574,8 @@ TRACE_EVENT(sched_pi_setprio,
			memcpy(__entry->comm, tsk->comm, TASK_COMM_LEN);
			__entry->pid		= tsk->pid;
			__entry->oldprio	= tsk->prio;
	-		__entry->newprio	= pi_task ?
	-				min(tsk->normal_prio, pi_task->prio) :
	+		__entry->newprio	= pi_task__nullable ?
	+				min(tsk->normal_prio, pi_task__nullable->prio) :
					tsk->normal_prio;
			/* XXX SCHED_DEADLINE bits missing */
		),


now I'm trying to make work something like:

	diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
	index 9ea4c404bd4e..4e4aae2d5700 100644
	--- a/include/trace/events/sched.h
	+++ b/include/trace/events/sched.h
	@@ -559,9 +559,9 @@ DEFINE_EVENT(sched_stat_runtime, sched_stat_runtime,
	  */
	 TRACE_EVENT(sched_pi_setprio,
	 
	-	TP_PROTO(struct task_struct *tsk, struct task_struct *pi_task),
	+	TP_PROTO(struct task_struct *tsk, struct task_struct *__nullable(pi_task)),
	 
	-	TP_ARGS(tsk, pi_task),
	+	TP_ARGS(tsk, __nullable(pi_task)),
	 
		TP_STRUCT__entry(
			__array( char,	comm,	TASK_COMM_LEN	)


jirka

