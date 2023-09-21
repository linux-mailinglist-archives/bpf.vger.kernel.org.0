Return-Path: <bpf+bounces-10506-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D097A9070
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 03:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13491B207D8
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 01:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5582D1115;
	Thu, 21 Sep 2023 01:28:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA98A5C
	for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 01:28:24 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35242A1
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 18:28:23 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-32155a45957so449972f8f.0
        for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 18:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695259701; x=1695864501; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gqbmNunrTPcP9If6Af4MAOB/k/0UQUfqR23z85+yoyU=;
        b=kl9ptQVssm9DL25KpRVwflk4UY38zrc/lESQ7WGQrylHMXW9IBGXfFUp0KLb6cf+X/
         tLZIppVRLwdrdDjwiCoX/DbuEiii1MTvRqQYi7SNCegNFaYNC78W5Cog6hphZRjyFaTi
         Z4p3JA7DRTU3BqGdDLCWRlTz9ya8z7JojwlfkA7rCVVvIpBp6eK+I0s2DyJObKFoVPxU
         R5cUOl0qVZqg0AxpbCgokyiibMb9ami/yXQd+jksxnH/xyT/vJeaKGXnrZGINE8E2aw/
         46g90fRPDBJRUEms5IhmH/4IGsAgComA6X8TKpR7yJk7Ki6gYYVClnOsCR0ubQFpIuTV
         swrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695259701; x=1695864501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gqbmNunrTPcP9If6Af4MAOB/k/0UQUfqR23z85+yoyU=;
        b=Hv99h4VVk4VKj6JWjS6KqjMFJtKGv+d4t9d7lA1m5+YJ3pKzAwTaOLWypJRebsKU8W
         K8e7pgRirfJ5kA5qChZ4Ehx7kO8fBgNbDymabLGFuoQjC7+mKntcLcirrx0qZc5rKxLq
         XpJM0N1Q1/MENOkYMNNetIT7o24cX5kzOaUVNcE83OUd5uqDEV5rBXA2g7UXdr0ZSyuP
         szgv29bssBH+ryouim9jNoyIenkPtyS9VYP8sUPih1rW2PfzxYYNLcrDRQvyIKKLlk9C
         YEUQIACxjyCACYuYNTRyZJPqr+qA4wF7kI3dbrevJCP4/ns0ipzTW/okdEyaxp9ypl6C
         MGWQ==
X-Gm-Message-State: AOJu0Yyu6utOqu3cWHzujAZ8f72W7GOc9OjZA6JdcCqNjXbg10lWkypo
	ucf8J9zEUVrcTGLKtRBmJbKDiBddBcjMNYWZw97zKLha
X-Google-Smtp-Source: AGHT+IGJpqcqCgBQiKN7IhkJ2NxdgB7fcZWHDJAvDHoVmYjjquXIaPNYCFjGuExJuY6aodDfN57QiUJKHOdEaSpz0Pk=
X-Received: by 2002:a5d:6087:0:b0:31f:9a0d:167f with SMTP id
 w7-20020a5d6087000000b0031f9a0d167fmr3290907wrt.50.1695259701394; Wed, 20 Sep
 2023 18:28:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230914231123.193901-1-martin.kelly@crowdstrike.com> <20230914231123.193901-2-martin.kelly@crowdstrike.com>
In-Reply-To: <20230914231123.193901-2-martin.kelly@crowdstrike.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 20 Sep 2023 18:28:09 -0700
Message-ID: <CAEf4BzbACovLm74tUTzRLwQcVzf2+Lgje6ErYEffuVhxKb8fPg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 01/14] libbpf: refactor cleanup in ring_buffer__add
To: Martin Kelly <martin.kelly@crowdstrike.com>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 14, 2023 at 4:12=E2=80=AFPM Martin Kelly
<martin.kelly@crowdstrike.com> wrote:
>
> Refactor the cleanup code in ring_buffer__add to use a unified err_out
> label. This reduces code duplication, as well as plugging a potential
> leak if mmap_sz !=3D (__u64)(size_t)mmap_sz (currently this would miss
> unmapping tmp because ringbuf_unmap_ring isn't called).
>
> Signed-off-by: Martin Kelly <martin.kelly@crowdstrike.com>
> ---
>  tools/lib/bpf/ringbuf.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> index 02199364db13..f2020807996c 100644
> --- a/tools/lib/bpf/ringbuf.c
> +++ b/tools/lib/bpf/ringbuf.c
> @@ -118,10 +118,9 @@ int ring_buffer__add(struct ring_buffer *rb, int map=
_fd,
>         /* Map writable consumer page */
>         tmp =3D mmap(NULL, rb->page_size, PROT_READ | PROT_WRITE, MAP_SHA=
RED, map_fd, 0);
>         if (tmp =3D=3D MAP_FAILED) {
> -               err =3D -errno;

removing this is wrong, pr_warn() can clobber errno

>                 pr_warn("ringbuf: failed to mmap consumer page for map fd=
=3D%d: %d\n",
>                         map_fd, err);
> -               return libbpf_err(err);
> +               goto err_out;
>         }
>         r->consumer_pos =3D tmp;
>
> @@ -131,16 +130,15 @@ int ring_buffer__add(struct ring_buffer *rb, int ma=
p_fd,
>          */
>         mmap_sz =3D rb->page_size + 2 * (__u64)info.max_entries;
>         if (mmap_sz !=3D (__u64)(size_t)mmap_sz) {
> +               errno =3D E2BIG;

ditto, stick to err



>                 pr_warn("ringbuf: ring buffer size (%u) is too big\n", in=
fo.max_entries);
> -               return libbpf_err(-E2BIG);
> +               goto err_out;
>         }
>         tmp =3D mmap(NULL, (size_t)mmap_sz, PROT_READ, MAP_SHARED, map_fd=
, rb->page_size);
>         if (tmp =3D=3D MAP_FAILED) {
> -               err =3D -errno;
> -               ringbuf_unmap_ring(rb, r);
>                 pr_warn("ringbuf: failed to mmap data pages for map fd=3D=
%d: %d\n",
>                         map_fd, err);
> -               return libbpf_err(err);
> +               goto err_out;
>         }
>         r->producer_pos =3D tmp;
>         r->data =3D tmp + rb->page_size;
> @@ -151,15 +149,18 @@ int ring_buffer__add(struct ring_buffer *rb, int ma=
p_fd,
>         e->events =3D EPOLLIN;
>         e->data.fd =3D rb->ring_cnt;
>         if (epoll_ctl(rb->epoll_fd, EPOLL_CTL_ADD, map_fd, e) < 0) {
> -               err =3D -errno;
> -               ringbuf_unmap_ring(rb, r);
>                 pr_warn("ringbuf: failed to epoll add map fd=3D%d: %d\n",
>                         map_fd, err);
> -               return libbpf_err(err);
> +               goto err_out;
>         }
>
>         rb->ring_cnt++;
>         return 0;
> +
> +err_out:
> +       err =3D -errno;
> +       ringbuf_unmap_ring(rb, r);
> +       return libbpf_err(err);
>  }
>
>  void ring_buffer__free(struct ring_buffer *rb)
> --
> 2.34.1
>

