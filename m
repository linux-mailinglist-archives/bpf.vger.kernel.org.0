Return-Path: <bpf+bounces-63625-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB6DB09145
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 18:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4078617E2DA
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 16:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0122F85FE;
	Thu, 17 Jul 2025 16:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZ6yB9Tx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1481B4247;
	Thu, 17 Jul 2025 16:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752768175; cv=none; b=ZUkggUBy5sY9LD/S/U0QGhvbCiCDhmadLYz4wWu45LuSmUaMwxdXLudWBG2ziVNSoN5RfRC11aZ7KS9kMsbO8o+VlO9KvN6t0VEqWDZ2EH+c+fcZsGZDh4OhHNKfqHRLAeaWbUs9knLcnOhZDjU1Gs9/K9Jo0KeizwEFchuuM8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752768175; c=relaxed/simple;
	bh=PpIKhPkuTBZsQ5kxbdtQhT24tOu7PD+2oAMj04jaeFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Aa30fPDv4WZLFiAKrySSwa+MxXZcCcGP/uBFFsT9EGE/6q0YCNNulOOGdLm4Cgm7ZiUemumNbS6jCIBdtaGBWdv9lqp1qKwiMGTDVBhx+SysKOINR3rCmlS4iLGFEqOUSdLp/nPL+UL0Wx3vVfOeAM8tV/8zD/WQZhsfX4du6ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZ6yB9Tx; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a50fc7ac4dso533546f8f.0;
        Thu, 17 Jul 2025 09:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752768172; x=1753372972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PpIKhPkuTBZsQ5kxbdtQhT24tOu7PD+2oAMj04jaeFY=;
        b=kZ6yB9TxWLXwME7CzjhTY8Daz3LHgfoKZpbGLjy2VMfek4yRYQbezDsoNZDtNj65zJ
         cVd9/bUzjRmDcYpR6wNJkxIMvkCQy2ipsGGHHGzEBWvOAzeCxuScrvTqnAI2+rwm7tan
         MhTjmv7DtDg9SlneF23b8UOwbE24kmOkb29c02QoojpMxDdJg7e8RSm9W5IwW6NckTGY
         vk+k1Hg9yJraLFZ3dnFbYVR3os1KPFKlHMYHa21gLgUIuD+qQHJYIFpRhFSvGuD3Tf9Q
         yE4WuqzdbKIKQ6eg738wt41U0M09ZSiKrjcWFwjm4VV6fr1OVBehWvR2k+O6WiLi4pSL
         JVSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752768172; x=1753372972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PpIKhPkuTBZsQ5kxbdtQhT24tOu7PD+2oAMj04jaeFY=;
        b=Fpd6l6fLqoSH1R5YMaEaMhjpNsjPjt8elTpm7pF85CntdRq+7NoCHf04nMaE04Rpnl
         59gsxDfD9hF8esJtS8fh+YVrYpNSIuaDzicq/PN0QWZK5t1noX+td43mN5HbBjq3T0y1
         w6HJav2zKaWDYCXeZTgEQKbDi9QXIaktYAL5D8IY57s3sbaawsXkle+q7HZXH0zwuhbY
         /dvIz8UEWU7bFjPB3S2d7Sk/2FqYBxv+xHGHBthflSygyMb1dygvUHvIUyaR6MYzay5E
         LMRjOjgIvsum2qiLaC32XzUlmToL/Hw1dTgvLYuh7/cHOQCUPtGvYksbpwOW989uzq5G
         421A==
X-Forwarded-Encrypted: i=1; AJvYcCVktWOj2Lp3sTC2Q3M0ybu/mWX08fXvEZkVpAqFNKkSwsEuCbSHzvwzbiHksrCt/HBHfLG4wRauXfh+GG3iONcoLLRE@vger.kernel.org, AJvYcCWtI9jXuSFHP0YqdBT8OF8pIxplTwgvwa9SXCIYnX2IB22DTWZS8dafNN6DzLieSh3wBZQ=@vger.kernel.org, AJvYcCXh0zAufarptHHKQ+ChuR+eUFUTM7AC3q8BPvqYL8rf44nVuY68AYSLSJOofXWJFHrPl5Bn@vger.kernel.org
X-Gm-Message-State: AOJu0YwrqgUv3J/lthI2h7Z5uLsewHiXQg+ULOAs2SKLmLJo05oAgdwB
	0pwF9PCoot8OabUfjAtoxQxx+6BD2IMwzRYwr9T4M8cjPq73yX8yuRl52WbY7wSgJNR2XO7jZIc
	oAjDn/8+PkfUGQXSw3+yHjIohIl36BuI=
X-Gm-Gg: ASbGncsbBE7/jxJJ+NxbGb8OU6sgcIQ41L74NPx7uRfJDK9m5cbcyqlCdQVuLcIBxDg
	S4wh4ac9ur4bKgjhuKpBiRGL7E4psMYR7wcJyWX8hC+AMljJ4OQQyb0z58VRPTVZ3UgBb1TWjgd
	WWiv2K+2ZYCj0RQGrgeudqOtoKYN3r++XlLnoC7q4R07GoN08h5HqiW0KMX3gnjdBr3h22lWZOW
	cL4WQUJfJoox1wCOgTN7H8=
X-Google-Smtp-Source: AGHT+IFB4oRhHjPDrVl/yc1f8/SNaiIEVoiambFQLKPb9Ka8HTUWzSv/GsYGujgIC/fTAKitGtlYz5Wg0UkXv7BSCEM=
X-Received: by 2002:a05:6000:5c2:b0:3a5:39bb:3d61 with SMTP id
 ffacd0b85a97d-3b613e982e0mr2719922f8f.27.1752768171242; Thu, 17 Jul 2025
 09:02:51 -0700 (PDT)
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
 <20250717111216.4949063d@batman.local.home> <CAADnVQ+r8=Nw0fz8huFHDNe2Z6UnQNyqXW1=sMOrOGd8WniTyw@mail.gmail.com>
 <20250717114028.77ea7745@batman.local.home> <20250717115510.7717f839@batman.local.home>
In-Reply-To: <20250717115510.7717f839@batman.local.home>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 17 Jul 2025 09:02:38 -0700
X-Gm-Features: Ac12FXxVEaQJhegtSLdy4TSHsSZ0PotohWhyaCvWLso-UyfRoShy-xNEqM3ocnY
Message-ID: <CAADnVQJwpM=DfWjYe12pbx=Yb9NR5MRktzwgV_ALjLqMR3w9nw@mail.gmail.com>
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

On Thu, Jul 17, 2025 at 8:55=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Thu, 17 Jul 2025 11:40:28 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > Yes, it is a tracepoint infra problem that we are trying to solve. The
> > reason we are trying to solve it is because BPF programs can extend the
> > time a tracepoint takes. If anything else extended the time, this would
> > need to be solved as well. But currently it's only BPF programs that
> > cause the issue.
>
> BTW, if we can't solve this issue and something else came along and
> attached to tracepoints that caused unbounded latency, I would also
> argue that whatever came along would need to be prevented from being
> configured with PREEMPT_RT. My comment wasn't a strike against BPF
> programs; It was a strike against something adding unbounded latency
> into a critical section that has preemption disabled.

Stop blaming the users. Tracepoints disable preemption for now
good reason and you keep shifting the blame.
Fix tracepoint infra.

