Return-Path: <bpf+bounces-9056-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFAC78EDD8
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 14:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 376F0281572
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 12:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9888711715;
	Thu, 31 Aug 2023 12:58:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5647481;
	Thu, 31 Aug 2023 12:58:33 +0000 (UTC)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6ADCF2;
	Thu, 31 Aug 2023 05:58:31 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99c93638322so154912766b.1;
        Thu, 31 Aug 2023 05:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693486710; x=1694091510; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=k8DYQ7uXcJO6r+s6TemNXKJyBx508B85eJ8IVr0n4Ys=;
        b=FhKg2mROH6plvNyT7VH8RDwqY7gM9+J3lcHa43ViQWDmWpE0+1X6M/lVMa6EHrnhZi
         2k2DRV3Ecg35GxcWPg6oNjzasmksyJHJb9VhyKc3UJMDzHagf387c6UHL9FvKMnFxwFg
         p8Rtp209EKjonevtbrK0HJIvbgbwTEbK4nxR3In9oQEJf4I+7XAiY3uci/Ry0h8jqs9N
         KU3dHqAAT6A0NPVmgLuQZIO/W+dU5ADiSj5XBpSTHXB0jZboSLWZ+BIVMWkDawkW8IiQ
         FJbbUxgvnSFoL1mIPqiobNi82b20arWu2W10WfmF5MMmVxvV2qprojEtZ2YgCspu/N4K
         uR7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693486710; x=1694091510;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k8DYQ7uXcJO6r+s6TemNXKJyBx508B85eJ8IVr0n4Ys=;
        b=DU+zOlwPaoeHW7ro/N8iMxE96gb7jPMwvpc7CPkwS7EnH4SiW2egNgIMnLEu/olx0f
         7DLZpDaW4svmj6t8boAv8JnJrBLHMMsc8FEdyWcvTgWm7/OUMKcW/qhNg6yfaHIPeSSp
         1fGmKUpQgea6DPZ6pcO2wX0qt/fXpu9DIiNFTTRl+E56yFVC/N5ldBeSj/oW3pZKA2cz
         oX9u4D8ivD+47LecOGBvYrdnyLK9f7QbW3njJVOdyd2JBuGG0I4VMT0WjtD/Rt32fGXI
         jdb2+VrxEnmeIdfuOwIlvaOu0iEp2WsJ78fOOq1tOaxAoYt6zjdbZ3ATW48lNsmoZknf
         0g8A==
X-Gm-Message-State: AOJu0Yx2mLPKpgm+BOTv8Inr7qJxc2J3ppDogq233TSBSZHUveQ8G/BK
	o0wyUHXFGyAqn2bXEhJmJHJXOj9Lf+U=
X-Google-Smtp-Source: AGHT+IFvN+zaf4qLVDnGrAs18vC4O8NE5EtHF2Ku6pb+2wQ8Uokl7w7CVF1oKaeNFKYiV8ozaipKOA==
X-Received: by 2002:a17:907:7283:b0:9a5:83f0:9bc5 with SMTP id dt3-20020a170907728300b009a583f09bc5mr3032414ejc.18.1693486709998;
        Thu, 31 Aug 2023 05:58:29 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id lj17-20020a170906f9d100b009829dc0f2a0sm730975ejb.111.2023.08.31.05.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 05:58:29 -0700 (PDT)
Message-ID: <e18920c41ad99d22837e82ad3df7a33e12b67aaf.camel@gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: fix a CI failure caused by
 vsock write
From: Eduard Zingerman <eddyz87@gmail.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>, Bobby Eshleman
	 <bobby.eshleman@bytedance.com>
Date: Thu, 31 Aug 2023 15:58:28 +0300
In-Reply-To: <20230831013105.2930824-1-xukuohai@huaweicloud.com>
References: <20230831013105.2930824-1-xukuohai@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 2023-08-31 at 09:31 +0800, Xu Kuohai wrote:
> From: Xu Kuohai <xukuohai@huawei.com>
>=20
> While commit 90f0074cd9f9 ("selftests/bpf: fix a CI failure caused by vso=
ck sockmap test")
> fixes a receive failure of vsock sockmap test, there is still a write fai=
lure:
>=20
> Error: #211/79 sockmap_listen/sockmap VSOCK test_vsock_redir
> Error: #211/79 sockmap_listen/sockmap VSOCK test_vsock_redir
>   ./test_progs:vsock_unix_redir_connectible:1501: egress: write: Transpor=
t endpoint is not connected
>   vsock_unix_redir_connectible:FAIL:1501
>   ./test_progs:vsock_unix_redir_connectible:1501: ingress: write: Transpo=
rt endpoint is not connected
>   vsock_unix_redir_connectible:FAIL:1501
>   ./test_progs:vsock_unix_redir_connectible:1501: egress: write: Transpor=
t endpoint is not connected
>   vsock_unix_redir_connectible:FAIL:1501
>=20
> The reason is that the vsock connection in the test is set to ESTABLISHED=
 state
> by function virtio_transport_recv_pkt, which is executed in a workqueue t=
hread,
> so when the user space test thread runs before the workqueue thread, this
> problem occurs.
>=20
> To fix it, before writing the connection, wait for it to be connected.

Fun fact:
while trying this patch I hit an oops [1]. I'm currently trying to
bisect the commit causing this oops and have the following observation:
- good revisions don't have this test as flip-flop
- bad revisions have this test as flip-flop.

[1] https://lore.kernel.org/bpf/de816b89073544deb2ce34c4b242d583a6d4660f.ca=
mel@gmail.com/

>=20
> Fixes: d61bd8c1fd02 ("selftests/bpf: add a test case for vsock sockmap")
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> ---
>  .../bpf/prog_tests/sockmap_helpers.h          | 29 +++++++++++++++++++
>  .../selftests/bpf/prog_tests/sockmap_listen.c |  5 ++++
>  2 files changed, 34 insertions(+)
>=20
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h b/t=
ools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
> index d12665490a90..837dfb0361c6 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
> @@ -179,6 +179,35 @@
>  		__ret;                                                         \
>  	})
> =20
> +static inline int poll_connect(int fd, unsigned int timeout_sec)
> +{
> +	struct timeval timeout =3D { .tv_sec =3D timeout_sec };
> +	fd_set wfds;
> +	int r;
> +	int eval;
> +	socklen_t esize;
> +
> +	FD_ZERO(&wfds);
> +	FD_SET(fd, &wfds);
> +
> +	r =3D select(fd + 1, NULL, &wfds, NULL, &timeout);
> +	if (r =3D=3D 0)
> +		errno =3D ETIME;
> +
> +	if (r !=3D 1)
> +		return -1;
> +
> +	if (getsockopt(fd, SOL_SOCKET, SO_ERROR, &eval, &esize) < 0)
> +		return -1;
> +
> +	if (eval !=3D 0) {
> +		errno =3D eval;
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
>  static inline int poll_read(int fd, unsigned int timeout_sec)
>  {
>  	struct timeval timeout =3D { .tv_sec =3D timeout_sec };
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/to=
ols/testing/selftests/bpf/prog_tests/sockmap_listen.c
> index 5674a9d0cacf..2d3bf38677b6 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> @@ -1452,6 +1452,11 @@ static int vsock_socketpair_connectible(int sotype=
, int *v0, int *v1)
>  	if (p < 0)
>  		goto close_cli;
> =20
> +	if (poll_connect(c, IO_TIMEOUT_SEC) < 0) {
> +		FAIL_ERRNO("poll_connect");
> +		goto close_cli;
> +	}
> +
>  	*v0 =3D p;
>  	*v1 =3D c;
> =20


