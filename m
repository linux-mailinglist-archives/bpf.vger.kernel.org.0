Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688126BF8FE
	for <lists+bpf@lfdr.de>; Sat, 18 Mar 2023 09:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjCRIeR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 18 Mar 2023 04:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjCRIeQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 18 Mar 2023 04:34:16 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EDF90797;
        Sat, 18 Mar 2023 01:34:12 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id w11so3536338wmo.2;
        Sat, 18 Mar 2023 01:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679128450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IAwD34h/OR3i3A5T4/iVtj4bFuK5KpGaAWZE6okZa44=;
        b=oBS8WOmu7YIDUWHqFvE/fS7jKf9hfbjBtL5s7f5hhQi6MTlTn/f/ZhngsXnXXGk1MQ
         196LcZ0kxYFjkBoe3cNgFDpRyQETqJKw+Stdl+NzB9bLaqVZ7j+VHxaYgEM9h8hJN9Wf
         jVU/1gdrAjwHFDoEDQTXeWX+WK8Nk67sO2myGzSBDZp70isYDPJQDvkCeVHFj+RZcT2j
         ykV/vz1LvRuuwgja+QHiV0ZLIwTFH1/hxTXhKDHpsQ73u2sYLtS03LC6qQOm2DXHR6hM
         sMB+R9WrrnJg88qejqvkajSCLRQFThbR/68Xo2iFruRP2zs/5e9jgAiFLvcCZjSsQPUF
         Tqpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679128450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IAwD34h/OR3i3A5T4/iVtj4bFuK5KpGaAWZE6okZa44=;
        b=3P/sVsOdAlpe5+fFucEuw8ZTGLPwcTwqZqxS30EBOKCA+tFTM0s7SFadMg8SPRma/r
         L4JNY4pGpjMyvejr++eTvowWD1ulgKAarwk65AGREzzfhZwkXdb0xr8tBflyJsxANeKP
         kDq2lOtbiJNysb08zB8AfXspedX7yuIx1KEriJhUu6hOGcZUrywhYL2PkyBSMqy2AkfC
         PLEh/68JriD8bnWErMMVVgqZgvXLihWSIr/DGnCBgvuR78X/+H8ND4tAlpKITv887SjL
         j1DTSMiMTah5mNIUqsVxUv1FOjcOlo26JozymDR3LWEe3VEvpPBZup721p1quSnIgbjx
         WZeg==
X-Gm-Message-State: AO0yUKWa8jm+oDw9KKp4uRo+WjdUwv8NjtMOSzpFVvWvNd23Wg7X+STU
        Mb2puhvKX6V1GhKJsaeOKUU=
X-Google-Smtp-Source: AK7set9hn+u/qdIBUzB7AochpnvZos9W3Ofl0dnvwk/TIEMDl5Ld0oUM8Oo8fYzs0HVqTAFXPv3J6g==
X-Received: by 2002:a05:600c:4f07:b0:3ed:3cec:d2ec with SMTP id l7-20020a05600c4f0700b003ed3cecd2ecmr9784588wmq.15.1679128450203;
        Sat, 18 Mar 2023 01:34:10 -0700 (PDT)
Received: from krava (net-93-147-243-166.cust.vodafonedsl.it. [93.147.243.166])
        by smtp.gmail.com with ESMTPSA id t1-20020a7bc3c1000000b003e1f2e43a1csm4073432wmj.48.2023.03.18.01.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 01:34:09 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Sat, 18 Mar 2023 09:34:05 +0100
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Ian Rogers <irogers@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Hao Luo <haoluo@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        bpf@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Namhyung Kim <namhyung@gmail.com>,
        Dave Chinner <david@fromorbit.com>, kernel-team@meta.com
Subject: Re: [PATCHv3 bpf-next 0/9] mm/bpf/perf: Store build id in file object
Message-ID: <ZBV3fRGcymXjcuRr@krava>
References: <20230316170149.4106586-1-jolsa@kernel.org>
 <ZBNTMZjEoETU9d8N@casper.infradead.org>
 <CAP-5=fVYriALLwF2FU1ZUtLuHndnvPw=3SctVqY6Uwex8JfscA@mail.gmail.com>
 <CAEf4BzYgyGTVv=cDwaW+DBke1uk_aLCg3CB_9W6+9tkS8Nyn_Q@mail.gmail.com>
 <ZBPjs1b8crUv4ur6@casper.infradead.org>
 <CAEf4BzbPa-5b9uU0+GN=iaMGc6otje3iNQd+MOg_byTSYU8fEQ@mail.gmail.com>
 <20230317211403.GZ3390869@ZenIV>
 <20230317212125.GA3390869@ZenIV>
 <CAEf4BzYQ-bktO9s8yhBk7xUoz=2NFrgdGviWsN2=HWPBaGv6hA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYQ-bktO9s8yhBk7xUoz=2NFrgdGviWsN2=HWPBaGv6hA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 17, 2023 at 11:08:44PM -0700, Andrii Nakryiko wrote:

SNIP

> > > That does depend upon the load, obviously, but it's not hard to collect -
> > > you already have more than enough hooks inserted in the relevant places.
> > > That might give a better appreciation of the reactions...
> >
> > One possibility would be a bit stolen from inode flags + hash keyed by
> > struct inode address (middle bits make for a decent hash function);
> > inode eviction would check that bit and kick the corresponding thing
> > from hash if the bit is set.
> >
> > Associating that thing with inode => hash lookup/insert + set the bit.
> 
> This is an interesting idea, but now we are running into a few
> unnecessary problems. We need to have a global dynamically sized hash
> map in the system. If we fix the number of buckets, we risk either
> wasting memory on an underutilized system (if we oversize), or
> performance problems due to collisions (if we undersize) if we have a
> busy system with lots of executables mapped in memory. If we don't
> pre-size, then we are talking about reallocations, rehashing, and
> doing that under global lock or something like that. Further, we'd
> have to take locks on buckets, which causes further problems for
> looking up build ID from this hashmap in NMI context for perf events
> and BPF programs, as locks can't be safely taken under those
> conditions, and thus fetching build ID would still be unreliable
> (though less so than it is today, of course).
> 
> All of this is solvable to some degree (but not perfectly and not with
> simple and elegant approaches), but seems like an unnecessarily
> overcomplication compared to the amount of memory that we hope to
> save. It still feels like a Kconfig-guarded 8 byte field per struct
> file is a reasonable price for gaining reliable build ID information
> for profiling/tracing tools.
> 
> 
>   [0] https://drgn.readthedocs.io/en/latest/index.html
> 
>   [1] Script I used:
> 
> from drgn.helpers.linux.pid import for_each_task
> from drgn.helpers.linux.fs import for_each_file
> 
> task_cnt = 0
> file_set = set()
> 
> for task in for_each_task(prog):
>     task_cnt += 1
>     try:
>         for (fd, file) in for_each_file(task):
>             file_set.add(file.value_())
>     except:
>         pass
> 
> uniq_file_cnt = len(file_set)
> print(f"task_cnt={task_cnt} uniq_file_cnt={uniq_file_cnt}")

great you beat me to this, I wouldn't have thought of using drgn for this ;-)
I'll see if I can install it to some of our test servers

thanks,
jirka
