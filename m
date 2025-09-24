Return-Path: <bpf+bounces-69528-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E70DAB993B0
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 11:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B4BE16E3A8
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 09:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE212D9EC2;
	Wed, 24 Sep 2025 09:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBmDAu54"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90801E520E
	for <bpf@vger.kernel.org>; Wed, 24 Sep 2025 09:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758707281; cv=none; b=IveUIVHxfCnCFIo2AOthetAsjHGRdpW5HLZQJitEMrPfho9x7PgMVNWC90DfQaVaj8zn/yL3YwRtS3UFupyRwuP41xaTX8S8nZVFCYb9+wsF1zHELi4Ys3kMMFJG7ryz/ESOuoq8qmktmbhv/5oOsfiFqZCcbAJgW99WkBrKj7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758707281; c=relaxed/simple;
	bh=clfk60SyfYqZmt5Z+z2CI7XpK9tr1yr5nZ4/ERZNp8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sAX9is3RDnBwjpBL/k2SJ3Wd/Na8NptkvCVSBA3Km9u3nWTHXgE79GnGB2lhXMv5ikm30h/V0TsJVU/oa9J0y11F6ciPBD5JbWrWCKk9hQ0hmvRDnikqftH2hrh1zzoZSiXLlpqe7ls7CtrkNHSfcnFlo8Z/bG1xbN/CVC/6cX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TBmDAu54; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3fc36b99e92so441924f8f.0
        for <bpf@vger.kernel.org>; Wed, 24 Sep 2025 02:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758707273; x=1759312073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+/yAQIJHy6zgxStgmA8+woCe8XjoAU5txYeFqYzfH0=;
        b=TBmDAu54boe1929wX6EsDoCVrvE/jUZZAnve83MwzzbSDage2TOPdDqeiu57zquv89
         MsQ2vmzbzwFb6EtVKBxHdmYCX7iR7tztLSaV9vdcpOAc4OmXNtxxgZlPXxHzKd5bo2Yv
         2AifCbs0RUr8mfArXWqlLsN+yYOYF8SNZh1b/d4/3vAcrYsUCT9mNUGywXjkKJQmmxpl
         phRRS/PM5vSb3P93bJ9Z8URbPvnX1ibRokI6wn0haVwhsgc7raTD5xT7snLrTGbLYgQz
         tJUuorK+PJl7YBvkNhSwdU1h/gHx9baE8/+7Aurprb7nsx8coYfuBzdfN6YklgJ1Oe7f
         Tosw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758707273; x=1759312073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v+/yAQIJHy6zgxStgmA8+woCe8XjoAU5txYeFqYzfH0=;
        b=HEP1jbkSbeqgFbv8T1V8Jey5n/nHcXL0m+sOBYfeZ5zcpBF9+YDnItek5+P0+GDn/m
         T8GD0rfnVPtmkrLYMTIO/AXrYyJGGrmtXNNufCNrHwJ8NQuaEcC0FMyBKBYPKFnLjO4P
         7Yc+aDXazXNBctUiAOogSMOUd0XhtYz0CrMk9ocIFj2v1sPH8lvXnoMxVDYvmmzYG9Ym
         H+BwjyhyFVXyUiWh4elq1EqTJ8IIargEvvHYMDxaapgFI8bGSGNnhEnUCVRlDcWCun+Q
         PCNWhSksgscF2V65Qe2lJoyqJltKkLOclwV8swKTixKVg4OvtvDQhIjqXZpcyHeT6yQh
         NTCg==
X-Forwarded-Encrypted: i=1; AJvYcCUj/nBbFzYlw7UB2e77/1xsvw+JClkfUsd8Flfw6WElsGaA25BACBMTxAwsJcgZ6RZPK/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjeNpxR6KHPB+OrNxb+Fh/btFw3aqmNH1Iz0/+7n3+l4n+hpAF
	162a806KhPkzG8YKXS9CQzCRDeauLqAsFwMxRqibVIyP7WCvXTIbsZb1W3qd1R62gSNMrBSeL6/
	3NO64+JID3AsmapEWdrL6XYbwUzEzwuJRNw1F
X-Gm-Gg: ASbGncsDU2G4OzWg5WnMTmOXwsXayPeOeczveWR9yEJNPZO6r2ZvTdqs3t4uWLl4/jT
	bbzWwE5op3BDYGDcSoQm1UmrP8IuBV49V9rcVgql/FSNDHqxjuTX9JKcDygHfmsvfKPKByVXvDq
	G7SiWgb5OTtS+H5BmEM1e38xxn81EohDMXX/09PXFFZzVNRM8npqIgX2BYEbfv+DpLx26sQkrXv
	bmKT/RiHxMXYWtJ6qg=
X-Google-Smtp-Source: AGHT+IGNEyOFTkhhfZ+ODCUH/TtmGTf98EryrfgpvlPOBPzYZ9gdhhQMDlm+uYotpfaf5G/L0rt+YloNfDg3NmGpD8g=
X-Received: by 2002:a5d:5d84:0:b0:3fc:54ff:edbb with SMTP id
 ffacd0b85a97d-40abe09400fmr1871286f8f.9.1758707273143; Wed, 24 Sep 2025
 02:47:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916215301.664963-1-jolsa@kernel.org> <20250916215301.664963-3-jolsa@kernel.org>
 <CAEf4BzYTJcq=Kk6W9Gz90gM=mw2fS2T-QBurUhdjBNinReDSjQ@mail.gmail.com> <20250924084956.GW3245006@noisy.programming.kicks-ass.net>
In-Reply-To: <20250924084956.GW3245006@noisy.programming.kicks-ass.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 24 Sep 2025 11:47:42 +0200
X-Gm-Features: AS18NWAjVTpnvN9YoNCHY8qLaBt16TRzfs-v53h1ST40PSwW1aqo1PKnsvSDwoI
Message-ID: <CAADnVQJ6CFD6D9gDb5R=ZnAiXVVJxMe+V3Mv+qniwD13-28MTQ@mail.gmail.com>
Subject: Re: [PATCHv4 bpf-next 2/6] uprobe: Do not emulate/sstep original
 instruction when ip is changed
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ingo Molnar <mingo@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 11:15=E2=80=AFAM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
>
> On Tue, Sep 16, 2025 at 03:28:52PM -0700, Andrii Nakryiko wrote:
> > On Tue, Sep 16, 2025 at 2:53=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wr=
ote:
> > >
> > > If uprobe handler changes instruction pointer we still execute single
> > > step) or emulate the original instruction and increment the (new) ip
> > > with its length.
> > >
> > > This makes the new instruction pointer bogus and application will
> > > likely crash on illegal instruction execution.
> > >
> > > If user decided to take execution elsewhere, it makes little sense
> > > to execute the original instruction, so let's skip it.
> > >
> > > Acked-by: Oleg Nesterov <oleg@redhat.com>
> > > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  kernel/events/uprobes.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > > index 7ca1940607bd..2b32c32bcb77 100644
> > > --- a/kernel/events/uprobes.c
> > > +++ b/kernel/events/uprobes.c
> > > @@ -2741,6 +2741,13 @@ static void handle_swbp(struct pt_regs *regs)
> > >
> > >         handler_chain(uprobe, regs);
> > >
> > > +       /*
> > > +        * If user decided to take execution elsewhere, it makes litt=
le sense
> > > +        * to execute the original instruction, so let's skip it.
> > > +        */
> > > +       if (instruction_pointer(regs) !=3D bp_vaddr)
> > > +               goto out;
> > > +
> >
> > Peter, Ingo,
> >
> > Are you guys ok with us routing this through the bpf-next tree? We'll
> > have a tiny conflict because in perf/core branch there is
> > arch_uprobe_optimize() call added after handler_chain(), so git merge
> > will be a bit confused, probably. But it should be trivially
> > resolvable.
>
> Nah, I suppose that'll be fine. Thanks!

Thanks! Applied.

Jiri,
in the future, please keep the whole history in the cover letter.
v1->v2, v2->v3. Just v4 changes are nice, but pls copy paste
previous cover letters and expand them.
Also please always include links to previous versions in the cover.
Search on lore sucks. Links in the cover are a much better
way to preserve the history.

