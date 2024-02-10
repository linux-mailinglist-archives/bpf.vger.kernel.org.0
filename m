Return-Path: <bpf+bounces-21712-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 820278504F2
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 16:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4314D283EF5
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 15:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093395BADF;
	Sat, 10 Feb 2024 15:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IrUUlCA+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C8A5BAE7
	for <bpf@vger.kernel.org>; Sat, 10 Feb 2024 15:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707579070; cv=none; b=NIZ8M6X6qWLKRvBTw/a1gAoWqnmtppzyZsNWTjGSttey5+ol2rDsWUdpvxAvIfmKvMF8QV15qkq8c3bf6sfnVhe+H3Ay9NuqKbKyPBuficn8K8uCRisnvaOlP0E8Wt7x8tRFVwzOfDXGa69iPMYajpDMF1Wk3D4qsUokPf7Efr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707579070; c=relaxed/simple;
	bh=azOZ7quth80TtmWzcI53foDqe3KuxBvYSAvjqCkilhU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qNMDw9k/1yy6+6dzNlvkRrEnMyb4vb3D8HXJGMrir9O4gq/E7PD81hMfO7SJ+cR9pTvDFMDk8cgC0QotFSl2ZaOLnx3naJQwMxuKo74u04j3fAxF1zH/l77Rsn4Wz4nNPxrF5NvJHtBgitShNXdDJgvcn7p+v/mZmNBWEieyCJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IrUUlCA+; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56001d49cc5so2334061a12.2
        for <bpf@vger.kernel.org>; Sat, 10 Feb 2024 07:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707579067; x=1708183867; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5Ztq/nmgSiGAwIGVYgsV9ffjlUlitLlAMXXOwIqtsog=;
        b=IrUUlCA+WhbZdlZgi10/XhC/OSc7RToCkP5GALy2jx1rU/LehSz85np7QDLgT+moDQ
         L+DzoDJJvwI9aj68lEY/F5afga3kz2j0vK0VooEgrQnvvBw+sETdlCRU3kBGb19jF0bC
         yEqN9thhSbs6kYOMX8Jn3fUfFsmyRDGBiv4z1SSEcAIrFDcxdkVdBElyo6XDUAosEuaH
         5TUZOmijoybtBKvynSp9aeJTLtOwoqN0Lk3xHkWA4iyQUKoe1AwP10z8z6ryvllDOxQE
         MwHruGtvKqfAO/kcjvWT+FJTCeMvVSBkgBfwpb0rArn9cCfX2cMDiMFbZR5vo2UAe9wo
         VzbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707579067; x=1708183867;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Ztq/nmgSiGAwIGVYgsV9ffjlUlitLlAMXXOwIqtsog=;
        b=TMBniIp9r72vel5o09uGC1w1Y5Uiwv7y+yKuhClWun5STBPoaJTP1QfQLxX62BaVfM
         b69x2XR5j1odHCT7tX7Fm0XyfFgnMu3FUSMXy0fzRMCXD4Jny9koNwsX0m/4DwgeTer4
         wFD0fEv9nGrzASgghAUozFm4+MlsXf8vKw8Ctg1//KpIV670qEHLexM1tIbdlgrE/plA
         cNfGlNdOFYC6Vp5rgEuQO/kQ8vS7AG5HAR6PyNKqS7i4k9g8+q2hIx8Mpc1nPWX2C4CV
         suMDC+WHID89qbiCzX0w+neMqI5tqHqA9Nl0BelAIAguwJqBhqsmN5hqxAt44dOg5HUd
         F/WA==
X-Forwarded-Encrypted: i=1; AJvYcCUZ4nJ5eHPX8oV4ZY8HbOnRY5w660pfuWLEN7/3NWvVb3uR3wtaTx9YB2Y0+SgKVoM7ttubyo+6dsrpQQlrZotM4QAI
X-Gm-Message-State: AOJu0YwUIH9vpgrcBzgYyZQIiTFLmZ6B5rzmUTndxS80ko1gXos3ZO8P
	pS7cmzkAWwW9EhHw+YRdKxx8nJq5kwEwwyfGzFg2C7BLpMle75bk
X-Google-Smtp-Source: AGHT+IHEpytKgBdOZtU4tSDpsb4TdHzWYvzRaM8SkRoPLS6oDRY5vnPTo7qUqcYrM3yrWwX0Kb6Bvw==
X-Received: by 2002:aa7:d289:0:b0:55e:eb81:2db0 with SMTP id w9-20020aa7d289000000b0055eeb812db0mr1504058edq.38.1707579066369;
        Sat, 10 Feb 2024 07:31:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWfBWZEwvg152xsnCozFQhazfn5tKaBAWjrT31sj6ojaXq0s9My8afjJqWPGk2xnAPEco2YrQ+sMtQeaU+5qvmf5IUq/GgcPisQk7/ZBtvdw/wfSjz6pyPw2XfPFvISdbTh/WMrx2F3MmMy+DuG7QtuclnpDI+g5/bxPjj2xPr0y2tMHBG6GXWlFWUSBb8RINTtTIj1bbKLzI1glksf7uZpn68GQ5ThCuYjcOdnHzLXGtcbj3nte83Rn1bvM4HjLjsHrBc5m2IBdus7K96Er2SjhWPOxq0H96zYJTempPZtRIJc5mFfd2AV38IbJGt2stDSg5mL3KbaySgCIjnElHSUaehez2p6eawd3kN+QrRonVRxxrLL100/
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id ig4-20020a056402458400b0056098a293cdsm818870edb.69.2024.02.10.07.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 07:31:06 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 10 Feb 2024 16:31:04 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Viktor Malik <vmalik@redhat.com>
Subject: Re: [PATCH RFC bpf-next 0/4] bpf: Add support to attach return prog
 in kprobe multi
Message-ID: <ZceWuIgsmiLYyCxQ@krava>
References: <20240207153550.856536-1-jolsa@kernel.org>
 <CAEf4BzZdPJWUiu9yNMsecB-tq0tHCLhrSF47b=w23fPevg=EWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZdPJWUiu9yNMsecB-tq0tHCLhrSF47b=w23fPevg=EWg@mail.gmail.com>

On Thu, Feb 08, 2024 at 11:35:18AM -0800, Andrii Nakryiko wrote:
> On Wed, Feb 7, 2024 at 7:35 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > hi,
> > adding support to attach both entry and return bpf program on single
> > kprobe multi link.
> >
> > Having entry together with return probe for given function is common
> > use case for tetragon, bpftrace and most likely for others.
> >
> > At the moment if we want both entry and return probe to execute bpf
> > program we need to create two (entry and return probe) links. The link
> > for return probe creates extra entry probe to setup the return probe.
> > The extra entry probe execution could be omitted if we had a way to
> > use just single link for both entry and exit probe.
> >
> > In addition it's possible to control the execution of the return probe
> > with the return value of the entry bpf program. If the entry program
> > returns 0 the return probe is installed and executed, otherwise it's
> > skip.
> >
> 
> In general, I think this is a very useful ability to have a combined
> entry/return program.

great, thanks

> 
> But the way you implement it with extra flag and extra fd parameter
> makes it harder to have a nice high-level support in libbpf (and
> presumably other BPF loader libraries) for this.
> 
> When I was thinking about doing something like this, I was considering
> adding a new program type, actually. That way it's possible to define
> this "let's skip return probe" protocol without backwards
> compatibility concerns. It's easier to use it declaratively in libbpf.

ok, that seems cleaner.. but we need to use current kprobe programs,
so not sure at the moment how would that fit in.. did you mean new
link type?

> You just declare SEC("kprobe.wrap/...") (or whatever the name,
> something to designate that it's both entry and exit probe) as one
> program and in the code there would be some way to determine whether
> we are in entry mode or exit mode (helper or field in the custom
> context type, the latter being faster and more usable, but it's
> probably not critical).

hum, so the single program would be for both entry and exit probe,
I'll need to check how bad it'd be for us, but it'd probably mean
just one extra tail call, so it's likely ok

> 
> Another frequently requested feature and a very common use case is to
> measure duration of the function, so if we have a custom type, we can
> have a field to record entry timestamp and let user calculate

you mean bpf program context right?

> duration, if necessary. Without this users have to pay a bunch of
> extra overhead to record timestamp and put it into hashmap (keyed by
> thread id) or thread local storage (even if they have no other use for
> thread local storage).

sounds good

> 
> Also, consider that a similar concept is applicable to uprobes and we
> should do that as well, in similar fashion. And the above approach
> works for both kprobe/kretprobe and uprobe/uretprobe cases, because
> they have the same pt_regs data structure as a context (even if for
> exit probes most of the values of pt_regs are not that meaningful).

ok, that seems useful for uprobes as well

btw I have another unrelated change in stash that that let you choose
the bpf_prog_active or prog->active re-entry check before program is
executed in krobe_multi link.. I also added extra flag, and it still
seems like good idea to me, thoughts? ;-)

> 
> So anyways, great feature, but let's discuss end-to-end usability
> story before we finalize the implementation?

yep, it does say RFC in the subject ;-)

> 
> 
> > I'm still working on the tetragon change, so I'll be sending non-RFC
> > version once that's ready, meanwhile any ideas and feedback on the
> > approach would be great.
> >
> > The change in bpftrace [1] using the new interface shows speed increase
> > with tracing perf bench messaging:
> >
> >   # perf bench sched messaging -l 100000
> >
> > having system wide bpftrace:
> >
> >   # bpftrace -e 'kprobe:ksys_write { }, kretprobe:ksys_write { }'
> >
> > without bpftrace:
> >
> >   # Running 'sched/messaging' benchmark:
> >   # 20 sender and receiver processes per group
> >   # 10 groups == 400 processes run
> >
> >        Total time: 119.595 [sec]
> >
> >    Performance counter stats for 'perf bench sched messaging -l 100000':
> >
> >      102,419,967,282      cycles:u
> >    5,652,444,107,001      cycles:k
> >    5,782,645,019,612      cycles
> >       22,187,151,206      instructions:u                   #    0.22  insn per cycle
> >    2,979,040,498,455      instructions:k                   #    0.53  insn per cycle
> >
> >        119.671169829 seconds time elapsed
> >
> >         94.959198000 seconds user
> >       1815.371616000 seconds sys
> >
> > with current bpftrace:
> >
> >   # Running 'sched/messaging' benchmark:
> >   # 20 sender and receiver processes per group
> >   # 10 groups == 400 processes run
> >
> >        Total time: 221.153 [sec]
> >
> >    Performance counter stats for 'perf bench sched messaging -l 100000':
> >
> >      125,292,164,504      cycles:u
> 
> btw, why +25% in user space?... this looks weird

hmm right.. maybe there's some bpftrace timer code that got triggered/executed
more times because it takes long to finish the workload? I'll check

thanks,
jirka

> 
> 
> >   10,315,020,393,735      cycles:k
> >   10,501,379,274,042      cycles
> >       22,187,583,545      instructions:u                   #    0.18  insn per cycle
> >    4,856,893,111,303      instructions:k                   #    0.47  insn per cycle
> >
> >        221.229234283 seconds time elapsed
> >
> >        103.792498000 seconds user
> >       3432.643302000 seconds sys
> >
> > with bpftrace using the new interface:
> >
> >   # Running 'sched/messaging' benchmark:
> >   # 20 sender and receiver processes per group
> >   # 10 groups == 400 processes run
> >
> >        Total time: 157.825 [sec]
> >
> >    Performance counter stats for 'perf bench sched messaging -l 100000':
> >
> >      102,423,112,279      cycles:u
> >    7,450,856,354,744      cycles:k
> >    7,584,769,726,693      cycles
> >       22,187,270,661      instructions:u                   #    0.22  insn per cycle
> >    3,985,522,383,425      instructions:k                   #    0.53  insn per cycle
> >
> >        157.900787760 seconds time elapsed
> >
> >         97.953898000 seconds user
> >       2425.314753000 seconds sys
> >
> > thanks,
> > jirka
> >
> >
> > [1] https://github.com/bpftrace/bpftrace/pull/2984
> > ---
> > Jiri Olsa (4):
> >       fprobe: Add entry/exit callbacks types
> >       bpf: Add return prog to kprobe multi
> >       libbpf: Add return_prog_fd to kprobe multi opts
> >       selftests/bpf: Add kprobe multi return prog test
> >
> >  include/linux/fprobe.h                                       |  18 ++++++++++------
> >  include/uapi/linux/bpf.h                                     |   4 +++-
> >  kernel/trace/bpf_trace.c                                     |  50 ++++++++++++++++++++++++++++++++-----------
> >  tools/include/uapi/linux/bpf.h                               |   4 +++-
> >  tools/lib/bpf/bpf.c                                          |   1 +
> >  tools/lib/bpf/bpf.h                                          |   1 +
> >  tools/lib/bpf/libbpf.c                                       |   5 +++++
> >  tools/lib/bpf/libbpf.h                                       |   6 +++++-
> >  tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c   |  53 +++++++++++++++++++++++++++++++++++++++++++++
> >  tools/testing/selftests/bpf/progs/kprobe_multi_return_prog.c | 105 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  10 files changed, 226 insertions(+), 21 deletions(-)
> >  create mode 100644 tools/testing/selftests/bpf/progs/kprobe_multi_return_prog.c

