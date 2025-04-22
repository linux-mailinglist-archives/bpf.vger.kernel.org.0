Return-Path: <bpf+bounces-56445-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 462AFA97646
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 21:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CB153BB433
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 19:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FFB298CD4;
	Tue, 22 Apr 2025 19:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4B1Eex4/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30D52989A8
	for <bpf@vger.kernel.org>; Tue, 22 Apr 2025 19:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745351854; cv=none; b=o/WD+90g3Vdl7oIHZ+Zb1s7Ae7Jf19hDc+WuW5FT7OuvisccUoPiaCbYvfLuK9UsAdCaLQ2AyLxWXi/db7cVXI33Y600bxhl7/V22aSpsFcdVPR5/fuS87SppT5lFHqGhWzQhy4N6DcuSyuBLUgycBbttPNwLnDw1My4SGGU1Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745351854; c=relaxed/simple;
	bh=CTVA2mrAn/AMpQDf5O262gMMZUU1TRh2/DuID8H/EP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GKE5ptcRgVwS5DqIL8RT7ZnFqkT1X0TjkK97Pv/VQtqN6+FNwqxiVeUnjkS/sERzqCMpL9vmEHJXf/Hkhs43sdXKkiMEu9C2EzMxjOyB/1c5bZw5Gp9W0+atsPrC5YWEq15XLZ/l3gcZStbSL+25Ao21PwdmndKfzqOqam335W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4B1Eex4/; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cf3192d8bso1495e9.1
        for <bpf@vger.kernel.org>; Tue, 22 Apr 2025 12:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745351851; x=1745956651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+8WoEV+fhr75HFqg9zZSA4L2nRl0GyEtZHiF2PswuY=;
        b=4B1Eex4/sKIjSHTFcN7ivYU9jkqma/S+wCqJszDrDsbomeZ7jSa7sHhmoTHczx93pj
         qlDzKqMtIRnu2/0T+d5oKrTUb9Tbf6xin53LT0l9bZCZZHrPcxMXnuDEj+6Nm4nu+1jE
         uHAiL7TOfm7ruXz3kDJgwtJgtxvFaLoAU/gkx6v0jTCUEaQKQpNi58BYlZ6E0xQNUe0Q
         fYw4CuYzu7fHI5cqImmY31nJDE0vAkVOdGBCop0FVeaQGGgIe3kFgTf+QOszgHcoR69D
         csk5aJ37+Lm+VBRBrBbAnlMwkE4YbkO/YKyJOw0qY19xvRArLkDXFD4RrNcNsGFlWPLT
         2yrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745351851; x=1745956651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o+8WoEV+fhr75HFqg9zZSA4L2nRl0GyEtZHiF2PswuY=;
        b=W4DyrzLbgWW2U540hEPBcl9R5G1jAzwuL6T4UmsyVY7OLrXFJMJyuWDpUxBmysVQPu
         QfHyL7QlxbJFl6MkmfnNaQQKaTze2+wBBOTMS0eAplOmNhqm9c++OnQvUK86XYqDp/j5
         OLIDOTLbLU6IRuHJxGGScx5wXhSu0OkWRfHQLN7mk4u8WMYhKuMEkAHlvtqEjKdyJ1T2
         9fHdpy9sd4D44JXBhfEvlNv2mSYlfZu4894xeDZo6aHi5eASwDfAO9Y6pbfh50T8035O
         I8AeSdUdCL5x3h/ZcFlwPAWMKRT8XTHYEBtIgu1RFzArOQMJu7o989wDOK5XJwFUpthQ
         fXtA==
X-Forwarded-Encrypted: i=1; AJvYcCV7JYc2wm8yichCT4zx5Z3HAj8ZPBJNdOxkOylzBkoZqZDgw0wKRj54puKolyLB4VNgTs8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNNevRbjLLg9AQDBa++ndhExKkPYqa0h7gBihK7sj/FnAFpMRS
	MdV96NN8AvBSmisT0sUAIVn5k7bNcEXWmrRkX+xFofvaCd4gQ2lk2owcZ90vJ8PUkfOVkvKS+tt
	gLsybzql4JGChQAn2nlyTajprHlWwX0I8qhep
X-Gm-Gg: ASbGncuyIbhsXxJVHrHgj2ba02WOzctQneLoNxsq4oVjK2crlOAVco6wLe9TW5N5E1C
	eueGwe22/fHMSoqkDwtIsT1WQ5a2ludURoUt3uGQuVM8jTYdbLzExL9JqXLezj0uKdUWM/CIH7e
	Knb3A3Q7ETX59Rw0Izg/NoGk+Drma5U0X6BFm42IQOvlQEPq9XTas1Rv6pbU/o9Ns=
X-Google-Smtp-Source: AGHT+IHUmXBjG9n60eY/loYKceaeQypFwnBTAsAPzYJ5PJ5nFZ7ErzebtVx7FMQxwUfLtBAv12j9WXMAZTzYMIU/Svk=
X-Received: by 2002:a05:600c:259:b0:439:8d84:32ff with SMTP id
 5b1f17b1804b1-44091b78f2dmr168325e9.3.1745351850985; Tue, 22 Apr 2025
 12:57:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414225227.3642618-1-tjmercier@google.com>
 <20250414225227.3642618-3-tjmercier@google.com> <CAPhsuW54g5YCmLVX=cc3m2nfQTZrMH+6ZMBgouEMMfqcccOtww@mail.gmail.com>
 <CABdmKX1OqLLsY5+LSMU-c=DDUxTFaivNcyXG3ntD8D0ty1Pwig@mail.gmail.com> <CAADnVQ+0PXgm_VuSJDKwr9iomxFLuG-=Chi2Ya3k0YPnKaex_w@mail.gmail.com>
In-Reply-To: <CAADnVQ+0PXgm_VuSJDKwr9iomxFLuG-=Chi2Ya3k0YPnKaex_w@mail.gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Tue, 22 Apr 2025 12:57:18 -0700
X-Gm-Features: ATxdqUHMQq2PHoV14JDZonbBE5auIlNOjBV31C8667rOy5nLy9RJngJSN6-OcnY
Message-ID: <CABdmKX1aMuyPTNXD72wXyXAfOi6f58DfcaBDh6uDo0EQ7pKChw@mail.gmail.com>
Subject: Re: [PATCH 2/4] bpf: Add dmabuf iterator
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Song Liu <song@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Shuah Khan <skhan@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, android-mm@google.com, simona@ffwll.ch, 
	Jonathan Corbet <corbet@lwn.net>, Eduard <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 4:39=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Apr 21, 2025 at 1:40=E2=80=AFPM T.J. Mercier <tjmercier@google.co=
m> wrote:
> >
> > > > new file mode 100644
> > > > index 000000000000..b4b8be1d6aa4
> > > > --- /dev/null
> > > > +++ b/kernel/bpf/dmabuf_iter.c
> > >
> > > Maybe we should add this file to drivers/dma-buf. I would like to
> > > hear other folks thoughts on this.
> >
> > This is fine with me, and would save us the extra
> > CONFIG_DMA_SHARED_BUFFER check that's currently needed in
> > kernel/bpf/Makefile but would require checking CONFIG_BPF instead.
> > Sumit / Christian any objections to moving the dmabuf bpf iterator
> > implementation into drivers/dma-buf?
>
> The driver directory would need to 'depends on BPF_SYSCALL'.
> Are you sure you want this?
> imo kernel/bpf/ is fine for this.

I don't have a strong preference so either way is fine with me. The
main difference I see is maintainership.

> You also probably want
> .feature                =3D BPF_ITER_RESCHED
> in bpf_dmabuf_reg_info.

Thank you, this looks like a good idea.

> Also have you considered open coded iterator for dmabufs?
> Would it help with the interface to user space?

I read through the open coded iterator patches, and it looks like they
would be slightly more efficient by avoiding seq_file overhead. As far
as the interface to userspace, for the purpose of replacing what's
currently exposed by CONFIG_DMABUF_SYSFS_STATS I don't think there is
a difference. However it looks like if I were to try to replace all of
our userspace analysis of dmabufs with a single bpf program then an
open coded iterator would make that much easier. I had not considered
attempting that.

One problem I see with open coded iterators is that support is much
more recent (2023 vs 2020). We support longterm stable kernels (back
to 5.4 currently but probably 5.10 by the time this would be used), so
it seems like it would be harder to backport the kernel support for an
open-coded iterator that far since it only goes back as far as 6.6
now. Actually it doesn't look like it is possible while also
maintaining the stable ABI we provide to device vendors. Which means
we couldn't get rid of the dmabuf sysfs stats userspace dependency
until 6.1 EOL in Dec. 2027. :\ So I'm in favor of a traditional bpf
iterator here for now.

