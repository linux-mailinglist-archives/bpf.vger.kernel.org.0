Return-Path: <bpf+bounces-74585-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D73FBC5F820
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 23:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3EFF035B533
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 22:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FFA3112BB;
	Fri, 14 Nov 2025 22:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODJjV5tw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7DC30ACF3
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 22:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763158825; cv=none; b=BDvbktd2uvK0mh8yfMg41kooVy+2IScsXxVHtvnvl+nq1ibP7X3ZE8LC9x14+42BssR4Dh0TGJ8nXv/7isIg/FeHmGzCjZe5AlstgahVus4Gcs4LjYqp4uqzk41v3Xa45bVWKdaliOXXwS1sC6LdTKTWahUg+O50VHT9wxMGGEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763158825; c=relaxed/simple;
	bh=PY9GsTZcXw318i/dA0vp8UybhlK0KlgPnoaFZIB25zc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lanAnX1vy3sHH1C6AagylpKiv9h1wjjPpOK0cmZKwDKRrW6dH78pGz+lFFoBeYulKrCwDSigvhd4kuJP+07ShtFH9WPbCsCVO0mdl2KCiqe1OMlEWtahWlk7hDI7hUgQ6TPEJFdF8/4s7uxKarINcEkARn9rn4K3QxUQ9wragy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ODJjV5tw; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3434700be69so3126271a91.1
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 14:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763158823; x=1763763623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tf/JL+BLOCG7Nc2KSKkYmwfGkjNtqGuWtil1E0dqLgc=;
        b=ODJjV5tw4vt/dloP+rPaY8TAJpCo9SiW2lUIjFigM0UNEIP0UZikPL1G6bkeOgrvC3
         plGnolJU1waaW97Grx8h5sUV9xQK3SZHEhdV1fOXsmutYM2Z2i2zAnZxEUVTKaG2Klyd
         3Jlq81cuc4H8YtcgGAAZXJxLZq1lwJ2sXLZM34EqxLPaJAJoF9/CG0r4oCOvpa9NYKg3
         iWn12Du4u2RPKuFyJ2A3E3HOP6XMQK0bR+GkED4KNzQrL9A2G8Raxiu4YrpK0eYQ/zTY
         vvQUHiKOfpj49Iy4pYqp+aS9uPE2RVsh5hPiWPtHUZK6Vl+05tG1T8WJP+wsDx070riF
         7Lyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763158823; x=1763763623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Tf/JL+BLOCG7Nc2KSKkYmwfGkjNtqGuWtil1E0dqLgc=;
        b=FiFEjGyGytdlx1bz5jw3nJk3OUR0ydLp8UXdlrtPSBbGcvyKwYQEp++tGEl20cwifx
         LOKmz+F25axAtfpRtaX9Qe5gfe4Xys1chmJ4j1WDhuwpFtHf9LiqYVSTPqo47QJ2UkJ9
         bGpQ31WpMsCILOJ70s8NqosJprod7KobdZ1usr0qtiOTrMLdc7N5bLM+sYHU7hvRqyDw
         Gralgsudhb52qDp5fAicQNazA0dc8mu5QEMpdx79le3Ru/92gMBBQGjVuMGmlybqWRTF
         PRumT1om8Bwlzb2Wws5pHMR4Z+308fz/npGSLnt4eQ06cj2QBXOrCKh4woZTYky89WYe
         Ld4w==
X-Gm-Message-State: AOJu0Yy08/Z5/0+3175kzboewfBlh63Ild7Svrb1jPaWTRAVV5O/o1K/
	keMCjLmW+rCIGfZq7E6taCiPUWb01pD0pZODG0i6yjFdvzhXFeKZMbQnMYpdLO1PjLMsPFbLW5b
	0havBotd915/b2kaBHaWJb9pPBhKsCajXQAwU
X-Gm-Gg: ASbGnctil2boCGjfqP5tuBfqUGfW6V6mpOmo9narLsD+9/PjCeA1SdXMAnbiKZBmXgs
	EW6DT/wO3EvICVpy98QdouOwa5lVEGvfJZ0jG5TVlZ52gDiMD498WWB9UR0t27fz9eYC6Kjvw21
	fKB8wOeCJ+bzkAUeUeGjfVkmqps6le/tYC/FGXoIKN3oFkV3myg0qbVBOoODogj5JoEUR0/Sm0F
	zY2hBFP4foIeEFgCsT3aF6LvDLY6gGGoujR7fl/c2oLyoMVL5hvZn2zDcZBCDJ2Ww9ONANCQWZ4
X-Google-Smtp-Source: AGHT+IEH379m+H16uH77q1fGWAtXILQT2BXkv+VI7XFYwyM0xCEtVerxNDzN6yIAw/ns+aX91xOVCQxqaPNOPirXlHI=
X-Received: by 2002:a17:90b:388d:b0:33f:ebc2:645 with SMTP id
 98e67ed59e1d1-343fa52ab2bmr5429215a91.20.1763158823130; Fri, 14 Nov 2025
 14:20:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113070531.46573-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20251113070531.46573-1-alexei.starovoitov@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 14 Nov 2025 14:20:11 -0800
X-Gm-Features: AWmQ_blJTW60bYojH9Y6K3oBBOCcL_iQZrQ7uy5DZUaSZyrbuK4JmIdP6zJWl5c
Message-ID: <CAEf4BzaOTZQV0bTszqKOqw1jE4+-shqA06ga7yFM6Moc-Gy+fw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix failure path in send_signal test
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 11:05=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> When test_send_signal_kern__open_and_load() fails parent closes the
> pipe which cases ASSERT_EQ(read(pipe_p2c...)) to fail, but child
> continues and enters infinite loop, while parent is stuck in wait(NULL).
>
> Fix the issue by killing the child before jumping to skel_open_load_failu=
re.
>
> The bug was discovered while compiling all of selftests with -O1 instead =
of -O2
> which caused progs/test_send_signal_kern.c to fail to load.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  tools/testing/selftests/bpf/prog_tests/send_signal.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c b/tools=
/testing/selftests/bpf/prog_tests/send_signal.c
> index 1702aa592c2c..61521dc76c3c 100644
> --- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
> +++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
> @@ -110,8 +110,10 @@ static void test_send_signal_common(struct perf_even=
t_attr *attr,
>         close(pipe_p2c[0]); /* close read */
>
>         skel =3D test_send_signal_kern__open_and_load();
> -       if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
> +       if (!ASSERT_OK_PTR(skel, "skel_open_and_load")) {
> +               kill(pid, SIGKILL);
>                 goto skel_open_load_failure;
> +       }


this is only a partial solution, as rightfully pointed out by AI. The
real solution, IMO, is to make child die by itself if parent's pipe is
closed (which is what we do in parent on cleanup). If you run these
tests with -v, you'll actually see what happens on child side:

#374/7   send_signal/send_signal_tracepoint_remote:OK
test_send_signal_common:PASS:pipe_c2p 0 nsec
test_send_signal_common:PASS:pipe_p2c 0 nsec
test_send_signal_common:PASS:fork 0 nsec
test_send_signal_common:PASS:fork 0 nsec
test_send_signal_common:PASS:sigaction 0 nsec
test_send_signal_common:PASS:pipe_write 0 nsec
test_send_signal_common:FAIL:pipe_read unexpected pipe_read: actual 0
!=3D expected 1


So a really simple and more robust solution is:

diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c
b/tools/testing/selftests/bpf/prog_tests/send_signal.c
index 1702aa592c2c..589a7bf3532a 100644
--- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
+++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
@@ -76,7 +76,8 @@ static void test_send_signal_common(struct
perf_event_attr *attr,
                ASSERT_EQ(write(pipe_c2p[1], buf, 1), 1, "pipe_write");

                /* make sure parent enabled bpf program to send_signal */
-               ASSERT_EQ(read(pipe_p2c[0], buf, 1), 1, "pipe_read");
+               if (!ASSERT_EQ(read(pipe_p2c[0], buf, 1), 1, "pipe_read"))
+                       goto child_cleanup;

                /* wait a little for signal handler */
                for (int i =3D 0; i < 1000000000 && !sigusr1_received; i++)=
 {
@@ -101,6 +102,7 @@ static void test_send_signal_common(struct
perf_event_attr *attr,
                if (!remote)
                        ASSERT_OK(setpriority(PRIO_PROCESS, 0,
old_prio), "setpriority");

+child_cleanup:
                close(pipe_c2p[1]);
                close(pipe_p2c[0]);
                exit(0);

pw-bot: cr


>
>         /* boost with a high priority so we got a higher chance
>          * that if an interrupt happens, the underlying task
> --
> 2.47.3
>

