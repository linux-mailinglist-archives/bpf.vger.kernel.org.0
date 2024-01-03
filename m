Return-Path: <bpf+bounces-18877-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C59E28233A1
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 18:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72F88286D14
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 17:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609361C684;
	Wed,  3 Jan 2024 17:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ilbW+Awq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3271C2A9;
	Wed,  3 Jan 2024 17:40:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF93C4339A;
	Wed,  3 Jan 2024 17:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704303640;
	bh=kif2bw2FG7EZZYJYjHsYnB9iHshx00TE2vdHkS1MAQc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ilbW+AwqPODlsLi6kVkZGWBFz009dwCrrxcslPjVrBoRceZIJsooVkOlLImYht5P5
	 rqWKdYGGPXfwrRpbS1caw8QdZCW57ZUFXWlLUqR8i+hIcq18J7wG3Ukz/6jnz1J8As
	 IkGbSsmGVaYCRgYvUObucDbZ71j7kDDW+veLmKuNwpQ9Dp+lejSTuRdGefwXY/hry3
	 UiThckl4BtqxBEe1vS6/6IKQE/l7B7Hz4M9iwx8QB1gk0cLHtwYSJxgE7BTABizevP
	 j6lkaF+eY33jod2g4DXZM1k+/4S/005F+zNHI3y6E7vmalL58VJbRMmuvUOLprzc28
	 p/CKsSYaJ29Gw==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50e7d6565b5so7848001e87.0;
        Wed, 03 Jan 2024 09:40:40 -0800 (PST)
X-Gm-Message-State: AOJu0YymhJz58QV2p9ZN3uTGLiaMVJGVliR+y0aADoC0s5aDJkxrHnAu
	JCGlw0UcSyPMJDZuz+kH8nEP21L/DTFWpASSEF4=
X-Google-Smtp-Source: AGHT+IHdcNf0HfRTjmT03rv2Safr/oCgAw2zpuyFkm9Oqtmhg7Heu5bStB0iVwFNN5dxsxUCNitrH6m18fCdNYCQNbg=
X-Received: by 2002:ac2:5b9b:0:b0:50e:71d4:c76d with SMTP id
 o27-20020ac25b9b000000b0050e71d4c76dmr6922016lfn.109.1704303638367; Wed, 03
 Jan 2024 09:40:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207014655.1252484-1-irogers@google.com> <CAP-5=fWdAouBb7us44HOdd+ZfBj5fLFTuLCokbG8w3jVuQgTxw@mail.gmail.com>
 <ZZWK43OPvGcd-BAR@kernel.org>
In-Reply-To: <ZZWK43OPvGcd-BAR@kernel.org>
From: Song Liu <song@kernel.org>
Date: Wed, 3 Jan 2024 09:40:26 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6EZ-FoZFbCuxs7gAa0OaQGw0zMLDaeEsNoU31vjXijnQ@mail.gmail.com>
Message-ID: <CAPhsuW6EZ-FoZFbCuxs7gAa0OaQGw0zMLDaeEsNoU31vjXijnQ@mail.gmail.com>
Subject: Re: [PATCH v1] perf env: Avoid recursively taking env->bpf_progs.lock
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Ming Wang <wangming01@loongson.cn>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 8:27=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> Em Tue, Jan 02, 2024 at 07:00:53PM -0800, Ian Rogers escreveu:
> > On Wed, Dec 6, 2023 at 5:46=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> > >
> > > Add variants of perf_env__insert_bpf_prog_info, perf_env__insert_btf
> > > and perf_env__find_btf prefixed with __ to indicate the
> > > env->bpf_progs.lock is assumed held. Call these variants when the loc=
k
> > > is held to avoid recursively taking it and potentially having a threa=
d
> > > deadlock with itself.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> >
> > Ping.
>
> Applied, with that minor patch reduction hunk and this:
>
> Fixes: f8dfeae009effc0b ("perf bpf: Show more BPF program info in print_b=
pf_prog_info()")
>
> Song, can I have your Acked-by?

LGTM. Thanks for the fix!

Acked-by: Song Liu <song@kernel.org>

