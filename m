Return-Path: <bpf+bounces-10147-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC847A216B
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 16:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04B9D281E68
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 14:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4942130D14;
	Fri, 15 Sep 2023 14:49:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629B430CE1
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 14:49:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4C06C433C8
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 14:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694789381;
	bh=TS2bBM6iIT+o9NZg5Tu4DOXTg/fs74AUsRoKi8Xbil4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IoGuXK1TAWj6ghbAgWwSP4+OEr3PrDoCsw0RtiwqeSZGzzQQ4QcctW9/eSju0IQIG
	 Ziw7oWdFauh2EG0s1c+usfgXc/CRhwaqsg98ckr0GQjU+eoGhhSBODnpEOjUveauUF
	 K2Ivpf9RSIfSuyhIE8v7IxEWk8F2vstFxJr22m8AsXLMNEmfLBXnDAi4K41pIB0RXL
	 Ry7PvCCC6Cq25IdbPOLHetNy5Nq0BWiJqIM7gR8qmMY9hB+KUXACwoY6pD2O1cpyVP
	 h82BL/FET1nNm/AHSb5CRUamiO9RcakDhrgwiYz9d6NVxA4FXqFnsnjEktTHU50IfM
	 TZIhhzod6OVFg==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5029ace4a28so3978691e87.1
        for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 07:49:41 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy39utYEJMWVfSbqFzs9MucFQ1vafhVdEFOmFOR6DKBQwhDWhav
	SzvqGbj6LZl0WKAnzuyN9snEe7puIyaOOYUccYc=
X-Google-Smtp-Source: AGHT+IF25Nz01o6+JvYEKczOc1iY9j8Tv+wnM7f5rXnSru2hewTtoENd7K1mgtW2uKRO1r4AMyc8wvoKU0Wcw0+GTqQ=
X-Received: by 2002:a05:6512:2343:b0:502:df19:83b3 with SMTP id
 p3-20020a056512234300b00502df1983b3mr1899337lfu.10.1694789380075; Fri, 15 Sep
 2023 07:49:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230915101420.1193800-1-jolsa@kernel.org>
In-Reply-To: <20230915101420.1193800-1-jolsa@kernel.org>
From: Song Liu <song@kernel.org>
Date: Fri, 15 Sep 2023 07:49:27 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7FeiA+9B61-F+-fbfiV18sx21f0FqAmnfCyWyDB1CJtA@mail.gmail.com>
Message-ID: <CAPhsuW7FeiA+9B61-F+-fbfiV18sx21f0FqAmnfCyWyDB1CJtA@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Fix uprobe_multi get_pid_task error path
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>, bpf@vger.kernel.org, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 15, 2023 at 3:14=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Dan reported Smatch static checker warning due to missing error
> value set in uprobe multi link's get_pid_task error path.
>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/bpf/c5ffa7c0-6b06-40d5-aca2-63833b5cd9af@=
moroto.mountain/
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Reviewed-by: Song Liu <song@kernel.org>

> ---
>  kernel/trace/bpf_trace.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index c1c1af63ced2..868008f56fec 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -3223,8 +3223,10 @@ int bpf_uprobe_multi_link_attach(const union bpf_a=
ttr *attr, struct bpf_prog *pr
>                 rcu_read_lock();
>                 task =3D get_pid_task(find_vpid(pid), PIDTYPE_PID);
>                 rcu_read_unlock();
> -               if (!task)
> +               if (!task) {
> +                       err =3D -ESRCH;
>                         goto error_path_put;
> +               }
>         }
>
>         err =3D -ENOMEM;
> --
> 2.41.0
>
>

