Return-Path: <bpf+bounces-58251-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 896B3AB7854
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 23:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAE663B7169
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 21:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1034C223DE2;
	Wed, 14 May 2025 21:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0MEKTI9J"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB8022371B
	for <bpf@vger.kernel.org>; Wed, 14 May 2025 21:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747259952; cv=none; b=J5YAPW6tDtMTkLzLDPwWJ9zN54eJ3RqV1pnDVSIFPd0HvrmCaVMnCwYjTfQc+Dy7EgY1cPEa9CmJ21wfiypGFQ/X8HzuzOc72Qazr0xU3Qi/PsUWz8oCvdu+kgzwYkI9he19OrwUbM3s60VuASIiX0O4aOCkDzw+VwMbZ8CrbEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747259952; c=relaxed/simple;
	bh=TWcw01T/w6LATvvOxnm+hi0n7GlTE/e5VE0POQyIkdE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XH3IkpQi0uvdViQUdzSVJlhO9PFhiJW7xfDKbkxfyPGQSu8QQADDHO7ez60sYCHq3SWtmfPoFoZuHbaeKHnA5cRGToXs8yWzea6qmanHfx1fJWnHnvch4nupehp+2irbgG1ghnajBUPy4EFXCgYah1Sd7lZO1/lusjf4mxXNRtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0MEKTI9J; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43d5f10e1aaso22205e9.0
        for <bpf@vger.kernel.org>; Wed, 14 May 2025 14:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747259949; x=1747864749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N6BjLggY6RYhBduHWEU2r/0qSGTtOcmp2Rv7SfgPX2c=;
        b=0MEKTI9JkWbPmqdbIMQad8MqxocU6iEyWj+GDKhmo9EITGFBnYkfatuJJscQvu32it
         Rz7W4+RpO52lhuN3KPVYkfXjxznMMvokL55fIHChPtV+XsWCTc+AbFOBBiMp1U9bovFU
         6BiTYB3oQa7ZJcO2h5cVNP8iuqRcAod9dp7zhQyso4t4hiFgjo+cJDVwNlsfXy51YuBk
         MKAE5WpdoBqv+BvDVpSvDoyC8eOrNiw4XIj6nxWWOQArkXjKtVpW172OWFyrs8EqFZ0H
         bnfJOjI/QaLVLw3PCzY2gi9nVFbR/5GkURkTqj8HWUX+WRecEbTcG0h5xyySbJCrW8ya
         bTrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747259949; x=1747864749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N6BjLggY6RYhBduHWEU2r/0qSGTtOcmp2Rv7SfgPX2c=;
        b=nfpD+JoLv1fm0VWU4OMGbWJ1cl/pbNkUXimAS21rxb/ZQN1vscQjqROy86mPZJa4tS
         yinL1XRI+CRBRCrKSLLlM2ezSqW02QOcLMUXCpdNy2Kj+sOMnN6tSYVKMDn6i2JiK3Yx
         EeZFTborGivCOHX00ykN2XGNlKt0xfKYJLDdPp2p0iNB3olmnqBm6hCBX6UVSpLIyUaa
         wlqhHcVQoXw7ZUWlCBDyXV4uDfFIFnY1tY5/yGM+r9EnKgBm5tZBmb/ZXxZmZnNWb1pK
         mUKhPS6ayK6OUjgVpheumb3snW3H29dnZdoRMs0I3sXA+T9hWMqcSFkCUjyRyEEY5Dfq
         LxRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVifGEQIwK1Rc8zjPthvMPDbAK/kD9g+6ctNrDER2+6P+P3M5V7Kc2lrUT0p4cejwxjHT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFb2fKTadpggTGgd0s41TG3tyt8Mh3rX0amZ93YTfA4HEzZ87N
	BQ5VcmX25aB7w6gBUrHR+2bx3H51el6QUHFEiVnQwLdoqs0rmPzXdBC1wVDgEiOoENY3W2N3GnS
	tT8xwzQxl3drfgaucgj4Y07QqZQdmSP9aWPiJur0T
X-Gm-Gg: ASbGncv6rwdECgiIiV8V+t8WSGeC+vS2KLe+jCN+km2pPju59KrZHiVrGp88PCwdcTi
	hs18+ZEyfX7ntgOQ7nGndqibz3FY742Jr29y6efxikblspV8Cu6El09JpxBbcrLiivQu13PrCOu
	7iQE8noe+LrRMzrGGZv13ulgjyUzFg+ziY3MbOurUdvzrPPoumASaP96oHmHry6vw=
X-Google-Smtp-Source: AGHT+IF9CkMy8uQHae8tBwjfZQnl2xTDU2FaaHSwjDP6uOoyICX4dbqTYj1/pDGgkaVhdrmo/aPKYQuBWpB4B9m3R6w=
X-Received: by 2002:a05:600c:6095:b0:441:aaa8:312e with SMTP id
 5b1f17b1804b1-442f8b45ad1mr472635e9.6.1747259949004; Wed, 14 May 2025
 14:59:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250513163601.812317-1-tjmercier@google.com> <20250513163601.812317-5-tjmercier@google.com>
 <CAPhsuW4uKxFP=i2KgaKPvezD5sBcVheQRBF1fY5DyYafin_yFQ@mail.gmail.com>
In-Reply-To: <CAPhsuW4uKxFP=i2KgaKPvezD5sBcVheQRBF1fY5DyYafin_yFQ@mail.gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 14 May 2025 14:58:57 -0700
X-Gm-Features: AX0GCFvBkYq3GWDHm1043uOPWEQY2osVY6pw6Ua9BcA8wU905Xni8mQWiWzsG7M
Message-ID: <CABdmKX3Q5+bfbBBndSS6mxUhapFGY5zLr9CV-p0+CfNPOzuvGA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 4/5] selftests/bpf: Add test for dmabuf_iter
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

On Wed, May 14, 2025 at 1:53=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> On Tue, May 13, 2025 at 9:36=E2=80=AFAM T.J. Mercier <tjmercier@google.co=
m> wrote:
> >
> > This test creates a udmabuf, and a dmabuf from the system dmabuf heap,
> > and uses a BPF program that prints dmabuf metadata with the new
> > dmabuf_iter to verify they can be found.
> >
> > Signed-off-by: T.J. Mercier <tjmercier@google.com>
> > Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> Acked-by: Song Liu <song@kernel.org>

Thanks.

>
> With one more comment below.
>
> [...]
>
> > diff --git a/tools/testing/selftests/bpf/progs/dmabuf_iter.c b/tools/te=
sting/selftests/bpf/progs/dmabuf_iter.c
> > new file mode 100644
> > index 000000000000..2a1b5397196d
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/dmabuf_iter.c
> > @@ -0,0 +1,53 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2025 Google LLC */
> > +#include <vmlinux.h>
> > +#include <bpf/bpf_core_read.h>
> > +#include <bpf/bpf_helpers.h>
> > +
> > +/* From uapi/linux/dma-buf.h */
> > +#define DMA_BUF_NAME_LEN 32
> > +
> > +char _license[] SEC("license") =3D "GPL";
> > +
> > +/*
> > + * Fields output by this iterator are delimited by newlines. Convert a=
ny
> > + * newlines in user-provided printed strings to spaces.
> > + */
> > +static void sanitize_string(char *src, size_t size)
> > +{
> > +       for (char *c =3D src; *c && (size_t)(c - src) < size; ++c)
>
> We should do the size check first, right? IOW:
>
> for (char *c =3D src; (size_t)(c - src) < size && *c; ++c)

Yeah if you call the function with size =3D 0, which is kinda
questionable and not possible with the non-zero array size that is
tied to immutable UAPI. Let's change it like you suggest.


>
> > +               if (*c =3D=3D '\n')
> > +                       *c =3D ' ';
> > +}
> > +
> [...]

