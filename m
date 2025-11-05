Return-Path: <bpf+bounces-73540-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6178BC33742
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 01:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2124442646F
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 00:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19762253AB;
	Wed,  5 Nov 2025 00:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LfTaIBmn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DAE54774
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 00:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762301785; cv=none; b=AjflxAoSao7Oe0J4G5ifdyCCC3UnNtMvbMWOgGDsP9KjWydTx37mj//bQQzcsEgxuNrRQfQs8uj2TgvXh+fWDoskykBRxVfUnCn0/VqFME61QN3UZbI4dvCWSlFBy35iXnOVr5YRdSA16Kxxrx/tVpmEh+JfgJs/Syc07q1t5KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762301785; c=relaxed/simple;
	bh=48YH2RtI3KW7kaFfM/LY3WnoX8bLd0bwh9yZQxZNDBU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gEDhgURWPHXYkoLxUjrkayacRlBTzd1KPBmgn2SVhAne9WBQtPlLeDLM9P2kp7W1UDcYl0eGCu5Tz6GgG3Vy6+SDuvciG3oT6u6+GQAAvrkAw+hf1oSqeyo8ULcTcarK+npg4FPWp4wF/KkTN1GwSutMZqJS8ORUgFoNkpeacV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LfTaIBmn; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-295df6ad56cso22416225ad.3
        for <bpf@vger.kernel.org>; Tue, 04 Nov 2025 16:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762301783; x=1762906583; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R14VE183UXTiToDun6FbcmEsUyunklyOPEIanXsq35I=;
        b=LfTaIBmniUavpTJtQ/0eXlYlafDnHZXjEg8Y1rpb5ko+zVH5Tnp5bK39+nO1LbLpxx
         cyCLJ14ko5Q6YyaoUaGx6m4GEZ8Puaj18hISU99kQV2bWJPwWAX89m7vBi/Jx3QhxiE5
         CQSbdDbWRb7JbqA4cSujFyNSfojizcAngLm70Whg6wnfb5ZlzbCtve8zKbCOGibWDPvx
         IJ+3vhBWFFISya1/6dHPY3KZoAPIHdAX67Lta4DRyXcccmdUT7KCDnyWofMENvfkaWh/
         CFCbPT+gVCf8IU8L5X26TMDwa7iaRuFrYH3vaR51/VqL+M48Bap/WKq2gH71jW2GEuQZ
         GZ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762301783; x=1762906583;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R14VE183UXTiToDun6FbcmEsUyunklyOPEIanXsq35I=;
        b=Ik8RUZf4xlM2roOE2+5cjyYV4IaCVvDvqMRPS58BQoZTjZl9GJ6H5QgjWg0CevDGqu
         bAwRxfAUFN4OrvVfnisKcQoHO9TA2g2b2Rd9qdGOKwLW7G7eQvb6Nfq2z/pCz56Bz+lx
         ls0oq6+cml/kb5ifHxY8KZBzbN82nAtNzLM3OkN39SWk7Nla+OQEklvoyftkC9uLwMqw
         Iclf6zRFivBzDrygh/AMr5A+c71Pt4MBezHrRJLcBxe2QDV7SbAC+kAROb2on5fI6BcA
         Wk5h7FujSUgpGBcj5tniImakutyqcDMf0hJUPpTf5peLQxr24PWhrWBc8vtSUmQ8frS0
         P1Rg==
X-Forwarded-Encrypted: i=1; AJvYcCWFL8sG7W4xSGoN+lvZzSb659+YNYKuiHFG/u/NJhutOvFGHnurJRIFCCBKhOGfipP7Rm8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywevaa7EriqpOx6WoAGsVKWqZ2QCEl/mWLNhug8vb5s4R6ec283
	OuVKLVJLCXyNce1yTOPezfEiPp1yzX2jXKmjdSOEONaPQzT7gPPEJs02pySXVD4O
X-Gm-Gg: ASbGncso6H/MBpBjcwmKubrsyGfhYedBiRd9gHCy+12t5K8hyIxJasW7li3LQHq1Aws
	18pOuaa69yLBk5gHV1EPN07gO7G8L/G0Q1Z/rylgX7X4/jLxkF5WIZJ6euNurWe92waUeVKUUYn
	fCWsrTbJG9qID5GgKSFX0r+z8p/qGUvxPFLgJr1RfsMYy71jr945UmxklI6V0c7qnLRnJCbhGUZ
	wEs5JrcQftLgbmYzCHRazlryn2wQ3NGXdxkW1pMtpPcQ/ZCnKso4ckWejdTmv54ZxP1FGz/F8XO
	xEGyxVyVLyWd038AyJL5UVq/ehNEKR00boQaHDFvm6R5/mSlq5/HWkVIQuvvIz2UQ8BQKqCWPrC
	WZo/8kcPm9QnBxXz5iXdu/jOt51VIz9kHx/JkSyg8zYzgmb6FSAmGXVycf7iFnQsFWhH/NUCD77
	vYyHSKVqjJNDjFFybK3SiYqzM=
X-Google-Smtp-Source: AGHT+IGQ3eQZyWv1ijoQcXgFeW5nEdzJ0bEGgowv/pzjI70FkRTNS0ZWHgI8B0kFFPOf2NtHdfcs7A==
X-Received: by 2002:a17:902:d4c9:b0:295:7804:13b7 with SMTP id d9443c01a7336-2962adb4071mr19818925ad.10.1762301783060;
        Tue, 04 Nov 2025 16:16:23 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:a643:22b:eb9:c921? ([2620:10d:c090:500::5:99aa])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601972a87sm39852035ad.15.2025.11.04.16.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 16:16:22 -0800 (PST)
Message-ID: <3986a6b863be2ec62820ea5d2cf471f7e233fac0.camel@gmail.com>
Subject: Re: [RFC PATCH v4 2/7] libbpf: Add BTF permutation support for type
 reordering
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Donglin Peng
	 <dolinux.peng@gmail.com>
Cc: ast@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Alan
 Maguire <alan.maguire@oracle.com>, Song Liu <song@kernel.org>, pengdonglin
 <pengdonglin@xiaomi.com>
Date: Tue, 04 Nov 2025 16:16:21 -0800
In-Reply-To: <CAEf4BzaQ9k=_JwpmkjnbN8o0XaA=EGcP-=CBxmXLc3kzh3aY3A@mail.gmail.com>
References: <20251104134033.344807-1-dolinux.peng@gmail.com>
	 <20251104134033.344807-3-dolinux.peng@gmail.com>
	 <CAEf4BzaQ9k=_JwpmkjnbN8o0XaA=EGcP-=CBxmXLc3kzh3aY3A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-11-04 at 16:11 -0800, Andrii Nakryiko wrote:

[...]

> > +static int btf_permute_remap_type_id(__u32 *type_id, void *ctx)
> > +{
> > +       struct btf_permute *p =3D ctx;
> > +       __u32 new_type_id =3D *type_id;
> > +
> > +       /* skip references that point into the base BTF */
> > +       if (new_type_id < p->btf->start_id)
> > +               return 0;
> > +
> > +       new_type_id =3D p->map[*type_id - p->btf->start_id];
>=20
> I'm actually confused, I thought p->ids would be the mapping from
> original type ID (minus start_id, of course) to a new desired ID, but
> it looks to be the other way? ids is a desired resulting *sequence* of
> types identified by their original ID. I find it quite confusing. I
> think about permutation as a mapping from original type ID to a new
> type ID, am I confused?

Yes, it is a desired sequence, not mapping.
I guess its a bit simpler to use for sorting use-case, as you can just
swap ids while sorting.

