Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D27560BB6
	for <lists+bpf@lfdr.de>; Wed, 29 Jun 2022 23:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiF2V3o (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Jun 2022 17:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiF2V3o (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Jun 2022 17:29:44 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F8C1F2DC
        for <bpf@vger.kernel.org>; Wed, 29 Jun 2022 14:29:43 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 9so16519474pgd.7
        for <bpf@vger.kernel.org>; Wed, 29 Jun 2022 14:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RYHM3pxc+fuotx0RRU3jAOWx/WCvcmmmXB8yVNijvPY=;
        b=d5On02JYto//RaLr2xwoHQOBKIJoUqIYGNtuYBDYd4zfGVRet5w3kC298ktwQXT0Ms
         e/81EpzDMyhCFAnCqBFw7vgbSX6fIqCzE5IGetqIKYuF0W4AuNnOFrf6Lu1yYPBSSgIU
         TH3HwiFmW8/bDVUjN5obwf/ub6Vr/Iln6zTcndX+SWc2I5aR1+bY0xXdiwqDXV/HvDVb
         o4/3+8WF/GjEhuRUJ7WfKR78uVGEarbEbPDPFgNy+qBoQpanxvCynG/WoXzk09LzeRwn
         16A519uuOLnpCHm7qykuVxJrqYahLZ8KJDk+kYtAhPX8IlWplDYJxQMbcOc74x2K3khO
         4lLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RYHM3pxc+fuotx0RRU3jAOWx/WCvcmmmXB8yVNijvPY=;
        b=YRNbxrjLJVZuwFscup/FJTKgeiPGN/VLhrmBt3ca8t+ymU5CJNgrF4GEdZPeGIAkg8
         Odl2WZ8gcTbbBFoTZ4F4jv7edxvnpvz80/vHlUDC0XVzlkwTtWyYup5PrBqQHoflVu6z
         H8CyKDYdRbHAql+5BtEeyB0j1g/wgS6CLMfws632HHpA0bXLdMpM5xCPEPc7pzJYsWoi
         lYjZJ7wTlx/84VMP5ZK+IfWJ3ugm3q5wHVj0YL4bDBD/2FhqUq00oWk3PxTlgPvREMX+
         /CkdoT+G/S0hS/S+TswqhH1E7t6awwHd1jcvIpyIEitT+F7UgfmmKIlVugW0tnb7V5ww
         T/NQ==
X-Gm-Message-State: AJIora82gBeQ4F40eKq4JHfSBr0jhe3IrJ+TIESGHJ33qhjEYm3zD7QX
        F8QD3IgMvQWffnIRZh3F8TtZq8j5Mk1goWZttQw35g==
X-Google-Smtp-Source: AGRyM1uFNGy5nuQEjHxGtKH6gIQV4DYflkmLqvIesaR5/NBUm16DZrNhevMbkpZaibfEGag0I7J1rup/M5Ok+ZYjuY8=
X-Received: by 2002:a62:1582:0:b0:525:6361:85cd with SMTP id
 124-20020a621582000000b00525636185cdmr10874628pfv.72.1656538183029; Wed, 29
 Jun 2022 14:29:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220628174314.1216643-1-sdf@google.com> <20220628174314.1216643-12-sdf@google.com>
 <CAADnVQJHKtYd2XKiWRj_5fnVdT7aP2NEwi4eVUdqCO7q2nQ6Og@mail.gmail.com> <CAKH8qBtmoFbvvTSTA-u2J6n=So8Q9mMSwVqgdOBY6vzpOQzkKg@mail.gmail.com>
In-Reply-To: <CAKH8qBtmoFbvvTSTA-u2J6n=So8Q9mMSwVqgdOBY6vzpOQzkKg@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Wed, 29 Jun 2022 14:29:32 -0700
Message-ID: <CAKH8qBu5F2SHwtbRJ+vpHRGeqEKT0pk-St6B9JTev5bWNy8f_g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v11 11/11] selftests/bpf: lsm_cgroup functional test
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 29, 2022 at 1:31 PM Stanislav Fomichev <sdf@google.com> wrote:
>
> On Wed, Jun 29, 2022 at 1:26 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Jun 28, 2022 at 10:43 AM Stanislav Fomichev <sdf@google.com> wrote:
> > > +
> > > +static void test_lsm_cgroup_functional(void)
> >
> > It fails BPF CI on s390:
> >
> > test_lsm_cgroup_functional:FAIL:attach alloc_prog_fd unexpected error:
> > -524 (errno 524)
> > test_lsm_cgroup_functional:FAIL:detach_create unexpected
> > detach_create: actual -2 < expected 0
> > test_lsm_cgroup_functional:FAIL:detach_alloc unexpected detach_alloc:
> > actual -2 < expected 0
> > test_lsm_cgroup_functional:FAIL:detach_clone unexpected detach_clone:
> > actual -2 < expected 0
> >
> > https://github.com/kernel-patches/bpf/runs/7100626120?check_suite_focus=true
> >
> > but I pushed it to bpf-next anyway.
> > Thanks a lot for this work and please follow up with a fix.
>
> Thanks, I'll take a look!

Looks like this needs a blacklist entry in
https://github.com/kernel-patches/vmtest/blob/master/travis-ci/vmtest/configs/blacklist/BLACKLIST-latest.s390x

Or, I can make tests more flexible by doing the following
(copy-pasting into gmail, so tabs are broken):

diff --git a/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c
b/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c
index d40810a742fa..904b02a17598 100644
--- a/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c
+++ b/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c
@@ -100,6 +100,10 @@ static void test_lsm_cgroup_functional(void)
  ASSERT_EQ(query_prog_cnt(cgroup_fd, "bpf_lsm_sk_alloc_security"), 0,
"prog count");
  ASSERT_EQ(query_prog_cnt(cgroup_fd, NULL), 0, "total prog count");
  err = bpf_prog_attach(alloc_prog_fd, cgroup_fd, BPF_LSM_CGROUP, 0);
+ if (err < 0 && errno == ENOTSUPP) {
+ test__skip();
+ return;
+ }
  if (!ASSERT_OK(err, "attach alloc_prog_fd"))
  goto detach_cgroup;
  ASSERT_EQ(query_prog_cnt(cgroup_fd, "bpf_lsm_sk_alloc_security"), 1,
"prog count");

Any preference?
