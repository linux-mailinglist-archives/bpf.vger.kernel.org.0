Return-Path: <bpf+bounces-28274-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3DB8B7CDD
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 18:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91BE71F21AFB
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 16:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331A8179965;
	Tue, 30 Apr 2024 16:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTtPhhGV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4F1175554;
	Tue, 30 Apr 2024 16:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714494594; cv=none; b=EJxTUj0LJzWCoxdgh4zCsDSZEINHJ13iI+o6YPA93bz0Ptuy8HFpxqjawDWKHxdyvzQy0Cgg3TWT4TC+HGt+6uYo6JONIzLG6RM6AtMKomLtmf3aamaZp5l2wDWX1E49No5bcOh8rj/GGnFpbGeWmgTvKrIFuoSiDpbP0bCG70I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714494594; c=relaxed/simple;
	bh=nz+VaBU6RtPqdW451GEPI/aHEIuxOlomtq0gZmOR5zM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uo5gUCdvQVHqwBUMiKWxAEE0AAkRVcwkAQOHR7HSCR/4kQWccVVfKlXsby7iMYqpI0A+MzwrnLJ2/QeOUfvnQanrmDXiWO8fy6iO0mh2h1W0z8b8G+W08KemI9WYMkY5lSqhgUsr0SCXklVy5ytHXfvhf2iB6J/gp60cJ7q3kKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iTtPhhGV; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2a4b457769eso4920673a91.2;
        Tue, 30 Apr 2024 09:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714494592; x=1715099392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9EaAPDvr92t3gXHQnvo1ngk0g+MSCmUHMmnShhgOnA=;
        b=iTtPhhGV5fWEl7e+QKrwb/zJfHsEkjuZbAE9A+L6jVrKkpyZQfbWiykbg6bTabMaOv
         zmvj8gZ2UXwZ/L3jESx1UGiF52Zv37uq9rj5TW+8VxgKBt6lUbxfPNpfack5Xpm+DjtO
         ITP06sS/zbsQJhuMMSkHRogSoqTWxaMe7tIyE/C0v7X0/NJd+WoD+K06N82VXr8j6q9R
         CbjEmx1bgJExO6QzenLrhQCJxTvONuPB8HYTghfVyw0ZEZ0a3S++v/LhzNxNQR0yKmKY
         veA9RgfQX6AI+CbJ5BoR4p6TfLuhBZUFeGzqzuB+fLnWn6rPjgNH/G0nKO2BMcKSGyNM
         tjdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714494592; x=1715099392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K9EaAPDvr92t3gXHQnvo1ngk0g+MSCmUHMmnShhgOnA=;
        b=Kvkoh0uld4DeJaqEhtj9sbrogVOlYqvJQ0tDbnFYOnBd1zSkoiXJ4jtZbF489/ExXo
         PXS/oPY2JbBA+QO+kaBISR3+MT1uP9kYhaYeQHlTVMXyM7r4pyAZiheqnt5V/2bexw0i
         4NsO1dhE6SutQgtSPaKaoE424XN5sJR7dS2lFs/n1k4ZfIUbSVd0ynJq5Qddt1+BBvPt
         oeUtvsfdDx1qRL4NuuKXRFwMtfRI3g4/BI805FKAs9j1/UZlFVtciq6kWMwX1SHR+KeE
         7R+eRghinisSLd7vqydDl5EJAlMH2lz+c3FY+NkfN91sLNxJ9I5gzWfkmpbXYlGhpBCK
         vp4w==
X-Forwarded-Encrypted: i=1; AJvYcCWlfmnY0vLMcgMT+yXLwPRDrW+xBIZAcBWk15XUq7jUCm+swuLiXnNB/sxSOOuXXp5TQJCuJ7R5LnVgyYLP+oOBOk5KfM21tjLMOvsCJ5EO/EdOS/IfOMQPnLk1GrDR0Yyfyh1fdLfsLiIMMmI3rmSdcSIqSfq/kcFrmzit7wTPgrOytcny
X-Gm-Message-State: AOJu0YyJHMA/b71fWFV2rQ34AclWZqL+O3wqguWodsCaQ+1SnswhL5Iy
	warAXXRonPBiacLcoFbGJE/QeVmCTfd53Wl3qbo5plU0eeH6rYhTKAbFncZrfFB5catSqY8jIj7
	l6scmodYtq1HgODTk4Tg3qtadLUXpqqm/
X-Google-Smtp-Source: AGHT+IG86XdZ6k/BeO+ngAp+nqWg9VwdFEyoOuJNHEuvGMjdevq6xJDE40lZ4lICPs2AgNN+c8w8m/aWm10nDV5tsbM=
X-Received: by 2002:a17:90b:19d0:b0:2af:ff3:e14a with SMTP id
 nm16-20020a17090b19d000b002af0ff3e14amr2988226pjb.16.1714494592488; Tue, 30
 Apr 2024 09:29:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171318533841.254850.15841395205784342850.stgit@devnote2>
 <CAEf4BzYMToveELxsOJ9dXz3H-9omhxRLKgGK-ppYvmK8pgDsfA@mail.gmail.com>
 <20240429225119.410833c12d9f6fbcce0a58db@kernel.org> <CAEf4BzZDqD4fyLpoq9r2M0HnES7aO7YW=ZNH-k8uPJWd_VbAJg@mail.gmail.com>
 <20240430223217.fd375d57d130a4207be18e94@kernel.org>
In-Reply-To: <20240430223217.fd375d57d130a4207be18e94@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 30 Apr 2024 09:29:40 -0700
Message-ID: <CAEf4BzZQLPL7419W1=yNw6gzB4gquiXfeANbUKbUL8bK+5if=w@mail.gmail.com>
Subject: Re: [PATCH v9 00/36] tracing: fprobe: function_graph: Multi-function
 graph and fprobe on fgraph
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Florent Revest <revest@chromium.org>, linux-trace-kernel@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>, 
	Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alan Maguire <alan.maguire@oracle.com>, Mark Rutland <mark.rutland@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 6:32=E2=80=AFAM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
>
> On Mon, 29 Apr 2024 13:25:04 -0700
> Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> > On Mon, Apr 29, 2024 at 6:51=E2=80=AFAM Masami Hiramatsu <mhiramat@kern=
el.org> wrote:
> > >
> > > Hi Andrii,
> > >
> > > On Thu, 25 Apr 2024 13:31:53 -0700
> > > Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> > >
> > > > Hey Masami,
> > > >
> > > > I can't really review most of that code as I'm completely unfamilia=
r
> > > > with all those inner workings of fprobe/ftrace/function_graph. I le=
ft
> > > > a few comments where there were somewhat more obvious BPF-related
> > > > pieces.
> > > >
> > > > But I also did run our BPF benchmarks on probes/for-next as a basel=
ine
> > > > and then with your series applied on top. Just to see if there are =
any
> > > > regressions. I think it will be a useful data point for you.
> > >
> > > Thanks for testing!
> > >
> > > >
> > > > You should be already familiar with the bench tool we have in BPF
> > > > selftests (I used it on some other patches for your tree).
> > >
> > > What patches we need?
> > >
> >
> > You mean for this `bench` tool? They are part of BPF selftests (under
> > tools/testing/selftests/bpf), you can build them by running:
> >
> > $ make RELEASE=3D1 -j$(nproc) bench
> >
> > After that you'll get a self-container `bench` binary, which has all
> > the self-contained benchmarks.
> >
> > You might also find a small script (benchs/run_bench_trigger.sh inside
> > BPF selftests directory) helpful, it collects final summary of the
> > benchmark run and optionally accepts a specific set of benchmarks. So
> > you can use it like this:
> >
> > $ benchs/run_bench_trigger.sh kprobe kprobe-multi
> > kprobe         :   18.731 =C2=B1 0.639M/s
> > kprobe-multi   :   23.938 =C2=B1 0.612M/s
> >
> > By default it will run a wider set of benchmarks (no uprobes, but a
> > bunch of extra fentry/fexit tests and stuff like this).
>
> origin:
> # benchs/run_bench_trigger.sh
> kretprobe :    1.329 =C2=B1 0.007M/s
> kretprobe-multi:    1.341 =C2=B1 0.004M/s
> # benchs/run_bench_trigger.sh
> kretprobe :    1.288 =C2=B1 0.014M/s
> kretprobe-multi:    1.365 =C2=B1 0.002M/s
> # benchs/run_bench_trigger.sh
> kretprobe :    1.329 =C2=B1 0.002M/s
> kretprobe-multi:    1.331 =C2=B1 0.011M/s
> # benchs/run_bench_trigger.sh
> kretprobe :    1.311 =C2=B1 0.003M/s
> kretprobe-multi:    1.318 =C2=B1 0.002M/s s
>
> patched:
>
> # benchs/run_bench_trigger.sh
> kretprobe :    1.274 =C2=B1 0.003M/s
> kretprobe-multi:    1.397 =C2=B1 0.002M/s
> # benchs/run_bench_trigger.sh
> kretprobe :    1.307 =C2=B1 0.002M/s
> kretprobe-multi:    1.406 =C2=B1 0.004M/s
> # benchs/run_bench_trigger.sh
> kretprobe :    1.279 =C2=B1 0.004M/s
> kretprobe-multi:    1.330 =C2=B1 0.014M/s
> # benchs/run_bench_trigger.sh
> kretprobe :    1.256 =C2=B1 0.010M/s
> kretprobe-multi:    1.412 =C2=B1 0.003M/s
>
> Hmm, in my case, it seems smaller differences (~3%?).
> I attached perf report results for those, but I don't see large differenc=
e.

I ran my benchmarks on bare metal machine (and quite powerful at that,
you can see my numbers are almost 10x of yours), with mitigations
disabled, no retpolines, etc. If you have any of those mitigations it
might result in smaller differences, probably. If you are running
inside QEMU/VM, the results might differ significantly as well.

>
> > > >
> > > > BASELINE
> > > > =3D=3D=3D=3D=3D=3D=3D=3D
> > > > kprobe         :   24.634 =C2=B1 0.205M/s
> > > > kprobe-multi   :   28.898 =C2=B1 0.531M/s
> > > > kretprobe      :   10.478 =C2=B1 0.015M/s
> > > > kretprobe-multi:   11.012 =C2=B1 0.063M/s
> > > >
> > > > THIS PATCH SET ON TOP
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > kprobe         :   25.144 =C2=B1 0.027M/s (+2%)
> > > > kprobe-multi   :   28.909 =C2=B1 0.074M/s
> > > > kretprobe      :    9.482 =C2=B1 0.008M/s (-9.5%)
> > > > kretprobe-multi:   13.688 =C2=B1 0.027M/s (+24%)
> > >
> > > This looks good. Kretprobe should also use kretprobe-multi (fprobe)
> > > eventually because it should be a single callback version of
> > > kretprobe-multi.
>
> I ran another benchmark (prctl loop, attached), the origin kernel result =
is here;
>
> # sh ./benchmark.sh
> count =3D 10000000, took 6.748133 sec
>
> And the patched kernel result;
>
> # sh ./benchmark.sh
> count =3D 10000000, took 6.644095 sec
>
> I confirmed that the parf result has no big difference.
>
> Thank you,
>
>
> > >
> > > >
> > > > These numbers are pretty stable and look to be more or less represe=
ntative.
> > > >
> > > > As you can see, kprobes got a bit faster, kprobe-multi seems to be
> > > > about the same, though.
> > > >
> > > > Then (I suppose they are "legacy") kretprobes got quite noticeably
> > > > slower, almost by 10%. Not sure why, but looks real after re-runnin=
g
> > > > benchmarks a bunch of times and getting stable results.
> > >
> > > Hmm, kretprobe on x86 should use ftrace + rethook even with my series=
.
> > > So nothing should be changed. Maybe cache access pattern has been
> > > changed?
> > > I'll check it with tracefs (to remove the effect from bpf related cha=
nges)
> > >
> > > >
> > > > On the other hand, multi-kretprobes got significantly faster (+24%!=
).
> > > > Again, I don't know if it is expected or not, but it's a nice
> > > > improvement.
> > >
> > > Thanks!
> > >
> > > >
> > > > If you have any idea why kretprobes would get so much slower, it wo=
uld
> > > > be nice to look into that and see if you can mitigate the regressio=
n
> > > > somehow. Thanks!
> > >
> > > OK, let me check it.
> > >
> > > Thank you!
> > >
> > > >
> > > >
> > > > >  51 files changed, 2325 insertions(+), 882 deletions(-)
> > > > >  create mode 100644 tools/testing/selftests/ftrace/test.d/dyneven=
t/add_remove_fprobe_repeat.tc
> > > > >
> > > > > --
> > > > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > > >
> > >
> > >
> > > --
> > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

