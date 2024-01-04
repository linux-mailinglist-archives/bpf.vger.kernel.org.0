Return-Path: <bpf+bounces-19010-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E56823BD0
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 06:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 166091C24C78
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 05:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45EDF18640;
	Thu,  4 Jan 2024 05:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGUe1DgF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6F91862D
	for <bpf@vger.kernel.org>; Thu,  4 Jan 2024 05:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33723ad790cso121858f8f.1
        for <bpf@vger.kernel.org>; Wed, 03 Jan 2024 21:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704346780; x=1704951580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/E9RVyHBQxuSD+t/xFiwEMLinUzKnQy5Uq2prnwx324=;
        b=HGUe1DgFh9gxmNhcXrIZUwsoceUqwzMsnoe8pY81ZEipQabaaqPXsD4dauwa/lnIFW
         jDGM92jtRb4WJ3UwB1xysmfLIoVuly2Uu7NXD16g+rin9FozlG8q0U3tUKUfGVZum5yd
         yFqMDKY3TkIdZioK2kPy7q03gHo2ZEUXBQByCeB/sT208qh3fw65QfcKD5+AhG9UOBwP
         1i4vlqVowvMMQMLsO/PIHmCCZ4jXZU9F/bEd+1706ZNVaA9QIvz/r2a4+u4QpHtIIHCs
         PqQToShQtzLHEyroL31EuA2w+shhaZTQK6ar2Tnpqe78xxE8xW/tL/M2At/97cbIUoUY
         7vXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704346780; x=1704951580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/E9RVyHBQxuSD+t/xFiwEMLinUzKnQy5Uq2prnwx324=;
        b=nKiOOdmRU6Xnkw/8Cp4aFW63tp0EWLygCTVMfOZw79o1pT9JfQBtmEeTxeamSs75yN
         wrdnawSH4IK4bTSpSo1fkqUg6b3l4O6uy5vmE0icyUupG0ft9lJZXfhHoj/rrg2leSQf
         auST5IUZVji3BNqLyr3zqfJMKghnM0wvdtEPpdZ53GgfBeK94X9Iwe4mgQCc/2DE3Zyz
         kVxVBHKJYHuELOV+TuKDRaYXNNpA1AI6KwrtPBfoEQOmB253y21nk8D4xVm7sIw35LO1
         c5UwZZ2+/M3cgPYLUYMjliqhUvOS9biyYD3mQ+eNHoJk2QLDLUs4ef4UpXW6hXhyJ1l0
         0hkg==
X-Gm-Message-State: AOJu0Yxb5TZOTFVXlwBPDgOqwnsFo7BIoTE4x8xCyC5uoYqSxucLIYMs
	gBGKC4Q04DKb7X/SAmFwXdZWHSwcNF/ptJujqYc=
X-Google-Smtp-Source: AGHT+IF6hYE+DX2T4Mxpf9mYK3mtTQAjXYUnfcA2ppSfg2vRGH7IH/7ltytUXGQZ4zexH1qGD6cBKl50/kp6socTzpU=
X-Received: by 2002:a05:6000:1b8a:b0:336:82a4:f7bc with SMTP id
 r10-20020a0560001b8a00b0033682a4f7bcmr37369wru.37.1704346780354; Wed, 03 Jan
 2024 21:39:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104013847.3875810-1-andrii@kernel.org> <20240104013847.3875810-8-andrii@kernel.org>
In-Reply-To: <20240104013847.3875810-8-andrii@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 3 Jan 2024 21:39:29 -0800
Message-ID: <CAADnVQJn0+fvvbOVnfPFQm=1j+=oFsjy65T2-QY8Ps0pL4nh_A@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 7/9] libbpf: implement __arg_ctx fallback logic
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@meta.com>, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 5:39=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org> =
wrote:
>
> This limitation was the reason to add btf_decl_tag("arg:ctx"), making
> the actual argument type not important, so that user can just define
> "generic" signature:
>
>   __noinline int global_subprog(void *ctx __arg_ctx) { ... }

I still think that this __arg_ctx only makes sense with 'void *'.
Blind rewrite of ctx is a foot gun.

I've tried the following:

diff --git a/tools/testing/selftests/bpf/progs/test_global_func_ctx_args.c
b/tools/testing/selftests/bpf/progs/test_global_func_ctx_args.c
index 9a06e5eb1fbe..0e5f5205d4a8 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func_ctx_args.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func_ctx_args.c
@@ -106,9 +106,9 @@ int perf_event_ctx(void *ctx)
 /* this global subprog can be now called from many types of entry progs, e=
ach
  * with different context type
  */
-__weak int subprog_ctx_tag(void *ctx __arg_ctx)
+__weak int subprog_ctx_tag(long ctx __arg_ctx)
 {
-       return bpf_get_stack(ctx, stack, sizeof(stack), 0);
+       return bpf_get_stack((void *)ctx, stack, sizeof(stack), 0);
 }

 struct my_struct { int x; };
@@ -131,7 +131,7 @@ int arg_tag_ctx_raw_tp(void *ctx)
 {
        struct my_struct x =3D { .x =3D 123 };

-       return subprog_ctx_tag(ctx) + subprog_multi_ctx_tags(ctx, &x, ctx);
+       return subprog_ctx_tag((long)ctx) +
subprog_multi_ctx_tags(ctx, &x, ctx);
 }

and it "works".

Both kernel and libbpf should really limit it to 'void *'.

In the other email I suggested to allow types that match expected
based on prog type, but even that is probably a danger zone as well.
The correct type would already be detected by the verifier,
so extra __arg_ctx is pointless.
It makes sense only for such polymorphic functions and those
better use 'void *' and don't dereference it.

I think this can be a follow up.

