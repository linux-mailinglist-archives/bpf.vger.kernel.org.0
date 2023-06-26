Return-Path: <bpf+bounces-3453-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D24F73E2C1
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 17:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B578280DF5
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 15:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE0BBA29;
	Mon, 26 Jun 2023 15:05:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86D3AD5D
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 15:05:29 +0000 (UTC)
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F1F10C1;
	Mon, 26 Jun 2023 08:05:26 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id 3f1490d57ef6-be30cbe88b3so3408152276.1;
        Mon, 26 Jun 2023 08:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687791926; x=1690383926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pegs9TJqI5ERPmTyKCB6W0EPsjXwbILtGPmjonf7lUo=;
        b=FHpX/4uQkZFdx3lLDSfby1RmDagKbu4vZhGJTRYZVNDN95xLwPS+VyiZxZtl6flZ2l
         MkqG6GYz/9gCQ9y/rMg8Zo5BvIKioYnCtOga3ARdet3G0KHjWfVYL+AphiWEzNK3VKC5
         hBIX8QHEQwbnLQgDhj5UhFLwXcP+FrHjaAGfMJoXkJo1NJRKY/xXaY3YqLU79q2un5vG
         K6p6DCXQYx6Ms91CADcoudgnLXnRv1U3t6woEHz/Bu2RuLx/5uJ/NVrkM13X7lSQmcPL
         rlke+4xXjAXCWgAHX0N/o/wjuS/jLcvYdQZWmeUde7Vg0kiPowuJah3An6o2qkffIWv+
         Fzzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687791926; x=1690383926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pegs9TJqI5ERPmTyKCB6W0EPsjXwbILtGPmjonf7lUo=;
        b=QEYGI4pE8yRP5C3dXomStZW5jvqpTXqIg/GDe6ut6uZ9eVXpTBI+LtVu1Won/Qqq0V
         JFa6MwBiTU5F5tX9Yk2nusXWUOklUOLmWYB5Z3R7gDG1Sj5BDM/PggphazY5zJuocaym
         5R4NsKl8s2aMo0Iu9BdWHA4Ng+JQsVqH9lO9CHK7vZ65Eou78w54C5vAU+CUrohAerIj
         6TcpMwcd5+iKcZDRvlbQ4hwJb837nVyf1GmTLmVw/wRa7f6tVqxkBxVomUxJN6Z4xiZK
         yokrZpZxjx7xQnM7785aWl3OoldOhzafV66Ogf6OWBCg2qBc/PQ2TNwwSLqsQdx8WT+c
         S/IA==
X-Gm-Message-State: AC+VfDyiqJOjpgbctb7IFYYHCPhL/zdC01E6JoJpVqzL21RDjArTyseL
	3k2n8LmNWKPwSiux0L5CAY5+k/hzC8AZOIDblDcqOrCdnnY4+Q==
X-Google-Smtp-Source: ACHHUZ4uT88kn0A+GVn574Fj3hlzzxtPyUec+Ql3r0zISMuteIdMVRgP5ybnqF5b1hW18/wDqCA+q5MrVSCgjXL7CRE=
X-Received: by 2002:a25:dd0:0:b0:c13:aca0:b70a with SMTP id
 199-20020a250dd0000000b00c13aca0b70amr6337670ybn.32.1687791925693; Mon, 26
 Jun 2023 08:05:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230622075715.1818144-1-imagedong@tencent.com>
 <20230622075715.1818144-4-imagedong@tencent.com> <d507239c-0e73-abb3-3863-f4363b8fdd11@iogearbox.net>
In-Reply-To: <d507239c-0e73-abb3-3863-f4363b8fdd11@iogearbox.net>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Mon, 26 Jun 2023 23:05:14 +0800
Message-ID: <CADxym3an3zOxzHJyCWuvNTs4nG+bUn0S2FKpTM-mwCnPcQ0kmw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 3/3] selftests/bpf: add testcase for TRACING
 with 6+ arguments
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: yhs@meta.com, alexei.starovoitov@gmail.com, ast@kernel.org, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, benbjiang@tencent.com, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Menglong Dong <imagedong@tencent.com>, revest@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 26, 2023 at 10:47=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.=
net> wrote:
>
> On 6/22/23 9:57 AM, menglong8.dong@gmail.com wrote:
> > From: Menglong Dong <imagedong@tencent.com>
>
> (CC'ing also Florent wrt arm64)
>
> > Add test9/test10 in fexit_test.c and fentry_test.c to test the fentry
> > and fexit whose target function have 7/11 arguments.
> >
> > Correspondingly, add bpf_testmod_fentry_test7() and
> > bpf_testmod_fentry_test11() to bpf_testmod.c
> >
> > Meanwhile, add bpf_modify_return_test2() to test_run.c to test the
> > MODIFY_RETURN with 7 arguments.
> >
> > Add bpf_testmod_test_struct_arg_7/bpf_testmod_test_struct_arg_7 in
> > bpf_testmod.c to test the struct in the arguments.
> >
> > And the testcases passed:
> >
> > ./test_progs -t fexit
> > Summary: 5/12 PASSED, 0 SKIPPED, 0 FAILED
> >
> > ./test_progs -t fentry
> > Summary: 3/0 PASSED, 0 SKIPPED, 0 FAILED
> >
> > ./test_progs -t modify_return
> > Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
> >
> > ./test_progs -t tracing_struct
> > Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
> >
> > Signed-off-by: Menglong Dong <imagedong@tencent.com>
> > Acked-by: Yonghong Song <yhs@fb.com>
> > ---
> > v6:
> > - add testcases to tracing_struct.c instead of fentry_test.c and
> >    fexit_test.c
> > v5:
> > - add testcases for MODIFY_RETURN
> > v4:
> > - use different type for args in bpf_testmod_fentry_test{7,12}
> > - add testcase for grabage values in ctx
> > v3:
> > - move bpf_fentry_test{7,12} to bpf_testmod.c and rename them to
> >    bpf_testmod_fentry_test{7,12} meanwhile
> > - get return value by bpf_get_func_ret() in
> >    "fexit/bpf_testmod_fentry_test12", as we don't change ___bpf_ctx_cas=
t()
> >    in this version
> > ---
> >   net/bpf/test_run.c                            | 23 ++++++--
> >   .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 49 ++++++++++++++++-
> >   .../selftests/bpf/prog_tests/fentry_fexit.c   |  4 +-
> >   .../selftests/bpf/prog_tests/fentry_test.c    |  2 +
> >   .../selftests/bpf/prog_tests/fexit_test.c     |  2 +
> >   .../selftests/bpf/prog_tests/modify_return.c  | 20 ++++++-
> >   .../selftests/bpf/prog_tests/tracing_struct.c | 19 +++++++
> >   .../testing/selftests/bpf/progs/fentry_test.c | 32 +++++++++++
> >   .../testing/selftests/bpf/progs/fexit_test.c  | 33 ++++++++++++
> >   .../selftests/bpf/progs/modify_return.c       | 40 ++++++++++++++
> >   .../selftests/bpf/progs/tracing_struct.c      | 54 ++++++++++++++++++=
+
> >   11 files changed, 271 insertions(+), 7 deletions(-)
>
> This triggers test failures on arm64 in BPF CI given the additions are
> not yet supported there:
>
> https://github.com/kernel-patches/bpf/actions/runs/5371020820/jobs/974360=
6263
> https://github.com/kernel-patches/bpf/actions/runs/5371020820/jobs/974360=
6326
>
> [...]
> Notice: Success: 362/3077, Skipped: 12, Failed: 3
> Error: #71 fentry_fexit
>    Error: #71 fentry_fexit
>    test_fentry_fexit:PASS:fentry_skel_load 0 nsec
>    test_fentry_fexit:PASS:fexit_skel_load 0 nsec
>    test_fentry_fexit:FAIL:fentry_attach unexpected error: -1 (errno 524)
> Error: #72 fentry_test
>    Error: #72 fentry_test
>    test_fentry_test:PASS:fentry_skel_load 0 nsec
>    fentry_test:FAIL:fentry_attach unexpected error: -1 (errno 524)
>    test_fentry_test:FAIL:fentry_first_attach unexpected error: -1 (errno =
524)
> Error: #76 fexit_test
>    Error: #76 fexit_test
>    test_fexit_test:PASS:fexit_skel_load 0 nsec
>    fexit_test:FAIL:fexit_attach unexpected error: -1 (errno 524)
>    test_fexit_test:FAIL:fexit_first_attach unexpected error: -1 (errno 52=
4)
> [...]
>
> I think probably the best way would be to separate the new test cases and
> then update tools/testing/selftests/bpf/DENYLIST.aarch64 to exclude them
> from being run on arm64 until support gets added there too.

Good idea! I didn't know the existence of DENYLIST,
or I'll already do it like this.

I'll send a new version.

Thanks!
Menglong Dong

>
> Thanks,
> Daniel

