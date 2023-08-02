Return-Path: <bpf+bounces-6729-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E2076D392
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 18:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D89E21C20318
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 16:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEB7D520;
	Wed,  2 Aug 2023 16:24:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E91ED30B
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 16:24:02 +0000 (UTC)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E411FFA
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 09:24:01 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b9e6cc93c6so59715031fa.2
        for <bpf@vger.kernel.org>; Wed, 02 Aug 2023 09:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690993439; x=1691598239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MlwoJ1ECb2Ug0CVq6a1omjS1pl7fvXZD5/whMoG1CEQ=;
        b=ZIsux3IDRSQ+k61YGHe+rD1RDLPQJp4cUgf6l5Hay+f3Y/0N3hjU1af/EzbuPxAdIL
         digRRpRcbfG+8ZBkAeW0sxtydmOIstaTvTt+7cTHTWic36ZqKYuDvbrrNC16E7hoJT7V
         wzMnloqrCUZ/fQr2GUK5oxhphYPa2argWuUhlgJgMphJDWVRMoO8WE+rrGwkp4haBGst
         mWEJrWfB6YAVRBSA3efKEbEJl8BttQ1S3/fTFLIq1UkVCBVszTLYI1SlhoqmoLSRQAn1
         48phv1S6KrWAaDBN4kaq6LlNkgTA6h6yxJTbUYGw8URBMku+LQxxOgpHcTf1X5YEvFih
         0AeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690993439; x=1691598239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MlwoJ1ECb2Ug0CVq6a1omjS1pl7fvXZD5/whMoG1CEQ=;
        b=kDf302SI5H52AecrfCKCkgEQRlvPH8XxpzOQYPYTiscnKBdxzZcgxJtNOhMdY+EJtq
         Ln7ZxIYTvEZijW8k3L42vvo0UOw8nM0k5ZeSYACb8LjyeA53R4gpRVmTCOUM3Y39qSvz
         kToUIWaNhoo1KIsyyEA6Tenu6sFD5h8IVqAFprHKhxgHmPj6AmxuBWDWZTizGpGqkw+h
         c8V2Nmj3i8xZjRWG11ltuM0Z5EXD2+0bRSpvBRL41WC4UJlSZUXCXo35Jb4SiZEOFqhx
         a9yxbpqchdod8qyi1q3SKt5HQfM95Qv6O51cBqYQIThKqvzHweIY/8SqrF98tDfCeiEw
         xcRA==
X-Gm-Message-State: ABy/qLblHDRj5laQ0Ptvudkv+cVYg3KXcSq3H6vQwwmUMznv2e+pJzPW
	SSCpArpWrVXh422RfPcpqw2hsX8WWd8SzqxrbS4=
X-Google-Smtp-Source: APBJJlGvj3rFHD5jGUQcif+zxnwrlgqkuYnOdIf58yQQbABP3MRVxKmdI2UP0onX1TRDiBCZo4twIjm3naBMYSg6URc=
X-Received: by 2002:a2e:8551:0:b0:2b6:a08d:e142 with SMTP id
 u17-20020a2e8551000000b002b6a08de142mr4947953ljj.7.1690993439115; Wed, 02 Aug
 2023 09:23:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230801142912.55078-1-laoar.shao@gmail.com> <3f56b3b3-9b71-f0d3-ace1-406a8eeb64c0@linux.dev>
 <CALOAHbAnyorNdYAp1FretQcqEp_j6mQ93ATwx02auLTYnL_0KQ@mail.gmail.com>
 <CAADnVQKwY+j6JrxJ4dc1M7yhkSf958ubSH=WB7dKmHt9Ac9gQQ@mail.gmail.com>
 <20230802032958.GB472124@maniforge> <8b6b0703-4ed6-c0cb-c61a-9ebcfb5fe668@linux.dev>
 <20230802154634.GD472124@maniforge>
In-Reply-To: <20230802154634.GD472124@maniforge>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 2 Aug 2023 09:23:47 -0700
Message-ID: <CAADnVQK3KWLNKh23upOwuNLoF9mMK0AemejxJ6jvWv8UP4MCBA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/3] bpf: Add new bpf helper bpf_for_each_cpu
To: David Vernet <void@manifault.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, Yafang Shao <laoar.shao@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 2, 2023 at 8:46=E2=80=AFAM David Vernet <void@manifault.com> wr=
ote:
>
> On Tue, Aug 01, 2023 at 11:54:18PM -0700, Yonghong Song wrote:
> >
> >
> > On 8/1/23 8:29 PM, David Vernet wrote:
> > > On Tue, Aug 01, 2023 at 07:45:57PM -0700, Alexei Starovoitov wrote:
> > > > On Tue, Aug 1, 2023 at 7:34=E2=80=AFPM Yafang Shao <laoar.shao@gmai=
l.com> wrote:
> > > > >
> > > > > >
> > > > > > In kernel, we have a global variable
> > > > > >      nr_cpu_ids (also in kernel/bpf/helpers.c)
> > > > > > which is used in numerous places for per cpu data struct access=
.
> > > > > >
> > > > > > I am wondering whether we could have bpf code like
> > > > > >      int nr_cpu_ids __ksym;
> > >
> > > I think this would be useful in general, though any __ksym variable l=
ike
> > > this would have to be const and mapped in .rodata, right? But yeah,
> > > being able to R/O map global variables like this which have static
> > > lifetimes would be nice.
> >
> > No. There is no map here. __ksym symbol will have a ld_imm64 insn
> > to load the value in the bpf code. The address will be the kernel
> > address patched by libbpf.
>
> ld_imm64 is fine. I'm talking about stores. BPF progs should not be able
> to mutate these variables.

ksyms are readonly and support for them is already in the kernel and libbpf=
.
The only reason:
extern int nr_cpu_ids __ksym;
doesn't work today because nr_cpu_ids is not in vmlinux BTF.
pahole adds only per-cpu vars to BTF.

