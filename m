Return-Path: <bpf+bounces-42702-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54EE89A9390
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 00:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 964DFB21650
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 22:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5261FEFBC;
	Mon, 21 Oct 2024 22:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bmb87qHL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D616137750
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 22:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729551283; cv=none; b=dIAkxMHKXG3ICUbCnErmWXm5MWNn2Aw0eOVFLo444xPeW7OjWdzn8k10G4RkXMVh+xtBSvVOlrGL/Slr19pS1/z3g+F/Bf9qnKmFqaamkfClccqLJVeyomYVrvKliGWxoqEvsNp6prNXAmvLklmGSuGe8nJTSkfOxxsO1kLAQR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729551283; c=relaxed/simple;
	bh=Q/XIsVGE4Q/EJpJlLfeLROiJ8qy+ZKFe94yK4mxX9Wk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OwBu1FYIGtxLqHxa4jqNWo1FBnTORQutAIY3TCeax4fiQoknSMaTdQhyhjUT6KopzaI8IslHccj+HUSxVEtmtWxYcG9n/kD0LbNje7MtK4YzApG1Vkk+DNz+q/DS9QhcDTQWstCu2heZa06f8eUBiJT9ThrFB4/Z4yHUfsV39lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bmb87qHL; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20c8ac50b79so86275ad.0
        for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 15:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729551281; x=1730156081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OYWm8qPtDHK7Ptrp4+QU3serWZnnV9n3j6iMIME5OTo=;
        b=bmb87qHL5bm6HRH+Z5zJoc4+bccfHrRR5aehCJx8vF74P0uxDhMQO+akgEQZXV8k2l
         DwRm3G5xJGI9RBzGF4l7Ya5gHlkfxN0fN2ghbf3rZQM23yBWLi0TWq4/4Hz/3suwBF2y
         dASTfi0aOYaEPu+inwie2z0UG4NikcLFp+dYw3JtN9n21KxecWXjpuLpvII6qkLP+s+c
         7E0qPgwnhPupfTyEbCHVzcZKzwTaxfHvgK5DHW2qZfyG7NCUR+Knrh4tOLLlJsEZoBUr
         6RKcjDyjH6KN6FOH5HcjtrRsYYrs7QnPFF/dC9qvUseML/+IKs6jJPRU6TPnlPs2hoWD
         SWqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729551281; x=1730156081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OYWm8qPtDHK7Ptrp4+QU3serWZnnV9n3j6iMIME5OTo=;
        b=Y6T+eJmpZ1aIpR8TjfTS+iqhDhe9AfoLg/i88OWe6tYdETXzVUNYCxOUvc7U5xLajs
         T5yBB4fWbDQzFMIAPMuyV/X4LZzd2W5WvsUb8Qwop08EwnvqEbYNAR0EXkZB+FiNK99N
         Is1bT67su174Nnx4trZqRj0cX+V1kWuyBN/6gwJy6ZGGILlhOzcijofMp1zB0ssC7S+a
         DhK1jXc7MLv6E22T9RX1UOs7dPPfaE9qEjDssjgaggILVgSD1YiDorva/v5t3zpuNf+C
         7JZ469xFZstvydUMpLOEm9VbZN+Te9S3nRLjCayH6MPs6vE4MTlaNxlNHVzsx2ttKYjK
         +zyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvZtKBR7PC3C77ZsFuctwFEKjslmcY2a9T2C2kyuhM4LpcVVYlVjIGa0+pCM3GZ5uRU80=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTNCn6vCNd6UyNSO2RAPPSFpqWIn/+hMZhoxeu8gG+Ii8i4KZy
	WuBB4YkiJHpoVBy4AKQYngoArjeB+oJgOedT3DS9pSkEbWEPQlslY8my/gbaD4ki5/8mWi1vIjO
	y1U7iT4isLOkS4O/sqkyQnn5LAWChLzJ66Iw5gkkW9SyAilOyuyV0
X-Google-Smtp-Source: AGHT+IF2QkQLH/jexBZQwaUOU9+BOJypjphzTBtnfLoXWmAxPffUJk9u40roRuw2Fw3F57A4PtclyRxhoo9XerM3FKQ=
X-Received: by 2002:a17:903:18d:b0:206:ae0b:bfcb with SMTP id
 d9443c01a7336-20e9806cf6cmr1181895ad.28.1729551281280; Mon, 21 Oct 2024
 15:54:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017225031.2448426-1-jrife@google.com> <20241017225031.2448426-2-jrife@google.com>
 <fb910573-41d8-47b5-8ab9-ecbc8df7a56b@linux.dev>
In-Reply-To: <fb910573-41d8-47b5-8ab9-ecbc8df7a56b@linux.dev>
From: Jordan Rife <jrife@google.com>
Date: Mon, 21 Oct 2024 15:54:28 -0700
Message-ID: <CADKFtnSgnPMOM5Fz8t-HMSkHOp+8VwuB76GJa4JCrKUVL1aTzA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/4] selftests/bpf: Migrate *_POST_BIND test
 cases to prog_tests
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	"Daniel T. Lee" <danieltimlee@gmail.com>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> How is verbose used and is it still needed?

It probably isn't needed here, so I will remove it. sock_create.c,
whose structure I emulated for sock_post_bind.c, has something
similar, but it seems superfluous there as well.

> nit. ASSERT_OK_FD().
> Since the test binds to a specific ip/port, please run it in its own netn=
s

Sure, will do.

-Jordan

On Mon, Oct 21, 2024 at 2:28=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 10/17/24 3:49 PM, Jordan Rife wrote:
> > Move all BPF_CGROUP_INET6_POST_BIND and BPF_CGROUP_INET4_POST_BIND test
> > cases to a new prog_test, prog_tests/sock_post_bind.c, except for
> > LOAD_REJECT test cases.
> >
> > Signed-off-by: Jordan Rife <jrife@google.com>
> > ---
> >   .../selftests/bpf/prog_tests/sock_post_bind.c | 417 +++++++++++++++++=
+
> >   tools/testing/selftests/bpf/test_sock.c       | 245 ----------
> >   2 files changed, 417 insertions(+), 245 deletions(-)
> >   create mode 100644 tools/testing/selftests/bpf/prog_tests/sock_post_b=
ind.c
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/sock_post_bind.c b/=
tools/testing/selftests/bpf/prog_tests/sock_post_bind.c
> > new file mode 100644
> > index 000000000000..c46537e3b9d4
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/sock_post_bind.c
> > @@ -0,0 +1,417 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include <linux/bpf.h>
> > +#include <test_progs.h>
> > +#include "cgroup_helpers.h"
> > +
> > +static char bpf_log_buf[4096];
> > +static bool verbose;
>
> How is verbose used and is it still needed?
>
> [ ... ]
>
> > +     if (bind(sockfd, (const struct sockaddr *)&addr, len) =3D=3D -1) =
{
> > +             /* sys_bind() may fail for different reasons, errno has t=
o be
> > +              * checked to confirm that BPF program rejected it.
> > +              */
> > +             if (errno !=3D EPERM)
> > +                     goto err;
> > +             if (port_retry)
> > +                     goto retry;
> > +             res =3D BIND_REJECT;
> > +             goto out;
> > +     }
>
> [ ... ]
>
> > +void test_sock_post_bind(void)
> > +{
> > +     int cgroup_fd, i;
> > +
> > +     cgroup_fd =3D test__join_cgroup("/post_bind");
> > +     if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))
>
> nit. ASSERT_OK_FD().
>
> Since the test binds to a specific ip/port, please run it in its own netn=
s. It
> is easy to do with netns_new and netns_free, a recent example:
>
> https://lore.kernel.org/bpf/20241020-syncookie-v2-1-2db240225fed@bootlin.=
com/
>
> The same netns can be reused for different subtests of this "sock_post_bi=
nd" test.
>
> Others look good. Thanks for moving the test to test_progs.
>
> pw-bot: cr
>

