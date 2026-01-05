Return-Path: <bpf+bounces-77888-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD61CF5D25
	for <lists+bpf@lfdr.de>; Mon, 05 Jan 2026 23:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F4BE3071B99
	for <lists+bpf@lfdr.de>; Mon,  5 Jan 2026 22:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759863126C1;
	Mon,  5 Jan 2026 22:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OLYfXn1w";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="iGZE8w74"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547892F3618
	for <bpf@vger.kernel.org>; Mon,  5 Jan 2026 22:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767651896; cv=none; b=YE2Ii9fqmh1M2rJ+e4LyA/kXZtKJagUozsfoTvH41OHiskp36Pr65rJJ5lv2ixy/AxOAC7DgPDZV6bTWJV06yTC02+7FA7l2y9RTFqAKL0y4O8OU3ovolDCrAaoA3LQxVIc23LVCP0iPh4Po76kSPU9I8kKmsP1V56Dz/KDtpaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767651896; c=relaxed/simple;
	bh=4GujXFcPY78Soe5fJ5zpAxshw/1UlVOk9zQiTnAySak=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=koC96WQLY/SUFkcQtZZ6qpXbqgutgd0NazEJ56mhcCuvEeAidXEfN1q+WLQJxOlk2wpkwJJ0RAMK/ECoGbI2QYy20R5GtqmGCsmKY1X/AOnxrwauSMbc6hBt82XPoMid/07XJ196S9svHepR9Z0TuKyfc0z54RE0RmCDcTdKop8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OLYfXn1w; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=iGZE8w74; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767651894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UIu36dvOmGSWGl/xVA3p8ygE7dV+HFTFGY8xQr3jAbk=;
	b=OLYfXn1wKltSxz97KBeZIaXkqe3zKkZMOOogh2Y1d77+GDMcewGNDo/gZVBzIfuKxSB06w
	x9L9c7yI8izwt+VbQ0FvlED8a6Ja9GP0gHXKBTsR+7Z20HAvmElS6X/eNesbZJG59Z4jvz
	G8p5Vz9o15EwrgE2uoniKzQnIALgNWc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-QHJzk_98OXeEDgyvYa1e1Q-1; Mon, 05 Jan 2026 17:24:52 -0500
X-MC-Unique: QHJzk_98OXeEDgyvYa1e1Q-1
X-Mimecast-MFC-AGG-ID: QHJzk_98OXeEDgyvYa1e1Q_1767651892
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4f4a92bf359so9693131cf.2
        for <bpf@vger.kernel.org>; Mon, 05 Jan 2026 14:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767651892; x=1768256692; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UIu36dvOmGSWGl/xVA3p8ygE7dV+HFTFGY8xQr3jAbk=;
        b=iGZE8w7471qtJS6Dr67JwcDKXIwNJyH+kshUD/o3O4u+kcvuIDdSMf/eqOROSVm/KP
         l1hXnLIjSah7gQSqKLrNIzkTjFoBnSlpRu6T3gnJ01wuxaZsf03HpNg5KlCkPrtYoNHN
         rdNb0g08YNQw0I91u0qsMwHhdS/z+EVELCb4239P3EjdTWpWKaAwDcmmuRVxE+mKeMcV
         jA1E99K+kwvl9ghmqQ7xDataOkJ6jUnayxbuHg9oh8dD7vSpxEK3In539EcTwHTdvq2w
         DDTo83c9wZG2m163xWSPMn+7DVS9jBKQLwu3h9tHqAtZibpRWxiujw/n5YMWTJNHyjtt
         J8Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767651892; x=1768256692;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UIu36dvOmGSWGl/xVA3p8ygE7dV+HFTFGY8xQr3jAbk=;
        b=UPFkqTKT8XhBF2AL40AgnUPIZDBR5qRf3EQ56jvOGx7I828VmIdvxx6SwPNDEaRhPG
         cfqeJZWkdcVoYDeNuZKk3hUdICyi/ZXihg0ON/kRWrHoBspMKocgkKN5KxLmTer9jIO3
         lqZNlMx7WDjNKpCX0khgc/zPrgNLUfYtus8VKehF3YONHwqh0PH7vkTYq+MKdqhb28Dd
         nUcHLuTWhXyIF2lIiunLVJjoiAblAco4VJ6uwAWfPuzTd4L8CNEbb/cG88Lk9NvUOcZe
         jQdLhHGEePt4R9rvVgrH2bJO24QBq09vHfpo4GDl3TNhy1cZWYB9H4cg2BEjtt+NUorh
         7Agw==
X-Forwarded-Encrypted: i=1; AJvYcCUxhBo92YPPbZrg7h20dMNw1USnLfgWjUcmioMxPxji/NuiwTjyICvJVplC+mUY7gtOhis=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvs8qvdJKeRDbsmRkbfSLobly+vh57ugbmdz8NtFjGaY3vLrtC
	D2sHsncS6c/9s6lXiqOITyTsCJGai1lukS9TM2KkDlSefGHMTUyZip7bEYPHkUtS3rWuqj1/5Nq
	LJE7RgFe04zA46wMARcDq7oUCGx7K9mqzu15U2NxLnsvlKFsNH519yw==
X-Gm-Gg: AY/fxX6yLGQz+wjck52jcgN2Sicf57eF0vKfOLzKDtgWzSkZmf/a7lmsCY9MeA7gDn1
	NVSMYYWoHmCtRD1R1GHSBUUPJSEDTalbsKKMLHOkJRmhYaxFgyzRmKYPFb7OszB0YYsez9c8M/U
	U86BX4NYpr+5+drE5QDaxgHj0qf5kGGSjyThzHMKTOEe5jC2MSASLzvubcxp2BqPcs4MhiVU0l2
	tiBINfZ+QCOOq1a9bbdPP7UlQGtl/anrvWGzb8Q9yJOmnHk1wp505malEDxWzL+WUts47FBUbDP
	7j60jAaBAa1/H20lHC92/6LiMOyZRwLzKgSBjhdMfE0+xaYIL8IoE1kR0LHainV4aCnPIMNK5wk
	NrRYXOWlmoZyT5zzRzfsd6lCvNtBBWLctKS+q4ArDJA==
X-Received: by 2002:a05:622a:3c8:b0:4f1:caed:da6b with SMTP id d75a77b69052e-4ffa76d8404mr15124081cf.35.1767651892401;
        Mon, 05 Jan 2026 14:24:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExNh0xTTv6L2+E9HZQoqXbrAGQ+sIzOchE6ENYBi29Y5oaqVBf9GDoOpp1unnFpjh+Y6BDeA==
X-Received: by 2002:a05:622a:3c8:b0:4f1:caed:da6b with SMTP id d75a77b69052e-4ffa76d8404mr15123831cf.35.1767651892036;
        Mon, 05 Jan 2026 14:24:52 -0800 (PST)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:cc81:56d0:ab94:b2cb:29a6:7ac0])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8907726041fsm2305706d6.45.2026.01.05.14.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 14:24:51 -0800 (PST)
Message-ID: <7f953b7e2a9d30e0f22c30c5c4e10828018bc40c.camel@redhat.com>
Subject: Re: [PATCH v1 1/4] tools/rtla: Consolidate nr_cpus usage across all
 tools
From: Crystal Wood <crwood@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>, Costa Shulyupin
 <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Wander Lairson Costa	
 <wander@redhat.com>, Ivan Pravdin <ipravdin.official@gmail.com>, John Kacur
	 <jkacur@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Date: Mon, 05 Jan 2026 16:24:50 -0600
In-Reply-To: <CAP4=nvSr=Wz--CJgJ9kmXfB3r3uNYnt9bJt-_bCigH--rbbx2A@mail.gmail.com>
References: <20251205151924.2250142-1-costa.shul@redhat.com>
	 <CAP4=nvS9fTtNCtDCt254-ukTePD7hW3HoKExOPNPDOdppUig9g@mail.gmail.com>
	 <CAP4=nvSr=Wz--CJgJ9kmXfB3r3uNYnt9bJt-_bCigH--rbbx2A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-12-17 at 10:06 +0100, Tomas Glozar wrote:
> =C3=BAt 16. 12. 2025 v 15:41 odes=C3=ADlatel Tomas Glozar <tglozar@redhat=
.com> napsal:
> > Since commit 2f3172f9dd58c ("tools/rtla: Consolidate code between
> > osnoise/timerlat and hist/top") that was merged into 6.18, common.h
> > includes timerlat_u.h. Your change thus causes a double include of
> > timerlat_u.h, leading to a build error:
> >=20
> > In file included from src/timerlat_u.c:20:
> > src/timerlat_u.h:6:8: error: redefinition of =E2=80=98struct timerlat_u=
_params=E2=80=99
> >    6 | struct timerlat_u_params {
> >      |        ^~~~~~~~~~~~~~~~~
> > In file included from src/common.h:5,
> >                 from src/timerlat_u.c:19:
> > src/timerlat_u.h:6:8: note: originally defined here
> >    6 | struct timerlat_u_params {
> >      |        ^~~~~~~~~~~~~~~~~
> >=20
> > Please rebase your patchset and fix this so that timerlat_u.h is only
> > included once.
> >=20
>=20
> Correction: the base of the patchset has nothing to do with this. It
> is the C standard, from C23 (default in GCC 15), redefinition of
> structs is allowed [1], so this error doesn't exist. In earlier
> standards, this is not allowed.
>=20
> [1] https://www.open-std.org/jtc1/sc22/wg14/www/docs/n2863.pdf

Regardless of how permissive the language might be getting in this case,
we should have #pragma once on all of the headers to avoid this sort of
problem.

-Crystal


