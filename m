Return-Path: <bpf+bounces-18960-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2359B823919
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 00:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5945287626
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 23:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF2E1EB40;
	Wed,  3 Jan 2024 23:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1iazWeZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3501F5F6
	for <bpf@vger.kernel.org>; Wed,  3 Jan 2024 23:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-556ea884968so615623a12.3
        for <bpf@vger.kernel.org>; Wed, 03 Jan 2024 15:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704323875; x=1704928675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQ1c89q7+vNg3S3qlwIohAaIqzWGEz10ftpISynPnRQ=;
        b=F1iazWeZ3w1wD9SiGMtZ9VgrFlEvdfTmNsZQjWDsJ91/FjzKVEHt10ppMW0eLGyGGu
         T1ml7opi+Uw05eFXSeQpBPqOVrIGhakLI0IvoI7iTfamU4e6qtNOp0CNjPZpq8r55PD6
         TUxSzBqDNEpeLYtyynjEs2KcTDcqEFqxIsL4esTaEui4vaoG8taOVc4Iyp7PnkitN65c
         LPNHho5HMfdOxwGyotfddZDmX3iEc9zAUVHnpnm4qyBfVB3XAf3OtKiljIeCSI+tAMQP
         uEf5bje+FnoA7Q3RXjP6ykIdIz6BbfUApb9NKVYaJ4ZVtJIZsHnDwrU/kKyY7xtjaIVS
         liYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704323875; x=1704928675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OQ1c89q7+vNg3S3qlwIohAaIqzWGEz10ftpISynPnRQ=;
        b=T/9i/RYuclR8HocjQsK22zBA+RgdIbLunu6xcZvCLWSN1izH3dtT7HpPTq2akwmRoM
         R+dx59Cyq6DDI5SZdOvdRUKPIxt/mwkBGeOpQREgeEdU5em9Lmq3ZW86muDoFDtji7hV
         P8YijlcrMMBr+RxEHVrXMxvCdv5y+0VOPTqLwmu5yTGWLWS6IS+j4uG5va7wVNH3dk78
         CelnTAFbVdLhyh6DBqJ8DVPC1cfzxGylilqNgE6vmcRvP4GrdNFJIIaguNfvj2Bo3kmi
         TpUvoZscjHGw/y8iCTKRu9xzl4bpvNZaTMcKys1dSagnLv6THhA1uUBM1kJLwNUJJ9X9
         HlJw==
X-Gm-Message-State: AOJu0Yyx0cVzGjJ6X4jXwyRiBxRxL8AZ7jsZvXzZWvMa3pINt+0TPVmt
	vC5ji3t2jBDIcL6PdMz3jk9j9cHNx2vX1UUqsLw=
X-Google-Smtp-Source: AGHT+IHn7rYRhrFkIeMd6E9CO9uqk0uoPgv0/eE4huulDzXIjQuT9LAAJz1g8QR7KjA7cyqvYoWORITi27A5cj4L5RE=
X-Received: by 2002:a50:bb03:0:b0:540:4c04:ab94 with SMTP id
 y3-20020a50bb03000000b005404c04ab94mr10319867ede.42.1704323875226; Wed, 03
 Jan 2024 15:17:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102190055.1602698-1-andrii@kernel.org> <20240102190055.1602698-10-andrii@kernel.org>
 <2e7306da990a9b7af22d2af271dacb9723b067fc.camel@gmail.com>
In-Reply-To: <2e7306da990a9b7af22d2af271dacb9723b067fc.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 3 Jan 2024 15:17:43 -0800
Message-ID: <CAEf4Bzbj8Eeo=SNtRzk75ST8=BnPVJi9CNp4KKpPaT_fnhUymA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 9/9] selftests/bpf: add arg:ctx cases to
 test_global_funcs tests
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 12:57=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2024-01-02 at 11:00 -0800, Andrii Nakryiko wrote:
> > Add a few extra cases of global funcs with context arguments. This time
> > rely on "arg:ctx" decl_tag (__arg_ctx macro), but put it next to
> > "classic" cases where context argument has to be of an exact type that
> > BPF verifier expects (e.g., bpf_user_pt_regs_t for kprobe/uprobe).
> >
> > Colocating all these cases separately from other global func args that
> > rely on arg:xxx decl tags (in verifier_global_subprogs.c) allows for
> > simpler backwards compatibility testing on old kernels. All the cases i=
n
> > test_global_func_ctx_args.c are supposed to work on older kernels, whic=
h
> > was manually validated during development.
> >
> > Acked-by: Jiri Olsa <jolsa@kernel.org>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
>
> At first I thought that we would need to add a new CI job that would
> run these tests for some older kernel version.

libbpf CI will test this on 5.15 kernel, so we will have regression tests

>
> However, the transformation of the sub-program parameters happens
> unconditionally. So it should be possible to read BTF for some of the
> programs after they are loaded and check if transformation is applied
> as expected. Thus allowing to check __arg_ctx handling on libbpf side
> w/o the need to run on old kernel.

Yes, but it's bpf_prog_info to get func_info (actually two calls due
to how API is), parse func_info (pain without libbpf internal helpers
from libbpf_internal.h, and with it's more coupling) to find subprog's
func BTF ID and then check BTF.

It's so painful that I don't think it's worth it given we'll test this
in libbpf CI (and I did manual check locally as well).

Also, nothing actually prevents us from not doing this if the kernel
supports __arg_ctx natively, which is just a painful feature detector
to write, using low-level APIs, which is why I decided that it's
simpler to just do this unconditionally.

> I think it's worth it to add such test, wdyt?
>

I feel like slacking and not adding this :) This will definitely fail
in libbpf CI, if it's wrong.

