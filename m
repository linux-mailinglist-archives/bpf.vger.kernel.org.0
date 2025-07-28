Return-Path: <bpf+bounces-64524-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D7EB13D11
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 16:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 575F13A5A5F
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 14:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF1926E6EB;
	Mon, 28 Jul 2025 14:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jd622B/o"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f194.google.com (mail-yb1-f194.google.com [209.85.219.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D24212B3D;
	Mon, 28 Jul 2025 14:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753712800; cv=none; b=DdZEEaSnDZcZROF201LX5PpdtK4v6vSo0QUeXDVZefZQpgKQBtkdms0Yu3j88NNuGvFARfQpXWiuKf876JobPfYEe7YSgw5WI1Yp0vWnakVvtONKk5ABSqZwQHyZ+GauqltO2hOAD2zK+cOuqiOe7mZLfcXPxKlzZWBRyIUCX2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753712800; c=relaxed/simple;
	bh=eyUD4zVX3UqOFr/Qm++GfTVu2nBcqq2i0qsiYTDDWAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cv3c+FtHAukzqjTzBKu1ebolh7qde5pfZSJ78AN0kcYbvD8r6yGdkG51EQvLfRemYuFRV+0MAfqpPJVQiQM+M9YQQL2cMbXAqa5bi7q0TvEJWK9VBor31xAGyKOGWy2USNYYrgzoTnyBPjAxv8x5CXvX9zmfcyzaFrGNSvrQSIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jd622B/o; arc=none smtp.client-ip=209.85.219.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f194.google.com with SMTP id 3f1490d57ef6-e8bbb605530so4260314276.0;
        Mon, 28 Jul 2025 07:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753712798; x=1754317598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LG4Q2CXpb5TPSjLW0g9Uo8USQ0VGQIBOukvZjuFnm+I=;
        b=jd622B/oGnoDJSiInyMsbkg1ZZUbA8SBJs/P7KyVakYxu49noZOUQ4VNklGsxZKYE6
         xMNVUxRm0XoRhcFV1Dtnrxv8Tm044rqihUZHpCo+pqroFYqoYKFyKNPmcbU9Ei20iW90
         cjFoPRu+4oOjd+YJSiiTLuc0d+yUyB6nfILzfhqMofUL46uUBk4vPVeVeuBbJQ809c8v
         pQ3ZzJZgFD9Gss+I9ZGykJj2eX84jcNG+PqFTPLf96DThXisNrNwZLH78k/lOTOznjfD
         UnoRAkOFbL8IPrCoRrFjvsh83UDXC46yUr9HhtaArx4G/TD/LE0JtjSnJJEPGRd4hjXm
         VWTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753712798; x=1754317598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LG4Q2CXpb5TPSjLW0g9Uo8USQ0VGQIBOukvZjuFnm+I=;
        b=wGue5b2+AlykGMVzJao3v7ghODuh6DAdoEAjmu2v6oCi63efOOkD50Vm1oaaEyN9G5
         j/PrvVkd/r7+j3zcxYU4MHlUvkowVAd1jlpfOZTNWMiYT7TDmzcnaaP3Omn5wPMvcZEE
         Aeebwrt82dCgE/cGwEtP9BGsSCZR9xNwTO/RR+4OIEQH6ykGuTpxNLGNrK66se0Dc2NI
         6eWSYVxTEZNcsH1OKkgbKUllck4Nc7P4zV/FgjimqjkzlA55YMc18S8+Po+YlmHT40V4
         C5KSNU1utGF3eBH7oqCWgKZ85Wozo0wN8RbAp85y0AmsFGXLHrmEcl+OqlBJ+6MqdYRN
         zaJw==
X-Forwarded-Encrypted: i=1; AJvYcCUdAJXQxHJic2pcotCyxSVbPunQh7kN5jweXeRJPy/XsefHUCrEqdl1EbLn73yQnLAmIH4=@vger.kernel.org, AJvYcCVfTxN2UokS3OmIB0JXa5OyYSOzFvpLCc6jHiWerOZEgrB9oiVSk7bQrvj94n3V1UjrRExS93lmI75KyjnK@vger.kernel.org, AJvYcCW7ayZt8kDiBhzczMidVj5bH+RSKkpV0OtukFkYoJnEx+GF3o524fS2PlsL2+XsrcUC4iIlYFLRuMLfvqKONsehSM7L@vger.kernel.org
X-Gm-Message-State: AOJu0YxQBSgbqGAq17aa62s0xcze/74pnRaERJb3aQ+TToJVQP7G+SJV
	pLmWOmhzFu9geUO93mrMmYN+F+8lH6ddi8BrSt3qfBJKLkH6Bgp1WdVy7+2tw5GuoJNPmglnbEu
	2XfXjuc1XmpQgKiNqwn0oZ+3VjXFUQyTwXO2KP/s=
X-Gm-Gg: ASbGncvtWAJ29bmv7nK4h4YgT2hyJF5/Ykc0dYlSKRS2NoGMu9dTMYM1d6D30szWxn3
	AK0BX/t6lWXv7l+vI453kp0wNTm0XCRs+xYMGXhqSc8sYwrqTATJLnaYchSNCOQaOX7ZSrTVbxI
	uJEaZlKaXaAMmmY7cn/nJrpHGRkop+U/0IOn6VgISrnx0X6fR8Be8Bw2ITl1M/TXlyZfizvW0BC
	+Dx80o=
X-Google-Smtp-Source: AGHT+IF7oO3TKRzzMn/elYJeaf3mlB7NM77NoxnnINrb5WH9Df+24p7rSMGC4b1KHp+hZLSJDPdQOOITwpwGWQ1FN9g=
X-Received: by 2002:a05:6902:160e:b0:e87:a1f2:5ccb with SMTP id
 3f1490d57ef6-e8de2113acemr17709352276.19.1753712798175; Mon, 28 Jul 2025
 07:26:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728072637.1035818-1-dongml2@chinatelecom.cn> <20250728213502.df49c01629de5fe9b6f15632@kernel.org>
In-Reply-To: <20250728213502.df49c01629de5fe9b6f15632@kernel.org>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Mon, 28 Jul 2025 22:26:27 +0800
X-Gm-Features: Ac12FXzloI0foczJuPDfIn9760hHJBVVEX7jn-psOfa7NR9BMDir5SdN42uxhOU
Message-ID: <CADxym3b=-tGOVqnoPeDb0q3EZZ-DMjkM0fiaSS6=Q+y07azYMg@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v2 0/4] fprobe: use rhashtable for fprobe_ip_table
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: alexei.starovoitov@gmail.com, rostedt@goodmis.org, 
	mathieu.desnoyers@efficios.com, hca@linux.ibm.com, revest@chromium.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 8:35=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
>
> Hi Menglong,
>
> What are the updates from v1? Just adding RFC?

No, the V1 uses rhashtable, which is wrong, and makes the
function address unique in the hash table.

And in the V2, I use rhltable instead, which supports duplicate
keys.

Sorry that I forgot to add the changelog :/

>
> Thanks,
>
> On Mon, 28 Jul 2025 15:22:49 +0800
> Menglong Dong <menglong8.dong@gmail.com> wrote:
>
> > For now, the budget of the hash table that is used for fprobe_ip_table =
is
> > fixed, which is 256, and can cause huge overhead when the hooked functi=
ons
> > is a huge quantity.
> >
> > In this series, we use rhltable for fprobe_ip_table to reduce the
> > overhead.
> >
> > Meanwhile, we also add the benchmark testcase "kprobe-multi-all", which
> > will hook all the kernel functions during the testing. Before this seri=
es,
> > the performance is:
> >   usermode-count :  875.380 =C2=B1 0.366M/s
> >   kernel-count   :  435.924 =C2=B1 0.461M/s
> >   syscall-count  :   31.004 =C2=B1 0.017M/s
> >   fentry         :  134.076 =C2=B1 1.752M/s
> >   fexit          :   68.319 =C2=B1 0.055M/s
> >   fmodret        :   71.530 =C2=B1 0.032M/s
> >   rawtp          :  202.751 =C2=B1 0.138M/s
> >   tp             :   79.562 =C2=B1 0.084M/s
> >   kprobe         :   55.587 =C2=B1 0.028M/s
> >   kprobe-multi   :   56.481 =C2=B1 0.043M/s
> >   kprobe-multi-all:    6.283 =C2=B1 0.005M/s << look this
> >   kretprobe      :   22.378 =C2=B1 0.028M/s
> >   kretprobe-multi:   28.205 =C2=B1 0.025M/s
> >
> > With this series, the performance is:
> >   usermode-count :  902.387 =C2=B1 0.762M/s
> >   kernel-count   :  427.356 =C2=B1 0.368M/s
> >   syscall-count  :   30.830 =C2=B1 0.016M/s
> >   fentry         :  135.554 =C2=B1 0.064M/s
> >   fexit          :   68.317 =C2=B1 0.218M/s
> >   fmodret        :   70.633 =C2=B1 0.275M/s
> >   rawtp          :  193.404 =C2=B1 0.346M/s
> >   tp             :   80.236 =C2=B1 0.068M/s
> >   kprobe         :   55.200 =C2=B1 0.359M/s
> >   kprobe-multi   :   54.304 =C2=B1 0.092M/s
> >   kprobe-multi-all:   54.487 =C2=B1 0.035M/s << look this
> >   kretprobe      :   22.381 =C2=B1 0.075M/s
> >   kretprobe-multi:   27.926 =C2=B1 0.034M/s
> >
> > The benchmark of "kprobe-multi-all" increase from 6.283M/s to 54.487M/s=
.
> >
> > The locking is not handled properly in the first patch. In the
> > fprobe_entry, we should use RCU when we access the rhlist_head. However=
,
> > we can't use RCU for __fprobe_handler, as it can sleep. In the origin
> > logic, it seems that the usage of hlist_for_each_entry_from_rcu() is no=
t
> > protected by rcu_read_lock neither, isn't it? I don't know how to handl=
e
> > this part ;(
> >
> > Menglong Dong (4):
> >   fprobe: use rhltable for fprobe_ip_table
> >   selftests/bpf: move get_ksyms and get_addrs to trace_helpers.c
> >   selftests/bpf: skip recursive functions for kprobe_multi
> >   selftests/bpf: add benchmark testing for kprobe-multi-all
> >
> >  include/linux/fprobe.h                        |   2 +-
> >  kernel/trace/fprobe.c                         | 141 ++++++-----
> >  tools/testing/selftests/bpf/bench.c           |   2 +
> >  .../selftests/bpf/benchs/bench_trigger.c      |  30 +++
> >  .../selftests/bpf/benchs/run_bench_trigger.sh |   2 +-
> >  .../bpf/prog_tests/kprobe_multi_test.c        | 220 +----------------
> >  tools/testing/selftests/bpf/trace_helpers.c   | 230 ++++++++++++++++++
> >  tools/testing/selftests/bpf/trace_helpers.h   |   3 +
> >  8 files changed, 348 insertions(+), 282 deletions(-)
> >
> > --
> > 2.50.1
> >
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

