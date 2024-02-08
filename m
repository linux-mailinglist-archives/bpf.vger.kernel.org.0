Return-Path: <bpf+bounces-21532-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3461F84E909
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 20:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C42FB308A9
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 19:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1500B381BE;
	Thu,  8 Feb 2024 19:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZagQpeo0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB8D3714E
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 19:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707420932; cv=none; b=ieGJul4ZDe96m+UbJjvjuc96DqYrN6UBy8/gUaQaICL3VQzfw2hjVLQY9M/k/lFu0ocDKC/ZQq+b/fIK6I0F4LBbB5hMEO1DAP0ziFBKzNDkSVypZk83NpIjTamDIKqzKriRnN1MO+yHkCZunAILmyLTtdCPiwX9O4b5yZrI5J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707420932; c=relaxed/simple;
	bh=5rKecV+Ugq/vpFKCAjp0/My4Q4YZ0FAhnOCNZFa9AL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JDapk+7MGvKABEXn3UlAof8h4/Fm/FApE4Et/7WhaSaB2tM1GkTxZMcDXMhMPYxJa/mIRx9RDpaCR4sGIym49n6auknfr4jW22XHNKdMGfb/eA3gd8RNcjGOQMtZbVxm2IJJEWrEyu/BIeUH2kA+Qm2QGzNjfVk99MpEsKOncHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZagQpeo0; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-296e8c8d218so144560a91.3
        for <bpf@vger.kernel.org>; Thu, 08 Feb 2024 11:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707420930; x=1708025730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=67K9dz2k1WC8A2hJTgg+s5iqZIEFf42/rDwd2R3rJnc=;
        b=ZagQpeo0N1mppO7XS8u8ECEASZAAuuDEQwnb+EK8OFjNgLIYkj6aOE+0xuF3qp92PW
         Ajbx491UGWyjMsw4cs7UO5rLWeZNupKqePjH1YN9rQSxiGtqwxDtGgY3/nUQJRarbFMq
         TWRq+QZbOojgztZqfhbsc3xMY8BXn3dca+AQBvI0FAOVGVhia9EZzVQi0L0YfxD6ybeR
         16D1rNFJEdnXMUEaVohu+44P1nRHEO/WPFPNrdoURCK+lRzSU+Dkyth3rn/cHLNe7Zri
         /NpSBnPxJkKITfjwYQzQrSIT/9fBZbA3xc8DxIZzGAWDANK/4juPrgtdkl10fyqpHcnt
         dhzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707420930; x=1708025730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=67K9dz2k1WC8A2hJTgg+s5iqZIEFf42/rDwd2R3rJnc=;
        b=n4GMLgs/RhVtZcwVltTf9CrG/QktollD0H5y/ghtnJegWr3LBQ69HFHJ5lpyQbGOZk
         2aQjUaJtqwb/stcIXlob6LUkeUgXv8ldlVHcf+aWxUJjqwT9DHFOyUTw1d/J+yUw+G90
         V7iFaxyjwZ6iXF4YjQzhwjiZ1h5FK/XzFX2y9lfk9RYXUoHhRHYjL6vbFR+QWqhp7ewi
         G2qM0RMmypTFKjybQwgQyPpgCiClmkuZPuidO/nvzIrnw0g+M/KEXOe7Z83SfgN3DYw8
         dfsIBMlJwAsvxci1eIRP3Uh/qd8MupRoL8jLByoLxd4pJqWCgNjXIw/sUGuKMR5ws6SU
         5CuA==
X-Gm-Message-State: AOJu0YxYq33DXRtRW6FH76NTVUGge2cSbeXfNCWhhZf1YkBlRzVjY4Rw
	vHgbCnJFPQw3O0UE2GI+kmZVxxleyfOJFf1tL9TMvcAc5ijCHt8lIPpb9CXb7DL9BKIafRafA6l
	Km6EofXnVgvzrU9B4tUUL50j/l7I=
X-Google-Smtp-Source: AGHT+IFnMOQgPZW0wZydRCqqaNixAEr/LhIBVufY9hULOkrS9OrvuYEIG9PtwXomcdmkPfDMtCRcTyh2yVyuG31Igdk=
X-Received: by 2002:a17:90b:3d03:b0:297:7d8:e64d with SMTP id
 pt3-20020a17090b3d0300b0029707d8e64dmr175270pjb.1.1707420930283; Thu, 08 Feb
 2024 11:35:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207153550.856536-1-jolsa@kernel.org>
In-Reply-To: <20240207153550.856536-1-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 8 Feb 2024 11:35:18 -0800
Message-ID: <CAEf4BzZdPJWUiu9yNMsecB-tq0tHCLhrSF47b=w23fPevg=EWg@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 0/4] bpf: Add support to attach return prog
 in kprobe multi
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Viktor Malik <vmalik@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 7:35=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> hi,
> adding support to attach both entry and return bpf program on single
> kprobe multi link.
>
> Having entry together with return probe for given function is common
> use case for tetragon, bpftrace and most likely for others.
>
> At the moment if we want both entry and return probe to execute bpf
> program we need to create two (entry and return probe) links. The link
> for return probe creates extra entry probe to setup the return probe.
> The extra entry probe execution could be omitted if we had a way to
> use just single link for both entry and exit probe.
>
> In addition it's possible to control the execution of the return probe
> with the return value of the entry bpf program. If the entry program
> returns 0 the return probe is installed and executed, otherwise it's
> skip.
>

In general, I think this is a very useful ability to have a combined
entry/return program.

But the way you implement it with extra flag and extra fd parameter
makes it harder to have a nice high-level support in libbpf (and
presumably other BPF loader libraries) for this.

When I was thinking about doing something like this, I was considering
adding a new program type, actually. That way it's possible to define
this "let's skip return probe" protocol without backwards
compatibility concerns. It's easier to use it declaratively in libbpf.
You just declare SEC("kprobe.wrap/...") (or whatever the name,
something to designate that it's both entry and exit probe) as one
program and in the code there would be some way to determine whether
we are in entry mode or exit mode (helper or field in the custom
context type, the latter being faster and more usable, but it's
probably not critical).

Another frequently requested feature and a very common use case is to
measure duration of the function, so if we have a custom type, we can
have a field to record entry timestamp and let user calculate
duration, if necessary. Without this users have to pay a bunch of
extra overhead to record timestamp and put it into hashmap (keyed by
thread id) or thread local storage (even if they have no other use for
thread local storage).

Also, consider that a similar concept is applicable to uprobes and we
should do that as well, in similar fashion. And the above approach
works for both kprobe/kretprobe and uprobe/uretprobe cases, because
they have the same pt_regs data structure as a context (even if for
exit probes most of the values of pt_regs are not that meaningful).

So anyways, great feature, but let's discuss end-to-end usability
story before we finalize the implementation?


> I'm still working on the tetragon change, so I'll be sending non-RFC
> version once that's ready, meanwhile any ideas and feedback on the
> approach would be great.
>
> The change in bpftrace [1] using the new interface shows speed increase
> with tracing perf bench messaging:
>
>   # perf bench sched messaging -l 100000
>
> having system wide bpftrace:
>
>   # bpftrace -e 'kprobe:ksys_write { }, kretprobe:ksys_write { }'
>
> without bpftrace:
>
>   # Running 'sched/messaging' benchmark:
>   # 20 sender and receiver processes per group
>   # 10 groups =3D=3D 400 processes run
>
>        Total time: 119.595 [sec]
>
>    Performance counter stats for 'perf bench sched messaging -l 100000':
>
>      102,419,967,282      cycles:u
>    5,652,444,107,001      cycles:k
>    5,782,645,019,612      cycles
>       22,187,151,206      instructions:u                   #    0.22  ins=
n per cycle
>    2,979,040,498,455      instructions:k                   #    0.53  ins=
n per cycle
>
>        119.671169829 seconds time elapsed
>
>         94.959198000 seconds user
>       1815.371616000 seconds sys
>
> with current bpftrace:
>
>   # Running 'sched/messaging' benchmark:
>   # 20 sender and receiver processes per group
>   # 10 groups =3D=3D 400 processes run
>
>        Total time: 221.153 [sec]
>
>    Performance counter stats for 'perf bench sched messaging -l 100000':
>
>      125,292,164,504      cycles:u

btw, why +25% in user space?... this looks weird


>   10,315,020,393,735      cycles:k
>   10,501,379,274,042      cycles
>       22,187,583,545      instructions:u                   #    0.18  ins=
n per cycle
>    4,856,893,111,303      instructions:k                   #    0.47  ins=
n per cycle
>
>        221.229234283 seconds time elapsed
>
>        103.792498000 seconds user
>       3432.643302000 seconds sys
>
> with bpftrace using the new interface:
>
>   # Running 'sched/messaging' benchmark:
>   # 20 sender and receiver processes per group
>   # 10 groups =3D=3D 400 processes run
>
>        Total time: 157.825 [sec]
>
>    Performance counter stats for 'perf bench sched messaging -l 100000':
>
>      102,423,112,279      cycles:u
>    7,450,856,354,744      cycles:k
>    7,584,769,726,693      cycles
>       22,187,270,661      instructions:u                   #    0.22  ins=
n per cycle
>    3,985,522,383,425      instructions:k                   #    0.53  ins=
n per cycle
>
>        157.900787760 seconds time elapsed
>
>         97.953898000 seconds user
>       2425.314753000 seconds sys
>
> thanks,
> jirka
>
>
> [1] https://github.com/bpftrace/bpftrace/pull/2984
> ---
> Jiri Olsa (4):
>       fprobe: Add entry/exit callbacks types
>       bpf: Add return prog to kprobe multi
>       libbpf: Add return_prog_fd to kprobe multi opts
>       selftests/bpf: Add kprobe multi return prog test
>
>  include/linux/fprobe.h                                       |  18 +++++=
+++++------
>  include/uapi/linux/bpf.h                                     |   4 +++-
>  kernel/trace/bpf_trace.c                                     |  50 +++++=
+++++++++++++++++++++++++++-----------
>  tools/include/uapi/linux/bpf.h                               |   4 +++-
>  tools/lib/bpf/bpf.c                                          |   1 +
>  tools/lib/bpf/bpf.h                                          |   1 +
>  tools/lib/bpf/libbpf.c                                       |   5 +++++
>  tools/lib/bpf/libbpf.h                                       |   6 +++++=
-
>  tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c   |  53 +++++=
++++++++++++++++++++++++++++++++++++++++
>  tools/testing/selftests/bpf/progs/kprobe_multi_return_prog.c | 105 +++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++
>  10 files changed, 226 insertions(+), 21 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/kprobe_multi_return=
_prog.c

