Return-Path: <bpf+bounces-13309-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2B57D81F2
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 13:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBD39B2135C
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 11:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236502D784;
	Thu, 26 Oct 2023 11:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fB6O5mQ5"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EAF286B2
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 11:42:12 +0000 (UTC)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69481A6
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 04:42:10 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-66d11fec9a5so5470786d6.1
        for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 04:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698320530; x=1698925330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aTHE5JsH+OSuQIz04id+Xdenoq0dG5qfzi9WDqlXutA=;
        b=fB6O5mQ5yT7xu9VXl+umi3T97drf2thz2RO2ii3DcsZXFSgAwpGIrC1GgE76eAQsvm
         2CJO9VbDbc7QWlGUIViXtk2Knv3LYSgWT4Sw66L7jcW3VG+G7WiRBjUOtG0UpyqJvu4n
         Mc5+SvCAcLxpe8T1YYuR9sQWmjADSyG9mYAFh1P5pK2Hu2KOye8NTG3XOW7tnxviDD+J
         FhRdrZjzexcz40fYNQi77gMMkmT3uDV4Gurd4qw9z5UAVA8yFGdGk/fqMiDwhAq5hAcC
         E5pjGuzuc45sLgJUPq9TwVl1CeKCZXCX9MjzDPb3dAKqtFqPbTARIxLEzWe1MVLhTdTf
         SYTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698320530; x=1698925330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aTHE5JsH+OSuQIz04id+Xdenoq0dG5qfzi9WDqlXutA=;
        b=Fr+kY+rU/9JSquKwusMiq6Swz7P3JrESf1usBWo6Z/3uQYS1jHk/J6V8XnUG9R4pas
         5OBX0vZDdEPqPtg/TvfdfyLqRqlrp+t/mUybaEBUMWu0/dsQBpuBTrdBrZAkafAzuAWe
         sfOOEhzKkxEHema4Jj23/GjKP7ZtCIYnrddqvWDOni+dUTK79raMEYn/CYLO56Yqosbd
         fDIDTtadUGhEqjWlWUQRZ2QZZXQEECtVs1DjFJ6GWa11J/WIkNc488cXDPZJRkxpeCZQ
         zBrvBUatvF0wuFWK3Kct/ZAWxTdXcAD2xL+5OY/PDHdUyIbHuxRgtkuizY+6H6+SHnBr
         bglw==
X-Gm-Message-State: AOJu0Yypsd+7LEErYnYDBMPqOaZwINPWfYgc7iyfEjxbkNA0h/QK/RI0
	Xh1y/zbB2xpamg3oJtyw3C/ldk6j1hqj0xrlUd0=
X-Google-Smtp-Source: AGHT+IHN7km9cul+oMZevYcz4Q61HLe/xygHXxh9DWD89HLKsxXgG7P9OGt2Uup4HAequUQ+S8C0upSCPOz6CE7y46w=
X-Received: by 2002:ad4:5b8b:0:b0:66d:61c3:8ca4 with SMTP id
 11-20020ad45b8b000000b0066d61c38ca4mr18008886qvp.15.1698320529795; Thu, 26
 Oct 2023 04:42:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025202420.390702-1-jolsa@kernel.org> <20231025202420.390702-5-jolsa@kernel.org>
In-Reply-To: <20231025202420.390702-5-jolsa@kernel.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 26 Oct 2023 19:41:33 +0800
Message-ID: <CALOAHbC52fMNvvwsjJHZb26seQjQSZ4oNOLiWp3+3Q+JNmJckw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/6] selftests/bpf: Use bpf_link__destroy in
 fill_link_info tests
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 4:25=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> The fill_link_info test keeps skeleton open and just creates
> various links. We are wrongly calling bpf_link__detach after
> each test to close them, we need to call bpf_link__destroy.
>
> Also we need to set the link NULL so the skeleton destroy
> won't try to destroy them again.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Yafang Shao <laoar.shao@gmail.com>

> ---
>  .../selftests/bpf/prog_tests/fill_link_info.c       | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c b/to=
ols/testing/selftests/bpf/prog_tests/fill_link_info.c
> index 97142a4db374..0379872c445a 100644
> --- a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
> +++ b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
> @@ -22,6 +22,11 @@ static __u64 kmulti_addrs[KMULTI_CNT];
>  #define KPROBE_FUNC "bpf_fentry_test1"
>  static __u64 kprobe_addr;
>
> +#define LINK_DESTROY(__link) ({                \
> +       bpf_link__destroy(__link);      \
> +       __link =3D NULL;                  \
> +})
> +
>  #define UPROBE_FILE "/proc/self/exe"
>  static ssize_t uprobe_offset;
>  /* uprobe attach point */
> @@ -157,7 +162,7 @@ static void test_kprobe_fill_link_info(struct test_fi=
ll_link_info *skel,
>         } else {
>                 kprobe_fill_invalid_user_buffer(link_fd);
>         }
> -       bpf_link__detach(skel->links.kprobe_run);
> +       LINK_DESTROY(skel->links.kprobe_run);
>  }
>
>  static void test_tp_fill_link_info(struct test_fill_link_info *skel)
> @@ -171,7 +176,7 @@ static void test_tp_fill_link_info(struct test_fill_l=
ink_info *skel)
>         link_fd =3D bpf_link__fd(skel->links.tp_run);
>         err =3D verify_perf_link_info(link_fd, BPF_PERF_EVENT_TRACEPOINT,=
 0, 0, 0);
>         ASSERT_OK(err, "verify_perf_link_info");
> -       bpf_link__detach(skel->links.tp_run);
> +       LINK_DESTROY(skel->links.tp_run);
>  }
>
>  static void test_uprobe_fill_link_info(struct test_fill_link_info *skel,
> @@ -189,7 +194,7 @@ static void test_uprobe_fill_link_info(struct test_fi=
ll_link_info *skel,
>         link_fd =3D bpf_link__fd(skel->links.uprobe_run);
>         err =3D verify_perf_link_info(link_fd, type, 0, uprobe_offset, 0)=
;
>         ASSERT_OK(err, "verify_perf_link_info");
> -       bpf_link__detach(skel->links.uprobe_run);
> +       LINK_DESTROY(skel->links.uprobe_run);
>  }
>
>  static int verify_kmulti_link_info(int fd, bool retprobe)
> @@ -295,7 +300,7 @@ static void test_kprobe_multi_fill_link_info(struct t=
est_fill_link_info *skel,
>         } else {
>                 verify_kmulti_invalid_user_buffer(link_fd);
>         }
> -       bpf_link__detach(skel->links.kmulti_run);
> +       LINK_DESTROY(skel->links.kmulti_run);
>  }
>
>  void test_fill_link_info(void)
> --
> 2.41.0
>


--=20
Regards
Yafang

