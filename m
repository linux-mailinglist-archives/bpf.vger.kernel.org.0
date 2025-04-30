Return-Path: <bpf+bounces-57065-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB55AA515A
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 18:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B2414E3003
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 16:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739D125332B;
	Wed, 30 Apr 2025 16:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gq1v21Ii"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1971CDFCE
	for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 16:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746029808; cv=none; b=RSrIrcTy6Nf0/2dt8xgsolXXA6yeZWcta1IaYmY3pjNRO9g4CgMZj1r0ak6s6s4rRivEiAvhkZxiQgHl0iFBO1znXgzA059spcNKsh4wGaTHxOBShMPxVKZh+DM9y1CVZyflrtoPmGMk2hI5UGL+prbP3wNH4m8wYHhL4d4s4Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746029808; c=relaxed/simple;
	bh=+KZ9L4C8fdupkJuWJt9x1SC22tDZgcdjSY+Ht9ebt1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=emAEgV6vxGntQQ1X62mfloRzeg9sxs6nNk1jwZos1UyQDot1BH3iY8GFxvbkALG/6MnHVxiJOaDlmuniy39EXAAb/YcP1qp4ALqK9oYCjLX2c1ot6E0tzhPjB+ZEvQh9Z8H5838nXMO8d85+rSX7PUhU2nPd5RrYbRS7JVxYFrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gq1v21Ii; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-39ac9aea656so8563977f8f.3
        for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 09:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746029804; x=1746634604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3590ZTEs1KQBIn7/bUpltm0Rsj0OLuG8mGosQsAgt0M=;
        b=gq1v21IiV4Jxe0+yQvh6jwEH2AbWno3E5PVl3I0L+3KDTQQNg94hHXrnC9ksQpL+HI
         B04CXMj0B+lO9PyVjvRbLfKrTvdGX1wrx6PIpwkcLgnw/ZmJD4ECXVbDkPQFAwIHLfFO
         K4sK0BwZfqBpSaLvO5zMtlqBAD33Fj7nABM5XUoth+4cj9Ax47qDg5SC9SYALRJChd6+
         HiCvz0wsdY8TRmqLpDz6bhFiW1UzIBpFwFYiG+Six+vYw3tAt5vCaDXY2fkjKFOt/gx7
         lKAEENcv+Kdy/Pybmj+tzL9KVTZGJCTUuMkicWstQSl1R4YpJINPZgM6fexOv6a3x9Jo
         87qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746029804; x=1746634604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3590ZTEs1KQBIn7/bUpltm0Rsj0OLuG8mGosQsAgt0M=;
        b=M3cJXWTr3NuW035joeBNOROE09huqOi3FWoQNY2GdiiC2iVvau1u0+Lt7o1rDj3Aun
         TuyHcSFEzoR+EuCQipPmS0735SLtoLy0g+Rhjz0kvJow9enygeze55fr+X+j2xAeFAq0
         TmFjszb5VGq1yNmEOCmYjKwn4updq10Y4Tb0AQY2QQu/491tGxgmgxuCwjBd5nQIKvKg
         TfrP2NUsuwxwiuj56dg+Fh4s1m5MepcZyYXPNrlL078D4Rqbo7hIteK0eMx+1QIddPLU
         R9ZF50NXVmnLFifoTOdR2yEG5gjFyd3ktQzhcaaAUPaGIRrwsJI1HEehK/EGjz99hnvQ
         IlvA==
X-Gm-Message-State: AOJu0Yx7Ere1Auo2BKcSy4oTb/hXOCbJcOV/Ae27P7oWztGKjmN/Un7W
	rBaC8k5dtVDy4HDB1P6Nqd5N/zwz5U99BSpw5B32jokxYCyqL92GnMBhJ2wgkA+pafXdnJjO6cy
	ftW6Dc2v216hzYqTDXsoBE10VqV4=
X-Gm-Gg: ASbGncvNDGWZBinT/Oj9gwl2XVAoCHeR1fbH9JfzOYqHAYtYe1mnruCwlq1dL3DqR2H
	3N98hIKGLhh3ys122CW7hgMvGjQSIYnM90W2PDx2B+s/4QarRPfZEgTVstvaev8by/wq7RyQlzs
	qTnxDK/Yk31yqKXzx2NQLOiaXjsvR6NPzXW3nlEw==
X-Google-Smtp-Source: AGHT+IFa3hD6lwquR+V15y8m8bVYpmDiRkw0CRecmk957X0nkqCeaL9RjOVg6KsxGxdhNb7J8rf28XKNzRHVMnQoRmM=
X-Received: by 2002:a05:6000:184b:b0:39c:2688:612b with SMTP id
 ffacd0b85a97d-3a08f75379fmr3711555f8f.7.1746029804276; Wed, 30 Apr 2025
 09:16:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429041214.13291-1-piliu@redhat.com> <20250429041214.13291-5-piliu@redhat.com>
 <CAADnVQKTSubuisSBap_J=tgO15fCdtwF-NDY_1HLP_m6o28mhw@mail.gmail.com> <CAF+s44QM55AtGyquKvj0XAzZAjOii7VJYWsGD50iK3+r6GZSmg@mail.gmail.com>
In-Reply-To: <CAF+s44QM55AtGyquKvj0XAzZAjOii7VJYWsGD50iK3+r6GZSmg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 30 Apr 2025 09:16:32 -0700
X-Gm-Features: ATxdqUGB48vHpPeEdU_NX4frkjCUrtyGmy_6ByixlEaL_MFEjQG9XKezXmBp5zs
Message-ID: <CAADnVQKKr7C+eRin=efg5umLumghGfYJst2MwDwpB5bEtt4rSA@mail.gmail.com>
Subject: Re: [RFCv2 4/7] bpf/kexec: Introduce three bpf kfunc for kexec
To: Pingfan Liu <piliu@redhat.com>
Cc: bpf <bpf@vger.kernel.org>, kexec@lists.infradead.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jeremy Linton <jeremy.linton@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Simon Horman <horms@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Philipp Rudo <prudo@redhat.com>, Viktor Malik <vmalik@redhat.com>, 
	Jan Hendrik Farr <kernel@jfarr.cc>, Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, 
	Eric Biederman <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 3:47=E2=80=AFAM Pingfan Liu <piliu@redhat.com> wrot=
e:
>
> On Wed, Apr 30, 2025 at 8:04=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Apr 28, 2025 at 9:13=E2=80=AFPM Pingfan Liu <piliu@redhat.com> =
wrote:
> >  +__bpf_kfunc struct mem_range_result *bpf_kexec_decompress(char
> > *image_gz_payload, int image_gz_sz,
> > > +                       unsigned int expected_decompressed_sz)
> > > +{
> > > +       decompress_fn decompressor;
> > > +       //todo, use flush to cap the memory size used by decompressio=
n
> > > +       long (*flush)(void*, unsigned long) =3D NULL;
> > > +       struct mem_range_result *range;
> > > +       const char *name;
> > > +       void *output_buf;
> > > +       char *input_buf;
> > > +       int ret;
> > > +
> > > +       range =3D kmalloc(sizeof(struct mem_range_result), GFP_KERNEL=
);
> > > +       if (!range) {
> > > +               pr_err("fail to allocate mem_range_result\n");
> > > +               return NULL;
> > > +       }
> > > +       refcount_set(&range->usage, 1);
> > > +
> > > +       input_buf =3D vmalloc(image_gz_sz);
> > > +       if (!input_buf) {
> > > +               pr_err("fail to allocate input buffer\n");
> > > +               kfree(range);
> > > +               return NULL;
> > > +       }
> > > +
> > > +       ret =3D copy_from_kernel_nofault(input_buf, image_gz_payload,=
 image_gz_sz);
> > > +       if (ret < 0) {
> > > +               pr_err("Error when copying from 0x%px, size:0x%x\n",
> > > +                               image_gz_payload, image_gz_sz);
> > > +               kfree(range);
> > > +               vfree(input_buf);
> > > +               return NULL;
> > > +       }
> > > +
> > > +       output_buf =3D vmalloc(expected_decompressed_sz);
> > > +       if (!output_buf) {
> > > +               pr_err("fail to allocate output buffer\n");
> > > +               kfree(range);
> > > +               vfree(input_buf);
> > > +               return NULL;
> > > +       }
> > > +
> > > +       decompressor =3D decompress_method(input_buf, image_gz_sz, &n=
ame);
> > > +       if (!decompressor) {
> > > +               pr_err("Can not find decompress method\n");
> > > +               kfree(range);
> > > +               vfree(input_buf);
> > > +               vfree(output_buf);
> > > +               return NULL;
> > > +       }
> > > +       //to do, use flush
> > > +       ret =3D decompressor(image_gz_payload, image_gz_sz, NULL, NUL=
L,
> > > +                               output_buf, NULL, NULL);
> > > +
> > > +       /* Update the range map */
> > > +       if (ret =3D=3D 0) {
> > > +               range->buf =3D output_buf;
> > > +               range->size =3D expected_decompressed_sz;
> > > +               range->status =3D 0;
> > > +       } else {
> > > +               pr_err("Decompress error\n");
> > > +               vfree(output_buf);
> > > +               kfree(range);
> > > +               return NULL;
> > > +       }
> > > +       pr_info("%s, return range 0x%lx\n", __func__, range);
> > > +       return range;
> > > +}
> >
> > These kfuncs look like generic decompress routines.
> > They're not related to kexec and probably should be in kernel/bpf/helpe=
rs.c
> > or kernel/bpf/compression.c instead of kernel/kexec_pe_image.c.
> >
>
> Thanks for your suggestion. I originally considered using these kfuncs
> only in kexec context (Later, introducing a dedicated BPF_PROG_TYPE
> for kexec).

We do not add new prog types anymore.
They're frozen just like the list of helpers.

> They are placed under a lock so that a malice attack can
> not exhaust the memory through repeatedly calling to the decompress
> kfunc.

attack? This is all root only anyway and all memory is counted
towards memcg.
Make sure to use GFP_KERNEL_ACCOUNT and something similar
to bpf_map_get_memcg.

> To generalize these kfunc, I think I can add some boundary control of
> the memory usage to prevent such attacks.

Don't reinvent the wheel. memcg is the mechanism.

> > They also must be KF_SLEEPABLE.
> > Please test your patches with all kernel debugs enabled.
> > Otherwise you would have seen all these "sleeping while atomic"
> > issues yourself.
> >
>
> See, I will have all these debug options for the V3 test.
>
> Appreciate your insight.
>
> Regards,
>
> Pingfan
>

