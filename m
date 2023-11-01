Return-Path: <bpf+bounces-13852-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A5F7DE815
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 23:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9FAA2818EB
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 22:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1EE1C294;
	Wed,  1 Nov 2023 22:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYhkGBrr"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55FB1C289
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 22:24:50 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57DAA122
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 15:24:49 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9d0b4dfd60dso45947666b.1
        for <bpf@vger.kernel.org>; Wed, 01 Nov 2023 15:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698877488; x=1699482288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2lXfbyOQDDjmE5a4XPtR5ivMd1utX2ypMNLL2UdTELI=;
        b=gYhkGBrrLDUuVZRemXphfp9/FHj2uPU5IiSIrPlGsy+MuKkDF4Fs503alM50wcsJAW
         pA6XuoYIHE2bAF2z8V6Rp2RSEiC6lUjpwxjSQzm9GXCUljiDKlZjXUzlAiEmaK6fP/91
         xY/8opggdUZ1y4tvIMEUqdOS2san5YvGVZbjj+bp+rQ59Kh2dQpqJF0NqfH9p2O8sg4A
         VRXjMI8ljPiOlIKJEEyRGyC2wrTx4S4fg5IM61ILWwq8FTaTYylqvFuveej1wxVU2ghk
         d0WDl2xaTBwNtudm1S68I1C4Mz44aGji5PLhXz8Ufsz95eoWN4av5HjCh4Asfh2k1S6k
         TUOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698877488; x=1699482288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2lXfbyOQDDjmE5a4XPtR5ivMd1utX2ypMNLL2UdTELI=;
        b=OYXrHPGAogYo4SEsgqPhd4ITAeHGfMr63kGYcoEFDfKzW+BTtPnwvndhUOF6Jk+Sh3
         vi0rMChapf/uYkjqeBGBr1K+2rTWhkgI/LpRoUAJE75uWLUieeVGsBj581b0lp1kNU68
         IBuTb0nVH/Hxr/ncm23as2bqZjtNyn793byrFU8O19mUUghmPrDbQ6ee5TGfmrHVa8xG
         Z1jLblTk7XPOHxA0cGZtl/aNseGfz108F5Oqhj0sWWI34akdifEv8KcjGjOMWGnlHl5t
         X8LTe7Hy3SP0pcZnQ2R2rbHkEcVDEF6bn5iIT40zdbUwbPIC0q44ie9rkDbXorloJhkJ
         Q19g==
X-Gm-Message-State: AOJu0YzDHDuu2FJF8Z5VrwmszXeZLaSt5iXqH+NrvgGWm0gCe48XgXKQ
	+JVsLBGst0xTs5uNt0zKyMCruVVA25ejQlaQl3c=
X-Google-Smtp-Source: AGHT+IFDaJJTE1/u1DhgNtemnHE+0Ywx3eTf7kQ7mpnrYfQNmL78cr5iC007M4RLWYYKNfYsJE5ow0pcB5l1m2VXpnA=
X-Received: by 2002:a17:907:1c13:b0:9ae:37d9:803e with SMTP id
 nc19-20020a1709071c1300b009ae37d9803emr3866697ejc.8.1698877487718; Wed, 01
 Nov 2023 15:24:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025202420.390702-1-jolsa@kernel.org> <20231025202420.390702-5-jolsa@kernel.org>
In-Reply-To: <20231025202420.390702-5-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 1 Nov 2023 15:24:36 -0700
Message-ID: <CAEf4BzbKCtON6qry3qpoO5FdNbwMUWV7F2FHzHi+K34qBv3pjg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/6] selftests/bpf: Use bpf_link__destroy in
 fill_link_info tests
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Yafang Shao <laoar.shao@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 1:25=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
>
> The fill_link_info test keeps skeleton open and just creates
> various links. We are wrongly calling bpf_link__detach after
> each test to close them, we need to call bpf_link__destroy.
>
> Also we need to set the link NULL so the skeleton destroy
> won't try to destroy them again.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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

if we don't want skeleton to take care of these links, we shouldn't
assign them into skel->links region, IMO

so perhaps the proper fix is to have local bpf_link variable in these tests=
?

>  }
>
>  void test_fill_link_info(void)
> --
> 2.41.0
>

