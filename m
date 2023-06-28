Return-Path: <bpf+bounces-3671-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A46E27417C3
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 20:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D86541C203B1
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 18:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E720D52A;
	Wed, 28 Jun 2023 18:03:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F956D518
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 18:03:11 +0000 (UTC)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD0CED;
	Wed, 28 Jun 2023 11:03:06 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b698937f85so1404131fa.2;
        Wed, 28 Jun 2023 11:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687975385; x=1690567385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wtrqVXZyrVo6nVpul5ot1RJ1MamLe48pX5okyndgaqo=;
        b=MNKpzHLoDlf3fwJ6yvt9iIiaWnJMsGrP6PyAQn5G/Mu/rHXC4CnE3/88JI7wwbPsLA
         NDhQQKT/bh4SYrvW1+eZDFeFv2FiJjdEgyjBmM2QlT5JJmdcuAn0a2+MhA9VzwADvK9a
         UKwraRkWMENZmJnt+GWJbmDEUAy3qbgMqKuhxizxUmTQj4i+jNU4SLJycyPQO9U3t+WW
         gI/fnkA8u9Hk2kE9JizWeo5l+6HCDrqQ5w0Ji4LcMzr4HR/CULpKygzTj1FwcRHbjuUc
         9+n+DOHuxFfwQKTTkPuUyYr7YybA6HQE71qxpR+I+rzj21IBxQN6+NnVWboHGUmEt7zH
         /tcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687975385; x=1690567385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wtrqVXZyrVo6nVpul5ot1RJ1MamLe48pX5okyndgaqo=;
        b=eu4wrjWcgEAykC/X9HjIhnZbXz0QOMfVGjqvcCkwq5YahbIqRI3r98jSUxYvfGyudB
         G2E3HY2SVgM5qrCBlQ/grHa99OlQvTjB7GlLC0uBeuSnjN4oJgk7MORKqbNCOI56+IrP
         bvKIsP19bvhzPGgXmzEEArmsCZldJ1+cOFiKUkeHUUka48VB6gnD4azMexCeMeWWFQwW
         49cwYGjZxMzsKtkFKx6gPA3M7g4crWLrVzqBMK7Xk7KKI9DiGPScDg0UFG5w16ZUP3rQ
         TW9p47k/a1Qv9PHA6X1TyuGuw00IOfYdF64wFVYVUlj6y6nBT7PW3FNntLlGtglPwDPk
         2S1g==
X-Gm-Message-State: AC+VfDz/9Tbhyi8/9vH+FFSbc1soqlcGOefmygpFeQFg1tv4Hc5o2PP/
	gJ2cBsKp9DKslMsad4u23FiG4wbjNdeFtMyoB5A=
X-Google-Smtp-Source: ACHHUZ5+8RpOzP7j4OSRw+H5WgkyCxdPKFgsYMgY3flx/Gr64fa/p6y2+5xzKHUKJMG6qzJCyKRu41Yii8n9haWljbI=
X-Received: by 2002:a2e:9b92:0:b0:2b6:a630:1e5 with SMTP id
 z18-20020a2e9b92000000b002b6a63001e5mr5787459lji.33.1687975384599; Wed, 28
 Jun 2023 11:03:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230628115910.3817966-1-houtao@huaweicloud.com> <20230628115910.3817966-2-houtao@huaweicloud.com>
In-Reply-To: <20230628115910.3817966-2-houtao@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 28 Jun 2023 11:02:52 -0700
Message-ID: <CAADnVQ+yg5iP59Y1oTsZmM6A2orOY=JNZME+m=TgJpOKwYbj_Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 1/2] selftests/bpf: Add min() and max() macros
 in bpf_util.h
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yhs@fb.com>, Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org, 
	Hou Tao <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 28, 2023 at 4:41=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> From: Hou Tao <houtao1@huawei.com>
>
> max() will be used by the following htab-mem benchmark patch.
>
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  tools/testing/selftests/bpf/bpf_util.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/bpf_util.h b/tools/testing/selft=
ests/bpf/bpf_util.h
> index 10587a29b967..e87e9f8c13a7 100644
> --- a/tools/testing/selftests/bpf/bpf_util.h
> +++ b/tools/testing/selftests/bpf/bpf_util.h
> @@ -59,4 +59,11 @@ static inline void bpf_strlcpy(char *dst, const char *=
src, size_t sz)
>         (offsetof(TYPE, MEMBER) + sizeof_field(TYPE, MEMBER))
>  #endif
>
> +#ifndef min
> +#define min(x, y) ((x) < (y) ? (x) : (y))
> +#endif
> +#ifndef max
> +#define max(x, y) ((x) < (y) ? (y) : (x))
> +#endif

That's for user space only?
Just use the standard MIN/MAX macros.

