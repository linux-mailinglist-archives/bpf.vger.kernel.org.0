Return-Path: <bpf+bounces-74604-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6823BC5FCB6
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 02:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CAB684E47ED
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 01:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7858E19D092;
	Sat, 15 Nov 2025 01:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cr0Lc0ez"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853D18C1F
	for <bpf@vger.kernel.org>; Sat, 15 Nov 2025 01:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763168540; cv=none; b=Zjc1OEzY2835GAsihMkIaXYo3JfMkBZJLQoiX1zlww8zAQMDM6HQI84+3hDdnQFAGiv1sUCNTMPbffy3MciQVuNvWN4QLk0haXfni6UZY8y5puUEillTaX+TBd9xaXnHPCCQI8E/KLlBTHKiXQ26ykL6QKwX5bZDd/s8so++lAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763168540; c=relaxed/simple;
	bh=9fNLHsHvSXQeMXIx0lq4fIozVBcn8XMUf3XPAHjWnNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MBEk0X/8DU4V8nAYIZfiHMqwjMydMwfL02mefA0nRiJMezYciA/C0ivBv3srgJIWA7yebQlSk300Uw2zz1Od2rdBzCAPpQogSIoVs4UKlPmO16Hx9iVMUxSrPjSAtZzKtEKnsAxhpGySZya4Dte9yIGYI6TqhXWtYjhdKElpobk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cr0Lc0ez; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-34372216275so2941764a91.2
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 17:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763168538; x=1763773338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eXX5MDpy+6/eLHjR6egM5Nnoyu7Nh3KPOJLsM3Pm5as=;
        b=cr0Lc0ezbCCSeK43GULaoqKRnUs3U1gttizbgjSgORX/Usf/BmSjNftO6owJW9++Om
         yem1OEZCYXr6VAtDxD8ASCg0QhnY6FD0j3G5l3xBqRJYh3o24YB5yKEz9AxqzTnbIbpp
         tpPZRayzznwWxLMNgeyuarFGaU1kmhE7PM1BZNSEJJHNqUl/DdECzeNd0FZdc5hAvIKR
         EwQoR8XWLFLcl1zqDPTy0STNr5CbpBvMXFl395NAu0721L0AQGsXvuZ4/gUrgU+cplzF
         CATHgxn9jCarqEwHi1Z08LHOuItc+r7T0FQq3f3xAeqLZ/JzCARhjECs59C103fEx3xu
         8n1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763168538; x=1763773338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eXX5MDpy+6/eLHjR6egM5Nnoyu7Nh3KPOJLsM3Pm5as=;
        b=QN3I3NciBWMWdLL8UcdHMyK1D0kKHGeX8l8zH+T4ItYfg3DK8WfypTgHy3fcpQZZuA
         dph9cJCezKExmO2ULMou1YeGtvhRTVtHnFfjmXo4vSTRO1Mr/anYgxVXUnuzvKUydSt6
         QI1i7q3xt/pSzoHt58MztXImHDyW+DFYCC7z6aX1CixrbAR5ymuuBlMsIRzOfoxwF/hx
         xTKtd1HeGh+IOMvieQzgW250CGcoVW9i8oaGlF8NL+VseAX7Emvo0zoqe59UHahy0ojY
         9VPGfq23QoEAJeilCKKy9cq5facyiHyktYhczVi1ziP8tl8dP/F2bChVl67c64hDsZOC
         yOIQ==
X-Gm-Message-State: AOJu0YxpKmtcSHgFSo8EicfBgQyBXIiM/s49La93ddZojsbtF/DKjpvx
	56mZpjJ1+TlLSwmARG1RBTUbnnq399P61uc0w+TGtiKiG+rt16v8FJwuFwvs2OI4O+pQ3fJHKnU
	nhhRR0SR3ieltIzzd29V2PEiTdSGfJZdXznqR
X-Gm-Gg: ASbGncvoNkQus63PTJipPua8gfV+2YZ71JDC7czkN1Fk2Da1XgkHJV5cN57v/ajeDvK
	VXoN//WcuKPTHv+hls6Ha28pNjpEy0u0DhRdI0RhaYeCx2OcoxmWyn2a7vjQo2Z8gGHgoxMGV6a
	d0HatXfN3Wdsg+FPl8u7kRlpXjI3+uixnZiD6oSrfkAAkH+tSBZKQ8b7UFZ5C6ATXIPPD+7EmNF
	L4PzMia9iO1rqjtVuNkcnGPR31Dl6q7RCJTp8z55cJNQCw1KcyNvP9LWOZ3mwBRbfC8bgRnA3KB
	6oCVNYbe99U=
X-Google-Smtp-Source: AGHT+IHl0SbDhbWCXMQmtaZNVHBour6wnz5J0EoKAp0QJTwEgo4TkvMdEL2aQr1zh71/my1BI7jXIoK7PyiiwPWCSsc=
X-Received: by 2002:a17:90a:c886:b0:340:be40:fe0c with SMTP id
 98e67ed59e1d1-343fa76c90fmr5343335a91.36.1763168537570; Fri, 14 Nov 2025
 17:02:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113070531.46573-1-alexei.starovoitov@gmail.com>
 <CAEf4BzaOTZQV0bTszqKOqw1jE4+-shqA06ga7yFM6Moc-Gy+fw@mail.gmail.com> <CAADnVQLcOwO5HZ8AqmcLM=-t_bwuUwkskUO-G2PPrhw6sC9w1A@mail.gmail.com>
In-Reply-To: <CAADnVQLcOwO5HZ8AqmcLM=-t_bwuUwkskUO-G2PPrhw6sC9w1A@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 14 Nov 2025 17:02:04 -0800
X-Gm-Features: AWmQ_bmhQrEojna7UmRIeYAszfzgtv-u8mkPWH-6mJvtnc1szqMyhs14XOxPnnE
Message-ID: <CAEf4BzYoJruxceBkDH=cjPJOd3uov1E+4miW4jWfPdGqUeWv9A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix failure path in send_signal test
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 2:25=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Nov 14, 2025 at 2:20=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Nov 12, 2025 at 11:05=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > From: Alexei Starovoitov <ast@kernel.org>
> > >
> > > When test_send_signal_kern__open_and_load() fails parent closes the
> > > pipe which cases ASSERT_EQ(read(pipe_p2c...)) to fail, but child
> > > continues and enters infinite loop, while parent is stuck in wait(NUL=
L).
> > >
> > > Fix the issue by killing the child before jumping to skel_open_load_f=
ailure.
> > >
> > > The bug was discovered while compiling all of selftests with -O1 inst=
ead of -O2
> > > which caused progs/test_send_signal_kern.c to fail to load.
> > >
> > > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > > ---
> > >  tools/testing/selftests/bpf/prog_tests/send_signal.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c b/t=
ools/testing/selftests/bpf/prog_tests/send_signal.c
> > > index 1702aa592c2c..61521dc76c3c 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
> > > @@ -110,8 +110,10 @@ static void test_send_signal_common(struct perf_=
event_attr *attr,
> > >         close(pipe_p2c[0]); /* close read */
> > >
> > >         skel =3D test_send_signal_kern__open_and_load();
> > > -       if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
> > > +       if (!ASSERT_OK_PTR(skel, "skel_open_and_load")) {
> > > +               kill(pid, SIGKILL);
> > >                 goto skel_open_load_failure;
> > > +       }
> >
> >
> > this is only a partial solution, as rightfully pointed out by AI. The
> > real solution, IMO, is to make child die by itself if parent's pipe is
> > closed (which is what we do in parent on cleanup). If you run these
> > tests with -v, you'll actually see what happens on child side:
>
> You're looking at the old patch.

 oops :)

>
> > #374/7   send_signal/send_signal_tracepoint_remote:OK
> > test_send_signal_common:PASS:pipe_c2p 0 nsec
> > test_send_signal_common:PASS:pipe_p2c 0 nsec
> > test_send_signal_common:PASS:fork 0 nsec
> > test_send_signal_common:PASS:fork 0 nsec
> > test_send_signal_common:PASS:sigaction 0 nsec
> > test_send_signal_common:PASS:pipe_write 0 nsec
> > test_send_signal_common:FAIL:pipe_read unexpected pipe_read: actual 0
> > !=3D expected 1
> >
> >
> > So a really simple and more robust solution is:
>
> Not really. It would still miss all other unhandled ASSERTs and gotos
> in the parent.

I'd be actually more concerned about that sigusr1_received loop in the
child, that one we can get stuck in for a long while, so ok, SIGKILL
it is.


> See v2 for robust sigkill.
>
> > diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c
> > b/tools/testing/selftests/bpf/prog_tests/send_signal.c
> > index 1702aa592c2c..589a7bf3532a 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
> > @@ -76,7 +76,8 @@ static void test_send_signal_common(struct
> > perf_event_attr *attr,
> >                 ASSERT_EQ(write(pipe_c2p[1], buf, 1), 1, "pipe_write");
> >
> >                 /* make sure parent enabled bpf program to send_signal =
*/
> > -               ASSERT_EQ(read(pipe_p2c[0], buf, 1), 1, "pipe_read");
> > +               if (!ASSERT_EQ(read(pipe_p2c[0], buf, 1), 1, "pipe_read=
"))
> > +                       goto child_cleanup;
> >
> >                 /* wait a little for signal handler */
> >                 for (int i =3D 0; i < 1000000000 && !sigusr1_received; =
i++) {
> > @@ -101,6 +102,7 @@ static void test_send_signal_common(struct
> > perf_event_attr *attr,
> >                 if (!remote)
> >                         ASSERT_OK(setpriority(PRIO_PROCESS, 0,
> > old_prio), "setpriority");
> >
> > +child_cleanup:
> >                 close(pipe_c2p[1]);
> >                 close(pipe_p2c[0]);
> >                 exit(0);
> >
> > pw-bot: cr
> >
> >
> > >
> > >         /* boost with a high priority so we got a higher chance
> > >          * that if an interrupt happens, the underlying task
> > > --
> > > 2.47.3
> > >

