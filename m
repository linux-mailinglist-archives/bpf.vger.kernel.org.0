Return-Path: <bpf+bounces-9779-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D5779D7DD
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 19:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39FAA2821B4
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 17:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E063D9446;
	Tue, 12 Sep 2023 17:45:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79EB1FA8
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 17:45:50 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F312410C9
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 10:45:49 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99357737980so736556166b.2
        for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 10:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694540748; x=1695145548; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Uv2S9lOE1k8udXgoVOKcH7PpZkFM/dwfYbUJUpyqIQA=;
        b=QhKX3oT4wXgfHx0dr8FeQ6tD4aGkUE6SOmrVMC6CN1RRxnGjiJf66n4rLBXRwCvjs/
         Z5VvyIgNlvnhKpUwDnQJ9vwQsgmo/v8LjAo6RcQZYOMF9qanuxZ7IU4miRRBn0WFBJ/4
         d1WfbymPS/6otzSWaTCp1vjMXZhBOtO+8nJ5REpeh17WZmvmLFogpIczjXcy1Ah2NcVJ
         ++rXzp6L/pZZXl7GkLGoMeMtfl8O0NwOXuSICIM9679w3gKoOivTAcQ4J/2jp0WwyAlu
         B8Sq5ZMsHWGhxURLorBsTKm3Y6vvHKBAIaClJM28H9S7zPbtk/muQfq46zM+HqhmNI0a
         HIDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694540748; x=1695145548;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uv2S9lOE1k8udXgoVOKcH7PpZkFM/dwfYbUJUpyqIQA=;
        b=epxw5kAWBUPQ6MAe0RFlzVK8sJjCGUSuYQUhlapVwf7HdRjnp1fdS4DmHJSJTRXfl4
         14Aqg1e8z8lcAtR7uymCUkUvzvYLt3CFMC+wTRiD81LiTRkAdKXE9PrgKSc6tpLCcg0I
         HjLA9e/iOHR6d1T8yrl7k10XlfbE34q6vtT/2XXUVyeWJLPoliljsiErpNH3SgewVaZ4
         HaK70b5/baX2JEm3WOwZlUAYUBldgOf02mw5n1e0SoViCDqlElVwpiMIgXHdS/Heb05j
         RcDcAivjRoqTUsv0Qei7wiUatD5tU3QZLlP/NIdDNkYvNtCVjpJvXfUVthJDe2YyGA8/
         Avxw==
X-Gm-Message-State: AOJu0YyajQOztMz5hgqn5eFu8icigj4mPMUuZr+eaJAfWpFYPTp5U67B
	hbO2OUUaJN0PT223xUe7PZw=
X-Google-Smtp-Source: AGHT+IFpGPcklaflUxAsE0F51ttVdm4uBorZ75CfSTCkbN5OrLQjdRon2oJdjusUwsid1m60Pzoj4g==
X-Received: by 2002:a17:907:75c7:b0:9ad:7c98:2e99 with SMTP id jl7-20020a17090775c700b009ad7c982e99mr4974ejc.63.1694540748074;
        Tue, 12 Sep 2023 10:45:48 -0700 (PDT)
Received: from krava ([83.240.62.189])
        by smtp.gmail.com with ESMTPSA id t20-20020a1709063e5400b009a19fa8d2e9sm6989104eji.206.2023.09.12.10.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 10:45:47 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 12 Sep 2023 19:45:45 +0200
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf] selftests/bpf: Fix kprobe_multi_test/attach_override
 test
Message-ID: <ZQCjyUzfwnKS6ODb@krava>
References: <20230912141437.366046-1-jolsa@kernel.org>
 <CAADnVQ+BfF3fojHCcfq6suJ-4GkTrchtkfrZHtvt0OQDMXLBBA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+BfF3fojHCcfq6suJ-4GkTrchtkfrZHtvt0OQDMXLBBA@mail.gmail.com>

On Tue, Sep 12, 2023 at 07:57:40AM -0700, Alexei Starovoitov wrote:
> On Tue, Sep 12, 2023 at 7:14 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > We need to deny the attach_override test for arm64
> > and make it static.
> >
> > Fixes: 7182e56411b9 ("selftests/bpf: Add kprobe_multi override test")
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/testing/selftests/bpf/DENYLIST.aarch64               | 1 +
> >  tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c | 2 +-
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testing/selftests/bpf/DENYLIST.aarch64
> > index 7f768d335698..b32f962dee92 100644
> > --- a/tools/testing/selftests/bpf/DENYLIST.aarch64
> > +++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
> > @@ -9,6 +9,7 @@ kprobe_multi_test/bench_attach                   # bpf_program__attach_kprobe_mu
> >  kprobe_multi_test/link_api_addrs                 # link_fd unexpected link_fd: actual -95 < expected 0
> >  kprobe_multi_test/link_api_syms                  # link_fd unexpected link_fd: actual -95 < expected 0
> >  kprobe_multi_test/skel_api                       # libbpf: failed to load BPF skeleton 'kprobe_multi': -3
> > +kprobe_multi_test/attach_override                # test_attach_override:FAIL:kprobe_multi_empty__open_and_load unexpected error: -22
> 
> why do we need this ?
> Andrii, move of kconfig override into common should fix it, no?

the test creates kprobe_multi link, so it needs fprobe,
which is still not enabled in arm

but I miread the error.. there's some other issue with
override helper on arm

also the missing static fix is needed

jirka

> 
> >  module_attach                                    # prog 'kprobe_multi': failed to auto-attach: -95
> >  fentry_test/fentry_many_args                     # fentry_many_args:FAIL:fentry_many_args_attach unexpected error: -524
> >  fexit_test/fexit_many_args                       # fexit_many_args:FAIL:fexit_many_args_attach unexpected error: -524
> > diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> > index e05477b210a5..4041cfa670eb 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> > @@ -454,7 +454,7 @@ static void test_kprobe_multi_bench_attach(bool kernel)
> >         }
> >  }
> >
> > -void test_attach_override(void)
> > +static void test_attach_override(void)
> >  {
> >         struct kprobe_multi_override *skel = NULL;
> >         struct bpf_link *link = NULL;
> > --
> > 2.41.0
> >

