Return-Path: <bpf+bounces-39347-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 840F9972361
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 22:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D94CCB22C90
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 20:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8918F189F33;
	Mon,  9 Sep 2024 20:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8aecEDx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9F91CAA6;
	Mon,  9 Sep 2024 20:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725912796; cv=none; b=O1410+IFRHE0HlWCUTUNBfqMd4ioe1RPG4ORye6p6wyFw3LZEU7HOHVM7fcYpqNCPAXm+WkgM+CiehZB20SSJBVQBF1G5Eof3+lbIVbAqyyhnHFoTQqw92zxBJFfz+0R/kL44U7uDHrjRpdIux92HdF6xL1SP41ibNxFKQxpL+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725912796; c=relaxed/simple;
	bh=Pcz0ezSsaPLev3yVQApSD16X1qAyI7PtNkYE9DYYR9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TQUp1TT4EOIc/gNY3do+2POtgBTyBH7LweR/EKNprIy+l91GQguc8SUnjEMB/DDIz3KWKQtIwfHdNbyvqaxXE2J9qAMljBOAhZ+HsjMcI1FLk0TtmH4sKJqo2HPPcA6XHE/jCzzKrNerS7E4B6jLPRFO9xTnIrCGii++poZukSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h8aecEDx; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-206b9455460so39241355ad.0;
        Mon, 09 Sep 2024 13:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725912794; x=1726517594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WD0uAwzCMkMApgZD0UfsxApJcJH6AM3KNicBeGxPEHM=;
        b=h8aecEDxEv+2Fs5xm6PoYbxSAYllPIc4nO0MRt+ZkqX7xB2LFVW+Sa/Ndg0OGFCWC3
         X4Ebd+qDK73Mp4Fx74OYvKgDOWCoNm/iwwBDzjyFJhygcYy29Po/Ecs11AHd8srILGD/
         OWQ4GoOrHDzHacHPI6O5H0ZvA2hrfWT9xu0aQFD+pCCYwfmgX/PBOYGVy2HhsfoA274N
         BXL9Gbc/JFQCsJlrdpIFdsRu6DIeUp2hNcDMqHEHGyHOe/L9CL5ml3/QlB2yysLN+NTH
         RzXMhKpZL+wqJoUQHMbPSr5eK3EHUqhLwMNPnNeN5s4N2pnP2su1P4FuvZsL6SiFpbN1
         zZYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725912794; x=1726517594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WD0uAwzCMkMApgZD0UfsxApJcJH6AM3KNicBeGxPEHM=;
        b=dExmtGaNA6N8vDs09ofYpvFhQ0cvazx+S3/ez68P9b1Pva2ZJ5AbYD81H6zZ+dzd02
         f1V76g3nN5BsVFiPZ48SwiwSkMTg5YBQt6LO4WHbwh5ZjBcfxMp5ytBFmBsYSlzC9UTT
         w6anoEr68QU7yxqUcGZZenQvvn5v6kDbeBSdDcaXskVK/AJHnmqrgz1E+EVG8o1mmneK
         PVUMBnKn5izKxH0pvlN21qz+hjGEz2wlx8ZrNBPKwohHoE9tYzV3v+qjYu8vXqj4rbj5
         5A5OTv3Qa6Jjj+pnsCx0Kf4zoqNWSaLMNHA9BmXq9zAME8WVRuM3cVrtVsND/bPJlNeH
         /ULQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsjiZbhYSmq+yzEY3PZ9szeuRd97W8x2xiQUPhoTa0gDk7kNAwqaKhbVzgH1/oDBTWhQI=@vger.kernel.org, AJvYcCWzJNo01qCw6G0mmyBtK28K1hrj76N5XiPFKjbUSVlmlUfy60nL8kifBhuO/oVP7EPatILxHGUjYEtWDUv9VO00tT2j@vger.kernel.org, AJvYcCWzTe6RK/+t0YUSHrxggkoWArt0APY+b3hNY0xosviIz9kuzxAiZYwCNedgM4k7u3CCgDiktRw2e1gGzV9C@vger.kernel.org
X-Gm-Message-State: AOJu0YxOeAgTmTCxrfgR7LmSUYv8ZlSZn6JJv/L87N/ml2SKEH1ridFv
	w5Bx4sGd2tVj0LbSxyYohcpzrY+rzD9hs4wDXlH/KqFHzLpBCze8b1WiKC6dxKMyGJnhaMvebzN
	Gxh4QELv4O+KuN+vKZEzMcNVgnqE=
X-Google-Smtp-Source: AGHT+IFO24pjNyWopUmhGojEFIa6eeUsteaegxFSno5uz5ILepDPjgWgmtNMnrSe/fcClaYqr7NgZ3uQYSdCfHSg1pM=
X-Received: by 2002:a17:902:8a81:b0:206:8d6e:d003 with SMTP id
 d9443c01a7336-2074381fdd4mr10868065ad.4.1725912793722; Mon, 09 Sep 2024
 13:13:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828144153.829582-1-mathieu.desnoyers@efficios.com>
 <20240828144153.829582-4-mathieu.desnoyers@efficios.com> <CAEf4BzZERq7qwf0TWYFaXzE6d+L+Y6UY+ahteikro_eugJGxWw@mail.gmail.com>
 <1f442f99-92cd-41d6-8dd2-1f4780f2e556@efficios.com> <CAEf4BzbS0TRN1vPzPtSZj+XN7oVUUwyoxHr5p7igH8X-nhZhGw@mail.gmail.com>
 <279860b4-2f42-463f-bee2-c6c60ec72f29@efficios.com>
In-Reply-To: <279860b4-2f42-463f-bee2-c6c60ec72f29@efficios.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 9 Sep 2024 13:13:01 -0700
Message-ID: <CAEf4BzZ-sWqComLC=VOQugjWBkdX=iApFnCnUxisWgwd6fHFjQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/5] tracing/bpf-trace: Add support for faultable tracepoints
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, 
	bpf@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>, 
	linux-trace-kernel@vger.kernel.org, Michael Jeanson <mjeanson@efficios.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 10:22=E2=80=AFAM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> On 2024-09-09 12:53, Andrii Nakryiko wrote:
> > On Mon, Sep 9, 2024 at 8:11=E2=80=AFAM Mathieu Desnoyers
> [...]
> >>>
> >>> I wonder if it would be better to just do this, instead of that
> >>> preempt guard. I think we don't strictly need preemption to be
> >>> disabled, we just need to stay on the same CPU, just like we do that
> >>> for many other program types.
> >>
> >> I'm worried about introducing any kind of subtle synchronization
> >> change in this series, and moving from preempt-off to migrate-disable
> >> definitely falls under that umbrella.
> >>
> >> I would recommend auditing all uses of this_cpu_*() APIs to make sure
> >> accesses to per-cpu data structures are using atomics and not just usi=
ng
> >> operations that expect use of preempt-off to prevent concurrent thread=
s
> >> from updating to the per-cpu data concurrently.
> >>
> >> So what you are suggesting may be a good idea, but I prefer to leave
> >> this kind of change to a separate bpf-specific series, and I would
> >> leave this work to someone who knows more about ebpf than me.
> >>
> >
> > Yeah, that's ok. migrate_disable() switch is probably going a bit too
> > far too fast, but I think we should just add
> > preempt_disable/preempt_enable inside __bpf_trace_run() instead of
> > leaving it inside those hard to find and follow tracepoint macros. So
> > maybe you can just pass a bool into __bpf_trace_run() and do preempt
> > guard (or explicit disable/enable) there?
> >
>
> Passing an extra boolean to __bpf_trace_run would impact all tracepoints
> calling into ebpf, adding an extra function argument and extra tests for
> all of those. The impact may be small, but it is non-zero in both code si=
ze
> and overhead, so it would not be my preferred approach.
>

Ok, sounds good to me, we can always change that after your patch set
makes it into upstream.

> I have modified the macros to add the guard within __bpf_trace_##call
> following suggestions from Linus:
>
>    https://lore.kernel.org/lkml/CAHk-=3DwggDLDeTKbhb5hh--x=3D-DQd69v41137=
M72m6NOTmbD-cw@mail.gmail.com/
>
> I'll Cc you on that version of the series.

Thanks!

>
> Thanks,
>
> Mathieu
>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
>

