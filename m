Return-Path: <bpf+bounces-13104-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 876EA7D46C7
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 07:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B86CF1C20B52
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 05:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBE35671;
	Tue, 24 Oct 2023 05:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBO8+Jxs"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E871FA5
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 05:01:33 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCB1B0
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 22:01:31 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-4084095722aso32821095e9.1
        for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 22:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698123690; x=1698728490; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CEWHVBSJljVv3NcchzJwkvXeBjvw/X4JgbzHYj40s58=;
        b=QBO8+JxsFdbj3LVGklqAy7yaGc4hLEqlzkiPeVXjrBshD+v0RA6sh/vUUc9V4c47CW
         xXnwl/Zy9HKfYry2o29jDNnlNqFk0UsF0S6hJAOEPWpvM6pmnTQpRSfJ49DEJtr0IZvJ
         Y7G34ZrJSjXTUC08dFIscR4Z7J8uoajgwQoPTu9zVOU+lcwB7vw0fOaQJbnBepbQdA7h
         DL7UEAyLDI3V6VyNaG+bOMmHcVuPO7FnsLum4WY/rqw2MjeRkoWwnWGkYn7IFRJoZCWN
         hy9XFmmraVESrP4hIdSKPislxpSM9Re3YWFZ39mmM0gEVMfn2K+CYMDmlOrJLMjHy9+C
         tXkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698123690; x=1698728490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CEWHVBSJljVv3NcchzJwkvXeBjvw/X4JgbzHYj40s58=;
        b=u+dALkQzoTZxcqFV8pnue+4moIbvRmPDdsxyfAR2iBVvnlBYbsChgLTbyS4D3Dirbe
         kB2Cat2PycrpJYF+dJ4b2HqGwM4wqRcUGsidQBnjVsnHmGYw4qDzv0tOUDK6wGwsIrdF
         Do5bxq2l/mE40d5+B5hmsKZeK5aVv89SKaQszEef/W6Q0DY9RDGt0PglAfLoG7FW5UwI
         6uvC/LEQyCqhQbzsRz+OwV2rRj9PItYEzuQkYfZZuz05pb1WOHqeBAb1aCzF0N2cXgZh
         V/yy35pd3T0SbmJxPBb/Xi8N6WgMYwbgJKV6WqhDGW5lkN+NOQ2tkTyD6TzXKEMi1//H
         Ah3A==
X-Gm-Message-State: AOJu0YySkepMu8aA+hUiDWa30bCEEYfCMd5aryf5gZCAK1MvJTy+8ula
	BjI29F3wwRRudqYWdsOjfKn5RCSOL79uBPDCEvg=
X-Google-Smtp-Source: AGHT+IHJ8NVG3SkzwjL8pMpvngsRPAghXbClEphUnlMSYKPg/zkDTp3e0uxz1aSbvGLuVxWJLQIkOau9WOgwG0hbyXk=
X-Received: by 2002:adf:ec50:0:b0:32d:cd57:1a58 with SMTP id
 w16-20020adfec50000000b0032dcd571a58mr8050644wrn.54.1698123689421; Mon, 23
 Oct 2023 22:01:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231023224100.2573116-1-song@kernel.org> <20231023224100.2573116-4-song@kernel.org>
 <CAADnVQJ-u_j8p7FMOpDHsUKjTa0E9sjA0G=zG8V484kuatNDvw@mail.gmail.com> <90721298-D511-4C37-B8BC-947215BFA59E@fb.com>
In-Reply-To: <90721298-D511-4C37-B8BC-947215BFA59E@fb.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 23 Oct 2023 22:01:18 -0700
Message-ID: <CAADnVQLC9T05WRgFebSEjMVomYJPvGmX9r2KEMqC11GdbRg9pA@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 3/9] bpf: Introduce KF_ARG_PTR_TO_CONST_STR
To: Song Liu <songliubraving@meta.com>
Cc: Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>, 
	"fsverity@lists.linux.dev" <fsverity@lists.linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>, 
	Eric Biggers <ebiggers@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>, 
	Roberto Sassu <roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 8:25=E2=80=AFPM Song Liu <songliubraving@meta.com> =
wrote:
>
>
>
> > On Oct 23, 2023, at 5:49=E2=80=AFPM, Alexei Starovoitov <alexei.starovo=
itov@gmail.com> wrote:
> >
> > On Mon, Oct 23, 2023 at 3:41=E2=80=AFPM Song Liu <song@kernel.org> wrot=
e:
> >> +
> >> +        __bpf_kfunc bpf_get_file_xattr(..., const char *name__const_s=
tr,
> > ...
> >> +               case KF_ARG_PTR_TO_CONST_STR:
> >
> > CONST_STR was ok here, but as __const_str suffix is a bit too verbose.
> > How about just __str ? I don't think we'll have non-const strings in
> > the near future.
>
> I thought about this. While we don't foresee non-const strings in the
> near future, I think __const_str is acceptable. These annotations are
> part of the core APIs of kfuncs. As we enabled other subsystems to add
> kfuncs without touching BPF core, it makes sense to keep the annoations
> as stable as possible. Making __const_str a little shorter doesn't seem
> to justify the risk of changing it in the future.
>
> Also, we already have longer annotations like __refcounted_kptr. So I
> personally prefer to keep the annotation as __const_str.

Ok. That's fair. Didn't realize that such a long suffix is already in use.

