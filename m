Return-Path: <bpf+bounces-9446-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A37AE797C33
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 20:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D4B1281738
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 18:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455F813AE1;
	Thu,  7 Sep 2023 18:46:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C162B8BF5
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 18:46:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D6AAC433CB
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 18:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694112404;
	bh=+o06ohyzjZCygXRCaFkG6sSyQty2xU9lhgCdv3wMIiw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=re2Y7H3eWzM9k78hPVvDNA9Dmq5g8ymb2S+n81l/tbjoQjZl0Aapj2gY3CxmNPD21
	 vq2oVS+H73IsgvYrhEOh97L/1bQWWm1KWUN8RK72f1dcrt+01j4DS8/MVdloN8t6vc
	 2ZNgn5sDuAwKeOdD/tXeBfIGpLYExqr6VZciB2a3eyunfLWbzmyLVPfkMNb6y/pFD9
	 t5t2BqRAs3nkKqPvT9dabS9RqRYtD5qFXtGAt4r94Wp7SsyTUSIyKH8N9ijUXpmRFg
	 yLZwcaAUH3ICx3CIkednZui8I2dZFLqx57xKA63DPL66ktB6VOvVNCp9eI7W8kQAbz
	 1vC8XFK+oIKkQ==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2bd0bc8b429so23159971fa.2
        for <bpf@vger.kernel.org>; Thu, 07 Sep 2023 11:46:44 -0700 (PDT)
X-Gm-Message-State: AOJu0YyLOQfxazZxNyVCseVNgCme9wiBMtB6owbKJ964MWBRYTym3f0O
	bbP59ZrwZxNTAJ7Bw/MTNhY2cpCT1jYLEjT9tSQ=
X-Google-Smtp-Source: AGHT+IHvkOoRUjaecHAga4QGBjsmwEwpeHQZoXMhn1F/+RjIJH8K2UEWjm+ZvogVKLgOMGXQ3XtR0SgeQCDU8+BR7gs=
X-Received: by 2002:a2e:998d:0:b0:2b9:ea17:558b with SMTP id
 w13-20020a2e998d000000b002b9ea17558bmr84010lji.16.1694112402158; Thu, 07 Sep
 2023 11:46:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230907071311.254313-1-jolsa@kernel.org> <20230907071311.254313-5-jolsa@kernel.org>
In-Reply-To: <20230907071311.254313-5-jolsa@kernel.org>
From: Song Liu <song@kernel.org>
Date: Thu, 7 Sep 2023 11:46:29 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7Jx5KOoM9ZU9=Br7cEYGFtNyVeDGVg-vDX2tOgLvV3zQ@mail.gmail.com>
Message-ID: <CAPhsuW7Jx5KOoM9ZU9=Br7cEYGFtNyVeDGVg-vDX2tOgLvV3zQ@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 4/9] bpf: Count missed stats in trace_call_bpf
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Hou Tao <houtao1@huawei.com>, 
	Daniel Xu <dxu@dxuuu.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 7, 2023 at 12:14=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Increase misses stats in case bpf array execution is skipped
> because of recursion check in trace_call_bpf.
>
> Adding bpf_prog_inc_misses_counters that increase misses
> counts for all bpf programs in bpf_prog_array.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Reviewed-and-tested-by: Song Liu <song@kernel.org>


> ---
>  include/linux/bpf.h      | 16 ++++++++++++++++
>  kernel/trace/bpf_trace.c |  3 +++
>  2 files changed, 19 insertions(+)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 87eeb3a46a1d..abc18d6f2f2e 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2911,6 +2911,22 @@ static inline int sock_map_bpf_prog_query(const un=
ion bpf_attr *attr,
>  #endif /* CONFIG_BPF_SYSCALL */
>  #endif /* CONFIG_NET && CONFIG_BPF_SYSCALL */
>
> +static __always_inline void
> +bpf_prog_inc_misses_counters(const struct bpf_prog_array *array)
> +{
> +       const struct bpf_prog_array_item *item;
> +       struct bpf_prog *prog;
> +
> +       if (unlikely(!array))
> +               return;
> +
> +       item =3D &array->items[0];
> +       while ((prog =3D READ_ONCE(item->prog))) {
> +               bpf_prog_inc_misses_counter(prog);
> +               item++;
> +       }
> +}
> +
>  #if defined(CONFIG_INET) && defined(CONFIG_BPF_SYSCALL)
>  void bpf_sk_reuseport_detach(struct sock *sk);
>  int bpf_fd_reuseport_array_lookup_elem(struct bpf_map *map, void *key,
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index a9d8634b503c..44f399b19af1 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -117,6 +117,9 @@ unsigned int trace_call_bpf(struct trace_event_call *=
call, void *ctx)
>                  * and don't send kprobe event into ring-buffer,
>                  * so return zero here
>                  */
> +               rcu_read_lock();
> +               bpf_prog_inc_misses_counters(rcu_dereference(call->prog_a=
rray));
> +               rcu_read_unlock();
>                 ret =3D 0;
>                 goto out;
>         }
> --
> 2.41.0
>
>

