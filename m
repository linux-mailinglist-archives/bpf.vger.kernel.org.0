Return-Path: <bpf+bounces-4397-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0398974A9F2
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 06:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33CB11C20F3D
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 04:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF841FAB;
	Fri,  7 Jul 2023 04:32:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B215DEA0
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 04:32:33 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89D21FEC
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 21:32:29 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fbfa811667so4436765e9.1
        for <bpf@vger.kernel.org>; Thu, 06 Jul 2023 21:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688704348; x=1691296348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xtDYyQxDNgl2Au/rbmT+E7IdGoiOkXpjx9DSBLgMod8=;
        b=scQQ0/zNdlw0YPcjmp4TmZIeTjCMFRf1QaEBxO0mN2QC1RRLr977YZghEHcEUSe4Da
         pZ0CRmNhQx5+ZZvwtzeXsr+IytJJKNXT3RSt2sN/gRNUlFkgvfFrZTRLb8WV6GSkif6s
         R1A+viE+DzmZmAGKmLxRbB1f91jGq8SCdgR1Yfo8GlDYYesgF+GDLTHC/lTv9lOOnei+
         N2wya1TWS+6ekbzZVcqbQBDdSpTl3KD1V8ctbmSj1/AJ0A+gmdI4rBejWV+ZAqjvqO5j
         Tr4ZMsMn8hMKWq6iLQN4MYtHI5zxxn2CbD9ZNL4+P7t2qNHPXjwiQVim0/453DZjUSPH
         ARPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688704348; x=1691296348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xtDYyQxDNgl2Au/rbmT+E7IdGoiOkXpjx9DSBLgMod8=;
        b=LyRQuYhdmxkSpGf5Zq/YC2WDbhZgdjE7KgLjMPlWkh+rzMgK2wJZgt1pl/JTOpV02s
         XrE8QzsXPIRks3YXnsqz/zouyO21jbKGC63qjq2YE2/ENPhXFr51RDcW6HjBJe10ao/N
         rpqW3hgIwhMYmOnnDoNFu0rvW4StoH//BrFvN9r1mNNq/+4gugmiAholnF6HHlIIA/iy
         GmqBnl21kAlf/C1AetWzF1dFXYLkB+1PN+J8aLwqaTEmdKmV8LoXHYQUUteYAFrBeH88
         DFPd4GEpzFr0vy7Hmm5cmv7IjZY78rDzQdqbxY8FQmn9xM5jBs4VKXgACq21aoYhmu4C
         yR8w==
X-Gm-Message-State: ABy/qLayPY98SSyl7C588iSmQpj3oQbInJ6jxNT2JppMd1+YfIRoBgI3
	zl2IwYTz5ewEwPreiFpnng1J01psYfHQXNbWISxRIM9+FZQ=
X-Google-Smtp-Source: APBJJlFlXEZ2sDcSOAewBAD69YvApbUsln+ARlGQGEAHS19uCzWGhFo/ugCYrZiv7n2cpcShE6eLr7QKO8kq6zQhiDY=
X-Received: by 2002:a05:600c:2207:b0:3f7:e660:cdc5 with SMTP id
 z7-20020a05600c220700b003f7e660cdc5mr3559266wml.9.1688704347771; Thu, 06 Jul
 2023 21:32:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230630083344.984305-1-jolsa@kernel.org> <20230630083344.984305-19-jolsa@kernel.org>
In-Reply-To: <20230630083344.984305-19-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 6 Jul 2023 21:32:15 -0700
Message-ID: <CAEf4BzYhfSZgWSRSn4QUm+k0JMzqUd0R_ud5-DVL0Lm1GmvOWA@mail.gmail.com>
Subject: Re: [PATCHv3 bpf-next 18/26] selftests/bpf: Add uprobe_multi api test
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
> Adding uprobe_multi test for bpf_program__attach_uprobe_multi
> attach function.
>
> Testing attachment using glob patterns and via bpf_uprobe_multi_opts
> paths/syms fields.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  .../bpf/prog_tests/uprobe_multi_test.c        | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b=
/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> index 5cd1116bbb62..f97a68871e73 100644
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> @@ -69,8 +69,79 @@ static void test_skel_api(void)
>         uprobe_multi__destroy(skel);
>  }
>
> +static void
> +test_attach_api(const char *binary, const char *pattern, struct bpf_upro=
be_multi_opts *opts)
> +{
> +       struct bpf_link *link1 =3D NULL, *link2 =3D NULL;
> +       struct bpf_link *link3 =3D NULL, *link4 =3D NULL;
> +       struct uprobe_multi *skel =3D NULL;
> +
> +       skel =3D uprobe_multi__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "uprobe_multi__open_and_load"))
> +               goto cleanup;
> +
> +       opts->retprobe =3D false;
> +       link1 =3D bpf_program__attach_uprobe_multi(skel->progs.test_uprob=
e, -1,
> +                                                     binary, pattern, op=
ts);
> +       if (!ASSERT_OK_PTR(link1, "bpf_program__attach_uprobe_multi"))
> +               goto cleanup;
> +
> +       opts->retprobe =3D true;
> +       link2 =3D bpf_program__attach_uprobe_multi(skel->progs.test_uretp=
robe, -1,
> +                                                     binary, pattern, op=
ts);
> +       if (!ASSERT_OK_PTR(link2, "bpf_program__attach_uprobe_multi_retpr=
obe"))
> +               goto cleanup;
> +
> +       opts->retprobe =3D false;
> +       link3 =3D bpf_program__attach_uprobe_multi(skel->progs.test_uprob=
e_sleep, -1,
> +                                                     binary, pattern, op=
ts);
> +       if (!ASSERT_OK_PTR(link1, "bpf_program__attach_uprobe_multi"))

link3

> +               goto cleanup;
> +
> +       opts->retprobe =3D true;
> +       link4 =3D bpf_program__attach_uprobe_multi(skel->progs.test_uretp=
robe_sleep, -1,
> +                                                     binary, pattern, op=
ts);
> +       if (!ASSERT_OK_PTR(link2, "bpf_program__attach_uprobe_multi_retpr=
obe"))

link4

> +               goto cleanup;
> +
> +       uprobe_multi_test_run(skel);
> +
> +cleanup:
> +       bpf_link__destroy(link4);
> +       bpf_link__destroy(link3);
> +       bpf_link__destroy(link2);
> +       bpf_link__destroy(link1);

you could have used
skel->links.{test_uprobe,test_uretprobe,test_uprobe_sleep,test_uretprobe_sl=
eep}
"containers" to not manage destruction of these links manually

> +       uprobe_multi__destroy(skel);
> +}
> +
> +static void test_attach_api_pattern(void)
> +{
> +       LIBBPF_OPTS(bpf_uprobe_multi_opts, opts);
> +
> +       test_attach_api("/proc/self/exe", "uprobe_multi_func_*", &opts);
> +       test_attach_api("/proc/self/exe", "uprobe_multi_func_?", &opts);
> +}
> +

[...]

