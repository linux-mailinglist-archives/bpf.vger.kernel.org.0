Return-Path: <bpf+bounces-43799-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BD09B9B91
	for <lists+bpf@lfdr.de>; Sat,  2 Nov 2024 01:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E26681C21106
	for <lists+bpf@lfdr.de>; Sat,  2 Nov 2024 00:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4024A23;
	Sat,  2 Nov 2024 00:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKeDiPUX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF45A920
	for <bpf@vger.kernel.org>; Sat,  2 Nov 2024 00:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730507404; cv=none; b=AOWVlFiI1ZlloS6TPnF00j7P9wEHgZTejYXi7f/0GMW0CKHKY2RUTaT8B6rSiQu08E9V+1v9WYBJ5i+y0GiVsFYjla0Q4b1bf3ka3LvnSUiBE3RkGOURp8fVhJkbSuDJ8KQAGxxBwjHSDAyXX1m3KuIfVgilUVzWyuiAf0QXKnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730507404; c=relaxed/simple;
	bh=aU5mq9QOCluPyRGJiqlVEYYYr7f4ynv5hd5El4tI9Jo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hmjY1cJqv5WnZcna0eIWMlnM+JTYGWP/+0FKzgjegJlJq9e/DLumhcnpb3+1/qMuR7TxXmJS/xJp/c0gZZKiIUi9PX7rlCndAoYOhE9SMWQJlzGEilkfqK/30lCsIyhy/XVzC6iF2VUPYpFMvCF5waVAlzOm4wLR3P5o3MBGl3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CKeDiPUX; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43155afca99so21140595e9.1
        for <bpf@vger.kernel.org>; Fri, 01 Nov 2024 17:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730507400; x=1731112200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rRDfaSJDlapexlFdLCk2k9sVN8NMgeUEunaMamgLBio=;
        b=CKeDiPUXiqxBq8tbzNodJ4uceJoFrFcDajTzTeYNrhK7jBJe+xDNdPsHhKm9OfBnmS
         1hMmmTR+6yjbWl4cQ8M/kfT+x6Ce+GMxyNvoEuEtinCEumpHrD/g1udWBQfb3kMN1iik
         5E6GvmRwwDwX7Mvd+KWNe3TxRUK9dKTL2l7/Yu3HNwpA31VMOowU8lQMth/QmcXUEIbk
         QWz/3Jrvo+nxl2c2RoE0pnN0kTDZrgpeHq4i5EV9IjtMLxkkdM5p1nvOlRSHu8X776Ol
         bX+sQW9JdKL4S3d0P8UP/JxmFt7JtUu1r9Vc4UdqZ6kSXMxgsUNqlHbJUKxGYw5dCcUb
         SYNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730507400; x=1731112200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rRDfaSJDlapexlFdLCk2k9sVN8NMgeUEunaMamgLBio=;
        b=RXc/QMM6zjYDH+dYbiyfQ6IC3d4TTTTW4QRRM15pmGIlN5Wqvi/8XBHdOs6YJ0eXyF
         3NzwLtdpVVf2C9No9BOvTGjsuFtCBh+Zi4953Cz5mYXnDdZmiT408TWmIQlzMh8SCNPz
         1x4V+gI9bm3G4sg1r+sgGqHDQmizVIu034RMVOyoRvsfYk1WRJEfZ5+YA2Q+RXEainFs
         XLEvrwTtp1y0jm2Ndv/wIsIh68y5cJcTuWIfvNYZ+pQbACVAB47spYc0X/gnJam5xJZS
         mmD8m8qW6bXOD4tYV/hASxtKXjEERnJhltvQ/pXCOx9VltTkAJrHDIsUOyLroN2JIW9S
         CKog==
X-Forwarded-Encrypted: i=1; AJvYcCWy2GznT8OWAG4FgoNHjgztw3pWDKhJ5lsR36xlDUBJnMP2Tb8o3R9AqsRemFCXK9NFg04=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9+/QkyOINKf49LJEhRraUKKvzHiyuQdjJFbfmKclqRcIGFxPD
	vGfGF4fIlR/AEpf6MQhbCQ00tky+h2YOeriHYM9x/BZpzhZo37bX9/ntNHEFz2tbXG2OVBMFb0Q
	iE7haq+f0AWWoJ0WVGaCL5WvK1jk9NQbi
X-Google-Smtp-Source: AGHT+IGgADKlAh7fgoc3U0j5DwR4frEg15KerfGXHBHcvyaI1ctFdjhDZAAiXZlS0+VEfGuvi7cFbEDELlQ5fhNhsF4=
X-Received: by 2002:a05:6000:1a8e:b0:37d:2d6f:3284 with SMTP id
 ffacd0b85a97d-381c145bd78mr6153341f8f.9.1730507400160; Fri, 01 Nov 2024
 17:30:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101000017.3424165-1-memxor@gmail.com> <CAP01T75OUeE8E-Lw9df84dm8ag2YmHW619f1DmPSVZ5_O89+Bg@mail.gmail.com>
 <c3f7ee7790c6f53a572ff2857433f534f4972189.camel@gmail.com>
In-Reply-To: <c3f7ee7790c6f53a572ff2857433f534f4972189.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 1 Nov 2024 17:29:49 -0700
Message-ID: <CAADnVQLZ9oj4+en43UZVOOLNHfHGq2aEcR9pYwLKLeMh1rJN-w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 0/2] Handle possible NULL trusted raw_tp arguments
To: Eduard Zingerman <eddyz87@gmail.com>, Puranjay Mohan <puranjay@kernel.org>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, kkd@meta.com, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Steven Rostedt <rostedt@goodmis.org>, 
	Jiri Olsa <olsajiri@gmail.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 5:21=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Fri, 2024-11-01 at 14:18 +0100, Kumar Kartikeya Dwivedi wrote:
>
> [...]
>
> > I see that all selftests except one passed. The one that didn't
> > appears to have been cancelled after running for an hour, and stalled
> > after select_reuseport:OK.
> > Looking at the LLVM 18
> > (https://github.com/kernel-patches/bpf/actions/runs/11621768944/job/323=
66412581?pr=3D7999)
> > run instead of LLVM 17
> > (https://github.com/kernel-patches/bpf/actions/runs/11621768944/job/323=
66400714?pr=3D7999,
> > which failed), it seems the next test send_signal_tracepoint.
> >
> > Is this known to be flaky? I'm guessing not and it is probably caused
> > by my patch, but just want to confirm before I begin debugging.
>
> I suspect this is a test send_signal.
> It started to hang for me yesterday w/o any apparent reason (on master br=
anch).
> I added workaround to avoid stalls, but this does not address the
> issue with the test. Workaround follows.

Hmm.
Puranjay touched it last with extra logic.

And before that David Vernet tried to address flakiness
in commit 4a54de65964d.
Yonghong also noticed lockups in paravirt
and added workaround 7015843afc.

Your additional timeout/workaround makes sense to me,
but would be good to bisect whether Puranjay's change caused it.

> ---
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c b/tools=
/testing/selftests/bpf/prog_tests/send_signal.c
> index ee5a221b4103..4af127945417 100644
> --- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
> +++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
> @@ -18,6 +18,38 @@ static void sigusr1_siginfo_handler(int s, siginfo_t *=
i, void *v)
>
>  static char log_buf[64 * 1024];
>
> +static ssize_t read_with_timeout(int fd, void *buf, size_t count)
> +{
> +       struct timeval tv =3D { 1, 0 };
> +       fd_set fds;
> +       int err;
> +
> +       FD_ZERO(&fds);
> +       FD_SET(fd, &fds);
> +       err =3D select(fd + 1, &fds, NULL, NULL, &tv);
> +       if (!ASSERT_GE(err, 0, "read select"))
> +               return err;
> +       if (FD_ISSET(fd, &fds))
> +               return read(fd, buf, count);
> +       return -EAGAIN;
> +}
> +
> +static ssize_t write_with_timeout(int fd, void *buf, size_t count)
> +{
> +       struct timeval tv =3D { 1, 0 };
> +       fd_set fds;
> +       int err;
> +
> +       FD_ZERO(&fds);
> +       FD_SET(fd, &fds);
> +       err =3D select(fd + 1, NULL, &fds, NULL, &tv);
> +       if (!ASSERT_GE(err, 0, "write select"))
> +               return err;
> +       if (FD_ISSET(fd, &fds))
> +               return write(fd, buf, count);
> +       return -EAGAIN;
> +}
> +
>  static void test_send_signal_common(struct perf_event_attr *attr,
>                                     bool signal_thread, bool remote)
>  {
> @@ -75,10 +107,10 @@ static void test_send_signal_common(struct perf_even=
t_attr *attr,
>                 }
>
>                 /* notify parent signal handler is installed */
> -               ASSERT_EQ(write(pipe_c2p[1], buf, 1), 1, "pipe_write");
> +               ASSERT_EQ(write_with_timeout(pipe_c2p[1], buf, 1), 1, "pi=
pe_write");
>
>                 /* make sure parent enabled bpf program to send_signal */
> -               ASSERT_EQ(read(pipe_p2c[0], buf, 1), 1, "pipe_read");
> +               ASSERT_EQ(read_with_timeout(pipe_p2c[0], buf, 1), 1, "pip=
e_read");
>
>                 /* wait a little for signal handler */
>                 for (int i =3D 0; i < 1000000000 && !sigusr1_received; i+=
+) {
> @@ -94,10 +126,10 @@ static void test_send_signal_common(struct perf_even=
t_attr *attr,
>                 buf[0] =3D sigusr1_received;
>
>                 ASSERT_EQ(sigusr1_received, 8, "sigusr1_received");
> -               ASSERT_EQ(write(pipe_c2p[1], buf, 1), 1, "pipe_write");
> +               ASSERT_EQ(write_with_timeout(pipe_c2p[1], buf, 1), 1, "pi=
pe_write");
>
>                 /* wait for parent notification and exit */
> -               ASSERT_EQ(read(pipe_p2c[0], buf, 1), 1, "pipe_read");
> +               ASSERT_EQ(read_with_timeout(pipe_p2c[0], buf, 1), 1, "pip=
e_read");
>
>                 /* restore the old priority */
>                 if (!remote)
> @@ -158,7 +190,7 @@ static void test_send_signal_common(struct perf_event=
_attr *attr,
>         }
>
>         /* wait until child signal handler installed */
> -       ASSERT_EQ(read(pipe_c2p[0], buf, 1), 1, "pipe_read");
> +       ASSERT_EQ(read_with_timeout(pipe_c2p[0], buf, 1), 1, "pipe_read")=
;
>
>         /* trigger the bpf send_signal */
>         skel->bss->signal_thread =3D signal_thread;
> @@ -172,7 +204,7 @@ static void test_send_signal_common(struct perf_event=
_attr *attr,
>         }
>
>         /* notify child that bpf program can send_signal now */
> -       ASSERT_EQ(write(pipe_p2c[1], buf, 1), 1, "pipe_write");
> +       ASSERT_EQ(write_with_timeout(pipe_p2c[1], buf, 1), 1, "pipe_write=
");
>
>         /* For the remote test, the BPF program is triggered from this
>          * process but the other process/thread is signaled.
> @@ -188,7 +220,7 @@ static void test_send_signal_common(struct perf_event=
_attr *attr,
>         }
>
>         /* wait for result */
> -       err =3D read(pipe_c2p[0], buf, 1);
> +       err =3D read_with_timeout(pipe_c2p[0], buf, 1);
>         if (!ASSERT_GE(err, 0, "reading pipe"))
>                 goto disable_pmu;
>         if (!ASSERT_GT(err, 0, "reading pipe error: size 0")) {
> @@ -199,7 +231,7 @@ static void test_send_signal_common(struct perf_event=
_attr *attr,
>         ASSERT_EQ(buf[0], 8, "incorrect result");
>
>         /* notify child safe to exit */
> -       ASSERT_EQ(write(pipe_p2c[1], buf, 1), 1, "pipe_write");
> +       ASSERT_EQ(write_with_timeout(pipe_p2c[1], buf, 1), 1, "pipe_write=
");
>
>  disable_pmu:
>         close(pmu_fd);
>

