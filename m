Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6ED699D2F
	for <lists+bpf@lfdr.de>; Thu, 16 Feb 2023 20:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjBPTxj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Feb 2023 14:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBPTxj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Feb 2023 14:53:39 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1044016337
        for <bpf@vger.kernel.org>; Thu, 16 Feb 2023 11:53:38 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id d40so7088240eda.8
        for <bpf@vger.kernel.org>; Thu, 16 Feb 2023 11:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fB7ceTtrDLAVq2Vl3Yk+pnarmUv+fjxQNCRjIPas8vc=;
        b=MfQOgsSbhBUr/MuX12DrRddpG6C1hqbwcMJovmOU+B/U/qX/MobK4WvScUDwBAO0Wq
         Ex8vPG0wcVWkE2cUCVUBbNC15HfaqHCu7ICQLStCZnPeNDwiRxv7QBzHSxTi32a+g7RV
         jYNoSOiZTfo6YnQkpZEO6OME0QlFBkbtoqFnrbcgbbT/3osSusntSr66+wVlnEcRnPnW
         SLT77AUvvsrVa83yyNmB9BBrA80uln2BdweDz0rjRx44bm71+qIOx8DxcOfnKgZvTyHL
         1RAZYqsfLUEoGpArl5jz/Zz5LPYGGqcjvr34aEPZHZt+2ejNeb1LzzntsyNVr9cbUKVq
         sKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fB7ceTtrDLAVq2Vl3Yk+pnarmUv+fjxQNCRjIPas8vc=;
        b=JQPsve8SGhQ9PF7oW1GleVkTaqxto403EfnRCyMbbEPmNP4l9/pV+T/LTcWUM0Cxbj
         YydNuDF2jBQ5wppxLiA6eAf5rxdNLAyjaEyH6399epzoFLIu/ZqLhqnx5+AvXCo7i2ap
         r2OaDtrFmnW9lBlwkoBFhTCSOiylHf08oX7bQ+mTDNGQzsLXKCMQFnOvCXndbAA9u4Ga
         adJ77apaAsd/kwPwOM6pY1gJmd/czrzDgEvrXn94iMB5lCgYq4Q1VfZmnJLbBJ3pwcRg
         fFB8R2OYK53Is1Gvy6kbOZaKz0gj/NeQvFEwN5dxZTdx0vvEOe1gWRn/PBGuVw9MRsdb
         +uUA==
X-Gm-Message-State: AO0yUKU9Bghvyp9QYKSxxZUTebalZIWs+2f3nzGhcCZ+zhiZtsMtDwZO
        lrKhLqpBw4JvUw8xahSz5kUa62TykCslxnyuEXGYadfa
X-Google-Smtp-Source: AK7set+tqqi5zHhYqjB+GgSFpVC8Q+a/aFJahbkEEFDHZutzOnaT+oilpfZ/pHQUWFJs4utbKotUCB0zpLDevanzb0M=
X-Received: by 2002:a17:906:6896:b0:8a5:c8bd:4ac4 with SMTP id
 n22-20020a170906689600b008a5c8bd4ac4mr3416606ejr.15.1676577216582; Thu, 16
 Feb 2023 11:53:36 -0800 (PST)
MIME-Version: 1.0
References: <20230216045954.3002473-1-andrii@kernel.org> <Y+5qn2EMxN+3RN24@google.com>
In-Reply-To: <Y+5qn2EMxN+3RN24@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 16 Feb 2023 11:53:24 -0800
Message-ID: <CAEf4BzZTi1XxS8KB7aBPGtHnnWd6NKA40DKu0eQDPegxxhqM=Q@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 0/3] Fix BPF verifier global subprog context
 argument logic
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com
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

On Thu, Feb 16, 2023 at 9:40 AM Stanislav Fomichev <sdf@google.com> wrote:
>
> On 02/15, Andrii Nakryiko wrote:
> > Fix kernel bug in determining whether global subprog's argument is
> > PTR_TO_CTX,
> > which is done based on type names. Currently KPROBE programs are broken.
>
> > Add few tests validating that KPROBE context can be passed to global
> > subprog.
> > For that also refactor test_global_funcs test to use test_loader
> > framework.
>
> > v1->v2:
> >    - fix compilation warning on arm64 and s390x by force-casting ctx to
> >      `void *`, to discard const from `const struct user_pt_regs *`, when
> >      passing it to bpf_get_stack().
>
> Such a shame there isn't something like unconstify(typeof(xxx)) :-(
> But thank you for catching this. Need to build a habit of looking at
> the buildbot output.

Yep. And yep, me too :)

>
> Reposting for patchwork:
>
> Acked-by: Stanislav Fomichev <sdf@google.com>

Oh, sorry, forgot to carry over your ack from v1.


>
> > Andrii Nakryiko (3):
> >    bpf: fix global subprog context argument resolution logic
> >    selftests/bpf: convert test_global_funcs test to test_loader framework
> >    selftests/bpf: add global subprog context passing tests
>
> >   kernel/bpf/btf.c                              |  13 +-
> >   .../bpf/prog_tests/test_global_funcs.c        | 133 +++++-------------
> >   .../selftests/bpf/progs/test_global_func1.c   |   6 +-
> >   .../selftests/bpf/progs/test_global_func10.c  |   4 +-
> >   .../selftests/bpf/progs/test_global_func11.c  |   4 +-
> >   .../selftests/bpf/progs/test_global_func12.c  |   4 +-
> >   .../selftests/bpf/progs/test_global_func13.c  |   4 +-
> >   .../selftests/bpf/progs/test_global_func14.c  |   4 +-
> >   .../selftests/bpf/progs/test_global_func15.c  |   4 +-
> >   .../selftests/bpf/progs/test_global_func16.c  |   4 +-
> >   .../selftests/bpf/progs/test_global_func17.c  |   4 +-
> >   .../selftests/bpf/progs/test_global_func2.c   |  43 +++++-
> >   .../selftests/bpf/progs/test_global_func3.c   |  10 +-
> >   .../selftests/bpf/progs/test_global_func4.c   |  55 +++++++-
> >   .../selftests/bpf/progs/test_global_func5.c   |   4 +-
> >   .../selftests/bpf/progs/test_global_func6.c   |   4 +-
> >   .../selftests/bpf/progs/test_global_func7.c   |   4 +-
> >   .../selftests/bpf/progs/test_global_func8.c   |   4 +-
> >   .../selftests/bpf/progs/test_global_func9.c   |   4 +-
> >   .../bpf/progs/test_global_func_ctx_args.c     | 105 ++++++++++++++
> >   20 files changed, 292 insertions(+), 125 deletions(-)
> >   create mode 100644
> > tools/testing/selftests/bpf/progs/test_global_func_ctx_args.c
>
> > --
> > 2.30.2
>
