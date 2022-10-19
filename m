Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F73C603902
	for <lists+bpf@lfdr.de>; Wed, 19 Oct 2022 06:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiJSE5f (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Oct 2022 00:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiJSE5e (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Oct 2022 00:57:34 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565DB6704F;
        Tue, 18 Oct 2022 21:57:31 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id y14so37163232ejd.9;
        Tue, 18 Oct 2022 21:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=35peG0IP4JiPLGxzfXqI/wQBb35mxDEhGOgvcGpqSyc=;
        b=ZpI/bfSYkwg3sOORo0rZ+97ajfBfrUv07EUG4Z6ePd39nqsw7CORsekgXvDesNnoyy
         2qN+GHiYzSb9mNJIprV+uaUPVIqSRhEHPXQ6FdcUGqkPrY5A8JXXQGLfR6CxHzidA79/
         JVvGDL/k6wZOVuE4TyyqZabwGlRsxkpBxyqFQWnfRL4seu/JrO436voU6pfqdF6evLmj
         St3fXSbxAFCCR36wOfJLcYQ/k6yUs7k783B83+qSKtw+2gRbufgm5D0Lpj7j9y6FXvZf
         f+MEBtMmR53AT+DBh7L2XfoPO6jg9KhGpsOMUR0TyDVwjP7v7GhL/8t4WyjcV6b5rdLp
         aVQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=35peG0IP4JiPLGxzfXqI/wQBb35mxDEhGOgvcGpqSyc=;
        b=W+J8sagKtr4RuTkYulbAw7dgsut5JpF2NBpHUaSEoegnQCl9FdzgPEyQLeQeZVy+7Q
         H43At41LZsZz26NV8VWWCuPK1XZOajDnVzoFXnmqCXGQ5xZARlNEhTJeWaYM/AaShiOe
         qDk4ivTXKa1nx2uCKETlKEjRJUxI4J/nBxwtJbYvq10LcpVA999TPiCEUNE2Htv++lSi
         4lfs9sWsVTrXPss7jUtCSr6RH3U0Vm3PVpYNta1KkFdJxEGx9pU7l1Q0l7zn8rpXTtCC
         Rg4ieeApQKYlZeuQo7y38OahsqRBvKMRZt1TE8P8SzQIKoMwgnSafTO0Heg/6XKQSNwp
         r5GQ==
X-Gm-Message-State: ACrzQf0p1HE3jrvVDFVQDUQ8kDuVPYCs1099gx+PcxCm6SYDUEmecdMs
        i7vZ3pDNcmASA9NZVHlM5IRqAQ9vPsUuNYaR16E=
X-Google-Smtp-Source: AMsMyM4QOsMkvlYidGnoGdGzD7kUE35SaXqpI7fQcpzl0796XYfe08z7lt/M19jrzA7TXR5ngJwzLJViIzExG6nghQ4=
X-Received: by 2002:a17:907:1c98:b0:78d:3b06:dc8f with SMTP id
 nb24-20020a1709071c9800b0078d3b06dc8fmr5006085ejc.58.1666155449729; Tue, 18
 Oct 2022 21:57:29 -0700 (PDT)
MIME-Version: 1.0
References: <Yz8lbkx3HYQpnvIB@krava> <20221007081327.1047552-1-sumanthk@linux.ibm.com>
 <Yz/1QNGfO39Y7dOJ@krava> <Y0BDWK7cl83Fkwqz@hirez.programming.kicks-ass.net>
In-Reply-To: <Y0BDWK7cl83Fkwqz@hirez.programming.kicks-ass.net>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 18 Oct 2022 21:57:18 -0700
Message-ID: <CAADnVQJ0ur6Pox9aTjoSkXs43strqN__e1h4JWya46WOER9V4w@mail.gmail.com>
Subject: Re: [PATCH] bpf: fix sample_flags for bpf_perf_event_output
To:     Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        bpf <bpf@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        X86 ML <x86@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 7, 2022 at 8:31 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Oct 07, 2022 at 11:45:36AM +0200, Jiri Olsa wrote:
> > On Fri, Oct 07, 2022 at 10:13:27AM +0200, Sumanth Korikkar wrote:
> > > * Raw data is also filled by bpf_perf_event_output.
> > > * Add sample_flags to indicate raw data.
> > > * This eliminates the segfaults as shown below:
> > >   Run ./samples/bpf/trace_output
> > >   BUG pid 9 cookie 1001000000004 sized 4
> > >   BUG pid 9 cookie 1001000000004 sized 4
> > >   BUG pid 9 cookie 1001000000004 sized 4
> > >   Segmentation fault (core dumped)
> > >
> > > Fixes: 838d9bb62d13 ("perf: Use sample_flags for raw_data")
> > > Acked-by: Namhyung Kim <namhyung@kernel.org>
> > > Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> >
> > Acked-by: Jiri Olsa <jolsa@kernel.org>
> >
> > Peter,
> > I think this should go through your tree again?
> > bpf-next/master does not have sample_flags merged yet
>
> Yep can do. I'll line it up in perf/urgent (Ingo just send out
> perf/core).

Peter,

Could you please hurry up. 11 days have passed.

This issue affects everyone the hard way now after merging
all the trees: tip -> linus -> net-next -> bpf-next.
The BPF CI is red right now with 5 tests failing because
this fix is still missing.
It's causing a headache to maintainers and developers.
