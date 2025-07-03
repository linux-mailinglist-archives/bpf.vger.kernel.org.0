Return-Path: <bpf+bounces-62326-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D67AF81AB
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 21:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EDA7584F2A
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 19:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF3A2FA65B;
	Thu,  3 Jul 2025 19:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="BAXAQjwb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFE025228C
	for <bpf@vger.kernel.org>; Thu,  3 Jul 2025 19:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751572646; cv=none; b=DWi9vSkJ8p9dtPpp/aL/SMwnIYK7LbCHgTqARcvUwSfpnwqjjXTAktdkissGnWYugs1PO+2LEmFwVpMqk2LQTi1kls7sRimfbu0H43xJgBC6hQyF60wU92mZqM6DYlDZ3Cgzwkb1UM4gi9EBomAHMD2mbIH2ebf7JukOv9UMt3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751572646; c=relaxed/simple;
	bh=oMnsOs3v8cBTntFqDhIIZjieqyyMNCEpC+z1nBg1DFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eaWB9yMjy5mvRIjgptTwu4TT18Hy7Ub+2/NFpwVhhyob+Addn12fJDgWhhxQFSVcxuLzuZ14djZdYMCLPqT/6pelvchioaEc4qI4ur1POnoThNIEbmzpWBjaCJ+3uIzyPzAbCy2pTs5fQvWXH2kNpKyPP5m/UJQu5RSlp6tD6yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=BAXAQjwb; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-710fd2d0372so11531137b3.0
        for <bpf@vger.kernel.org>; Thu, 03 Jul 2025 12:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1751572643; x=1752177443; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KKtoiAtIXaCA5J/qQETEklZJQupgWmigyMX5deuW8dY=;
        b=BAXAQjwbVdiqu/NVJT51V5oKi9/BgEaCe2nPNpeXRQVULezfJmM3skHZFafzopcP7Q
         OddfiLaVbq3eiSQjjc9tSQDZOrimMEp76+V8zGcQk1ywGp2rskhBr/WBpOzeIvxMmOS8
         gdNhvTE6VoanOwZWcUfLyZOvreISs6R79fBdN+smsn7DW0x4MWUW/uYemnlvdHUcz5Hi
         nvZz2iem7cyD3Vhz+XYBh6I7+yo0HdIXcaxFKermIj11ui1rbuLRnTDAS73sHd2lpxc+
         Em6qA0mtBGFZUSoLsYrkG7uGP1Bi+yePVAuu7MV2BV+9fXkmJEPnsi+MyA2WhuxaDx0r
         PcJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751572643; x=1752177443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KKtoiAtIXaCA5J/qQETEklZJQupgWmigyMX5deuW8dY=;
        b=GQSDOXDx0e1rQ2YoPMT7gh+XzwV2p+oYexsVmL9wDJ2k+Ztc7Zfp8/9hT1NpBpXynF
         xIp/OAo2FR0LFpNYZx2UGFUQQujVaqifOw1orfZGWafX+4YFOOaiZ0uBkyJK59zN4MUG
         VvbpG+769Peus7PRWuUAKdQ5LNVCoI5KxsvE8rckP4e6knf4uUiOifUSU2tJ0naDdhrA
         Hayz+MVb1P0UDdNWpSkTtxiUZ/S9weRw0cwY+kFsG8fOu3M+sk+Mw1jCkgppYvEsiuzX
         d5AbxreT/Q7QZkSQL/jOW8GrgjTJ6RvHuqCtS7iFKmA84PwFx2ADxlUxB6DGfBJ4KGWz
         HKrA==
X-Gm-Message-State: AOJu0YxqSgRWKL/zvuP+ZW/p9ihV6c22VWGWhJ5CN3rd5wZFO+iSirmf
	V3DMugmR+ExnAb4C+mKSIQPRY9p7xO1EQPUs1DXMmfIvFUlS+R+1DyRAm1+GzIaCzN4bV/QnmEQ
	mv0mNuGUTG879T2uRdhzecIDX2BYCOrQ14gmSSophKw==
X-Gm-Gg: ASbGnctJhCFf+wvyDDWjhSlWrLA+OWgxUYN0vFJTrzE3DXpJnKGna11L1AC893QM+6m
	Dq5G7+OsFid1iFB7tZhIY2Nu6eY/4BFvqBv9h3YJ+nlu6NMNOHMR0ueYnoQx3STB6DRoEv6EzUO
	T2SvNqEweIZWw7dwpQDayPCpMPDJcunLhlMTk2i5Xni9Ga
X-Google-Smtp-Source: AGHT+IHq2zp7OVn4r725mcFOaWns5fFWgt7Ip4E4wFHJGprUuiNtu3qlJ5wX/yylxWrBHSXrFdQgXLVDE9xvclBAaJg=
X-Received: by 2002:a05:690c:6701:b0:712:e082:4300 with SMTP id
 00721157ae682-71667eccfbcmr3114417b3.14.1751572642903; Thu, 03 Jul 2025
 12:57:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702031737.407548-1-memxor@gmail.com> <20250702031737.407548-13-memxor@gmail.com>
In-Reply-To: <20250702031737.407548-13-memxor@gmail.com>
From: Emil Tsalapatis <emil@etsalapatis.com>
Date: Thu, 3 Jul 2025 15:57:12 -0400
X-Gm-Features: Ac12FXyitOetvEk3LLIq5v2_IAjkKNmCal94FnqLx3kw7IH_aAk2c-1MePzbOd8
Message-ID: <CABFh=a6_SaqrKHuDtcWTvGBkxL9ekX=rWumgDmWL12Exn5TNrg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 12/12] selftests/bpf: Add tests for prog streams
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Barret Rhoden <brho@google.com>, Matt Bobrowski <mattbobrowski@google.com>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 11:17=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Add selftests to stress test the various facets of the stream API,
> memory allocation pattern, and ensuring dumping support is tested and
> functional.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  .../testing/selftests/bpf/prog_tests/stream.c | 141 ++++++++++++++++++
>  tools/testing/selftests/bpf/progs/stream.c    |  81 ++++++++++
>  .../testing/selftests/bpf/progs/stream_fail.c |  17 +++
>  3 files changed, 239 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/stream.c
>  create mode 100644 tools/testing/selftests/bpf/progs/stream.c
>  create mode 100644 tools/testing/selftests/bpf/progs/stream_fail.c
>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> diff --git a/tools/testing/selftests/bpf/prog_tests/stream.c b/tools/test=
ing/selftests/bpf/prog_tests/stream.c
> new file mode 100644
> index 000000000000..d9f0185dca61
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/stream.c
> @@ -0,0 +1,141 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
> +#include <test_progs.h>
> +#include <sys/mman.h>
> +#include <regex.h>
> +
> +#include "stream.skel.h"
> +#include "stream_fail.skel.h"
> +
> +void test_stream_failure(void)
> +{
> +       RUN_TESTS(stream_fail);
> +}
> +
> +void test_stream_success(void)
> +{
> +       RUN_TESTS(stream);
> +       return;
> +}
> +
> +struct {
> +       int prog_off;
> +       const char *errstr;
> +} stream_error_arr[] =3D {
> +       {
> +               offsetof(struct stream, progs.stream_cond_break),
> +               "ERROR: Timeout detected for may_goto instruction\n"
> +               "CPU: [0-9]+ UID: 0 PID: [0-9]+ Comm: .*\n"
> +               "Call trace:\n"
> +               "([a-zA-Z_][a-zA-Z0-9_]*\\+0x[0-9a-fA-F]+/0x[0-9a-fA-F]+\=
n"
> +               "|[ \t]+[^\n]+\n)*",
> +       },
> +       {
> +               offsetof(struct stream, progs.stream_deadlock),
> +               "ERROR: AA or ABBA deadlock detected for bpf_res_spin_loc=
k\n"
> +               "Attempted lock   =3D (0x[0-9a-fA-F]+)\n"
> +               "Total held locks =3D 1\n"
> +               "Held lock\\[ 0\\] =3D \\1\n"  // Lock address must match
> +               "CPU: [0-9]+ UID: 0 PID: [0-9]+ Comm: .*\n"
> +               "Call trace:\n"
> +               "([a-zA-Z_][a-zA-Z0-9_]*\\+0x[0-9a-fA-F]+/0x[0-9a-fA-F]+\=
n"
> +               "|[ \t]+[^\n]+\n)*",
> +       },
> +};
> +
> +static int match_regex(const char *pattern, const char *string)
> +{
> +       int err, rc;
> +       regex_t re;
> +
> +       err =3D regcomp(&re, pattern, REG_EXTENDED | REG_NEWLINE);
> +       if (err)
> +               return -1;
> +       rc =3D regexec(&re, string, 0, NULL, 0);
> +       regfree(&re);
> +       return rc =3D=3D 0 ? 1 : 0;

Nit: You can just return rc and do ASSERT_TRUE(ret > 0) for the result in
test_stream_errors.

> +}
> +
> +void test_stream_errors(void)
> +{
> +       LIBBPF_OPTS(bpf_test_run_opts, opts);
> +       LIBBPF_OPTS(bpf_prog_stream_read_opts, ropts);
> +       struct stream *skel;
> +       int ret, prog_fd;
> +       char buf[1024];
> +
> +       skel =3D stream__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "stream__open_and_load"))
> +               return;
> +
> +       for (int i =3D 0; i < ARRAY_SIZE(stream_error_arr); i++) {
> +               struct bpf_program **prog;
> +
> +               prog =3D (struct bpf_program **)(((char *)skel) + stream_=
error_arr[i].prog_off);
> +               prog_fd =3D bpf_program__fd(*prog);
> +               ret =3D bpf_prog_test_run_opts(prog_fd, &opts);
> +               ASSERT_OK(ret, "ret");
> +               ASSERT_OK(opts.retval, "retval");
> +
> +#if !defined(__x86_64__)
> +               ASSERT_TRUE(1, "Timed may_goto unsupported, skip.");
> +               if (i =3D=3D 0) {
> +                       ret =3D bpf_prog_stream_read(prog_fd, 2, buf, siz=
eof(buf), &ropts);
> +                       ASSERT_EQ(ret, 0, "stream read");
> +                       continue;
> +               }
> +#endif
> +
> +               ret =3D bpf_prog_stream_read(prog_fd, BPF_STREAM_STDERR, =
buf, sizeof(buf), &ropts);
> +               ASSERT_GT(ret, 0, "stream read");
> +               ASSERT_LE(ret, 1023, "len for buf");
> +               buf[ret] =3D '\0';
> +
> +               ret =3D match_regex(stream_error_arr[i].errstr, buf);
> +               if (!ASSERT_TRUE(ret =3D=3D 1, "regex match"))
> +                       fprintf(stderr, "Output from stream:\n%s\n", buf)=
;
> +       }
> +
> +       stream__destroy(skel);
> +}
> +
> +void test_stream_syscall(void)
> +{
> +       LIBBPF_OPTS(bpf_test_run_opts, opts);
> +       LIBBPF_OPTS(bpf_prog_stream_read_opts, ropts);
> +       struct stream *skel;
> +       int ret, prog_fd;
> +       char buf[64];
> +
> +       skel =3D stream__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "stream__open_and_load"))
> +               return;
> +
> +       prog_fd =3D bpf_program__fd(skel->progs.stream_syscall);
> +       ret =3D bpf_prog_test_run_opts(prog_fd, &opts);
> +       ASSERT_OK(ret, "ret");
> +       ASSERT_OK(opts.retval, "retval");
> +
> +       ASSERT_LT(bpf_prog_stream_read(0, BPF_STREAM_STDOUT, buf, sizeof(=
buf), &ropts), 0, "error");
> +       ret =3D -errno;
> +       ASSERT_EQ(ret, -EINVAL, "bad prog_fd");
> +
> +       ASSERT_LT(bpf_prog_stream_read(prog_fd, 0, buf, sizeof(buf), &rop=
ts), 0, "error");
> +       ret =3D -errno;
> +       ASSERT_EQ(ret, -ENOENT, "bad stream id");
> +
> +       ASSERT_LT(bpf_prog_stream_read(prog_fd, BPF_STREAM_STDOUT, NULL, =
sizeof(buf), NULL), 0, "error");
> +       ret =3D -errno;
> +       ASSERT_EQ(ret, -EFAULT, "bad stream buf");
> +
> +       ret =3D bpf_prog_stream_read(prog_fd, BPF_STREAM_STDOUT, buf, 2, =
NULL);
> +       ASSERT_EQ(ret, 2, "bytes");
> +       ret =3D bpf_prog_stream_read(prog_fd, BPF_STREAM_STDOUT, buf, 2, =
NULL);
> +       ASSERT_EQ(ret, 1, "bytes");
> +       ret =3D bpf_prog_stream_read(prog_fd, BPF_STREAM_STDOUT, buf, 1, =
&ropts);
> +       ASSERT_EQ(ret, 0, "no bytes stdout");
> +       ret =3D bpf_prog_stream_read(prog_fd, BPF_STREAM_STDERR, buf, 1, =
&ropts);
> +       ASSERT_EQ(ret, 0, "no bytes stderr");
> +
> +       stream__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/stream.c b/tools/testing/s=
elftests/bpf/progs/stream.c
> new file mode 100644
> index 000000000000..ae163a656082
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/stream.c
> @@ -0,0 +1,81 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
> +#include <vmlinux.h>
> +#include <bpf/bpf_tracing.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +#include "bpf_experimental.h"
> +
> +struct arr_elem {
> +       struct bpf_res_spin_lock lock;
> +};
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_ARRAY);
> +       __uint(max_entries, 1);
> +       __type(key, int);
> +       __type(value, struct arr_elem);
> +} arrmap SEC(".maps");
> +
> +#define ENOSPC 28
> +#define _STR "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
> +
> +#define STREAM_STR (u64)(_STR _STR _STR _STR)

Is this unused?

> +
> +int size;
> +
> +SEC("syscall")
> +__success __retval(0)
> +int stream_exhaust(void *ctx)
> +{
> +       /* Use global variable for loop convergence. */
> +       size =3D 0;
> +       bpf_repeat(BPF_MAX_LOOPS) {
> +               if (bpf_stream_printk(BPF_STDOUT, _STR) =3D=3D -ENOSPC &&=
 size =3D=3D 99954)
> +                       return 0;
> +               size +=3D sizeof(_STR) - 1;
> +       }
> +       return 1;
> +}
> +
> +SEC("syscall")
> +__success __retval(0)
> +int stream_cond_break(void *ctx)
> +{
> +       while (can_loop)
> +               ;
> +       return 0;
> +}
> +
> +SEC("syscall")
> +__success __retval(0)
> +int stream_deadlock(void *ctx)
> +{
> +       struct bpf_res_spin_lock *lock, *nlock;
> +
> +       lock =3D bpf_map_lookup_elem(&arrmap, &(int){0});
> +       if (!lock)
> +               return 0;

Nit: Maybe change the unexpected failure paths to non-zero?
If they are followed then the test stderr output will fail the regex
in userspace, but still it would be nice to immediately be able
to see which step broke.

> +       nlock =3D bpf_map_lookup_elem(&arrmap, &(int){0});
> +       if (!nlock)
> +               return 0;
> +       if (bpf_res_spin_lock(lock))
> +               return 0;
> +       if (bpf_res_spin_lock(nlock)) {
> +               bpf_res_spin_unlock(lock);
> +               return 0;
> +       }
> +       bpf_res_spin_unlock(nlock);
> +       bpf_res_spin_unlock(lock);
> +       return 0;
> +}
> +
> +SEC("syscall")
> +__success __retval(0)
> +int stream_syscall(void *ctx)
> +{
> +       bpf_stream_printk(BPF_STDOUT, "foo");
> +       return 0;
> +}
> +
> +char _license[] SEC("license") =3D "GPL";
> diff --git a/tools/testing/selftests/bpf/progs/stream_fail.c b/tools/test=
ing/selftests/bpf/progs/stream_fail.c
> new file mode 100644
> index 000000000000..12004d5092b7
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/stream_fail.c
> @@ -0,0 +1,17 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
> +#include <vmlinux.h>
> +#include <bpf/bpf_tracing.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_core_read.h>
> +#include "bpf_misc.h"
> +
> +SEC("syscall")
> +__failure __msg("Possibly NULL pointer passed")
> +int stream_vprintk_null_arg(void *ctx)
> +{
> +       bpf_stream_vprintk(BPF_STDOUT, "", NULL, 0, NULL);
> +       return 0;
> +}
> +

Possibly add a test passing a random scalar as the pointer? Though if the
test above succeeds, the verifier properly identifies the argument as a poi=
nter
arg so it wouldn't give any extra signal.


> +char _license[] SEC("license") =3D "GPL";
> --
> 2.47.1
>

