Return-Path: <bpf+bounces-55670-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2628A84B15
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 19:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D2FB9A0FE4
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 17:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418071EBA16;
	Thu, 10 Apr 2025 17:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqVoef6p"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A52D1EF377
	for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 17:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744306392; cv=none; b=IbObJrjQmnwC0FSmRcMgN9lzMckyJ1d5Uc5akK4yqk26d2JOeOkBU4OaFs5M/BcCsGmDthiz1b3CfuwnFrhj9QULXM+zcApVSwPd5ha4AWsqtwQlNWLUeCzUm63XHdoBy6R3yFFp4cUxCi7fYD+8o3ZGnzcbENoWZVR6Dv+66gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744306392; c=relaxed/simple;
	bh=St7E9Yh2QwX0SSDkbA9Y6WidN/Pb7k+sH/PTlyW2t4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gg2OCW8iM8xKurOv5A6ouezt1bX9n/idMFoL77OSr/pnmzm3RA3K6kA0USu6qHFW5/ivOG7jR3IlY0/AI3WPyk8ewdKhR5DKNoTMsbbd8yOMKgoE86BfeyCaxdyWlh7UFUsqREoqUBsJBUzRGNa+XKQ3Ho+XWSN21VA7FUVS9LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqVoef6p; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-736ee709c11so918799b3a.1
        for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 10:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744306390; x=1744911190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xwaln81qw4wGJOrAJbn4tiLjdOl2KdrT7/VH76zwKEw=;
        b=jqVoef6pAoTtOKABy1g3c87Zkno4GWxAm4cFTHbt0HnbrwHKQQcizBMl94SY50094N
         lSHRyl6ErKnI6lDPVgVP9KIRRJkosp7BU7CBlg4Yy3PjltxiCiYhoVTjDylMx4hDXhr9
         WLOTkRYgu5k+d03bKeyfKuRzQZqP56Zuo38IdpUTOoMcsG+N5h9VDz0yODBuX70soVna
         Oz5ukJurjfV2Yt5A4+pn2lOYSVHtNTV+xnAG3OXf+5JDR3n6FphtctkLWkIQxHSsoY5s
         N3vmJnGcCRJc2ZB/cj2OHInOfn6xrAmXSZU7VT9XRZw6gQOpKE/wA1/KcgHFtM+NVJVA
         V1aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744306390; x=1744911190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xwaln81qw4wGJOrAJbn4tiLjdOl2KdrT7/VH76zwKEw=;
        b=sN+Pth+PQ3ydw6NS8C59E/aU5tYFJOX2cXXBD52uMYoBKpOSPQW7oIS6NQLINIoOBB
         t76xs7e3XTo7Yc9UIIgFkj6dFPNNHcTB2tEWKznC0ej+Df9fJglbmM/pvCmdSiHRgiJn
         pn8bUBCcrxffqVwCrTzhZgGLpsr5TwBt8gpQwgyQ8H2IUzj816aIUkK/o5N+Gne0i9z7
         0wwd6Og6WjFwlHaW+vE19a54/ZjVX2J9yyeUXmwAYHyzQ5fwsR9tPDxNKW9YwO95gb9s
         s4xpRflgv1hvNIH58fpPuGX8JUMgcFZzDunrhb/yKbclqs6nlKGtRcRG6qz76WWmO958
         VswA==
X-Forwarded-Encrypted: i=1; AJvYcCUSmki406eUy9gUQe4/0W3ntHJFRDhOplG47hMGOTHltTKTYptBZQmASbZbN/Nv4t+W0iA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8qHPL8TMQKCLdAzDr3bKIoBYd3mwg9oVxIwmremld556Wg0ht
	VxHUE/mF5S2j+MRc4Ds+rU13Jqv3GSQSiD66RiJDBopiRe4VQ1OyGemfb/yJ8412x8ml03henyz
	E1YmuTPpikaQnYtfPa7o/cFaGXss8aqAU
X-Gm-Gg: ASbGnculODM9Tl0JfVD/iATKhLU0nFQuKxE4T+5uZhGEb3QgJD7fpqMkCEQM79ymd9R
	hLr8Vh7+0chzVNs3YS+KsJQtu/YLtbUTiZARmfSDtreZk5rJsPNoHgrOxbaNjL4eksQ/+N+H+bi
	+vPbKy1ZprwB4AOA6tpmdKXDg3yDBIj2GFUahmV72yxr+XW6Q=
X-Google-Smtp-Source: AGHT+IGDSsZV4IFZzVfnjVsmzohadlnr5PdUM0gKH+sF1WxiDfLpmjrG86bFczeG7IB0YnsZ2xSXI41/HAwLTmrUzvU=
X-Received: by 2002:a05:6a00:21c5:b0:739:b288:13e7 with SMTP id
 d2e1a72fcca58-73bc0b7a48cmr3573427b3a.15.1744306390337; Thu, 10 Apr 2025
 10:33:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAADnVQJbBOK25Fx3zEG-ZH=zTFRfPNQye673b5TnpdTdMEXAUA@mail.gmail.com>
 <20250410103804.49250-1-malayarout91@gmail.com>
In-Reply-To: <20250410103804.49250-1-malayarout91@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 10 Apr 2025 10:32:57 -0700
X-Gm-Features: ATxdqUFGKVgTs-JLgBX81PVl-Nb6Tos6wRcO1pGkJYKyNPVmRdsNDo5MDhj7jt4
Message-ID: <CAEf4BzaogUrvCxga36F1_o-h53Ur0mAaG9im1JsPfAhutxSYuQ@mail.gmail.com>
Subject: Re: [PATCH RESEND bpf-next v3] selftests/bpf: close the file
 descriptor to avoid resource leaks
To: Malaya Kumar Rout <malayarout91@gmail.com>
Cc: alexei.starovoitov@gmail.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 3:38=E2=80=AFAM Malaya Kumar Rout
<malayarout91@gmail.com> wrote:
>
> Static analysis found an issue in bench_htab_mem.c
>
> cppcheck output before this patch:
> tools/testing/selftests/bpf/benchs/bench_htab_mem.c:284:3: error: Resourc=
e leak: fd [resourceLeak]
> tools/testing/selftests/bpf/prog_tests/sk_assign.c:41:3: error: Resource =
leak: tc [resourceLeak]
>
> cppcheck output after this patch:
> No resource leaks found
>
> Fix the issue by closing the file descriptors fd and tc.
>
> Signed-off-by: Malaya Kumar Rout <malayarout91@gmail.com>
> ---

I still don't see this patch in our Patchworks.

But I noticed that the subject is:

RE:[PATCH RESEND bpf-next v3] selftests/bpf: close the file descriptor
to avoid resource leaks

and there is

In-Reply-To: <CAADnVQJbBOK25Fx3zEG-ZH=3DzTFRfPNQye673b5TnpdTdMEXAUA@mail.gm=
ail.com>

email header, so I suspect bot ignores this because it's a reply.

Please send it as a stand-alone email with `git send-email`, hopefully
that works.

>  tools/testing/selftests/bpf/benchs/bench_htab_mem.c | 3 +--
>  tools/testing/selftests/bpf/prog_tests/sk_assign.c  | 4 +++-
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/benchs/bench_htab_mem.c b/tools/=
testing/selftests/bpf/benchs/bench_htab_mem.c
> index 926ee822143e..297e32390cd1 100644
> --- a/tools/testing/selftests/bpf/benchs/bench_htab_mem.c
> +++ b/tools/testing/selftests/bpf/benchs/bench_htab_mem.c
> @@ -279,6 +279,7 @@ static void htab_mem_read_mem_cgrp_file(const char *n=
ame, unsigned long *value)
>         }
>
>         got =3D read(fd, buf, sizeof(buf) - 1);
> +       close(fd);
>         if (got <=3D 0) {
>                 *value =3D 0;
>                 return;
> @@ -286,8 +287,6 @@ static void htab_mem_read_mem_cgrp_file(const char *n=
ame, unsigned long *value)
>         buf[got] =3D 0;
>
>         *value =3D strtoull(buf, NULL, 0);
> -
> -       close(fd);
>  }
>
>  static void htab_mem_measure(struct bench_res *res)
> diff --git a/tools/testing/selftests/bpf/prog_tests/sk_assign.c b/tools/t=
esting/selftests/bpf/prog_tests/sk_assign.c
> index 0b9bd1d6f7cc..10a0ab954b8a 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sk_assign.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
> @@ -37,8 +37,10 @@ configure_stack(void)
>         tc =3D popen("tc -V", "r");
>         if (CHECK_FAIL(!tc))
>                 return false;
> -       if (CHECK_FAIL(!fgets(tc_version, sizeof(tc_version), tc)))
> +       if (CHECK_FAIL(!fgets(tc_version, sizeof(tc_version), tc))) {
> +               pclose(tc);
>                 return false;
> +       }
>         if (strstr(tc_version, ", libbpf "))
>                 prog =3D "test_sk_assign_libbpf.bpf.o";
>         else
> --
> 2.43.0
>

