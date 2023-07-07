Return-Path: <bpf+bounces-4398-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2714974A9F5
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 06:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6AD4281659
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 04:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E2C1FAB;
	Fri,  7 Jul 2023 04:33:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F59615C2
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 04:33:55 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167BC1BC9
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 21:33:54 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fbc59de0e2so15392575e9.3
        for <bpf@vger.kernel.org>; Thu, 06 Jul 2023 21:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688704432; x=1691296432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wB+VASNKnPuE7rr3XetvEi9C9gvqFrMfD0m1yeILKlI=;
        b=j9eKp4AXH0JyGxeSoGD/PBsqbFJDynXHYyTxw248zIOlLxmhJPRsDww+ogD8civ1AZ
         faiM7MgkzWp0+kneCxMTttqWgiOxeCMgjFKqHTG28Uw2rzNPcXi6SOOiC1iwCuFmEzVc
         Q3KasLC9JM2YnX9NO3l/xSLSO9opHeWeyuFHwSBNo5j0cwvPF+JeT2Tz1h7kG9GE/wPP
         5oJ57lbs3P/on/fShJzxSSSjTyDzSawpnN5WOrl1W6xD5RAImVh3XTmesbDCoaDoeyMD
         4F2eYQC1ohBmHJ83Y7YeTl1T4Y1/3hjZsgXbQ96N1QUVdz0lNJ8PlxQPXW7Dwy5XFIPi
         MKFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688704432; x=1691296432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wB+VASNKnPuE7rr3XetvEi9C9gvqFrMfD0m1yeILKlI=;
        b=lMxxqC8jIC/XXPB65aWBa5tzNix82Typ8xxPGEk11TZ5It8IJd46xdm6E1sTLt2y5x
         +nJo9VsYz66BwAKa4FeWvuzVOGmxYdx7rgR5di4ESKEVH+zZNCZo1V+YShFWUgPrUJBg
         q+Vdpbt7jar2O5klO0EwTVFdzfMr5i1mBcLaxF7z5ljZRBZ9cXOFYkMBMusytItozVCk
         f1+Pk8Ucr6fKK2BZevmisEoBC2ALARrVPohHAIgzaPy3DYf7nyx0mHpBcYFvxXtlIsE3
         peeplCWvFF9BKViUFjfbJZvr74h6P4w1XuRA1jnOlbDyJIawoARi6Nzp3SBLV/J2riVf
         GGxQ==
X-Gm-Message-State: ABy/qLbZlEFfucR0nChqM1BfxwH3vWSm8j/3lKxqDbaCOfgHESUOKq18
	GakHqiyYZi6G5lzE4gO4VwhZPkRxswvSxQFLZ1b0T0oVKLY=
X-Google-Smtp-Source: APBJJlFUn6fDq6OaiwbjIrVDUEgs/VQRgJlZxbUarVvqud0hnphXyVVwkUEJ/bJW83oLO/E9aZEuV2cXI1ymPQKi57E=
X-Received: by 2002:a05:600c:22d1:b0:3fa:8c67:fc43 with SMTP id
 17-20020a05600c22d100b003fa8c67fc43mr2748207wmg.32.1688704432388; Thu, 06 Jul
 2023 21:33:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230630083344.984305-1-jolsa@kernel.org> <20230630083344.984305-20-jolsa@kernel.org>
In-Reply-To: <20230630083344.984305-20-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 6 Jul 2023 21:33:40 -0700
Message-ID: <CAEf4Bzbgvt3aCZmx2zTn4tFuHmc6AgfN1=uSdriBb8bnCzyb3g@mail.gmail.com>
Subject: Re: [PATCHv3 bpf-next 19/26] selftests/bpf: Add uprobe_multi link test
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 30, 2023 at 1:37=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding uprobe_multi test for bpf_link_create attach function.
>
> Testing attachment using the struct bpf_link_create_opts.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  .../bpf/prog_tests/uprobe_multi_test.c        | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>

[...]

> +       opts.kprobe_multi.flags =3D BPF_F_UPROBE_MULTI_RETURN;
> +       prog_fd =3D bpf_program__fd(skel->progs.test_uretprobe);
> +       link2_fd =3D bpf_link_create(prog_fd, 0, BPF_TRACE_UPROBE_MULTI, =
&opts);
> +       if (!ASSERT_GE(link2_fd, 0, "link2_fd"))
> +               goto cleanup;
> +
> +       opts.kprobe_multi.flags =3D 0;
> +       prog_fd =3D bpf_program__fd(skel->progs.test_uprobe_sleep);
> +       link3_fd =3D bpf_link_create(prog_fd, 0, BPF_TRACE_UPROBE_MULTI, =
&opts);
> +       if (!ASSERT_GE(link1_fd, 0, "link3_fd"))

link3_fd

> +               goto cleanup;
> +
> +       opts.kprobe_multi.flags =3D BPF_F_UPROBE_MULTI_RETURN;
> +       prog_fd =3D bpf_program__fd(skel->progs.test_uretprobe_sleep);
> +       link4_fd =3D bpf_link_create(prog_fd, 0, BPF_TRACE_UPROBE_MULTI, =
&opts);
> +       if (!ASSERT_GE(link2_fd, 0, "link4_fd"))

link4_fd

> +               goto cleanup;
> +       uprobe_multi_test_run(skel);
> +
> +cleanup:
> +       if (link1_fd >=3D 0)
> +               close(link1_fd);
> +       if (link2_fd >=3D 0)
> +               close(link2_fd);
> +       if (link3_fd >=3D 0)
> +               close(link3_fd);
> +       if (link4_fd >=3D 0)
> +               close(link4_fd);
> +
> +       uprobe_multi__destroy(skel);
> +       free(offsets);
> +}
> +
>  void test_uprobe_multi_test(void)
>  {
>         if (test__start_subtest("skel_api"))
> @@ -144,4 +210,6 @@ void test_uprobe_multi_test(void)
>                 test_attach_api_pattern();
>         if (test__start_subtest("attach_api_syms"))
>                 test_attach_api_syms();
> +       if (test__start_subtest("link_api"))
> +               test_link_api();
>  }
> --
> 2.41.0
>

