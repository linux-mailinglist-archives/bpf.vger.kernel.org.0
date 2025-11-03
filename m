Return-Path: <bpf+bounces-73293-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABFEC29C64
	for <lists+bpf@lfdr.de>; Mon, 03 Nov 2025 02:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 754F23A55F9
	for <lists+bpf@lfdr.de>; Mon,  3 Nov 2025 01:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A48271469;
	Mon,  3 Nov 2025 01:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4aGudqB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80542F5E
	for <bpf@vger.kernel.org>; Mon,  3 Nov 2025 01:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762132838; cv=none; b=quAifxgYQtGqpsOXGNvYe6cF2NtG8A+++LpQS1OghgXqN5rU7ZajAG/PgmFAtIsoLkqUEFnG0PBYbUmvvYL+ayaz/a5NZWlxITAqsXUKhfKgFlQxVSMTTAeMd34eqF3cjPJq0+cDJ2oToau2pMy7yZJjpsZtwLwwJI8nGyYVLbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762132838; c=relaxed/simple;
	bh=1LAAn+Z5xoPYzyg30F9FeK8noBsYqvleFp9Jn25EztY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HrS+AGRNmcc4mkSGH8YRyT5jyFZPeAjFB+wfbLscvFPmZdrcrjoFbL1hXc0C/SingOCe7GGv2xXI29v/H9i7LklcFmBDKNZTWpdKSB5/A0WoK7Nehn9zX1r1AmTX31A7ARg+tjKrfQoZTK/ymPiUq68NKU4hJ8jeea0u8N2hfIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E4aGudqB; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-640bd9039fbso726896a12.2
        for <bpf@vger.kernel.org>; Sun, 02 Nov 2025 17:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762132835; x=1762737635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6o69PGXXR3RBbRcnqQbAWMDbgwdLMCFEE7c26uWS6X0=;
        b=E4aGudqBP8EWlh7tl1u2bJtjL5NNQ7peD15wjM+KJESfVVFFlRu8/ksMOX7YjtW3r+
         OtOhTt3HdoScypUyvXKb2zmcs3lu2KLPYL4Nd1W/15p57VehO+LjDXL27PDYKkTyszY1
         UCvpyfPogPsmvwKjXKct7DBlpvuBJ71c+OULsGh3uRLIvX5BG0OdxGHra3FRtiWs6DoL
         agxC4Roy8Og86635L7Pa0TBJwU9Uq2foSJtLaGyVVK2ZKw4Hjr3QEmc+Y7JPqz1qxh4v
         mOZldgEb3gX51PNzQ50t0SeDQTkpMPshVVWICJNqVnafyOlLlNb92ybWmh+l/GdKEAwD
         Saww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762132835; x=1762737635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6o69PGXXR3RBbRcnqQbAWMDbgwdLMCFEE7c26uWS6X0=;
        b=uzDRlFj55x6HNrGArZP96wmHe373H50FJK40qJ2EPO35osJ55XBpRftSBd/Ur7fEe6
         /Q4ob6CczrR1gY00jIr8ZcS4V2huFlAXfzML0fdVXDGnyo4BXGaL9BJXmBqs1wi5JJQM
         SUDVXKVewJ+ReGcxmnfcP6ldEHgE+PWdlGA4xOIaeITYm2IbbHaUa0x8SzWAywPbn/OL
         MUFN5afJbVkVNTmMGsmE509aicHqu9LAK+bj3GQ+RN+2PQGwn+lHybeLkmDVCh/6cFLl
         qufO99pApmEHi2DXFm6YKlvac+OLRSobT6nWBcS8J7CtfA+T18vW1m7CynIaGaL8qhp4
         W04w==
X-Forwarded-Encrypted: i=1; AJvYcCXWv+LtETqIG5TKSsloKZ10w1GYab6K0Rxm/VFcKUE9aSVykXW5ftx0aO5/K2kCpnT3xI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAppppq70LQ43l5WP9ULVi771fAhPAFEP2o9iR114effnZK296
	EvJl3hLMYT56W8Ih9wmf5EprcR6jqHJ9TnvnkfvXeAtZkIfMlbeAOFOXUqBQt0hrjxQyL3+bXNF
	kpFnmRdRq/NTRuC3Lc5jKj6QqfLajNpQ=
X-Gm-Gg: ASbGncsiusR+mY6DYHn1GrammayabLkHn7t8yHqzQEHkSkTsUlslEJnAq8Msaio8mbJ
	7zL3yJV8AFNW+akyB5W0Dqt1pd+Zl0/NTrDbvpaGA5FeecNxPtKYUi1ZM2c8KcjWZniBE37vHj9
	bPRTz8QBCJK0Cd9RfZIbuV02MmxIPZzhlel424Go/Z3ag+SfeG8/f4gDWPcafyvYF8J8ghCfgiq
	HU5V9rw6kXZT76u9i1zuFqSCN6tC0SQ8sOub0qUWwexnMmo56KCUu2QnaYsdQ==
X-Google-Smtp-Source: AGHT+IFQiFViuJQbXhEm8/2UCUwAZnU0wpU5q41bCr6Py0FglerqTsyWswO1/oU/bE3nF1HvunvUPgqDMQii18SeD8I=
X-Received: by 2002:a17:907:70e:b0:b3e:8252:cd47 with SMTP id
 a640c23a62f3a-b70704bc386mr1151976166b.31.1762132835081; Sun, 02 Nov 2025
 17:20:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027135423.3098490-1-dolinux.peng@gmail.com>
 <20251027135423.3098490-4-dolinux.peng@gmail.com> <CAEf4BzZ+tpT2ViD_zc8mwz260spriYDiPymw3MFsEibRcuqbqg@mail.gmail.com>
 <CAErzpmvahZJRFktDydp5tcpYnhCAw9P9UmPeC5XpRxPuo0mZ8w@mail.gmail.com> <CAEf4Bzbv+vgsh9_8hsy=JMojmdR_Zoq1EEzaGj0CetMN-7LmDQ@mail.gmail.com>
In-Reply-To: <CAEf4Bzbv+vgsh9_8hsy=JMojmdR_Zoq1EEzaGj0CetMN-7LmDQ@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Mon, 3 Nov 2025 09:20:22 +0800
X-Gm-Features: AWmQ_bkLzXSgwO3OCR1pUlQf1s0rqdB7tTg-l9OMrUdUmcHpDX7YKB7cR9ncZ4c
Message-ID: <CAErzpmsVHD7Z5h3jiv8xjVrZcGtZd2umuB-8sv8TsNuTLs8A7A@mail.gmail.com>
Subject: Re: [RFC PATCH v3 3/3] btf: Reuse libbpf code for BTF type sorting
 verification and binary search
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Eduard Zingerman <eddyz87@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, Song Liu <song@kernel.org>, 
	pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 1, 2025 at 12:51=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Oct 28, 2025 at 7:03=E2=80=AFPM Donglin Peng <dolinux.peng@gmail.=
com> wrote:
> >
> > On Wed, Oct 29, 2025 at 2:40=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Mon, Oct 27, 2025 at 6:54=E2=80=AFAM Donglin Peng <dolinux.peng@gm=
ail.com> wrote:
> > > >
> > > > The previous commit implemented BTF sorting verification and binary
> > > > search algorithm in libbpf. This patch enables this functionality i=
n
> > > > the kernel.
> > > >
> > > > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > > > Cc: Alexei Starovoitov <ast@kernel.org>
> > > > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > > > Cc: Alan Maguire <alan.maguire@oracle.com>
> > > > Cc: Song Liu <song@kernel.org>
> > > > Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> > > > Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
> > > > ---
> > > > v2->v3:
> > > > - Include btf_sort.c directly in btf.c to reduce function call over=
head
> > > > ---
> > > >  kernel/bpf/btf.c | 34 ++++++++++++++++++----------------
> > > >  1 file changed, 18 insertions(+), 16 deletions(-)
> > > >
> > > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > > index 0de8fc8a0e0b..df258815a6ca 100644
> > > > --- a/kernel/bpf/btf.c
> > > > +++ b/kernel/bpf/btf.c
> > > > @@ -33,6 +33,7 @@
> > > >  #include <net/sock.h>
> > > >  #include <net/xdp.h>
> > > >  #include "../tools/lib/bpf/relo_core.h"
> > > > +#include "../tools/lib/bpf/btf_sort.h"
> > >
> > > I don't believe in code reuse for the sake of code reuse. This code
> > > sharing just makes everything more entangled and complicated.
> > > Reimplementing binary search is totally fine, IMO.
> >
> > Thanks. Would you be open to the approach from v2, where we place
> > the common code in btf_sort.c and compile it separately rather than
> > including it directly?
> >
>
> No, the code is too trivial to try to reuse it. Kernel and user space
> libbpf code are run with different constraints, sharing it is
> necessary evil (like for BPF CO-RE relocations), not something that
> should be encouraged.

Thanks, I will implement it separately as recommended.

>
> > >
> > > [...]

