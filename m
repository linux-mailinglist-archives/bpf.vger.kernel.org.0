Return-Path: <bpf+bounces-55824-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAEEA86EF5
	for <lists+bpf@lfdr.de>; Sat, 12 Apr 2025 20:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B33C517E7E1
	for <lists+bpf@lfdr.de>; Sat, 12 Apr 2025 18:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078E021D3EE;
	Sat, 12 Apr 2025 18:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNnOmr51"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D045E219A86
	for <bpf@vger.kernel.org>; Sat, 12 Apr 2025 18:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744483503; cv=none; b=NVGZARu81nuV4NXSSG19Gd9S3bMCq4RoSCa8Vq4PtNwZt9cth/rFZjNrm2BIf4HncsiC8MrEqPkprjCLPWfsSZKJm7pkEawD0mAjqarFaP779UXnrcLwM6QekQF6bmOIEnsrYjD/2HDQ4c7shht/3gVV7mi177Drzwt82WqlsKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744483503; c=relaxed/simple;
	bh=nMQfA6SpIVT9+GMsg29DvKVWLGvtG4m8IW1rOE8FYcQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MTUoNFDxXYHfNpDX5ixRWwn17eDIhrnZmq1RhzLouR8foIm1e9TXS7+lCboceEjsoYIrdv0YYpPAJGgdjMsK43IIgeSbyh7OsqVAETbko29ZLEjEdtwsYzn3ExjAj6fbpTiHMCra14ehiZL2AEIKhxfCwFNhB0DxshVYYD0nMGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bNnOmr51; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac25d2b2354so485395766b.1
        for <bpf@vger.kernel.org>; Sat, 12 Apr 2025 11:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744483500; x=1745088300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pi44msVE7pSUgK3Zm7ryTO1mwYMow8OFFuoy4ByQWdY=;
        b=bNnOmr51jP7bEWCxdmby2oDl508H0HK/mtQDUxeFmhQZDDiQ9zNiM7N6XgO6hnPbPT
         1zh3ejhgDO6kNDuRBrP8hd7qm0/A4dbYuF4ROff3r07GJU4zjSObaWvtyl95aq7062mc
         CwDlJjSgwIwif3yM95K8SpHwY2MKCkgy/qFP98unu4SX75crGkWRovIABXlTQT6tfgSZ
         nfwaVOuXI6e3pnSCoSbeWps9UhfHCzj6Z2bPJ+MORfTAnuIehxblAl7wq6OTL6Yokmnp
         e5gPAMC578Vj5hKG3xAWnmuOlSy3/Ibk0+R62/lwWl3JRUeP+naBNouJAriYXvnaZPK4
         sgVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744483500; x=1745088300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pi44msVE7pSUgK3Zm7ryTO1mwYMow8OFFuoy4ByQWdY=;
        b=CoEp8j0KY7zesvAwIqcEwWgG2zlUpkh4Cg4WsrqUboyjYPh74i/Sw6tP2QP6ihh2VB
         7yghDkfEGtNkXd+181w8Dk6w+VbbLVpzkf9wCJuL6UVbPDu5evJt36XNxNrzq0N7QGYN
         DJCWyp8hRnyK+tWlBwn4svnMcaEWgzFnizWrbix+Nr/xvtaqwhHv1Ph4MCw2W+NxpmAJ
         uCw75A2VhMkcgVeO8p2g3cvdCm1tJ3xomf8wczE2ZYZrwruKlyCMcivaRNaMsJXnFCPu
         VyWN/9H5WhFmInmeM3g1vX9kiPBKGs8T7ATYH4FUnM0mY8hEZaMQf7sglBnT631Q3rK/
         0zKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXojDoXQwNzTpq6vv+ECaq+OG4sr1mIShaAGKMyLLnr7fas1yk8Opu4O4FGVBqNt+PH8iI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJqE/0JkkhBsKUbkxiyRzBKgyADN4+4kD/WdXONHRc/XU/29ix
	A9Ko2q6oJz1wU+Y8WM2gnAanwWE6HxvyAivj0wQWC2o+J70LTX1CD4SW62J76/BWs0BBRRrmTuT
	8naDHCrcOtEuIrSGjJ4aSzMoiwwQ=
X-Gm-Gg: ASbGncvPRu0Vo8jvGVw26orO6XQHCHBJv+e2mP54qzEGAOgHjV9c1LseS7Zxij7wZMd
	10WyoCoVLnJTlAguHgu++aDTwQ1DXn9KvIyxX3fDLD9/Phgu+s1ctImNm2djeAMypQdhN5EKq56
	UKi6saT3d8OGhWEB7N0DRyvpB6
X-Google-Smtp-Source: AGHT+IHezcy6ERejqRHx9FdYsGsUDOzSki15onddSkA/OxphBun7W9yGCWUv7W3gK1MHePL/ircRaGRQDHbJlPddilM=
X-Received: by 2002:a17:907:9445:b0:ac7:b621:7635 with SMTP id
 a640c23a62f3a-acad34fb5fbmr617898866b.36.1744483499747; Sat, 12 Apr 2025
 11:44:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAADnVQJbBOK25Fx3zEG-ZH=zTFRfPNQye673b5TnpdTdMEXAUA@mail.gmail.com>
 <20250410103804.49250-1-malayarout91@gmail.com> <CAEf4BzaogUrvCxga36F1_o-h53Ur0mAaG9im1JsPfAhutxSYuQ@mail.gmail.com>
In-Reply-To: <CAEf4BzaogUrvCxga36F1_o-h53Ur0mAaG9im1JsPfAhutxSYuQ@mail.gmail.com>
From: malaya kumar rout <malayarout91@gmail.com>
Date: Sun, 13 Apr 2025 00:14:48 +0530
X-Gm-Features: ATxdqUH6AFd8G052gfnelfMU4BNiOh-xoAJXpbPqG2-6Ux1IicYg19vc7XoWUTk
Message-ID: <CAE2+fR-QvJqL0VkqPufLL+r7FLaOSTRt2_xXjq=fdpk0yAGj2w@mail.gmail.com>
Subject: Re: [PATCH RESEND bpf-next v3] selftests/bpf: close the file
 descriptor to avoid resource leaks
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: alexei.starovoitov@gmail.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Malaya Kumar Rout
Ph. No:  +91-9778203508
             +91-7008245249

On Thu, Apr 10, 2025 at 11:03=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Apr 10, 2025 at 3:38=E2=80=AFAM Malaya Kumar Rout
> <malayarout91@gmail.com> wrote:
> >
> > Static analysis found an issue in bench_htab_mem.c
> >
> > cppcheck output before this patch:
> > tools/testing/selftests/bpf/benchs/bench_htab_mem.c:284:3: error: Resou=
rce leak: fd [resourceLeak]
> > tools/testing/selftests/bpf/prog_tests/sk_assign.c:41:3: error: Resourc=
e leak: tc [resourceLeak]
> >
> > cppcheck output after this patch:
> > No resource leaks found
> >
> > Fix the issue by closing the file descriptors fd and tc.
> >
> > Signed-off-by: Malaya Kumar Rout <malayarout91@gmail.com>
> > ---
>
> I still don't see this patch in our Patchworks.
>
> But I noticed that the subject is:
>
> RE:[PATCH RESEND bpf-next v3] selftests/bpf: close the file descriptor
> to avoid resource leaks
>
> and there is
>
> In-Reply-To: <CAADnVQJbBOK25Fx3zEG-ZH=3DzTFRfPNQye673b5TnpdTdMEXAUA@mail.=
gmail.com>
>
> email header, so I suspect bot ignores this because it's a reply.
>
> Please send it as a stand-alone email with `git send-email`, hopefully
> that works.
>
I have shared a stand-alone email with 'git send-email'.Kindly confirm
at your earliest convenience. If any issues arise again, please permit
me to share two separate patches, as we have modifications in two
distinct files.

> >  tools/testing/selftests/bpf/benchs/bench_htab_mem.c | 3 +--
> >  tools/testing/selftests/bpf/prog_tests/sk_assign.c  | 4 +++-
> >  2 files changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/benchs/bench_htab_mem.c b/tool=
s/testing/selftests/bpf/benchs/bench_htab_mem.c
> > index 926ee822143e..297e32390cd1 100644
> > --- a/tools/testing/selftests/bpf/benchs/bench_htab_mem.c
> > +++ b/tools/testing/selftests/bpf/benchs/bench_htab_mem.c
> > @@ -279,6 +279,7 @@ static void htab_mem_read_mem_cgrp_file(const char =
*name, unsigned long *value)
> >         }
> >
> >         got =3D read(fd, buf, sizeof(buf) - 1);
> > +       close(fd);
> >         if (got <=3D 0) {
> >                 *value =3D 0;
> >                 return;
> > @@ -286,8 +287,6 @@ static void htab_mem_read_mem_cgrp_file(const char =
*name, unsigned long *value)
> >         buf[got] =3D 0;
> >
> >         *value =3D strtoull(buf, NULL, 0);
> > -
> > -       close(fd);
> >  }
> >
> >  static void htab_mem_measure(struct bench_res *res)
> > diff --git a/tools/testing/selftests/bpf/prog_tests/sk_assign.c b/tools=
/testing/selftests/bpf/prog_tests/sk_assign.c
> > index 0b9bd1d6f7cc..10a0ab954b8a 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/sk_assign.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
> > @@ -37,8 +37,10 @@ configure_stack(void)
> >         tc =3D popen("tc -V", "r");
> >         if (CHECK_FAIL(!tc))
> >                 return false;
> > -       if (CHECK_FAIL(!fgets(tc_version, sizeof(tc_version), tc)))
> > +       if (CHECK_FAIL(!fgets(tc_version, sizeof(tc_version), tc))) {
> > +               pclose(tc);
> >                 return false;
> > +       }
> >         if (strstr(tc_version, ", libbpf "))
> >                 prog =3D "test_sk_assign_libbpf.bpf.o";
> >         else
> > --
> > 2.43.0
> >

