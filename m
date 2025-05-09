Return-Path: <bpf+bounces-57893-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91434AB1B6B
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 19:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 391C21BA69A4
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 17:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5D5238C16;
	Fri,  9 May 2025 17:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q66q71F4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B745F238C10
	for <bpf@vger.kernel.org>; Fri,  9 May 2025 17:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746810821; cv=none; b=CA7KQIZkoTDlwMnzWOtYpV5On3gur5L8Vtx/+v+igKuA+bKTVt1l3Bj0jevs0t+/SHKvZchtli1rCA/mIWiguLl3KGfIgTSsUcnA6BGOF4ZSF3ytQAapMxFZubimLhSi7Oj9Oi168ZLFSKLDhRBoPZLmpt6YUzMKblrGjAcZxOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746810821; c=relaxed/simple;
	bh=q0i9baUv6Smn9AiNhymhI2ACXAdYEVlp2to7dVDGUeA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oOjSx26ANDwGIntzPxm8bzOmPRGzx+YuEe+YM1ViSKABXM0L/+5elByd4FJL1FOcRK+ZFqdTyf7KGFFQIvD1ti68TeN0NU02fhn+TSwdCGUK/3G6e4t3D7cdyZRhjkf1IAwTMYdoK7hIcyIqIwCXgdZOX10dO3FaWsNwY+zkuVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q66q71F4; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cfe808908so2725e9.0
        for <bpf@vger.kernel.org>; Fri, 09 May 2025 10:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746810818; x=1747415618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4VaVuUlmTBwUGFLDmqnTpZ1Y04NZbtvxnB5A69BImEI=;
        b=q66q71F4RcSQjpNT1a9ouNk/Gu9qAuo4hZC53/XyXcv1qxrZq5h+SIUdxx/742e9+z
         36LgGCiy5hwbMvvB4JkksuwSds3R84DVqW747Wra10Cx8TDx5JoqEhizM37ODMibzNsi
         QxIWeNzMjdWRwzKws89AcCQyfV/YBrFBbutklmk8DdpIximhIMdIitxDUoXHLlkEs+fD
         tKSed+TF/QBkngSJmPwDAsr/YeOk+k+FxgSW8LAGahBOHrutV4u/PJc73Oi5dD3xJbaE
         wWoU0XgYwNokOnBbFuQCNZ19RMlPxFCGSJiQe0VQoGiQ2if2MGhezJfJTz69qQqEQ81t
         jBXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746810818; x=1747415618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4VaVuUlmTBwUGFLDmqnTpZ1Y04NZbtvxnB5A69BImEI=;
        b=qxhEy4Hij98Nx71gezFO48auSM9n1n7eOFmG/B172vk7B1qi3RfjKOOTw7fU2Ajgqk
         iyQX1lJ0wGr9fqWX1+lvOyrfPyMfvvUgTV7Mk24/6i7NFtLiPRMgurqScTIje714tHgO
         d18Krqa6PazOCwiFyUs31F/ABIvZrVsurNt3WnBAsY8jtYGBUYjNjTucV8nmwZMUUc/+
         BPHcgO12RvSZqd8k+tMiX5cN8SZYxchSAp0SC0GJIhKDwgEaJ5AY8uFcEis27KQBzXAl
         4bwatHkPJ1i07iNY2KudMcp+dXIyYpH080Xjo3YihqSCVFijRkVQCVWgiP9aQA7030R2
         C2dw==
X-Forwarded-Encrypted: i=1; AJvYcCWa5YEpew33oAp28RXMtF8f/0WecyTg8C8/AQ3EmysXhX58uRIKDVcAq97D9HgvZhlDIYo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/u2K0n/A3naFeW+JxkPEetA8NBQ6BoYIkKqkaqzyr9b+5ibm8
	38koOlbBCo0Xs3pUaHrw4Wy8JRMVkhFxsupfw38s7apXBCwy/b4c8NEsbMYvSKPfopaA3HtlfVm
	cUNwjxVOZl7K/6LUTTD5StgCqOjPdnjqDAshC
X-Gm-Gg: ASbGncucAANtdns8huVt1o8ycsp4S+dgKTgCg4DlQJKqjiAsQi79KljfNThEvlEtoeh
	0FwRlM9tjRAwdBFzWpBY40EWfqTXe3rKt2XVzYGuM3Z3iimMWA5Nj8gbEdwdTrNi9pnitqxlBji
	y8kANhAdG2i/nOOITj2xA8
X-Google-Smtp-Source: AGHT+IGT/ZF46/GjI2YJV8SislyLWmjgR7bh1R7xJkwAOUVe7U8oq9t1ZWPW+aXIicMtdoBOVsn4uE7XK6SJT8ETH7c=
X-Received: by 2002:a05:600c:3789:b0:439:9434:1b6c with SMTP id
 5b1f17b1804b1-442d7c2cb4dmr1036775e9.3.1746810817854; Fri, 09 May 2025
 10:13:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508182025.2961555-1-tjmercier@google.com>
 <20250508182025.2961555-4-tjmercier@google.com> <CAPhsuW613T4biUPER9zR9DdQA_wscN4-i3vV4efoOKUZ7pkTeA@mail.gmail.com>
In-Reply-To: <CAPhsuW613T4biUPER9zR9DdQA_wscN4-i3vV4efoOKUZ7pkTeA@mail.gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Fri, 9 May 2025 10:13:26 -0700
X-Gm-Features: AX0GCFsAmjlDFEArBqLUnLS1jyLR63E5yA91kW0eDQ-Z7yMddq7EqrFUgFenMYg
Message-ID: <CABdmKX0t-ng2WJPUdjXUgtbyNks4vcp3rVNbQOGPNFRF5kTQGQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 3/5] bpf: Add open coded dmabuf iterator
To: Song Liu <song@kernel.org>
Cc: sumit.semwal@linaro.org, christian.koenig@amd.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	skhan@linuxfoundation.org, alexei.starovoitov@gmail.com, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, android-mm@google.com, 
	simona@ffwll.ch, eddyz87@gmail.com, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 5:28=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> On Thu, May 8, 2025 at 11:20=E2=80=AFAM T.J. Mercier <tjmercier@google.co=
m> wrote:
> >
> > This open coded iterator allows for more flexibility when creating BPF
> > programs. It can support output in formats other than text. With an ope=
n
> > coded iterator, a single BPF program can traverse multiple kernel data
> > structures (now including dmabufs), allowing for more efficient analysi=
s
> > of kernel data compared to multiple reads from procfs, sysfs, or
> > multiple traditional BPF iterator invocations.
> >
> > Signed-off-by: T.J. Mercier <tjmercier@google.com>
>
> Acked-by: Song Liu <song@kernel.org>
>
> With one nitpick below:
>
> > ---
> >  kernel/bpf/dmabuf_iter.c | 47 ++++++++++++++++++++++++++++++++++++++++
> >  kernel/bpf/helpers.c     |  5 +++++
> >  2 files changed, 52 insertions(+)
> >
> > diff --git a/kernel/bpf/dmabuf_iter.c b/kernel/bpf/dmabuf_iter.c
> > index 96b4ba7f0b2c..8049bdbc9efc 100644
> > --- a/kernel/bpf/dmabuf_iter.c
> > +++ b/kernel/bpf/dmabuf_iter.c
> > @@ -100,3 +100,50 @@ static int __init dmabuf_iter_init(void)
> >  }
> >
> >  late_initcall(dmabuf_iter_init);
> > +
> > +struct bpf_iter_dmabuf {
> > +       /* opaque iterator state; having __u64 here allows to preserve =
correct
> > +        * alignment requirements in vmlinux.h, generated from BTF
> > +        */
>
> nit: comment style.

Added a leading /*

(This is copied from task_iter.c, which currently has the same style.)


> > +       __u64 __opaque[1];
> > +} __aligned(8);
> > +
> > +/* Non-opaque version of bpf_iter_dmabuf */
> > +struct bpf_iter_dmabuf_kern {
> > +       struct dma_buf *dmabuf;
> > +} __aligned(8);
> > +
> [...]

