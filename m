Return-Path: <bpf+bounces-6752-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A2876D913
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 22:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EA161C2121B
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 20:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C4C1119F;
	Wed,  2 Aug 2023 20:57:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C933C100CD
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 20:57:58 +0000 (UTC)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692EA3AB6
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 13:57:31 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b9ab1725bbso3911891fa.0
        for <bpf@vger.kernel.org>; Wed, 02 Aug 2023 13:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691009849; x=1691614649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ByW6lm6lYtcwM8O3jUgyv+MOsFCTjgEipdGDHdL9Qkg=;
        b=f/G87SBsqCSMD0Ad8LvltvLpfFxXJfACKrsBBG9WQH3DKMX1KNoJyKN9G3n6EpasEM
         EsVMT3YLg09vKxHKANT1FQ/VQWxNDweX+amT5XZJaifJ8PRcKmFU0pSyJAUpbxETrxUo
         H+o8HhRGUYDFogEfRN5+5ODpU6gsbu7YBotZ8sC2tP0q4fiJqJfcnWHnsCXqo8r6PpVM
         ZS2ZWEmYsODrmoEaQK4OrqFLsPfowvLbq1Pu0barI+31fPrIWVCo609rRfEx/fZpCdNV
         6iqB/j6JHc40pTMbhsKsgrd4RnACZf0amrAPdIJVBRJs66KheRMXcbsLkSaUBUhhKgKu
         uJXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691009849; x=1691614649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ByW6lm6lYtcwM8O3jUgyv+MOsFCTjgEipdGDHdL9Qkg=;
        b=Mxu0x8Wb+4zF+qH5aPo6+/cIbvoAXVzkUZ10evRkblTwe4yNu9CpUFskqoG4PDTAlq
         KFiqybEJHhLVS9Nq8XEJIPfxBM7cq5d67BWSYTHDklpex6GjDAuqJ6/eYtTcrft8UB95
         Qx0NK7jii5k65ZvbZ4Cxy5QrscZop6QqaBQGj+EEaDdMeU7uGRANODtnyfTASizFGWy1
         Fg3Fmp+tvRr93PZBY8p/BheAJQ+Yv0pNhPkVtBvolEvs2Q+etadL3I78BnW7jBGpQ+G+
         z1Bb7BBcHt9t5zWvITgV36oQ8mbh+WUKq+8x4THULYN57dchYsx4vdheg+olH6GE8CwL
         ryTA==
X-Gm-Message-State: ABy/qLYxaH9sOfxIoE5nZeC2OCsuLyiyQ6k81fB+UG7nCI/IbeJTHAxC
	n7A9rAsPJcoi1Msyj9dSJHhf6b8L1WAv3H3O7fs=
X-Google-Smtp-Source: APBJJlG85NzsOttDJ/UurcwlcGUQL63+u2kUoYu6NefpfZ+1f85xOThvi9I95cGyw84Iqw0+8K3Zmwc2XS7ijae8jLg=
X-Received: by 2002:a2e:8689:0:b0:2b4:7f2e:a433 with SMTP id
 l9-20020a2e8689000000b002b47f2ea433mr6094626lji.36.1691009849068; Wed, 02 Aug
 2023 13:57:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230731111313.3745-1-laoar.shao@gmail.com> <20230731111313.3745-3-laoar.shao@gmail.com>
In-Reply-To: <20230731111313.3745-3-laoar.shao@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 2 Aug 2023 13:57:17 -0700
Message-ID: <CAADnVQJZNdr5Wg3xFsNqZEjkguiB7T9hLcmnf-rsPR-Cq2njTw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 2/2] selftests/bpf: Add selftest for fill_link_info
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 31, 2023 at 4:13=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> Add selftest for the fill_link_info of uprobe, kprobe and tracepoint.
> The result:
>
>   $ tools/testing/selftests/bpf/test_progs --name=3Dfill_link_info
>   #79/1    fill_link_info/kprobe_link_info:OK
>   #79/2    fill_link_info/kretprobe_link_info:OK
>   #79/3    fill_link_info/kprobe_fill_invalid_user_buff:OK
>   #79/4    fill_link_info/tracepoint_link_info:OK
>   #79/5    fill_link_info/uprobe_link_info:OK
>   #79/6    fill_link_info/uretprobe_link_info:OK
>   #79/7    fill_link_info/kprobe_multi_link_info:OK
>   #79/8    fill_link_info/kretprobe_multi_link_info:OK
>   #79/9    fill_link_info/kprobe_multi_ubuff:OK
>   #79      fill_link_info:OK
>   Summary: 1/9 PASSED, 0 SKIPPED, 0 FAILED
>
> The test case for kprobe_multi won't be run on aarch64, as it is not
> supported.
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  tools/testing/selftests/bpf/DENYLIST.aarch64       |   3 +
>  .../selftests/bpf/prog_tests/fill_link_info.c      | 369 +++++++++++++++=
++++++
>  .../selftests/bpf/progs/test_fill_link_info.c      |  42 +++
>  3 files changed, 414 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/fill_link_info=
.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_fill_link_info=
.c
>
> diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testing=
/selftests/bpf/DENYLIST.aarch64
> index 3b61e8b..b2f46b6 100644
> --- a/tools/testing/selftests/bpf/DENYLIST.aarch64
> +++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
> @@ -12,3 +12,6 @@ kprobe_multi_test/skel_api                       # libb=
pf: failed to load BPF sk
>  module_attach                                    # prog 'kprobe_multi': =
failed to auto-attach: -95
>  fentry_test/fentry_many_args                     # fentry_many_args:FAIL=
:fentry_many_args_attach unexpected error: -524
>  fexit_test/fexit_many_args                       # fexit_many_args:FAIL:=
fexit_many_args_attach unexpected error: -524
> +fill_link_info/kprobe_multi_link_info            # bpf_program__attach_k=
probe_multi_opts unexpected error: -95
> +fill_link_info/kretprobe_multi_link_info         # bpf_program__attach_k=
probe_multi_opts unexpected error: -95
> +fill_link_info/kprobe_multi_ubuff                # bpf_program__attach_k=
probe_multi_opts unexpected error: -95


BPF CI isn't happy, because s390 also needs to be updated?
We'll just mark patches as 'changes requested' next time without
explicit emails.

