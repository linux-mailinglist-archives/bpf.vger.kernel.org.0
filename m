Return-Path: <bpf+bounces-12381-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3FF7CBA33
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 07:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8786A281694
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 05:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCBEC133;
	Tue, 17 Oct 2023 05:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0poQWVZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09719C12F
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 05:35:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B9E7C433C9
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 05:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697520930;
	bh=C1tokE0LRGEedDukFY72J8Rbpsi2aFNpgcICl03O/pA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=X0poQWVZahx11gvOjAAtQ976elcf8cGAUJ2wTkmro1BMrPVWj+v4ejhI7L7QZPHkb
	 UNGefYpUmfmxSsCMPVF21xmjiEUDIzlYi/jzJrAETckYj98tagDzdnLTA+2adj1OdE
	 IH4CElgbEGBaVqYuOryUtkh/VyBl2aQiHmap2MdEvOahba6c7ax0yxKNzjRm3CQEX+
	 nKxmA4E5HtFmWUfGXg+DsM8cmKkzrbLHs8oiWREZBqy9jEf+HokXXLdJN5BRc5XuKp
	 URwW7gfxm3XGVARKIOv49iXPkcahH1w0HAc0UcMFwzItC71LP51r8k3+B+shCVAGPE
	 0/lALAPOrjGMA==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-507962561adso5816277e87.0
        for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 22:35:30 -0700 (PDT)
X-Gm-Message-State: AOJu0YzmA82eEAjstHSsT/pQ5tWF9iFsloMn308lzv7f4B518cJ0cMRx
	kFTHN/fwQFEnljrfiL2pDfXVEbZMQjTR51nRde4=
X-Google-Smtp-Source: AGHT+IGO5kJQMyZJo8AOLh0R5+fANiUPYY7irO+xj8qtyak2MSHTxtatKn1Vjha+ESrI69V5ScixefNyCAc67TaiVmw=
X-Received: by 2002:a05:6512:3195:b0:503:34b8:20b with SMTP id
 i21-20020a056512319500b0050334b8020bmr1328164lfe.65.1697520928765; Mon, 16
 Oct 2023 22:35:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231013182644.2346458-1-song@kernel.org> <20231013182644.2346458-3-song@kernel.org>
 <20231015070714.GF10525@sol.localdomain> <CAPhsuW42L6cfyxLR30kc1zSWQr8_JyxoUv1EuRVZpoAix3bm8A@mail.gmail.com>
 <20231017031206.GA1907@sol.localdomain>
In-Reply-To: <20231017031206.GA1907@sol.localdomain>
From: Song Liu <song@kernel.org>
Date: Mon, 16 Oct 2023 22:35:16 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4u2GNL8BmEPPtYjc1KtP4Dx+wqtX1fc2eMPYB_6LmrRA@mail.gmail.com>
Message-ID: <CAPhsuW4u2GNL8BmEPPtYjc1KtP4Dx+wqtX1fc2eMPYB_6LmrRA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/5] bpf, fsverity: Add kfunc bpf_get_fsverity_digest
To: Eric Biggers <ebiggers@kernel.org>
Cc: bpf@vger.kernel.org, fsverity@lists.linux.dev, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	kernel-team@meta.com, tytso@mit.edu, roberto.sassu@huaweicloud.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 8:12=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
> On Mon, Oct 16, 2023 at 01:10:40PM -0700, Song Liu wrote:
> > On Sun, Oct 15, 2023 at 12:07=E2=80=AFAM Eric Biggers <ebiggers@kernel.=
org> wrote:
> > >
> > [...]
> > > > + */
> > > > +__bpf_kfunc int bpf_get_fsverity_digest(struct file *file, struct =
bpf_dynptr_kern *digest_ptr)
> > > > +{
> > > > +     const struct inode *inode =3D file_inode(file);
> > > > +     struct fsverity_digest *arg =3D digest_ptr->data;
> > >
> > > What alignment is guaranteed here?
> >
> > drnptr doesn't not provide alignment guarantee for digest_ptr->data.
> > If we need alignment guarantee, we need to add it here.
>
> So technically it's wrong to cast it to struct fsverity_digest, then.

We can enforce alignment here. Would __aligned(2) be sufficient?

Thanks,
Song

