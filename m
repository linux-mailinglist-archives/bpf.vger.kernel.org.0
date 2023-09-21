Return-Path: <bpf+bounces-10509-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BB37A9073
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 03:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D128B207DB
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 01:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8763617C2;
	Thu, 21 Sep 2023 01:28:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20D615A7
	for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 01:28:37 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E3AA9
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 18:28:36 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-532aaba8747so386446a12.3
        for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 18:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695259715; x=1695864515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nazVFb5jdWHaNORXdC0zWbe2tRuB2ciYOHi0A1zoXIk=;
        b=H37+OKl1APfW45JTIgwodrpfx7YBst7JaSURJXYt6YJ9CVFkHH41ZRw6r28+TxF58H
         Zp+fZmyHfrDYvy5AZL9Cu27UUliO9QwIQf0mRVk/asV4aV/mjU0ZvIY1kQxG4WCef1ku
         WzTrnoxYz/uEqS2kRG225vEdNnc0BGi9Z4DOehFou5cx9H0jWKFyRPQVbRP+9O8iglzf
         7CT/TwYQpDRy2poBHQTH0y1ayeLnIDbtC60jCqr9y/niZKESZ3+PUiw+znx30fFi04iq
         YZJtysrlAoSOuGD/QWQXOl0OQrEyBqYEtQpxAWs3sAJiaFwqhnyu6TZ1eZymNyNKk6wK
         zHcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695259715; x=1695864515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nazVFb5jdWHaNORXdC0zWbe2tRuB2ciYOHi0A1zoXIk=;
        b=ZATp2XwljMYkqJh/TJBpHlclUIz96Yj6b7aUke2T8MPxOP8LJLgJuxgosqpQWs1O9k
         9hUrrpzKeFqWlVUxnMTemsQiIe8pvcE1uiBZCH5LtREAsXpro6lDxagX+eBgcPRBzqGh
         oOTls5SwiNNHi6l6iyyednboQ7/RA0kBBGf0/7wHJ9i/QRt1VIMZT8prABvSho6LpRw3
         2Jhy7idez0KEYNfQm0WTyCVWPGHtpxGloA3N4wEpuMBo+fP+rltdiZG+IuUuZhrqB6nB
         9S9xz2vipFX9OabsqpoljfylHAeBU8+aDUJaSYPIJ63aD1jc413rYBZyO/rEXfRH4OD8
         cdsQ==
X-Gm-Message-State: AOJu0YwmG647copTfNOU7oEnCNbsnQ0BjNDPJMPmX79Dq5U6UMK+TypS
	ILaLtNz8Qfl0w0uLYm/xsifw+CuswKkBUQv8sCo=
X-Google-Smtp-Source: AGHT+IHqWyBGm7BLqFuxUFQTLPqRrpxDM62feuAKJynrAndO69BQWNm3BuArWPlzskOsVRtYwhmqJjbh/rFzq1PO8Ns=
X-Received: by 2002:a17:906:194:b0:9ae:4c6e:c493 with SMTP id
 20-20020a170906019400b009ae4c6ec493mr2316522ejb.37.1695259714821; Wed, 20 Sep
 2023 18:28:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230914231123.193901-1-martin.kelly@crowdstrike.com> <20230914231123.193901-6-martin.kelly@crowdstrike.com>
In-Reply-To: <20230914231123.193901-6-martin.kelly@crowdstrike.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 20 Sep 2023 18:28:22 -0700
Message-ID: <CAEf4BzYi2PWkg2A27DQVTJyXS6LJkhSNKPChUtBgKtJjZzZg+g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 05/14] libbpf: add ring__producer_pos, ring__consumer_pos
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
> Add APIs to get the producer and consumer position for a given
> ringbuffer.
>
> Signed-off-by: Martin Kelly <martin.kelly@crowdstrike.com>
> ---
>  tools/lib/bpf/libbpf.h   | 16 ++++++++++++++++
>  tools/lib/bpf/libbpf.map |  2 ++
>  tools/lib/bpf/ringbuf.c  | 14 ++++++++++++++
>  3 files changed, 32 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 2d6c39e20863..935162dbb3bf 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -1263,6 +1263,22 @@ LIBBPF_API int ring_buffer__epoll_fd(const struct =
ring_buffer *rb);
>  LIBBPF_API struct ring *ring_buffer__ring(struct ring_buffer *rb,
>                                           unsigned int idx);
>
> +/**
> + * @brief **ring__consumer_pos()** returns the current consumer position=
.
> + *
> + * @param r A ring object.
> + * @return The current consumer position.
> + */
> +LIBBPF_API unsigned long ring__consumer_pos(const struct ring *r);
> +
> +/**
> + * @brief **ring__producer_pos()** returns the current producer position=
.
> + *
> + * @param r A ring object.
> + * @return The current producer position.
> + */
> +LIBBPF_API unsigned long ring__producer_pos(const struct ring *r);
> +
>  struct user_ring_buffer_opts {
>         size_t sz; /* size of this struct, for forward/backward compatibi=
lity */
>  };
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 7a7370c2bc25..1c532fe7a445 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -401,4 +401,6 @@ LIBBPF_1.3.0 {
>                 bpf_program__attach_tcx;
>                 bpf_program__attach_uprobe_multi;
>                 ring_buffer__ring;
> +               ring__consumer_pos;
> +               ring__producer_pos;

we keep this list ordered, so ring__ goes before ring_b



>  } LIBBPF_1.2.0;
> diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> index 2857df0f2d03..54c596db57a4 100644
> --- a/tools/lib/bpf/ringbuf.c
> +++ b/tools/lib/bpf/ringbuf.c
> @@ -336,6 +336,20 @@ struct ring *ring_buffer__ring(struct ring_buffer *r=
b, unsigned int idx)
>         return rb->rings[idx];
>  }
>
> +unsigned long ring__consumer_pos(const struct ring *r)
> +{
> +       /* Synchronizes with smp_store_release() in ringbuf_process_ring(=
). */
> +       return smp_load_acquire(r->consumer_pos);
> +}
> +
> +unsigned long ring__producer_pos(const struct ring *r)
> +{
> +       /* Synchronizes with smp_store_release() in __bpf_ringbuf_reserve=
() in
> +        * the kernel.
> +        */
> +       return smp_load_acquire(r->producer_pos);
> +}
> +
>  static void user_ringbuf_unmap_ring(struct user_ring_buffer *rb)
>  {
>         if (rb->consumer_pos) {
> --
> 2.34.1
>

