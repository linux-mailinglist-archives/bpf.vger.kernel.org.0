Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F35560CCE
	for <lists+bpf@lfdr.de>; Thu, 30 Jun 2022 00:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbiF2W5V (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Jun 2022 18:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbiF2W4J (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Jun 2022 18:56:09 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AC625C70
        for <bpf@vger.kernel.org>; Wed, 29 Jun 2022 15:55:30 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id r18so16337179edb.9
        for <bpf@vger.kernel.org>; Wed, 29 Jun 2022 15:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OXt14LuN+irbM9tgtsYCJdlKqXQxNLT2rmY5OiaJsAc=;
        b=BM7Hm1RXfHhwE7FDxtzyKAy3ukPFA9YNEhOwPIEnbsS2RDdjL0e0vgfBY9dtsm0I+I
         jL6VJR5HN/FfzBqMInJbJoz6l492MgwUy7yVSITAiQ1qC9DusMZ/lP8cCOjMh6v7oEYm
         Kpab/wddgb4ZzAKz8md+n844wTWQhvqg709rGLkkZnkz+xyeJ0JUVNy31M19ij40TsoK
         X75N10wHt8L/X3fe30G6lwMt9MgGqX3LaJOUoe85xhsxbkmF4xk4XkBhuz8YrYFBh+ML
         FezhiTayRxrXPg/kuOSv28qKm3YbJzR4/CZ5sSB+cIMdg6urUBWyFrGMkk1qgU2QviGt
         BBsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OXt14LuN+irbM9tgtsYCJdlKqXQxNLT2rmY5OiaJsAc=;
        b=Ik0hR4MEeCB7OnWk6SUKC7HYDFQG8zDOOKoSAkeKSzxhSCF5pdVCnRCriZFVOIrqmV
         HB2he0xkWl54wFfL9n4SROIT2Z8rNV+kDEk6+wC8T6SJZhLQbDwEQMNhoHB3DNfiK9nh
         FFEqcjAFLKXkS3sBmN2TijrDuUcmHYvyrxOsv8fajlQo2kx3C8Ei/lz+66ATABfFL6dv
         e4WxVAy4PuwEeb8xcTrCB/YmC0lhJqF+77mmdclXpzAJOclFgUABqu3J7HmyJBpgR1XZ
         CjtwHIEj6F6QCtDRcCtXDMkTAFUozosTY9I9h1oZLq17QOgoUwG+ysDwMW+F15lQZV58
         14yQ==
X-Gm-Message-State: AJIora9Nd2zhAoJIC38aqwc+TfhOUpdA4vEBi23xvoZiVjG8cGVve0MG
        MUFAnyUTr6Tezhx4Kj7jyvkryXKhY0IrhZPqCvWBuCpT
X-Google-Smtp-Source: AGRyM1tE7rTS3VI15qyJ2YF6WlFtljpW8S7OS4zR9JMmeMy6jThCBR+OTeDOnmbAeUJPfSfWk5g4Q1sHnMMzgrHcRKI=
X-Received: by 2002:a05:6402:1a4d:b0:435:74ce:7b36 with SMTP id
 bf13-20020a0564021a4d00b0043574ce7b36mr7308785edb.94.1656543329024; Wed, 29
 Jun 2022 15:55:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220628174314.1216643-1-sdf@google.com> <20220628174314.1216643-12-sdf@google.com>
 <CAADnVQJHKtYd2XKiWRj_5fnVdT7aP2NEwi4eVUdqCO7q2nQ6Og@mail.gmail.com>
 <CAKH8qBtmoFbvvTSTA-u2J6n=So8Q9mMSwVqgdOBY6vzpOQzkKg@mail.gmail.com> <CAKH8qBu5F2SHwtbRJ+vpHRGeqEKT0pk-St6B9JTev5bWNy8f_g@mail.gmail.com>
In-Reply-To: <CAKH8qBu5F2SHwtbRJ+vpHRGeqEKT0pk-St6B9JTev5bWNy8f_g@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 29 Jun 2022 15:55:17 -0700
Message-ID: <CAADnVQJR-RYXvDpkv1hYuqJuxbv_Xak5JK2dJjMOWxbxEWsF+Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v11 11/11] selftests/bpf: lsm_cgroup functional test
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 29, 2022 at 2:29 PM Stanislav Fomichev <sdf@google.com> wrote:
>
> On Wed, Jun 29, 2022 at 1:31 PM Stanislav Fomichev <sdf@google.com> wrote:
> >
> > On Wed, Jun 29, 2022 at 1:26 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Tue, Jun 28, 2022 at 10:43 AM Stanislav Fomichev <sdf@google.com> wrote:
> > > > +
> > > > +static void test_lsm_cgroup_functional(void)
> > >
> > > It fails BPF CI on s390:
> > >
> > > test_lsm_cgroup_functional:FAIL:attach alloc_prog_fd unexpected error:
> > > -524 (errno 524)
> > > test_lsm_cgroup_functional:FAIL:detach_create unexpected
> > > detach_create: actual -2 < expected 0
> > > test_lsm_cgroup_functional:FAIL:detach_alloc unexpected detach_alloc:
> > > actual -2 < expected 0
> > > test_lsm_cgroup_functional:FAIL:detach_clone unexpected detach_clone:
> > > actual -2 < expected 0
> > >
> > > https://github.com/kernel-patches/bpf/runs/7100626120?check_suite_focus=true
> > >
> > > but I pushed it to bpf-next anyway.
> > > Thanks a lot for this work and please follow up with a fix.
> >
> > Thanks, I'll take a look!
>
> Looks like this needs a blacklist entry in
> https://github.com/kernel-patches/vmtest/blob/master/travis-ci/vmtest/configs/blacklist/BLACKLIST-latest.s390x
>
> Or, I can make tests more flexible by doing the following
> (copy-pasting into gmail, so tabs are broken):
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c
> b/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c
> index d40810a742fa..904b02a17598 100644
> --- a/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c
> +++ b/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c
> @@ -100,6 +100,10 @@ static void test_lsm_cgroup_functional(void)
>   ASSERT_EQ(query_prog_cnt(cgroup_fd, "bpf_lsm_sk_alloc_security"), 0,
> "prog count");
>   ASSERT_EQ(query_prog_cnt(cgroup_fd, NULL), 0, "total prog count");
>   err = bpf_prog_attach(alloc_prog_fd, cgroup_fd, BPF_LSM_CGROUP, 0);
> + if (err < 0 && errno == ENOTSUPP) {
> + test__skip();
> + return;
> + }
>   if (!ASSERT_OK(err, "attach alloc_prog_fd"))
>   goto detach_cgroup;
>   ASSERT_EQ(query_prog_cnt(cgroup_fd, "bpf_lsm_sk_alloc_security"), 1,
> "prog count");
>
> Any preference?

Ahh. Right. s390 lacks bpf trampoline support.
We've been blacklisting the tests manually,
but if it's fixable this way it's better to do it in the test,
so when s390 (and other archs) gain trampoline support
the test will be executed automatically without waiting for CI
maintainers to unlist the tests.
