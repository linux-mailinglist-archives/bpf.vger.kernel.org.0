Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD0B452454A
	for <lists+bpf@lfdr.de>; Thu, 12 May 2022 08:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350072AbiELGAV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 May 2022 02:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350074AbiELGAU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 May 2022 02:00:20 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B86D21B16F;
        Wed, 11 May 2022 23:00:20 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id w130so5324178oig.0;
        Wed, 11 May 2022 23:00:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a7v3kpgCHL4lSPtmaodDrwClQXTFc2Us+lIP9tOf/jQ=;
        b=r1wBYnZ3YexOTa1Uvyh3dbiO2bRf21R35Pue8W4pa7ZwzFhYZmiHh6Vnh6wzhu6va6
         U9UhsHsLGyVZXimMIpZ0tSD8hIomG8SKf6qe0ovDVqT1TMOUUNxDTT84WcTYyV2FJqsO
         KMvbuDgoloSTwj0K1YWiF+TgjuCkORpmfeBwguWnKHMzvUk7OSODg33RhP4APxwRN3+s
         OidWRobzOhKbIhYSJ2DXg4HsbLmdF3F8lT+8Qi+Ay25fYGh74Y60AXXzP+lBoUSF89yK
         lgwCwEUZgH1YHOjzoeuttr5V6f7dZt2SWcStrPnr/uyffBsdbjeO6PxZIjQROujsdni0
         Xh7g==
X-Gm-Message-State: AOAM531TIHhUfYflW86Cj8MUVgYaIIxC5We9BEPF3GF+snQrUu0s5jv9
        +c6zYUokhWRf9SrzFkQUpwTLYaCt/z7TkZ5HNqM=
X-Google-Smtp-Source: ABdhPJyyBK4NyiBn8Ll0K1mCMENvb6ThGjHNjyRBEf/Xzfb0SAwxmYsMpV46GgZhL4lFgleEeXpO5qU3fqMNetLr3Nc=
X-Received: by 2002:a05:6808:2218:b0:326:bd8c:d044 with SMTP id
 bd24-20020a056808221800b00326bd8cd044mr4376782oib.92.1652335219320; Wed, 11
 May 2022 23:00:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220506201627.85598-1-namhyung@kernel.org> <20220506201627.85598-2-namhyung@kernel.org>
 <YnqXtRqW1phdtc7a@kernel.org>
In-Reply-To: <YnqXtRqW1phdtc7a@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 11 May 2022 23:00:08 -0700
Message-ID: <CAM9d7cjDxNx42oxyL5A0TA+b6tJXtSgAP6eVvHOGwz55rZ7piw@mail.gmail.com>
Subject: Re: [PATCH 1/4] perf report: Do not extend sample type of bpf-output event
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Song Liu <songliubraving@fb.com>, Hao Luo <haoluo@google.com>,
        Milian Wolff <milian.wolff@kdab.com>,
        bpf <bpf@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Blake Jones <blakejones@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Arnaldo,

On Tue, May 10, 2022 at 9:50 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Fri, May 06, 2022 at 01:16:24PM -0700, Namhyung Kim escreveu:
> > Currently evsel__new_idx() sets more sample_type bits when it finds a
> > BPF-output event.  But it should honor what's recorded in the perf
> > data file rather than blindly sets the bits.  Otherwise it could lead
> > to a parse error when it recorded with a modified sample_type.
>
> Can you please try to provide a Fixes: tag for this? This way reviewing
> gets simpler by looking at who introduced this, if there was some reason
> or if it was a plain oversight.
>
> It also helps to get this fix propabated to the stable trees.

Well.. actually this is not a fix.  I've realized it adds some
sample types when it creates a new evsel regardless of
the perf_event_attr.

This was not a problem so far (as nobody touched it),
but when I changed some sample types during record
for this change, perf report sees a different value and
rejects the data.

Thanks,
namhyung
