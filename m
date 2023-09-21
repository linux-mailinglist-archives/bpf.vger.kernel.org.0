Return-Path: <bpf+bounces-10512-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD937A9076
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 03:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 278871C209E8
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 01:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B878117FC;
	Thu, 21 Sep 2023 01:28:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E0317EA
	for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 01:28:47 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8794A1
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 18:28:45 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-532aaba8747so386541a12.3
        for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 18:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695259724; x=1695864524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lQVH68Mb1mZNUu3Mv9Q7waKwawX/2OfmnaaVoJv6DJw=;
        b=IBWVEl/1Ifp0+CUCsowUyohPJweTDLRdPSKmYRDPoxpuSjOXM9Fg/wP8cWl4HcHrM3
         KMO2Vx00xMaUyAKKGwzY8G9V82D1Es6nd+bbF486IdIIMeXCoxjEaOdFdrsAFfkJiNJt
         eY/kJP5gJoauFMlm43EhmVSoukDgyCZFBMZNc3lv6GpDGWrnnbSZu2yBqlh99bycH/EA
         RNFC6g4o3Ya8JNv97g+DDVmChRd9f4XJK00quhdY0iKKAXuHLJV9mgQsxm6z3h0xyns6
         +uVmIVCOEPZg6CROun8KFzZmMyhhOphPOxH3aXpmQ/Y5Jjj90xdcHBuDfcupGV+cmhun
         ralQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695259724; x=1695864524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lQVH68Mb1mZNUu3Mv9Q7waKwawX/2OfmnaaVoJv6DJw=;
        b=CYoBoch7/EyjXofa5liDlXN/eKHFMYP7cEGtHkHDE/GM/1t3xyvpp42DtHV2QetoTn
         ZCA0ZF8weC6uDNVcF8FXfGBWZhuclF1PymQ2sYk8v2CmOu8MIpFCFaXLO7Cuoo58rmwx
         jVOF+jK5atfBLlqW5hXptYsVtcbBvsLK0bgkoiOA3UGyQmTbgYjbpwJn24IA99xni0hE
         /zmldA87pRrGs4u0WsECqPjkLojJPXY02rOdR81PZx0OJtST7s+ZneXyeil+PKGA02xh
         xhMUmKar3tlofepxgbmA3OX8ShCMvaTlCF5kOg0H2Tf1VikQ8ms5cNPaQGG70yNXdUEk
         oPKQ==
X-Gm-Message-State: AOJu0Yx+uTCC2vK21Yd7vVvRDtH6iweY2pSg1s12sLsR9ob2pUZTFkIN
	FUKui+kn3M9MGDQ0xw4ATRhHviTc/uS4w3MISPeAp9Jv
X-Google-Smtp-Source: AGHT+IGjWYfY1ykTBVy+8rMSvTZFz0jG1nmheIuf4pLMagSF2p4VzY2LkQcpvmQ9fgNrQfLYd+uvYX/YsySuNCE9fOo=
X-Received: by 2002:a17:906:1d05:b0:9ae:406c:3423 with SMTP id
 n5-20020a1709061d0500b009ae406c3423mr3520171ejh.6.1695259724028; Wed, 20 Sep
 2023 18:28:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230914231123.193901-1-martin.kelly@crowdstrike.com> <20230914231123.193901-14-martin.kelly@crowdstrike.com>
In-Reply-To: <20230914231123.193901-14-martin.kelly@crowdstrike.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 20 Sep 2023 18:28:32 -0700
Message-ID: <CAEf4BzYfEafeOk75zv-2de0NKS-+MQuRdjjwtdyV5Rbb3bmXgA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 13/14] libbpf: add ring__consume
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
> Add ring__consume to consume a single ringbuffer, analogous to
> ring_buffer__consume.
>
> Signed-off-by: Martin Kelly <martin.kelly@crowdstrike.com>
> ---
>  tools/lib/bpf/libbpf.h   | 10 ++++++++++
>  tools/lib/bpf/libbpf.map |  1 +
>  tools/lib/bpf/ringbuf.c  | 13 +++++++++++++
>  3 files changed, 24 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index d2a237086c2c..861f8b6795e9 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -1307,6 +1307,16 @@ LIBBPF_API size_t ring__size(const struct ring *r)=
;
>   */
>  LIBBPF_API int ring__map_fd(const struct ring *r);
>
> +/**
> + * @brief **ring__consume()** consumes available ringbuffer data without=
 event
> + * polling.
> + *
> + * @param r A ring object.
> + * @return The number of records consumed (or INT_MAX, whichever is less=
), or
> + * a negative number if any of the callbacks return an error.
> + */
> +LIBBPF_API int ring__consume(struct ring *r);
> +
>  struct user_ring_buffer_opts {
>         size_t sz; /* size of this struct, for forward/backward compatibi=
lity */
>  };
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 13800b73c343..4b5124bb0e1a 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -402,6 +402,7 @@ LIBBPF_1.3.0 {
>                 bpf_program__attach_uprobe_multi;
>                 ring_buffer__ring;
>                 ring__avail_data_size;
> +               ring__consume;
>                 ring__consumer_pos;
>                 ring__map_fd;
>                 ring__producer_pos;
> diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> index 2dba2836d85b..b7ef003366d3 100644
> --- a/tools/lib/bpf/ringbuf.c
> +++ b/tools/lib/bpf/ringbuf.c
> @@ -365,6 +365,19 @@ int ring__map_fd(const struct ring *r)
>         return r->map_fd;
>  }
>
> +int ring__consume(struct ring *r)
> +{
> +       int64_t res;
> +
> +       res =3D ringbuf_process_ring(r);
> +       if (res < 0)
> +               res =3D libbpf_err(res);

it's a bit confusing to have libbpf_err() not within some return.
Let's do `return libbpf_err(res);` here as the only error path?

> +       else if (res > INT_MAX)
> +               res =3D INT_MAX;
> +
> +       return res;

and here we can have `return res > INT_MAX ? INT_MAX : res;`


> +}
> +
>  static void user_ringbuf_unmap_ring(struct user_ring_buffer *rb)
>  {
>         if (rb->consumer_pos) {
> --
> 2.34.1
>

