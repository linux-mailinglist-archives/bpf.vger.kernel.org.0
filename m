Return-Path: <bpf+bounces-16451-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 357F4801381
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 20:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCCCF28155F
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 19:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423654F1E1;
	Fri,  1 Dec 2023 19:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHhjFuYb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5C3B0
	for <bpf@vger.kernel.org>; Fri,  1 Dec 2023 11:17:20 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9e1021dbd28so361928766b.3
        for <bpf@vger.kernel.org>; Fri, 01 Dec 2023 11:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701458239; x=1702063039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vFoREuU6DjgHmXYWygeeaB8agh40b+J+anc0cCSq++w=;
        b=BHhjFuYbzJSlHkbUlRuNunZfUNnAnBYvPNxNKlFO1JnFj07fTh+n4q1o2lHxoOQcRp
         tYjHIFy6AR54797CEOnIcLgK8TY8MSCb34J+vy5nzwZSirPrc0PuA6kJCZTXQdlYIAJI
         AGWjSSYPOvTU9JTo3xp+vDEzZeP61BVaD/g1ym/RAR2lNb3j6iVpkWg2gJSyimZNdz3L
         SFh2z5sSfWNjGADBV5p18rinFOGi6M9IG97naadAEvlyFizAQmLg6yFm3kevu3SP1drM
         X5k2uCvYi2ZhI3ImZ1R43IAGPfIa1+Mp6iyzlbmYZpJBP9ApeWmcY1lLzyjbwtd+jjrw
         CmtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701458239; x=1702063039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vFoREuU6DjgHmXYWygeeaB8agh40b+J+anc0cCSq++w=;
        b=E41Q/xYx/xDPOxHzA+j59HMYWh8YuPzuC+iheJDWm0sZJqoBHs9xD8ijzETtGiycaY
         EgVAvTDtufzVXmfylG2lhqmdMUVN0dgb4N9KIEYiy5qkY3AzRClW4V/JQdOWkTTDjEZ6
         cMMNV3DVZEszt9iWdTF63/Rvqr5a4IuW8hr7qUBVstnSZPQ67bTyyV+NK74YrUlGwmeG
         lRZN6GLsCGKJrXL/242dsoWKRtfNjW7mD10rLt+rDpbsQueMNOHBOs4j0iXcqQYxazMc
         jYxi0GfkG+vDSB5lhG463GKDKIu83ugaUHWNOiE0gb7KDYTgXNsJ5XHRESrX+ZBBIpBI
         zB3Q==
X-Gm-Message-State: AOJu0Yxby8Xbrox780eLJGYeF+YegHFtzlIP7sJd1o5r/rxxkPB7/RTe
	VC9zHllTMieaWSGYsl2kQ+tv5rsVBy4t4Tx7Wjs=
X-Google-Smtp-Source: AGHT+IFl99+4rBvRDqfWDc6IA/RLYo8qXnXrBGBIK1nymz5laZw+r0YuAI3zkGWkWi8vM/xaO6VFoduDLZKbi+XdyoE=
X-Received: by 2002:a17:906:853:b0:a18:3b25:d72e with SMTP id
 f19-20020a170906085300b00a183b25d72emr1144407ejd.67.1701458238913; Fri, 01
 Dec 2023 11:17:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231201013006.910349-1-andrii@kernel.org> <68fc1915f6d0fec5d4503052dfabe0f0f9fb6d91.camel@gmail.com>
In-Reply-To: <68fc1915f6d0fec5d4503052dfabe0f0f9fb6d91.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 1 Dec 2023 11:17:07 -0800
Message-ID: <CAEf4BzYgdX4m15fV9Xujk8RRDbwNH5zWuV6Wb+k2+NXigJ5nNA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: validate eliminated global
 subprog is not freplaceable
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 1, 2023 at 7:16=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Thu, 2023-11-30 at 17:30 -0800, Andrii Nakryiko wrote:
> > Add selftest that establishes dead code-eliminated valid global subprog
> > (global_dead) and makes sure that it's not possible to freplace it, as
> > it's effectively not there. This test will fail with unexpected success
> > before 2afae08c9dcb ("bpf: Validate global subprogs lazily").
> >
> > Suggested-by: Alexei Starovoitov <ast@kernel.org>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>

Oops, didn't see your reply before sending v2. But there will be v3 anyway =
:)

>
> [...]
> > diff --git a/tools/testing/selftests/bpf/prog_tests/global_func_dead_co=
de.c b/tools/testing/selftests/bpf/prog_tests/global_func_dead_code.c
> [...]
> > +void test_global_func_dead_code(void)
> > +{
> [...]
> > +     ASSERT_HAS_SUBSTR(log_buf, "Subprog global_dead doesn't exist", "=
dead_subprog_missing_msg");
>
> Nit: the log is not printed if verbose tests execution is requested.

I'm not sure I understand. What do you expect to happen that's not
happening in verbose mode?

>
> [...]
>
> > index a0a5efd1caa1..7f9b21a1c5a7 100644
> > --- a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
> > +++ b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
> > @@ -10,25 +10,31 @@
> >
> >  int arr[1];
> >  int unkn_idx;
> > +const volatile bool call_dead_subprog =3D false;
> >
> > -__noinline long global_bad(void)
> > +__noinline long global_bad(int x)
> >  {
> > -     return arr[unkn_idx]; /* BOOM */
> > +     return arr[unkn_idx] + x; /* BOOM */
> >  }
>
> Nit/question:
>   Why change prototype from (void) to (int) here and elsewhere?
>   Does not seem necessary for test logic.

I had some troubles attaching freplace initially, but my freplace
skills were rusty :) I can try undoing this and leaving it as is.

>
> [...]

