Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22346BB765
	for <lists+bpf@lfdr.de>; Wed, 15 Mar 2023 16:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbjCOPSA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Mar 2023 11:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbjCOPR7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Mar 2023 11:17:59 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030D130B35
        for <bpf@vger.kernel.org>; Wed, 15 Mar 2023 08:17:57 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 624F1240808
        for <bpf@vger.kernel.org>; Wed, 15 Mar 2023 16:17:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1678893476; bh=8rSkPd2SvPuVFTNw3k5jVgWFHOG7GEQwDShYxmPrqwc=;
        h=Date:From:To:Cc:Subject:From;
        b=YBNnXaTKfcguT7GKrH6okiXmV61OYTQ467FXJWzNJVjHA8HFs1x6bImKtrhkLmn+E
         Wuo/dd7gwjMKa9GHRrrmv1J6+dfCz+cZnO6RteFDlTupwVnwJYoCsovZQLl9UJL0gN
         rcC2c9u9w5MiH/DVYFtv+JrAnFxgzrF3IA+H7nWAluf4WSJ0QPO7PaO/rh9KCB+xqf
         OmvPs5nQZlpfzHYMmry1wKwoeE+r1S+hYvsEL+MwIqwJ1b/P61gDGKSbJvskOrThsi
         hmJMJR11XrAgEOjz2JSE/MmpYxh9WyoNGExAvhyTO7JS9x19+toCTNkKSMBh5+8bXM
         65lHAwyYExoKw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4PcDXt6Yxjz6tn0;
        Wed, 15 Mar 2023 16:17:50 +0100 (CET)
Date:   Wed, 15 Mar 2023 15:17:42 +0000
From:   Daniel =?utf-8?Q?M=C3=BCller?= <deso@posteo.net>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Ian Rogers <irogers@google.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, lkft-triage@lists.linaro.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: Re: next: zip.c:35:8: error: packed attribute causes inefficient
 alignment for 'magic' [-Werror=attributes]
Message-ID: <20230315151742.ydv7dw6agaeqxcj5@nuc>
References: <CA+G9fYtBnwxAWXi2+GyNByApxnf_DtP1-6+_zOKAdJKnJBexjg@mail.gmail.com>
 <CAEf4Bzb9_5KvWKxEAgz0V_OS0+h6PQN_Pir_rfrcviu2O80cqQ@mail.gmail.com>
 <CAP-5=fXURWoZu2j6Y8xQy23i7=DfgThq3WC1RkGFBx-4moQKYQ@mail.gmail.com>
 <CAEf4BzaSD_9pdaSzfcinAEapzzHK2vYytHhk39jpepkCKOBVwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzaSD_9pdaSzfcinAEapzzHK2vYytHhk39jpepkCKOBVwQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 14, 2023 at 04:56:15PM -0700, Andrii Nakryiko wrote:
> On Tue, Mar 14, 2023 at 1:01 PM Ian Rogers <irogers@google.com> wrote:
> >
> > On Tue, Mar 14, 2023 at 11:52 AM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Mon, Mar 13, 2023 at 11:38 PM Naresh Kamboju
> > > <naresh.kamboju@linaro.org> wrote:
> > > >
> > > > perf builds failing from Linux next-20230307..next-20230314 but pass on
> > > > Linux mainline v6.3-rc2.
> > > >
> > > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > >
> > > Thanks for the report, but I'm not sure what's wrong here. We added
> > > __attribute__((packed)) attribute intentionally and want to keep it
> > > this way. It seems like perf itself is using packed structs (e.g.,
> > > struct debug_line_header in util/genelf_debug.c), so I'm wondering why
> > > that code doesn't cause any problems.
> > >
> > > Any hints from perf folks?
> >
> > We use a #pragma to disable the warnings in at least one place:
> > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/lib/perf/include/perf/event.h?h=perf-tools#n194
> >
> 
> Ok, let's do the same here. Daniel, can you please send a follow up
> patch to silence this warning?

Sounds good.

Thanks,
Daniel
