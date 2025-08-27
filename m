Return-Path: <bpf+bounces-66739-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BF5B38E80
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 00:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 280EA1C21CF4
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 22:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE36D30F80F;
	Wed, 27 Aug 2025 22:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFJnMN7p"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DBF4438B;
	Wed, 27 Aug 2025 22:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756334136; cv=none; b=dJeF+C+ADmKdBt+ubnCUW8QnrDBBnee/4XcO6L/l+bG9DNghNASLLqV4ZGUcVWe6G3TFC9adqtgCMHkZcwK3bkZ7KYoTkBas0RHNT1F9XhMjc2r5Nug/RC4JNEXqhbd/7yj4i4Tpfvpo6Sgx/N+6m1gr23EjAJcgKqklFfKpm04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756334136; c=relaxed/simple;
	bh=SXs86Z/ghHdUpv2SW5CCCQ+HH076bKTpxuaSrBbkGxA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z3dm5nt5G22gKjRZ02vNGTPhbFBAwDc16eODaKZiY+ZHqOPApGbHh99ekmHDVxKz2my82gJ9wP5ng8tMJVrZGW+IWiEvYAx7YUeZIvFTZHp7P9B0ipHaWQzgrbWgieg0IPuv8LcCUwonwVxxK2nEUobuJflyjHh0C3UAkUQaJbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RFJnMN7p; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b47173749dbso287946a12.1;
        Wed, 27 Aug 2025 15:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756334134; x=1756938934; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g436yRDs2oFYHuwHkA6woTZL702ArnB+cDHvw8FDL8c=;
        b=RFJnMN7pHTKkX0VmQ4v2BgzJPCYFbIKBCkLkKIfO3kA1sSpQqNkxr72PAF20J/Aj4U
         B53Vcjaip3PefQS6VZBLHhKZqOpZD37ddT8FwyjvLEqpnUFTK58vMVlcanIcB5W3raFM
         Mw+fBfKZ+Xbnwx+oqLueIq2A8FsLWOKqVM7tvJuBtLl80hP07ZDv8tbAx0B52Q7W2nbI
         BZVnmF72rZqsZFH8wZ+4omxJ3kt+jNSxFCmK3DleTx2PrfaiSNRLz+VFC5j+k0+ZI9BD
         rSY8s2uH272ZbL7o5tYaTQPse8Wa4YXYt88/7L5T1qcma3bt2coKZnB/4j2EcHkIxsE1
         x63Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756334134; x=1756938934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g436yRDs2oFYHuwHkA6woTZL702ArnB+cDHvw8FDL8c=;
        b=O9fOJfBmSoGeY3ZEhq4mefL2XJ2t31TIY633jur5JXYqweL1YeVtNPIJZcxMyZ6wkk
         LE5LS1wLIDCkY1r3OiClhdOf/Cfb6jIj5Gcrxew2tXz7vdnKiibkSlc4SCBCHB/sh+QL
         7Yomx1RW7qCf6u/gmugv9zhRcBROXJNNscCXJfcPPqDY0GHG1lIVfpcEWdouc4/sA5iB
         3SRFHouoZ3r+mF07uGzMQKMfwEL9mWmU1f3s7M8iTQAafLcv/pLCKsUwGfBft8z9QkJa
         NfRsHaPc/NDpiGpraKTW28pvYlwEiCaZeOzh7yxelM59VHvceqE//k6j1g4WFClDlokt
         3sRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIk4iBZocL5yMt+Wcm/A2Af8pqdKlEdLXAmWdLUxAx8/wozTjWCupBSjlDYk1xTlxm1Vn3TAOvnz8gRGb4@vger.kernel.org, AJvYcCXCBiJAp1c2T69pbUZbAPY7iDfN3WOVcmpeO08sbkcalZmrCDl1mIPKmfw1It7vO2ltbsE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr+OSMOGTbPr9CxBRFUzpnsIFctwsTBoNyCeW+XYO64iYnBBhP
	/vHMeY6BwL/K0Nj6ThTDf7sM2VFYiG5qbf525FLSUIiO9zWRrSp0jQhOwe24b1h5lydgJduoBUo
	b1sXfWUGzA4vSL2buajV7khz+knMk69E=
X-Gm-Gg: ASbGncspKC7NghGY1hIiEb9yXOYpmsWGnSAewtPD4Ilqz15OYqy9i1vlkZJebv+b2hs
	ZThDZeScY6B6ycFN4uVzFwuzqu4ZMljteJ1A6d3potEt/UfZZe+zqiL9L+LI4nbdErXVzsx8c9e
	xPhNq/DBZNj72WkVaVvRXMS6cRo+ThfSeu8W9Dn7TCFYSWVEqKniZj5xYDmV8OMj7SpSiomj35H
	+CLMJwyUTLDOgRSs87KLQs=
X-Google-Smtp-Source: AGHT+IEMhGho3V13rfPJ7OAJesJPtlRBTfKaNkPl34bBTrx8f0Z2ik5O1dV7r67GNkOypyb4AvYz5/DDh05R6k6JfCI=
X-Received: by 2002:a17:903:2349:b0:248:abeb:c104 with SMTP id
 d9443c01a7336-248abebc290mr40398975ad.15.1756334133667; Wed, 27 Aug 2025
 15:35:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_65E5988AD52BEC280D22964189505CD6ED06@qq.com>
In-Reply-To: <tencent_65E5988AD52BEC280D22964189505CD6ED06@qq.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 27 Aug 2025 15:35:19 -0700
X-Gm-Features: Ac12FXzr0aV8tX6mrAQDZiFZAhBUoaHQ7KfdnOPlGI_LftpBv2kw6CZvUBSGpks
Message-ID: <CAEf4BzaMUEPjix29JjiYCt1JmWcz97gemSpXL9iD9Gc-g+yZYw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf/helpers: bpf_strnstr: Exact match length
To: Rong Tao <rtoax@foxmail.com>, Viktor Malik <vmalik@redhat.com>
Cc: ast@kernel.org, daniel@iogearbox.net, rongtao@cestc.cn, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, 
	"open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)" <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cc'ing Viktor as well

On Tue, Aug 26, 2025 at 9:29=E2=80=AFPM Rong Tao <rtoax@foxmail.com> wrote:
>
> From: Rong Tao <rongtao@cestc.cn>
>
> strnstr should not treat the ending '\0' of s2 as a matching character,
> otherwise the parameter 'len' will be meaningless, for example:
>
>     1. bpf_strnstr("openat", "open", 4) =3D -ENOENT
>     2. bpf_strnstr("openat", "open", 5) =3D 0

please add these cases to the tests

>
> This patch makes (1) return 0, indicating a successful match.
>
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> ---
>  kernel/bpf/helpers.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 401b4932cc49..65bd0050c560 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -3681,6 +3681,8 @@ __bpf_kfunc int bpf_strnstr(const char *s1__ign, co=
nst char *s2__ign, size_t len
>                                 return -ENOENT;
>                         if (c1 !=3D c2)
>                                 break;
> +                       if (j =3D=3D len - 1)
> +                               return i;

But this seems like a wrong fix. The API assumes that s2 is
well-formed zero-terminated string, and so we shouldn't just randomly
truncate it. Along the examples above, what will happen to
bpf_strnstr("openat", "open", 3)? With your fix it will return
success, right? But it shouldn't, IMO, because "open" wasn't really
found in the first 3 characters of, effectively, "ope".

We should also test bpf_strnstr("", "", 0)... ;)


So maybe something like this (but I haven't really tested it):


diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 401b4932cc49..ced7132980fe 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3672,10 +3672,12 @@ __bpf_kfunc int bpf_strnstr(const char
*s1__ign, const char *s2__ign, size_t len

        guard(pagefault)();
        for (i =3D 0; i < XATTR_SIZE_MAX; i++) {
-               for (j =3D 0; i + j < len && j < XATTR_SIZE_MAX; j++) {
+               for (j =3D 0; i + j <=3D len && j < XATTR_SIZE_MAX; j++) {
                        __get_kernel_nofault(&c2, s2__ign + j, char, err_ou=
t);
                        if (c2 =3D=3D '\0')
                                return i;
+                       if (i + j =3D=3D len)
+                               break;
                        __get_kernel_nofault(&c1, s1__ign + j, char, err_ou=
t);
                        if (c1 =3D=3D '\0')
                                return -ENOENT;


pw-bot: cr


>                 }
>                 if (j =3D=3D XATTR_SIZE_MAX)
>                         return -E2BIG;
> --
> 2.51.0
>
>

