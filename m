Return-Path: <bpf+bounces-69435-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35149B967BC
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 17:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FD38161D56
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 14:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3520521FF30;
	Tue, 23 Sep 2025 14:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWWIkEJP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BA3223707
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 14:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758639591; cv=none; b=neQGFR0iuv9BS2r4VUWP/nkURbeeuFsCcvvqnwXK1GO3X2MR36nMKs5RnjuMnBrxn0oywjZVkx0cIneVlBalWclsnE6lt33cZvyqoENJSsWhXBsdPvT48TQZyLiWYZDrs7uLGymfJyKUOlVUy45N7x/T4KD+r+N/w3VsH5VM+Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758639591; c=relaxed/simple;
	bh=/sf6RSk0HtIi/tuM6nyQHk9n66TRqqeIrI3ZDHgS3q4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mnFQB38QOXVtMryuo/5HFO7VCo7SufLTAyfPuhR4Qc8xFz7GmXmB12hLBDuQL1vlpWf7JqGP7MBSkPIoD+oFnaeHj61h27/keh9w44GCaUtXmoltC0iCDTpytmt/hcAH+oWL77qcHIzB6nELS96ZMbAAHU4S2ded3yqnQbshXbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWWIkEJP; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3fc36b99e92so1551751f8f.0
        for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 07:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758639588; x=1759244388; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=buaTp1Y5bpwMLpCiXRtyfdNJDd622oze9rQ7afd7ndU=;
        b=IWWIkEJP8nWNEN7D89dq9czIpYbLDp+9CwZW1OydV31DH5pcwdfj+HOUkc2slTNhZ8
         G0+v3zkisG5D3s902s+ck4Lq32CwG7el7Q8tyBSXsYdfAkstT1IpigxE4qacfUFw7V23
         A0hyAubbepJqlx+ieNnvq4YkY6Fmr1U3fl0Lqgb1zJbq0qPlAxh4XhNE2ncYXkiG/rsH
         hMoe2RUZX4aFX0OU8S2CJ5h4pwpkFEvQGo/lLDl+GMBOqytLtcV0ZeGxRGiX47LQ/RUM
         yz+yRQBvyK6wHYgwLm/BsdmKA9dA6gM5qEoiQgPA3qWZFZZR8sqvDwTfFQLr32QjagpF
         /ZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758639588; x=1759244388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=buaTp1Y5bpwMLpCiXRtyfdNJDd622oze9rQ7afd7ndU=;
        b=VHmGzdof9quFWsZA7bZ6w0wMpC8iWpDAyK6mKnj+LF4Koip7GWRN+ok5lisZH5iIiB
         /JgdqYDGWxES16rnC+oHOEZo5/EdjDCFMTt/7gygb7WudEUGuNz8U4FpEvwAcn0RcJiv
         19LFQ5lh6qwOKAKOTBJi0h6qyHr4/7qXR3VWAc+BOo6k4rbHrm1WH1V7u1TCCjyaCyOo
         XhvnQgd72g9YJlRdGJS7szDdilssYtyjmnQIq1al+ufo9saYhzxKeIfXuyakYbISbxtX
         d94H39y+rKfbGcBUxyAPGHBxUb1nszeJvuKq3gg0SY7zmVUtrQZhZHXhgmvYPyCkPw9g
         NuYg==
X-Gm-Message-State: AOJu0YxxSRF6ENAi6VBHkrTlB9th6bhTY+lt9i/zxvU8vz8t8TaNRH9N
	oQGJNGJvp/b/TLDQP4gY0aVIF2bpLwu6J3Y4pQbMdCtd3u2AAqlEDrW3/Xu0v/sYUgM42rGdbb5
	gCS72FubNMf6s08jD3zaQ1TniW8C2mzM=
X-Gm-Gg: ASbGncs2IRYn3YoMSo1KNO+zaAfT4v603Z2s3jeIf+NFWsipGmGRZYGc5lKtbWHCTSa
	ILoKX+A4XY5BnZ0j9VdR3ABE7HLJWvFYFhD/6wvolnujKFEAROJU9xBD5SAjLlskFBLUo0CC7bB
	aPQYBDdZ2HiHbdtNxP/bzJ4Ed7g2YO39dl0Pe6AC59NzgGAa6fu0Pfw1i0Yn4mCxh40Y2dlfG/K
	6qQX1KzKc4QNzEmtXdOagHVFhidY954eHbx
X-Google-Smtp-Source: AGHT+IGzOpNyvl3CRUPdTwj25PXXyXMNNId9iD4LzEXRIB1miahgWI7xHndd8EYh9luJiIdvPHAj10hXKvxEw6LbIyE=
X-Received: by 2002:a05:6000:40c7:b0:3ea:63d:44a8 with SMTP id
 ffacd0b85a97d-405d090c6f8mr2778670f8f.15.1758639588133; Tue, 23 Sep 2025
 07:59:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923112404.668720-1-mykyta.yatsenko5@gmail.com> <20250923112404.668720-9-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250923112404.668720-9-mykyta.yatsenko5@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 23 Sep 2025 07:59:37 -0700
X-Gm-Features: AS18NWC1jO4b1efqg-44Q68WprwhFWx99dI9t8Y1QnraHaSXhJmy2QXBpsHgH04
Message-ID: <CAADnVQKS0bWcSJns4zF_mmKnh4+is3faM5wPt1O-Y0FdiP7UeQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 8/9] selftests/bpf: BPF task work scheduling tests
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 4:24=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
> +static void task_work_run(const char *prog_name, const char *map_name)
> +{
> +       struct task_work *skel;
> +       struct bpf_program *prog;
> +       struct bpf_map *map;
> +       struct bpf_link *link;
> +       int err, pe_fd =3D 0, pid, status, pipefd[2];
> +       char user_string[] =3D "hello world";
> +
> +       if (!ASSERT_NEQ(pipe(pipefd), -1, "pipe"))
> +               return;
> +
> +       pid =3D fork();
> +       if (pid =3D=3D 0) {
> +               __u64 num =3D 1;
> +               int i;
> +               char buf;
> +
> +               close(pipefd[1]);
> +               read(pipefd[0], &buf, sizeof(buf));
> +               close(pipefd[0]);
> +
> +               for (i =3D 0; i < 10000; ++i)
> +                       num *=3D time(0) % 7;
> +               (void)num;
> +               exit(0);
> +       }
> +       ASSERT_GT(pid, 0, "fork() failed");
> +
> +       skel =3D task_work__open();
> +       if (!ASSERT_OK_PTR(skel, "task_work__open"))
> +               return;
> +
> +       bpf_object__for_each_program(prog, skel->obj) {
> +               bpf_program__set_autoload(prog, false);
> +       }
> +
> +       prog =3D bpf_object__find_program_by_name(skel->obj, prog_name);
> +       if (!ASSERT_OK_PTR(prog, "prog_name"))
> +               goto cleanup;
> +       bpf_program__set_autoload(prog, true);
> +       skel->bss->user_ptr =3D (char *)user_string;
> +
> +       err =3D task_work__load(skel);
> +       if (!ASSERT_OK(err, "skel_load"))
> +               goto cleanup;
> +
> +       pe_fd =3D perf_event_open(PERF_TYPE_HARDWARE, PERF_COUNT_HW_CPU_C=
YCLES, pid);
> +       if (pe_fd =3D=3D -1 && (errno =3D=3D ENOENT || errno =3D=3D EOPNO=
TSUPP)) {
> +               printf("%s:SKIP:no PERF_COUNT_HW_CPU_CYCLES\n", __func__)=
;
> +               test__skip();
> +               goto cleanup;
> +       }
> +       if (!ASSERT_NEQ(pe_fd, -1, "pe_fd")) {
> +               fprintf(stderr, "perf_event_open errno: %d, pid: %d\n", e=
rrno, pid);
> +               goto cleanup;
> +       }
> +
> +       link =3D bpf_program__attach_perf_event(prog, pe_fd);
> +       if (!ASSERT_OK_PTR(link, "attach_perf_event"))
> +               goto cleanup;
> +
> +       close(pipefd[0]);
> +       write(pipefd[1], user_string, 1);
> +       close(pipefd[1]);
> +       /* Wait to collect some samples */
> +       waitpid(pid, &status, 0);
> +       pid =3D 0;
> +       map =3D bpf_object__find_map_by_name(skel->obj, map_name);
> +       if (!ASSERT_OK_PTR(map, "find map_name"))
> +               goto cleanup;
> +       if (!ASSERT_OK(verify_map(map, user_string), "verify map"))
> +               goto cleanup;
> +cleanup:
> +       if (pe_fd >=3D 0)
> +               close(pe_fd);
> +       task_work__destroy(skel);
> +       if (pid) {
> +               close(pipefd[0]);
> +               write(pipefd[1], user_string, 1);
> +               close(pipefd[1]);
> +               waitpid(pid, &status, 0);
> +       }
> +}

Applied, but this one is buggy.
It seems to be missing perf_event cleanup.
Pls send a fix asap.

./test_progs -t bpf_cookie
...
#18      bpf_cookie:OK
Summary: 1/11 PASSED, 0 SKIPPED, 0 FAILED

./test_progs -t task_work
...
#434     task_work:OK
#435/1   task_work_stress/no_delete:OK
#435/2   task_work_stress/with_delete:OK
#435     task_work_stress:OK
Summary: 2/9 PASSED, 0 SKIPPED, 0 FAILED

./test_progs -t bpf_cookie
test_bpf_cookie:PASS:skel_open 0 nsec
#18/1    bpf_cookie/kprobe:OK
#18/2    bpf_cookie/multi_kprobe_link_api:OK
#18/3    bpf_cookie/multi_kprobe_attach_api:OK
#18/4    bpf_cookie/uprobe:OK
#18/5    bpf_cookie/multi_uprobe_attach_api:OK
#18/6    bpf_cookie/tracepoint:OK
pe_subtest:FAIL:perf_fd unexpected perf_fd: actual -1 < expected 0
#18/7    bpf_cookie/perf_event:FAIL
#18/8    bpf_cookie/trampoline:OK
#18/9    bpf_cookie/lsm:OK
#18/10   bpf_cookie/tp_btf:OK
#18/11   bpf_cookie/raw_tp:OK
#18      bpf_cookie:FAIL


Ihor,

we probably should extend CI to run test_progs twice in the same VM
to catch such cleanup issues.

