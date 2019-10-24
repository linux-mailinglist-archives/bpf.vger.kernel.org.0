Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A63E5E3BBC
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2019 21:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410274AbfJXTDl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Oct 2019 15:03:41 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34729 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392785AbfJXTDk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Oct 2019 15:03:40 -0400
Received: by mail-wm1-f65.google.com with SMTP id v3so2621212wmh.1
        for <bpf@vger.kernel.org>; Thu, 24 Oct 2019 12:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sOlMPkHiIzj/1B8Xdw7OYCh86kzsC/Xbe8Wte/5yW6Q=;
        b=T0qtov6jc1dWgVKPBKr+vQM05EqJtQlosqzBPsldHBN/WJeMn12v6oSWAzvVChG/Oo
         adeXB39MdZpTCFvYC/HeOChfNtKImaaFdp8DJBp72XB2JW6AnmcRfIiKLe5QGUuDj8yf
         WHHGTBqYrJlXmU+E/n5xRTvVG+QGDBYBCrWL4xzSx5GFZHoy3px+saTNPB6aO2rbXbXC
         W+AiGoI9xIrsr8E+I6cUQaJPWE6g0wvsZpCdKH0UH7mVRdyqjkdiMipiKXJh2EYOoO61
         l8LzLMJ+FMudrZPfYCvX/8WAV9D/F/gdzfKF3ahPkEONDiwrOYBeDaiedjOZKcEaD+gs
         epxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sOlMPkHiIzj/1B8Xdw7OYCh86kzsC/Xbe8Wte/5yW6Q=;
        b=jhuP/8JZHCCRi5kN65pKoak3uKZCk6WiH0AvtSvFnEmiJ2TpaJOTzpsRkVPGFzLPbA
         roOX0m+VXP8PkhrFnYdaozGGz9pREa+sN7v7VZC+QpWgrJNfkGiDqUTkCTyYqpgv5QBh
         hzukYMDfhZ9x4JbPkVSz4fFDMnp3grfkte0xDbXjYbSOy5LGx+dRR+Y44YXrJu78M9zX
         7PR9eBEhOvSfrlpaiIRvwcQizG+lMFLBZ4OyYBM91sp0v+0UeFPpOCeOCo1D49ymqdg+
         zaR9bxqI+A6JJN5XS3tdmAu8F+Z89zae6AukADFC8elk63Toqxuke4BTigvl9BWQKohX
         Idaw==
X-Gm-Message-State: APjAAAUzEhT28GJJiqKjjyFGCZ/ISOempJ8qgJL9ZnxwDC0LZ4gLObtI
        t9FMiF+sjMwWbTF8Hkg+uzIWpeF4+HtuohYqQCNvjg==
X-Google-Smtp-Source: APXvYqy/lvarHvt9DQzDe9G2HXXmTGxdzgcZNoWA9U7wCC2qWxO7jfRxZT7bqAZWy7ZQ+Tb8pwH1UPf1ZIWJ3aTgkPw=
X-Received: by 2002:a7b:c74a:: with SMTP id w10mr6252770wmk.30.1571943816673;
 Thu, 24 Oct 2019 12:03:36 -0700 (PDT)
MIME-Version: 1.0
References: <20191017170531.171244-1-irogers@google.com> <20191023005337.196160-1-irogers@google.com>
 <20191023005337.196160-7-irogers@google.com> <20191023090131.GH22919@krava>
In-Reply-To: <20191023090131.GH22919@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 24 Oct 2019 12:03:25 -0700
Message-ID: <CAP-5=fV4=0D=71Ea_ViHMo0opqME2JX2oGsTLPix3hbfdeV7MA@mail.gmail.com>
Subject: Re: [PATCH v2 6/9] perf tools: add destructors for parse event terms
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Sorry, the intent here is that patch v2 be used in preference to the
1st patch, it looks like you've applied both. The first patch split
apart tracepoint_name to avoid accessing out of scope stack memory,
the second patch allocates heap memory that is correctly destructed
(and consequently needs 1 fewer struct tracepoint_name member). Please
disregard the 1st patch and just apply the second series.

Thanks,
Ian


On Wed, Oct 23, 2019 at 2:01 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Tue, Oct 22, 2019 at 05:53:34PM -0700, Ian Rogers wrote:
> > If parsing fails then destructors are ran to clean the up the stack.
> > Rename the head union member to make the term and evlist use cases more
> > distinct, this simplifies matching the correct destructor.
>
> I'm getting compilation fail:
>
>   CC       util/parse-events-bison.o
> util/parse-events.y: In function =E2=80=98yydestruct=E2=80=99:
> util/parse-events.y:125:45: error: =E2=80=98struct tracepoint_name=E2=80=
=99 has no member named =E2=80=98sys=E2=80=99; did you mean =E2=80=98sys1=
=E2=80=99?
>   125 | %destructor { free ($$.sys); free ($$.event); } <tracepoint_name>
>
> jirka
>
