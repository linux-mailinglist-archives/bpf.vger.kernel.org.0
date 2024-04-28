Return-Path: <bpf+bounces-28053-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 312B68B4EC9
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 01:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA25D281288
	for <lists+bpf@lfdr.de>; Sun, 28 Apr 2024 23:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA4F1A286;
	Sun, 28 Apr 2024 23:25:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597781426C;
	Sun, 28 Apr 2024 23:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714346753; cv=none; b=AkUgfGuCqCVwpxYYtBKlUxRHF0pBJ50FsNNOjnfBtEjCmX31PByKKnuu04IBVptMa0VTrdeNf3cUPdas3GK5ljgZCbB2zGP5VINUv+IIIyULr6mHTDZ0MFKN3ucz+ZudxsqsBQbEkA22V+2C7n8lgFizQjgloBLAVkiYMB1cZ0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714346753; c=relaxed/simple;
	bh=yDrUOwB6HaFx72kB39jjAMjhpY5LUydTGFTQOH7bIO0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ayaZCymykBgm/dSJ4Hyj0KTxKrFJ3Lo9j49hyOr+jrgdr75T7f7olGsVOg4w2xvcvo6E4ZTMqynE34V78HoePfh6+RLNhxCHbOi7E7LdxuCcadTY3fl3KMaRjDuqTtclrUJqb2dFXH82MhWDY9MxWSbcAZfJkwnKYBVNuvdqajY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF42C113CC;
	Sun, 28 Apr 2024 23:25:51 +0000 (UTC)
Date: Sun, 28 Apr 2024 19:25:49 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Florent Revest <revest@chromium.org>,
 linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Sven
 Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Alan Maguire <alan.maguire@oracle.com>,
 Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v9 00/36] tracing: fprobe: function_graph:
 Multi-function graph and fprobe on fgraph
Message-ID: <20240428192549.7898bf6b@rorschach.local.home>
In-Reply-To: <CAEf4BzYMToveELxsOJ9dXz3H-9omhxRLKgGK-ppYvmK8pgDsfA@mail.gmail.com>
References: <171318533841.254850.15841395205784342850.stgit@devnote2>
	<CAEf4BzYMToveELxsOJ9dXz3H-9omhxRLKgGK-ppYvmK8pgDsfA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 25 Apr 2024 13:31:53 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

I'm just coming back from Japan (work and then a vacation), and
catching up on my email during the 6 hour layover in Detroit.

> Hey Masami,
>=20
> I can't really review most of that code as I'm completely unfamiliar
> with all those inner workings of fprobe/ftrace/function_graph. I left
> a few comments where there were somewhat more obvious BPF-related
> pieces.
>=20
> But I also did run our BPF benchmarks on probes/for-next as a baseline
> and then with your series applied on top. Just to see if there are any
> regressions. I think it will be a useful data point for you.
>=20
> You should be already familiar with the bench tool we have in BPF
> selftests (I used it on some other patches for your tree).

I should get familiar with your tools too.

>=20
> BASELINE
> =3D=3D=3D=3D=3D=3D=3D=3D
> kprobe         :   24.634 =C2=B1 0.205M/s
> kprobe-multi   :   28.898 =C2=B1 0.531M/s
> kretprobe      :   10.478 =C2=B1 0.015M/s
> kretprobe-multi:   11.012 =C2=B1 0.063M/s
>=20
> THIS PATCH SET ON TOP
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> kprobe         :   25.144 =C2=B1 0.027M/s (+2%)
> kprobe-multi   :   28.909 =C2=B1 0.074M/s
> kretprobe      :    9.482 =C2=B1 0.008M/s (-9.5%)
> kretprobe-multi:   13.688 =C2=B1 0.027M/s (+24%)
>=20
> These numbers are pretty stable and look to be more or less representativ=
e.

Thanks for running this.

>=20
> As you can see, kprobes got a bit faster, kprobe-multi seems to be
> about the same, though.
>=20
> Then (I suppose they are "legacy") kretprobes got quite noticeably
> slower, almost by 10%. Not sure why, but looks real after re-running
> benchmarks a bunch of times and getting stable results.
>=20
> On the other hand, multi-kretprobes got significantly faster (+24%!).
> Again, I don't know if it is expected or not, but it's a nice
> improvement.
>=20
> If you have any idea why kretprobes would get so much slower, it would
> be nice to look into that and see if you can mitigate the regression
> somehow. Thanks!

My guess is that this patch set helps generic use cases for tracing the
return of functions, but will likely add more overhead for single use
cases. That is, kretprobe is made to be specific for a single function,
but kretprobe-multi is more generic. Hence the generic version will
improve at the sacrifice of the specific function. I did expect as much.

That said, I think there's probably a lot of low hanging fruit that can
be done to this series to help improve the kretprobe performance. I'm
not sure we can get back to the baseline, but I'm hoping we can at
least make it much better than that 10% slowdown.

I'll be reviewing this patch set this week as I recover from jetlag.

-- Steve

