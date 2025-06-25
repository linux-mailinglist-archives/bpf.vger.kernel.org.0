Return-Path: <bpf+bounces-61573-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90545AE8EEF
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 21:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 456C01C281C3
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 19:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7FE1F3FDC;
	Wed, 25 Jun 2025 19:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUkuHtHU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667752AD13
	for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 19:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750880778; cv=none; b=sxR1mT8xtkx6UO2GFpYdaUliGqlTaKqvj90PFXaaEHjZxJ4JH0Yc/B4sUwPIHIEfDU7e9vjXWnr3N1DOVS4I8UkTBXL/pab1mFcsn/HwvHQn4q/twP6xi9oL7fWwnNpVZj2v5jAWZ9OxM7/dcP/QNnBDnhxMjIbYp0xMpMjI3Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750880778; c=relaxed/simple;
	bh=aRvxc2CkKJWNm9x/VrnvdKH1FZkFN8xYZWOUKF1uer4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nY+2uisrMzJ2OhxR8A8Qjf40bx1x383CrmlEwPGtm/bromcr2HcFMbroDbcHFnhRRn5Myt/PvRZdIAvXVbaXsxyflurt549aHgwU+r3Tet3GFNN9r/NdCBMC1ZkUT9zPP+MgH6GPUi53sh8dKYSZUQFqT3gnDHqeTqa1KCUvHBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CUkuHtHU; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2363616a1a6so2885535ad.3
        for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 12:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750880777; x=1751485577; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PHm2VbDsH9bJuWx3x6oS3u6X68/W0rI/VG9RJRRlLjk=;
        b=CUkuHtHUviPQasbYlD/erDkmk8NPAI3h34p/RLgMXNY6wC4w4mxc+ZFTCMTjRIcZ85
         UiViUpjZCO6ptZ111bmJ6bJQa9i0y7NGFrpRw2dxlECmyPlPmcinQGt/wV9HNss4xzEH
         cj4z1eqbm0JZ51NDEckRmQhCQW1Fzrl7cgiUiKw6kDf11yH1SxcrCchVV4w5pQgpAbKh
         HeJpEDxuwtixIPbLhSuj+XVv/75oJWNFPzhCKj1MtR63jBmESxd7K0EasZSTe5TCOq9M
         4JhVRgj/fHS0ATX+MKophW555oFscQMqVYZjZHU0vno4VMBgXT7lDOG+sY9SVYhN9MGj
         dXJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750880777; x=1751485577;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PHm2VbDsH9bJuWx3x6oS3u6X68/W0rI/VG9RJRRlLjk=;
        b=XZpgnVgtMp+l6qeDUTvJQ0J82Mdh3hhWCstS40tM5X/6Bo7T/GuTWgY0rRAuDa9Lup
         GIObbA7Z9Hw+Bvlb2CEkJcASjtSftlHIZNoq4QN6nAU0o3wVO9WIOv14fDhCH4jdulb6
         0v+fOOmSvqbqbfDws/WP47olAkOdWvzQyGqx6NdESJssYlUEOEJMfVW5z5IIIYjDIuUT
         CLyT1nV3bAuGahQjlKyuOR9TeEvmfMhocR2gKRmU0BKl/O8FfilW8V8/g5q9N8K2nhju
         nO9Y3/a3RLJTIEodiTeuytdXE+yGXg9GQHCf0iBJrzhRH9h75K7jq+OI0tPpqOBOv/EP
         eWAw==
X-Gm-Message-State: AOJu0YxwSDwFRHgO5G63KlicGrDonFTR8sp2MicBHMctqJ+uto5QLjiF
	h7F3nNZ2JPo9wfvEA/+y8kSSo6gQhjkXJoVu1pazIvdMVaAF9iriYvN+
X-Gm-Gg: ASbGncunDuD4qDygu9Di0Af+pI5ay1Yk2xBTi57veD5rGo+W0cW2sL3bbaVBm1BqoLy
	Drj5GyTuL1z0G/i/0HVeR1l4jZafqIf5fONgE9eNZDaBqtAtbB74CKi/Dy8mRgkzhbflAUQvEnI
	Z9zvsm+EhtU1O9/x4CxNTr9qp5JmA83tkyPZpOjebRcQ42SXS5B04/2AqL+kXWIYJY70TEkdtPd
	BqIjeuTFWFomXm7j0VZKMzr5vx/4fMK1lN5bKt3RQPchBsYN9Yucq9idkbAQNdkevNPz+kqE+yF
	kJEN/faUKrI7IkQyuH2GwFPuzTGQFNgIYQVJ8Gwpt/7rOB2CJCx9u/+9d/NH0ONCm84VpbW3IEe
	tCgjc4D4hjls=
X-Google-Smtp-Source: AGHT+IEvCSmNiHh8lMnLOiePa83UmueRtJjKdvB8HXNjFLXYUejryZ8t3sooXbZxnSMX9hIkdcxFzw==
X-Received: by 2002:a17:903:166e:b0:235:880:cf8a with SMTP id d9443c01a7336-23823fd068fmr71003785ad.15.1750880776658;
        Wed, 25 Jun 2025 12:46:16 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:2bd4:b3aa:7cc1:1d78? ([2620:10d:c090:500::5:1734])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b31f119e820sm13254259a12.23.2025.06.25.12.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 12:46:16 -0700 (PDT)
Message-ID: <8fa3ad36c2754bfa9a9b7366d47a1d2824c81ce1.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 3/3] selftests/bpf: check operations on
 untrusted ro pointers to mem
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, 	martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev
Date: Wed, 25 Jun 2025 12:46:14 -0700
In-Reply-To: <CAEf4BzYv1GKz81pVsCoeBBO5pdc76bkdg-AY6vA9sbbaXE3Eew@mail.gmail.com>
References: <20250625182414.30659-1-eddyz87@gmail.com>
	 <20250625182414.30659-4-eddyz87@gmail.com>
	 <CAEf4BzYv1GKz81pVsCoeBBO5pdc76bkdg-AY6vA9sbbaXE3Eew@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-06-25 at 12:38 -0700, Andrii Nakryiko wrote:
> On Wed, Jun 25, 2025 at 11:24=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
> >=20
> > The following cases are tested:
> > - it is ok to load memory at any offset from rdonly_untrusted_mem;
> > - rdonly_untrusted_mem offset/bounds are not tracked;
> > - writes into rdonly_untrusted_mem are forbidden;
> > - atomic operations on rdonly_untrusted_mem are forbidden;
> > - rdonly_untrusted_mem can't be passed as a memory argument of a
> >   helper of kfunc;
> > - it is ok to use PTR_TO_MEM and PTR_TO_BTF_ID in a same load
> >   instruction.
> >=20
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > ---
> >  .../bpf/prog_tests/mem_rdonly_untrusted.c     |   9 ++
> >  .../bpf/progs/mem_rdonly_untrusted.c          | 136 ++++++++++++++++++
> >  2 files changed, 145 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/mem_rdonly_u=
ntrusted.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/mem_rdonly_untrus=
ted.c
> >=20
>=20
> Would be good to have a test that demonstrates loads of all
> combinations of signed/unsigned and 1/2/4/8 bytes. Maybe as a follow
> up?

Will respin.

