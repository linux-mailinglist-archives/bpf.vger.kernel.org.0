Return-Path: <bpf+bounces-4747-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E0574E9D5
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 11:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70769281189
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 09:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BDD1774F;
	Tue, 11 Jul 2023 09:07:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D74E17723
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 09:07:07 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E96122
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 02:07:06 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-98dfb3f9af6so714272466b.2
        for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 02:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689066425; x=1691658425;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IvbJcxeS+G7KVdeePtf5xW0khBK4V6qPT7xdpSt0hQw=;
        b=bpccFnF6aDsxsR4mOv0s/EHLlhQ+EW8WCr228vcu1mLrjy3tyo2yYqMkJb4+OOEM6t
         11WzYHzbhjWEdGtKF0Mvcr9fiVutd/tEaG5FP4+/QrkY1Ea0GwzmgckP4VwHk9r0HC+X
         F0OBow1CW0j7jp06iMLbkBjt+QeGg1aL7cLKIBTYvx/YM+x09gL2oUIvdaoc0nXpkM4d
         D1xN0+Vt1Fmh7cVXQWzAWerti1MQJrtTns8+ZgHvYbH7RmiioML1AkFR3hebSnxV3N5M
         P15CsTC3YRPxvm56G3T2iW/HkjZWzSouq0jN3Nn6lyzxhaoEqGFR9aRCroNrUrWPYXUc
         sZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689066425; x=1691658425;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IvbJcxeS+G7KVdeePtf5xW0khBK4V6qPT7xdpSt0hQw=;
        b=cyXOVC/tIx+95BhQEveePC/9S8L2QQPCR2YRPd/c3p3ef7GhIyvz6mHf+OVhwH+2Jk
         Ipj+lEFTHCfKrNZSNPXCMnvrc2kPgkyjp0xoKRJsP8wwvWh7yn65tL9OZ6S821WoGSpu
         NVjXDut4ozS9yYPOKZUtY9tM1cWi6oMuIfXLjwh1hkvkRrPQN7J0K9RABLTZKkORcyWv
         v6Dsuy3hlQSYzYrUU1ye06bl3ePfUtJsswQye2lLoehHtPfuWLRowTxeaw2Q2Jsga/ff
         LB2TmFGtKSxeDohmy4Bl7l6fhqTGiBTcfcPjizp0juFcjDaLH0Q2Kxs3q6Br/n8a1+cv
         hkRg==
X-Gm-Message-State: ABy/qLaQU7N9KTtCsH5CbpDMUhpDmWk90Opaa5iknKEenYMzrYnLzUpV
	Gk0KE4ZdNjwxtMysXHT4c6M=
X-Google-Smtp-Source: APBJJlHMy1HmMo4sfupX0Jv9fZksG6ZIf+18zBBa787avCCG3lvfMQcW1j3kZBRllOFlNfsJwqYdxA==
X-Received: by 2002:a17:906:9bf3:b0:992:91ce:4508 with SMTP id de51-20020a1709069bf300b0099291ce4508mr14858482ejc.53.1689066424573;
        Tue, 11 Jul 2023 02:07:04 -0700 (PDT)
Received: from krava (net-109-116-206-239.cust.vodafonedsl.it. [109.116.206.239])
        by smtp.gmail.com with ESMTPSA id f21-20020a1709064dd500b0098951bb4dc3sm865461ejw.184.2023.07.11.02.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 02:07:04 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 11 Jul 2023 11:07:01 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCHv3 bpf-next 21/26] selftests/bpf: Add uprobe_multi bench
 test
Message-ID: <ZK0bteQwo7NPRDi4@krava>
References: <20230630083344.984305-1-jolsa@kernel.org>
 <20230630083344.984305-22-jolsa@kernel.org>
 <CAEf4BzYrKXWskLfHY+FOLWjNMvm_ujvmHVB6ai8zrMevFXEg2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYrKXWskLfHY+FOLWjNMvm_ujvmHVB6ai8zrMevFXEg2Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 06, 2023 at 09:38:20PM -0700, Andrii Nakryiko wrote:
> On Fri, Jun 30, 2023 at 1:38 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding test that attaches 50k uprobes in uprobe_multi binary.
> >
> > After the attach is done we run the binary and make sure we
> > get proper amount of hits.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  .../bpf/prog_tests/uprobe_multi_test.c        | 56 +++++++++++++++++++
> >  .../selftests/bpf/progs/uprobe_multi.c        |  9 +++
> >  2 files changed, 65 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> > index fd858636b8b0..547d46965d70 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> > @@ -202,6 +202,60 @@ static void test_link_api(void)
> >         free(offsets);
> >  }
> >
> > +static inline __u64 get_time_ns(void)
> > +{
> > +       struct timespec t;
> > +
> > +       clock_gettime(CLOCK_MONOTONIC, &t);
> > +       return (__u64) t.tv_sec * 1000000000 + t.tv_nsec;
> > +}
> > +
> 
> hmm.. I would expect we have this helper somewhere in common headers.
> If not, we should probably move all such helpers into one header and
> use it everywhere

hum, now I see it's also defined in bench.h, I'll try to use it from
there ;-) also perhaps in kprobe multi test

> 
> > +static void test_bench_attach_uprobe(void)
> > +{
> > +       long attach_start_ns, attach_end_ns;
> > +       long detach_start_ns, detach_end_ns;
> > +       double attach_delta, detach_delta;
> > +       struct uprobe_multi *skel = NULL;
> > +       struct bpf_program *prog;
> > +       int err;
> > +
> > +       skel = uprobe_multi__open();
> > +       if (!ASSERT_OK_PTR(skel, "uprobe_multi__open"))
> > +               goto cleanup;
> > +
> > +       bpf_object__for_each_program(prog, skel->obj)
> > +               bpf_program__set_autoload(prog, false);
> > +
> > +       bpf_program__set_autoload(skel->progs.test_uprobe_bench, true);
> 
> I don't get why you bothered adding this test_uprobe_bench into
> progs/uprobe_multi and go through this manual auto-load
> setting/resetting, instead of just having test_uprobe_bench in a
> separate skeleton?...

ok, will add separate file for that.. will be simpler

> 
> > +
> > +       err = uprobe_multi__load(skel);
> > +       if (!ASSERT_EQ(err, 0, "uprobe_multi__load"))
> > +               goto cleanup;
> > +
> > +       attach_start_ns = get_time_ns();
> > +
> > +       err = uprobe_multi__attach(skel);
> > +       if (!ASSERT_OK(err, "uprobe_multi__attach"))
> > +               goto cleanup;
> > +
> > +       attach_end_ns = get_time_ns();
> > +
> > +       system("./uprobe_multi");
> > +
> > +       ASSERT_EQ(skel->bss->count, 50000, "uprobes_count");
> > +
> > +cleanup:
> > +       detach_start_ns = get_time_ns();
> > +       uprobe_multi__destroy(skel);
> > +       detach_end_ns = get_time_ns();
> > +
> > +       attach_delta = (attach_end_ns - attach_start_ns) / 1000000000.0;
> > +       detach_delta = (detach_end_ns - detach_start_ns) / 1000000000.0;
> > +
> > +       printf("%s: attached in %7.3lfs\n", __func__, attach_delta);
> > +       printf("%s: detached in %7.3lfs\n", __func__, detach_delta);
> 
> and for us lazy folks, what are the numbers you see on your machine?

right, will put it to the changelog

	# ./test_progs -n 260/5 -v
	bpf_testmod.ko is already unloaded.
	Loading bpf_testmod.ko...
	Successfully loaded bpf_testmod.ko.
	test_bench_attach_uprobe:PASS:uprobe_multi__open 0 nsec
	test_bench_attach_uprobe:PASS:uprobe_multi__load 0 nsec
	test_bench_attach_uprobe:PASS:uprobe_multi__attach 0 nsec
	test_bench_attach_uprobe:PASS:uprobes_count 0 nsec
	test_bench_attach_uprobe: attached in   0.398s
	test_bench_attach_uprobe: detached in   0.443s
	#260/5   uprobe_multi_test/bench_uprobe:OK
	#260     uprobe_multi_test:OK
	Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
	Successfully unloaded bpf_testmod.ko.

thanks,
jirka

> 
> > +}
> > +
> >  void test_uprobe_multi_test(void)
> >  {
> >         if (test__start_subtest("skel_api"))
> > @@ -212,4 +266,6 @@ void test_uprobe_multi_test(void)
> >                 test_attach_api_syms();
> >         if (test__start_subtest("link_api"))
> >                 test_link_api();
> > +       if (test__start_subtest("bench_uprobe"))
> > +               test_bench_attach_uprobe();
> >  }
> > diff --git a/tools/testing/selftests/bpf/progs/uprobe_multi.c b/tools/testing/selftests/bpf/progs/uprobe_multi.c
> > index 1eeb9b7b9cad..cd73139dc881 100644
> > --- a/tools/testing/selftests/bpf/progs/uprobe_multi.c
> > +++ b/tools/testing/selftests/bpf/progs/uprobe_multi.c
> > @@ -89,3 +89,12 @@ int test_uretprobe_sleep(struct pt_regs *ctx)
> >         uprobe_multi_check(ctx, true, true);
> >         return 0;
> >  }
> > +
> > +int count;
> > +
> > +SEC("?uprobe.multi/./uprobe_multi:uprobe_multi_func_*")
> > +int test_uprobe_bench(struct pt_regs *ctx)
> > +{
> > +       count++;
> > +       return 0;
> > +}
> > --
> > 2.41.0
> >

