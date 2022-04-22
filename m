Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA89250B4BB
	for <lists+bpf@lfdr.de>; Fri, 22 Apr 2022 12:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446400AbiDVKOa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Apr 2022 06:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377723AbiDVKOa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Apr 2022 06:14:30 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7D5506E7;
        Fri, 22 Apr 2022 03:11:37 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id r13so15429152ejd.5;
        Fri, 22 Apr 2022 03:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/5jFIllHJ5gNhVb9UGODyKx/Qa32vuqS5VMBQo+3n8s=;
        b=cU5sTb2IGwQuvzP/JShkIB3U7TZ3eteKDNGGlPUluCEbu5FoP95ibrNSC4SNWpKvHv
         onI6hGSIyTdveM/RFpT0xSVMIAbUOfBvgIWLPoyyfmo8v1jnb3vk1X4USaDRRAsN0/1N
         A1R4VBo3T6kcXEYu5XHyTLnM9Bsu7n7eva/+8Lhmfeqh0tpvQzGrBVR6LZp7GUvYk55x
         1lX0qvSoh4yX5aJa7Ktk4VVubRFVUs51gdzzy9Txr3E+lZvHP2dG3ylK9sUvxok679I5
         LHMXpqqwJFjT+6XSINmkRDR3OQjrI5XbWuIVlIyQxhtUiSRFxySjHldkbmeoy4JDKxJ9
         JY7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/5jFIllHJ5gNhVb9UGODyKx/Qa32vuqS5VMBQo+3n8s=;
        b=UuZ+90tqO6qvHr1vJKD6XurhAFLQgcOCIUyhzU2HFEX4s8J1X2k/Afs30cqXIoMwkL
         re+0wZBkmSnXHKFrwq98xfMbRyadKZYDDlZp0EE/ANBcHJzVOIGqoxyjzPDUBtrLI2Sf
         7nD3BneKQZ2dhVYd8O5kEKqVtnNfzx/ljG/DVoGaC6o89TblfGVDHRp1GeHXLk/g4FPP
         //Zt2EEuI18KnMeWkf+S+Sg812KOGuG5uHA515Ml1hjHpDerKgZWwBs395Z80zidAb0p
         0y8TjjAHvd9fzMaAeAj8Ctt0sy/PumDrOxZjxmFwHxQ4VKh2XwjGTu1EVffBIWKpGuQz
         Ak9A==
X-Gm-Message-State: AOAM533prTGt5/HkWogc1ZpD3l7m5M+KBz0hDYJn3WlNZV2wi3XpKAjt
        jTKTMJbZ98QYFlZQGjifCg0=
X-Google-Smtp-Source: ABdhPJxVCmYEiDhhqtAiMHUNIsfX58xYW7NI7ILUW2z5cMlN76p7A6glGcq+J/WvvCTtsFxlIfCzvA==
X-Received: by 2002:a17:906:7304:b0:6da:9243:865 with SMTP id di4-20020a170906730400b006da92430865mr3317761ejc.665.1650622295880;
        Fri, 22 Apr 2022 03:11:35 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id y19-20020a056402359300b00423e51be1cesm707069edc.64.2022.04.22.03.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 03:11:35 -0700 (PDT)
Date:   Fri, 22 Apr 2022 12:11:32 +0200
From:   Jiri Olsa <olsajiri@gmail.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Song Liu <songliubraving@fb.com>, Hao Luo <haoluo@google.com>,
        bpf@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Blake Jones <blakejones@google.com>
Subject: Re: [RFC 0/4] perf record: Implement off-cpu profiling with BPF (v1)
Message-ID: <YmJ/VAt2yblZC9HN@krava>
References: <20220422053401.208207-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422053401.208207-1-namhyung@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 21, 2022 at 10:33:57PM -0700, Namhyung Kim wrote:

SNIP

> The perf bench sched messaging created 400 processes to send/receive
> messages through unix sockets.  It spent a large portion of cpu cycles
> for audit filter and read/copy the messages while most of the
> offcpu-time was in read and write calls.
> 
> You can get the code from 'perf/offcpu-v1' branch in my tree at
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
> 
> Enjoy! :)

  CC      builtin-record.o
builtin-record.c:52:10: fatal error: util/off_cpu.h: No such file or directory
   52 | #include "util/off_cpu.h"

forgot to add util/off_cpu.h ?

jirka

> 
> Thanks,
> Namhyung
> 
> 
> Namhyung Kim (4):
>   perf report: Do not extend sample type of bpf-output event
>   perf record: Enable off-cpu analysis with BPF
>   perf record: Implement basic filtering for off-cpu
>   perf record: Handle argument change in sched_switch
> 
>  tools/perf/Makefile.perf               |   1 +
>  tools/perf/builtin-record.c            |  21 ++
>  tools/perf/util/Build                  |   1 +
>  tools/perf/util/bpf_off_cpu.c          | 301 +++++++++++++++++++++++++
>  tools/perf/util/bpf_skel/off_cpu.bpf.c | 214 ++++++++++++++++++
>  tools/perf/util/evsel.c                |   4 +-
>  6 files changed, 540 insertions(+), 2 deletions(-)
>  create mode 100644 tools/perf/util/bpf_off_cpu.c
>  create mode 100644 tools/perf/util/bpf_skel/off_cpu.bpf.c
> 
> 
> base-commit: 41204da4c16071be9090940b18f566832d46becc
> -- 
> 2.36.0.rc2.479.g8af0fa9b8e-goog
> 
