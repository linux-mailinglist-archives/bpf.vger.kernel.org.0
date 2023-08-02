Return-Path: <bpf+bounces-6691-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B2376C84F
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 10:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA22228195B
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 08:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6AC566E;
	Wed,  2 Aug 2023 08:24:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0BC539E
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 08:24:50 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E878E45
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 01:24:49 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-99bf9252eddso668972766b.3
        for <bpf@vger.kernel.org>; Wed, 02 Aug 2023 01:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690964688; x=1691569488;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HUtyplM9SWkrHcuWOwinwTiD/Z1KJIGmNWfU8Eudvio=;
        b=iL9tgcOmbzAVTDIj+cqb7jaitgRg4E9Pa5hPSGiY+pOZ9GUUhrTgM7GTPDzt4a6F+y
         V1Ibr0HTCDwojuRdkPv2O1p1NGo04unnP3s+y67saAAZdpqGs+VUcH0VZQ59BS6Bmvuf
         cUfg9ghAKUNaM/yOWpcoqvocSle3dxOBBemHrlaOYILLjIL0AAGO3NRMYLvjigfEERCv
         B4aj3IntdlUwUUhOyqomO5mBTJIpmbGbgr/OyfJrM0Sd9uK3c8aTGhRf4GKSsBlR2DIV
         +uJWaVEnZBxnX0kbzC9J9NQ+gk8nFi2c/vgPUFvSdYgORuV45YsiGD81rippi6Rle4Cb
         2QIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690964688; x=1691569488;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HUtyplM9SWkrHcuWOwinwTiD/Z1KJIGmNWfU8Eudvio=;
        b=V8mUKr9eq9bYYvB5/l8E65abnK8TJTpIWo+r7qZnm3kvGjI2+jzHbui03KS+8Z7FaI
         3DHEPU4RFw45S63r5JPZHp8a6EUeBZ71YbdAx9pJonVJ8saeTS8LAboshRcfMLu8LzGh
         cmHGTbuzB5XnkEiYK9jz8cpnRr7COm+ccwfp5rDc3yP4Npfr014eoPenP+9PQl1BHogj
         Tt3ZPsZpcu9Cvn0++DZQs0cigBvAZoeiNF0EJg8zC8sBDtd10x4UewmCBp99kMON6OP4
         +VwS/KS4eCRfD1LttqR3MN2MVCw5ubqwG5eI6+y6L/GNWdaISLTk4H31EwMEP/rK560e
         KMTA==
X-Gm-Message-State: ABy/qLa7RzOGYl8hKHtwRxftf0+issatbHRRhHi0ttPpByw0X6nBYUD/
	SSdZHIQWDu4pxrlO9bBGKgc=
X-Google-Smtp-Source: APBJJlHsc4VuIDNh8Yx0YEfPjDU88frtSEMHJ4FGtNl7wK/AHRoU2vCHDGu+rQ06eLApPi9NIabIOQ==
X-Received: by 2002:a17:906:3f1b:b0:99b:d0dc:7e68 with SMTP id c27-20020a1709063f1b00b0099bd0dc7e68mr3953366ejj.72.1690964687439;
        Wed, 02 Aug 2023 01:24:47 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id p9-20020a1709060dc900b0099bc038eb2bsm8691222eji.58.2023.08.02.01.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 01:24:46 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 2 Aug 2023 10:24:44 +0200
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCHv5 bpf-next 25/28] selftests/bpf: Add uprobe_multi usdt
 bench test
Message-ID: <ZMoSzH/3D447BW+9@krava>
References: <20230730134223.94496-1-jolsa@kernel.org>
 <20230730134223.94496-26-jolsa@kernel.org>
 <CAADnVQKdrMo+sMNbuKZt1HU5RXN7qfN+kEyTWXtN3U5uvGRjrQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKdrMo+sMNbuKZt1HU5RXN7qfN+kEyTWXtN3U5uvGRjrQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 01, 2023 at 10:51:35AM -0700, Alexei Starovoitov wrote:
> On Sun, Jul 30, 2023 at 6:46 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding test that attaches 50k usdt probes in usdt_multi binary.
> >
> > After the attach is done we run the binary and make sure we get
> > proper amount of hits.
> >
> > With current uprobes:
> >
> >   # perf stat --null ./test_progs -n 254/6
> >   #254/6   uprobe_multi_test/bench_usdt:OK
> >   #254     uprobe_multi_test:OK
> >   Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
> >
> >    Performance counter stats for './test_progs -n 254/6':
> >
> >       1353.659680562 seconds time elapsed
> >
> > With uprobe_multi link:
> >
> >   # perf stat --null ./test_progs -n 254/6
> >   #254/6   uprobe_multi_test/bench_usdt:OK
> >   #254     uprobe_multi_test:OK
> >   Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
> >
> >    Performance counter stats for './test_progs -n 254/6':
> >
> >          0.322046364 seconds time elapsed
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  .../bpf/prog_tests/uprobe_multi_test.c        | 39 +++++++++++++++++++
> >  .../selftests/bpf/progs/uprobe_multi_usdt.c   | 16 ++++++++
> >  2 files changed, 55 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_usdt.c
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> > index 56c2062af1c9..19a66431a61f 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> > @@ -4,6 +4,7 @@
> >  #include <test_progs.h>
> >  #include "uprobe_multi.skel.h"
> >  #include "uprobe_multi_bench.skel.h"
> > +#include "uprobe_multi_usdt.skel.h"
> >  #include "bpf/libbpf_internal.h"
> >  #include "testing_helpers.h"
> >
> > @@ -234,6 +235,42 @@ static void test_bench_attach_uprobe(void)
> >         printf("%s: detached in %7.3lfs\n", __func__, detach_delta);
> >  }
> >
> > +static void test_bench_attach_usdt(void)
> > +{
> > +       struct uprobe_multi_usdt *skel = NULL;
> > +       long attach_start_ns, attach_end_ns;
> > +       long detach_start_ns, detach_end_ns;
> > +       double attach_delta, detach_delta;
> > +
> > +       skel = uprobe_multi_usdt__open_and_load();
> > +       if (!ASSERT_OK_PTR(skel, "uprobe_multi__open"))
> > +               goto cleanup;
> > +
> > +       attach_start_ns = get_time_ns();
> > +
> > +       skel->links.usdt0 = bpf_program__attach_usdt(skel->progs.usdt0, -1, "./uprobe_multi",
> > +                                                    "test", "usdt", NULL);
> > +       if (!ASSERT_OK_PTR(skel->links.usdt0, "bpf_program__attach_usdt"))
> > +               goto cleanup;
> > +
> > +       attach_end_ns = get_time_ns();
> > +
> > +       system("./uprobe_multi usdt");
> > +
> > +       ASSERT_EQ(skel->bss->count, 50000, "usdt_count");
> > +
> > +cleanup:
> > +       detach_start_ns = get_time_ns();
> > +       uprobe_multi_usdt__destroy(skel);
> > +       detach_end_ns = get_time_ns();
> > +
> > +       attach_delta = (attach_end_ns - attach_start_ns) / 1000000000.0;
> > +       detach_delta = (detach_end_ns - detach_start_ns) / 1000000000.0;
> > +
> > +       printf("%s: attached in %7.3lfs\n", __func__, attach_delta);
> > +       printf("%s: detached in %7.3lfs\n", __func__, detach_delta);
> > +}
> 
> It fails CI.
> /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c:338:6:
> error: variable 'attach_start_ns' is used uninitialized whenever 'if'
> condition is true [-Werror,-Wsometimes-uninitialized]
> if (!ASSERT_OK_PTR(skel, "uprobe_multi__open"))

hum, one more change is needed.. will fix

thanks,
jirka

