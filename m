Return-Path: <bpf+bounces-63617-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B36C3B0908A
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 17:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D5AD1C4534E
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 15:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590602F85E9;
	Thu, 17 Jul 2025 15:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILvzVPaH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1E32F85CD;
	Thu, 17 Jul 2025 15:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752766061; cv=none; b=uh3NhmoFGae3PxsdoIFsjNy8Maf5RYSqshBRY5UzaT/z6fiSc1yWTZyeroXoJ5jnxCaDQ1+6tMOzfURsJb/Ik2T0zccbuT8gqwOFFGmSEYDNu26oBJv/dYu0nnQUKQDurNhmSPRCqX27vMwiaZsTbtXqaKGEXKq+oVf3M5L+GI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752766061; c=relaxed/simple;
	bh=LhrFHpYsRnEHg0B/lmcoVHLZfq1NyHa1tH7Idp+Qoz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YbWBzKStLZ7uK39Gvv4+Ri+tFjF4vlS26GTGC16/PxVGO777FFgTMMu2OFrYnGD5ohjjnDt045XBuSRSuEfpIVLj78x6SzpaushfjoPK5UYI0dlVR0UmVDit2gTG25O/TOzmy9zpxUju71pVt1LFG8L7Jq81tcfh3doNlQxji1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ILvzVPaH; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a4f379662cso827861f8f.0;
        Thu, 17 Jul 2025 08:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752766058; x=1753370858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LhrFHpYsRnEHg0B/lmcoVHLZfq1NyHa1tH7Idp+Qoz0=;
        b=ILvzVPaHjISgRDF6EzAJI/fWPvKDbv6KKGi9ciReNN1vI//3fa3ht2zmsbijetCLoI
         QkRfIjjCdGm1SgwJQuqnyXMilwonM5n8oi4oOGxZRUE0ufrpfpPjm8QEdib1L3K2FTlo
         zZMYkn1NVU2NPLDxA8yYOFiinvzqM+Dw/vp3kRlspKguEUaN425po8rhqGk3vDI0gKx6
         eoeIrb6nJbZl2kiRFzlzb4mWuBkrzNCAO4GyEXEMshveQtYt7io8fnclIthZN4GD8+fi
         KJO9RoZ4NwKqWlLQVWQj54iyavVN3kWxETLqwLeOqzElYzyeld8GUZo5dCD5893X9jCJ
         VaeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752766058; x=1753370858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LhrFHpYsRnEHg0B/lmcoVHLZfq1NyHa1tH7Idp+Qoz0=;
        b=fICuIA56ig6/6Ck7Qh1M6G7zBEktZjUa2UEhnbXy7ldKhRjEq3bwusRq6zZXNSKMaE
         dQaCNbC5KggZzP8/vb718o+4upn1yQP4LAI7YY+9cge1spp2YDUYcyhJ060kUgi9/vbz
         4Ml48OoOAvQY/3bZvkPNGaeIdFgRWralgIQFAOudsSWZnU0s3C5Z8iX56Uq9fIv2Nl8l
         6ykP8gnuiAVTIs9PjeVgIOLanWnXbgppN3nIp2BJ7u3ss4j3ruBFObEUyR2Fne8z3g6V
         Zzqo6O8YX0m+0wijsw7bV0m3IbFe3XvdLR/J/nCP6nKlZLPjUkRJRjTRIv1OSxYUMjSd
         nJ4w==
X-Forwarded-Encrypted: i=1; AJvYcCUSOs64CliDIrdt2DstHmIWqS4NOQrYwHpla7xd6EQdTWFdI/kImlwbaPmZ90VbNikbhf9Q@vger.kernel.org, AJvYcCWV7KKNmrC7BjQXHmqoiGjsuJZCIhNYlesAE/enpGMW5GjTcuP9Hlaixu66xHDvhZW0yas=@vger.kernel.org, AJvYcCXrRaYFw0u3pWvdylnpQWVwFaLEjfKRd9EHEZmsLBv/7tVPQpgo91htkGB/6SCf6etUXWTE/UPRyNgv7I3e8calYkJD@vger.kernel.org
X-Gm-Message-State: AOJu0YxD0WdzOVzRsWTyBLg3TLKbubjVwBRociwyPjmlCoG09DIznwUD
	+Ezcp6idPwUqniggZgfgRzEHJbRKS2k7egXYKIOuuRi+C8+qihcBbrxNt7GeClbs6kpFuVTlAdK
	0QHvziFSxblK+Xvemp2OQ4oWuRHi1sKzHCQ==
X-Gm-Gg: ASbGncsXt048p+YEJ/36Es7a3yHEO2hjUP4e9YCQI/rMtWVHsNdAFqJq79u+w6v8lOj
	8ZI4AsyP2sYNvjruegi8gm3eYuGboNGoOe4QTunIfDuQVOOYMUX+gY/h04/iihJDM8c2Qn0HEfK
	A5va/VcuYcr42Nak2LXzTHRSQQoWS76HdLa6JSgya9mQN/stEkNN6vG+9SLQEauElOz4+fg8U9w
	9ZxgQMjqz3J5eJTQGxOVWs=
X-Google-Smtp-Source: AGHT+IG8k6sso9++qlBvVzKzU6GGWQpGnwuYDmx/VuR8lzCOZhOVTOskA3kl3KXW2xQF9DvJIDyU9xRvxYQr+HGx64U=
X-Received: by 2002:a05:6000:402a:b0:3a5:27ba:47c7 with SMTP id
 ffacd0b85a97d-3b60e50ff6amr6259702f8f.48.1752766058238; Thu, 17 Jul 2025
 08:27:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <03083dee-6668-44bb-9299-20eb68fd00b8@paulmck-laptop>
 <fa80f087-d4ff-4499-aec9-157edafb85eb@paulmck-laptop> <29b5c215-7006-4b27-ae12-c983657465e1@efficios.com>
 <acb07426-db2f-4268-97e2-a9588c921366@paulmck-laptop> <ba0743dc-8644-4355-862b-d38a7791da4c@efficios.com>
 <512331d8-fdb4-4dc1-8d9b-34cc35ba48a5@paulmck-laptop> <bbe08cca-72c4-4bd2-a894-97227edcd1ad@efficios.com>
 <16dd7f3c-1c0f-4dfd-bfee-4c07ec844b72@paulmck-laptop> <20250716110922.0dadc4ec@batman.local.home>
 <895b48bd-d51e-4439-b5e0-0cddcc17a142@paulmck-laptop> <bb20a575-235b-499e-aa1d-70fe9e2c7617@paulmck-laptop>
 <e8f7829c-51c9-494a-827a-ee471b2e17cd@efficios.com> <CAADnVQL7gz3OwUVCzt7dbJHvZzOK1zC4AOgMDu5mg6ssKuYU6Q@mail.gmail.com>
 <20250717111216.4949063d@batman.local.home>
In-Reply-To: <20250717111216.4949063d@batman.local.home>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 17 Jul 2025 08:27:24 -0700
X-Gm-Features: Ac12FXzFRC8adLl7CZkn_RpMEeWocBjx5K-fqVR_zZuPS6uWVV2ffn0TRaEQxn4
Message-ID: <CAADnVQ+r8=Nw0fz8huFHDNe2Z6UnQNyqXW1=sMOrOGd8WniTyw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] rcu: Add rcu_read_lock_notrace()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Boqun Feng <boqun.feng@gmail.com>, 
	linux-rt-devel@lists.linux.dev, rcu@vger.kernel.org, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, 
	Frederic Weisbecker <frederic@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Josh Triplett <josh@joshtriplett.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Uladzislau Rezki <urezki@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 8:12=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Thu, 17 Jul 2025 07:57:27 -0700
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>
> > I still don't understand what problem is being solved.
> > As current tracepoint code stands there is no issue with it at all
> > on PREEMPT_RT from bpf pov.
> > bpf progs that attach to tracepoints are not sleepable.
> > They don't call rt_spinlock either.
> > Recognizing tracepoints that can sleep/fault and allow
> > sleepable bpf progs there is on our to do list,
> > but afaik it doesn't need any changes to tracepoint infra.
> > There is no need to replace existing preempt_disable wrappers
> > with sleepable srcu_fast or anything else.
>
> From the PREEMPT_RT point of view, it wants BPF to be preemptable. It
> may stop migration, but if someone adds a long running BPF program
> (when I say long running, it could be anything more than 10us), and it
> executes on a low priority task. If that BPF program is not preemptable
> it can delay a high priority task from running. That defeats the
> purpose of PREEMPT_RT.
>
> If this is unsolvable, then we will need to make PREEMPT_RT and BPF
> mutually exclusive in the configs.

Stop this fud, please.

bpf progs were preemptible for years and had no issue in RT.
tracepoints are using preempt_disable() still and that's a
tracepoint infra problem. Nothing to do with users of tracepoints.

