Return-Path: <bpf+bounces-28956-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 479D68BEE8F
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 23:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9B7DB210BC
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 21:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91A87316F;
	Tue,  7 May 2024 21:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZqNtQxR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC92A71B3A;
	Tue,  7 May 2024 21:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715115862; cv=none; b=tUcgtKvUAzHHILVi66kOnHlmZ5tfUK+0XBPxwIGb+TiGTJ4W5nu4EVs4aYQm7e9J9G4BIE+TSLpisrRtxpd+8NBMuSMvcXbtBBHEVaqF01FZ3zp9amBp97XwAUMV8Z4t/94T7ct6lLRPyY9flIAVIZbHXw4b9+JGCsK8Lopi1jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715115862; c=relaxed/simple;
	bh=9ythelcd555ehayoCK+v6PnGyHN2aIf5mfrvlET7y4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rlq3wbsDaluVZXYxNhnz6RHUVw0TwLtFTifXhnvpd46Lxfi8kb3ejVBqa++Wv3rTEJ6jcpqoZj21r5DMXHFxv4dTYyNwUU6og1Upi6watF2YIl38zpCYqdl7Lwz6SfkpbxLs7uJqYMerXPVF3oGwukGWj+/7dXt8WFElH4w+kNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jZqNtQxR; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-61c4ebd0c99so2368262a12.0;
        Tue, 07 May 2024 14:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715115860; x=1715720660; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MFzLP9jypxz8zp9JCgtxnmrKkuxXPrSxPzVAWQBs/uM=;
        b=jZqNtQxRsCskCePX71jcFMFj/K3q40uhIKi2if8KL/YIsEg2rFRdlgj8lCGD9Mewpj
         DzaG9+2eDfIfpKaeKPfhxISweO5mOWhfYyhI/VCIRzsPWMgmkH6+YEUr076ePaDC8HYW
         fOxfLrvq6trAImpWC6/ivbruvdBY3P0o3i6BdJWoMt+DgX7dbj5tY9RcYNMnTbj5jGTV
         jvfP9I7Y5kGZWyiFucKwYpQAQ6qbjMdShiwmHAIyfWGunhUbMPTIOCQ5zGSHpJ0JQnzE
         z8vdDKlptmwoWOQNzQ25DC8UIqF9oqKY3WAihX9DUYZ2c6ENlWiZxLQ+Lr/0GeDGe45e
         9R4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715115860; x=1715720660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MFzLP9jypxz8zp9JCgtxnmrKkuxXPrSxPzVAWQBs/uM=;
        b=VVzmgXdFHZkqNek/YmWR9AV9pjMucmKL93vg2U5fiOluZClNGR2XYsTKh4sMoXSK0g
         78jefW2UGpqJ13MQCSU3v+N2yAa09Tnq2sdRUTrzUOj2HXhtcfAfOUXYgmCMlP55HCis
         DF/o7qgI1AjNS0HioN5b0wKsnKSGEUPB5fWWvygV23R8k44YJLfBJvr3lCHtYPmihCH4
         bKaNI+I0qVVv5bFGRBHJJ2Lh/btcVfwtL+UIihl70ppCymOZPfki6kGIwjVm/z9tb1vq
         yV2otIM6PuQyzuwTJxnczlH13JiZCFqv1IAXOwU7SkPQ2W394cPPxDsSKTA6OT/PID57
         OEog==
X-Forwarded-Encrypted: i=1; AJvYcCV46FLTIRzbzsow448QTNhWlYd6rF4R8PSZyDJ+YSJQX/18aUa9s85YVVPqaafQJ+iu6qvh7yO2+H27OS8g1xbbktrKZQ1ZyG2yVa4B9l1BotvOeHhLkthhqRPuYFpR+yzIaQlTr0g9NFlgJr09K+gT/pmvZjjrxKI+DFYzD1VFq++ZbZB9
X-Gm-Message-State: AOJu0YyAYA3tZGPTl7hnRmAbRgl3DyuzYu9RxSMGXIIIwlL1pLcN2Yf3
	EHUzVYWEBo952RxxaQdMgXqPkgcpPSHKRFjNZ46bENN8ESp1p/EIHGkl/NfWqYJCl0GKKriZSrb
	RO0pPnhsrPKoY2D0XaICUuzhdUAQ=
X-Google-Smtp-Source: AGHT+IEvi+qh6FV6T7TpdH8lIa91LZDU7awvCKHqDLHp6p/u8XRcYsLVnh1NuA9JDVQ663ZK+HDD0OJS6hdKcdp/eaQ=
X-Received: by 2002:a17:90b:348e:b0:2ac:513b:b316 with SMTP id
 98e67ed59e1d1-2b6163a32ebmr826188a91.10.1715115860101; Tue, 07 May 2024
 14:04:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171318533841.254850.15841395205784342850.stgit@devnote2>
 <CAEf4BzYMToveELxsOJ9dXz3H-9omhxRLKgGK-ppYvmK8pgDsfA@mail.gmail.com>
 <20240429225119.410833c12d9f6fbcce0a58db@kernel.org> <CAEf4BzZDqD4fyLpoq9r2M0HnES7aO7YW=ZNH-k8uPJWd_VbAJg@mail.gmail.com>
 <20240430223217.fd375d57d130a4207be18e94@kernel.org> <CAEf4BzZQLPL7419W1=yNw6gzB4gquiXfeANbUKbUL8bK+5if=w@mail.gmail.com>
 <20240502110610.412d54a0cf194293b82ee787@kernel.org>
In-Reply-To: <20240502110610.412d54a0cf194293b82ee787@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 7 May 2024 14:04:08 -0700
Message-ID: <CAEf4BzYb0LUKo_BUnd72qrBOtnbbHRS8SaDz0XcTx-DTgb2mVA@mail.gmail.com>
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

On Wed, May 1, 2024 at 7:06=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.or=
g> wrote:
>
> On Tue, 30 Apr 2024 09:29:40 -0700
> Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> > On Tue, Apr 30, 2024 at 6:32=E2=80=AFAM Masami Hiramatsu <mhiramat@kern=
el.org> wrote:
> > >
> > > On Mon, 29 Apr 2024 13:25:04 -0700
> > > Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> > >
> > > > On Mon, Apr 29, 2024 at 6:51=E2=80=AFAM Masami Hiramatsu <mhiramat@=
kernel.org> wrote:
> > > > >
> > > > > Hi Andrii,
> > > > >
> > > > > On Thu, 25 Apr 2024 13:31:53 -0700
> > > > > Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> > > > >
> > > > > > Hey Masami,
> > > > > >
> > > > > > I can't really review most of that code as I'm completely unfam=
iliar
> > > > > > with all those inner workings of fprobe/ftrace/function_graph. =
I left
> > > > > > a few comments where there were somewhat more obvious BPF-relat=
ed
> > > > > > pieces.
> > > > > >
> > > > > > But I also did run our BPF benchmarks on probes/for-next as a b=
aseline
> > > > > > and then with your series applied on top. Just to see if there =
are any
> > > > > > regressions. I think it will be a useful data point for you.
> > > > >
> > > > > Thanks for testing!
> > > > >
> > > > > >
> > > > > > You should be already familiar with the bench tool we have in B=
PF
> > > > > > selftests (I used it on some other patches for your tree).
> > > > >
> > > > > What patches we need?
> > > > >
> > > >
> > > > You mean for this `bench` tool? They are part of BPF selftests (und=
er
> > > > tools/testing/selftests/bpf), you can build them by running:
> > > >
> > > > $ make RELEASE=3D1 -j$(nproc) bench
> > > >
> > > > After that you'll get a self-container `bench` binary, which has al=
l
> > > > the self-contained benchmarks.
> > > >
> > > > You might also find a small script (benchs/run_bench_trigger.sh ins=
ide
> > > > BPF selftests directory) helpful, it collects final summary of the
> > > > benchmark run and optionally accepts a specific set of benchmarks. =
So
> > > > you can use it like this:
> > > >
> > > > $ benchs/run_bench_trigger.sh kprobe kprobe-multi
> > > > kprobe         :   18.731 =C2=B1 0.639M/s
> > > > kprobe-multi   :   23.938 =C2=B1 0.612M/s
> > > >
> > > > By default it will run a wider set of benchmarks (no uprobes, but a
> > > > bunch of extra fentry/fexit tests and stuff like this).
> > >
> > > origin:
> > > # benchs/run_bench_trigger.sh
> > > kretprobe :    1.329 =C2=B1 0.007M/s
> > > kretprobe-multi:    1.341 =C2=B1 0.004M/s
> > > # benchs/run_bench_trigger.sh
> > > kretprobe :    1.288 =C2=B1 0.014M/s
> > > kretprobe-multi:    1.365 =C2=B1 0.002M/s
> > > # benchs/run_bench_trigger.sh
> > > kretprobe :    1.329 =C2=B1 0.002M/s
> > > kretprobe-multi:    1.331 =C2=B1 0.011M/s
> > > # benchs/run_bench_trigger.sh
> > > kretprobe :    1.311 =C2=B1 0.003M/s
> > > kretprobe-multi:    1.318 =C2=B1 0.002M/s s
> > >
> > > patched:
> > >
> > > # benchs/run_bench_trigger.sh
> > > kretprobe :    1.274 =C2=B1 0.003M/s
> > > kretprobe-multi:    1.397 =C2=B1 0.002M/s
> > > # benchs/run_bench_trigger.sh
> > > kretprobe :    1.307 =C2=B1 0.002M/s
> > > kretprobe-multi:    1.406 =C2=B1 0.004M/s
> > > # benchs/run_bench_trigger.sh
> > > kretprobe :    1.279 =C2=B1 0.004M/s
> > > kretprobe-multi:    1.330 =C2=B1 0.014M/s
> > > # benchs/run_bench_trigger.sh
> > > kretprobe :    1.256 =C2=B1 0.010M/s
> > > kretprobe-multi:    1.412 =C2=B1 0.003M/s
> > >
> > > Hmm, in my case, it seems smaller differences (~3%?).
> > > I attached perf report results for those, but I don't see large diffe=
rence.
> >
> > I ran my benchmarks on bare metal machine (and quite powerful at that,
> > you can see my numbers are almost 10x of yours), with mitigations
> > disabled, no retpolines, etc. If you have any of those mitigations it
> > might result in smaller differences, probably. If you are running
> > inside QEMU/VM, the results might differ significantly as well.
>
> I ran it on my bare metal machines again, but could not find any differen=
ce
> between them. But I think I enabled intel mitigations on, so it might mak=
e
> a difference from your result.
>
> Can you run the benchmark with perf record? If there is such differences,
> there should be recorded.

I can, yes, will try to do this week, I'm just trying to keep up with
the rest of the stuff on my plate and haven't found yet time to do
this. I'll get back to you (and I'll use the latest version of your
patch set, of course).

> e.g.
>
> # perf record -g -o perf.data-kretprobe-nopatch-raw-bpf -- bench -w2 -d5 =
-a trig-kretprobe
> # perf report -G -i perf.data-kretprobe-nopatch-raw-bpf -k $VMLINUX --std=
io > perf-out-kretprobe-nopatch-raw-bpf
>
> I attached the results in my side.
> The interesting point is, the functions int the result are not touched by
> this series. Thus there may be another reason if you see the kretprobe
> regression.
>
> Thank you,
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

