Return-Path: <bpf+bounces-16857-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0786A8068D1
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 08:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B631428203F
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 07:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A952118028;
	Wed,  6 Dec 2023 07:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OuvjhmrM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F82D5F
	for <bpf@vger.kernel.org>; Tue,  5 Dec 2023 23:43:37 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-db5e692d4e0so5139841276.2
        for <bpf@vger.kernel.org>; Tue, 05 Dec 2023 23:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701848616; x=1702453416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2M3fcWfuKZ0oJPVwfakCI7vyMHFPcKgVyJ1A+kF2YfQ=;
        b=OuvjhmrMLv6rIMRHnr6zvIiYbznTYyrJDHPjDuw4zDISIas83li0bvg2hWyGK9IE7O
         VJ3OKVweqnvjtYbc9Wr6QuPq2ebqM923woievYcWMUdtu0BRQpZiVY0Z5ergk0TwJ1ND
         b1mH95o4cia/48VBNDplr87DFwi5VG98Vte5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701848616; x=1702453416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2M3fcWfuKZ0oJPVwfakCI7vyMHFPcKgVyJ1A+kF2YfQ=;
        b=AnOEzT7vFGcE5oi2NTu7d8bOd+QlNmeSuYnLHWXnETJujT/m1FtpvYOJ1/CuGLTi/K
         WAspNPuLqvif5ZeJkzNJlnTeSrFkdCsSKy72DWL+mANwfoS/+xdmw5uoYKIUbork2AJ2
         Wi5mDcsOcnFN1H9KkkZ6VseEfJ7usOSS3m4/rh9blfmOMbM3O18a1gLTcgCopzv1n+9b
         VNVYOJVSpmr+4l+mn95WRZMtSoltpf9GiTep+l/6V6b/y5APmzygtuQiH5LhvYb9+qPC
         X5j+o76kDW5fFol4kxOHeDDnvfuxF8+ax5IFye3TB4pqAkYbjeKQemKOF1SgfW3bFKrO
         gOhg==
X-Gm-Message-State: AOJu0YxgdKsX2uPZUWdgSp6JPiTgGrKxde3LuRRrtlOmr7J6LmKLkQzO
	Hg/XkRUtC3Xug3MRfhlTPSv+NEprOmLUeJzAb0wTsw==
X-Google-Smtp-Source: AGHT+IF3/gw4rOSnVtIMR8bBZfqKrAHTsxgM4aBCfbE/7K4PzeLEa68gHkK3yFY/MY/lVlHVtriQhFtzDbY3bW/gwH4=
X-Received: by 2002:a25:7650:0:b0:db5:3bb8:c5da with SMTP id
 r77-20020a257650000000b00db53bb8c5damr320154ybc.32.1701848616517; Tue, 05 Dec
 2023 23:43:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231201094729.1312133-1-jiejiang@chromium.org>
 <20231205-versorgen-funde-1184ee3f6aa4@brauner> <CAEf4BzZY=twEbSyE7cLee_aYcH3k8qxUEt6tBC_G-etU7E9JpA@mail.gmail.com>
In-Reply-To: <CAEf4BzZY=twEbSyE7cLee_aYcH3k8qxUEt6tBC_G-etU7E9JpA@mail.gmail.com>
From: Jie Jiang <jiejiang@chromium.org>
Date: Wed, 6 Dec 2023 16:43:25 +0900
Message-ID: <CAGUv5Mj3o0_jYf9bDR7mj2Oh0oOu-NmQd3o_NaH_J9dFvmRfsQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Support uid and gid when mounting bpffs
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	vapier@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 3:28=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Dec 5, 2023 at 8:31=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
> >
> > On Fri, Dec 01, 2023 at 09:47:29AM +0000, Jie Jiang wrote:
>> ...
> > Sorry, I was asked to take a quick look at this. The patchset looks fin=
e
> > overall but it will interact with Andrii's patchset which makes bpffs
> > mountable inside a user namespace (with caveats).
> >
> > At that point you need additional validation in bpf_parse_param(). The
> > simplest thing would probably to just put this into this series or into
> > @Andrii's series. It's basically a copy-pasta from what I did for tmpfs
> > (see below).
> >
> > I plan to move this validation into the VFS so that {g,u}id mount
> > options are validated consistenly for any such filesystem. There is jus=
t
> > some unpleasantness that I have to figure out first.
> >

Thank you very much for the suggestions and discussions.
I uploaded the v2 version of this patch to include the checks as you sugges=
ted.

> > @Andrii, with the {g,u}id mount option it means that userns root can
> > ...
> [...]

