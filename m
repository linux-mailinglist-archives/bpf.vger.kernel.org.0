Return-Path: <bpf+bounces-14042-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2467DFD5E
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 00:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AD79B21383
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 23:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4546224FC;
	Thu,  2 Nov 2023 23:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZKM2mXvl"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AE1224C3
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 23:54:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95376C433C7
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 23:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698969249;
	bh=IeBLuUIlZNqMh3woqCgZmDkuQOwUno9t0oVB/JBLdMo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZKM2mXvlxS0hWXCMUizoFcVlTn/2FN0/KlidTOoM2beKh20uQ9HFx1wBPEEFReVU0
	 RlR26jHzvnL6KfPAZskuX/n71scMR3FETkXHrBY/aO3vYCDM9H/QrIx79tBuEMMwLL
	 N+y5w7Z9ppAnRZfK01ka9bgi86m2BwKueez/25ZRu+klb4elV5bBG8OZ9E2afNBvLI
	 HgsWPfBsvK713L0DgZ7NRezmtO+Lbutb68rONIPAYrEYUjvl/8xexNjiMuhZe/36/e
	 rc2wIVueBaX4nTUlzQp1syGkGSHpf/DVtSSojLLseo/3OgO481nO8cNeAtMhG8Z8HM
	 f7pm1V8p+eazw==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5079f9ec8d9so1649358e87.0
        for <bpf@vger.kernel.org>; Thu, 02 Nov 2023 16:54:09 -0700 (PDT)
X-Gm-Message-State: AOJu0YxZ/wX9tbMExJ+t6UZ58uEz3SzFu5CxTBwp9EV19qrxhLIYqkET
	0v67qpxFA0KSas2ST3at1zAn+U+s3o4yPpB7J7c=
X-Google-Smtp-Source: AGHT+IFX+KuDErK2I7+0alkSTbwUSp4kyHJM3c39MKx8+jIqxdZ4RzyPiEyetwGKJqGeHwUas+8q9qhOik+watLYaes=
X-Received: by 2002:ac2:434f:0:b0:507:cc09:59ab with SMTP id
 o15-20020ac2434f000000b00507cc0959abmr393744lfl.9.1698969247837; Thu, 02 Nov
 2023 16:54:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231102201619.3135203-1-song@kernel.org> <20231102201619.3135203-2-song@kernel.org>
 <CAPhsuW68DMvSSu9JVfJLWiRjrSWbhOmza2ivd6Dmh22oogM7eA@mail.gmail.com>
In-Reply-To: <CAPhsuW68DMvSSu9JVfJLWiRjrSWbhOmza2ivd6Dmh22oogM7eA@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Thu, 2 Nov 2023 16:53:55 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5+rFanHxuXADDHYheeAwt0bvKdLcxwO=ysCeK+kWdOjQ@mail.gmail.com>
Message-ID: <CAPhsuW5+rFanHxuXADDHYheeAwt0bvKdLcxwO=ysCeK+kWdOjQ@mail.gmail.com>
Subject: Re: [PATCH v8 bpf-next 1/9] bpf: Add __bpf_dynptr_data* for in kernel use
To: roberto.sassu@huaweicloud.com
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@kernel.org, kernel-team@meta.com, ebiggers@kernel.org, 
	tytso@mit.edu, vadfed@meta.com, kpsingh@kernel.org, bpf@vger.kernel.org, 
	fsverity@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Roberto,

On Thu, Nov 2, 2023 at 3:59=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> On Thu, Nov 2, 2023 at 1:16=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> >
> [...]
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index df697c74d519..92dc20d9b9ae 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -1378,6 +1378,7 @@ __bpf_kfunc int bpf_verify_pkcs7_signature(struct=
 bpf_dynptr_kern *data_ptr,
> >                                struct bpf_dynptr_kern *sig_ptr,
> >                                struct bpf_key *trusted_keyring)
> >  {
> > +       void *data, *sig;
> >         int ret;
> >
> >         if (trusted_keyring->has_ref) {
> > @@ -1394,10 +1395,14 @@ __bpf_kfunc int bpf_verify_pkcs7_signature(stru=
ct bpf_dynptr_kern *data_ptr,
> >                         return ret;
> >         }
> >
> > -       return verify_pkcs7_signature(data_ptr->data,
> > -                                     __bpf_dynptr_size(data_ptr),
> > -                                     sig_ptr->data,
> > -                                     __bpf_dynptr_size(sig_ptr),
> > +       data =3D __bpf_dynptr_data(data_ptr, __bpf_dynptr_size(data_ptr=
));
> > +       sig =3D __bpf_dynptr_data(sig_ptr, __bpf_dynptr_size(sig_ptr));
> > +
> > +       if (!data || !sig)
> > +               return -EINVAL;
>
> Sigh, I missed this failure:
>
> https://github.com/kernel-patches/bpf/actions/runs/6737884115/job/1831648=
0188
>
> #110/1 kfunc_dynptr_param/dynptr_data_null
> ...
> verify_success:FAIL:err unexpected err: actual -22 !=3D expected -74
>
> It is easy to fix, but I am not sure which is the right fix.
>
> Basically, null dynptr bpf_verify_pkcs7_signature used to return
> -EBADMSG. And it
> is returning -EINVAL after this change. Do we need to keep the error code=
 as
> -EBADMSG?

Could you please share your thoughts on this (EINVAL vs. EBADMSG)?

Thanks,
Song

