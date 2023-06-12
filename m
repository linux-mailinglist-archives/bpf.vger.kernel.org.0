Return-Path: <bpf+bounces-2447-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C66C72D077
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 22:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4989A1C20B5E
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 20:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D33F8F41;
	Mon, 12 Jun 2023 20:31:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC283EA0
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 20:31:32 +0000 (UTC)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66787191
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 13:31:31 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b1b3836392so58878401fa.0
        for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 13:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686601889; x=1689193889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eAE2yN4DVS9x7h2duz49HCr9B6goNMuTAHti0FtJBns=;
        b=lxIiYUYcUXqGb4mI1i5wE4qcdzsd2U6ZTnkO/R4rr7qpWs/gxK3v2N+zjW8aCoFED5
         8y1oh8ermudtUpmerMRp1XwdIeIsA/DwJQo7b1eVt79gjksbSN5+2YSqIUNTPP9mlwv0
         AlOeIYIemgZZ13Al1Pf5hmllkyC/YmFjEisr4BX6j/LkamO0wQ9LIjolGfkE4trsVDPb
         ZPOsdDgXAugW0p+jkazhaud/IHHHCLuaM7+Jts7nDWUTyzb1oxjWsZdzeIcm+6Z3rRNE
         21i/dWa5vuf8yO3kc2PmgyPnV5FlE9vLQApfFdqPYbBcSTnCy3HtA020pxBRjJEjfoVQ
         XfOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686601889; x=1689193889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eAE2yN4DVS9x7h2duz49HCr9B6goNMuTAHti0FtJBns=;
        b=Dh/UmDlu2s6JXGDNkMmA3VAJPDXDzFVupMi99V9iZxF0WYCzQfDNcKqTao3qwRsu6+
         PDW+jS2F5Q69x8NKGPydIUatguBENKBjWxsaSX/c9U86AE4HD/2HwIhaSQVLe/QABLV3
         O7yGix9Xz0r4R4iqdCxR3eYt2bueQttrV/rEf5pZEY8cw2QM1i4fxirPSoyLCsKTDxrE
         Q/LGXXGCa3ye6C+hnkU5rHR7oguR1iIBj4XYf5sYKJIeoUCf9RbxqS0uNnPg3s3Q8jvO
         Dw+JiGBWhnpaNT21hB37VmBCxg6kVyiKAXgJQq5FdHOQUFKrWdbv/MlxPsvYdV4j9u8O
         fANg==
X-Gm-Message-State: AC+VfDwIr01nF7XodweBKio6fVDhCWFq13fM3rd3bF6Pit9DcrH0JivQ
	CzxekcUoobuSYmwjcOubHiYWsQPdhYiEh3i31dk=
X-Google-Smtp-Source: ACHHUZ6ABkUd1z9zTjJVXS3uUL1gt5N0kXQG3MZZFg9JWlGn+F8oGLcv8Xz1cnqDu3MsOrRNvMzOfwI8sydFUraJBiw=
X-Received: by 2002:a2e:95d5:0:b0:2b1:bf5d:4115 with SMTP id
 y21-20020a2e95d5000000b002b1bf5d4115mr3324309ljh.13.1686601889237; Mon, 12
 Jun 2023 13:31:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230612191641.441774-1-kuifeng@meta.com> <20230612191641.441774-3-kuifeng@meta.com>
In-Reply-To: <20230612191641.441774-3-kuifeng@meta.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 12 Jun 2023 13:31:18 -0700
Message-ID: <CAADnVQ+Fbz9pQ6BbKX_z9Sx=pwNaODD7vvBsaz_89Zy6Zs0=jg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Verify that the cgroup_skb
 filters receive expected packets.
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Kernel Team <kernel-team@meta.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kui-Feng Lee <kuifeng@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 12, 2023 at 12:16=E2=80=AFPM Kui-Feng Lee <thinker.li@gmail.com=
> wrote:
> +static int close_connection(int *closing_fd, int *peer_fd, int *listen_f=
d)
> +{
> +       int err;
> +
> +       /* Half shutdown to make sure the closing socket having a chance =
to
> +        * receive a FIN from the client.
> +        */
> +       err =3D shutdown(*closing_fd, SHUT_WR);
> +       if (CHECK(err, "shutdown closing_fd", "failed: %d\n", err))
> +               return -1;
> +       usleep(100000);
> +       err =3D close(*peer_fd);
> +       if (CHECK(err, "close peer_fd", "failed: %d\n", err))
> +               return -1;
> +       *peer_fd =3D -1;
> +       usleep(100000);
> +       err =3D close(*closing_fd);

usleep() won't guarantee it. The test will be flaky.
Can you make it reliable?

> +
> +/* Run accept() on a socket in the cgroup to receive a new connection. *=
/
> +#define EGRESS_ACCEPT                                                  \
> +       case SYN_RECV_SENDING_SYN_ACK:                                  \
> +               if (tcph.fin || !tcph.syn || tcph.rst || !tcph.ack)     \
> +                       g_unexpected++;                                 \
> +               else                                                    \
> +                       g_sock_state =3D SYN_RECV;                       =
 \
> +               break
> +
> +#define INGRESS_ACCEPT                                                 \
> +       case INIT:                                                      \
> +               if (!tcph.syn || tcph.fin || tcph.rst || tcph.ack)      \
> +                       g_unexpected++;                                 \
> +               else                                                    \
> +                       g_sock_state =3D SYN_RECV_SENDING_SYN_ACK;       =
 \
> +               break;                                                  \
> +       case SYN_RECV:                                                  \
> +               if (tcph.fin || tcph.syn || tcph.rst || !tcph.ack)      \
> +                       g_unexpected++;                                 \
> +               else                                                    \
> +                       g_sock_state =3D ESTABLISHED;                    =
 \
> +               break
> +

The macros make the code difficult to follow.
Could you do it with normal functions?

