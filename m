Return-Path: <bpf+bounces-51537-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF50A357F2
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 08:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CD9B3AA3FC
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 07:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C6320AF77;
	Fri, 14 Feb 2025 07:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZrd4voV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEF615573F
	for <bpf@vger.kernel.org>; Fri, 14 Feb 2025 07:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739518322; cv=none; b=fyCD9KQIv8zJ1l3bkpPmzQzAmajIhLkp7CQf4SIiRowC3Y+JOICUkl7/QBzQj/vDprEY0P4U50NA/J1fToIxVIZE4C1QCSCT1Dg9Nr5Uz0TkHZ2mg7D1wopxJK6li16SPZYW9V34xPX5IgDBd14fdwPDw95SN+8FKBAakjkM7Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739518322; c=relaxed/simple;
	bh=dR0qhOZbgLOZ4jV6iCFj8vbSLv3c8Wy31l91CG6bgLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aml7Ux+ILMV1rYX6okKiRtRbjjiQcqJvfuW6R7PzVuCB0HMTtWY1fMvrJIaMu9vMo7HVxnjLlXgJpfItd9VJnfh9CJAfHHlv0+HatQvnL9YEztTyHU5U0GDI8br8weRYyUPKxObFoKuUDNC9Ryb3gFkUlhR9z5iq6XE8SGbzdEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZrd4voV; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6e451fdcae2so17368436d6.1
        for <bpf@vger.kernel.org>; Thu, 13 Feb 2025 23:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739518319; x=1740123119; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GRI4Rzk2hXwidTxjLavNPdmNQahBGqv1v2XSoz7Mm0A=;
        b=GZrd4voVCNc3FcGWkQiRvr9pA7goqdPX8PM3jt+XtyXfpnNz78livBHsTMV/2zAGkd
         KSmEM4b6X9qOPabQi4o0cDGbvJ2WZ2UAXtkDMbOknuuUwPcCcg5gwhxT+xtJqhulOo58
         vVgVqHptwaHTQdt42LpF1xCo+9KdVqnnXCL68qCQCLBp8V4biyzgnL6Ye3xRBogVKwu5
         zaICK/5ZC+U+4kjbiR7hBkDWsMKFmCRcQ/EJogjLAgEgvbTdQDPHg3mrhflil8ApZc5A
         0qkA8+C5yo5yOJIGl7W+3qUuAjiCLTtyjA/YFr7+y0+AuWxi14cEMoPvIFqioSv5GPDP
         hhgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739518319; x=1740123119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GRI4Rzk2hXwidTxjLavNPdmNQahBGqv1v2XSoz7Mm0A=;
        b=qm9jTKXRfqHEEDaJ7jCXG31fbqd2LCGX2xGFlj7xNJrii3DYUy5qYPxMIXBEu/m4uE
         XN0s8CsyVqxv5NuNECgPZQZf7kZk435xHZccHJfCGeBQ8rwNXvN93ZNqJOhWQuGHfHj8
         If6LqX7Ybg2uB1sLS/VEP5Yvk3VTFzn/pDBIxjoskwd8izDuGOKn6SfF0COVIAEGUmVD
         v98Mh6m1HxQe4CxpLdvrswLwIPoLfMwD4Wg6jwx7hJ+OcEnQNymp3p4VOUulkPJv3uCi
         JvdYmfSgGYtyF25bc1novvPtUk34ofXY6+++JZhuyiBVr8wnXl9bMpeQNVy/j4v+1pCo
         IAFw==
X-Forwarded-Encrypted: i=1; AJvYcCVnZUhdaTMd9T0XKeBIG8PQWkEnuRcHtSHYJQYiGs3djrmebWgfc5whwr1Z+JCufen6cjs=@vger.kernel.org
X-Gm-Message-State: AOJu0YysnOjfaUHBOpHpmkIrM+pKE6pjmPx4UAmC/8QGczctMJ23qoxn
	dOBCqqbCP2V8QUF9ZF9hEFdVvFuxr6+EUvDWdKuX/oSZu6mVWxYxJSAu3xuTN9N0TlVOanZePXg
	qzcdW26JiFBu/eKZkRPXbaWe0eOc=
X-Gm-Gg: ASbGnctBHm8oQ+GK8c12lW1uerHo1MMBKu0ozNia3KMvvqPWFAbWIdbm6eyEvxhgtOy
	NilLqEZf2AwyUv5cPWWmHL1pLu0HmBHcqQHV0ie+KkhvzFMrmTuCZA4LOKC2XsUDtrBYi6ak/UQ
	c=
X-Google-Smtp-Source: AGHT+IFNPvenTsvhKZL4lHFrWQk1JzmK9GirQSA5usOya37WDl0nMI2tOLMun0UxxqSn8Zkn/U9abbFXWcSlXWMIqkA=
X-Received: by 2002:a05:6214:2484:b0:6d8:a1fe:7293 with SMTP id
 6a1803df08f44-6e46ede44e2mr165555976d6.42.1739518319616; Thu, 13 Feb 2025
 23:31:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211023359.1570-1-laoar.shao@gmail.com> <20250211023359.1570-4-laoar.shao@gmail.com>
 <CAPhsuW6bbbmQFpEX_xHTb9PDq+Xf_p0FH62NwzN6PcPKzi0MrA@mail.gmail.com>
In-Reply-To: <CAPhsuW6bbbmQFpEX_xHTb9PDq+Xf_p0FH62NwzN6PcPKzi0MrA@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 14 Feb 2025 15:31:23 +0800
X-Gm-Features: AWEUYZnK062V-HcIIKMoq7kk3LazTnH_8STpJduc7KdOvDenKZ6_XLVXp5_2U3M
Message-ID: <CALOAHbA5518=ZLr1WZ7jeAo9XTm3LQGLji4f-bY7JQB3KFNbxQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: Add selftest for attaching
 fexit to __noreturn functions
To: Song Liu <song@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, jpoimboe@kernel.org, 
	peterz@infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 1:23=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> On Mon, Feb 10, 2025 at 6:34=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
> > The reuslt:
> >
> >   $ tools/testing/selftests/bpf/test_progs --name=3Dfexit_noreturns
> >   #99      fexit_noreturns:OK
> >   Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  .../selftests/bpf/prog_tests/fexit_noreturns.c      | 13 +++++++++++++
> >  tools/testing/selftests/bpf/progs/fexit_noreturns.c | 13 +++++++++++++
> >  2 files changed, 26 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/fexit_noretu=
rns.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/fexit_noreturns.c
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_noreturns.c b=
/tools/testing/selftests/bpf/prog_tests/fexit_noreturns.c
> > new file mode 100644
> > index 000000000000..588362275ed7
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/fexit_noreturns.c
> > @@ -0,0 +1,13 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <test_progs.h>
> > +#include "fexit_noreturns.skel.h"
> > +
> > +void test_fexit_noreturns(void)
> > +{
> > +       struct fexit_noreturns *fexit_skel;
> > +
> > +       fexit_skel =3D fexit_noreturns__open_and_load();
> > +       ASSERT_NULL(fexit_skel, "fexit_load");
> > +       ASSERT_EQ(errno, EINVAL, "can't load fexit_noreturns");
> > +}
> > diff --git a/tools/testing/selftests/bpf/progs/fexit_noreturns.c b/tool=
s/testing/selftests/bpf/progs/fexit_noreturns.c
> > new file mode 100644
> > index 000000000000..003aafe2b896
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/fexit_noreturns.c
> > @@ -0,0 +1,13 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <linux/bpf.h>
> > +#include <bpf/bpf_helpers.h>
> > +#include <bpf/bpf_tracing.h>
> > +
> > +char _license[] SEC("license") =3D "GPL";
> > +
> > +SEC("fexit/do_exit")
>
> We can add:
>
> __failure __msg(<verifier log added in 2/3>)
>
> here.
> > +int BPF_PROG(noreturns)
> > +{
> > +       return 0;
> > +}
> > --
> > 2.43.5
> >
>
> Then, test_fexit_noreturns above can simply be:
>
> void test_fexit_noreturns(void)
> {
>         RUN_TESTS(fexit_noreturns);
> }
>

Thanks for your suggestion; it really helps simplify the code.

--=20
Regards
Yafang

