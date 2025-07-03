Return-Path: <bpf+bounces-62329-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D3DAF81B9
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 22:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 706E51C28866
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 20:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2066529B20C;
	Thu,  3 Jul 2025 20:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQ0W3c4N"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BCF238C21
	for <bpf@vger.kernel.org>; Thu,  3 Jul 2025 20:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751572899; cv=none; b=V8IBlbmr6pXXneOaSvGqn8ZCMzRwyK2PdQRKLzlIexU10dgwb/3ByVTA4cMT+EpR1EDhV9mTI+BZqAQVWWDREyBHy2SE8oLnW+apY6yBjRs5IRps9F+YWwVR5fxvrANymBdyY2nTYa9YSeajCJsDITmDUyTwD0TuE8Fy3g41MPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751572899; c=relaxed/simple;
	bh=lOOnSlcoKJOwFAggryIAAszQzvYGP5bJ033tpYB7Pps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CK6Gt2AcG1Pcb1CXCR/zavo/KNab2OKAOYeorr9B9aFplTOwQNvge8P6P6eJ3n2jsE/NyTX6OBTqe40sluAV+ahkE9s7P6mFgD7WrWz/SLcV4DXXbWIJsd8zQj2zA55j+LQSLX9m69Z2ZzlBxABzoizmeo39GhfqJVtc0NiZ+/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jQ0W3c4N; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-ae3a604b43bso47831366b.0
        for <bpf@vger.kernel.org>; Thu, 03 Jul 2025 13:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751572894; x=1752177694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MxhV+HF3Uwo6ChAcOwVXBJZ0Epk8e3ImgDRmr5vdT6A=;
        b=jQ0W3c4NgstdDz2MFlOOssIgwtiYSs9tKqpdByAmFbzGpuWGgt6El6kodNp+r8rrM/
         IV8NRHhfDe5+19NANO2Hok7d6k3+zMLUbLIuDslZRGDGKAr1tZgdRbYEja6vuIXHV5x2
         twAKuj0zSu/0w8Nevs5GyklPPvIOjo03AK8OrUZvj1Mq/kG/SmULozz2ZC876lXYEjhT
         h2mbzOnRX/CBDjHmF+drJjZjap6eQGYNuxv/Laker3WEWSt8lBR9oeRe2oMMGxkGrJBV
         n619X7/KI4esEVINIn6Il72GO7aNRITyDIVGDb9LngJAEcNWCI/E5c7Ucv6Ze5013/RY
         eupA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751572894; x=1752177694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MxhV+HF3Uwo6ChAcOwVXBJZ0Epk8e3ImgDRmr5vdT6A=;
        b=UXLs5WIFi6TCf1Rus0MM/eM9YgY/XtqHX2bbTHz2ME9yW5Q+HzVmwlcDp8nDRQSMTu
         /vKDaftIO7lLRpIflmsOHrGQ3eAcq1QBZJaFP9fxQyFRxkodgMwsFRbnSWWv4tZDIocD
         v6OkeFNUkVUE9AkRnaXUNMwcpkATL5DM3qqEBEz8n+q6BITsVNNXS6UMIdAxD/+m45Fu
         xUVD5PtNjberCRqdSpqmbzs7Q6zl2O/nYKJLnkXpQ1AFYDEWzWqts1TKmDbdUHeiVTIN
         UFljpscsFbSICqIFwSRPSwhhxUHkVyPj5QBJ46raK4pbD1ZyO7vhhxwQ3sssRaS1YcGA
         VEaw==
X-Gm-Message-State: AOJu0YzlMyPl6ZmfEi2A0dZ5zHH8LCCw7MtBx/DPAQnE0zw6VHyN2Paz
	eewid0hjkauh2y9LWtZDRh80mTPwOTytbWjh4AApT39kw//8YBmX002aPnJQ962Z/oXRiN2v8Hg
	oIgXtSXbuFov2XyzcP6ziDjYYHJbdDD8=
X-Gm-Gg: ASbGncvxi6F0eXLfbJ5Poy/9d7NeQYr5Ujskw1Z8twNmp5kJsOG6sRiTwAZERfTXGs+
	bxqdEEmQvSabLsvypqTuv3LlExduE5z6pd+P8J+MFJaO7X85v3KVJHvFHkaicJXkceVDnkRSUJ6
	cWT79AiFnDYEY31h5oPVAgPmdvYdw5r0VxQAkBLeu6O2tYtgeu99AAKGz+YaFjUzdqrrbzLZLXY
	ac=
X-Google-Smtp-Source: AGHT+IHxYiKPnGFi8ImKamLyRIa40P8O9x8Q9bQN1W+UHrFzpAU7ZAlBso9NA3FdjPzSy+2a23+afdcWTWlm1oWNaaA=
X-Received: by 2002:a17:906:fd84:b0:ae3:75e5:ff7a with SMTP id
 a640c23a62f3a-ae3d8435199mr479623966b.19.1751572893309; Thu, 03 Jul 2025
 13:01:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702031737.407548-1-memxor@gmail.com> <20250702031737.407548-13-memxor@gmail.com>
 <CABFh=a6_SaqrKHuDtcWTvGBkxL9ekX=rWumgDmWL12Exn5TNrg@mail.gmail.com>
In-Reply-To: <CABFh=a6_SaqrKHuDtcWTvGBkxL9ekX=rWumgDmWL12Exn5TNrg@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 3 Jul 2025 22:00:56 +0200
X-Gm-Features: Ac12FXxOVYbJVP8FPbLi9fppadYaTRvzKu8VfPCpwGcLLhaFLoovOJXFTKbnPpY
Message-ID: <CAP01T75gWczaLQvkw3QMdntsGd-h+kCtGiU8t7u8+ZmCWuWNMg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 12/12] selftests/bpf: Add tests for prog streams
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Barret Rhoden <brho@google.com>, Matt Bobrowski <mattbobrowski@google.com>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 3 Jul 2025 at 21:57, Emil Tsalapatis <emil@etsalapatis.com> wrote:
>
> On Tue, Jul 1, 2025 at 11:17=E2=80=AFPM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > Add selftests to stress test the various facets of the stream API,
> > memory allocation pattern, and ensuring dumping support is tested and
> > functional.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  .../testing/selftests/bpf/prog_tests/stream.c | 141 ++++++++++++++++++
> >  tools/testing/selftests/bpf/progs/stream.c    |  81 ++++++++++
> >  .../testing/selftests/bpf/progs/stream_fail.c |  17 +++
> >  3 files changed, 239 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/stream.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/stream.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/stream_fail.c
> >
>
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
>
> > diff --git a/tools/testing/selftests/bpf/prog_tests/stream.c b/tools/te=
sting/selftests/bpf/prog_tests/stream.c
> > new file mode 100644
> > index 000000000000..d9f0185dca61
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/stream.c
> > @@ -0,0 +1,141 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
> > +#include <test_progs.h>
> > +#include <sys/mman.h>
> > +#include <regex.h>
> > +
> > +#include "stream.skel.h"
> > +#include "stream_fail.skel.h"
> > +
> > +void test_stream_failure(void)
> > +{
> > +       RUN_TESTS(stream_fail);
> > +}
> > +
> > +void test_stream_success(void)
> > +{
> > +       RUN_TESTS(stream);
> > +       return;
> > +}
> > +
> > +struct {
> > +       int prog_off;
> > +       const char *errstr;
> > +} stream_error_arr[] =3D {
> > +       {
> > +               offsetof(struct stream, progs.stream_cond_break),
> > +               "ERROR: Timeout detected for may_goto instruction\n"
> > +               "CPU: [0-9]+ UID: 0 PID: [0-9]+ Comm: .*\n"
> > +               "Call trace:\n"
> > +               "([a-zA-Z_][a-zA-Z0-9_]*\\+0x[0-9a-fA-F]+/0x[0-9a-fA-F]=
+\n"
> > +               "|[ \t]+[^\n]+\n)*",
> > +       },
> > +       {
> > +               offsetof(struct stream, progs.stream_deadlock),
> > +               "ERROR: AA or ABBA deadlock detected for bpf_res_spin_l=
ock\n"
> > +               "Attempted lock   =3D (0x[0-9a-fA-F]+)\n"
> > +               "Total held locks =3D 1\n"
> > +               "Held lock\\[ 0\\] =3D \\1\n"  // Lock address must mat=
ch
> > +               "CPU: [0-9]+ UID: 0 PID: [0-9]+ Comm: .*\n"
> > +               "Call trace:\n"
> > +               "([a-zA-Z_][a-zA-Z0-9_]*\\+0x[0-9a-fA-F]+/0x[0-9a-fA-F]=
+\n"
> > +               "|[ \t]+[^\n]+\n)*",
> > +       },
> > +};
> > +
> > +static int match_regex(const char *pattern, const char *string)
> > +{
> > +       int err, rc;
> > +       regex_t re;
> > +
> > +       err =3D regcomp(&re, pattern, REG_EXTENDED | REG_NEWLINE);
> > +       if (err)
> > +               return -1;
> > +       rc =3D regexec(&re, string, 0, NULL, 0);
> > +       regfree(&re);
> > +       return rc =3D=3D 0 ? 1 : 0;
>
> Nit: You can just return rc and do ASSERT_TRUE(ret > 0) for the result in
> test_stream_errors.

Ack.

>
> > +}
> > +
> > +void test_stream_errors(void)
> > +{
> > +       LIBBPF_OPTS(bpf_test_run_opts, opts);
> > +       LIBBPF_OPTS(bpf_prog_stream_read_opts, ropts);
> > +       struct stream *skel;
> > +       int ret, prog_fd;
> > +       char buf[1024];
> > +
> > +       skel =3D stream__open_and_load();
> > +       if (!ASSERT_OK_PTR(skel, "stream__open_and_load"))
> > +               return;
> > +
> > +       for (int i =3D 0; i < ARRAY_SIZE(stream_error_arr); i++) {
> > +               struct bpf_program **prog;
> > +
> > +               prog =3D (struct bpf_program **)(((char *)skel) + strea=
m_error_arr[i].prog_off);
> > +               prog_fd =3D bpf_program__fd(*prog);
> > +               ret =3D bpf_prog_test_run_opts(prog_fd, &opts);
> > +               ASSERT_OK(ret, "ret");
> > +               ASSERT_OK(opts.retval, "retval");
> > +
> > +#if !defined(__x86_64__)
> > +               ASSERT_TRUE(1, "Timed may_goto unsupported, skip.");
> > +               if (i =3D=3D 0) {
> > +                       ret =3D bpf_prog_stream_read(prog_fd, 2, buf, s=
izeof(buf), &ropts);
> > +                       ASSERT_EQ(ret, 0, "stream read");
> > +                       continue;
> > +               }
> > +#endif
> > +
> > +               ret =3D bpf_prog_stream_read(prog_fd, BPF_STREAM_STDERR=
, buf, sizeof(buf), &ropts);
> > +               ASSERT_GT(ret, 0, "stream read");
> > +               ASSERT_LE(ret, 1023, "len for buf");
> > +               buf[ret] =3D '\0';
> > +
> > +               ret =3D match_regex(stream_error_arr[i].errstr, buf);
> > +               if (!ASSERT_TRUE(ret =3D=3D 1, "regex match"))
> > +                       fprintf(stderr, "Output from stream:\n%s\n", bu=
f);
> > +       }
> > +
> > +       stream__destroy(skel);
> > +}
> > +
> > +void test_stream_syscall(void)
> > +{
> > +       LIBBPF_OPTS(bpf_test_run_opts, opts);
> > +       LIBBPF_OPTS(bpf_prog_stream_read_opts, ropts);
> > +       struct stream *skel;
> > +       int ret, prog_fd;
> > +       char buf[64];
> > +
> > +       skel =3D stream__open_and_load();
> > +       if (!ASSERT_OK_PTR(skel, "stream__open_and_load"))
> > +               return;
> > +
> > +       prog_fd =3D bpf_program__fd(skel->progs.stream_syscall);
> > +       ret =3D bpf_prog_test_run_opts(prog_fd, &opts);
> > +       ASSERT_OK(ret, "ret");
> > +       ASSERT_OK(opts.retval, "retval");
> > +
> > +       ASSERT_LT(bpf_prog_stream_read(0, BPF_STREAM_STDOUT, buf, sizeo=
f(buf), &ropts), 0, "error");
> > +       ret =3D -errno;
> > +       ASSERT_EQ(ret, -EINVAL, "bad prog_fd");
> > +
> > +       ASSERT_LT(bpf_prog_stream_read(prog_fd, 0, buf, sizeof(buf), &r=
opts), 0, "error");
> > +       ret =3D -errno;
> > +       ASSERT_EQ(ret, -ENOENT, "bad stream id");
> > +
> > +       ASSERT_LT(bpf_prog_stream_read(prog_fd, BPF_STREAM_STDOUT, NULL=
, sizeof(buf), NULL), 0, "error");
> > +       ret =3D -errno;
> > +       ASSERT_EQ(ret, -EFAULT, "bad stream buf");
> > +
> > +       ret =3D bpf_prog_stream_read(prog_fd, BPF_STREAM_STDOUT, buf, 2=
, NULL);
> > +       ASSERT_EQ(ret, 2, "bytes");
> > +       ret =3D bpf_prog_stream_read(prog_fd, BPF_STREAM_STDOUT, buf, 2=
, NULL);
> > +       ASSERT_EQ(ret, 1, "bytes");
> > +       ret =3D bpf_prog_stream_read(prog_fd, BPF_STREAM_STDOUT, buf, 1=
, &ropts);
> > +       ASSERT_EQ(ret, 0, "no bytes stdout");
> > +       ret =3D bpf_prog_stream_read(prog_fd, BPF_STREAM_STDERR, buf, 1=
, &ropts);
> > +       ASSERT_EQ(ret, 0, "no bytes stderr");
> > +
> > +       stream__destroy(skel);
> > +}
> > diff --git a/tools/testing/selftests/bpf/progs/stream.c b/tools/testing=
/selftests/bpf/progs/stream.c
> > new file mode 100644
> > index 000000000000..ae163a656082
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/stream.c
> > @@ -0,0 +1,81 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
> > +#include <vmlinux.h>
> > +#include <bpf/bpf_tracing.h>
> > +#include <bpf/bpf_helpers.h>
> > +#include "bpf_misc.h"
> > +#include "bpf_experimental.h"
> > +
> > +struct arr_elem {
> > +       struct bpf_res_spin_lock lock;
> > +};
> > +
> > +struct {
> > +       __uint(type, BPF_MAP_TYPE_ARRAY);
> > +       __uint(max_entries, 1);
> > +       __type(key, int);
> > +       __type(value, struct arr_elem);
> > +} arrmap SEC(".maps");
> > +
> > +#define ENOSPC 28
> > +#define _STR "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
> > +
> > +#define STREAM_STR (u64)(_STR _STR _STR _STR)
>
> Is this unused?

Yep, will drop.

>
> > +
> > +int size;
> > +
> > +SEC("syscall")
> > +__success __retval(0)
> > +int stream_exhaust(void *ctx)
> > +{
> > +       /* Use global variable for loop convergence. */
> > +       size =3D 0;
> > +       bpf_repeat(BPF_MAX_LOOPS) {
> > +               if (bpf_stream_printk(BPF_STDOUT, _STR) =3D=3D -ENOSPC =
&& size =3D=3D 99954)
> > +                       return 0;
> > +               size +=3D sizeof(_STR) - 1;
> > +       }
> > +       return 1;
> > +}
> > +
> > +SEC("syscall")
> > +__success __retval(0)
> > +int stream_cond_break(void *ctx)
> > +{
> > +       while (can_loop)
> > +               ;
> > +       return 0;
> > +}
> > +
> > +SEC("syscall")
> > +__success __retval(0)
> > +int stream_deadlock(void *ctx)
> > +{
> > +       struct bpf_res_spin_lock *lock, *nlock;
> > +
> > +       lock =3D bpf_map_lookup_elem(&arrmap, &(int){0});
> > +       if (!lock)
> > +               return 0;
>
> Nit: Maybe change the unexpected failure paths to non-zero?
> If they are followed then the test stderr output will fail the regex
> in userspace, but still it would be nice to immediately be able
> to see which step broke.

Good catch, will fix. We should definitely not return 0.

>
> > +       nlock =3D bpf_map_lookup_elem(&arrmap, &(int){0});
> > +       if (!nlock)
> > +               return 0;
> > +       if (bpf_res_spin_lock(lock))
> > +               return 0;
> > +       if (bpf_res_spin_lock(nlock)) {
> > +               bpf_res_spin_unlock(lock);
> > +               return 0;
> > +       }
> > +       bpf_res_spin_unlock(nlock);
> > +       bpf_res_spin_unlock(lock);
> > +       return 0;
> > +}
> > +
> > +SEC("syscall")
> > +__success __retval(0)
> > +int stream_syscall(void *ctx)
> > +{
> > +       bpf_stream_printk(BPF_STDOUT, "foo");
> > +       return 0;
> > +}
> > +
> > +char _license[] SEC("license") =3D "GPL";
> > diff --git a/tools/testing/selftests/bpf/progs/stream_fail.c b/tools/te=
sting/selftests/bpf/progs/stream_fail.c
> > new file mode 100644
> > index 000000000000..12004d5092b7
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/stream_fail.c
> > @@ -0,0 +1,17 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
> > +#include <vmlinux.h>
> > +#include <bpf/bpf_tracing.h>
> > +#include <bpf/bpf_helpers.h>
> > +#include <bpf/bpf_core_read.h>
> > +#include "bpf_misc.h"
> > +
> > +SEC("syscall")
> > +__failure __msg("Possibly NULL pointer passed")
> > +int stream_vprintk_null_arg(void *ctx)
> > +{
> > +       bpf_stream_vprintk(BPF_STDOUT, "", NULL, 0, NULL);
> > +       return 0;
> > +}
> > +
>
> Possibly add a test passing a random scalar as the pointer? Though if the
> test above succeeds, the verifier properly identifies the argument as a p=
ointer
> arg so it wouldn't give any extra signal.

Yeah, I can add one more, and this is the only interface to streams
visible to the program.

>
>
> > +char _license[] SEC("license") =3D "GPL";
> > --
> > 2.47.1
> >

