Return-Path: <bpf+bounces-5762-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4124F7600F6
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 23:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7183D1C20C75
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 21:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5674310978;
	Mon, 24 Jul 2023 21:15:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2390EDDC8
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 21:15:24 +0000 (UTC)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09078E56
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 14:15:20 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-63cebd0a7c5so9953096d6.3
        for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 14:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690233319; x=1690838119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4rysK55oB8iprX5PsN92lskw7NnrBKRNpCCq0EizyQ=;
        b=1BXELcHUXg/+rCkwfBoa14IfiR2Q6aqU9PgFbw47oz0uC3np3HFNCaFz7ScGSD5/Mq
         DQ2deQyYa6L8MreNAP/kbkznCiJ5lVuxnhfnrHFfd7TilrEZNfgf05J4hKAWXPiFXCKp
         w2saThXCYP65xSFqvvNKuNizMsmiRJkbU1CrPzPT6jgiRpEfH5PpOv1qTdGsIVNhCvAe
         Gntw2xb1FeAwbgsih7FPFGkyqFi3TaKSwJrgCjzW3MJ1FEezE8GysHleA1+80rYFJBqh
         nI1ugr89BQt/oT26XVioNDLE/paobBJMMPO2VpTFOpV8yTf+D95fnySZsTO0RH7SoWAV
         YxUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690233319; x=1690838119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w4rysK55oB8iprX5PsN92lskw7NnrBKRNpCCq0EizyQ=;
        b=UxMDX/BtSjkqEb0b6DGjtuutZjF6wWbKSKYdufSYT2GMm2LRetG+1CTa3O7cBRChrv
         pW+6zFclWDh3VhJdV//4GbTYMuaQtGlIpXjJMFLJ47I3CvNBhaRxTbfWU78MoTEgCMqH
         kiJA/a/MvkxaLjWy7UtwIDu5JveTN17lI1037wocgfViCS/fYpB0VXolE0KLEHnO8YXz
         W8ufhzpYFKkxQxof0OgjBlPgLgG4/Th/zbQsfu/75t0YfUTL2SbTyhCncd6bIHrPOZ/w
         apAMPVBhVj+Aq05df8PJOta3n/FmwHho1sBiZdoqvDCcuT4abt9YGUfVL7pqF684SZEO
         9kJg==
X-Gm-Message-State: ABy/qLZ65qEFcfMr7yjylBNJnZlMlGwJsfFkExlZqzf2bFH2JwdPngL7
	DS1rUOkDzsbZ6cLDSeuT3Ph0v26uhh3mAGQOrKgDOA==
X-Google-Smtp-Source: APBJJlGzkKPEZS/cCDJEywZijBo4Ycb4UpPFNxCPqzb5sG8S3hNQy1Vf6sw4+I8SpcgyjWOXfG3YKaJb/rNkKkoJIKU=
X-Received: by 2002:a0c:facf:0:b0:635:e4ed:b6c9 with SMTP id
 p15-20020a0cfacf000000b00635e4edb6c9mr949080qvo.24.1690233319030; Mon, 24 Jul
 2023 14:15:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230724201247.748146-1-irogers@google.com>
In-Reply-To: <20230724201247.748146-1-irogers@google.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 24 Jul 2023 14:15:07 -0700
Message-ID: <CAKwvOd=12eSPyc5ZRgm8NPMJYjj13QOxcnHtv_Y7Ws-zffyUrA@mail.gmail.com>
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
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 24, 2023 at 1:12=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> Add a build flag, LTO=3D1, so that perf is built with the -flto
> flag. Address some build errors this configuration throws up.

Hi Ian,
Thanks for the performance numbers. Any sense of what the build time
numbers might look like for building perf with LTO?

Does `-flto=3Dthin` in clang's case make a meaningful difference of
`-flto`? I'd recommend that over "full LTO" `-flto` when the
performance difference of the result isn't too meaningful.  ThinLTO
should be faster to build, but I don't know that I've ever built perf,
so IDK what to expect.
--=20
Thanks,
~Nick Desaulniers

