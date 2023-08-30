Return-Path: <bpf+bounces-9001-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC5978E0B1
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 22:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF0D31C2074A
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 20:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFDA7491;
	Wed, 30 Aug 2023 20:31:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B458BE1
	for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 20:31:07 +0000 (UTC)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA9149FC
	for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 13:30:37 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-500bdef7167so1610463e87.0
        for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 13:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693427370; x=1694032170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FXMV8eZCvXRSjEgYrVUCGbzmHiaMeF9g8zpMiDwgy0A=;
        b=APeAczMGXvb5UADNTRNpX+JLSk6SceXjauGYxkK5d3iy2JSq0sMcCPzYUKq6FFjpOS
         hBW/7uDSOEW/733k+7LPmF656mFhPxeWy+ptaBmUQbJnLnASpXYqW4NXPTL+JapkPHte
         X1HUlv7TZJl25PyTxnt6G50kQgm6wTPskL+fKTLmqj5Tew8F+LKJYRO7Zy0k9FPo0kW/
         b+ufpnWz7m2piJ25S7BFoyfakFj9z83tvKKw+ZQVXcgp8qc9NsAbR8XrJOSHiArgbkTA
         FSjOmxiQhKXRla+P+Z/FEkM+B770TUEVhkiIVXHF8agilhf+h05QAbhjAJPMBzuxsQAe
         Lxmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693427370; x=1694032170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FXMV8eZCvXRSjEgYrVUCGbzmHiaMeF9g8zpMiDwgy0A=;
        b=IqaqJwCaZkabnbYVoiWri4pY3AWCPoIzsrtBTShshqq3A+0cY20awn2CST5u9lofHR
         VaK0darWlnowaYXvpyU7kDLkXCuSXPn3v3SF5Afw5NvfRkJT2vhHI3vCg+TsjpT0fR4e
         DqDmAEnRmWxtLFaLtLqxQCAh2dvJfmY90OfQAgKUAlyd46mSO8s1q4rW1iFXtCIPbGNP
         0bLOEiFUG6J9TIJ5IvmNHCP51fCQVyhOPpXFH6FV+QfzvvasE6nPA6ecPM0ea+HrGRa/
         O0+gER7V0Dzawx+VtgNpyDNAlh1H54yOQV/dTDblJtHrX9y9zkPr/R4z6ZCv/7ooEkdn
         XJ2g==
X-Gm-Message-State: AOJu0Yw5/zl2qoyM/a3hZLi/mcsTzdlg7FRTOV9PaLMuDheOVF9w7JxR
	q4wTsT2qBHskgv8Mj0lE7xPdIcLAkh5SKbltXg4=
X-Google-Smtp-Source: AGHT+IEs/iYJ1M1vaA6TKz5FZ5E40FWY7mYmPT5loJW0nTyfEZ0QNgSvQtHI6OKN6PoqV5RbGNeVU5C00agL1DXmGHI=
X-Received: by 2002:a05:6512:3085:b0:500:9034:ce52 with SMTP id
 z5-20020a056512308500b005009034ce52mr227514lfd.17.1693427369926; Wed, 30 Aug
 2023 13:29:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230830093502.1436694-1-jolsa@kernel.org> <ZO9DvsaOImg4Dt5r@krava>
 <CAPhsuW56Bc_Ynd=uduJ1OwHLZD40GqzrD89W8-AjGKN=bmgzng@mail.gmail.com> <ZO+Sqomnp5BkH+m6@krava>
In-Reply-To: <ZO+Sqomnp5BkH+m6@krava>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 30 Aug 2023 13:29:18 -0700
Message-ID: <CAADnVQK2a76Ax7_7xQWEoKi5HSKbx3TrzrBoPWXi=AXD_U_ecw@mail.gmail.com>
Subject: Re: [RFC/PATCH bpf-next] bpf: Fix d_path test after last fs update
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Song Liu <song@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Hou Tao <houtao1@huawei.com>, 
	Viktor Malik <vmalik@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 30, 2023 at 12:04=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wro=
te:
>
> On Wed, Aug 30, 2023 at 02:35:49PM -0400, Song Liu wrote:
> > On Wed, Aug 30, 2023 at 9:27=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> =
wrote:
> > >
> > > On Wed, Aug 30, 2023 at 11:35:02AM +0200, Jiri Olsa wrote:
> > > > Recent commit [1] broken d_path test, because now filp_close is not
> > > > called directly from sys_close, but eventually later when the file
> > > > is finally released.
> > > >
> > > > I can't see any other solution than to hook filp_flush function and
> > > > that also means we need to add it to btf_allowlist_d_path list, so
> > > > it can use the d_path helper.
> > > >
> > > > But it's probably not very stable because filp_flush is static so i=
t
> > > > could be potentially inlined.
> > >
> > > looks like llvm makes it inlined (from CI)
> > >
> > >   Error: #68/1 d_path/basic
> > >   libbpf: prog 'prog_close': failed to find kernel BTF type ID of 'fi=
lp_flush': -3
> > >
> > > jirka
> >
> > I played with it for a bit, but haven't got a good solution. Maybe we s=
hould
> > just remove the test for close()?
>
> I was thinking the same.. also we have some example with filp_close in bp=
ftrace
> docs, I think we'll need to add some note with explanation in there

Maybe use __x64_sys_close in the test and recommend bpftrace scripts
to do the same?

