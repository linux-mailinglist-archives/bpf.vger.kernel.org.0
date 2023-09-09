Return-Path: <bpf+bounces-9590-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAEC47994BD
	for <lists+bpf@lfdr.de>; Sat,  9 Sep 2023 02:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC22A1C20AF5
	for <lists+bpf@lfdr.de>; Sat,  9 Sep 2023 00:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40F31108;
	Sat,  9 Sep 2023 00:44:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11A57E5
	for <bpf@vger.kernel.org>; Sat,  9 Sep 2023 00:44:48 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942042D75
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 17:44:25 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-31f71b25a99so2130642f8f.2
        for <bpf@vger.kernel.org>; Fri, 08 Sep 2023 17:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694220190; x=1694824990; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jn7N8/7unp/UDFxJztV15cAYobxm7KxB9sqsvB03zM8=;
        b=iCB4WqMnQyBb7eumVIH4Gq4Vwe2yI/5k7RgJ5MJvz0H5HY1KVLAYTNS8Q8JIxXhayH
         i0lnfnAiSRUrG8/DitkqbVdg12lpFICsLd0cu09xrT0MvRqToje0pHJs+j6b2qjsQc37
         b1N1wvRq6LQrr9rrblOjaY98CZdw2SDXODF7JgadUWtAnN6VNBIvPKzm4AEAaBJuO174
         Q3UixeoeaOMDAYDyetUqFX4ThDekERHc7z4pq4K07E29TipggFig/Y+QBvGY+W3DyGFq
         neNci9vReMqK0FIs6lL8upT9Bcvu2OjOULBnXhSVxzoeFuyom9XidzZiPM6O5OGaCHir
         Frsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694220190; x=1694824990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jn7N8/7unp/UDFxJztV15cAYobxm7KxB9sqsvB03zM8=;
        b=aadXqynL17M8e3EHNqIFfLgPFeute5hoOO12Djry8PiQCsC9F1nojJ/bx/hbrkiZyW
         n+4VNz2Jac1Nxgb4aJ/vYDQSuBQoiKcB9alB+Bf96Ly5D7uFclRdHmeeOmhmZZRCKGcj
         rSkQsatfFeIKWbJWxLsdZfcj9vnXl+MtYuwb4tOY6qJKaVB6ke7rdF4tqipA/ymiahAz
         9jCeTOCMm9C2KjJtEWtcE7s/V9ODgoH1REe9Q3OF2fxnr3RKdvIzkOa/OGY0qg3roGIj
         Pq1gagQObl+gkmz4OxbxD0KisdHL6dSR8ksurFGcRt1GikMar+mxyuu+yVd1isu0auoo
         mFug==
X-Gm-Message-State: AOJu0YyPmPhcoKIYb+qRwLWY6TEOR2sTlVdRASGmuYo66qhrhngXNhEb
	Iwx88XIWnvN+2uvt81w17bCG23g0hdxoZAHD9NZ9Kyoe
X-Google-Smtp-Source: AGHT+IE2hV3TV/dAryRhGPMHyojowiXskHa/nWLfqdrjXzooT3YkemxmN4nMpLYV18sdL1w7cZXHZfb3h4nYQp29aHs=
X-Received: by 2002:a17:906:1db2:b0:9a4:88af:b77 with SMTP id
 u18-20020a1709061db200b009a488af0b77mr3235154ejh.60.1694219160682; Fri, 08
 Sep 2023 17:26:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230907234041.58388-1-martin.kelly@crowdstrike.com> <20230907234041.58388-2-martin.kelly@crowdstrike.com>
In-Reply-To: <20230907234041.58388-2-martin.kelly@crowdstrike.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 8 Sep 2023 17:25:48 -0700
Message-ID: <CAEf4BzZXVZ6LTX2KuXDo427kGwi4g1zGNfgEPrHfnJ4AmDq6Nw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: add ring_buffer__query
To: Martin Kelly <martin.kelly@crowdstrike.com>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 7, 2023 at 4:42=E2=80=AFPM Martin Kelly
<martin.kelly@crowdstrike.com> wrote:
>
> Add ring_buffer__query to fetch ringbuffer information from userspace,
> working the same as the bpf_ringbuf_query helper.
>
> Signed-off-by: Martin Kelly <martin.kelly@crowdstrike.com>
> ---
>  tools/lib/bpf/libbpf.h   |  2 ++
>  tools/lib/bpf/libbpf.map |  1 +
>  tools/lib/bpf/ringbuf.c  | 33 +++++++++++++++++++++++++++++++++
>  3 files changed, 36 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 0e52621cba43..4ceed3ffabc2 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -1248,6 +1248,8 @@ LIBBPF_API int ring_buffer__add(struct ring_buffer =
*rb, int map_fd,
>  LIBBPF_API int ring_buffer__poll(struct ring_buffer *rb, int timeout_ms)=
;
>  LIBBPF_API int ring_buffer__consume(struct ring_buffer *rb);
>  LIBBPF_API int ring_buffer__epoll_fd(const struct ring_buffer *rb);
> +LIBBPF_API __u64 ring_buffer__query(struct ring_buffer *rb, unsigned int=
 index,
> +                                   __u64 flags);
>
>  struct user_ring_buffer_opts {
>         size_t sz; /* size of this struct, for forward/backward compatibi=
lity */
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 57712321490f..cbb3dc39446e 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -400,4 +400,5 @@ LIBBPF_1.3.0 {
>                 bpf_program__attach_netfilter;
>                 bpf_program__attach_tcx;
>                 bpf_program__attach_uprobe_multi;
> +               ring_buffer__query;
>  } LIBBPF_1.2.0;
> diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> index 02199364db13..85ccac7a2db3 100644
> --- a/tools/lib/bpf/ringbuf.c
> +++ b/tools/lib/bpf/ringbuf.c
> @@ -69,6 +69,15 @@ static void ringbuf_unmap_ring(struct ring_buffer *rb,=
 struct ring *r)
>         }
>  }
>
> +static unsigned long ringbuf_avail_data_sz(struct ring *r)
> +{
> +       unsigned long cons_pos, prod_pos;
> +
> +       cons_pos =3D smp_load_acquire(r->consumer_pos);
> +       prod_pos =3D smp_load_acquire(r->producer_pos);
> +       return prod_pos - cons_pos;
> +}
> +
>  /* Add extra RINGBUF maps to this ring buffer manager */
>  int ring_buffer__add(struct ring_buffer *rb, int map_fd,
>                      ring_buffer_sample_fn sample_cb, void *ctx)
> @@ -323,6 +332,30 @@ int ring_buffer__epoll_fd(const struct ring_buffer *=
rb)
>         return rb->epoll_fd;
>  }
>
> +/* A userspace analogue to bpf_ringbuf_query for a particular ringbuffer=
 index
> + * managed by this ringbuffer manager. Flags has the same arguments as
> + * bpf_ringbuf_query, and the index given is a 0-based index tracking th=
e order
> + * the ringbuffers were added via ring_buffer__add. Returns the data req=
uested
> + * according to flags.
> + */
> +__u64 ring_buffer__query(struct ring_buffer *rb, unsigned int index, __u=
64 flags)

I can see how this might be useful, but I don't think this exact API
and approach will work well.

First, I'd just add getters to get consumer and producer position and
producer. User-space code can easily derive available data from that
(and it's always racy and best effort to determine amount of data
enqueued in ringbuf, so having this as part of user-space API also
seems a bit off). RING_SIZE is something that user-space generally
should know already, or it can get it through a bpf_map__max_entries()
helper.

Second, this `unsigned int index` is not a good interface. There is
nothing in ring_buffer APIs that operates based on such an index.

So we need to think a bit more about the better way to provide this in
libbpf UAPI, IMO.

> +{
> +       struct ring *ring =3D &rb->rings[index];
> +
> +       switch (flags) {
> +       case BPF_RB_AVAIL_DATA:
> +               return ringbuf_avail_data_sz(ring);
> +       case BPF_RB_RING_SIZE:
> +               return ring->mask + 1;
> +       case BPF_RB_CONS_POS:
> +               return smp_load_acquire(ring->consumer_pos);
> +       case BPF_RB_PROD_POS:
> +               return smp_load_acquire(ring->producer_pos);
> +       default:
> +               return 0;
> +       }
> +}
> +
>  static void user_ringbuf_unmap_ring(struct user_ring_buffer *rb)
>  {
>         if (rb->consumer_pos) {
> --
> 2.34.1
>

