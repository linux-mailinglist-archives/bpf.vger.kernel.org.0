Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB396A124B
	for <lists+bpf@lfdr.de>; Thu, 23 Feb 2023 22:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjBWVuF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Feb 2023 16:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBWVuD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Feb 2023 16:50:03 -0500
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB1DF77B;
        Thu, 23 Feb 2023 13:50:02 -0800 (PST)
Received: by mail-vs1-f51.google.com with SMTP id f13so13962855vsg.6;
        Thu, 23 Feb 2023 13:50:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r7xjpQc7ELJpfmCL2VOzLnnU8rHD9JJ2+wguahKqJjI=;
        b=JDR+mjehDw9066HjWSUhKCfovzP1o/0XRCMGH4RZ8MCkJ0Z1KECZquWufO47srnuq6
         jVXa9OHBkdymMyzj96esMyrjZbuiK74RXNcTKKT7gtNll7BYULqyepQ9ufJGL0CrCCHT
         jUA+/H6ImJtRl6MtQow8uKUsuJoiPkSt4hiJO6/nq5AoXZaQ6689iTWww/oTqFMpFSfU
         o0AAyjglT74kwELY7/FO8qrTZ+ljO7HbmBmBkrz1hpXeiJ/ahhDDt1KJ0kjlNTuncTgw
         mrUJ7OVsKwsyggnonkfrhgtEG+BKP2afi7SYLxKGSwSengksy3/pF6ODi1WCmJuZV0pG
         d0xg==
X-Gm-Message-State: AO0yUKWiOXCjkQJCU58eswMKs3+gP7LF67BXxdytxV49swHJJocIuyNj
        uQsIbn9Vn+/od7Gh5HXWI394M/sVhlwuXittEvw=
X-Google-Smtp-Source: AK7set8NGh1mxIbFg7MzYyrjxYgDjfkKuIVijdNNHXQP92atWvUPPv0g5fcRYVQYo4ZpUOitB2uTTRfh81jftsFWfes=
X-Received: by 2002:a67:e182:0:b0:411:fd99:bc47 with SMTP id
 e2-20020a67e182000000b00411fd99bc47mr921766vsl.2.1677189001891; Thu, 23 Feb
 2023 13:50:01 -0800 (PST)
MIME-Version: 1.0
References: <20230219061329.1001079-1-namhyung@kernel.org> <Y/d8juzJIRHdtKlQ@kernel.org>
In-Reply-To: <Y/d8juzJIRHdtKlQ@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 23 Feb 2023 13:49:49 -0800
Message-ID: <CAM9d7cgxJEMioUAqVN7g+GVfmEYtJ3S1tGyNhdQH_qv7wYJAFg@mail.gmail.com>
Subject: Re: [RFC/PATCHSET 0/8] perf record: Implement BPF sample filter (v2)
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Song Liu <song@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        James Clark <james.clark@arm.com>, Hao Luo <haoluo@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
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

On Thu, Feb 23, 2023 at 6:47 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Sat, Feb 18, 2023 at 10:13:21PM -0800, Namhyung Kim escreveu:
> > Hello,
> >
> > There have been requests for more sophisticated perf event sample
> > filtering based on the sample data.  Recently the kernel added BPF
> > programs can access perf sample data and this is the userspace part
> > to enable such a filtering.
> >
> > This still has some rough edges and needs more improvements.  But
> > I'd like to share the current work and get some feedback for the
> > directions and idea for further improvements.
> >
> > v2 changes)
> >  * fix build error with the misc field  (Jiri)
> >  * add a destructor for filter expr  (Ian)
> >  * remove 'bpf:' prefix  (Arnaldo)
> >  * add '||' operator
> >
> > The kernel changes are in the tip.git tree (perf/core branch) for now.
> > perf record has --filter option to set filters on the last specified
> > event in the command line.  It worked only for tracepoints and Intel
> > PT events so far.  This patchset extends it to have 'bpf:' prefix in
> > order to enable the general sample filters using BPF for any events.
> >
> > A new filter expression parser was added (using flex/bison) to process
> > the filter string.  Right now, it only accepts very simple expressions
> > separated by comma.  I'd like to keep the filter expression as simple
> > as possible.
> >
> > It requires samples satisfy all the filter expressions otherwise it'd
> > drop the sample.  IOW filter expressions are connected with logical AND
> > operations implicitly.
> >
> > Essentially the BPF filter expression is:
> >
> >   <term> <operator> <value> (("," | "||") <term> <operator> <value>)*
>
> So "," means "&&" ?

Right. :)

>
> I understand that its less characters, but can't we use the well
> established '&&' instead? :-)

It's doable but I was a bit afraid of the complexity or confusion
it might bring up.  It should handle expressions like 'A && B || C'
then we need to be clear on the precedence of them.  Currently
it would behave like 'A && (B || C)' but users might expect
'(A && B) || C'.

Then we might want to add the parentheses explicitly to adjust
the operator priority.  That could result in complex expressions
possibly with nested parentheses.  I'm not sure if we really want
this.  Considering the restrictions in BPF, I think we should keep
the expressions as simple as possible.

Thanks,
Namhyung
