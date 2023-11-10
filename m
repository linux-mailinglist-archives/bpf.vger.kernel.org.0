Return-Path: <bpf+bounces-14690-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBFD7E77D8
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 04:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BC831C20B17
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 03:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17561399;
	Fri, 10 Nov 2023 03:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dgcGbb3h"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5293015C5
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 03:00:44 +0000 (UTC)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1494229
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 19:00:43 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-6754b4091b6so9333336d6.3
        for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 19:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699585242; x=1700190042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0CQprBIT89yr4woUy6wILD1LDiQuucjGa+L5/x5rGyM=;
        b=dgcGbb3h3wt4uqEoXDjPnOnuKX2FEXI3n9dpzbrBFqA2JcQwJr5HebPH5kBpXHWr+C
         DKVzkGUooW3/uNWJbMR4hNmtcMn5itM7ykhIYxDdjCGj5Pea6u/aathSlcrGQahRRDF+
         TxosaAsmlSRlpQhiQPsGFRr/boKUNERdXrZDMlGko6C0yZXV7LrfJbugqQ1jwPhaPpmH
         lwEfIpD3pCOoeAvCUp6aqvD/sveijB6iFBapJNZYn2bLSCx4I4CV+T7/pUlBvdTit284
         1D+CInU/IEre6oon1MJ1DCol05KTUtyXSukK9JD25FhETiCY4qzSw/Bzw2gfo/TvnQJC
         mpEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699585242; x=1700190042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0CQprBIT89yr4woUy6wILD1LDiQuucjGa+L5/x5rGyM=;
        b=RTrofQ3F8VxmpzuU9eC4KNb3Y05n3c17DInwR3SRrtK72gpWE/4oek11YeDUJbNSvq
         +h10v8SBUy0kHJwE/LhqHiYiXLYBQxFk5Z0T9fWyu/UaIEXQrWOdcj6Cn5JOSWrr8e9o
         /9JFHW9vo7BvNxiwZBPK5l58gK5ivs6aDteOAxOkrMwUb3XMuFciXU1h1w4Rm0Z4bWSM
         ZwMh+8TVY0vCGpNh+BNzlnhtJsRPGmig7qpxM+B7I+1Tlar3ZGtnOEBPLSIFcqBZp6R4
         pDqykeOoJ0Lu6bRTyTEx5qAt8karflBSKxKjW5ssMuuYFu4GgI3U9LbDiIBqaejSUVv+
         oFeA==
X-Gm-Message-State: AOJu0Yyzcu038ruTh3BbywhmjRWfsE+Qz3UeH4bxXJR4uzJqTwm7JLpM
	APsP9ALdA2kVXyqPMrpr9k06cHvdYTIJSPZ0en8=
X-Google-Smtp-Source: AGHT+IGAHEAuuRTrltZFHr/7qu2XOcTDCLDt2mUvEaI+rBb7TPcT1e8PNXEXr0biYeahcUi+uQaWlTNVEe7yYEN6YIw=
X-Received: by 2002:a05:6214:2427:b0:66d:1215:6e3 with SMTP id
 gy7-20020a056214242700b0066d121506e3mr8601922qvb.10.1699585242517; Thu, 09
 Nov 2023 19:00:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231109092838.721233-1-jolsa@kernel.org> <20231109092838.721233-5-jolsa@kernel.org>
In-Reply-To: <20231109092838.721233-5-jolsa@kernel.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 10 Nov 2023 11:00:04 +0800
Message-ID: <CALOAHbCeQEsDG-9nKwywZqYTaCvj7ZbiVsjovU6V-JoQg0dTbw@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 4/6] selftests/bpf: Use bpf_link__destroy in
 fill_link_info tests
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 9, 2023 at 5:29=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
>
> The fill_link_info test keeps skeleton open and just creates
> various links. We are wrongly calling bpf_link__detach after
> each test to close them, we need to call bpf_link__destroy.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

I've just realized that we can use a local link for this particular scenari=
o :)
Feel free to add:

Acked-by: Yafang Shao <laoar.shao@gmail.com>

> ---
>  .../selftests/bpf/prog_tests/fill_link_info.c | 44 ++++++++++---------
>  1 file changed, 23 insertions(+), 21 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c b/to=
ols/testing/selftests/bpf/prog_tests/fill_link_info.c
> index 97142a4db374..9294cb8d7743 100644
> --- a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
> +++ b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
> @@ -140,14 +140,14 @@ static void test_kprobe_fill_link_info(struct test_=
fill_link_info *skel,
>                 .retprobe =3D type =3D=3D BPF_PERF_EVENT_KRETPROBE,
>         );
>         ssize_t entry_offset =3D 0;
> +       struct bpf_link *link;
>         int link_fd, err;
>
> -       skel->links.kprobe_run =3D bpf_program__attach_kprobe_opts(skel->=
progs.kprobe_run,
> -                                                                KPROBE_F=
UNC, &opts);
> -       if (!ASSERT_OK_PTR(skel->links.kprobe_run, "attach_kprobe"))
> +       link =3D bpf_program__attach_kprobe_opts(skel->progs.kprobe_run, =
KPROBE_FUNC, &opts);
> +       if (!ASSERT_OK_PTR(link, "attach_kprobe"))
>                 return;
>
> -       link_fd =3D bpf_link__fd(skel->links.kprobe_run);
> +       link_fd =3D bpf_link__fd(link);
>         if (!invalid) {
>                 /* See also arch_adjust_kprobe_addr(). */
>                 if (skel->kconfig->CONFIG_X86_KERNEL_IBT)
> @@ -157,39 +157,41 @@ static void test_kprobe_fill_link_info(struct test_=
fill_link_info *skel,
>         } else {
>                 kprobe_fill_invalid_user_buffer(link_fd);
>         }
> -       bpf_link__detach(skel->links.kprobe_run);
> +       bpf_link__destroy(link);
>  }
>
>  static void test_tp_fill_link_info(struct test_fill_link_info *skel)
>  {
> +       struct bpf_link *link;
>         int link_fd, err;
>
> -       skel->links.tp_run =3D bpf_program__attach_tracepoint(skel->progs=
.tp_run, TP_CAT, TP_NAME);
> -       if (!ASSERT_OK_PTR(skel->links.tp_run, "attach_tp"))
> +       link =3D bpf_program__attach_tracepoint(skel->progs.tp_run, TP_CA=
T, TP_NAME);
> +       if (!ASSERT_OK_PTR(link, "attach_tp"))
>                 return;
>
> -       link_fd =3D bpf_link__fd(skel->links.tp_run);
> +       link_fd =3D bpf_link__fd(link);
>         err =3D verify_perf_link_info(link_fd, BPF_PERF_EVENT_TRACEPOINT,=
 0, 0, 0);
>         ASSERT_OK(err, "verify_perf_link_info");
> -       bpf_link__detach(skel->links.tp_run);
> +       bpf_link__destroy(link);
>  }
>
>  static void test_uprobe_fill_link_info(struct test_fill_link_info *skel,
>                                        enum bpf_perf_event_type type)
>  {
> +       struct bpf_link *link;
>         int link_fd, err;
>
> -       skel->links.uprobe_run =3D bpf_program__attach_uprobe(skel->progs=
.uprobe_run,
> -                                                           type =3D=3D B=
PF_PERF_EVENT_URETPROBE,
> -                                                           0, /* self pi=
d */
> -                                                           UPROBE_FILE, =
uprobe_offset);
> -       if (!ASSERT_OK_PTR(skel->links.uprobe_run, "attach_uprobe"))
> +       link =3D bpf_program__attach_uprobe(skel->progs.uprobe_run,
> +                                         type =3D=3D BPF_PERF_EVENT_URET=
PROBE,
> +                                         0, /* self pid */
> +                                         UPROBE_FILE, uprobe_offset);
> +       if (!ASSERT_OK_PTR(link, "attach_uprobe"))
>                 return;
>
> -       link_fd =3D bpf_link__fd(skel->links.uprobe_run);
> +       link_fd =3D bpf_link__fd(link);
>         err =3D verify_perf_link_info(link_fd, type, 0, uprobe_offset, 0)=
;
>         ASSERT_OK(err, "verify_perf_link_info");
> -       bpf_link__detach(skel->links.uprobe_run);
> +       bpf_link__destroy(link);
>  }
>
>  static int verify_kmulti_link_info(int fd, bool retprobe)
> @@ -278,24 +280,24 @@ static void test_kprobe_multi_fill_link_info(struct=
 test_fill_link_info *skel,
>                                              bool retprobe, bool invalid)
>  {
>         LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
> +       struct bpf_link *link;
>         int link_fd, err;
>
>         opts.syms =3D kmulti_syms;
>         opts.cnt =3D KMULTI_CNT;
>         opts.retprobe =3D retprobe;
> -       skel->links.kmulti_run =3D bpf_program__attach_kprobe_multi_opts(=
skel->progs.kmulti_run,
> -                                                                      NU=
LL, &opts);
> -       if (!ASSERT_OK_PTR(skel->links.kmulti_run, "attach_kprobe_multi")=
)
> +       link =3D bpf_program__attach_kprobe_multi_opts(skel->progs.kmulti=
_run, NULL, &opts);
> +       if (!ASSERT_OK_PTR(link, "attach_kprobe_multi"))
>                 return;
>
> -       link_fd =3D bpf_link__fd(skel->links.kmulti_run);
> +       link_fd =3D bpf_link__fd(link);
>         if (!invalid) {
>                 err =3D verify_kmulti_link_info(link_fd, retprobe);
>                 ASSERT_OK(err, "verify_kmulti_link_info");
>         } else {
>                 verify_kmulti_invalid_user_buffer(link_fd);
>         }
> -       bpf_link__detach(skel->links.kmulti_run);
> +       bpf_link__destroy(link);
>  }
>
>  void test_fill_link_info(void)
> --
> 2.41.0
>


--=20
Regards
Yafang

