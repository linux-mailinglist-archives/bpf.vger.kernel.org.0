Return-Path: <bpf+bounces-56014-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBAAA8ABF1
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 01:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66C361903888
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 23:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC4A2741BB;
	Tue, 15 Apr 2025 23:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYY5qa29"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B942517B7
	for <bpf@vger.kernel.org>; Tue, 15 Apr 2025 23:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744758930; cv=none; b=Nf8gjI1/kuKtj1Cd65XuKmiChot8wwp+3S7JHExHdAGPIt4fh+lLK+DUgmZ9cA2Xiee1zvmlcbZrYpJ8Fi+L6HLAEf2o+0BEWg0e5sQoIaryHHBLAUmW0D0vnEpTFpwmAxch3e532B3Y67q8HQiwpvMRoFFm42Z30gsupGFltfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744758930; c=relaxed/simple;
	bh=0Y+LMgOhLtt/fYrLPC3xn0mxyoK5KHtoI/uhkP5gPrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gojdWPxslM//I7gbknyAgqEcl++GnGoBkOogISQex1mEQtMeLd1k9NKkTvhl8IVMCAep+xYbAzyK+oM26u8xCrseHHe14H6LV6wasm0XXWj1SAu6of/dsw5rbsGlQo2FunyWM0gCognQsnN6CbcTHCLBF4sm5uYObM7xCw7f/Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VYY5qa29; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-224171d6826so86507665ad.3
        for <bpf@vger.kernel.org>; Tue, 15 Apr 2025 16:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744758928; x=1745363728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KJYh0QpalVdPz7ieuI+35tJkBPIpy9V4gRTATuks4xA=;
        b=VYY5qa29uMiCaoVpNZcPnv1SsV1GVyEaj930/sfB75LjGauuAXjxkqr3FwMKW2jiJb
         hxuIbD7yq15HA+vcYLTj++mHB8M0gwzhwTN2tBtomjMxm1y8Yxa1Qchy/6VoSzVyXatJ
         tJabGJELaT9ZEtA7UKp1CewZN4FEwXXjOeI8+GiTNhPUSchvLxhJjk3eQ3YoEhNrrKL8
         iamzZWVF3kSf3ENxm+OLyWVhHtPioWKD/MlSQTUlb76EFggbvhE0o8L4IM13YzQr8tcr
         v1yN86qua+vPX0hDNXF1JnV51BfpCcma9iaM84v+S7OmV/plq9xXTigUelnWw69jT/Rs
         cLEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744758928; x=1745363728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KJYh0QpalVdPz7ieuI+35tJkBPIpy9V4gRTATuks4xA=;
        b=K0p1nSTuMQ54o9Sd2gxeeFS8kjmPe0r4VfTGz++rbErscrwhegItocJkYcaLaRn9hz
         tsb1sBxLgPdpk8kHguj6yl1u6+p4jGCcTUe5S4x46IAqlIX1sgP9E/R27rEFaDbek3Kk
         gk+ZVhZYWkSJXfIpvTjlRctKY+k6ws7KP3IV2I+thnhT0OrNjpK7hny4RxNcNFozAhQh
         9pYI4Xrv93PfqOyjOeHOTSB8th9JFlnr6QefPhNjv+k6xdTfH4qHKz+jaZm8ZLtFqJHK
         dlEaVdbRNMscUelMJKKGOqaonBZPYtUEq6jMCXtI60XOcYKnpabpVs/R+uehz45Esbsh
         T2CQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEKLNsYe9pEVHqoKsWQ9mkTPZ9T+7CtL96p6g/8H44lHQ4z2/w1yyLJdVqgEZGgLBMdBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP96j9AzeB4Ux51g04lIg+MbH4nKrImr1x3thxeiS7d1MmkysY
	HIfuhzTnMfqkr0b0gH7D560OAkZzj3xJa8LEH6i/5oXmx1c0kVCCnurzD4ya/z0toVzmiQhl6wi
	Zik/nIfTXyTqsmU2+zHEeRFGFAX0=
X-Gm-Gg: ASbGncvBMx1G0m150DOEk6iPlWvYPJ+qxdLW+xP5Mm7td6E/vrQaI3D8NysXeHKqBzN
	mPBBjYJVxphiHo6VlobzoA+yK3J3bvCYwfF5SgXEdw/6i9oe8pmVWiv+E1ZVfj7Lv3jC29Hw7jr
	s/O9PFmhZHj2JyPREz6yIuzo5Kq4BCLE8lQyxORw==
X-Google-Smtp-Source: AGHT+IGSHHqeJk3/JiLcfzolmJdGXwLDoxBDCrdQMQcqb+zxk1ntWjGH8keHCLMsXYF5JQhYayswKaBDB+jN7Dakg0A=
X-Received: by 2002:a17:902:ce92:b0:22c:33b2:e420 with SMTP id
 d9443c01a7336-22c33b2e66dmr5394235ad.7.1744758928579; Tue, 15 Apr 2025
 16:15:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAADnVQJbBOK25Fx3zEG-ZH=zTFRfPNQye673b5TnpdTdMEXAUA@mail.gmail.com>
 <20250410103804.49250-1-malayarout91@gmail.com> <CAEf4BzaogUrvCxga36F1_o-h53Ur0mAaG9im1JsPfAhutxSYuQ@mail.gmail.com>
 <CAE2+fR-QvJqL0VkqPufLL+r7FLaOSTRt2_xXjq=fdpk0yAGj2w@mail.gmail.com>
In-Reply-To: <CAE2+fR-QvJqL0VkqPufLL+r7FLaOSTRt2_xXjq=fdpk0yAGj2w@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 15 Apr 2025 16:15:15 -0700
X-Gm-Features: ATxdqUF7-iz1_-OloN7wbfhplMYUgm_PNyMzX9L1vZfkBlOdg07mm2-i99fxF04
Message-ID: <CAEf4BzZGCfrEJpqbd=j11poDHyHqfobRvQeQB0FLEpBg9Bf_XQ@mail.gmail.com>
Subject: Re: [PATCH RESEND bpf-next v3] selftests/bpf: close the file
 descriptor to avoid resource leaks
To: malaya kumar rout <malayarout91@gmail.com>
Cc: alexei.starovoitov@gmail.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 12, 2025 at 11:45=E2=80=AFAM malaya kumar rout
<malayarout91@gmail.com> wrote:
>
> Malaya Kumar Rout
> Ph. No:  +91-9778203508
>              +91-7008245249
>
> On Thu, Apr 10, 2025 at 11:03=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Apr 10, 2025 at 3:38=E2=80=AFAM Malaya Kumar Rout
> > <malayarout91@gmail.com> wrote:
> > >
> > > Static analysis found an issue in bench_htab_mem.c
> > >
> > > cppcheck output before this patch:
> > > tools/testing/selftests/bpf/benchs/bench_htab_mem.c:284:3: error: Res=
ource leak: fd [resourceLeak]
> > > tools/testing/selftests/bpf/prog_tests/sk_assign.c:41:3: error: Resou=
rce leak: tc [resourceLeak]
> > >
> > > cppcheck output after this patch:
> > > No resource leaks found
> > >
> > > Fix the issue by closing the file descriptors fd and tc.
> > >
> > > Signed-off-by: Malaya Kumar Rout <malayarout91@gmail.com>
> > > ---
> >
> > I still don't see this patch in our Patchworks.
> >
> > But I noticed that the subject is:
> >
> > RE:[PATCH RESEND bpf-next v3] selftests/bpf: close the file descriptor
> > to avoid resource leaks
> >
> > and there is
> >
> > In-Reply-To: <CAADnVQJbBOK25Fx3zEG-ZH=3DzTFRfPNQye673b5TnpdTdMEXAUA@mai=
l.gmail.com>
> >
> > email header, so I suspect bot ignores this because it's a reply.
> >
> > Please send it as a stand-alone email with `git send-email`, hopefully
> > that works.
> >
> I have shared a stand-alone email with 'git send-email'.Kindly confirm
> at your earliest convenience. If any issues arise again, please permit
> me to share two separate patches, as we have modifications in two
> distinct files.
>

Yes, this time email arrived into Patchworks, but you had pclose ->
close mistake, please fix, test, and resubmit.

> > >  tools/testing/selftests/bpf/benchs/bench_htab_mem.c | 3 +--
> > >  tools/testing/selftests/bpf/prog_tests/sk_assign.c  | 4 +++-
> > >  2 files changed, 4 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/bpf/benchs/bench_htab_mem.c b/to=
ols/testing/selftests/bpf/benchs/bench_htab_mem.c
> > > index 926ee822143e..297e32390cd1 100644
> > > --- a/tools/testing/selftests/bpf/benchs/bench_htab_mem.c
> > > +++ b/tools/testing/selftests/bpf/benchs/bench_htab_mem.c
> > > @@ -279,6 +279,7 @@ static void htab_mem_read_mem_cgrp_file(const cha=
r *name, unsigned long *value)
> > >         }
> > >
> > >         got =3D read(fd, buf, sizeof(buf) - 1);
> > > +       close(fd);
> > >         if (got <=3D 0) {
> > >                 *value =3D 0;
> > >                 return;
> > > @@ -286,8 +287,6 @@ static void htab_mem_read_mem_cgrp_file(const cha=
r *name, unsigned long *value)
> > >         buf[got] =3D 0;
> > >
> > >         *value =3D strtoull(buf, NULL, 0);
> > > -
> > > -       close(fd);
> > >  }
> > >
> > >  static void htab_mem_measure(struct bench_res *res)
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/sk_assign.c b/too=
ls/testing/selftests/bpf/prog_tests/sk_assign.c
> > > index 0b9bd1d6f7cc..10a0ab954b8a 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/sk_assign.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
> > > @@ -37,8 +37,10 @@ configure_stack(void)
> > >         tc =3D popen("tc -V", "r");
> > >         if (CHECK_FAIL(!tc))
> > >                 return false;
> > > -       if (CHECK_FAIL(!fgets(tc_version, sizeof(tc_version), tc)))
> > > +       if (CHECK_FAIL(!fgets(tc_version, sizeof(tc_version), tc))) {
> > > +               pclose(tc);
> > >                 return false;
> > > +       }
> > >         if (strstr(tc_version, ", libbpf "))
> > >                 prog =3D "test_sk_assign_libbpf.bpf.o";
> > >         else
> > > --
> > > 2.43.0
> > >

