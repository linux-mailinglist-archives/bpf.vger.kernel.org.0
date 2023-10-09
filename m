Return-Path: <bpf+bounces-11730-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD717BE60D
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 18:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA32B1C20B50
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 16:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507D338BAF;
	Mon,  9 Oct 2023 16:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pbxm7K99"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E0635894
	for <bpf@vger.kernel.org>; Mon,  9 Oct 2023 16:13:23 +0000 (UTC)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E96FAC
	for <bpf@vger.kernel.org>; Mon,  9 Oct 2023 09:13:21 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-5068b69f4aeso8046e87.0
        for <bpf@vger.kernel.org>; Mon, 09 Oct 2023 09:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696867999; x=1697472799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g0jKnvS+p6tLusyf0KR6YxKQNRwudB/CjvpEJfWJaDA=;
        b=pbxm7K99vjQnmloMqRtmCZxbCBwwnBu8t0PN38YqT5RK4gnb2/HIfcL7SebCTKJA5m
         Xlz0kasxBJKKxtp8ko/mH4+S0zmSoaVgjGHMAIETL+fIUMNXGs0LwlNOOMe0fpSQUiMD
         1iiPrJxckZFiE0TEC0jVxfLodDnLU7HyJ0QQQYu9pJ3oBc2ypYQ81tKeWgm0E9oo9o/f
         c5tmGKoGIYWkjlzROnlSD4U7e+J4p2BQnFIL8aLHu8Uc40m/7KI8UxSA8XD3wSDua8hT
         gNfAHLUec0IXfYxK0MAEea5iyLsvk76mo3wAc+GJEEaf4qh/FTupUDcVQP7jB0UdF7GB
         P3zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696867999; x=1697472799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g0jKnvS+p6tLusyf0KR6YxKQNRwudB/CjvpEJfWJaDA=;
        b=w4eBqlx0UTwmk1BBt+oyi0q8NK2dxodZHICXXuetp/twwyuimCelzmHNUOo258q2bL
         /pgaSMW1jliSPHH4WQrqhrTQrYtGl6ccLjrcC7rJEcAUUzah9iPDLqVjDtdC+IuJHPOF
         Kp/gk8DqsC02gEjLfqQv66ZumlPBzu12wTo3whPNwijNshpAJT/oT4Ib8sTmw5DerwZK
         y+GwoN1skmKNnx7ZlQ2FyVN71cEjm9hsCgDuiOrgsMGBFgh+UeMms/rspIsM0Nw2CEOD
         yHvrmh1ERqQkct8+GnF1xHYYy9w/2wQZQ7/Tktzy2snl+KotI4eg7KlMqsAST3ZpQyVt
         /0vQ==
X-Gm-Message-State: AOJu0YxNCPad9ip3zgH026L4WICrzzXzmFr/37ruYsiCvkVqQ5M86s4Z
	wcxgEJGNboTyd2a1vt/RmvN40pe4xeJ0eROT59fxMg==
X-Google-Smtp-Source: AGHT+IF1HdpHvO8s/EVxVQ0me6ekTtk7UbIlgadFNqVNz5wYB+4oNqfX/opeS9wuIKe7sPJkg7G/ilLuNk6Uh/uD+jE=
X-Received: by 2002:a19:7006:0:b0:502:dc15:7fb with SMTP id
 h6-20020a197006000000b00502dc1507fbmr284723lfc.5.1696867999100; Mon, 09 Oct
 2023 09:13:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231005230851.3666908-1-irogers@google.com> <20231005230851.3666908-6-irogers@google.com>
 <CAM9d7chmVRrFgEZMYk3EWG+1wjXqLC3suu-xrX64hmfBSAFi0A@mail.gmail.com>
In-Reply-To: <CAM9d7chmVRrFgEZMYk3EWG+1wjXqLC3suu-xrX64hmfBSAFi0A@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Oct 2023 09:13:05 -0700
Message-ID: <CAP-5=fXbU_hckJp=evE5ja7BA4sS30E6hHryXXAEvwXs=1qkBA@mail.gmail.com>
Subject: Re: [PATCH v2 05/18] perf bench uprobe: Fix potential use of memory
 after free
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
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Oct 8, 2023 at 10:51=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Thu, Oct 5, 2023 at 4:09=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
> >
> > Found by clang-tidy:
> > ```
> > bench/uprobe.c:98:3: warning: Use of memory after it is freed [clang-an=
alyzer-unix.Malloc]
> >                 bench_uprobe_bpf__destroy(skel);
> > ```
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> I'm ok with the change but I think it won't call
> bench_uprobe__teardown_bpf_skel() if the setup function
> returns a negative value.  Maybe we also need to set the
> err in the default case of `switch (bench)` statement.

Yes, the analysis (I'll put it below) assumes that the err can be
positive yielding destroy being called twice, the second creating a
use-after-free. I think it is worth cleaning the code up and making
the analyzer's job easier.

Thanks,
Ian

```
bench/uprobe.c:98:3: warning: Use of memory after it is freed
[clang-analyzer-unix.Malloc]
               bench_uprobe_bpf__destroy(skel);
               ^
tools/perf/bench/uprobe.c:197:9: note: Calling 'bench_uprobe'
       return bench_uprobe(argc, argv, BENCH_UPROBE__TRACE_PRINTK);
              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/perf/bench/uprobe.c:150:6: note: 'bench' is not equal to
BENCH_UPROBE__BASELINE
       if (bench !=3D BENCH_UPROBE__BASELINE &&
bench_uprobe__setup_bpf_skel(bench) < 0)
           ^~~~~
tools/perf/bench/uprobe.c:150:6: note: Left side of '&&' is true
tools/perf/bench/uprobe.c:150:41: note: Calling 'bench_uprobe__setup_bpf_sk=
el'
       if (bench !=3D BENCH_UPROBE__BASELINE &&
bench_uprobe__setup_bpf_skel(bench) < 0)

^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/perf/bench/uprobe.c:68:7: note: 'skel' is non-null
       if (!skel) {
            ^~~~
tools/perf/bench/uprobe.c:68:2: note: Taking false branch
       if (!skel) {
       ^
tools/perf/bench/uprobe.c:74:6: note: Assuming 'err' is not equal to 0
       if (err) {
           ^~~
tools/perf/bench/uprobe.c:74:2: note: Taking true branch
       if (err) {
       ^
tools/perf/bench/uprobe.c:76:3: note: Control jumps to line 91
               goto cleanup;
               ^
tools/perf/bench/uprobe.c:91:2: note: Calling 'bench_uprobe_bpf__destroy'
       bench_uprobe_bpf__destroy(skel);
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/perf/util/bpf_skel/bench_uprobe.skel.h:44:6: note: Assuming
'obj' is non-null
       if (!obj)
           ^~~~
tools/perf/util/bpf_skel/bench_uprobe.skel.h:44:2: note: Taking false branc=
h
       if (!obj)
       ^
tools/perf/util/bpf_skel/bench_uprobe.skel.h:46:6: note: Assuming
field 'skeleton' is null
       if (obj->skeleton)
           ^~~~~~~~~~~~~
tools/perf/util/bpf_skel/bench_uprobe.skel.h:46:2: note: Taking false branc=
h
       if (obj->skeleton)
       ^
tools/perf/util/bpf_skel/bench_uprobe.skel.h:48:2: note: Memory is released
       free(obj);
       ^~~~~~~~~
tools/perf/bench/uprobe.c:91:2: note: Returning; memory was released
via 1st parameter
       bench_uprobe_bpf__destroy(skel);
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/perf/bench/uprobe.c:150:41: note: Returning; memory was released
       if (bench !=3D BENCH_UPROBE__BASELINE &&
bench_uprobe__setup_bpf_skel(bench) < 0)

^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/perf/bench/uprobe.c:150:41: note: Assuming the condition is false
       if (bench !=3D BENCH_UPROBE__BASELINE &&
bench_uprobe__setup_bpf_skel(bench) < 0)

^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/perf/bench/uprobe.c:150:2: note: Taking false branch
       if (bench !=3D BENCH_UPROBE__BASELINE &&
bench_uprobe__setup_bpf_skel(bench) < 0)
       ^
tools/perf/bench/uprobe.c:155:14: note: Assuming 'i' is >=3D 'loops'
       for (i =3D 0; i < loops; i++) {
                   ^~~~~~~~~
tools/perf/bench/uprobe.c:155:2: note: Loop condition is false.
Execution continues on line 159
       for (i =3D 0; i < loops; i++) {
       ^
tools/perf/bench/uprobe.c:164:2: note: Control jumps to 'case 1:'  at line =
169
       switch (bench_format) {
       ^
tools/perf/bench/uprobe.c:171:3: note:  Execution continues on line 179
               break;
               ^
tools/perf/bench/uprobe.c:179:6: note: 'bench' is not equal to
BENCH_UPROBE__BASELINE
       if (bench !=3D BENCH_UPROBE__BASELINE)
           ^~~~~
tools/perf/bench/uprobe.c:179:2: note: Taking true branch
       if (bench !=3D BENCH_UPROBE__BASELINE)
       ^
tools/perf/bench/uprobe.c:180:3: note: Calling 'bench_uprobe__teardown_bpf_=
skel'
               bench_uprobe__teardown_bpf_skel();
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/perf/bench/uprobe.c:97:6: note: 'skel' is non-null
       if (skel) {
           ^~~~
tools/perf/bench/uprobe.c:97:2: note: Taking true branch
       if (skel) {
       ^
tools/perf/bench/uprobe.c:98:3: note: Use of memory after it is freed
               bench_uprobe_bpf__destroy(skel);
               ^                         ~~~~
1 warning generated.
```

> Thanks,
> Namhyung
>
>
> > ---
> >  tools/perf/bench/uprobe.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/tools/perf/bench/uprobe.c b/tools/perf/bench/uprobe.c
> > index 914c0817fe8a..5c71fdc419dd 100644
> > --- a/tools/perf/bench/uprobe.c
> > +++ b/tools/perf/bench/uprobe.c
> > @@ -89,6 +89,7 @@ static int bench_uprobe__setup_bpf_skel(enum bench_up=
robe bench)
> >         return err;
> >  cleanup:
> >         bench_uprobe_bpf__destroy(skel);
> > +       skel =3D NULL;
> >         return err;
> >  }
> >
> > --
> > 2.42.0.609.gbb76f46606-goog
> >

