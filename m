Return-Path: <bpf+bounces-708-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA172705F24
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 07:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 696751C20E27
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 05:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292075239;
	Wed, 17 May 2023 05:17:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D394E210D
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 05:17:29 +0000 (UTC)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4A43A8D
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 22:17:28 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f13d8f74abso458713e87.0
        for <bpf@vger.kernel.org>; Tue, 16 May 2023 22:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684300646; x=1686892646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TrzB+D4xg4dp/8BfsAXbzMtLKJRWVVymSyDc82qwbQo=;
        b=ZZbivqjZcA0XRrLFXOdiaMmMtqRqByqK2clA1fkPkJcFCY0nZ2hUJAtaFzzUU3K/wu
         gqsmpIyjNBob11bBrN4kv9aR5Xrw2R8qorgyZ/FmFw/qur3/2bijMyKytpxh8oF5bHUE
         icMozr2LUhxtciAjhIesoWJ1UDVBDfRWk8NlezPu6RcBcQVsbdNzF6F8wToO37WmlMMc
         T/QQ63EJM8YC4cU5Nv3GkKF/MBoR1tKwMwf54NVp5G9Tl0tZlSAc8MIQU4erK459Inyk
         mANOaohvEh2iay46TzxqHMgvl5O3J1jvVCPLRI4jLp7I9CYLyrBnNIlBiTYVkrJ1a3ce
         Ba3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684300646; x=1686892646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TrzB+D4xg4dp/8BfsAXbzMtLKJRWVVymSyDc82qwbQo=;
        b=Bec5/AuMabH+cVO5Jh3CdSFcDnK02VjrYIoNr9AVjGoIhc4fiw1FXKtr5LphMqWXB7
         P9gtr5kcWTwBFTgyTlzvz3cZ7Zo14FH1pROaZXMclOgd2FqIMm4ob4xKdGGXAXcJ0+Cd
         drv4+EoByYyBxPEeu/IbyV7tOM1O8P7I8IdjmEN2LGlnWJMD441itlvCIoMHwAaAQMIc
         c2IHInT5XW8WEdzlV9qsQ/+G6PhQ/pffNiDn5CxXk7sFzaVKY0aila10M3+AXWBvNbXe
         wknaMdjU3TeuYIey8ZIMtwkAzth5cMkxHBeVSFTTwhHfQ881w5U8tOJr93c1SjhitORm
         JbVA==
X-Gm-Message-State: AC+VfDwqyJrhO3QPtgKqQGxDYZvtBjTu0pVma/cIC5rqNvF1xYUycHVI
	i5B/+nDAQ2Sm6/G5oF0afx5v/n+RViyImzqYWV0=
X-Google-Smtp-Source: ACHHUZ5PNuU4r561z0JLBygT12hrYz1C2VEj3x7oEt/J1HPjTOyl5iZFZMEmwC21/Gk3SxrIT5580HHsxAfQEOcDLA0=
X-Received: by 2002:a19:f003:0:b0:4f3:8c0d:41c2 with SMTP id
 p3-20020a19f003000000b004f38c0d41c2mr1238485lfc.54.1684300645970; Tue, 16 May
 2023 22:17:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230515133756.1658301-1-jolsa@kernel.org> <20230515133756.1658301-9-jolsa@kernel.org>
 <CAEf4BzaLAZX_xVyRkavFiz+yLR057TuERcmsOc_amtjQCbHVoA@mail.gmail.com>
In-Reply-To: <CAEf4BzaLAZX_xVyRkavFiz+yLR057TuERcmsOc_amtjQCbHVoA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 16 May 2023 22:17:14 -0700
Message-ID: <CAADnVQLkfW5iB8VpL=Ua6UWJjk1gOAztRForFzOqQYewXmUmYQ@mail.gmail.com>
Subject: Re: [PATCHv4 bpf-next 08/10] selftests/bpf: Allow to use kfunc from
 testmod.ko in test_verifier
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, David Vernet <void@manifault.com>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, May 16, 2023 at 2:45=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, May 15, 2023 at 6:39=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrot=
e:
> >
> > Currently the test_verifier allows test to specify kfunc symbol
> > and search for it in the kernel BTF.
> >
> > Adding the possibility to search for kfunc also in bpf_testmod
> > module when it's not found in kernel BTF.
> >
> > To find bpf_testmod btf we need to get back SYS_ADMIN cap.
> >
> > Acked-by: David Vernet <void@manifault.com>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/testing/selftests/bpf/test_verifier.c | 161 +++++++++++++++++---
> >  1 file changed, 139 insertions(+), 22 deletions(-)
> >
>
> Eduard is working on migrating most (if not all) test_verifier tests
> into test_progs where we can use libbpf declarative functionality for
> things like this.
>
> Eduard, can you please review this part? Would it make sense to just
> wait for the migration?

No. Migration might never complete.
It's already at the point of diminishing returns.
This patch set is a great clean up on its own.
Hence I've decided to apply it.
If in the future this particular patch for test_verifier won't be
necessary we can easily revert it.

