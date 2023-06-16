Return-Path: <bpf+bounces-2728-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D3D7336B8
	for <lists+bpf@lfdr.de>; Fri, 16 Jun 2023 18:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 598AC1C21013
	for <lists+bpf@lfdr.de>; Fri, 16 Jun 2023 16:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0137919E69;
	Fri, 16 Jun 2023 16:53:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38A913AC6
	for <bpf@vger.kernel.org>; Fri, 16 Jun 2023 16:53:44 +0000 (UTC)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C94A4ED5
	for <bpf@vger.kernel.org>; Fri, 16 Jun 2023 09:53:25 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b45a71c9caso11114251fa.3
        for <bpf@vger.kernel.org>; Fri, 16 Jun 2023 09:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686934393; x=1689526393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eYB+h7FcMyfPq2tug+zPFjkFmKHYe7UKU9BeWIK1a68=;
        b=hzALOmgK9MzC+Kh/9ste4+yuqlA4YyhhyVBiDl3RUHlF3jbA1Sw7sXT/6/Lo/umhpx
         4nPbvy7cA0Ofc4oX+WwAsov9gKxXtI+ewCziDFoIlFwiABL8aldPUwyLMxH2kKZFgrLA
         w67MqKzMY75NZqqAxQhbO3CzdV/tee4Iauwuo1BUDmEoOkT3+GE+xWlMd1r3sH/9v7Hj
         Yad6rTzUerW2mk26DCkWkmolpQe0EUIRZo+dSlrd9aBwOiGNYQEl2w8v4VjRwaHwbs1Z
         ASMf9RxuF3dBjrgRNGAwkxwJLacKSvbM+pC3gJK9HpLye+xCc8PflzMzxSwfKeZ8df9e
         I6lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686934393; x=1689526393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eYB+h7FcMyfPq2tug+zPFjkFmKHYe7UKU9BeWIK1a68=;
        b=PMDBxb+owA9KmBwqCaHMCS2h9413afvmOGKranXg6TKUHZVQq+tpLIRsLWQi2MYITu
         0fm5gAJlBWrm0Zqj+HMdYO3Gz2mqH+SGYUrrc8dSs3AVKHAWV+UhoCvO2acHwiMPaTeq
         oedfZO+SxxaGM9DgUBJJ2EjyfrN/JcnIVWXxaozVHuJmBIL9pukc5xrvEv9wlI9KnjLd
         jeOLAayBIjeK9IV0SE7ulPb6lcY8yxCjgI4gHfYlHRnBlHMc0bWa/sSB8pzSvb8CWju2
         cNF8SU6uMuikDZdjRokppjt5z4yXygL3U6DmyD8cROkTRGbRDN1YqGxDn/54Th4j4GaQ
         ZqXg==
X-Gm-Message-State: AC+VfDzQvafZJphJKU4E75uOxhDNAhN9iERDdFl1gZ+Oir0N7qgg/qTv
	q9uTRaRTMQGuA9m30HpRhw2itz+wxB/+PXgKH1w=
X-Google-Smtp-Source: ACHHUZ752JyquLhQqQ7+EKChQiGoCqhRAU+y00aVofvUTwiKnnkSH1XL8gpaetw/GOpbtohqAdRhSIZGe4jjfF6bnXU=
X-Received: by 2002:a2e:878c:0:b0:2b1:d34d:4e08 with SMTP id
 n12-20020a2e878c000000b002b1d34d4e08mr2191455lji.6.1686934392558; Fri, 16 Jun
 2023 09:53:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230613113119.2348619-1-jolsa@kernel.org>
In-Reply-To: <20230613113119.2348619-1-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 16 Jun 2023 09:53:00 -0700
Message-ID: <CAEf4BzaoecaejztBK9O+hbh1d-g_iTSXgpDrJAZmcaWYiWBn3Q@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Force kprobe multi expected_attach_type for
 kprobe_multi link
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

On Tue, Jun 13, 2023 at 4:31=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> We currently allow to create perf link for program with
> expected_attach_type =3D=3D BPF_TRACE_KPROBE_MULTI.
>
> This will cause crash when we call helpers like get_attach_cookie or
> get_func_ip in such program, because it will call the kprobe_multi's
> version (current->bpf_ctx context setup) of those helpers while it
> expects perf_link's current->bpf_ctx context setup.
>
> Making sure that we use BPF_TRACE_KPROBE_MULTI expected_attach_type
> only for programs attaching through kprobe_multi link.
>
> Fixes: ca74823c6e16 ("bpf: Add cookie support to programs attached with k=
probe multi link")
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  kernel/bpf/syscall.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 0c21d0d8efe4..e8fe04a5db93 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -4675,6 +4675,11 @@ static int link_create(union bpf_attr *attr, bpfpt=
r_t uattr)
>                 ret =3D bpf_perf_link_attach(attr, prog);
>                 break;
>         case BPF_PROG_TYPE_KPROBE:
> +               if (prog->expected_attach_type =3D=3D BPF_TRACE_KPROBE_MU=
LTI &&
> +                   attr->link_create.attach_type !=3D BPF_TRACE_KPROBE_M=
ULTI) {
> +                       ret =3D -EINVAL;
> +                       goto out;
> +               }

there is a separate expected attach type validation switch above this,
shouldn't this go there? We also have
bpf_prog_attach_check_attach_type() call above as well, and tbh by now
I'm not sure why we have like three places to check conditions like
this... But I'd put this check in either
bpf_prog_attach_check_attach_type() or in the dedicated switch for
attach_type checks.


>                 if (attr->link_create.attach_type =3D=3D BPF_PERF_EVENT)
>                         ret =3D bpf_perf_link_attach(attr, prog);
>                 else
> --
> 2.40.1
>

