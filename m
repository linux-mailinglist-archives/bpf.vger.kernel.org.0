Return-Path: <bpf+bounces-19074-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE6C824AE7
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 23:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1F23281F61
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 22:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B460D21374;
	Thu,  4 Jan 2024 22:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFo0F3ZL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C2D2C6A8
	for <bpf@vger.kernel.org>; Thu,  4 Jan 2024 22:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40d41555f9dso9385815e9.2
        for <bpf@vger.kernel.org>; Thu, 04 Jan 2024 14:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704407624; x=1705012424; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3v2gw/15uUiggyIYdqMtKeWukSvCgldM1mSl1cDqOX4=;
        b=WFo0F3ZLWm+qIepMG7gTh374NSnzN91PmkHeMoRRoj/MIYkKwJ1Z7t9m8C4vrWzWpL
         DxERYii1Pi6DwnP6WT9AZcpJUdWaphplJEL3wHVuwZU6LZXBHyoaFrihetCXWEYmsCIb
         w+RFKqBcrPSpGnjeSFkKZkLhIc3CbZYa1uPlq6qpjqc7rAVs7tdnWWzo7ivGWwE2i0lk
         03gyT+f3QOyJDEDvDHLK9c1Wmf3o1V1WDbJI/RyjEAzAvQGi6r/YAUdrj/Fz8J5ztLHB
         3kZRb5BkNT/rjmkgxiOj+D7BYgoMuVcR/VeiMIejY1HCJCBRnZlkKiuA416A63fH1+8f
         kKow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704407624; x=1705012424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3v2gw/15uUiggyIYdqMtKeWukSvCgldM1mSl1cDqOX4=;
        b=oAlALzkTCt0RGnOq0p6wjkRljjG6B69IoYTaDo4AMn8nzHYiWqAXElTCcJIF1VFrIT
         5C4rpnina8keqA6S/L98h7OT1My4EkClM4y1xvxWER2LnedtwgmTANJAEDqT3crfCjox
         NwvDuzSeLd29Ea9jBOjl5UJ71CJ6EG0eWNiYYkUrar+CkwmVZ1X8M1CglhU0Y3lzOa3p
         Qj9cqWFp0ggOltOPpg1BhZYqM1ofSnJbQahrvU2MoN0dGuN0L/4xn0tIneZbfIzIe6x0
         Dq0B0rP3mdBNfRnhsSlyCJI0NnSzY6hQIO3jH1w0IxF7VmHbdaJgREFsHZZd2sEMYT8H
         a/hQ==
X-Gm-Message-State: AOJu0YzcLuijxbq4qTmRHdr40YDECX0jc5baH6XJ2aZkmvaokMFa5IPO
	Nz+TubvLk3fn1rZiacvRDPvdnnuqiYm6k+OgCLXZjYwyB0A=
X-Google-Smtp-Source: AGHT+IHMPYPiVHshPcZwY4hnVecyQOXJnGQoJ3C36pOqpAwXPGIv5iXHLAHQRN5/7jposuzaov7AzPNhf6zSaZiwoVQ=
X-Received: by 2002:a05:600c:3d14:b0:40e:369c:edeb with SMTP id
 bh20-20020a05600c3d1400b0040e369cedebmr227218wmb.59.1704407623731; Thu, 04
 Jan 2024 14:33:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102193531.3169422-1-iii@linux.ibm.com> <20240102193531.3169422-3-iii@linux.ibm.com>
 <6f05eb0d-4807-4eef-99ba-2bfa9bd334af@linux.dev> <958781f9b02cb1d5ef82a0d78d65ecdbb3f26893.camel@linux.ibm.com>
 <3ac01843-9dbf-4c5b-a1ac-9acda8c47f19@linux.dev> <CAADnVQ+Y1MXe1WJg+Uv3to9jytL-6_qCdxgFsiB6rdzmwSf_MQ@mail.gmail.com>
In-Reply-To: <CAADnVQ+Y1MXe1WJg+Uv3to9jytL-6_qCdxgFsiB6rdzmwSf_MQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 4 Jan 2024 14:33:32 -0800
Message-ID: <CAADnVQK-zVo44z1ygPstbParCMB2tSXz=epgooktzLWPW+FkoQ@mail.gmail.com>
Subject: Re: [PATCH bpf 2/3] selftests/bpf: Double the size of test_loader log
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 1:19=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Jan 3, 2024 at 10:15=E2=80=AFAM Yonghong Song <yonghong.song@linu=
x.dev> wrote:
> >
> >
> > Okay, thanks for the explanation. I applied the patch set to
> > my local env and indeed, with this patch, I can see libbpf returns
> > an error.
>
> How did you repro this?
> I've tried reverting this patch, but the test in patch 3 still passes
> for me without errors.

Took me a long time... I was able to repro with:

diff --git a/tools/testing/selftests/bpf/progs/verifier_gotol.c
b/tools/testing/selftests/bpf/progs/verifier_gotol.c
index 05a329ee45ee..66bdb940a40b 100644
--- a/tools/testing/selftests/bpf/progs/verifier_gotol.c
+++ b/tools/testing/selftests/bpf/progs/verifier_gotol.c
@@ -36,6 +36,7 @@ l3_%=3D:
         \
 SEC("socket")
 __description("gotol, large_imm")
 __success __failure_unpriv __retval(40000)
+__log_level(1)
 __naked void gotol_large_imm(void)

and then I finally realized that this patch is fixing
the case when test_progs runs with -v. Like:
./test_progs -t gotol -v

I wish you mentioned this in the commit log.
Would have saved me a ton of time.

