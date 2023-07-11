Return-Path: <bpf+bounces-4745-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6D974E9D3
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 11:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 757A1281612
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 09:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1B81774D;
	Tue, 11 Jul 2023 09:06:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6162F17723
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 09:06:37 +0000 (UTC)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A411F93
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 02:06:35 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b701dee4bfso88608191fa.0
        for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 02:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689066394; x=1691658394;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x2FtHrdYVj2vdwuwBawKo32v0hRP4mFZ0EhnEv1gZ78=;
        b=COx5aoS8TO+UcdrAk2aGm7gWoi8LCGIVaY4srFf1kTyw+RGHh8DNhnSg73csbPgL+q
         ZvEuLDJDSNhWsgGZaauV0P31fz+FCJa4ngyKp9FtSob8frzzV7mn7POPvTlg98P7jsJq
         vS98ybOY7Cs+oW3Mr5NK72nzOKktA8FGWhAu24VSW4RP85C5iRF9Zyxf/fY9R6aDDFQN
         NSRvSNZUhVl1zqtnCVi7GmE4B9tTDr9lSJY3c4doFp8oWb0qQIzISaDwf2Raid9mbK0A
         WxUGUViz0+3eFvl3zpJBj1f/jn67aR0fj6D9Cr2WHW7Wm0EKA1X3ebdhHy3WL310KzkZ
         u+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689066394; x=1691658394;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x2FtHrdYVj2vdwuwBawKo32v0hRP4mFZ0EhnEv1gZ78=;
        b=UQVqSQtEUvyFA7xe06wqvtwkzFt7pdHfdzUx/7inLfNny0d54LIuCr+F2RmjzKfBvI
         BhSf1BjPAhoJhM94ClsoRLPsHmZdgCRF+U/8gSConv9D+7i44bzEFEvYM5bA4nOKGLrO
         8nWaWHcX6mHrSbnYtoc1r3F2nhMAW9U0WE/HXT3jigjYpaPOQj7dzWQw7SaLcucNkoea
         5y7UmE2hbsWhK3ntW+eRAoQUcgBPy/qyD+5/8AKsKDlookrDqRoN1cBqaa7ds7harkYJ
         u0iuE6n9WzE9J7KjAC5ph53VniCJOd4L9xT8MgXCoHL+AF2/k9CXRxAfnBEF6YNfXViL
         LnbA==
X-Gm-Message-State: ABy/qLaMLL9GLJBzIKqEHmxq6Xae0FWkjMRizqw68Mj8AxN2pTnzYv2e
	ihP4BKnINB+b3FniqCHBXgA=
X-Google-Smtp-Source: APBJJlEEch68uEs0K00fUmFetRsqpj4idW2wQv8/F0w32U9iqTFvgxGKB92XGz/MFUmFi1fMJKHRIA==
X-Received: by 2002:a2e:8782:0:b0:2b7:243e:a2 with SMTP id n2-20020a2e8782000000b002b7243e00a2mr3064611lji.48.1689066393687;
        Tue, 11 Jul 2023 02:06:33 -0700 (PDT)
Received: from krava (net-109-116-206-239.cust.vodafonedsl.it. [109.116.206.239])
        by smtp.gmail.com with ESMTPSA id w25-20020a170906481900b00992ddf46e65sm883469ejq.46.2023.07.11.02.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 02:06:33 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 11 Jul 2023 11:06:27 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCHv3 bpf-next 18/26] selftests/bpf: Add uprobe_multi api test
Message-ID: <ZK0bk5+oZ22WKtZ8@krava>
References: <20230630083344.984305-1-jolsa@kernel.org>
 <20230630083344.984305-19-jolsa@kernel.org>
 <CAEf4BzYhfSZgWSRSn4QUm+k0JMzqUd0R_ud5-DVL0Lm1GmvOWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYhfSZgWSRSn4QUm+k0JMzqUd0R_ud5-DVL0Lm1GmvOWA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 06, 2023 at 09:32:15PM -0700, Andrii Nakryiko wrote:
> On Fri, Jun 30, 2023 at 1:37 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding uprobe_multi test for bpf_program__attach_uprobe_multi
> > attach function.
> >
> > Testing attachment using glob patterns and via bpf_uprobe_multi_opts
> > paths/syms fields.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  .../bpf/prog_tests/uprobe_multi_test.c        | 71 +++++++++++++++++++
> >  1 file changed, 71 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> > index 5cd1116bbb62..f97a68871e73 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> > @@ -69,8 +69,79 @@ static void test_skel_api(void)
> >         uprobe_multi__destroy(skel);
> >  }
> >
> > +static void
> > +test_attach_api(const char *binary, const char *pattern, struct bpf_uprobe_multi_opts *opts)
> > +{
> > +       struct bpf_link *link1 = NULL, *link2 = NULL;
> > +       struct bpf_link *link3 = NULL, *link4 = NULL;
> > +       struct uprobe_multi *skel = NULL;
> > +
> > +       skel = uprobe_multi__open_and_load();
> > +       if (!ASSERT_OK_PTR(skel, "uprobe_multi__open_and_load"))
> > +               goto cleanup;
> > +
> > +       opts->retprobe = false;
> > +       link1 = bpf_program__attach_uprobe_multi(skel->progs.test_uprobe, -1,
> > +                                                     binary, pattern, opts);
> > +       if (!ASSERT_OK_PTR(link1, "bpf_program__attach_uprobe_multi"))
> > +               goto cleanup;
> > +
> > +       opts->retprobe = true;
> > +       link2 = bpf_program__attach_uprobe_multi(skel->progs.test_uretprobe, -1,
> > +                                                     binary, pattern, opts);
> > +       if (!ASSERT_OK_PTR(link2, "bpf_program__attach_uprobe_multi_retprobe"))
> > +               goto cleanup;
> > +
> > +       opts->retprobe = false;
> > +       link3 = bpf_program__attach_uprobe_multi(skel->progs.test_uprobe_sleep, -1,
> > +                                                     binary, pattern, opts);
> > +       if (!ASSERT_OK_PTR(link1, "bpf_program__attach_uprobe_multi"))
> 
> link3
> 
> > +               goto cleanup;
> > +
> > +       opts->retprobe = true;
> > +       link4 = bpf_program__attach_uprobe_multi(skel->progs.test_uretprobe_sleep, -1,
> > +                                                     binary, pattern, opts);
> > +       if (!ASSERT_OK_PTR(link2, "bpf_program__attach_uprobe_multi_retprobe"))
> 
> link4
> 
> > +               goto cleanup;
> > +
> > +       uprobe_multi_test_run(skel);
> > +
> > +cleanup:
> > +       bpf_link__destroy(link4);
> > +       bpf_link__destroy(link3);
> > +       bpf_link__destroy(link2);
> > +       bpf_link__destroy(link1);
> 
> you could have used
> skel->links.{test_uprobe,test_uretprobe,test_uprobe_sleep,test_uretprobe_sleep}
> "containers" to not manage destruction of these links manually

ah right, I keep forgetting we have those variables ready in there :-\
will change

thanks,
jirka

> 
> > +       uprobe_multi__destroy(skel);
> > +}
> > +
> > +static void test_attach_api_pattern(void)
> > +{
> > +       LIBBPF_OPTS(bpf_uprobe_multi_opts, opts);
> > +
> > +       test_attach_api("/proc/self/exe", "uprobe_multi_func_*", &opts);
> > +       test_attach_api("/proc/self/exe", "uprobe_multi_func_?", &opts);
> > +}
> > +
> 
> [...]

