Return-Path: <bpf+bounces-10511-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EECD07A9075
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 03:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D772B207FA
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 01:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDF317EC;
	Thu, 21 Sep 2023 01:28:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B329217EA
	for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 01:28:43 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227E7A9
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 18:28:42 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-991c786369cso45041566b.1
        for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 18:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695259720; x=1695864520; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Wr/HYaZ9MIO0IOaPIsMZKvc+ViX7d67JxxeynHCFuU=;
        b=E4A+rgU3r3wjiIuocyebuAyVv6BfatFD9E3EYQ38VXAbvaU6h5GN5QEdYn/7D73wxo
         VifjEPknaQ0+dXwK7brCUc+dbAPu/GSHFpt9ooiFtvtQ27RcQ0P15kz4YLdO8XmpNPh/
         YCOnKANkyzllsYGm0dwWO0rmaouyqQqljEmHEaxdQMoZK5xvQYrYf7BFiqPmjFcRaKLH
         hIGvIwLUw1EF6C5M6bDWFf0SBSNVWpog88JYOtbchwv6QoaXeiC0RKhua787vt1hRAPM
         U5UaAKIudNUzLRAQr90SU0etvAdf/vDxRzfF4Nxg/EgtCwE28y40XS1pdYVXlwhKKPY1
         F5kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695259720; x=1695864520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Wr/HYaZ9MIO0IOaPIsMZKvc+ViX7d67JxxeynHCFuU=;
        b=Kzg2y53tFtnb0EpJore019wvJ4DgqzK9yTY6lRfDOgKx1IflpZ2k7pCvDnbNYgHfNn
         ldxDA9Me3jIgbe2YbPId1GjxQsGiduIqBd3s9pZAXZjAEUeWWGQsVBLfddd3TwyP1gTI
         GzDScaJ27pIwkf5eze1Sl7Kjb1uZdl7FBPijGnkli0gBQXyxMHUnUKJzXP2rLqM4sshU
         h5e6suGt86QP5nymQC2261vhNAYS5Kg15efChAE/HrrmCTuh8RQ1mJjmubOupc0jvJBP
         H1SBtwowyQaAqSLtDm4TyOipS3dRj+IdrTUnXvV6ClZttMZI3994cGrel8wTrWJIi4qD
         pG1g==
X-Gm-Message-State: AOJu0YwPpWx+XJ0ClVNTkUIn5R04blH5dyhQ1xE3RQnh7X+El4O//YNU
	f0yafFHv7lPNDVaU+aNGWIldJjM78IQpxXYPbQE=
X-Google-Smtp-Source: AGHT+IFdjJFm5UjWmz1VyIC3voo7YjTTqZDnfonXELLpcGIWGrlBycx3klwy+LJOiaEwhDuyih/eLtSlS1ksPDokeV0=
X-Received: by 2002:a17:906:73c1:b0:9a5:a701:2b90 with SMTP id
 n1-20020a17090673c100b009a5a7012b90mr3619120ejl.40.1695259720576; Wed, 20 Sep
 2023 18:28:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230914231123.193901-1-martin.kelly@crowdstrike.com> <20230914231123.193901-10-martin.kelly@crowdstrike.com>
In-Reply-To: <20230914231123.193901-10-martin.kelly@crowdstrike.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 20 Sep 2023 18:28:29 -0700
Message-ID: <CAEf4BzYnFh_sXj8P-zUGHD8BBUv2MR9LWpw9DxS+RDntobC8cw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 09/14] libbpf: add ring__size
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
> Add ring__size to get the total size of a given ringbuffer.
>
> Signed-off-by: Martin Kelly <martin.kelly@crowdstrike.com>
> ---
>  tools/lib/bpf/libbpf.h   | 8 ++++++++
>  tools/lib/bpf/libbpf.map | 1 +
>  tools/lib/bpf/ringbuf.c  | 5 +++++
>  3 files changed, 14 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 87e3bad37737..299d98402ad4 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -1290,6 +1290,14 @@ LIBBPF_API unsigned long ring__producer_pos(const =
struct ring *r);
>   */
>  LIBBPF_API size_t ring__avail_data_size(const struct ring *r);
>
> +/**
> + * @brief **ring__size()** returns the total size of the ringbuffer.

it's confusing to use "ringbuffer" here, as you refer to ring buffer
*manager* and to ring buffer *map* inside it with this. Let's be more
precise and also maybe mention that this is the size of ring buffer's
map data area (excluding producer/consumer pages)


> + *
> + * @param r A ring object.
> + * @return The total size of the ringbuffer.
> + */
> +LIBBPF_API size_t ring__size(const struct ring *r);
> +
>  struct user_ring_buffer_opts {
>         size_t sz; /* size of this struct, for forward/backward compatibi=
lity */
>  };
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index f66d7f0bc224..4ca77e715667 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -404,4 +404,5 @@ LIBBPF_1.3.0 {
>                 ring__avail_data_size;
>                 ring__consumer_pos;
>                 ring__producer_pos;
> +               ring__size;
>  } LIBBPF_1.2.0;
> diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> index f51ad1af6ab8..52c385195f32 100644
> --- a/tools/lib/bpf/ringbuf.c
> +++ b/tools/lib/bpf/ringbuf.c
> @@ -355,6 +355,11 @@ size_t ring__avail_data_size(const struct ring *r)
>         return ring__producer_pos(r) - ring__consumer_pos(r);
>  }
>
> +size_t ring__size(const struct ring *r)
> +{
> +       return r->mask + 1;
> +}
> +
>  static void user_ringbuf_unmap_ring(struct user_ring_buffer *rb)
>  {
>         if (rb->consumer_pos) {
> --
> 2.34.1
>

