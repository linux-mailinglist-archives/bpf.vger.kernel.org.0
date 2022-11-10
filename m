Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC97624916
	for <lists+bpf@lfdr.de>; Thu, 10 Nov 2022 19:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiKJSIk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Nov 2022 13:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbiKJSIj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Nov 2022 13:08:39 -0500
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E01F46;
        Thu, 10 Nov 2022 10:08:38 -0800 (PST)
Received: by mail-oi1-f176.google.com with SMTP id l127so2627526oia.8;
        Thu, 10 Nov 2022 10:08:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XYCUBHqct+07UozRxiYIUw1k9pkP6QQrqh3olQalCvY=;
        b=QLFnR+dHBti1Cf4w9zBeHua0ZBYqTTbRZGRwXQBekFeLYhLSKFu1ameeKzn35B5fff
         uazojcljgmAjwDZpvSNiRt5uRVz+Joq8opxYPYtzPDPWKobEswUwHKirIpd84gimwJ3s
         jiwnKsIghaQxId+Q5fF3QB3radmyWYKFbUjQq8i4W7+aAiPVND0Yh/pnK4144F1nhfVk
         s3/cApCv66r61FvmrVlNWydxYz8+MyD7pBZat/2nCdy7aDMSs5IzSSJQNjcmh9VxJTSr
         hOrVn1w2qGFVil93Wxw9Fm2Rv//FKrXTwJRshLup8oalWVruVttt5DfZuMhQli/JKnfq
         gW+Q==
X-Gm-Message-State: ANoB5pn3XMfgc18WpUyUkVyBKPlxpd2wMyvoDI7z0icNsNxCli9dEg02
        yMTNuV74UYWNApMqQXuhRJsdqj+UU5Ca9Ccs+y4=
X-Google-Smtp-Source: AA0mqf7FVTwTIIGVD88sA/SHxb9baymLkL6QsBVO6Xsb5084bWwhfZ8Eij0SfnmiU9yaNso3Vl4VIYfKuI6S8Ps2GNk=
X-Received: by 2002:aca:130a:0:b0:35a:812c:3eae with SMTP id
 e10-20020aca130a000000b0035a812c3eaemr1374031oii.218.1668103717760; Thu, 10
 Nov 2022 10:08:37 -0800 (PST)
MIME-Version: 1.0
References: <20221109184914.1357295-1-irogers@google.com> <20221109184914.1357295-9-irogers@google.com>
 <CAM9d7cgpcVcUZo6ExLWis2Pu4V0FXdsNx+ZoKUWrOYqgqyZTiQ@mail.gmail.com> <Y202br0IHVj9SDJ+@kernel.org>
In-Reply-To: <Y202br0IHVj9SDJ+@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 10 Nov 2022 10:08:26 -0800
Message-ID: <CAM9d7cjZpzkE+FOoiti1rPxdKji2OS7M_bg+RvOAV9dwsGQP=w@mail.gmail.com>
Subject: Re: [PATCH v2 08/14] tools lib perf: Add missing install headers
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Arnaldo,

On Thu, Nov 10, 2022 at 9:35 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Wed, Nov 09, 2022 at 12:12:16PM -0800, Namhyung Kim escreveu:
> > On Wed, Nov 9, 2022 at 10:50 AM Ian Rogers <irogers@google.com> wrote:
> > > Headers necessary for the perf build. Note, internal headers are also
> > > installed as these are necessary for the build.
>
> > Yeah, it's sad we are using those internal headers in perf.
>
> The plan is for perf to eventually be a libperf tool, but what was done
> so far was make available classes and methods that were asked for by
> libperf users.
>
> Completely untangling tools/perf/ from those internal bits will needs
> lots more work, so doing it the way Ian is doing now seems ok.

Agreed.  I'm happy to see this work going on. :)

Thanks,
Namhyung
