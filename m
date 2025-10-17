Return-Path: <bpf+bounces-71230-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCD8BEADD6
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 18:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 564501AE1DA1
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 16:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B2D2E6CC9;
	Fri, 17 Oct 2025 16:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJ1JEkwC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D466625B31D
	for <bpf@vger.kernel.org>; Fri, 17 Oct 2025 16:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760719756; cv=none; b=dDdpJMW+jYwb2KfFn1ebtVIxX/hvWoQ2rnCH3sXeTPGq2TA6YUbnewtPT57Iz4OqAQ9YWo7XVaU849kduBbinSav4UPEqsxsIGCeCquIYRriJgADLYSmwMXgEs+ye2BjkDxZD6KEl8fvy8MpqWeuJnlu2cRy9k5gUNEDaLrumwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760719756; c=relaxed/simple;
	bh=f7LeaCgpkpv/0cKz2fOxN7nq7fxaeGm/IHO/bAgYlKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FH12Z44Ila+9Ub+s7rqLzyYxu6nBIb+RvWRiu2k0FsTNB4/kaVOoN4dAWezsd91UO9gptVTqBnpngJI8ioqK/R7LBTcqJ3uk9HWaSmkAMbe9iU6fG6DjFKZa/u1pcMqSoJaDXQmMDyK1UK58XJLODqIUgi8Kx2w8eXgMp/sELto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bJ1JEkwC; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-63bcfcb800aso2390983d50.0
        for <bpf@vger.kernel.org>; Fri, 17 Oct 2025 09:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760719753; x=1761324553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f7LeaCgpkpv/0cKz2fOxN7nq7fxaeGm/IHO/bAgYlKk=;
        b=bJ1JEkwC7NByXKq6dy11aptUFxntDH84unl5OVEp5R2dkoTjsid1AOJURc8OOkhU0T
         i54bTevcV06/x1VHdMvHvgBlbXJgsA8crUMf7aL/x8IDPJhsdF7BRuJwhPklnjm4QuC0
         EvqNHPyqqbR179Ysm0DfJfBIFmATSNc1yVjD7rZqH54CSfvxI0EVbi9S7G2+cvSQyP17
         0NSAX1v8FacDo4m0berWoPudfiiLD9iD5jOVhTydiGbmTvQxh1BuE1dj4sg6UbLrydXI
         Ozgj2A5ui/w4BqrZw57XXHC27w72qJLu88CJGH9ASEhj47NQa7GkxkeU1I1C+fUVuifF
         9ltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760719753; x=1761324553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f7LeaCgpkpv/0cKz2fOxN7nq7fxaeGm/IHO/bAgYlKk=;
        b=as0BZV82uA2llsXyZxe8ylIoR7tZjV1Y27lkVbMRoj1OY77wuBCdThudVWiGl/hEAF
         jSUw7LykB/BOC+LdHzrMAkJRp3As/plzPdhwSQa0shTOX/YmGfp1oNGcYDttabOgiSSY
         seZ1nlKBCMJyFdXwjkW1j3orBg4I4NgPMYQ71iFstFJf3UNA2PuR/IfsmacDtM9QZ/qp
         zFBjTqWfrn0DZ9WqA1On9YhiuxwtT4XEvPgI7iRzi+/WxcXNzVq0txZc9cAlb6e54zrb
         OhIcrGJc6qd9Smldde93fvPuo4On1EQ17G11Xw0zGsqgq7p/6Z3ESK9MAtRa3xIVICBO
         G1Cw==
X-Forwarded-Encrypted: i=1; AJvYcCVwO8jO0VDB8PcoJf0Dh4wwown05LTg2U3Ptjz6v0sVN9IBry62cZz1SsGdr1w0s7cwglE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPEU4C6y0BMigdPlKmwazUE+v7Hjef8JAz4Pn/rvzL5FnC51y7
	QfSkDXfqgtGfII5oC3OwOBY/zuacp//BpKrbvMIIJN+1PjET1fsaPRuGi/IuEa4xNOxFMOPVb3X
	QcWgvd/IccownyigBSGI3n/iezShbewI=
X-Gm-Gg: ASbGncsMTZ8aR7GjqM1t/LKkwMUhYzgg1QiDZuEqSo8VUMU4ly8owIcmp6IPwCJR9eK
	VrAN7BXr9aUchU6rkY8FYtrYn1Do6lAGxP+J/mh5+vzBdjOLeiLIzh4TQpJXHN1BDF/mZteqohq
	tirUjarPa6F3EmUcNL+DeMW7pv5hLj4BG4n32LsytUEQbKajiJXKxHxuMpKMxOCHNcVTtI44fnT
	9H0UJzPBY0XEfbdkZUy5RujwRy3sWboqAlsE7UI2PzoHDOMxcuC23LQllfruN1PT84yup0=
X-Google-Smtp-Source: AGHT+IHFbQbxlxK7FSTPuj1BO+alMVxSt0ml/8VBdjoMgkxZPLITTYvd3gbOYdpc/sSfjuHAODkTjL5FEpC7MabQXUY=
X-Received: by 2002:a53:c050:0:10b0:632:ed6b:754 with SMTP id
 956f58d0204a3-63e160e7c37mr3564373d50.9.1760719752582; Fri, 17 Oct 2025
 09:49:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016204503.3203690-1-ameryhung@gmail.com> <20251016204503.3203690-3-ameryhung@gmail.com>
 <285ba391-1d23-41be-8cc4-e2874fbcb1af@linux.dev> <CAMB2axO9GN=EMK2uLxqDLFkNk-V8sA7Rdb9LH3u6xx7fpCTyRA@mail.gmail.com>
In-Reply-To: <CAMB2axO9GN=EMK2uLxqDLFkNk-V8sA7Rdb9LH3u6xx7fpCTyRA@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 17 Oct 2025 09:49:01 -0700
X-Gm-Features: AS18NWC8POPlCZpJlI32QBv7z9tfYzxCClQbkuYPGVUyOeqiGA4bbSrWJ-paX4E
Message-ID: <CAMB2axMitKK6yvSKkyApMaoD2+W973N+7X2sDKj1yCVAMvakmw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/4] bpf: Support associating BPF program with struct_ops
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	daniel@iogearbox.net, tj@kernel.org, martin.lau@kernel.org, 
	kernel-team@meta.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 9:38=E2=80=AFAM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> On Thu, Oct 16, 2025 at 5:19=E2=80=AFPM Martin KaFai Lau <martin.lau@linu=
x.dev> wrote:
> >
> >
> >
> > On 10/16/25 1:45 PM, Amery Hung wrote:
> > > Each associated programs except struct_ops programs of the map will t=
ake
> > > a refcount on the map to pin it so that prog->aux->st_ops_assoc, if s=
et,
> > > is always valid. However, it is not guaranteed whether the map member=
s
> > > are fully updated nor is it attached or not. For example, a BPF progr=
am
> > > can be associated with a struct_ops map before map_update. The
> >
> > Forgot to ask this, should it at least ensure the map is fully updated
> > or it does not help in the use case?
>
> It makes sense and is necessary. Originally, I thought we don't need
> to make any promise about the state of the map since the struct_ops
> implementers have to track the state of the struct_ops themselves
> anyways. However, checking the state stored in kdata that may be
> incomplete does not look right.
>
> I will only return kdata from bpf_prog_get_assoc_struct_ops () when
> kvalue->common.state =3D=3D READY or INUSE.

should be kvalue->common.state !=3D INIT to make it consistent across
legacy and link-based attachment.

>
> If tracking the state in struct_ops kdata is overly complicated for
> struct_ops implementers, then we might need to consider changing the
> associated struct_ops from map to link.
>
> >
> > > struct_ops implementer will be responsible for maintaining and checki=
ng
> > > the state of the associated struct_ops map before accessing it.
> >

