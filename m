Return-Path: <bpf+bounces-10510-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC447A9074
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 03:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 656CD28163C
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 01:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E39717E8;
	Thu, 21 Sep 2023 01:28:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FB117C8
	for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 01:28:39 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15711A1
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 18:28:38 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9a648f9d8e3so45449866b.1
        for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 18:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695259716; x=1695864516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P+jKZQnhp1Ri6/jdeRj2UvWsUvg+dNNGKL6d8ZgJz0E=;
        b=W75Ggf2Tfs7BAtAAYwXXo93soEAtuBB0qvkr80XXTOjVrr5WWw0OPmgsMO+KzK02pg
         GZOZjzt0nIjiFrfGPfd/QAa67nYkmbgH3GyvtSgf1dQJwOEVXyI8j5hOE8e9cxLSpO8n
         FdAsE5KFPBOW+R/Poz1a4bktqNod963YZCbc3uzUyD/U9sidlU2oyTgHQogI3DeNRkfs
         4RsBwAtMsireBysdqoj5ZcdpdAE9MkadE9myk7eKqXY2a2c3uywQQYFl66rOVkewIo5X
         CundGOl3Ia9uJMZX9RPcOJ69ZFHs4qyEqZIvXDwKm8AeDyjyPjuW/UTYAlxz29s6m/wR
         FDpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695259716; x=1695864516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P+jKZQnhp1Ri6/jdeRj2UvWsUvg+dNNGKL6d8ZgJz0E=;
        b=gDZ8tDLfjNQ1insb7WKsZd9mhaa4F3jRrNcj2zryrrmkjL+fFG/tEy7BWJUoXWJs6r
         14F74vkOnr1LHy7j2RmW/0yD0qiQ1XRQZmsOW1P1/GYCHWMLN3nGpAcmlcIIyE1ptLb4
         IsRsi8k5KqDWRmWZ02fx7K8Opo377lWWIXiX44y2GJprszXbndNEKUhrQpED/YJ7OV89
         0urkN6Vb5Do54TM5Vo2xckO8cgiuREOxazGWDXXCvuHJTm/SuAlOqTKF7NRGV6n7w9PG
         eKqOT+mN5cWzIC2r9qkR10hWo0Opa6rypPzT2Ct/n7FKujXP85Oup0JsQg3H8ud1NQEp
         08Ig==
X-Gm-Message-State: AOJu0YyNR5Ie7bOzGFpN6j9eT9DTPAvTu/Oj7Grk6cb3+ZmaV+fxT6k8
	p15jy8zKFC2RzNYmZExB/b6stKvkljwWbZrZy18=
X-Google-Smtp-Source: AGHT+IHmrFXQoMT1icbHpTktANIG8qvEAYsKxBy7HPOXhMB40EyPzZ7APtkaiPeCEcIHAcMDXrKpmQhfJ6yxJtYEAbc=
X-Received: by 2002:a17:906:ee8c:b0:9ad:7d5c:3d4b with SMTP id
 wt12-20020a170906ee8c00b009ad7d5c3d4bmr3870686ejb.35.1695259716590; Wed, 20
 Sep 2023 18:28:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230914231123.193901-1-martin.kelly@crowdstrike.com> <20230914231123.193901-8-martin.kelly@crowdstrike.com>
In-Reply-To: <20230914231123.193901-8-martin.kelly@crowdstrike.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 20 Sep 2023 18:28:25 -0700
Message-ID: <CAEf4BzbwTM2xXmgLD4h+81=zTLAhTkq2pmma+ScwEsS5=y34qQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 07/14] libbpf: add ring__avail_data_size
To: Martin Kelly <martin.kelly@crowdstrike.com>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 14, 2023 at 4:12=E2=80=AFPM Martin Kelly
<martin.kelly@crowdstrike.com> wrote:
>
> Add ring__avail_data_size for querying the currently available data in
> the ringbuffer, similar to the BPF_RB_AVAIL_DATA flag in
> bpf_ringbuf_query. This is racy during ongoing operations but is still
> useful for overall information on how a ringbuffer is behaving.
>
> Signed-off-by: Martin Kelly <martin.kelly@crowdstrike.com>
> ---
>  tools/lib/bpf/libbpf.h   | 11 +++++++++++
>  tools/lib/bpf/libbpf.map |  1 +
>  tools/lib/bpf/ringbuf.c  |  5 +++++
>  3 files changed, 17 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 935162dbb3bf..87e3bad37737 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -1279,6 +1279,17 @@ LIBBPF_API unsigned long ring__consumer_pos(const =
struct ring *r);
>   */
>  LIBBPF_API unsigned long ring__producer_pos(const struct ring *r);
>
> +/**
> + * @brief **ring__avail_data_size()** returns the number of bytes in thi=
s
> + * ringbuffer not yet consumed. This has no locking associated with it, =
so it
> + * can be inaccurate if operations are ongoing while this is called. How=
ever, it
> + * should still show the correct trend over the long-term.
> + *
> + * @param r A ring object.
> + * @return The number of bytes not yet consumed.
> + */
> +LIBBPF_API size_t ring__avail_data_size(const struct ring *r);
> +
>  struct user_ring_buffer_opts {
>         size_t sz; /* size of this struct, for forward/backward compatibi=
lity */
>  };
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 1c532fe7a445..f66d7f0bc224 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -401,6 +401,7 @@ LIBBPF_1.3.0 {
>                 bpf_program__attach_tcx;
>                 bpf_program__attach_uprobe_multi;
>                 ring_buffer__ring;
> +               ring__avail_data_size;
>                 ring__consumer_pos;
>                 ring__producer_pos;
>  } LIBBPF_1.2.0;
> diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> index 54c596db57a4..f51ad1af6ab8 100644
> --- a/tools/lib/bpf/ringbuf.c
> +++ b/tools/lib/bpf/ringbuf.c
> @@ -350,6 +350,11 @@ unsigned long ring__producer_pos(const struct ring *=
r)
>         return smp_load_acquire(r->producer_pos);
>  }
>
> +size_t ring__avail_data_size(const struct ring *r)
> +{
> +       return ring__producer_pos(r) - ring__consumer_pos(r);

this might be ok as is, but if you look at kernel implementation, we
make sure to get consumer position first, and then producer position
second, then calculate difference. This is deliberately to avoid the
situation when consumer pos is greater than producer pos, which will
result in non-sensical negative (or huge) numbers.

Let's do the same, use two local variables, and have conservative
ordering: consumer, then producer.


> +}
> +
>  static void user_ringbuf_unmap_ring(struct user_ring_buffer *rb)
>  {
>         if (rb->consumer_pos) {
> --
> 2.34.1
>

