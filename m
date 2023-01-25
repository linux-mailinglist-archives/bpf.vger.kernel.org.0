Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6840A67B6F9
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 17:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234848AbjAYQdo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 11:33:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234668AbjAYQdj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 11:33:39 -0500
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65162BED9;
        Wed, 25 Jan 2023 08:33:38 -0800 (PST)
Received: by mail-qt1-f172.google.com with SMTP id a25so16393850qto.10;
        Wed, 25 Jan 2023 08:33:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e4hEkk6Ac/01YXV4woTuVpkpHvraviXdnxqXSyWsbnA=;
        b=6ZQQMyf+S5r/SKxUbGSuJ/2WUofO6oQB25HcnENvaQqLs31GUZNXvaqJXZ23NFMOi8
         G/2AcFte0S9sI7wRS8ZEMGPOqVE6I7dKB3yvLJKJgK/yr9bTp/f3RV1bZeanK8ZvoTe6
         +hXtHlvDTTefB+BtSjkeHTRYL80I5AcxwIX0GcKn4J6XEB5PX3IRRX0snedgIFx4rLlh
         /PgqBXullybBSiWJ10IL5aakjZt+9pu+PMMBYs9ZDPnU1nYZCbOQ+dFoo1UH9HCstN11
         NfjynC4mLywyUnwUOxaGBnSpYgqSICpMDsJEs3awYjes6yKbg+gNAMGS/rSHgo24MhMo
         mc3Q==
X-Gm-Message-State: AO0yUKW2CLlzFxPXCKMEDtpv7FaLMz9GuGaF7yxyp542bFY6wfWR7mcH
        5JzCNgZ8QQk8TIRn8bQGy7E=
X-Google-Smtp-Source: AK7set8bh1KKtmfa6hRyXt2gjdAOr0VA1f+uTU2XsbY+kGf79mmf29Wz3YKhVpJ9zkuJUaUtrl+oAA==
X-Received: by 2002:ac8:5f89:0:b0:3b6:3a8f:ecbc with SMTP id j9-20020ac85f89000000b003b63a8fecbcmr4755693qta.66.1674664417719;
        Wed, 25 Jan 2023 08:33:37 -0800 (PST)
Received: from maniforge ([2620:10d:c091:480::1:113e])
        by smtp.gmail.com with ESMTPSA id b4-20020ac86bc4000000b003b62fcd6d50sm3588110qtt.28.2023.01.25.08.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 08:33:37 -0800 (PST)
Date:   Wed, 25 Jan 2023 10:33:34 -0600
From:   David Vernet <void@manifault.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@meta.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH bpf-next v3 4/4] bpf/selftests: Verify struct_ops prog
 sleepable behavior
Message-ID: <Y9FZ3ucyvd8UiSO4@maniforge>
References: <20230125050359.339273-1-void@manifault.com>
 <20230125050359.339273-5-void@manifault.com>
 <CAADnVQJ18MRB+z5feD-hu8zdV2s=rhTW--RWW06NWp-kQaBhag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQJ18MRB+z5feD-hu8zdV2s=rhTW--RWW06NWp-kQaBhag@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 25, 2023 at 08:06:11AM -0800, Alexei Starovoitov wrote:
> On Tue, Jan 24, 2023 at 9:04 PM David Vernet <void@manifault.com> wrote:
> >
> > In a set of prior changes, we added the ability for struct_ops programs
> > to be sleepable. This patch enhances the dummy_st_ops selftest suite to
> > validate this behavior by adding a new sleepable struct_ops entry to
> > dummy_st_ops.
> >
> > Signed-off-by: David Vernet <void@manifault.com>
> > ---
> >  include/linux/bpf.h                           |  1 +
> >  net/bpf/bpf_dummy_struct_ops.c                | 18 +++++++
> >  .../selftests/bpf/prog_tests/dummy_st_ops.c   | 54 ++++++++++++++-----
> >  .../selftests/bpf/progs/dummy_st_ops_fail.c   | 27 ++++++++++
> >  ...{dummy_st_ops.c => dummy_st_ops_success.c} | 19 +++----
> >  5 files changed, 94 insertions(+), 25 deletions(-)
> >  create mode 100644 tools/testing/selftests/bpf/progs/dummy_st_ops_fail.c
> >  rename tools/testing/selftests/bpf/progs/{dummy_st_ops.c => dummy_st_ops_success.c} (72%)
> 
> It fails on s390:
> dummy_st_ops_success/dummy_multiple_args:FAIL
> 
> Please add to DENYLIST as part of this patch.

Sorry, this was just a dumb replace-all mistake on my part -- accidentally
changed the name of the testsuite to dummy_st_ops_success when changing the
name of the BPF prog in prog_tests/dummy_st_ops. It's already in the DENYLIST.
This should fix it:

diff --git a/tools/testing/selftests/bpf/prog_tests/dummy_st_ops.c b/tools/testing/selftests/bpf/prog_tests/dummy_st_ops.c
index 135514fad83a..f43fcb13d2c4 100644
--- a/tools/testing/selftests/bpf/prog_tests/dummy_st_ops.c
+++ b/tools/testing/selftests/bpf/prog_tests/dummy_st_ops.c
@@ -144,7 +144,7 @@ static void test_dummy_sleepable(void)
        dummy_st_ops_success__destroy(skel);
 }

-void test_dummy_st_ops_success(void)
+void test_dummy_st_ops(void)
 {
        if (test__start_subtest("dummy_st_ops_attach"))
                test_dummy_st_ops_attach();


Will send out the v4 with that fix shortly.
