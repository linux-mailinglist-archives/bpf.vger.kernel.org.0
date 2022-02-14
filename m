Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1724B4431
	for <lists+bpf@lfdr.de>; Mon, 14 Feb 2022 09:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbiBNIdd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Feb 2022 03:33:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235395AbiBNIdd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Feb 2022 03:33:33 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C462F25C73;
        Mon, 14 Feb 2022 00:33:25 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id f17so25874425edd.2;
        Mon, 14 Feb 2022 00:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=W9b9pCfmFmrcYWsEo+U7cnwY9oLKWpwngvdTkhx16hg=;
        b=TEPb+gl+LBrDrWeECpXrvV9HbmSne6gn677eLSnZZoyywGkWObfq36PLcC3vQqcNzs
         EflhlHehf6pj8adxAF8L+eZP40jHkHqjiXxyKOB/WB3qvCqgGPdm55FqdDiNS13VN7EM
         pIyvZwoj8agUAQX72OwUB2hGT7z5qC3kXjs1qyrx2aC51ShoGvGCtSL4LAnt4fvGwgD+
         zoeh6/cTzyjFRSsxRvbw9cqtKMeVGp6GJGdQtJhVv8IOLcptJ0cQBwQY/KNsvBzwgrCW
         N89HPtpO+rcczKzO84lJBCscR6OeR2YCM0mUbhEii4vIIOPJaOiK3T1iPW2vbjDnI5ph
         IarQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W9b9pCfmFmrcYWsEo+U7cnwY9oLKWpwngvdTkhx16hg=;
        b=GgfxMnhVpKw5o/H1NZ3uNpF0j4OxPxxRjVQj4GV1tk3GZvX5Jru3aSIDO+UkPQhqgj
         spMY3tIfs9tk4EHafRd8ksdoT8V+zs2JTRI4npDQECDh7nzdgqOqcqIGnGP3a8J80ruo
         L9yK99nRYAmZBqmTgOPR3OL7h+nd0E2ERiLCtXApwWYm+YRixsM1afwwFD/Z78xyBvBu
         pC5+F93XFOJ86XXyN72irMZuW3rp//m6eN+bEuroBMhae5lzUxjVyAQ45BnW9qPH3ECL
         yFWsaJgEKn2MdyFclmEynHqNrRk/ozTwoiLt2Mq3CU9049j3BYBQRyB4c4q+B6cex4kG
         cktA==
X-Gm-Message-State: AOAM533pyG5gkbtuV0aOI9F2il7lobb/8YMBGke13qH1F9Eeejbf3sW4
        cMjyZ75QeYXyfUV/BM0N4dk=
X-Google-Smtp-Source: ABdhPJyOEtPOHO89J2Z6+lovDt/ozt46xYC7YQyOhFk5JO1c1J3KVFM6ZmtVQLbUCCAe3NVqDiQ8YA==
X-Received: by 2002:a05:6402:430e:: with SMTP id m14mr14094490edc.86.1644827604195;
        Mon, 14 Feb 2022 00:33:24 -0800 (PST)
Received: from krava ([83.240.63.12])
        by smtp.gmail.com with ESMTPSA id gu2sm10283682ejb.221.2022.02.14.00.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 00:33:23 -0800 (PST)
Date:   Mon, 14 Feb 2022 09:33:21 +0100
From:   Jiri Olsa <olsajiri@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Christy Lee <christylee@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH 1/3] perf/bpf: Remove prologue generation
Message-ID: <YgoT0aUdxOfRSJ/s@krava>
References: <20220123221932.537060-1-jolsa@kernel.org>
 <YgVk8t6COJhDJyzj@kernel.org>
 <YgWEEHFV4U0jhrX8@krava>
 <CAEf4Bza9a5_U2U9ZK_su4VGSA91EMNouipk=PFudGqkN_iGsPg@mail.gmail.com>
 <YgkdmQVN1XSuFDWM@krava>
 <CAEf4BzZO7ZZZv5bdUYY2Fzp0m05gWE9o62Y8=uAuJmUmWsD_hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZO7ZZZv5bdUYY2Fzp0m05gWE9o62Y8=uAuJmUmWsD_hw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Feb 13, 2022 at 09:57:15PM -0800, Andrii Nakryiko wrote:
> On Sun, Feb 13, 2022 at 7:02 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Thu, Feb 10, 2022 at 09:28:51PM -0800, Andrii Nakryiko wrote:
> > > On Thu, Feb 10, 2022 at 1:31 PM Jiri Olsa <olsajiri@gmail.com> wrote:
> > > >
> > > > On Thu, Feb 10, 2022 at 04:18:10PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > > Em Sun, Jan 23, 2022 at 11:19:30PM +0100, Jiri Olsa escreveu:
> > > > > > Removing code for ebpf program prologue generation.
> > > > > >
> > > > > > The prologue code was used to get data for extra arguments specified
> > > > > > in program section name, like:
> > > > > >
> > > > > >   SEC("lock_page=__lock_page page->flags")
> > > > > >   int lock_page(struct pt_regs *ctx, int err, unsigned long flags)
> > > > > >   {
> > > > > >          return 1;
> > > > > >   }
> > > > > >
> > > > > > This code is using deprecated libbpf API and blocks its removal.
> > > > > >
> > > > > > This feature was not documented and broken for some time without
> > > > > > anyone complaining, also original authors are not responding,
> > > > > > so I'm removing it.
> > > > >
> > > > > So, the example below breaks, how hard would be to move the deprecated
> > > > > APIs to perf like was done in some other cases?
> > > > >
> > >
> > > Just copy/pasting libbpf code won't work. But there are three parts:
> > >
> > > 1. bpf_(program|map|object)__set_priv(). There is no equivalent API,
> > > but perf can maintain this private data by building hashmap where the
> > > key is bpf_object/bpf_map/bpf_program pointer itself. Annoying but
> > > very straightforward to replace.
> > >
> > > 2. For prologue generation, bpf_program__set_prep() doesn't have a
> > > direct equivalent. But program cloning and adjustment of the code can
> > > be achieved through bpf_program__insns()/bpf_program__insn_cnt() API
> > > to load one "prototype" program, gets its underlying insns and clone
> > > programs as necessary. After that, bpf_prog_load() would be used to
> > > load those cloned programs into kernel.
> >
> > hm, I can't see how to clone a program.. so we need to end up with
> > several copies of the single program defined in the object.. I can
> > get its intructions with bpf_program__insns, but how do I add more
> > programs with these instructions customized/prefixed?
> 
> You can't add those clones back to bpf_object, of course. But after
> grabbing (and modifying) instructions, you can use bpf_prog_load()
> low-level API to create BPF programs and get their FDs back. You'll
> have to keep track of those prog FDs separately from libbpf' struct
> bpf_object.

ok so loaded on the side with bpf_prog_load

thanks,
jirka
