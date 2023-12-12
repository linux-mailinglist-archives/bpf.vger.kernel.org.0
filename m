Return-Path: <bpf+bounces-17593-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 142E880F9C3
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 22:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD7EE282151
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 21:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF1A64CC6;
	Tue, 12 Dec 2023 21:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZFTDPo08"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705B8B0
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 13:52:57 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-67a948922aaso39768846d6.3
        for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 13:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702417976; x=1703022776; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eu01wBwYodyirNuaBgNyWQ4DPQ8cBIBJbsNjksyx4oA=;
        b=ZFTDPo08Wma73f8mjONmELkqy+s3KS6T2rCZwt9f5rof00I+epaiiAoTc0ktsngJ4g
         IotaTY4uCaNghMS182G9tljegsBYV+QrQ8K3OPIXPdZSCPMrlZhbC33fZfvae0mhvUwz
         wHBmSjRp2TwBxrvHMrBy8S8yBajYqcgx0z86d3jKeCNvVA3rfH13vFYkUaA8NdNiAf6d
         2pN3Fw7EebqdcX4LLKTEACW8a2XOVHDz5ok0D2rGdwp307jCQDu8e2md6NtuCX47u8ch
         Y7nQNe7QjwWWghLbZty6cIYZqVq5ljRZp7CN9Y6bvNr57kFsx3wZNsqhlCD2iDkDO1CS
         3JfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702417976; x=1703022776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eu01wBwYodyirNuaBgNyWQ4DPQ8cBIBJbsNjksyx4oA=;
        b=Ic7s2URQd2KDHyqfqi8DraIzrcVTqsYsOQ00yUBgLkLsxeZ76axjmpI9wZkp1X5Tre
         JivQyn8vFcMljotG4zX/n6ElIeol2zLsppO1EvgO7YmiPUCg5bmG7JNAp0PqrjC6Gs2y
         Xoj1yFvenCC9/VRSkmB9gnxZGek1WsG+MnPGLPrX1OMIbKPvnJq9QwUfNHJ5aXEv0Xnl
         ja/GeSVefzLaDfqAFodugTz7uYi+I28wF86IJMftkGFhPFUBRMt6Byo3dksvRRfawb/M
         TfUikBLtGFsE+fDHSQQVd+G8zyDpKKz7NjkGt4x21D46tkrwo/wiw5+g3PugKtgZecsI
         jSTg==
X-Gm-Message-State: AOJu0YzKf7SeRqQDOEPbcPZhbFeCXEctES1LiI7EVjC5C8YUXGf5cjjJ
	FZ3AcyCW197RuUqtXJlWJ9+4ikmYNsdnlrdbxd2fJnxcR73sGg8ZNCQ=
X-Google-Smtp-Source: AGHT+IHtCpY0c6Rg+kbyPnOuSDgeAMBNRmqSy3zEBScCPDBIy9oSUfxGfSgM59fHdImzmmZNDonLDxw63AKKZdVFUFA=
X-Received: by 2002:a05:6214:18f1:b0:67a:a781:954c with SMTP id
 ep17-20020a05621418f100b0067aa781954cmr7556889qvb.79.1702417976453; Tue, 12
 Dec 2023 13:52:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212182911.3784108-1-zhuyifei@google.com> <bff66df3-bd32-445a-89a8-b6208d87ae0c@linux.dev>
In-Reply-To: <bff66df3-bd32-445a-89a8-b6208d87ae0c@linux.dev>
From: YiFei Zhu <zhuyifei@google.com>
Date: Tue, 12 Dec 2023 13:52:45 -0800
Message-ID: <CAA-VZP=7s4S73CDGWApatHoFRE1Gv1AQKJKXi=Nqf5dBU50OoQ@mail.gmail.com>
Subject: Re: [PATCH bpf] selftests/bpf: Relax time_tai test for equal
 timestamps in tai_forward
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Stanislav Fomichev <sdf@google.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko <andrii@kernel.org>, 
	Song Liu <songliubraving@fb.com>, Kurt Kanzenbach <kurt@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 1:39=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
> On 12/12/23 10:29 AM, YiFei Zhu wrote:
> > We're observing test flakiness on an arm64 platform which might not
> > have timestamps as precise as x86. The test log looks like:
> >
> >    test_time_tai:PASS:tai_open 0 nsec
> >    test_time_tai:PASS:test_run 0 nsec
> >    test_time_tai:PASS:tai_ts1 0 nsec
> >    test_time_tai:PASS:tai_ts2 0 nsec
> >    test_time_tai:FAIL:tai_forward unexpected tai_forward: actual 170234=
8135471494160 <=3D expected 1702348135471494160
> >    test_time_tai:PASS:tai_gettime 0 nsec
> >    test_time_tai:PASS:tai_future_ts1 0 nsec
> >    test_time_tai:PASS:tai_future_ts2 0 nsec
> >    test_time_tai:PASS:tai_range_ts1 0 nsec
> >    test_time_tai:PASS:tai_range_ts2 0 nsec
> >    #199     time_tai:FAIL
> >
> > This patch changes ASSERT_GT to ASSERT_GE in the tai_forward assertion
> > so that equal timestamps are permitted.
> >
> > Fixes: 64e15820b987 ("selftests/bpf: Add BPF-helper test for CLOCK_TAI =
access")
> > Signed-off-by: YiFei Zhu <zhuyifei@google.com>
> > ---
> >   tools/testing/selftests/bpf/prog_tests/time_tai.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/time_tai.c b/tools/=
testing/selftests/bpf/prog_tests/time_tai.c
> > index a31119823666..f45af1b0ef2c 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/time_tai.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/time_tai.c
> > @@ -56,7 +56,7 @@ void test_time_tai(void)
> >       ASSERT_NEQ(ts2, 0, "tai_ts2");
> >
> >       /* TAI is moving forward only */
> > -     ASSERT_GT(ts2, ts1, "tai_forward");
> > +     ASSERT_GE(ts2, ts1, "tai_forward");
>
> Can we guard the new change with arm64 specific macro?

Problem with this is that I'm not sure what other architectures could
be affected. AFAICT from the test, what it cares about is that time is
moving forwards rather than going backwards, so I thought GE is good
enough for what it's testing for.

>
> >
> >       /* Check for future */
> >       ret =3D clock_gettime(CLOCK_TAI, &now_tai);

