Return-Path: <bpf+bounces-74589-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C52C5F83D
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 23:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 98A2635B9FE
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 22:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEA730F923;
	Fri, 14 Nov 2025 22:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMshiMB9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE50221FB2
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 22:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763159125; cv=none; b=CFpCGHPg/qnUPO5BhqJbdbS0WeIllOfv0MIfJUeoC8hzVGlQlXLO1V6S2KFdDqqITFq6P4EjephuKZJNBz90T62MQqikcwHl64JZwtVJb/FEm/w4W0HLCUPn1+ESTM1fy694x6AOMEtsBcLS+q15vGvZwQ/2PZb9fRyDZbp72AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763159125; c=relaxed/simple;
	bh=J1DOV6YK9q3mqefSsCwFdohvx4WBn6bMETGH8xbtoCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DQ/FgK6EIHHW4O4OJrtG5ONGUXdJlhhnQS3RpAuo7te4zDEPj6ueqSgXqQjPbmNx+dAOIrjRVJ0caUZpPePEXt8aiLEk7FRRzDLnTt6mMI58hg9g33dcu/FiqW/dw5zUoHIpyVUgUjW7swVzzrz7dOHIc1cF1Y2+4DNTimgvcGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OMshiMB9; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-477563e28a3so16707835e9.1
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 14:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763159121; x=1763763921; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQe/l+l+qAUse+ReEIFbREyjDCPy1UspdkOF/1g6TL8=;
        b=OMshiMB93y7/6S/RsYc3hq7RkGaZH8F3TJ2eM/XCN25FxuuKyGrwlJ/XnA+YooTxDp
         108OkmZALGDCBplryfV9b4p31ONVftC93wzVaQ6MejVXTwQkYAoAB1tBSY2bP4DXw9HE
         PSFpZCvHVjCahhaiCHQUZpRiKGf40pS2KLme0rnisySZA3oP37LJsO2QFOpEm78KcFtf
         R0DSDpLMvuNFw39zu6QSGiflJIPj4B8CrQlquheeh2zzbUnQ94MrIHkMGXyufqe9o9Wr
         rA6dtIJN4qeZKsS6zaMAm3MKh2m7VFXfZ1ZQnv5ASPXWGdc0O/K1lfSYLEIbcvCRLKC1
         B1Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763159121; x=1763763921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IQe/l+l+qAUse+ReEIFbREyjDCPy1UspdkOF/1g6TL8=;
        b=YyfFnywQrn74X8SFqNbBtYc7c948ot2m+ltV2BE8hb/bN7AJrNE6k0jFkQGaVxEOS/
         8XUBcDSWtml3QRzIQx3UAyI5XnDlL2JrZyy5rYjeYalqM2TA+AxAstEzz/TLuEkg8XAP
         T62wrQefN+Wm5GNp3JxLYwZ53zSDdjXUsWfqAO7APbdN49ZNxOn5ji7g64DFa39NBh5n
         TarLDo9Q8rYbJAJpDUHndNmNVrBQSjYVNb0S/BFsDhYzDtDnwuVRynl/x7d8XJUPbQXD
         pwNp1WZ3pbl1UBaSlfcXjL63y/1mmar39O+jORmLLVpflqeVFCcrkCpHq3jnBhIouhys
         p4+w==
X-Gm-Message-State: AOJu0YxeZAAKMkloe+A4iX00Xxpxzplh+DIlRbBtVltImW3ZHlIQp0oi
	NVPoXTLqnKC6io+fDAEB2RIrAqeNZUJUDo6nvRp57stcoNZAotAcKyNVZRpemHzzq23Kv3B+ZjU
	K+xhkCGyHpNUiskTvAwtsGt/ekj3pZ+s=
X-Gm-Gg: ASbGncuSXghmYSmvdL5cGGtzLp38nOiV6QEbVSZeJ61MPtq/pmLVfH3vTkXElBA8xeu
	mLtp+XKm/RNHoIPzOxClrYuU6oj7BI96p1W7vgKHBLI4AneusXm/46xRmD0EBLx3ukbbj0AGJLw
	54DSR3geW+eHWBHo3CZpV83Klt14lKeIbn8Hl0VX40AorB8EP9j3jpcrbahGZS4akXCIWRvDqOB
	s7piPfsRuoLgrjT87DxfsU/3rxBiN0IXnhclTHANBR2Z8SyniQTrIvRieWcxlL272DDuTC/YH89
	mc84u2Nnup2ir4sqtZ8Qzz7A+0JL
X-Google-Smtp-Source: AGHT+IHgMM6X/5pljbdITCBnaz6uL5m7lPOeiIdOfWmQX7BT01GPYZL/DE2eGbCmAjcercM7ffmkDBrDHF93x/PZwes=
X-Received: by 2002:a05:600c:55d7:b0:475:d7fd:5c59 with SMTP id
 5b1f17b1804b1-47790e0b391mr28514445e9.16.1763159120554; Fri, 14 Nov 2025
 14:25:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113070531.46573-1-alexei.starovoitov@gmail.com> <CAEf4BzaOTZQV0bTszqKOqw1jE4+-shqA06ga7yFM6Moc-Gy+fw@mail.gmail.com>
In-Reply-To: <CAEf4BzaOTZQV0bTszqKOqw1jE4+-shqA06ga7yFM6Moc-Gy+fw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 14 Nov 2025 14:25:09 -0800
X-Gm-Features: AWmQ_blEcakydZ_HKClUNDEw48eOOTezfA0BXLr-BnUqUNeQBaoQOzdaqrcufvc
Message-ID: <CAADnVQLcOwO5HZ8AqmcLM=-t_bwuUwkskUO-G2PPrhw6sC9w1A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix failure path in send_signal test
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 2:20=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Nov 12, 2025 at 11:05=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > When test_send_signal_kern__open_and_load() fails parent closes the
> > pipe which cases ASSERT_EQ(read(pipe_p2c...)) to fail, but child
> > continues and enters infinite loop, while parent is stuck in wait(NULL)=
.
> >
> > Fix the issue by killing the child before jumping to skel_open_load_fai=
lure.
> >
> > The bug was discovered while compiling all of selftests with -O1 instea=
d of -O2
> > which caused progs/test_send_signal_kern.c to fail to load.
> >
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > ---
> >  tools/testing/selftests/bpf/prog_tests/send_signal.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c b/too=
ls/testing/selftests/bpf/prog_tests/send_signal.c
> > index 1702aa592c2c..61521dc76c3c 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
> > @@ -110,8 +110,10 @@ static void test_send_signal_common(struct perf_ev=
ent_attr *attr,
> >         close(pipe_p2c[0]); /* close read */
> >
> >         skel =3D test_send_signal_kern__open_and_load();
> > -       if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
> > +       if (!ASSERT_OK_PTR(skel, "skel_open_and_load")) {
> > +               kill(pid, SIGKILL);
> >                 goto skel_open_load_failure;
> > +       }
>
>
> this is only a partial solution, as rightfully pointed out by AI. The
> real solution, IMO, is to make child die by itself if parent's pipe is
> closed (which is what we do in parent on cleanup). If you run these
> tests with -v, you'll actually see what happens on child side:

You're looking at the old patch.

> #374/7   send_signal/send_signal_tracepoint_remote:OK
> test_send_signal_common:PASS:pipe_c2p 0 nsec
> test_send_signal_common:PASS:pipe_p2c 0 nsec
> test_send_signal_common:PASS:fork 0 nsec
> test_send_signal_common:PASS:fork 0 nsec
> test_send_signal_common:PASS:sigaction 0 nsec
> test_send_signal_common:PASS:pipe_write 0 nsec
> test_send_signal_common:FAIL:pipe_read unexpected pipe_read: actual 0
> !=3D expected 1
>
>
> So a really simple and more robust solution is:

Not really. It would still miss all other unhandled ASSERTs and gotos
in the parent.
See v2 for robust sigkill.

> diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c
> b/tools/testing/selftests/bpf/prog_tests/send_signal.c
> index 1702aa592c2c..589a7bf3532a 100644
> --- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
> +++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
> @@ -76,7 +76,8 @@ static void test_send_signal_common(struct
> perf_event_attr *attr,
>                 ASSERT_EQ(write(pipe_c2p[1], buf, 1), 1, "pipe_write");
>
>                 /* make sure parent enabled bpf program to send_signal */
> -               ASSERT_EQ(read(pipe_p2c[0], buf, 1), 1, "pipe_read");
> +               if (!ASSERT_EQ(read(pipe_p2c[0], buf, 1), 1, "pipe_read")=
)
> +                       goto child_cleanup;
>
>                 /* wait a little for signal handler */
>                 for (int i =3D 0; i < 1000000000 && !sigusr1_received; i+=
+) {
> @@ -101,6 +102,7 @@ static void test_send_signal_common(struct
> perf_event_attr *attr,
>                 if (!remote)
>                         ASSERT_OK(setpriority(PRIO_PROCESS, 0,
> old_prio), "setpriority");
>
> +child_cleanup:
>                 close(pipe_c2p[1]);
>                 close(pipe_p2c[0]);
>                 exit(0);
>
> pw-bot: cr
>
>
> >
> >         /* boost with a high priority so we got a higher chance
> >          * that if an interrupt happens, the underlying task
> > --
> > 2.47.3
> >

