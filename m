Return-Path: <bpf+bounces-75437-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1437AC84933
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 11:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C8A63AC236
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 10:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2553313E15;
	Tue, 25 Nov 2025 10:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQtmKhAZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9333E16A956
	for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 10:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764068027; cv=none; b=Juf8vRogKTuTYqMe286JGs5c8O+6ctPjFgGsURZDr62hf7iicm8V3iNsbXsv/8VSrBpATfhzLKHXdrTJR3cPxg6vOgN+u1D7E3impb4Uo0v4CEjWzIrgH1hmLXVTaJRmX9Ku8pTJLZW5gFB4ADnqTAczZ96xRGNthsaXfC/IqgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764068027; c=relaxed/simple;
	bh=MBdX1npt/FRsSNU2DumPEgxLQ2HI7Q6FTMfdmALqxtU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=flHs5nLs7xU61QtrAqFoYIFCpnPzxI7i85x32ggTOvHBiChbz4NeHZSgCKm3AxToOYgOo4t2Bm91DQ/dnO16U1o9PFYVPu5je5/HrAyBAgzV3zcF4pHrQcOatcUKPWPwj0wPj+mh2xUSHqmiz7xACnCFAP173eMkDbM80htfngU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQtmKhAZ; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4eda77e2358so46899911cf.1
        for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 02:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764068024; x=1764672824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBdX1npt/FRsSNU2DumPEgxLQ2HI7Q6FTMfdmALqxtU=;
        b=BQtmKhAZjmyyUJj2BCYhZxT1NjuZNmctY7PrKy7axOr2zn4fjVz2VChZq/FLLv8UNs
         wZhlqJDziVui6O9TTEogZ5QZ5IuGwFrIrj2bj8AFJU/cBAzuasOv5DQ4v0NmU7h4deFH
         sOWKi4YJQrjVjAHI0t3R9GBTpTcrzd7c75nxxgp9sdcNHv7rKI4VnO5URvKeRwIwiH8P
         Cf+Lh3N5RYMcLm6Hz6NErikxgHSESugaf84lYHWF3iBTvj+o8r52F4lbaXp8vp1EQ4u1
         Jp1acVVYM76U8LqEDiHYuku/Ov6xZYcwBpnrNOwfgMR/QExDFlcxeMCpKTnAToA9OIHO
         aTQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764068024; x=1764672824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MBdX1npt/FRsSNU2DumPEgxLQ2HI7Q6FTMfdmALqxtU=;
        b=EkL05xlgRblUduqFDeRlfbe+I1o8yw+70881xh/+ktfIqs2/BeyizvzO5oNxAZmtcc
         iPFMZrVMgrkxYUTmV3HsZnbPnS+zBTptW1Q8q3Su/i9jKypA6P9qIOUgm/aSsW8kJkIv
         kMQ4AK3//ZeoRtdQ89EK+2jiIO2bX2BO7CtZlnCHTa6g7mWb+mQhTEUdvqQcBJWkE6ru
         inccrm5pu5BWxVq4DsEeHQMq+vUQnoLgehEkoMtW1JNwZCft0ST0/nuguESwsbr+1OE1
         LdlspNCMvaOzNCniPaVIrSoBzshyeuQsdyMRybEt3lVhud2a6wL3M0FMhzvu/cdddOKD
         NNig==
X-Forwarded-Encrypted: i=1; AJvYcCXDA7EsWBNfCuKFfR3XxGLqGaBBxu45He8YWObjAM87sEXpMENcVXcYmbZ+Y1GDSgbkL3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAwYjcWjgmNyMRLFF46XZFdHetzPytFwKxOT8FZ4DO0ZY2XmCB
	jDc18jGPUocST7/Pvm6wiaBwS5iFcRvP99aIGKvn4GWtzmrt8kgQnpQZUycy96cBQupTpeUp8uY
	t3e8hGkjYzHLetBfhhIA59KSENe+xlvo=
X-Gm-Gg: ASbGnctvT5LzD/UvQwqmrd7LBFmKy7VWVfkqp4rR5rqQ+93sXPB3CHH5wqh0H3/l3lU
	rL2AGd4BPimiOnEMASH8VKZHtq+YwcMINijfU/FasoCdeft3ulo6ZS1xQCXYoq5CwWYIUZwh9T9
	q9I55ljHFBgT3PaWIPsd0aQnZojYT8a9Mk15J8wJ7cw/NRqt6TMnQ4C7Syv4tnUwPzPAT5dY3Ih
	ldLdkQv/dslqK8TvpXGKS3gAX5mO4Iv7aHtCXDMna6epOLCReT/X5k/O3AFiEjzcRZUm9aKdTYC
	syYfxx8=
X-Google-Smtp-Source: AGHT+IHWXQm9QpQXl0zidFuO8JaRSePKaOTQfOZihpf+JjYjWO2/sFyF7jWEZyCYe8MTh6I7PRlBm+N+3bu9fhxPv8s=
X-Received: by 2002:ac8:5aca:0:b0:4ee:208a:fbec with SMTP id
 d75a77b69052e-4ee58b1f748mr214700251cf.66.1764068024488; Tue, 25 Nov 2025
 02:53:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119031531.1817099-1-dolinux.peng@gmail.com>
 <20251119031531.1817099-6-dolinux.peng@gmail.com> <CAEf4BzYQfHKHUdxv7W7mET1xBXuokvx9v=69HNAkhg_CAPCm-g@mail.gmail.com>
 <CAErzpmvLhKbCYh3hYW=54JJtXj3TV0t2JAmGwy4E3xW7r84OBw@mail.gmail.com>
 <bddc9f1d5c1f2f7f233707cf2af81a2013d46b7d.camel@gmail.com>
 <CAErzpmvP41CNQhRVKuDU23xnBKjj239R6_e5K8DSwcNDo7GG5Q@mail.gmail.com>
 <f515305c3b250f9dbed003b98d78f72c3d72cc2c.camel@gmail.com>
 <ce92f733d24bfad103a9abcc209f411398e23332.camel@gmail.com>
 <CAErzpmv-CQy42LMFR4hzD4ANqL4ENnWyb0uKr7_FH1fj98S2QA@mail.gmail.com> <a254810a42510ad3adc00d27d1fd456710c7faa9.camel@gmail.com>
In-Reply-To: <a254810a42510ad3adc00d27d1fd456710c7faa9.camel@gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Tue, 25 Nov 2025 18:53:29 +0800
X-Gm-Features: AWmQ_bnliLHu2D2o0IqsdDqXXsAq5rrdrCHy36qf_fWsPqki22wO2_JeQdMEs3o
Message-ID: <CAErzpmsOXDe++K4sPhT=KOaumZ4HNP-cNidFaLSt9fr1tRzDKg@mail.gmail.com>
Subject: Re: [RFC PATCH v7 5/7] libbpf: Implement BTF type sorting validation
 for binary search optimization
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, ast@kernel.org, zhangxiaoqin@xiaomi.com, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Donglin Peng <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 2:16=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Sat, 2025-11-22 at 23:45 +0800, Donglin Peng wrote:
> > On Sat, Nov 22, 2025 at 5:05=E2=80=AFPM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> > >
> > > On Sat, 2025-11-22 at 00:50 -0800, Eduard Zingerman wrote:
> > >
> > > [...]
> > >
> > > > > Thanks. I=E2=80=99ve looked into find_btf_percpu_datasec and we c=
an=E2=80=99t use
> > > > > btf_find_by_name_kind here because the search scope differs. For
> > > > > a module BTF, find_btf_percpu_datasec only searches within the
> > > > > module=E2=80=99s own BTF, whereas btf_find_by_name_kind prioritiz=
es
> > > > > searching the base BTF first. Thus, placing named types ahead is
> > > > > more effective here. Besides, I found that the '.data..percpu' na=
med
> > > > > type will be placed at [1] for vmlinux BTF because the prefix '.'=
 is
> > > > > smaller than any letter, so the linear search only requires one l=
oop to
> > > > > locate it. However, if we put named types at the end, it will nee=
d more
> > > > > than 60,000 loops..
> > > >
> > > > But this can be easily fixed if a variant of btf_find_by_name_kind(=
)
> > > > is provided that looks for a match only in a specific BTF. Or accep=
ts
> > > > a start id parameter.
> > >
> > > Also, I double checked, and for my vmlinux the id for '.data..percpu'
> > > section is 110864, the last id of all. So, having all anonymous types
> > > in front does not change status-quo compared to current implementatio=
n.
> >
> > Yes. If types are sorted alphabetically, the '.data..percpu' section wi=
ll
> > have ID 1 in vmlinux BTF. In this case, linear search performance is
> > optimal when named types are placed ahead of anonymous types.
> >
> > I would like to understand the benefits of having anonymous types at th=
e
> > front of named types.
>
> This will allow using strcmp() instead of btf_compare_type_names(),
> which we have to copy both in kernel and in libbpf. Reducing the code
> size and cognitive load.

Thanks, I will fix it in the next version.

