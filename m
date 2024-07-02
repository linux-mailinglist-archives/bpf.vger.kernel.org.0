Return-Path: <bpf+bounces-33589-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FE491EC09
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 02:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 623FF2832BC
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 00:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B098830;
	Tue,  2 Jul 2024 00:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q15fsACN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5AE6FCB;
	Tue,  2 Jul 2024 00:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719881740; cv=none; b=g1gqMbkBvCjrTIpTfif6yqGGGgU4Nsr7xWFq3yquFKY+LySfdUgH0sp66vUDIo3rJmXNgqUrKEZG4GK0NuH3rGoKjePMbPJVX5pFVRgMk8sbwSXePBbZBll0KD/pr+TIzCXs6C3jcYdGPSs9RO93vDn7KDP9VWV4AcP5iBmkjCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719881740; c=relaxed/simple;
	bh=luFvNI/62MD7Wrum5uuGKm8RE6dct/VhNWLv6+cEcrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TjcL8ZyYrqfeuT4OV+lVqTC5jhTSkvHbU+3stfhVzunQuIV7pwPXrN/+yS7/FtAFW7h/cMqOqj5tFEE9r39RZdn2YgeyGtlCVX5NgQnzONCV7goHwIt9jpnjUvIRci3CuLyux4wLwJv5VHDmVqRVGbZSU9DUPRAeoGXGd/Xq9H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q15fsACN; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-25c9ef2701fso1711347fac.1;
        Mon, 01 Jul 2024 17:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719881738; x=1720486538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=luFvNI/62MD7Wrum5uuGKm8RE6dct/VhNWLv6+cEcrA=;
        b=Q15fsACNE6BO3UcWJt8O0vvIeMb3n2dNYm6tAnjVF7sKTfP+WbL0qZyjOlWj49tD9C
         5VbvPIBidcQcd/uD2doYDkQtWJu6JPMInhgk2rhK9QYVmQy6Ae6Uer/6itKNnXyo8pXY
         yX1e0Z92R+hcLuWGG6JS/xHmpJyCXFL+28uv42QZnvPU6PQeYMaYgQ8Y9jxLXffIhXZ7
         +H4rWRm071nRe2RPvjG1C+OzzoWk/Y6QTaV+oOrN1r5awYhkfzAdosd1P1jKem9cFrsP
         S+6OhSm+qKW0RfpruRPuiWwqpO8jKRcANt8QTZ8b41wttAiiVt4+EkJNno4g1Yitvpl8
         6SxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719881738; x=1720486538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=luFvNI/62MD7Wrum5uuGKm8RE6dct/VhNWLv6+cEcrA=;
        b=wnacofJJ2qt4ucp12DJIAQRicMJEB5Wsgf6Gz/vGmkjGMX/pQEsxbKpPQHC1n3ght/
         Fk7d3OZZo4EetvbqDFu1rka5hsnShEqUzXtDLf6ycTc5dEBamBg8jGPE4P/mjlNVoJH/
         joiRxWcHuOKE7U8J1eAhh1KFdrOlqSe6Ii55isDC9qavz0DlTxVBNcBMq+bd9OHD+K8d
         7Io7csTLGdtgBqKTcOaZiulFvBRTPRh8tK+xkhrKQANNQn71t4cG6hKubjsWTqs5uy55
         MmD+FB3IXXLarvVghagM++BYsWLgjhzTpbTWaBIlu3yihtmfxxtki+8pgGl9Vm5969zn
         TCBg==
X-Forwarded-Encrypted: i=1; AJvYcCUZKapw62PeRX/ctgMAf5CL36Szb1zE24vKhcDOnRtC0nQ7k+IuzieR3WOYvlZiLIwK6yH/pbbwvgLJL2D0IjOMA7Jc7tuYTuGnJhob+krMh7vIJZwCkeH6MHWBmkIhltAx
X-Gm-Message-State: AOJu0Yy4sgDMg255zpE+R3kGxAdwsdQiKg1zqvP1XARGgsAnyfHeeYOT
	He66eLjP+LW03CgQ3YWbaqpxEWh6Y3xdk0zIkWXkCHv/aYZqkrml08t7Icb9i4DuPYnBrwkvtJN
	UZKG6dbHIK6uTykYwVF4RhIcqnyrrNQ==
X-Google-Smtp-Source: AGHT+IHir9A497fIZzOSTLtyy0g2cgqLfwya8cRnsR/767PS+412njZLgGfu5s2kpLh5y8HWb6O4bgkoTuUHtxEV60s=
X-Received: by 2002:a05:6870:aa09:b0:254:9392:e5a2 with SMTP id
 586e51a60fabf-25db356f6e3mr4945465fac.25.1719881737727; Mon, 01 Jul 2024
 17:55:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zn4BupVa65CVayqQ@slm.duckdns.org> <Zn4Cw4FDTmvXnhaf@slm.duckdns.org>
 <CAADnVQJym9sDF1xo1hw3NCn9XVPJzC1RfqtS4m2yY+YMOZEJYA@mail.gmail.com>
 <Zn8xzgG4f8vByVL3@slm.duckdns.org> <CAEf4BzbVorxvJdGA0eLviRhboaisxe4Ng=VErZVh3MG9YrRaKw@mail.gmail.com>
 <Zn9BZB8tE-CySXnn@slm.duckdns.org> <Zn9De_70fy-DVA-_@slm.duckdns.org>
 <CAEf4BzY9-CW+SamvwkrHBH1RgB3bxybRmnrK_E0p_Np=V5MsMg@mail.gmail.com> <Zn9k-j06TM-JiIse@slm.duckdns.org>
In-Reply-To: <Zn9k-j06TM-JiIse@slm.duckdns.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 1 Jul 2024 17:55:25 -0700
Message-ID: <CAEf4BzbJPxDqunzmkxjTZV2ndU9qRg48N2c7xqdF64Jh3R1rUw@mail.gmail.com>
Subject: Re: [PATCH sched_ext/for-6.11 2/2] sched_ext: Implement scx_bpf_consume_task()
To: Tejun Heo <tj@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	David Vernet <void@manifault.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 6:35=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello, Andrii.
>
> On Fri, Jun 28, 2024 at 04:56:55PM -0700, Andrii Nakryiko wrote:
> > > Just a bit of addition and a question. scx_bpf_consume_task() is mayb=
e named
> > > too generically and I have a hard time imagining it being useful outs=
ide
> > > iteration loop. So, it does work out kinda neatly if we can tie the w=
hole
> > > thing (DSQ lookup, barrier seq) to the iterator.
> > >
> > > The reason why this becomes nasty is because I can't pass the pointer=
 to the
> > > iterator to a kfunc, so maybe allowing that can be a solution here to=
o?
> >
> > Sure, if that's the best way to go about this.
>
> If we decide to go this way, how difficult would it be to change the
> verifier to allow this?

Shouldn't be too difficult, but we'll know for sure when we start
implementing this, of course.

>
> BTW, as none of the practical schedulers use consume_task() yet, I can sk=
ip
> this for now. I'll post an updated patches for the iterator itself. We ca=
n
> decide what to do with consume_task() later.
>

Sounds good.

> Thanks.
>
> --
> tejun

