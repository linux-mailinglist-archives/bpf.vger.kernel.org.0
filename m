Return-Path: <bpf+bounces-43835-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 106C19BA681
	for <lists+bpf@lfdr.de>; Sun,  3 Nov 2024 16:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80B78B21157
	for <lists+bpf@lfdr.de>; Sun,  3 Nov 2024 15:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4717418660B;
	Sun,  3 Nov 2024 15:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdkAjKN3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFD8E552
	for <bpf@vger.kernel.org>; Sun,  3 Nov 2024 15:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730649531; cv=none; b=qmElYnHpnGYeoNe2uFrwqNGMK6KEdU111NHr7sjYhlNAMm/icJ2OfKnKSqvf7YODewhk//gvNppeRYzsbFFZuZrWVjFK7XDcZ4tinaxdxN4TdBX6rJ0cS02GfbYJ5YHPa1Xk1eI19x48pfjrp3DDD0kmx5uwfeBoZYjxFJhtCdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730649531; c=relaxed/simple;
	bh=0hgMhOZptKLHBqJMbuQZ7MUZ1mQuFjKfC9PQy7ItJa8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ze55eTD5akS33v4KEvnJ9gdQCxYUijTOVNOjbt61NchO+bRwYB0seTSA4w+g7Sbd1Le0aE/i3kp/xrQhYrbw8QIW+9kSGgJEIGAD39UYyU9Vd3WoBFcfsqrUin3IJ1UV4qbnn9GWNcrijY+ND9+c/08Rq1nZlxAZ8q8JP2ReqH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdkAjKN3; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-a9a68480164so532910866b.3
        for <bpf@vger.kernel.org>; Sun, 03 Nov 2024 07:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730649528; x=1731254328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6HoE8V/DR8l5NJBuRZip+1VlA3vBjYirOlT/zMXf7p8=;
        b=bdkAjKN3j2Is/JBtchO9BxAt6ncACeyFZ/NJaO6F4aH4wKCDyUSGrxWdGHhYmJYV+z
         MuQDZ7Opr4W51pIPev5XohflUnJuSTragXjnwB7/thVu4zNBWOVs4V+y+kdKgKferUB+
         GaB2t9Odly8hp0aCKU1DknYbG+50M2VEGK/QlZIVTpiuHCBn1YyNgc3M4AX6uM7hhFJD
         lr4KQjGXkiFj3xOhUXIDix84Ad+4TGJVkbIpY3b8YtFLuSnQslQAxhcpMH1Jh30qZVIz
         8OsAu19sBNQ4Sq1yBQdXzsm722FGki8FKX6aMn/0AAY9H8nEpWHJoE4bGVFX9w9fXoWn
         zXjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730649528; x=1731254328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6HoE8V/DR8l5NJBuRZip+1VlA3vBjYirOlT/zMXf7p8=;
        b=PJtQzUu7Sa6oYAOL4vzBUocr2ZV7PGrXkMNnVfxGvdWy+ll7WK4WV2tisXE9O5Tj+z
         M/qSkNnksHcXy8asq6+bmCVODRscD8RbCYVZHM2iGhk+PPDRfi0rhRsgG8x8l9M9ZthA
         pccdHGNCzDobyhaMYJVbxNY7n3ODh7UI/v0Ubl86YPM8l4bzn2ydYDA3InU8vfNu1xkC
         QxN8g/Y1ux9F6mNtIxp/+8dgIlz0ry8aIcvbrxlMNXQR08ih7E3aTKV0CwoJByvd0lls
         q/pz1kl64h29IkPCCMQCSKqgmmEF4CGy0AcpBNqeIrxLjnH9SdkWOTEc8da3bkDig/bz
         /9Kw==
X-Gm-Message-State: AOJu0YzGt+/wORqYOOr2lcTcOmi0jpyzUAOZhaVK4PuiCxS/KI11bZ1B
	Bj0Why4wc0NapaOrMwGuEeIBEjfpmB6YfjJbN4FvD+o+o9EuwHHziX08KmArBkP0v7FlVqKtlny
	4KfDA7DvVe0begVBnJejKdG/SL6E=
X-Google-Smtp-Source: AGHT+IFakvAS67sa10b/iRLAVYPMcnf+PBSktKr1Duq7lBR6R5GIekAdtBZBpalo6Sl4aUCF61ZcmqZ4Oxkeo9Wh3fM=
X-Received: by 2002:a17:907:7da0:b0:a99:f972:7544 with SMTP id
 a640c23a62f3a-a9de5f40788mr2621568766b.38.1730649527807; Sun, 03 Nov 2024
 07:58:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101000017.3424165-1-memxor@gmail.com> <20241101000017.3424165-3-memxor@gmail.com>
 <CAEf4BzY0ury4nWGOrjk1V2qK5+e1GT3b=i9eLLS42QB_QfNVyQ@mail.gmail.com>
In-Reply-To: <CAEf4BzY0ury4nWGOrjk1V2qK5+e1GT3b=i9eLLS42QB_QfNVyQ@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sun, 3 Nov 2024 09:58:11 -0600
Message-ID: <CAP01T76R-ycapvvnD7LYUde5DddH5AdyVrVbuat04jaM_0t0NQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/2] selftests/bpf: Add tests for raw_tp null handling
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, kkd@meta.com, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Steven Rostedt <rostedt@goodmis.org>, 
	Jiri Olsa <olsajiri@gmail.com>, Juri Lelli <juri.lelli@redhat.com>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 1 Nov 2024 at 14:19, Andrii Nakryiko <andrii.nakryiko@gmail.com> wr=
ote:
>
> On Thu, Oct 31, 2024 at 5:00=E2=80=AFPM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > Ensure that trusted PTR_TO_BTF_ID accesses perform PROBE_MEM handling i=
n
> > raw_tp program. Without the previous fix, this selftest crashes the
> > kernel due to a NULL-pointer dereference. Also ensure that dead code
> > elimination does not kick in for checks on the pointer.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  .../bpf/bpf_testmod/bpf_testmod-events.h      |  8 ++++++
> >  .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  2 ++
> >  .../selftests/bpf/prog_tests/raw_tp_null.c    | 25 +++++++++++++++++
> >  .../testing/selftests/bpf/progs/raw_tp_null.c | 27 +++++++++++++++++++
> >  4 files changed, 62 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/raw_tp_null.=
c
> >  create mode 100644 tools/testing/selftests/bpf/progs/raw_tp_null.c
> >
> > diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod-events=
.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod-events.h
> > index 6c3b4d4f173a..aeef86b3da74 100644
> > --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod-events.h
> > +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod-events.h
> > @@ -40,6 +40,14 @@ DECLARE_TRACE(bpf_testmod_test_nullable_bare,
> >         TP_ARGS(ctx__nullable)
> >  );
> >
> > +struct sk_buff;
> > +
> > +DECLARE_TRACE(bpf_testmod_test_raw_tp_null,
> > +       TP_PROTO(struct sk_buff *skb),
> > +       TP_ARGS(skb)
> > +);
> > +
> > +
> >  #undef BPF_TESTMOD_DECLARE_TRACE
> >  #ifdef DECLARE_TRACE_WRITABLE
> >  #define BPF_TESTMOD_DECLARE_TRACE(call, proto, args, size) \
> > diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/to=
ols/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> > index 8835761d9a12..4e6a9e9c0368 100644
> > --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> > +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> > @@ -380,6 +380,8 @@ bpf_testmod_test_read(struct file *file, struct kob=
ject *kobj,
> >
> >         (void)bpf_testmod_test_arg_ptr_to_struct(&struct_arg1_2);
> >
> > +       (void)trace_bpf_testmod_test_raw_tp_null(NULL);
> > +
> >         struct_arg3 =3D kmalloc((sizeof(struct bpf_testmod_struct_arg_3=
) +
> >                                 sizeof(int)), GFP_KERNEL);
> >         if (struct_arg3 !=3D NULL) {
> > diff --git a/tools/testing/selftests/bpf/prog_tests/raw_tp_null.c b/too=
ls/testing/selftests/bpf/prog_tests/raw_tp_null.c
> > new file mode 100644
> > index 000000000000..b9068fee7d8a
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/raw_tp_null.c
> > @@ -0,0 +1,25 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
> > +
> > +#include <test_progs.h>
> > +#include "raw_tp_null.skel.h"
> > +
> > +void test_raw_tp_null(void)
> > +{
> > +       struct raw_tp_null *skel;
> > +
> > +       skel =3D raw_tp_null__open_and_load();
> > +       if (!ASSERT_OK_PTR(skel, "raw_tp_null__open_and_load"))
> > +               return;
> > +
> > +       skel->bss->tid =3D gettid();
>
> this is not available everywhere, we just recently had a fix. Other
> tests call syscall() directly. It might be time to add macro in one of
> the helpers headers, though. But that can be done as a separate clean
> up patch outside of this change (there is enough to review and
> discuss)

Ok, I can include a clean up patch in the next revision.

>
> > +
> > +       if (!ASSERT_OK(raw_tp_null__attach(skel), "raw_tp_null__attach"=
))
> > +               goto end;
> > +
> > +       ASSERT_OK(trigger_module_test_read(2), "trigger testmod read");
> > +       ASSERT_EQ(skel->bss->i, 3, "invocations");
> > +
> > +end:
> > +       raw_tp_null__destroy(skel);
> > +}
> > diff --git a/tools/testing/selftests/bpf/progs/raw_tp_null.c b/tools/te=
sting/selftests/bpf/progs/raw_tp_null.c
> > new file mode 100644
> > index 000000000000..c7c9ad4ec3b7
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/raw_tp_null.c
> > @@ -0,0 +1,27 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
> > +
> > +#include <vmlinux.h>
> > +#include <bpf/bpf_tracing.h>
> > +
> > +char _license[] SEC("license") =3D "GPL";
> > +
> > +int tid;
> > +int i;
> > +
> > +SEC("tp_btf/bpf_testmod_test_raw_tp_null")
> > +int BPF_PROG(test_raw_tp_null, struct sk_buff *skb)
> > +{
> > +       if (bpf_get_current_task_btf()->pid =3D=3D tid) {
>
> nit: avoid unnecessary nesting. Check condition and return early. Also
> seems nicer to have task_struct local variable for this, tbh:
>
> struct task_struct *t =3D bpf_get_current_task_btf();
>
> if (t->pid !=3D tid)
>     return 0;
>
> /* the rest follows, unnested */

Ack.

>
> > +               i =3D i + skb->mark + 1;
> > +
> > +               /* If dead code elimination kicks in, the increment bel=
ow will
> > +                * be removed. For raw_tp programs, we mark input argum=
ents as
> > +                * PTR_MAYBE_NULL, so branch prediction should never ki=
ck in.
> > +                */
> > +               if (!skb)
> > +                       i +=3D 2;
> > +       }
> > +
> > +       return 0;
> > +}
> > --
> > 2.43.5
> >

