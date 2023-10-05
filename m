Return-Path: <bpf+bounces-11463-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F19547BA767
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 19:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id A039F281E6D
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 17:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CD638F80;
	Thu,  5 Oct 2023 17:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vN++5Qm9"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064AB358B5
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 17:13:44 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73221BC2
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 10:13:43 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a23fed55d7so17193227b3.2
        for <bpf@vger.kernel.org>; Thu, 05 Oct 2023 10:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696526023; x=1697130823; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/omlxDHCfwpahe9/8c3dPOYRcAgh7OQ4Gdfxm46yJSk=;
        b=vN++5Qm9aqeqvVV6hhI+yVLG2hbk7TlMWYaUzu09/E8C3oy+X/xxzWtwHnFqRJUuQn
         buffGuth8hKOViVABbdWfhiBcp1BfqOlOf7R2DynjBFLm6ac2oDEwGpVXpBGNkIJ9ypZ
         CgvPfRWQY78dDnlQ7KL6E+YQGxNQAt8NuOc/pQq/S1QAFYWIDlRqkWysRZ4KEIxoH1DS
         fGJoAQy0btMJwuQHmqX5u1w46hczleuL/oL22+H9xxnGjGrI7WziVQ8F90tcEZARk/i4
         z/bWDYCa2M42vZKh0oU0JexXV777IdQqEkInsdjMuDtNM4np1hQAtWCPvrzNT2Z2nL8l
         dGCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696526023; x=1697130823;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/omlxDHCfwpahe9/8c3dPOYRcAgh7OQ4Gdfxm46yJSk=;
        b=p4ENAPlSc9Rw/UIrsbb7Pn37C7ymoegwrK+71xZWsoHoRDxbMkcASn/3cFb9zYwzw4
         ZsM3thOoJWi7ZPVoxmCeLAIh5dZQwxcbmzavh5tt6ci+M5/LyHzWUuJAaX5WEDefleUY
         az/pD/oobpCC7i21jAesER9/MaU/uR+3JcFBUKyCNYqGgeW75ybFFgEFokfDhUVV75wu
         93t95gbblTJcUa0cSHBsLAXZVbr0H7ogmEU8thpF2Yvv2sWr4A1cTKIj+DDmGw+6ILRc
         rCBHc+kUJ3dv1Wgf9lwyam3+nrZjXRIaKamLMfMMKMZw3hrDOQV13zkJfceuyPkPl3a9
         QXcA==
X-Gm-Message-State: AOJu0YwjAJBVAUgPSkkYBvsWYgEjbxC1t+PcoGZt6K95dz6XubhGMcV5
	EaO+waaBnXhvQpRykOoEw6JevR0=
X-Google-Smtp-Source: AGHT+IGsFsx2Mojp5kVJso71Q3aisy60LP1GCjAS11QWB/pkxB/FxhCRYkZbUF5Gqji6qMiAh4qD3eo=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a81:8d49:0:b0:592:8069:540a with SMTP id
 w9-20020a818d49000000b005928069540amr101738ywj.8.1696526023011; Thu, 05 Oct
 2023 10:13:43 -0700 (PDT)
Date: Thu, 5 Oct 2023 10:13:40 -0700
In-Reply-To: <20231005083953.1281-2-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231005083953.1281-1-laoar.shao@gmail.com> <20231005083953.1281-2-laoar.shao@gmail.com>
Message-ID: <ZR7uxCMaWlfEBkBJ@google.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add selftest for sleepable bpf_task_under_cgroup()
From: Stanislav Fomichev <sdf@google.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/05, Yafang Shao wrote:
> The result as follows,
> 
>   $ tools/testing/selftests/bpf/test_progs --name=task_under_cgroup
>   #237     task_under_cgroup:OK
>   Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
> 
> And no error messages in dmesg.
> 
> Without the prev patch, there will be RCU warnings in dmesg.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/task_under_cgroup.c   |  8 +++++--
>  .../selftests/bpf/progs/test_task_under_cgroup.c   | 28 +++++++++++++++++++++-
>  2 files changed, 33 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/task_under_cgroup.c b/tools/testing/selftests/bpf/prog_tests/task_under_cgroup.c
> index 4224727..d1a5a5c 100644
> --- a/tools/testing/selftests/bpf/prog_tests/task_under_cgroup.c
> +++ b/tools/testing/selftests/bpf/prog_tests/task_under_cgroup.c
> @@ -30,8 +30,12 @@ void test_task_under_cgroup(void)
>  	if (!ASSERT_OK(ret, "test_task_under_cgroup__load"))
>  		goto cleanup;
>  
> -	ret = test_task_under_cgroup__attach(skel);
> -	if (!ASSERT_OK(ret, "test_task_under_cgroup__attach"))
> +	skel->links.lsm_run = bpf_program__attach_lsm(skel->progs.lsm_run);
> +	if (!ASSERT_OK_PTR(skel->links.lsm_run, "attach_lsm"))
> +		goto cleanup;
> +

So we rely on the second attach here to trigger the program above?
Maybe add a comment? Otherwise we might risk loosing this dependency
after some refactoring...

Other than that, both patches look good to me, feel free to use for both
if/when you resend:

Acked-by: Stanislav Fomichev <sdf@google.com>

