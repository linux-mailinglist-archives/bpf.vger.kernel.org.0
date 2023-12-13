Return-Path: <bpf+bounces-17627-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E46280FBB1
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 01:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D09FB20F5D
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 00:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7328ECE;
	Wed, 13 Dec 2023 00:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IqYrQgCJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D8AD5
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 16:01:58 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40c3ceded81so36999375e9.1
        for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 16:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702425717; x=1703030517; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PoRQyu8zQfBgzVj9Xc1SYb48C8wkknFWSE/TDdaX104=;
        b=IqYrQgCJnUskuFY5basULWfriwlrEIGgLIKIN1QritPUTyPmZVdB+l+UPPSQIbyu9v
         VpMp/Hi6IZUlVjkYFgd4WvAgLLxFJ/RolID9y3beVXAg2RdJO8fbgNVkxBzQVAo8nHGh
         UtbJ4suP2svwR1bULAhpfDsRb42bCxkxEhJcIE+CFz66EI2Jr3uJ94AScNqViRRVTn1q
         jMqSV4UPpjuz7/rtTwFwH0APykk1OcdC1hDYc7u6ryXA6BM4O3ZOERN7khQTXQyGTOpP
         UcndgiUwD5QYLeyrcmqr22ioqzLmPCychL97x4aUAJzMBpVVc02GUuQzh1BOOeh/cvEV
         gZdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702425717; x=1703030517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PoRQyu8zQfBgzVj9Xc1SYb48C8wkknFWSE/TDdaX104=;
        b=lFDfRpsequwk2Jjm8C95hg8rqX8ul6sjVkmzqvq+gcQzw6andR96tsapEWptxwd6V6
         N7UGCLJyx9yaM55t28G15EqREbnDS6ZUfR6HfDXN7bMVG7akED0pBCdhjLor2viHtXgy
         SMcDF2tb5JYC4wcBe2yleJ45U+IwcgbsXt0B2sFA7uvW5GXfNRHi37PvTxfYbeyDhHMr
         szfBW8oKTHUdaaoJGlmvA4pZ2tclrpI/qRgVUTG8rqZtpO5wf/ndgI8E22Y8HXQDK8H/
         3A7fr5corPKOxSYwhuKPycc9K3r4Ia52ma0UgKUkwUGujO7FlqAq4M9pGUMtWxejOH+J
         WsXg==
X-Gm-Message-State: AOJu0Ywrxb2CYSUFO7xacjA4rgHp2nbxpcLuK+QRONV7rpH22HIT8oPb
	BRARRPtXcJBFjvabpYe3jjomXd/tR8deO2oNsNYKx8XD
X-Google-Smtp-Source: AGHT+IFbuUNOvZexZX2opiAOD7VY+S2Wj4FQ5f5J4gG+JtDBoKZ5O+g51N06XTDqYAK6tM/KdwxE9Nv1CU97Qnw8yBo=
X-Received: by 2002:a7b:c415:0:b0:40c:3923:4dc8 with SMTP id
 k21-20020a7bc415000000b0040c39234dc8mr3380340wmi.33.1702425716597; Tue, 12
 Dec 2023 16:01:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212182911.3784108-1-zhuyifei@google.com> <bff66df3-bd32-445a-89a8-b6208d87ae0c@linux.dev>
 <CAA-VZP=7s4S73CDGWApatHoFRE1Gv1AQKJKXi=Nqf5dBU50OoQ@mail.gmail.com>
In-Reply-To: <CAA-VZP=7s4S73CDGWApatHoFRE1Gv1AQKJKXi=Nqf5dBU50OoQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 12 Dec 2023 16:01:44 -0800
Message-ID: <CAEf4BzZzuHE=BmFheEqrHShxS_9V2d4-DSjNBoVjT9vN1sAitQ@mail.gmail.com>
Subject: Re: [PATCH bpf] selftests/bpf: Relax time_tai test for equal
 timestamps in tai_forward
To: YiFei Zhu <zhuyifei@google.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Stanislav Fomichev <sdf@google.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <songliubraving@fb.com>, 
	Kurt Kanzenbach <kurt@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 1:53=E2=80=AFPM YiFei Zhu <zhuyifei@google.com> wro=
te:
>
> On Tue, Dec 12, 2023 at 1:39=E2=80=AFPM Yonghong Song <yonghong.song@linu=
x.dev> wrote:
> >
> >
> > On 12/12/23 10:29 AM, YiFei Zhu wrote:
> > > We're observing test flakiness on an arm64 platform which might not
> > > have timestamps as precise as x86. The test log looks like:
> > >
> > >    test_time_tai:PASS:tai_open 0 nsec
> > >    test_time_tai:PASS:test_run 0 nsec
> > >    test_time_tai:PASS:tai_ts1 0 nsec
> > >    test_time_tai:PASS:tai_ts2 0 nsec
> > >    test_time_tai:FAIL:tai_forward unexpected tai_forward: actual 1702=
348135471494160 <=3D expected 1702348135471494160
> > >    test_time_tai:PASS:tai_gettime 0 nsec
> > >    test_time_tai:PASS:tai_future_ts1 0 nsec
> > >    test_time_tai:PASS:tai_future_ts2 0 nsec
> > >    test_time_tai:PASS:tai_range_ts1 0 nsec
> > >    test_time_tai:PASS:tai_range_ts2 0 nsec
> > >    #199     time_tai:FAIL
> > >
> > > This patch changes ASSERT_GT to ASSERT_GE in the tai_forward assertio=
n
> > > so that equal timestamps are permitted.
> > >
> > > Fixes: 64e15820b987 ("selftests/bpf: Add BPF-helper test for CLOCK_TA=
I access")
> > > Signed-off-by: YiFei Zhu <zhuyifei@google.com>
> > > ---
> > >   tools/testing/selftests/bpf/prog_tests/time_tai.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/time_tai.c b/tool=
s/testing/selftests/bpf/prog_tests/time_tai.c
> > > index a31119823666..f45af1b0ef2c 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/time_tai.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/time_tai.c
> > > @@ -56,7 +56,7 @@ void test_time_tai(void)
> > >       ASSERT_NEQ(ts2, 0, "tai_ts2");
> > >
> > >       /* TAI is moving forward only */
> > > -     ASSERT_GT(ts2, ts1, "tai_forward");
> > > +     ASSERT_GE(ts2, ts1, "tai_forward");
> >
> > Can we guard the new change with arm64 specific macro?
>
> Problem with this is that I'm not sure what other architectures could
> be affected. AFAICT from the test, what it cares about is that time is
> moving forwards rather than going backwards, so I thought GE is good
> enough for what it's testing for.
>

Agreed. I think having architecture-specific GE vs GT here will just
add more complexity than necessary without providing any added safety.
So I applied the patch to bpf-next as is, thanks.

> >
> > >
> > >       /* Check for future */
> > >       ret =3D clock_gettime(CLOCK_TAI, &now_tai);

