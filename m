Return-Path: <bpf+bounces-18883-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B7C8234BE
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 19:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEC721C23BE3
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 18:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9CD1C6B7;
	Wed,  3 Jan 2024 18:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HiDN4CcN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4BD1C6A3
	for <bpf@vger.kernel.org>; Wed,  3 Jan 2024 18:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso8340298a12.3
        for <bpf@vger.kernel.org>; Wed, 03 Jan 2024 10:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704307406; x=1704912206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQsVnw27CM3f9q4xkJrInRjDOATYaCEsZ47HrdXouQk=;
        b=HiDN4CcN2R41liWKWalLrL6sVyB6T4oU1uLlJOsPCu844u4kIaFV0S1oDn+FwOoCFd
         wZewCuOnFSLRgeBWs1PzrMbHI/dqTQdHi5I+Jr0PEn22cX0aG3W+xCkTBOt5kGkv2Zwu
         tJr2Cot7K0qaiCngUun57UFnKH04HR0xkdeSCSqyDSdfHVTrUle03eNHN9poKGSI0yME
         dGBidZHT2fGGBJPjmfO6RzQb1/f7ijTNQPTxUDbpFKWOVZI4KRehuf47/Y3yKlMOi4rt
         vbTD4xxmPQcQqvXSqQJ2YXQiR37A5arYfyiAJI8536VFwKqPOKtNIMAYrRmGD+JKLrwI
         U++A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704307406; x=1704912206;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GQsVnw27CM3f9q4xkJrInRjDOATYaCEsZ47HrdXouQk=;
        b=vAZ/xxpcaWr8r6dC4lQNg3sKKdwijGolXnPLzUL/jTmxRzjUba9SNB7g1JQxisWq8w
         /nAzIM+8p7DVWcW2JbqPFcya67IDwsAKlTsjKmrc3pdUl9VhYo39T3AXZZtCe0noxzc2
         GetznaPrBT+/r79zwbVml/6O0QyPff8TZ0DVJymx4/0+rqQIprBOtC+YtdPIJq2lVgvV
         tbKERgjVpI35euIBa5FFHJ0HQbT3eGmhwSmaL1ZB2MjZcmmeeJTDRjrrF+ewJahaA10i
         rpX2KgDYV6GHfjsh0ZCdT017luq0WI5+EzQcYD81Ln+1rX2y+ZzeC+ejQjc3LcAOMfDK
         3n8g==
X-Gm-Message-State: AOJu0Yw8/5dnl48JsG015OfPKxedvFd9E05lmpj8cPP120K9klDCJJw5
	hnImfjusq/YDWpxSELi1Las=
X-Google-Smtp-Source: AGHT+IE0CW/A+8cSdP6cqSoqNsThSDZh6KjDh7zadPvBqzluymeubVFRjC9Y8G+MqFR2mYJef2hf6w==
X-Received: by 2002:a05:6a20:8906:b0:194:e4cb:c902 with SMTP id i6-20020a056a20890600b00194e4cbc902mr19105332pzg.44.1704307405672;
        Wed, 03 Jan 2024 10:43:25 -0800 (PST)
Received: from localhost ([98.97.37.198])
        by smtp.gmail.com with ESMTPSA id p21-20020a634f55000000b005cebb10e28fsm1475634pgl.69.2024.01.03.10.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 10:43:24 -0800 (PST)
Date: Wed, 03 Jan 2024 10:43:23 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, 
 Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>
Message-ID: <6595aacbb4c17_25612208f1@john.notmuch>
In-Reply-To: <3ac01843-9dbf-4c5b-a1ac-9acda8c47f19@linux.dev>
References: <20240102193531.3169422-1-iii@linux.ibm.com>
 <20240102193531.3169422-3-iii@linux.ibm.com>
 <6f05eb0d-4807-4eef-99ba-2bfa9bd334af@linux.dev>
 <958781f9b02cb1d5ef82a0d78d65ecdbb3f26893.camel@linux.ibm.com>
 <3ac01843-9dbf-4c5b-a1ac-9acda8c47f19@linux.dev>
Subject: Re: [PATCH bpf 2/3] selftests/bpf: Double the size of test_loader log
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Yonghong Song wrote:
> =

> On 1/2/24 11:05 PM, Ilya Leoshkevich wrote:
> > On Tue, 2024-01-02 at 16:41 -0800, Yonghong Song wrote:
> >> On 1/2/24 11:30 AM, Ilya Leoshkevich wrote:
> >>> Testing long jumps requires having >32k instructions. That many
> >>> instructions require the verifier log buffer of 2 megabytes.
> >>>
> >>> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> >>> ---
> >>>  =C2=A0 tools/testing/selftests/bpf/test_loader.c | 2 +-
> >>>  =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/tools/testing/selftests/bpf/test_loader.c
> >>> b/tools/testing/selftests/bpf/test_loader.c
> >>> index 37ffa57f28a1..b0bfcc8d4638 100644
> >>> --- a/tools/testing/selftests/bpf/test_loader.c
> >>> +++ b/tools/testing/selftests/bpf/test_loader.c
> >>> @@ -12,7 +12,7 @@
> >>>  =C2=A0 #define str_has_pfx(str, pfx) \
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(strncmp(str, pfx,=
 __builtin_constant_p(pfx) ? sizeof(pfx)
> >>> - 1 : strlen(pfx)) =3D=3D 0)
> >>>    =

> >>> -#define TEST_LOADER_LOG_BUF_SZ 1048576
> >>> +#define TEST_LOADER_LOG_BUF_SZ 2097152
> >> I think this patch is not necessary.
> >> If the log buffer size is not enough, the kernel
> >> verifier will wrap around and overwrite some initial states,
> >> but all later states are still preserved. In my opinion,
> >> there is really no need to increase the buffer size in this case,
> >> esp. it is a verification success case.
> > What I observed in this case was that bpf_check() still returned
> > -ENOSPC and failed the prog load. IIUC you are referring to the
> > functionality introduced by the following commit:
> >
> > commit 1216640938035e63bdbd32438e91c9bcc1fd8ee1
> > Author: Andrii Nakryiko <andrii@kernel.org>
> > Date:   Thu Apr 6 16:41:49 2023 -0700
> >
> >      bpf: Switch BPF verifier log to be a rotating log by default
> >
> > The commit message says, among other things:
> >
> >      The only user-visible change is which portion of verifier log us=
er
> >      ends up seeing *if buffer is too small*.
> >
> > So if we don't increase the log size, we would still have to deal wit=
h
> > -ENOSPC. An alternative would be to reallocate the log buffer and try=

> > again. But I thought that for the test code we better keep it as simp=
le
> > as possible.
> =

> Okay, thanks for the explanation. I applied the patch set to
> my local env and indeed, with this patch, I can see libbpf returns
> an error. So as you suggested, let us increase the buffer size to
> avoid extra handling in test_progs. So
> =

> Acked-by: Yonghong Song <yonghong.song@linux.dev>

LGTM.

Acked-by: John Fastabend <john.fastabend@gmail.com>=

