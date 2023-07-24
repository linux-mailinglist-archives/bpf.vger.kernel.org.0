Return-Path: <bpf+bounces-5768-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 377DE760243
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 00:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5F13281445
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 22:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC46D125CC;
	Mon, 24 Jul 2023 22:27:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5470125B4
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 22:27:34 +0000 (UTC)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4F210CB
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 15:27:32 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-76c4890a220so96450985a.3
        for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 15:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690237652; x=1690842452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dmJ4UktUm3I4b08JNBNEtnNvEux0EbK78Q8s0QO58jU=;
        b=bAlfJaNfqM49DHJaN+ilEqFTHpxcdiCzxldvdmGyGQ+FFGn/x35Zu1BNa4jmcuLxDT
         BR70Ybc3Z/fKvEpaE1Ye7VhUHxiKi3dnxOjQwJTQbCaa3kH30o9vdfPAbA+M+9ds2V/G
         nnsr2d9Ac7WKln1WWgRVY+6XtwRjMsLm/JLGvLhuv8AHcKn09MKt6VTRaXRAk8s/CheO
         E8HtPR0m/QUmtYfDuqmvA7hlufvZ4UdddVZ+PrFXhBbE6YIOBVdEAM5NtTipCR9zR/3p
         jXlEzyh2l/nTYnkjmwYKzo6nfpyRts33gJcxIWU9/oHB7FBOEh7Qi+BISa1s35GuwIKe
         Yi0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690237652; x=1690842452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dmJ4UktUm3I4b08JNBNEtnNvEux0EbK78Q8s0QO58jU=;
        b=B1oDFq9+1OBvPJrOejqdnW/FTsM2SLSJKKVQCXXliABPayMqyTEbTErXVib9SbDa4s
         BPh4S+gg+Jy5o0EGIuAkTyBvaAU1AKaec/gVfQZqbaLnfC4D4DOtUOHikVjH+lk+mX+e
         GAoFUr+fEnVZdlKq5VurgQUQZmTybmCPD9it6V6WERtTCxPry2tKkawkUOpkYPWTks8q
         VA3Wj/sJ/CteJS0kDn1dBKln+CsjEU831buOkZqmXOCpSo422BWDXtMY6oJ0Wza02dLi
         zU404SHHlY6vivfjsyCx6PJJ/VPXDnbusfQslK5Nbn3ghvyPwbuZrk7MLHLqMxhY9qBE
         7Hsg==
X-Gm-Message-State: ABy/qLaCTHoiwCJbX+ugwRSLD0kHTjaWOOxhPFop3+zEQydcecKLrxhA
	izbU230XEfoxmmeRCSDYcBqjVxFcymJUxW6n9Ou7HQ==
X-Google-Smtp-Source: APBJJlECrVm2GuN7mTC2Dq191dLy/wkFF1S9HS78iZkZQBh7hVibPxOOINn7nGfNmqIm7MRcqzKxAsAUVxtL4ns4Ly8=
X-Received: by 2002:a05:620a:2493:b0:766:27c2:cec8 with SMTP id
 i19-20020a05620a249300b0076627c2cec8mr1375203qkn.16.1690237651874; Mon, 24
 Jul 2023 15:27:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230724201247.748146-1-irogers@google.com> <CAKwvOd=12eSPyc5ZRgm8NPMJYjj13QOxcnHtv_Y7Ws-zffyUrA@mail.gmail.com>
 <CAP-5=fVh5atUjf4sLBYi4CwxYdWJfub_0anXKTdVuJrZkC4-tQ@mail.gmail.com>
In-Reply-To: <CAP-5=fVh5atUjf4sLBYi4CwxYdWJfub_0anXKTdVuJrZkC4-tQ@mail.gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 24 Jul 2023 15:27:20 -0700
Message-ID: <CAKwvOd=eZ+m4hJ23S=v-BW0BxuWk=YCW=xRLcD00iTKWBiHjVQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] Perf tool LTO support
To: Ian Rogers <irogers@google.com>
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
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 24, 2023 at 2:48=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Mon, Jul 24, 2023 at 2:15=E2=80=AFPM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Mon, Jul 24, 2023 at 1:12=E2=80=AFPM Ian Rogers <irogers@google.com>=
 wrote:
> > >
> > > Add a build flag, LTO=3D1, so that perf is built with the -flto
> > > flag. Address some build errors this configuration throws up.
> >
> > Hi Ian,
> > Thanks for the performance numbers. Any sense of what the build time
> > numbers might look like for building perf with LTO?
> >
> > Does `-flto=3Dthin` in clang's case make a meaningful difference of
> > `-flto`? I'd recommend that over "full LTO" `-flto` when the
> > performance difference of the result isn't too meaningful.  ThinLTO
> > should be faster to build, but I don't know that I've ever built perf,
> > so IDK what to expect.
>
> Hi Nick,
>
> I'm not sure how much the perf build will benefit from LTO to say
> whether thin is good enough or not. Things like "perf record" are
> designed to spend the majority of their time blocking on a poll system
> call. We have benchmarks at least :-)
>
> I grabbed some clang build times in an unscientific way on my loaded lapt=
op:
>
> no LTO
> real    0m48.846s
> user    3m11.452s
> sys     0m29.598s
>
> -flto=3Dthin
> real    0m55.910s
> user    4m2.342s
> sys     0m30.120s
>
> real    0m50.330s
> user    3m36.986s
> sys     0m28.519s
>
> -flto
> real    1m12.002s
> user    3m27.676s
> sys     0m30.305s
>
> real    1m5.187s
> user    3m19.348s
> sys     0m29.031s
>
> So perhaps thin LTO increases total build time by 10%, whilst full LTO
> increases it by 50%.
>
> Gathering some clang performance numbers:
>
> no LTO
> $ perf bench internals synthesize
> # Running 'internals/synthesize' benchmark:
> Computing performance of single threaded perf event synthesis by
> synthesizing events on the perf process itself:
>  Average synthesis took: 178.694 usec (+- 0.171 usec)
>  Average num. events: 52.000 (+- 0.000)
>  Average time per event 3.436 usec
>  Average data synthesis took: 194.545 usec (+- 0.088 usec)
>  Average num. events: 277.000 (+- 0.000)
>  Average time per event 0.702 usec
> # Running 'internals/synthesize' benchmark:
> Computing performance of single threaded perf event synthesis by
> synthesizing events on the perf process itself:
>  Average synthesis took: 175.381 usec (+- 0.105 usec)
>  Average num. events: 52.000 (+- 0.000)
>  Average time per event 3.373 usec
>  Average data synthesis took: 188.980 usec (+- 0.071 usec)
>  Average num. events: 278.000 (+- 0.000)
>  Average time per event 0.680 usec
>
> -flto=3Dthin
> $ perf bench internals synthesize
> # Running 'internals/synthesize' benchmark:
> Computing performance of single threaded perf event synthesis by
> synthesizing events on the perf process itself:
>  Average synthesis took: 183.122 usec (+- 0.082 usec)
>  Average num. events: 52.000 (+- 0.000)
>  Average time per event 3.522 usec
>  Average data synthesis took: 196.468 usec (+- 0.102 usec)
>  Average num. events: 277.000 (+- 0.000)
>  Average time per event 0.709 usec
> # Running 'internals/synthesize' benchmark:
> Computing performance of single threaded perf event synthesis by
> synthesizing events on the perf process itself:
>  Average synthesis took: 177.684 usec (+- 0.094 usec)
>  Average num. events: 52.000 (+- 0.000)
>  Average time per event 3.417 usec
>  Average data synthesis took: 190.079 usec (+- 0.077 usec)
>  Average num. events: 275.000 (+- 0.000)
>  Average time per event 0.691 usec
>
> -flto
> $ perf bench internals synthesize
> # Running 'internals/synthesize' benchmark:
> Computing performance of single threaded perf event synthesis by
> synthesizing events on the perf process itself:
>  Average synthesis took: 112.599 usec (+- 0.040 usec)
>  Average num. events: 52.000 (+- 0.000)
>  Average time per event 2.165 usec
>  Average data synthesis took: 119.012 usec (+- 0.070 usec)
>  Average num. events: 278.000 (+- 0.000)
>  Average time per event 0.428 usec
> # Running 'internals/synthesize' benchmark:
> Computing performance of single threaded perf event synthesis by
> synthesizing events on the perf process itself:
>  Average synthesis took: 107.606 usec (+- 0.147 usec)
>  Average num. events: 52.000 (+- 0.000)
>  Average time per event 2.069 usec
>  Average data synthesis took: 114.633 usec (+- 0.159 usec)
>  Average num. events: 279.000 (+- 0.000)
>  Average time per event 0.411 usec
>
> The performance win from thin LTO doesn't look to be there. Full LTO
> appears to be reducing event synthesis time down to 60% of what it
> was. The clang numbers are looking better than the GCC ones. I think
> from this it makes sense to use -flto.

Without any context, I'm not really sure what numbers are good vs. bad
("is larger better?").  More so I was curious if thinLTO perhaps got
most of the win without significant performance regressions. If not,
oh well, and if the slower full LTO has numbers that make sense to
other reviewers, well then *Chuck Norris thumbs up*.  Thanks for the
stats.

>
> Thanks,
> Ian
>
> > --
> > Thanks,
> > ~Nick Desaulniers



--=20
Thanks,
~Nick Desaulniers

