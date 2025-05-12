Return-Path: <bpf+bounces-58066-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C82ACAB473F
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 00:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3027219E55DB
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 22:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17EA2299AB2;
	Mon, 12 May 2025 22:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egu2svIu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAEFB660;
	Mon, 12 May 2025 22:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747088838; cv=none; b=q0v5YFRbwXpxZP/euBrnLBoh4W3vGo6T5TYIX0Qmp+sr0BhMXTlCKMPyFRnrsb7iMsfZ0bVVigMfhlRgMUOSK2KC4f+Z0AZBzeiF05ECM2V9OvfZ1CKrtD2Eg7MJRxcpZ4SenxOrHol25bbZUeg5QNcPe9Bp0fZNPYsuuVIsXL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747088838; c=relaxed/simple;
	bh=rKQkiS/el7HATPnJ2TWIlVdg9qiHDDSgYAUaIWkXLeA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YtWrECnUP1VYwpIbe447p3X7RnPKY08cAI/AmCvPPbjAJov01skDBo6G6rspAfZi0e+Od8GOBhOp/2CGlcl5lDck8hvBadrM34m3+oWajlC3zlVyF9A2sneuAvmaqR0zY4ERgjaiLfVd1vEn3hVzGruZ/Bw8LXkg22YBX/494x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=egu2svIu; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3081fe5987eso4489349a91.3;
        Mon, 12 May 2025 15:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747088836; x=1747693636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bM6KcY7eMbe/zblTyCzfcoYGgVPiUUzuBb8zFtfYZ4w=;
        b=egu2svIuITAlnKx5VVk3+xESUwWgWBl8nuGbz4syBhIJ9NVKP3A7PMnugIhdvrwFRw
         erDQvH9ATObM032sWeCD011MW+e5X5CEC0tElMLsJkK7BbyYyxGZQxtO60/M+XMKcV7N
         hdHlkxj8oKXWGuRcVXWb4RMNJWAxWL9QwgbWNrZUALVV+pCULMOejL1qJjGWotRWXeKT
         K7b2n9o9d76suV7IXRZ7npBNDRXrzqMYDl60SzyxgX4TqV8AFb65BUKNdujvZJS6P/oI
         wKQ0atiyXd7H5QkhnaHPhjSzmTOYx4HST6+QVMvkfSEWIoYdEzoy1poAG8vCKfqo0ZiK
         azYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747088836; x=1747693636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bM6KcY7eMbe/zblTyCzfcoYGgVPiUUzuBb8zFtfYZ4w=;
        b=YNR3w5tYEQdWH6rlCcFK38CgMM9SVAegvl1ieWJK9abyTb1kHcgU5mvbCVOZNyMVH3
         MtmMhvduFJxS/SsJWTER6NlvHNLjwUskQ8ryeMPrS1TBW9jKlDFWJrTmjyG3yfW0GdmL
         Yo9eqACWqzBy/A8AcsKuNQXy8S7maXj4FVS4BLzjZRkTgWLbkT8Cb4j0JNAgDJoUUbco
         Zo0xNte2CRm79L7CHucTJctPb+LY2AR/D4j6yhQ8RFDTcS2IyOaGdU+uCqVc3oh9h2Ho
         Hds6kVY0emV/0DmOgXKPAlnz4xW5khm8HwS4sSRnPzM/x46QU6Hc2ymMbYb9gWCLDKTL
         lNiw==
X-Forwarded-Encrypted: i=1; AJvYcCUD1PITFBtpjHLjHT2FbijXalKLqEXzcbk6NUcCgnaTSLgsshQHorCtphMmpnCrNEJBHYXctiJnOQQOl6FvRYeInK3b@vger.kernel.org, AJvYcCWvbHokLr7KNNexq2Y0qimcedrPCZiBoenEy0ia1S79Qd5ycJQSDCE6HKBes6l0rtG1iTU=@vger.kernel.org, AJvYcCX4DhmvkP4CVjn5h+zxBnJ+2Gn3v1LaiDAnw5Clngdr8k5UHgzhXAWfHAZz6aZPoy20kipz9kMJifZnBDQ/@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk3PlUx4AHLUNOeZFjDrwfrRM/z6e8GW4b3EVVeGoctHmiz0dM
	Ubr1osG5gzSBHcPo54sv3mlYz7ikAnXKIOFkvxLdVPd1HGow4UgMzNBbmiOjVOuMES/RIbyPsvj
	glbpaKqVT37lCiWrNKgq+c7In2GUbR+su
X-Gm-Gg: ASbGncv5aUOJNbJplv0SMAZ8AQRUJnAkpSDeIAmf7D6yy0Ifmg08SQcPZ3Ry/Hz0Mb8
	g7G8xzi2MBd5jc+E/7SMjyt5nKwKWEw/WCtaf0L7PsDcS2WIagR+KeNsgzXrt2+HJ+BNuWKJHze
	CHvY62Io2n3Z+Xx165StMdftVU2sa+8AWydNpb3jwl+P2k5Lfu
X-Google-Smtp-Source: AGHT+IF/Qs1+S2EQ1LzRXHj0K73ykpa4yeY/isl/c+DiHNEaGZUKO6jP78FAb0Pe8JKUlQtAczAm+p9vq0y3KwORV/U=
X-Received: by 2002:a17:90b:4c52:b0:30a:255c:9d10 with SMTP id
 98e67ed59e1d1-30c3cff49ffmr22190446a91.8.1747088836387; Mon, 12 May 2025
 15:27:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509164524.448387100@goodmis.org> <20250509165156.135430576@goodmis.org>
 <CAEf4BzaKfvCu2T+jJ2e-CCt0N50urfx+p6kQfV899_jkmT_XKQ@mail.gmail.com> <ak36qadrkrplficbyceqx4cadgokxwolyyu3slgq4ag2kfjif5@7bxxiipqgdam>
In-Reply-To: <ak36qadrkrplficbyceqx4cadgokxwolyyu3slgq4ag2kfjif5@7bxxiipqgdam>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 12 May 2025 15:27:02 -0700
X-Gm-Features: AX0GCFuWwVBmhXJFv-IBlcqVh6U9vhEVnbHdoYnRDAeUtUPD2ypCGMb1JLmfsws
Message-ID: <CAEf4BzYMHoMNdmDTwt_J6rQ=zr4zTB_gCBmfPkAd06Y2iztqFQ@mail.gmail.com>
Subject: Re: [PATCH v8 15/18] perf: Have get_perf_callchain() return NULL if
 crosstask and user are set
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 10, 2025 at 10:59=E2=80=AFAM Josh Poimboeuf <jpoimboe@kernel.or=
g> wrote:
>
> On Fri, May 09, 2025 at 02:53:38PM -0700, Andrii Nakryiko wrote:
> > On Fri, May 9, 2025 at 9:52=E2=80=AFAM Steven Rostedt <rostedt@goodmis.=
org> wrote:
> > >
> > > From: Josh Poimboeuf <jpoimboe@kernel.org>
> > >
> > > get_perf_callchain() doesn't support cross-task unwinding for user sp=
ace
> > > stacks, have it return NULL if both the crosstask and user arguments =
are
> > > set.
> > >
> > > Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> > > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > > ---
> > >  kernel/events/callchain.c | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
> > > index b0f5bd228cd8..abf258913ab6 100644
> > > --- a/kernel/events/callchain.c
> > > +++ b/kernel/events/callchain.c
> > > @@ -224,6 +224,10 @@ get_perf_callchain(struct pt_regs *regs, bool ke=
rnel, bool user,
> > >         struct perf_callchain_entry_ctx ctx;
> > >         int rctx, start_entry_idx;
> > >
> > > +       /* crosstask is not supported for user stacks */
> > > +       if (crosstask && user)
> > > +               return NULL;
> >
> > I think get_perf_callchain() supports requesting both user and kernel
> > stack traces, and if it's crosstask, you can still get kernel (but not
> > user) stack, if I'm reading the code correctly.
> >
> > So by just returning NULL early you will change this behavior, no?
>
> Yeah, that does seem like a bug.
>
> Though crosstask in general is dubious, even for kernel stacks.
>
> If the task is running while you're unwinding it, hilarity ensues.
> There are guardrails in place, so it should be safe, it may just produce
> nonsense.  But maybe the callers don't need perfection.
>
> But also, it would seem to be a bad idea to allow one task to spy on
> what another task's kernelspace is doing.  Does unpriv BPF allow that?

No, you need CAP_PERFMON to be able to capture stack traces, so we are
fine from that POV.

But also note that BPF itself doesn't allow requesting both user and
kernel stack traces in one go. So the issue I pointed out is not
really related to how BPF is using get_perf_callchain().

>
> Though it seems even 'cat /proc/self/stack' is a privileged operation
> these days, does unpriv BPF allow that as well?
>
> --
> Josh

