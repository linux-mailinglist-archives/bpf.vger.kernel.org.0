Return-Path: <bpf+bounces-36477-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A45E9496B1
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 19:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2435A286F71
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 17:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69264AEF5;
	Tue,  6 Aug 2024 17:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFc1DjMY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4DC3D984;
	Tue,  6 Aug 2024 17:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722965199; cv=none; b=Pz3aGC/yq6AhoC8a2+vwPgJvbyjRitS1BT9/CcwjLTDOnHmpqUlH/aPNIYQXcA8EyRewA0+5OlXG0QTzAa/C+4LjPTIdo8bRWNeU2ygsuxrTtOlw6c29sYSXi64w4Y6DEYuIDy3bHS0R8olXcKdfMTM0uBqq0sh9lZnZuvvkqPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722965199; c=relaxed/simple;
	bh=HMPRMX12R6eOvtWfBaZTU/fH1BllL8R0dascJhuc85I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z6npEljxK01tSpDkps7rxHD78yvAxzwl6ZtQgqIxOg998uLe30sLyuiJ/vqdf0x0aEcm3lbz/Ixbin9CMy5vQs/kqFkVZ7ANBiAtbTToXosX6ndOaY2N1w87wMQ5iBukdwtnmnBGqXY69899GCFAkdYQqGOcYBv1F2o64tlY2ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lFc1DjMY; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70f5ef740b7so693080b3a.2;
        Tue, 06 Aug 2024 10:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722965197; x=1723569997; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f2pnVkniru5CoPEoFm4XT1qKCTw6sOWq0Ou4QzAPznI=;
        b=lFc1DjMYqF5NozjjEQL89M30MLmsyKUx9skA2xfYMJ4Enr+wz3/1Usv8zYSg33TpWY
         OOx8fkfy2pOvZg2/e3SRFtxE3oP8v6/elWGZszfo50wZGsJ/IO9mULaPRbG5mTB3w6fG
         0L6tblhbpNowvyhSYhR2E8ZEjtV/eKskVIvR1pfbKacFgx7AiABsrP+xM4h5dotsCZrc
         VEwTBpJpp3Yq+Q8MDVtegB+Ause31GFLWK9Jhavu/ySSC7cp8nd/+0h4HXyaYqXP+PXA
         J8C60ByQfs1ndEIjar/JaFGuJ+NrYxu8ZJ+bQwCTXoWfjwa4YYElHGqxj66gyQfCxcG/
         VXEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722965197; x=1723569997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f2pnVkniru5CoPEoFm4XT1qKCTw6sOWq0Ou4QzAPznI=;
        b=V6psm2tNtWGcbw307c6tAUADQK76TPolMx0I7mSEY/oH3NODtA+l0rKthImLkXrT5T
         9yqhqYznkIlq5HuNETkooG1dOvYDHUaG7t5HtgoN2xhw99T+oWL2cnyaoi57FEvhDOZX
         /Fai8q9QgtZfGXm5Li1QHly1SJjBCwbeBEgUgzyrIyYNgAvfvjtDNsyNRtsRxZvnDeN2
         lhZddd/G5y8Zb0iq9otqDllzDlZmElSUyB3M+MLIljTnVJtRXyE3nbSCRFFI3UuX4/Hz
         XhJDK/Ll6BiWeNK+82WRempduKH+4PwUzlzdVIxb7zjQNYGLsK15w/7pze2BZ2zvjtDz
         v1lQ==
X-Forwarded-Encrypted: i=1; AJvYcCVD8NoOh7KCP1OneuVnf3qcwXxBMIv1LBVc8szjGVOdj5qbN2wjtiaov3JYOAf09hSZFNuQgKjxndjyJuxW@vger.kernel.org, AJvYcCVnahJ2KJ3fxE9KSzfUysECsv0Gkdxm/O2TAqHOwcZ5MHqzmSPXB5j9ZDAAxvpU06nlpSdHCfn0nqk9AXqlkrbsjDvB@vger.kernel.org, AJvYcCVxh3L3J0ne+eUksacPK4/CLxsD12Imu2kZ2QbPVL3BG9N4E+lwftVqibnLGmkDEdKZuWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJZThXTjsKVMbSC1YVEMEAJQcD8uSfWcpAZczJc+ly5TwA8z9/
	O++z+EEYbjju/QBqnytGtIKlAn3szjDPpHsrFAGs4892IITa5jQGrW0Y5AFEvXXV1pWiRRLFjK3
	mTZJ/qTrLT5yUGACRA7qcLOlbd6I=
X-Google-Smtp-Source: AGHT+IHL0i9gBda7B+KBaowzKiYJQ5lO01ijNUCmYEemdZoNEj2e4g/b33BMAbMPNg7JYYk+8auHyi6Y/CwIYov6UKI=
X-Received: by 2002:a05:6a21:e90:b0:1c4:d0d9:50aa with SMTP id
 adf61e73a8af0-1c699582380mr20651863637.20.1722965197101; Tue, 06 Aug 2024
 10:26:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805202803.1813090-1-andrii@kernel.org> <ZrHSts7eySxHs4wh@krava>
In-Reply-To: <ZrHSts7eySxHs4wh@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 6 Aug 2024 10:26:25 -0700
Message-ID: <CAEf4Bzaq86fPVGWtXqvxLtbsk06coGBebnAO5YiuvuUF2v7++w@mail.gmail.com>
Subject: Re: [PATCH] uprobes: get rid of bogus trace_uprobe hit counter
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	rostedt@goodmis.org, mhiramat@kernel.org, peterz@infradead.org, 
	oleg@redhat.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 12:37=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Mon, Aug 05, 2024 at 01:28:03PM -0700, Andrii Nakryiko wrote:
> > trace_uprobe->nhit counter is not incremented atomically, so its value
> > is bogus in practice. On the other hand, it's actually a pretty big
> > uprobe scalability problem due to heavy cache line bouncing between CPU=
s
> > triggering the same uprobe.
>
> so you're seeing that in the benchmark, right? I'm curious how bad
> the numbers are
>

Yes. So, once we get rid of all the uprobe/uretprobe/mm locks (ongoing
work), this one was the last limiter to linear scalability.

With this counter, I was topping out at about 12 mln/s uprobe
triggering (I think it was 32 CPUs, but I don't remember exactly now).
About 30% of CPU cycles were spent in this increment.

But those 30% don't paint the full picture. Once the counter is
removed, the same uprobe throughput jumps to 62 mln/s or so. So we
definitely have to do something about it.

> >
> > Drop it and emit obviously unrealistic value in its stead in
> > uporbe_profiler seq file.
> >
> > The alternative would be allocating per-CPU counter, but I'm not sure
> > it's justified.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  kernel/trace/trace_uprobe.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> > index 52e76a73fa7c..5d38207db479 100644
> > --- a/kernel/trace/trace_uprobe.c
> > +++ b/kernel/trace/trace_uprobe.c
> > @@ -62,7 +62,6 @@ struct trace_uprobe {
> >       struct uprobe                   *uprobe;
> >       unsigned long                   offset;
> >       unsigned long                   ref_ctr_offset;
> > -     unsigned long                   nhit;
> >       struct trace_probe              tp;
> >  };
> >
> > @@ -821,7 +820,7 @@ static int probes_profile_seq_show(struct seq_file =
*m, void *v)
> >
> >       tu =3D to_trace_uprobe(ev);
> >       seq_printf(m, "  %s %-44s %15lu\n", tu->filename,
> > -                     trace_probe_name(&tu->tp), tu->nhit);
> > +                trace_probe_name(&tu->tp), ULONG_MAX);
>
> seems harsh.. would it be that bad to create per cpu counter for that?

Well, consider this patch a conversation starter. There are two
reasons why I'm removing the counter instead of doing per-CPU one:

  - it's less work to send out a patch pointing out the problem (but
the solution might change)
  - this counter was never correct in the presence of multiple
threads, so I'm not sure how useful it is.

Yes, I think we can do per-CPU counters, but do we want to pay the
memory price? That's what I want to get from Masami, Steven, or Peter
(whoever cares enough).

>
> jirka
>
> >       return 0;
> >  }
> >
> > @@ -1507,7 +1506,6 @@ static int uprobe_dispatcher(struct uprobe_consum=
er *con, struct pt_regs *regs)
> >       int ret =3D 0;
> >
> >       tu =3D container_of(con, struct trace_uprobe, consumer);
> > -     tu->nhit++;
> >
> >       udd.tu =3D tu;
> >       udd.bp_addr =3D instruction_pointer(regs);
> > --
> > 2.43.5
> >

