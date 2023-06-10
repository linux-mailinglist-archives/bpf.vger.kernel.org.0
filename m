Return-Path: <bpf+bounces-2307-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CD772A996
	for <lists+bpf@lfdr.de>; Sat, 10 Jun 2023 09:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 981EF281A3E
	for <lists+bpf@lfdr.de>; Sat, 10 Jun 2023 07:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829457492;
	Sat, 10 Jun 2023 06:59:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F126FBE
	for <bpf@vger.kernel.org>; Sat, 10 Jun 2023 06:59:54 +0000 (UTC)
Received: from mail-yw1-x1141.google.com (mail-yw1-x1141.google.com [IPv6:2607:f8b0:4864:20::1141])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C181F3A9B;
	Fri,  9 Jun 2023 23:59:51 -0700 (PDT)
Received: by mail-yw1-x1141.google.com with SMTP id 00721157ae682-5689335d2b6so22661787b3.3;
        Fri, 09 Jun 2023 23:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686380391; x=1688972391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jzpp4ZiyZwzNvE4a5WSKnVkb62OYezIbe2zPDss4xsc=;
        b=MaMcYow4Eh1yNcWLCeusxVUvedanIOrNQWcaSuZUPZVe05mZqwgsRPeTW1l4MmX3uC
         FjWWtQWWercm17318nYmlZPLgPshyJC2gQJCGsgjTw71Z6Xm1WfmyM9y2xjatfMkGVAi
         sXqoUNUbaocMxvCLm8vkktiOqXU8p48y9feTgXEUZ7J0/mapvaUxxYdxVFtlRnjhiuwD
         UgSiDzCgDxgGMsMuhWoSToX/SCwU/RIk82IOW7T7HIvq1Uh8UGar0lyDVmsMt7qdmUH1
         swCsoPMWa0hHpQCOTPxd49+mlznUl1VaVD0Yv5WYIHru+xP31RSWzmVv5O6PXFWsVb0u
         1EGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686380391; x=1688972391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jzpp4ZiyZwzNvE4a5WSKnVkb62OYezIbe2zPDss4xsc=;
        b=P25wN1WlgcCGvxv6OHPE+5lvTreXg+1JprejqJkNGIT1Qd+Bw2Z37kcdwj4qbwvprV
         SuBmOPpJ0QBs8eZ+ZN444ysc0AGfOoYAzvQBVbO7gEdRmiVTErEcypkoovQANkUB/a4W
         DMvweNQoLLbz0kpLfx70F+a4p7SZfO8Nwdo4y/32UjI214cTEydL28wYMUQIqU+yO0Tj
         A+1fG30mpNZVyG2jxJUPjn/UqkKzW2fyiMm0ze5wYiR4QXla+Twe1cDqLF9YwdbigIgP
         3SOM9Fj2B3+nKzTxpzG8Hg9SCUuyxFQj8z81Bd8+D4TutkgehgFnu2OblEE0Vi8lSkyt
         5AXw==
X-Gm-Message-State: AC+VfDzyoFZCw3dkdmxGHfHjS1HghMGR91n9FY5xYMyrZpwljOYmCXxi
	wN2j5wx5Rw88n8aPKYHtxRzR0XF708QordXJxSY=
X-Google-Smtp-Source: ACHHUZ4XSQXYMtQoA2ZjBUhaVjM/usCR2CjVqZ88J7reifFFr0/iOiqg1FwZb1L+JWrQal6YQDwZxT5Nyeh2gzlIj/I=
X-Received: by 2002:a81:4896:0:b0:565:efe8:70fc with SMTP id
 v144-20020a814896000000b00565efe870fcmr3574240ywa.35.1686380390950; Fri, 09
 Jun 2023 23:59:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230609095653.1406173-1-imagedong@tencent.com> <68003017-5111-176a-de34-5d576b6e3488@meta.com>
In-Reply-To: <68003017-5111-176a-de34-5d576b6e3488@meta.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Sat, 10 Jun 2023 14:59:39 +0800
Message-ID: <CADxym3bm6tva6e6ahD-pGT=JF=0Ng6051fDcKs0-TZuu4CK-cA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 0/3] bpf, x86: allow function arguments up to
 12 for TRACING
To: Yonghong Song <yhs@meta.com>
Cc: andrii.nakryiko@gmail.com, alan.maguire@oracle.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jun 10, 2023 at 11:51=E2=80=AFAM Yonghong Song <yhs@meta.com> wrote=
:
>
>
>
> On 6/9/23 2:56 AM, menglong8.dong@gmail.com wrote:
> > From: Menglong Dong <imagedong@tencent.com>
> >
> > For now, the BPF program of type BPF_PROG_TYPE_TRACING can only be used
> > on the kernel functions whose arguments count less than 6. This is not
> > friendly at all, as too many functions have arguments count more than 6=
.
> > According to the current kernel version, below is a statistics of the
> > function arguments count:
> >
> > argument count | function count
> > 7              | 704
> > 8              | 270
> > 9              | 84
> > 10             | 47
> > 11             | 47
> > 12             | 27
> > 13             | 22
> > 14             | 5
> > 15             | 0
> > 16             | 1
> >
> > Therefore, let's enhance it by increasing the function arguments count
> > allowed in arch_prepare_bpf_trampoline(), for now, only x86_64.
> >
> > In the 1st patch, we make arch_prepare_bpf_trampoline() support to copy
> > function arguments in stack for x86 arch. Therefore, the maximum
> > arguments can be up to MAX_BPF_FUNC_ARGS for FENTRY and FEXIT.
> >
> > In the 2nd patch, we clean garbage value in upper bytes of the trampoli=
ne
> > when we store the arguments from regs or on-stack into stack.
> >
> > And the 3rd patches are for the testcases of the 1st patch.
> >
> > Changes since v3:
> > - try make the stack pointer 16-byte aligned. Not sure if I'm right :)
> > - introduce clean_garbage() to clean the grabage when argument count is=
 7
> > - use different data type in bpf_testmod_fentry_test{7,12}
> > - add testcase for grabage values in ctx
> >
> > Changes since v2:
> > - keep MAX_BPF_FUNC_ARGS still
> > - clean garbage value in upper bytes in the 2nd patch
> > - move bpf_fentry_test{7,12} to bpf_testmod.c and rename them to
> >    bpf_testmod_fentry_test{7,12} meanwhile in the 3rd patch
> >
> > Changes since v1:
> > - change the maximun function arguments to 14 from 12
> > - add testcases (Jiri Olsa)
> > - instead EMIT4 with EMIT3_off32 for "lea" to prevent overflow
> >
> > Menglong Dong (3):
> >    bpf, x86: allow function arguments up to 12 for TRACING
> >    bpf, x86: clean garbage value in the stack of trampoline
> >    selftests/bpf: add testcase for FENTRY/FEXIT with 6+ arguments
> >
> >   arch/x86/net/bpf_jit_comp.c                   | 145 ++++++++++++++++-=
-
> >   .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  19 ++-
> >   .../selftests/bpf/prog_tests/fentry_fexit.c   |   4 +-
> >   .../selftests/bpf/prog_tests/fentry_test.c    |   2 +
> >   .../selftests/bpf/prog_tests/fexit_test.c     |   2 +
> >   .../testing/selftests/bpf/progs/fentry_test.c |  33 ++++
> >   .../testing/selftests/bpf/progs/fexit_test.c  |  57 +++++++
> >   7 files changed, 245 insertions(+), 17 deletions(-)
>
> Also replace rebase on top of bpf-next. Patch 3 cannot be applied.

Okay!

