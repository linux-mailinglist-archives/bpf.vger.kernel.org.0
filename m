Return-Path: <bpf+bounces-9975-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0AC79FC08
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 08:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30A641F2228C
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 06:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5648D3D7F;
	Thu, 14 Sep 2023 06:31:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C997250E2
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 06:31:50 +0000 (UTC)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619DDE50
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 23:31:49 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-500c37d479aso931430e87.2
        for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 23:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694673107; x=1695277907; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fveZ/hJ9K2AmiOjLcfp085qakX6QDo5v+3IknUzCo4s=;
        b=JTRIFa9WV4+dpDByb1aScTTcr3j9eD4/9FQ9xucrfMPeFBzoXuFbyYq6kKKUEfrYfA
         RZ0k8DsUNmn7Xv9ZRXpQoEfyD2b3i3+BzlF3eFkhF8ujDdgpsRKUsQqVQhas95bUBtJ4
         LIvnjYp63IWDN8XCy0uA0lP14LGKDTMUeLsjwwAKh8ib2KKGvT/UaKDi7IIiHHq8ywFE
         EiNPYOLgyY1iAEzgOrdGVPUXlCyowVYxaazfBoW7JrOlMiiNz5KUGpT9l0nB93OcdMov
         aIYWflX/mwjVPAY47OyBcoNDjXFjcGLJU/SIN2rMuTAKnQ7uTwHvS+OB1CvIbnqGgpK/
         cGFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694673107; x=1695277907;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fveZ/hJ9K2AmiOjLcfp085qakX6QDo5v+3IknUzCo4s=;
        b=kcFAdHraMX81xcPOQD+xuQv6iYOVOLzj4m4uARjl8+8ZdUClokxoMJTZB8Dk6f1jVB
         9/7+BdVHhDtHimuh5XWowrFjomqpWVb6I9w+jaQ0GsUuW8jxsb8QQQVHvdcX5T78KKR5
         CeGIptDJakrzxcWpjZ225495negJwtGhh+x/VJKSXgp+kUyC5kNl36nlSwBbOGvIxN7e
         Vf/xcP477jlbwF0W7DB3heRIntDfek3DTvCMaahjyD6gvyb7kFbNNc1wqUEbW/67cbzS
         oRktgrXx3eFlYRaGPYCRDZa3BOFcqpyXqer2Wvdb79RGRcnoTphRXh8fNbtpKzhXYVjT
         gNwQ==
X-Gm-Message-State: AOJu0YxIcx0N0pR0WAsZGqN0IKDnaqGVJ1x7LAnFhMYda0qD1Nvis4ch
	PCVzz440VW2CFaRVzDYabnLRW06M0RQ=
X-Google-Smtp-Source: AGHT+IEO0F0KVopOHnsm8xBUD838g8o/gbaXtlpDkitPrSDAXdna4hU1fXhAZEh2CLr0daYZRSNO+g==
X-Received: by 2002:a2e:9d41:0:b0:2bb:aa37:6517 with SMTP id y1-20020a2e9d41000000b002bbaa376517mr3831392ljj.6.1694673107225;
        Wed, 13 Sep 2023 23:31:47 -0700 (PDT)
Received: from krava ([83.148.32.128])
        by smtp.gmail.com with ESMTPSA id um12-20020a170906cf8c00b009a219ecbaf1sm530084ejb.85.2023.09.13.23.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 23:31:46 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 14 Sep 2023 08:31:44 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCHv2 bpf] selftests/bpf: Fix
 kprobe_multi_test/attach_override test
Message-ID: <ZQKo0Dilcf+Ur/QP@krava>
References: <20230913114711.499829-1-jolsa@kernel.org>
 <CAEf4Bza6GiLXgB1mmo7jUcQPT4PW+tCRTQ266bZ706cqG7sOSg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bza6GiLXgB1mmo7jUcQPT4PW+tCRTQ266bZ706cqG7sOSg@mail.gmail.com>

On Wed, Sep 13, 2023 at 11:43:47AM -0700, Andrii Nakryiko wrote:
> On Wed, Sep 13, 2023 at 4:47 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > We need to deny the attach_override test for arm64, denying the
> > whole kprobe_multi_test suite. Also making attach_override static.
> >
> > Fixes: 7182e56411b9 ("selftests/bpf: Add kprobe_multi override test")
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/testing/selftests/bpf/DENYLIST.aarch64             | 9 +--------
> >  .../testing/selftests/bpf/prog_tests/kprobe_multi_test.c | 2 +-
> >  2 files changed, 2 insertions(+), 9 deletions(-)
> >
> > v2 changes:
> >   - rebased on latest bpf/master, used just kprobe_multi_test suite name
> >     in DENYLIST.aarch64 to cover all kprobe_multi tests
> >
> > diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testing/selftests/bpf/DENYLIST.aarch64
> > index 7f768d335698..b733ce16c0f8 100644
> > --- a/tools/testing/selftests/bpf/DENYLIST.aarch64
> > +++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
> > @@ -1,14 +1,7 @@
> >  bpf_cookie/multi_kprobe_attach_api               # kprobe_multi_link_api_subtest:FAIL:fentry_raw_skel_load unexpected error: -3
> >  bpf_cookie/multi_kprobe_link_api                 # kprobe_multi_link_api_subtest:FAIL:fentry_raw_skel_load unexpected error: -3
> >  fexit_sleep                                      # The test never returns. The remaining tests cannot start.
> > -kprobe_multi_bench_attach                        # bpf_program__attach_kprobe_multi_opts unexpected error: -95
> 
> did you drop kprobe_multi_bench_attach from DENYLIST intentionally?
> I'll leave it in DENYLIST.aarch64 for now when applying

ugh, no it should stay.. thanks a lot

jirka

> 
> > -kprobe_multi_test/attach_api_addrs               # bpf_program__attach_kprobe_multi_opts unexpected error: -95
> > -kprobe_multi_test/attach_api_pattern             # bpf_program__attach_kprobe_multi_opts unexpected error: -95
> > -kprobe_multi_test/attach_api_syms                # bpf_program__attach_kprobe_multi_opts unexpected error: -95
> > -kprobe_multi_test/bench_attach                   # bpf_program__attach_kprobe_multi_opts unexpected error: -95
> > -kprobe_multi_test/link_api_addrs                 # link_fd unexpected link_fd: actual -95 < expected 0
> > -kprobe_multi_test/link_api_syms                  # link_fd unexpected link_fd: actual -95 < expected 0
> > -kprobe_multi_test/skel_api                       # libbpf: failed to load BPF skeleton 'kprobe_multi': -3
> > +kprobe_multi_test                                # needs CONFIG_FPROBE
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

