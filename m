Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574055B2A82
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 01:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiIHXo3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Sep 2022 19:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiIHXo3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Sep 2022 19:44:29 -0400
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09F81032;
        Thu,  8 Sep 2022 16:44:26 -0700 (PDT)
Received: by mail-oo1-f54.google.com with SMTP id c17-20020a4a8ed1000000b004452faec26dso38132ool.5;
        Thu, 08 Sep 2022 16:44:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=hpjDs0d5k66FbZ/DNVbf1k31rcJNK+H1RkJ2bnLj/w8=;
        b=le1RPNW2HImWOvVkATbd0ARkXOhd5WXpAejnaHGI11OsSe0z6GUOeHAGKpnbHI7+IA
         rogB8OA0Usq+ipspQ61qtQMiJSicBNQT9YOoTYrKGHpCK+ljJufoZbBfIYv5J0LWjRUX
         JRDS5LFwAztjm8wr6cKkL3HBeP88PUi39zhqkuWP7lr7KI+6SzD9oTJ85jrPQJSNz92c
         cy7e62dGUCF/cxzziXDyFctGgO7WOzStx9q3cJjNM6QPj+GTbmsyCNaddr6ONw7gsZKX
         Eu2sq0YIchewJU+O9jGi3waTjj0BPyGwJGq8SWIkPhnjPcqlkANFa+lQzbmVc0/a5Ftx
         wR7w==
X-Gm-Message-State: ACgBeo2dZHQ7ZssLEGmlZKXL4RdnAKW7tcJZ11N5RiJBXE8i4LUnQr4Z
        +2eq0ep10tGPfouWUshN8JB59kQ65YKpmKuqR24=
X-Google-Smtp-Source: AA6agR6tMbRURXtQ+IY9F7bfWkuI3sINNcfKV8Si7ZXqgp5ux6MZlOmYsxEQSA3oaq/K0VXVi6JOLb0cgCP3Ag1gHQ4=
X-Received: by 2002:a4a:a78a:0:b0:472:a078:98d6 with SMTP id
 l10-20020a4aa78a000000b00472a07898d6mr691646oom.97.1662680666065; Thu, 08 Sep
 2022 16:44:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220908063754.1369709-1-namhyung@kernel.org> <Yxo32kpxsl9Mr7Mt@kernel.org>
In-Reply-To: <Yxo32kpxsl9Mr7Mt@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 8 Sep 2022 16:44:15 -0700
Message-ID: <CAM9d7cgOPUoGr96yc=M=bBTQG-jkW269Lc7-uEYTWGURiCAjyQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] perf lock contention: Improve call stack handling (v1)
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Arnaldo,

On Thu, Sep 8, 2022 at 11:43 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Wed, Sep 07, 2022 at 11:37:50PM -0700, Namhyung Kim escreveu:
> > Hello,
> >
> > I found that call stack from the lock tracepoint (using bpf_get_stackid)
> > can be different on each configuration.  For example it's very different
> > when I run it on a VM than on a real machine.
> >
> > The perf lock contention relies on the stack trace to get the lock
> > caller names, this kind of difference can be annoying.  Ideally we could
> > skip stack trace entries for internal BPF or lock functions and get the
> > correct caller, but it's not the case as of today.  Currently it's hard
> > coded to control the behavior of stack traces for the lock contention
> > tracepoints.
> >
> > To handle those differences, add two new options to control the number of
> > stack entries and how many it skips.  The default value worked well on
> > my VM setup, but I had to use --stack-skip=5 on real machines.
> >
> > You can get it from 'perf/lock-stack-v1' branch in
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
>
> This clashed with a patch you Acked earlier, so lets see if someone has
> extra review comments and a v2 become needed for other reason, when you
> can refresh it, ok?

Sounds good!

Thanks,
Namhyung
