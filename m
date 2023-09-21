Return-Path: <bpf+bounces-10507-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C643F7A9071
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 03:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CCB1B20995
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 01:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6005C1388;
	Thu, 21 Sep 2023 01:28:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7A8136A
	for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 01:28:29 +0000 (UTC)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDA6A1
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 18:28:27 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b9d07a8d84so6548381fa.3
        for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 18:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695259706; x=1695864506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0NGBSxAExkYfIk85JTi1Whewb4ukhiuCUM7N3ezSp4s=;
        b=Qc4gN/PRglH7M0bZ9FeVfv/iRxqP6Lm+noYU6+CnOGNpcgDxP+zCl4U47Oy07jM8XW
         xXel3gSIL6RPhb7tq8mthV+Vi5oNqgagsJgERF/WoEGeM7XYL+KAQ4oF9JifrHD1k2/c
         LVOo0HyHNDlzj/AQnTvHVG0SllqfeKcSuEdop8bqcm7leCCy2rj/xfUDGnW7KzLO2wNS
         UglL/C1yziSEAcSbYH+Zf8bKJ5TtmeCRZLodsWjHhr1yhFtwPx6EIjfYNmbQH9vzHLLJ
         KUp3SJw3RQ+u8RCwnY1ZgU3xnDdEDJR0r6hIqkH7cMf3D6Q0I9WUVsjRZTBWKAHQUtJu
         9cyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695259706; x=1695864506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0NGBSxAExkYfIk85JTi1Whewb4ukhiuCUM7N3ezSp4s=;
        b=bLR6XvYn7+Am5qZ8CYPgDReltv9eLwjX0OWXwlHRAVU96xtUsLhV08OFnQDnyUSCay
         loifYnb4WPBb0I1TOBaQdcrgqoWuWRNJo9+DyckdojQ+53y0VS0s1SXL2bivs/cD5C7Y
         4JLaGpPXPLosNj1y/14Jc8FWGOG4t1vscsfmJx68Cb1eHT1XSUvTyk5CvpNQniIwdj3w
         R3yvVBx5M98KwTWQNYGcj/CM2Hlz4/JfLrbN9rJVb9Fpm8cPmtFW8Lqk2duEwppKeOHZ
         rE7xzbXZEONKGOQbFqbhYqwK1psa6wuha9/JJGDuZfiaH4G7OrkHG5aNz6Nw2BPQ25gt
         Dx7g==
X-Gm-Message-State: AOJu0YwlTbmZ3Oo7axsuUADPYbPBfC3KvvXaeEOLyM9qAhpM6rdiZTsp
	F4Elnjo+kP1DqkcImgqy2AbJkoIxqmM/YbfOcsJVeoJ8
X-Google-Smtp-Source: AGHT+IGCyDWDgPWGscM+9kvKo1XJlD2za1+TrXvCu/3S6h59w31u8pkSEVrrpbi1AheMABlbEpC5tOumUj3JjYVkWrA=
X-Received: by 2002:a2e:870a:0:b0:2c0:7e0:2a1 with SMTP id m10-20020a2e870a000000b002c007e002a1mr3539949lji.41.1695259705848;
 Wed, 20 Sep 2023 18:28:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230914231123.193901-1-martin.kelly@crowdstrike.com> <20230914231123.193901-4-martin.kelly@crowdstrike.com>
In-Reply-To: <20230914231123.193901-4-martin.kelly@crowdstrike.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 20 Sep 2023 18:28:14 -0700
Message-ID: <CAEf4BzZiuSb5-qtrk_211gb=ouG8uvoVFysnHxgrsrgMoktAjA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 03/14] libbpf: add ring_buffer__ring
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
> Add a new function ring_buffer__ring, which exposes struct ring * to the
> user, representing a single ringbuffer.
>
> Signed-off-by: Martin Kelly <martin.kelly@crowdstrike.com>
> ---
>  tools/lib/bpf/libbpf.h   | 14 ++++++++++++++
>  tools/lib/bpf/libbpf.map |  1 +
>  tools/lib/bpf/ringbuf.c  |  8 ++++++++
>  3 files changed, 23 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 0e52621cba43..2d6c39e20863 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -1229,6 +1229,7 @@ LIBBPF_API int bpf_tc_query(const struct bpf_tc_hoo=
k *hook,
>
>  /* Ring buffer APIs */
>  struct ring_buffer;
> +struct ring;
>  struct user_ring_buffer;
>
>  typedef int (*ring_buffer_sample_fn)(void *ctx, void *data, size_t size)=
;
> @@ -1249,6 +1250,19 @@ LIBBPF_API int ring_buffer__poll(struct ring_buffe=
r *rb, int timeout_ms);
>  LIBBPF_API int ring_buffer__consume(struct ring_buffer *rb);
>  LIBBPF_API int ring_buffer__epoll_fd(const struct ring_buffer *rb);
>
> +/**
> + * @brief **ring_buffer__ring()** returns the ring object inside a given
> + * ringbuffer.

s/ringbuffer/ring buffer manager/

and I'd also add ", representing single BPF_MAP_TYPE_RINGBUF map instance"


> + *
> + * @param rb A ringbuffer object.

"ring buffer manager"?


> + * @param idx An index into the rings contained within the ringbuffer ob=
ject.
> + * The index is 0-based and corresponds to the order in which ring_buffe=
r__add
> + * was called.
> + * @return A ring object on success; NULL and errno set if the index is =
invalid.
> + */
> +LIBBPF_API struct ring *ring_buffer__ring(struct ring_buffer *rb,
> +                                         unsigned int idx);
> +
>  struct user_ring_buffer_opts {
>         size_t sz; /* size of this struct, for forward/backward compatibi=
lity */
>  };
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 57712321490f..7a7370c2bc25 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -400,4 +400,5 @@ LIBBPF_1.3.0 {
>                 bpf_program__attach_netfilter;
>                 bpf_program__attach_tcx;
>                 bpf_program__attach_uprobe_multi;
> +               ring_buffer__ring;
>  } LIBBPF_1.2.0;
> diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> index c2c79e10cfea..2857df0f2d03 100644
> --- a/tools/lib/bpf/ringbuf.c
> +++ b/tools/lib/bpf/ringbuf.c
> @@ -328,6 +328,14 @@ int ring_buffer__epoll_fd(const struct ring_buffer *=
rb)
>         return rb->epoll_fd;
>  }
>
> +struct ring *ring_buffer__ring(struct ring_buffer *rb, unsigned int idx)
> +{
> +       if (idx >=3D rb->ring_cnt)
> +               return errno =3D ERANGE, NULL;
> +
> +       return rb->rings[idx];
> +}
> +
>  static void user_ringbuf_unmap_ring(struct user_ring_buffer *rb)
>  {
>         if (rb->consumer_pos) {
> --
> 2.34.1
>

