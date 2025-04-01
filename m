Return-Path: <bpf+bounces-55101-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0267FA78343
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 22:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01BF2188B52E
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 20:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813E1212FA7;
	Tue,  1 Apr 2025 20:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixnzGKg3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCC51E1C29
	for <bpf@vger.kernel.org>; Tue,  1 Apr 2025 20:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743539251; cv=none; b=qdBOP9jQMiIz2pcuDWztvYuhczuUDsMGOED29nWkzEu5isx/XpMu/oAUGhTWg0D/8Mht94Ift2i7kCbZUQuwIQwsskfk5qMvV/A2KsGXvpw9EYZgUZ/jrpvidSqXresc0Bkglqsd62qx9xcm92XbjFVWxQ3fFVbQgC0fNU3YEDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743539251; c=relaxed/simple;
	bh=QnlZRu09sDwZ0GYHPs0FpYZGT6ecugzoDqSvOKP9IdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hdXsHTKGsLVfNG4fu+QbDHX7+pZjDcB8mjbXe2Mq3IaphpJM9PFKZI11fhsX/4K/+nV8dB0T4wT51J0bvbodZXagAq94ONURaom26GCZYdKBjxjGeiX+CszAt3RnJnqu5FeSRWhJmFN9jJtOjSX3O89uLeZB7F2Yhwggg5i8xTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ixnzGKg3; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cfb6e9031so53875575e9.0
        for <bpf@vger.kernel.org>; Tue, 01 Apr 2025 13:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743539248; x=1744144048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+06StXpJ1/iz96RyQhwP3ZTaJfEVjyd1lo4plTJkAo=;
        b=ixnzGKg3k/RDf/wlJtPaVE4bLjj/b3hXX9/tCutRbUAN+GJqTv/79QwjViytVdQ4Av
         skc/wFB8syQ/12jN2OX8zl/ycTzNcbbPdGuIpKdVV/ydpmnVPMa5ljKbNRq2UYNyIGEA
         fByZQ0tykXojD/4BrAO7aoexiPhfTkADyZW0wh/AE9u5Cqa4r8UoX5xJyiT32j2z3ia3
         oNOQCx5p8N7lYIe/Ep33gEN8G5iJSaiF+YI29whAZ98AXD03nAOTNeCG6cd8u2+YdF9b
         F25uRyjt4vTmos3k4S+7nYb0RJtSqxU8tAMTuDfzrcIejGIomIZ6HUJOH3HgkQrVWvuo
         e12Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743539248; x=1744144048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c+06StXpJ1/iz96RyQhwP3ZTaJfEVjyd1lo4plTJkAo=;
        b=jBDBvp99haN6rywxS2r6o+uOev9nhJs6mwb57JGLsQNBscz75HbR15zmnReoicUBMp
         rWGd0P+uB3ebaApvb4NaFx6pBw6DE7CaHJ1b42Ue7v07m/Pgzga4VA4RpxtVqfJi7WfK
         lORx7oczzdRiojGWiIIqUxL4JI3VfUQhahr5cMABye27gKrN8fjrK7i0Z/WnZdMG+EGb
         6JzQzZ6AXR1TQPbG/8XtI63mv8Zp/7kfpXLDrAEIH1nPhQxoPB8JehVc0Kx3Qe8fM1sz
         tkE62ppFLX1B5fhHkSaSRRELDUJFr9ajWbJ9FmfVeJ05xJDAytoO3mf2r+4xP+SgZ8Q4
         LjLg==
X-Forwarded-Encrypted: i=1; AJvYcCUTasuNfHsinB7Fl0Wl3Z1YeBuo4lwb17/Ri729UaxnatIxO6yW9N5mznN9oLBLAYC7xhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbkkNFlvHqK7520zYxHZTdrtVrKjO8f7nUXnCjHPfJM6ADTrBh
	G3hHFrx5CaNoF9ywgeEqFTKE94xMfZtGKtsoJrKr0O0oB6WJ51nhR2K8cPyIGrtzL+DUPRb0Itr
	IitR69ZwIGL2tN+Dp0AnJEipAtV0=
X-Gm-Gg: ASbGncvX8iAUrzTyncwmpBZU2dk+pxjujc15B9TT/XoMzg5J/oe5PT5vj1f0E11oVwO
	bf10XumX3w3Hi3MQtKvcn3yTlbOa+seDbKZ45kxovX90fRGmB3oKLxgWp5GvjYkFEo/vY1wB7dK
	RIuM5HxQYaKJDz95l9rw6tYrL5j8kRFgnV3eap18mb7V1nDVpLcXlm
X-Google-Smtp-Source: AGHT+IFZGrEd8c/SRZ6amPyForfWIxJejCMRa/WCHLpGzugnR/qbj3s/9It5qPb6gYe07jfEgW+IYVPM7nTj4j83chY=
X-Received: by 2002:a05:600c:4689:b0:43c:fe9f:ab90 with SMTP id
 5b1f17b1804b1-43e934aa20dmr95528755e9.28.1743539247701; Tue, 01 Apr 2025
 13:27:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1741874348.git.vmalik@redhat.com> <4e26ca57634db305a622b010b0d86dbb36b09c37.1741874348.git.vmalik@redhat.com>
 <CAEf4BzYTJh06kqR9hL=TvfBTRNskZMCPTAmcD7=nMFJrqR1OSA@mail.gmail.com>
 <317d7c59-a8aa-45ca-a6ab-3b602ac360ed@redhat.com> <CAEf4Bzb=F7nTWvLMo=NgMf_X4bkcNg8rR2E8K6UTv6B++4gxsg@mail.gmail.com>
In-Reply-To: <CAEf4Bzb=F7nTWvLMo=NgMf_X4bkcNg8rR2E8K6UTv6B++4gxsg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 1 Apr 2025 13:27:16 -0700
X-Gm-Features: AQ5f1Jp7JH3L40dC8Kwq6zvJC0MIexyZoA2aszo7Mf_hOWd3LMn6u4-71ispyNE
Message-ID: <CAADnVQKmT4cGj1S2e_fj9dngcz_=3QDL4=gNH66WqSXc5citaw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/3] bpf: Add kfuncs for read-only string operations
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Viktor Malik <vmalik@redhat.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 1, 2025 at 1:21=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> > >
> > >> +       }
> > >> +out:
> > >> +       pagefault_enable();
> > >
> > > how about we
> > >
> > > DEFINE_LOCK_GUARD_0(pagefault, pagefault_disable(), pagefault_enable(=
))
> > >
> > > like we do for preempt_{disable,enable}() and simplify all the
> > > implementations significantly?
> >
> > That's neat, I didn't know it. It will a bit more tricky to use here as
> > __get_kernel_nofault still requires a label but we should at least be
> > able to get rid of pagefault_{disable,enable}() in each function.
>
> yep, we'll have:
>
> err_out:
>     return -EFAULT;
>
> But the rest will be a clean loop and no pagefault_disable() clean
> ups, distracting from the main logic

Just a word of caution...
Please double check that both gcc and clang generate
proper cleanup code when asm goto is used.

