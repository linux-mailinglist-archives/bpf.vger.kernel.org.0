Return-Path: <bpf+bounces-31372-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7402B8FBCE2
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 22:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEEE31F24136
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 20:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEE414264D;
	Tue,  4 Jun 2024 20:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggaJKxar"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2487013790A
	for <bpf@vger.kernel.org>; Tue,  4 Jun 2024 20:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717531280; cv=none; b=fnAZRziK4ul9XxXzH22ReRrAGVKimQJ78JsOhlWTobVu+LkVsMMhYnag/EbC7VsKlSq/3cUo2hahEXCpKv9MVh4Vkm+dZhAGakvkMrAUpGKvG1aakN0y2d6Kr7c/RghUQZtRSur/XvBJrOmhMnG0jNPgN8FsSO1DLtwGPMHkH4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717531280; c=relaxed/simple;
	bh=usG9mF0WCep71BUhq49wLkxf74ZV8ym1n/NERkXFojo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O02faokz80FUfFfJffkSXdR4oN8zgOLHqyM4a9MzeYID4BI/LwZbMgq+EyjE2ozpV+9YX6O6MELu4m29ahUMUqOv7SLq+aIYZ45VilBH7qupzyuVDx/FohmNjdsKDUnBqEHi70o1exHI9oG5UXhaNpWdtnKJj5cRm9rUr/WoBoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ggaJKxar; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-6c4829d7136so1117125a12.1
        for <bpf@vger.kernel.org>; Tue, 04 Jun 2024 13:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717531278; x=1718136078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=igKfuc5co/e5dg9IIS3Ja4T6TeiLXeP3jW7c0dI66Xo=;
        b=ggaJKxarbgxEWRKu7d+pPGBog2yhL6n7CQEDAtRHHeldZ04L6ZnmvAizOY8l25Qw5k
         f/G/nqlxvJolbXkl0F/HlbFc47ZsZw0z/IGT+gqdarH+eO9rWL+udNeg+aeTrWeq+rgb
         4wOTJeM8q8fU2XOCE0kmldDXwjDiCEVCA1prUmt8R3mmlLBVrm9k0Y2x3fk6bicexnY2
         wi2hhOWLBKMRbn161eMWx+sBcw5+PBoLxPbGsUhgW092b6Eks+bCM0WrJWg9dyIpOf1O
         iTYwwr7TIYz5WgqGxGGw2YfCXjiIJWsAe/Pd3ICnxyxVW5WIrOjwP9P26rX+ISLVujvu
         DMOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717531278; x=1718136078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=igKfuc5co/e5dg9IIS3Ja4T6TeiLXeP3jW7c0dI66Xo=;
        b=DjE3o6hf3bpe2wXLaOvgOemkylJ8T9oobtG6MyVoor32B7MteQOnmsEbdrgJ8P4jXX
         BrVLa/fLQBpZ8C5J/y2jLEWWZfVgcfvKOQEC3Yo6+DLrPpsHDVDIHz6Hv2+M19Owr8E9
         cr7E7L/jL8uLGYBQat75g4PKJ/GSZSYN/UDVTQvOS2iv/q9HXIYWpTOkVRmBU0NrrZKX
         cXMNHgR+dL0qOV68Qt/igiXNCkZvXq8Qd0fgeMoIEFS+6RD63oCeT3dsd5voSHUgQ6E1
         /uc2IzhbQLkJkVN7ycQwceYFTlsKqGQG2qDUVqtSbbCUlTDr6hOG1RsnrVFNjspE9RDK
         4NvA==
X-Gm-Message-State: AOJu0Yz0Dlhl1HZN3fmIsEfYT+saITx0yUIPq65LF/quQ9oedd7qSS0w
	pvLGqGCeOBa2NfrZDasOAWWGhbM8dUuwZC3v723k4D7JirslmpnONdw/zdRrgowz7VanYbd7LBa
	qOlgVOazbdSuBO64BuwCn8yaGYqs=
X-Google-Smtp-Source: AGHT+IFr/IZZ8/CNZTmJNJ3KpYhh0NlkviJCLfwY6wWLk5ozKj5OdaHdHmTV+KPi+kNJJoRIUNELNMX/absR+JYNKQU=
X-Received: by 2002:a17:90a:578c:b0:2c1:a74d:653a with SMTP id
 98e67ed59e1d1-2c27db0ac08mr460595a91.16.1717531278348; Tue, 04 Jun 2024
 13:01:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604175546.1339303-1-yonghong.song@linux.dev>
In-Reply-To: <20240604175546.1339303-1-yonghong.song@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 4 Jun 2024 13:01:05 -0700
Message-ID: <CAEf4BzZLVvQ6A5qUsSkmPEmZYQDrN+=igb-tdCVZpTVKYeN2DA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Ignore .llvm.<hash> suffix in kallsyms_find()
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 10:56=E2=80=AFAM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> I hit the following failure when running selftests with
> internal backported upstream kernel:
>   test_ksyms:PASS:kallsyms_fopen 0 nsec
>   test_ksyms:FAIL:ksym_find symbol 'bpf_link_fops' not found
>   #123     ksyms:FAIL
>
> In /proc/kallsyms, we have
>   $ cat /proc/kallsyms | grep bpf_link_fops
>   ffffffff829f0cb0 d bpf_link_fops.llvm.12608678492448798416
> The CONFIG_LTO_CLANG_THIN is enabled in the kernel which is responsible
> for bpf_link_fops.llvm.12608678492448798416 symbol name.
>
> In prog_tests/ksyms.c we have
>   kallsyms_find("bpf_link_fops", &link_fops_addr)
> and kallsyms_find() compares "bpf_link_fops" with symbols
> in /proc/kallsyms in order to find the entry. With
> bpf_link_fops.llvm.<hash> in /proc/kallsyms, the kallsyms_find()
> failed.
>
> To fix the issue, in kallsyms_find(), if a symbol has suffix
> .llvm.<hash>, that suffix will be ignored for comparison.
> This fixed the test failure.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  tools/testing/selftests/bpf/trace_helpers.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/=
selftests/bpf/trace_helpers.c
> index 70e29f316fe7..dc871e642ed5 100644
> --- a/tools/testing/selftests/bpf/trace_helpers.c
> +++ b/tools/testing/selftests/bpf/trace_helpers.c
> @@ -221,6 +221,18 @@ int kallsyms_find(const char *sym, unsigned long lon=
g *addr)
>                 return -EINVAL;
>
>         while (fscanf(f, "%llx %c %499s%*[^\n]\n", &value, &type, name) >=
 0) {
> +               /* If CONFIG_LTO_CLANG_THIN is enabled, static variable/f=
unction
> +                * symbols could be promoted to global due to cross-file =
inlining.
> +                * For such cases, clang compiler will add .llvm.<hash> s=
uffix
> +                * to those symbols to avoid potential naming conflict.
> +                * Let us ignore .llvm.<hash> suffix during symbol compar=
ison.
> +                */
> +               if (type =3D=3D 'd') {
> +                       char *res =3D strstr(name, ".llvm.");

I declared this variable at the top of the function to remove this
empty line (and renamed it to "match"), applied to bpf-next, thanks!

> +
> +                       if (res)
> +                               *res =3D '\0';
> +               }
>                 if (strcmp(name, sym) =3D=3D 0) {
>                         *addr =3D value;
>                         goto out;
> --
> 2.43.0
>

