Return-Path: <bpf+bounces-56328-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FC1A9576D
	for <lists+bpf@lfdr.de>; Mon, 21 Apr 2025 22:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 818361895F7F
	for <lists+bpf@lfdr.de>; Mon, 21 Apr 2025 20:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0531F0E3A;
	Mon, 21 Apr 2025 20:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dausynZJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AC313FEE
	for <bpf@vger.kernel.org>; Mon, 21 Apr 2025 20:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745268049; cv=none; b=E4OHsWtuDcKSBE24XFVJ4OYXGF1L49hAPvITnjmtlmDaBepmU7iRpoOni11NLNcYmtqdDBg03VfUWQ+lf3VvIhX/Lb75lM1AWIrOY5qAs673P3jNWj4TMF9JCmh9zH9OLENQmwKnMAv+wpzH9hsCEqwCMDhJJH476vR6PCQMacU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745268049; c=relaxed/simple;
	bh=HPo1U1bOEBIqpKO3dXYxoCWodJ4tVhT3FiOemlOnrz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KQrvb+6wpMSL2OcLHZcvd6nPm4bSn7nAUDmRVv2G2LJfJfQLIJXqGC3cDqaRX2bpRB27SrtZxNxN80Kt+PlLqCr1QQDc8nhWpRO5Vxqt7mgQeP81ABHfglmt2hjtv+oqMFcDYkk/M+Ye6ezFheb1T12/6Y6LWsf6c20T2zqLASs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dausynZJ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43ef83a6bfaso173695e9.1
        for <bpf@vger.kernel.org>; Mon, 21 Apr 2025 13:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745268045; x=1745872845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/hk3KoCQ3cfNcS9T6WIJOvBbJ6pbk94kV2LEPNPjexo=;
        b=dausynZJgBKI3+nPgYAJpN6vp/vHVH+hAWPpkz+ODVCKFsD1Uva0khcagArMClc/lV
         WlN6CIN7RN5nSSh2iylmURg5eM/MnA3XgSCRhjhR8OZNuNoxHs7hju2LRPnpg82UZWkw
         fu1SDBfrfyahOOVRVPtWAyYQKHiQAO2ZPr5ZFAr6w88sQ3Y5G2X1CWDmPNXSUL+d4hjl
         TPTHKA2+Bl84yr42rVA/EWN12RdDDuWDiMMrDSZy6JmUsaGC4UyOMs9c94iWsFWs3TPe
         qoGr/N//G07ss4JtKTwTlhxpwtdpcD3hDvT2Tca0eysPu1qarLrgjvjREASwIYOTh82Q
         WFIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745268045; x=1745872845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/hk3KoCQ3cfNcS9T6WIJOvBbJ6pbk94kV2LEPNPjexo=;
        b=uHMqpynWeOlg+Sds3HM7YcVuoE9Eo2C37ZzYjU1nnWLWHsL7bFS28MMleW6iUA5jxW
         c0RQ4qsslsbJSnXuT1KcrNrYdqHtV5XPjqIN5CUZ+P8NQW13rNqBPX4mePe1R37disYL
         ptFmTOvOYxzjBgSnLjVUpRWHaImXv4yHmLq3hPSJHXOHh/GULMi2ZE477j2i8F+H7q4K
         xaLgC1koZO53TOx5iDm/q64jAqH1C7j7E3iSZ8roSqTRw/0Skfj4HGIsvA6/BwtBl5NC
         1TmJTwXsFA7ykqprAMl5SdAy22p1lBckdWs69wQV4yiObKlUqqg9oQ3s0jcFSwyKjQ5A
         BuuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmKpF8LzL+djyo90JVr34DmSqgnNjcOsCAOwX+k5QWktU/+2dv1arbo1kF67bXA12OCEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXrvVY0NsqQr3ThUnSyuymphfKVozz7d5ii9kz16UZoIiLR9oL
	eyAt2FFta5sqLaVKeg/EKCTMaYyViihlvPjyjg7O/618fBTn7ReUxI0zpwzVJ1VlWnOs1S/+gkS
	nEV9tJlZx0R3do9zTtSkgSitdxL+gUtmfKc28
X-Gm-Gg: ASbGncsKtJMPxMgOTwyrf8jNeCSrAnwIwlTx3v6k/aUrk8A/+RY4m2KtG3W/+OsL76i
	S/qq4pCnnkxCtAqlN8nk9sI8DcbBvxBplMG22Wn1RGxtwyEIU6CiwDXwEgqcQ3Au5nn8SHeKs3l
	PFtpD5eYhN0ZXEDpQD1H6JUtqVDi2qaJJ0
X-Google-Smtp-Source: AGHT+IGWcp45aLSZt8FM85c+hC9w5ExOa3HAud/x2yrnqew4c284QGEuar9sexOtbZfwcaDamqAvguiKQzmIHXztEi0=
X-Received: by 2002:a05:600c:4e47:b0:43d:169e:4d75 with SMTP id
 5b1f17b1804b1-4406b5e061dmr4739435e9.1.1745268045300; Mon, 21 Apr 2025
 13:40:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414225227.3642618-1-tjmercier@google.com>
 <20250414225227.3642618-3-tjmercier@google.com> <CAPhsuW54g5YCmLVX=cc3m2nfQTZrMH+6ZMBgouEMMfqcccOtww@mail.gmail.com>
In-Reply-To: <CAPhsuW54g5YCmLVX=cc3m2nfQTZrMH+6ZMBgouEMMfqcccOtww@mail.gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 21 Apr 2025 13:40:32 -0700
X-Gm-Features: ATxdqUHzaEdOwMz7Tlm_8h9gjvDy0ZSo4bia9-RfsuFhcpdkvxrkrY5bpFAEPyo
Message-ID: <CABdmKX1OqLLsY5+LSMU-c=DDUxTFaivNcyXG3ntD8D0ty1Pwig@mail.gmail.com>
Subject: Re: [PATCH 2/4] bpf: Add dmabuf iterator
To: Song Liu <song@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, skhan@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, android-mm@google.com, 
	simona@ffwll.ch, corbet@lwn.net, eddyz87@gmail.com, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	jolsa@kernel.org, mykolal@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 10:58=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> On Mon, Apr 14, 2025 at 3:53=E2=80=AFPM T.J. Mercier <tjmercier@google.co=
m> wrote:
> >
> > The dmabuf iterator traverses the list of all DMA buffers. The list is
> > maintained only when CONFIG_DEBUG_FS is enabled.
> >
> > DMA buffers are refcounted through their associated struct file. A
> > reference is taken on each buffer as the list is iterated to ensure eac=
h
> > buffer persists for the duration of the bpf program execution without
> > holding the list mutex.
> >
> > Signed-off-by: T.J. Mercier <tjmercier@google.com>
> > ---
> >  include/linux/btf_ids.h  |   1 +
> >  kernel/bpf/Makefile      |   3 +
> >  kernel/bpf/dmabuf_iter.c | 130 +++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 134 insertions(+)
> >  create mode 100644 kernel/bpf/dmabuf_iter.c
> >
> > diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
> > index 139bdececdcf..899ead57d89d 100644
> > --- a/include/linux/btf_ids.h
> > +++ b/include/linux/btf_ids.h
> > @@ -284,5 +284,6 @@ extern u32 bpf_cgroup_btf_id[];
> >  extern u32 bpf_local_storage_map_btf_id[];
> >  extern u32 btf_bpf_map_id[];
> >  extern u32 bpf_kmem_cache_btf_id[];
> > +extern u32 bpf_dmabuf_btf_id[];
>
> This is not necessary. See below.
>
> >
> >  #endif
> > diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> > index 70502f038b92..5b30d37ef055 100644
> > --- a/kernel/bpf/Makefile
> > +++ b/kernel/bpf/Makefile
> > @@ -53,6 +53,9 @@ obj-$(CONFIG_BPF_SYSCALL) +=3D relo_core.o
> >  obj-$(CONFIG_BPF_SYSCALL) +=3D btf_iter.o
> >  obj-$(CONFIG_BPF_SYSCALL) +=3D btf_relocate.o
> >  obj-$(CONFIG_BPF_SYSCALL) +=3D kmem_cache_iter.o
> > +ifeq ($(CONFIG_DEBUG_FS),y)
> > +obj-$(CONFIG_BPF_SYSCALL) +=3D dmabuf_iter.o
> > +endif
> >
> >  CFLAGS_REMOVE_percpu_freelist.o =3D $(CC_FLAGS_FTRACE)
> >  CFLAGS_REMOVE_bpf_lru_list.o =3D $(CC_FLAGS_FTRACE)
> > diff --git a/kernel/bpf/dmabuf_iter.c b/kernel/bpf/dmabuf_iter.c
> > new file mode 100644
> > index 000000000000..b4b8be1d6aa4
> > --- /dev/null
> > +++ b/kernel/bpf/dmabuf_iter.c
>
> Maybe we should add this file to drivers/dma-buf. I would like to
> hear other folks thoughts on this.

This is fine with me, and would save us the extra
CONFIG_DMA_SHARED_BUFFER check that's currently needed in
kernel/bpf/Makefile but would require checking CONFIG_BPF instead.
Sumit / Christian any objections to moving the dmabuf bpf iterator
implementation into drivers/dma-buf?

> > @@ -0,0 +1,130 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/* Copyright (c) 2025 Google LLC */
> > +#include <linux/bpf.h>
> > +#include <linux/btf_ids.h>
> > +#include <linux/dma-buf.h>
> > +#include <linux/kernel.h>
> > +#include <linux/seq_file.h>
> > +
> > +BTF_ID_LIST_GLOBAL_SINGLE(bpf_dmabuf_btf_id, struct, dma_buf)
>
> Use BTF_ID_LIST_SINGLE(), then we don't need this in btf_ids.h
>
> > +DEFINE_BPF_ITER_FUNC(dmabuf, struct bpf_iter_meta *meta, struct dma_bu=
f *dmabuf)
> > +
> > +static void *dmabuf_iter_seq_start(struct seq_file *seq, loff_t *pos)
> > +{
> > +       struct dma_buf *dmabuf, *ret =3D NULL;
> > +
> > +       if (*pos) {
> > +               *pos =3D 0;
> > +               return NULL;
> > +       }
> > +       /* Look for the first buffer we can obtain a reference to.
> > +        * The list mutex does not protect a dmabuf's refcount, so it c=
an be
> > +        * zeroed while we are iterating. Therefore we cannot call get_=
dma_buf()
> > +        * since the caller of this program may not already own a refer=
ence to
> > +        * the buffer.
> > +        */
>
> We should use kernel comment style for new code. IOW,
> /*
>  * Look for ...
>  */
>
>
> Thanks,
> Song

Thanks, I have incorporated all of your comments and retested. I will
give some time for more feedback before sending a v2.
>
> [...]

