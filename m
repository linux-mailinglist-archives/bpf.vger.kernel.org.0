Return-Path: <bpf+bounces-5766-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8D9760182
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 23:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B11F1C20AC0
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 21:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B1911C9E;
	Mon, 24 Jul 2023 21:48:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B735E1094E
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 21:48:24 +0000 (UTC)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD1D172D
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 14:48:20 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-40550136e54so103401cf.0
        for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 14:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690235300; x=1690840100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ifTUtuK5V5MYNm+bAiFRs1Giaz2am8su6EuD15e6Ok=;
        b=mMZUcwQNUodC/QF5Mwrwq4C5u18fp9psSC6UogZD89mO6pyZOOc7ho04Q2E7SqS/OO
         KjReVXCVmSn2vYocui6Dtk4Wm2DAnDXrk8g0wR7nnx5vBHWQgxtz001U5hQtWel4/muw
         tJ/yTdZDfKDBnHxwWLUnnv+FKDwZjAzFmIuo9B3bixEIYeBVKYlo7W2ujZubpiUjaYtJ
         CGYyn+1RC5RpPS84stQZYGW+dwJU0QtCn3Xl4TPiHwk2elm0ePhqvQZftkpbbr1xHBQX
         qtSRIrFmxyxhd/KpGzD7UKPMZKbbEA6SXOeFEQHkqse7OTDV0tI5Rvw4Oxu9u9hKLwmY
         yG0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690235300; x=1690840100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ifTUtuK5V5MYNm+bAiFRs1Giaz2am8su6EuD15e6Ok=;
        b=aHtglGaPKOt8ySufCCQG3LKOIhuwla6Dt5sdwrdGPv9ode4FDxbhhpjZhMU8LqmsA0
         bpM9XOMLTVmVYADKfVzzrKP6NWVt/fvk84L5729JucNezIC9OnnT8jOJEA1PJ+Jjl1gs
         XiZXjs14/g28aLbnuOcI/Pk/Lhb4ZOlP+Hr6jgBc6jrTAqWGnpz2r1PtJ/k6ohZcq/XH
         0sRqdYq4b41q6Xq75EWPd7i+rqVjcMyXSrDpyj+iPxPzmoYZzByixrYM2cr3IcICtr3e
         hqN0OIuFrGl8uJMJhbm9YvDaENYelB7GJRNgTsPppiy6lzhpRd1pI6WQcYnFrBjcDTNw
         oRzg==
X-Gm-Message-State: ABy/qLY+RCbZrAQfhBaiwRBnWR9pZAckrlUWHstBkcxoubNvcrnHM3CC
	tg+DW0kc/ZtiJNihT27dd5Oy7/EmvQWtNMTfymjlCQ==
X-Google-Smtp-Source: APBJJlHsYrWvniCrUgIhS1T7zRs3emxCP5nrN9ov/190OzoLUgKYnCs1z1pROaIHbr8oEMK6D6d+72oPtVgeoIS0i+k=
X-Received: by 2002:ac8:5c89:0:b0:403:59cb:66c4 with SMTP id
 r9-20020ac85c89000000b0040359cb66c4mr561657qta.23.1690235299904; Mon, 24 Jul
 2023 14:48:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230724201247.748146-1-irogers@google.com> <CAKwvOd=12eSPyc5ZRgm8NPMJYjj13QOxcnHtv_Y7Ws-zffyUrA@mail.gmail.com>
In-Reply-To: <CAKwvOd=12eSPyc5ZRgm8NPMJYjj13QOxcnHtv_Y7Ws-zffyUrA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 24 Jul 2023 14:48:08 -0700
Message-ID: <CAP-5=fVh5atUjf4sLBYi4CwxYdWJfub_0anXKTdVuJrZkC4-tQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] Perf tool LTO support
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Tom Rix <trix@redhat.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Carsten Haitzler <carsten.haitzler@arm.com>, 
	Zhengjun Xing <zhengjun.xing@linux.intel.com>, James Clark <james.clark@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, llvm@lists.linux.dev, maskray@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 24, 2023 at 2:15=E2=80=AFPM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Mon, Jul 24, 2023 at 1:12=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > Add a build flag, LTO=3D1, so that perf is built with the -flto
> > flag. Address some build errors this configuration throws up.
>
> Hi Ian,
> Thanks for the performance numbers. Any sense of what the build time
> numbers might look like for building perf with LTO?
>
> Does `-flto=3Dthin` in clang's case make a meaningful difference of
> `-flto`? I'd recommend that over "full LTO" `-flto` when the
> performance difference of the result isn't too meaningful.  ThinLTO
> should be faster to build, but I don't know that I've ever built perf,
> so IDK what to expect.

Hi Nick,

I'm not sure how much the perf build will benefit from LTO to say
whether thin is good enough or not. Things like "perf record" are
designed to spend the majority of their time blocking on a poll system
call. We have benchmarks at least :-)

I grabbed some clang build times in an unscientific way on my loaded laptop=
:

no LTO
real    0m48.846s
user    3m11.452s
sys     0m29.598s

-flto=3Dthin
real    0m55.910s
user    4m2.342s
sys     0m30.120s

real    0m50.330s
user    3m36.986s
sys     0m28.519s

-flto
real    1m12.002s
user    3m27.676s
sys     0m30.305s

real    1m5.187s
user    3m19.348s
sys     0m29.031s

So perhaps thin LTO increases total build time by 10%, whilst full LTO
increases it by 50%.

Gathering some clang performance numbers:

no LTO
$ perf bench internals synthesize
# Running 'internals/synthesize' benchmark:
Computing performance of single threaded perf event synthesis by
synthesizing events on the perf process itself:
 Average synthesis took: 178.694 usec (+- 0.171 usec)
 Average num. events: 52.000 (+- 0.000)
 Average time per event 3.436 usec
 Average data synthesis took: 194.545 usec (+- 0.088 usec)
 Average num. events: 277.000 (+- 0.000)
 Average time per event 0.702 usec
# Running 'internals/synthesize' benchmark:
Computing performance of single threaded perf event synthesis by
synthesizing events on the perf process itself:
 Average synthesis took: 175.381 usec (+- 0.105 usec)
 Average num. events: 52.000 (+- 0.000)
 Average time per event 3.373 usec
 Average data synthesis took: 188.980 usec (+- 0.071 usec)
 Average num. events: 278.000 (+- 0.000)
 Average time per event 0.680 usec

-flto=3Dthin
$ perf bench internals synthesize
# Running 'internals/synthesize' benchmark:
Computing performance of single threaded perf event synthesis by
synthesizing events on the perf process itself:
 Average synthesis took: 183.122 usec (+- 0.082 usec)
 Average num. events: 52.000 (+- 0.000)
 Average time per event 3.522 usec
 Average data synthesis took: 196.468 usec (+- 0.102 usec)
 Average num. events: 277.000 (+- 0.000)
 Average time per event 0.709 usec
# Running 'internals/synthesize' benchmark:
Computing performance of single threaded perf event synthesis by
synthesizing events on the perf process itself:
 Average synthesis took: 177.684 usec (+- 0.094 usec)
 Average num. events: 52.000 (+- 0.000)
 Average time per event 3.417 usec
 Average data synthesis took: 190.079 usec (+- 0.077 usec)
 Average num. events: 275.000 (+- 0.000)
 Average time per event 0.691 usec

-flto
$ perf bench internals synthesize
# Running 'internals/synthesize' benchmark:
Computing performance of single threaded perf event synthesis by
synthesizing events on the perf process itself:
 Average synthesis took: 112.599 usec (+- 0.040 usec)
 Average num. events: 52.000 (+- 0.000)
 Average time per event 2.165 usec
 Average data synthesis took: 119.012 usec (+- 0.070 usec)
 Average num. events: 278.000 (+- 0.000)
 Average time per event 0.428 usec
# Running 'internals/synthesize' benchmark:
Computing performance of single threaded perf event synthesis by
synthesizing events on the perf process itself:
 Average synthesis took: 107.606 usec (+- 0.147 usec)
 Average num. events: 52.000 (+- 0.000)
 Average time per event 2.069 usec
 Average data synthesis took: 114.633 usec (+- 0.159 usec)
 Average num. events: 279.000 (+- 0.000)
 Average time per event 0.411 usec

The performance win from thin LTO doesn't look to be there. Full LTO
appears to be reducing event synthesis time down to 60% of what it
was. The clang numbers are looking better than the GCC ones. I think
from this it makes sense to use -flto.

Thanks,
Ian

> --
> Thanks,
> ~Nick Desaulniers

