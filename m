Return-Path: <bpf+bounces-57690-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38304AAE7FE
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 19:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F40921C4293F
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 17:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B254A28D832;
	Wed,  7 May 2025 17:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qyJQwsFB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889FE28D83A
	for <bpf@vger.kernel.org>; Wed,  7 May 2025 17:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746639438; cv=none; b=Z2kZFOxVwPBTKhkBYqlV/N+VP+2Qy/G4lcWjRlKE4Ehr43R6HKMAp+TSSJ5J+5Me2X48BwGi1ZOryvpHMo9lCqkmYmDG9qpvKi5GECwtQXBcwReOzwzf7R4Ceul5JJD3lwTUk5muXXTUO7UM5TBKXc2WsflmcX9ftYMAJNtepPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746639438; c=relaxed/simple;
	bh=bQHhiJb/IfsuDYo0XF1+Y57pCH6WG6CKDTT1nxeWSmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LFKjcjcXD8uC5Yku9m1T8mYNqEG/FTDO+EdAXFsNQa1kCx2DFyYinBjlSPlOxip8xWGxVPdx0Ao/LzwllRBjoYKL6fjZBuy23XQ/sq6uCNB4GWcVn6SFd+7Y2266fStXnsZ35ZPwlNBZ0c+gGj8nKD4R+zHvw6rifb+M0rtE+pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qyJQwsFB; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43d5f10e1aaso4975e9.0
        for <bpf@vger.kernel.org>; Wed, 07 May 2025 10:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746639434; x=1747244234; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bQHhiJb/IfsuDYo0XF1+Y57pCH6WG6CKDTT1nxeWSmE=;
        b=qyJQwsFBjgtBNhkB9GBEU/vDwiCPenXS6NhmT3V9TSs/k+WfB8H+j+8eMGcGBNUqoJ
         YaGP261J7cYfyLhzBEx+uyCmydH+psw9Jk07U55xu5hhyumtYlQi26hNl6cIpDFl/oXS
         g/bBUJGsh/6vPsudxtX4g6FgvKs/V4fho/lfXquPAOO3NSnp/frlUanUXQnsj1hw2VLk
         mLC/zjEGeRgaBuTWVIcd5vpNKxOjvk8JAVzJYpEi0HGj3BIg+Jn2bQS5s1Pe64sfoBNd
         /BfJna7/eVlg53MwqmZZAIULCInqmcts/ezxre5VQm6AWlY7M5L7pwk+iU7TWqKt8SCw
         oVNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746639434; x=1747244234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bQHhiJb/IfsuDYo0XF1+Y57pCH6WG6CKDTT1nxeWSmE=;
        b=vcNqCY70qZMZG0e8f06x7C1rZDf8iKsquoZJSJencESj+ZaMN3737eCs/lXk9SdSCD
         8b5xgJhyqiG2jJ1JCdkSbCj4stTU9g5oHiRa+T70pTC3S+7gISBqewAOGDMvr+lbZ8fa
         bFrqtK3a3QAFTbTSRQO3lmAzJLqKvlLzcNCG4+GBKycQSJEL37LzvRVg9jz/6EIWuexd
         L/uFUMqS0V2+AN+PIvGVhWHeYpoIZzP3fdv21LHqpMWOADh8e0Fibmeld/TPB0udfT8k
         nVxVXrA/OKIJsu2wqsEdr9dstkTrCJwT7/RCWJuOMsR0AuS1HPtI0WnJhgOlSdOPcLUd
         4ShA==
X-Forwarded-Encrypted: i=1; AJvYcCWOstWKn8QvUppZBKKdLks900bvkKvh+oezIWpGQTkhhC0AkvXkH5Nwo24FkROyDaJ4hTI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzch6l/hmr1wUz+XAzu+e5x2IVC56OeTbuj1R/jB4cLXzJtKqsp
	E3lPfMdLFGc3K3gRAklciXtIEa8Dh7EIgO/3K6kOUDxGg/3RRTx+2u6WIrMU3Z8cGsn9zRyB27p
	yp/IM3wPTb/EbRXzTfh2PGVBluHwVxqS9Mis+
X-Gm-Gg: ASbGnctC4N87fEOohQ06hIIIjycFCV9ZXucMhRIq+kdTYlCY5ATn1O8PN1VXUoaNq53
	HNt5YogBbRUQYbNX3P1bLWl45Ol7qdS0av4FXi74NJu+y/Xs4gCJNyNiYKUIJV0w4srv7sB4Kbs
	JTRNrJleVTnjFActlFn/CLtnhYVamYiwwjwiQudCWKfwrWCPxt8cw=
X-Google-Smtp-Source: AGHT+IGhDsyDC4rx4Jh4KPoVriF6uM/2LMAigWo/dJgJXOk4tdHRjlokfIMBEcSr4ZZiHUTQp//vG2FjpjSJlL89x3c=
X-Received: by 2002:a05:600c:4448:b0:43b:c2cc:5075 with SMTP id
 5b1f17b1804b1-441d4d4b8d4mr1462165e9.5.1746639433809; Wed, 07 May 2025
 10:37:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507001036.2278781-1-tjmercier@google.com>
 <20250507001036.2278781-3-tjmercier@google.com> <CAADnVQL2i87Q4NEX-4rXDBa_xpTWnh=VY-sMCJzK+nY0qogeqw@mail.gmail.com>
In-Reply-To: <CAADnVQL2i87Q4NEX-4rXDBa_xpTWnh=VY-sMCJzK+nY0qogeqw@mail.gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 7 May 2025 10:37:01 -0700
X-Gm-Features: ATxdqUGvlgXnJv15CWumpdguGu0hVB25voP1FwyUGSqp8OgHDoPOAE5CsZeJmPA
Message-ID: <CABdmKX15i760AKT3e6BL-mOUgOjNfX7ugYJQmy_J6YD1TeNEfw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/5] bpf: Add dmabuf iterator
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Shuah Khan <skhan@linuxfoundation.org>, Song Liu <song@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, android-mm@google.com, simona@ffwll.ch, 
	Eduard <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 7:14=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, May 6, 2025 at 5:10=E2=80=AFPM T.J. Mercier <tjmercier@google.com=
> wrote:
> >
> > +/**
> > + * get_first_dmabuf - begin iteration through global list of DMA-bufs
> > + *
> > + * Returns the first buffer in the global list of DMA-bufs that's not =
in the
> > + * process of being destroyed. Increments that buffer's reference coun=
t to
> > + * prevent buffer destruction. Callers must release the reference, eit=
her by
> > + * continuing iteration with get_next_dmabuf(), or with dma_buf_put().
> > + *
> > + * Returns NULL If no active buffers are present.
> > + */
>
> kdoc wants to see 'Return:'.
>
> See errors in BPF CI.
>
> And patch 5 shouldn't be using /** for plain comments.

Thanks, I found the CI errors, fixed, and verified with
scripts/kernel-doc. I didn't receive emails about them though, not
sure if I should have.

> pw-bot: cr

