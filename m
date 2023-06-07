Return-Path: <bpf+bounces-2049-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A50137272E0
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 01:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1B642815EF
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 23:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D41C3B40B;
	Wed,  7 Jun 2023 23:22:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AFD3B3E0
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 23:22:51 +0000 (UTC)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2E42696
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 16:22:44 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-64d18d772bdso8766331b3a.3
        for <bpf@vger.kernel.org>; Wed, 07 Jun 2023 16:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686180163; x=1688772163;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/SIMJXbLGQj8207/g+qg5WK9QyDC2H9VR1RDNGdLAvE=;
        b=hbqvc0KeXXj9WEAHWW6HMDPpIEk7UvaepZFqYh+BTXpDQHreGPL8Q9PyCBV+Qdx+rv
         Wv+ozBPuNEPG2wfDibwDMI+q0dtrNxyBftRr1zY+W5eoXTPZ8IrZ++N2u6poNYVEMjQm
         1doo9l2no3dCA5b5pSMpFiKtIrRB5Toyf4uhUlF/vnyIiQjgY0qrho/uLk/ycHs+sWVD
         bdHz53sQBpQNl5rw0xNYl0sZnO7H48VA/M2azsBSUBoayy1OrOYxtjQ1q9biNHMWzeRU
         Ns48iDMo4yHG6ogR9iGzar1qv+jsB6/dg78fsuvB8Z7cjjgHdK0ZYSFoRnk9kpXdSVqJ
         QQeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686180163; x=1688772163;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/SIMJXbLGQj8207/g+qg5WK9QyDC2H9VR1RDNGdLAvE=;
        b=Yg3nztwfX5EtF60WGsCk4zJV9Y2miXhM5bfPVl4pJWBKbZoMY25Uj70rwAW3M9K12u
         9dXBMkPozv0Su7WubcUk4eeq0Hm6JZ0N+/Lf9SY20u6F6qSEILe7FmisUzMaxI8OFx58
         Ej287Fgu0MYefkrvc3uwqjWjJxVwd0Rajy0N/9KtxUInHIIgUgWsfN24pqT7q/LQgruu
         TgRfYd0ayXlfMyi7qR8FEmlF3mL3l+5gyLd1t36CwCEyM2satxWTy/Za1ipBF++iUZtI
         IZ9Lz5O08CvDDnqqR3DvsETxpdV/yMXr8aJaQMtU2VEbeSKkDzCziC2EHAWlovIHzAX1
         tvxA==
X-Gm-Message-State: AC+VfDyFm6M/LNVViC2UybTF8mFI7C1OxcpEjS/c5a6uYxP9GrwGm45a
	JP9oSaYG0aYjLvuPda6QbSE=
X-Google-Smtp-Source: ACHHUZ5YOD5aTKxq9XjMyYMgZEBYSE5YRqCjj0rmKMQftvskO8nhrN/aaQKRJ0PN6SYqQj/kxiyCAg==
X-Received: by 2002:a05:6a20:7484:b0:111:3998:7dd0 with SMTP id p4-20020a056a20748400b0011139987dd0mr5287256pzd.17.1686180163469;
        Wed, 07 Jun 2023 16:22:43 -0700 (PDT)
Received: from krava (c-67-160-222-115.hsd1.ca.comcast.net. [67.160.222.115])
        by smtp.gmail.com with ESMTPSA id l13-20020a62be0d000000b0064b0326494asm8830616pff.150.2023.06.07.16.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 16:22:43 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 7 Jun 2023 16:22:40 -0700
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jackie Liu <liu.yun@linux.dev>, olsajiri@gmail.com, andrii@kernel.org,
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
	bpf@vger.kernel.org, liuyun01@kylinos.cn
Subject: Re: [PATCH v4] libbpf: kprobe.multi: Filter with
 available_filter_functions
Message-ID: <ZIERQNxgXWvgxHNO@krava>
References: <ZG8f7ffghG7mLUhR@krava>
 <20230525102747.68708-1-liu.yun@linux.dev>
 <CAEf4Bzae7mdpCDBEafG-NUCPRohWkC8EBs0+twE2hUbB8LqWJA@mail.gmail.com>
 <b2273217-5adb-8ec6-288b-4f8703a56386@linux.dev>
 <CAEf4BzbGtZJvS-8=6i3g5A9uJm9_LHVRRbye-OLTdgeWZtdrsw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbGtZJvS-8=6i3g5A9uJm9_LHVRRbye-OLTdgeWZtdrsw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 02, 2023 at 10:27:31AM -0700, Andrii Nakryiko wrote:
> On Thu, May 25, 2023 at 6:38 PM Jackie Liu <liu.yun@linux.dev> wrote:
> >
> > Hi Andrii.
> >
> > 在 2023/5/26 04:43, Andrii Nakryiko 写道:
> > > On Thu, May 25, 2023 at 3:28 AM Jackie Liu <liu.yun@linux.dev> wrote:
> > >>
> > >> From: Jackie Liu <liuyun01@kylinos.cn>
> > >>
> > >> When using regular expression matching with "kprobe multi", it scans all
> > >> the functions under "/proc/kallsyms" that can be matched. However, not all
> > >> of them can be traced by kprobe.multi. If any one of the functions fails
> > >> to be traced, it will result in the failure of all functions. The best
> > >> approach is to filter out the functions that cannot be traced to ensure
> > >> proper tracking of the functions.
> > >>
> > >> Use available_filter_functions check first, if failed, fallback to
> > >> kallsyms.
> > >>
> > >> Here is the test eBPF program [1].
> > >> [1] https://github.com/JackieLiu1/ketones/commit/a9e76d1ba57390e533b8b3eadde97f7a4535e867
> > >>
> > >> Suggested-by: Jiri Olsa <olsajiri@gmail.com>
> > >> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> > >> ---
> > >>   tools/lib/bpf/libbpf.c | 92 +++++++++++++++++++++++++++++++++++++-----
> > >>   1 file changed, 83 insertions(+), 9 deletions(-)
> > >>
> > >
> > > Question to you and Jiri: what happens when multi-kprobe's syms has
> > > duplicates? Will the program be attached multiple times? If yes, then
> > > it sounds like a problem? Both available_filters and kallsyms can have
> > > duplicate function names in them, right?
> >
> > If I understand correctly, there should be no problem with repeated
> > function registration, because the bottom layer is done through fprobe
> > registration addrs, kprobe.multi itself does not do this work, but
> > fprobe is based on ftrace, it will register addr by makes a hash,
> > that is, if it is the same address, it should be filtered out.
> >
> 
> Looking at kernel code, it seems kernel will actually return error if
> user specifies multiple duplicated names. Because kernel will
> bsearch() to the first instance, and never resolve the second
> duplicated instance. And then will assume that not all symbols are
> resolved.

right, as I wrote in here [1] it will fail

[1] https://lore.kernel.org/bpf/ZHB0xNEbjmwHv18d@krava/

> 
> So, it worries me that we'll switch from kallsyms to available_filters
> by default, because that introduces new failure modes.

we did not care about duplicate with kallsyms because we used addresses,
and I think with duplicate addresss the kprobe_multi link will probably
attach (need to check) while with duplicate symbols it won't..

perhaps we could make sure we don't pass duplicate symbols?

we do the kprobe_multi bench with symbol names read from available_filter_functions
and we filter out duplicates

jirka

> 
> Either way, let's add a selftest that uses a duplicate function name
> and see what happens?
> 
> > The main problem here is not the problem of repeated registration of
> > functions, but some functions are not allowed to hook. For example, when
> > I track vfs_*, vfs_set_acl_prepare_kgid and vfs_set_acl_prepare_kuid are
> > not allowed to hook. These exist under kallsyms, but
> > available_filter_functions does not, I have observed for a while,
> > matching through available_filter_functions can effectively prevent this
> > from happening.
> 
> Yeah, I understand that. My point above is that a)
> available_filter_functions contains duplicates and b) doesn't contain
> addresses. So we are forced to rely on kernel string -> addr
> resolution, which doesn't seem to handle duplicate entries well (let's
> test).
> 
> So it's a regression to switch to that without taking any other precautions.
> 
> >
> > >
> > >> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > >> index ad1ec893b41b..3dd72d69cdf7 100644
> > >> --- a/tools/lib/bpf/libbpf.c
> > >> +++ b/tools/lib/bpf/libbpf.c
> > >> @@ -10417,13 +10417,14 @@ static bool glob_match(const char *str, const char *pat)
> > >>   struct kprobe_multi_resolve {
> > >>          const char *pattern;
> > >>          unsigned long *addrs;
> > >> +       const char **syms;
> > >>          size_t cap;
> > >>          size_t cnt;
> > >>   };
> > >>
> 
> [...]

