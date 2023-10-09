Return-Path: <bpf+bounces-11737-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3987BE6A2
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 18:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDB7D1C20B60
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 16:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C181CFBD;
	Mon,  9 Oct 2023 16:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="37ySzjw6"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC681A733
	for <bpf@vger.kernel.org>; Mon,  9 Oct 2023 16:37:39 +0000 (UTC)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C258A6
	for <bpf@vger.kernel.org>; Mon,  9 Oct 2023 09:37:37 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-50302e8fca8so8283e87.0
        for <bpf@vger.kernel.org>; Mon, 09 Oct 2023 09:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696869456; x=1697474256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UCcIV6Mm7zw1gNMMm0ZkrKGglzNc/5vCe0dsXvh6bqw=;
        b=37ySzjw6oM68AS1MPLubhdp5REUPwceWOVzpL1c0kqRWwWifzCwx+AvAPRKPADLUnn
         cNUJO1qbzeMpE4jekHT9NTcYCN/6JXsJl1birvpZveWlyEiQslZ5n2F6W8PmmFfxsoZh
         kWl8ndmpARsNOxKSRIx8UxnSbWqqalljAonuvqllttnTCuhKL5iY5/iTRfdP+9sT87fY
         w81jLGpRquC+1d1gqcj98EUF91x0en1JTPLWDbsCh0gefi5TnqNG+/keZKu+gFnfol1y
         M0I219jS3n7k5U1YT89I8wk+0tYOb022s/mTiOw+NBeWLLItllIvp/j/qVrp6hD5Sebk
         M3uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696869456; x=1697474256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UCcIV6Mm7zw1gNMMm0ZkrKGglzNc/5vCe0dsXvh6bqw=;
        b=d+FI+yiObHOZxn8AsD3eUkQNVFv39at7Sm5xZFAYhxdk1fuF2D66/GuTuFouUAdiU3
         /xgjJ98t6AyNBs68esPYrYeBet0teBucUzu4Su400ulmdLiG/T/YfdjHIhdkAjpR7Jlb
         wrt1Y8am+UfssdcsLPSHB31V759xS0qy//fECHxJzqDeSeQpTWN2dOvyPdmshHH6O3Rv
         TjRGFFD1lXT6MQdGUWAGnsWXpe+VlWLrQLBtx0BtWlNv9sIS/tOAtnm2xx4t+Zzhgv5E
         wAgNn9WVBestqm60lyu2cwexc4wQNsHJMzdHVtULq+1+BpaEW4WdQToVFquM1442ECmG
         XdNA==
X-Gm-Message-State: AOJu0YxJetucIOL7MjfRAGUm/Ceg/jo4W4lMM6DxvOi+6OMptzljUDfi
	ItNApGKhNW96OBk4LqwHU2sqnyTQ5k6qJ850XlY2Yw==
X-Google-Smtp-Source: AGHT+IFrz2vFJU/zI3Q1h36XuYf4dJwSe0vnT+pqWgCqVmuceBLNptLoibz7FuY74kPBGRakIVvBm12RbdQ4QIDmIJE=
X-Received: by 2002:ac2:44db:0:b0:505:7c88:9e45 with SMTP id
 d27-20020ac244db000000b005057c889e45mr231500lfm.0.1696869455500; Mon, 09 Oct
 2023 09:37:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231005230851.3666908-1-irogers@google.com> <20231005230851.3666908-14-irogers@google.com>
 <CAM9d7cj-ANu1j-6WxGDQ_+pJtDt1xfyuGCNyC_dTpCDECZZgCQ@mail.gmail.com>
In-Reply-To: <CAM9d7cj-ANu1j-6WxGDQ_+pJtDt1xfyuGCNyC_dTpCDECZZgCQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Oct 2023 09:37:24 -0700
Message-ID: <CAP-5=fVpkvtf=8niBTcLUcpEjypJAui0yT4ATtY763-mCSXamg@mail.gmail.com>
Subject: Re: [PATCH v2 13/18] perf svghelper: Avoid memory leak
To: Namhyung Kim <namhyung@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Tom Rix <trix@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ming Wang <wangming01@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Yanteng Si <siyanteng@loongson.cn>, 
	Yuan Can <yuancan@huawei.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	James Clark <james.clark@arm.com>, llvm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Oct 8, 2023 at 11:31=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Thu, Oct 5, 2023 at 4:09=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
> >
> > On success path the sib_core and sib_thr values weren't being
> > freed. Detected by clang-tidy.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/builtin-lock.c   | 1 +
> >  tools/perf/util/svghelper.c | 5 +++--
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> > index d4b22313e5fc..1b40b00c9563 100644
> > --- a/tools/perf/builtin-lock.c
> > +++ b/tools/perf/builtin-lock.c
> > @@ -2463,6 +2463,7 @@ static int parse_call_stack(const struct option *=
opt __maybe_unused, const char
> >                 entry =3D malloc(sizeof(*entry) + strlen(tok) + 1);
> >                 if (entry =3D=3D NULL) {
> >                         pr_err("Memory allocation failure\n");
> > +                       free(s);
> >                         return -1;
> >                 }
> >
>
> This is unrelated.  Please put it in a separate patch.

Sorry, will fix in v3.

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> > diff --git a/tools/perf/util/svghelper.c b/tools/perf/util/svghelper.c
> > index 0e4dc31c6c9c..1892e9b6aa7f 100644
> > --- a/tools/perf/util/svghelper.c
> > +++ b/tools/perf/util/svghelper.c
> > @@ -754,6 +754,7 @@ int svg_build_topology_map(struct perf_env *env)
> >         int i, nr_cpus;
> >         struct topology t;
> >         char *sib_core, *sib_thr;
> > +       int ret =3D -1;
> >
> >         nr_cpus =3D min(env->nr_cpus_online, MAX_NR_CPUS);
> >
> > @@ -799,11 +800,11 @@ int svg_build_topology_map(struct perf_env *env)
> >
> >         scan_core_topology(topology_map, &t, nr_cpus);
> >
> > -       return 0;
> > +       ret =3D 0;
> >
> >  exit:
> >         zfree(&t.sib_core);
> >         zfree(&t.sib_thr);
> >
> > -       return -1;
> > +       return ret;
> >  }
> > --
> > 2.42.0.609.gbb76f46606-goog
> >

