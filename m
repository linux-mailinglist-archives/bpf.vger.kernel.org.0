Return-Path: <bpf+bounces-274-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E95AA6FD6EF
	for <lists+bpf@lfdr.de>; Wed, 10 May 2023 08:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D04E1C20CDB
	for <lists+bpf@lfdr.de>; Wed, 10 May 2023 06:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9805697;
	Wed, 10 May 2023 06:24:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E5719918
	for <bpf@vger.kernel.org>; Wed, 10 May 2023 06:24:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A688C433A1
	for <bpf@vger.kernel.org>; Wed, 10 May 2023 06:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683699841;
	bh=6iaxX/Bb49rjz+4CxLbEJnTjiE7mFX799Gy6SgBYV6o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fWxbQ7fOCCN7UoBeIVJ5vn5R/XtlLg+DbOrK7gU+oZk+9O6wEmBkaKHdHBzbian/k
	 i8iU6WP8fUK5r3AopK60A1qUvkdK1A7M/UHdTMl4QWhm3W4gjYvWIgjHXjgQxXnDk+
	 8NTkQ9sfL/UU+IU63WUxVq7vxRBgoEfalc40OukA83FMM8w3Dep9jVC2tvy2o7cRF1
	 wfOqzB3/1ZO09cmANTSGwagVRdi2YOmRxXy2h+rDOaIfqHCFVfJfanBeQmyM7vYVpS
	 6w0Ww94kPtZ0iootJRGyZLsOYDE8V7ofJq867+gFDK4hFsqMLcEr6ztGaHOALJy4de
	 AGEh8bI1QnF7g==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ac88d9edf3so63027991fa.0
        for <bpf@vger.kernel.org>; Tue, 09 May 2023 23:24:00 -0700 (PDT)
X-Gm-Message-State: AC+VfDwN0ooWQuUNyj1n+SiTYo6QQXvNUEB/KWrOabm/UB+POFbGUnLQ
	FOflDGXvVOtD3YYuwVGpGQHnE+mpjWBWesxw0rQ=
X-Google-Smtp-Source: ACHHUZ57bX0tXH5Sro3Yz8Qu7puhWJi4EbSTPI0KCNAprbnVEoljFTOqzWNY6AOK1Qvt9j799GCIjJOSPp6ybJoFHi0=
X-Received: by 2002:a2e:9816:0:b0:2ac:80cd:6c0d with SMTP id
 a22-20020a2e9816000000b002ac80cd6c0dmr1617319ljj.19.1683699839000; Tue, 09
 May 2023 23:23:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230509151511.3937-1-laoar.shao@gmail.com> <20230509151511.3937-2-laoar.shao@gmail.com>
 <CAPhsuW6oAdLo1ErAQaaJSMhoyPWreuHZ_FZzftR=U0ptfZ8SdA@mail.gmail.com> <CALOAHbCkBCdApV+itpoNJGnbhZM=3QqZoND5i3ur4CimKf+JTA@mail.gmail.com>
In-Reply-To: <CALOAHbCkBCdApV+itpoNJGnbhZM=3QqZoND5i3ur4CimKf+JTA@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Tue, 9 May 2023 23:23:46 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5CbV_jcQv4FOB429oOY+3=KansOkOVqrfXhqeb_hMpnw@mail.gmail.com>
Message-ID: <CAPhsuW5CbV_jcQv4FOB429oOY+3=KansOkOVqrfXhqeb_hMpnw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Fix memleak due to fentry attach failure
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com, 
	songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 9, 2023 at 7:39=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> w=
rote:
>
> On Wed, May 10, 2023 at 1:41=E2=80=AFAM Song Liu <song@kernel.org> wrote:
[...]
> > > +static void bpf_tramp_image_free(struct bpf_tramp_image *im)
> > > +{
> > > +       bpf_image_ksym_del(&im->ksym);
> > > +       bpf_jit_free_exec(im->image);
> > > +       bpf_jit_uncharge_modmem(PAGE_SIZE);
> > > +       percpu_ref_exit(&im->pcref);
> > > +       kfree(im);
> > > +}
> >
> > Can we share some of this function with __bpf_tramp_image_put_deferred?
> >
>
> It seems we can introduce a generic helper as follows,
>   static void __bpf_tramp_image_free(struct bpf_tramp_image *im)
>   {
>       bpf_image_ksym_del(&im->ksym);
>       bpf_jit_free_exec(im->image);
>       bpf_jit_uncharge_modmem(PAGE_SIZE);
>       percpu_ref_exit(&im->pcref);
>   }
>
> And then use it in both bpf_tramp_image_free() and
> __bpf_tramp_image_put_deferred().
> WDYT?

How about we also use kfree_rcu() in bpf_tramp_image_free()?

Thanks,
Song

