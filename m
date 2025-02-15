Return-Path: <bpf+bounces-51644-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0A9A36C03
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 05:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 897373B1F6A
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 04:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240BC15A848;
	Sat, 15 Feb 2025 04:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="St57vTeh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39656748F
	for <bpf@vger.kernel.org>; Sat, 15 Feb 2025 04:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739594374; cv=none; b=UYZcvIYLzQx0pdqWhOcA8dREzTSbxZQe6kntLTabxNIl9N37X5D1TY3gz/zXO0Pkf8EyEvaYDP956isTo/Ygo3xukyw+9XpTzNW4qOrCaJDrmfnKJYJHF42xysA9dUY4bB8NLX/vUI12oic4SlthlNJvR36qA++/0Xt/j0DYPWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739594374; c=relaxed/simple;
	bh=wikAyXYiPPe1o1LQhxQIv+QxQI/nIQWpdQwZv7Ksazw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pD880fEQrzCVeEmRi3LAASVrramWIU8Uq8zm/jakzzd8DZ4/7A13d50xcnlOUqSptrhrcSJqSTBcqeYYwq5P6fnE5DzlYPfYC3624xFo61YHD0VwFh5SjNeOmXu141OtIWHUd4eVO7XspBzPsRB2NhbokbcWwNyZu+kDs8SedrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=St57vTeh; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6f6715734d9so24741317b3.3
        for <bpf@vger.kernel.org>; Fri, 14 Feb 2025 20:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739594372; x=1740199172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dXlkGSXejWHW05jGJw8TNarPoB2t3TY0TPODd+DXBqg=;
        b=St57vTehFm50/MTVcpREqFYXPyS/ha/CGRKT4TP+v20Z/i1CBek1t/E+SKPaEsf1CX
         8gJjebcYhklko4LAUwkW0HOh/G2Tb8zBqBTH8IP8s4gGu9fPOL0V49w/q8m/75ObmHLE
         hUolOS/k5AidZw5xoghgCaNFb46XWiCcMnhL8qnv+b3i7bEn0fVAqbThsCi8+I9H6wp2
         7umZcSr7n6OOYA/TyDh7hvA7oMb3MtWyNh4MceFshNj0U4MHkcKTbxk9oWFgINUld4bm
         ODA643xQGA0QpccBkW4tLS9o7gAM2YWAKGmPaaYoMxkyDRbF1XvkdPtu33tRkziIMGZ1
         dTgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739594372; x=1740199172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dXlkGSXejWHW05jGJw8TNarPoB2t3TY0TPODd+DXBqg=;
        b=ve1KsS3ZIJgHtLgZQZKFRCagYYGjtmfk2ahA88JrGbS/mPdM34z4HRLDTRtGe/VwLY
         5X1Aft1BzWuwZ8eA8l0qJTuZkZtjBo2B3LSkQsv7vdndJ5pGAiJEEloHVYEONAYXKg+c
         55dcwgiuUBpw3jAQinQmsS0Y45VU3Wjn4UYHK7ESKTLWzoc79yZcWMQyH8AfgyK+H0sF
         f999PSRcr654zKQ2s/jw23wiIQfGuDSjaUoHmmTwaaUWgfZqNKZOPtSOwSYJ1HsmAS/N
         72r9sr20kr7syG0ctCiI6xARkQHIGpB0SjRL5/azeFYnE+JsnjBWtBHV33141am1eEiY
         f3Tg==
X-Gm-Message-State: AOJu0YyI9Zkn3h6VkpRUloTQphG1g5XxErQC6oaelpXbnLMQj4hcq1xT
	kBxreB72lzLWx9fx+8pMitmBbZjxqd6As7LHILqMA9Oeqiou1NqHNdQc4/LeAXQRXlokGILWDnc
	UNslE8JmGoE9eN2VRiTvuJ/+3KH8=
X-Gm-Gg: ASbGnct1fEr9rjvJIpctjHUkBR6KdZJqJCGXnsFtB3vGy5zIbRhLgcd7ShrGtQtIQf5
	qkn3SU2DG3lP58XNAVcLpVgbFlXJ5AobagFGRik6Vlel/vxbZUt42wU8v+HVChGfG3LqvxXwX
X-Google-Smtp-Source: AGHT+IGVqiLDG4PLK9nfAfGPqtsidGS04btuKwTFovXvairxT6eEXGxZlKeKU/MgFrG7g9SOn0FaFWEIHJ/nkxKshwU=
X-Received: by 2002:a05:6902:13cf:b0:e5d:c68c:3549 with SMTP id
 3f1490d57ef6-e5dc902a6d0mr1578991276.8.1739594372108; Fri, 14 Feb 2025
 20:39:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214164520.1001211-1-ameryhung@gmail.com> <20250214164520.1001211-2-ameryhung@gmail.com>
 <CAADnVQJs0d9fihukcNaw5jfjHTEAMuisR=7fypoJn_DumfV_5A@mail.gmail.com>
In-Reply-To: <CAADnVQJs0d9fihukcNaw5jfjHTEAMuisR=7fypoJn_DumfV_5A@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 14 Feb 2025 20:39:21 -0800
X-Gm-Features: AWEUYZnVesgReWJrHEo9hH4psrvF3NhHPFM4Ttd3q558D5olZ3cgiplXuIStumw
Message-ID: <CAMB2axN8hZ2vgA6crYCyisBNVFti48KVuNdutCVz1f9dcXU00w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/5] bpf: Make every prog keep a copy of ctx_arg_info
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, Eddy Z <eddyz87@gmail.com>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 6:42=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Feb 14, 2025 at 8:45=E2=80=AFAM Amery Hung <ameryhung@gmail.com> =
wrote:
> >
> >
> > +int bpf_prog_ctx_arg_info_init(struct bpf_prog *prog,
> > +                              const struct bpf_ctx_arg_aux *info, u32 =
cnt)
> > +{
> > +       prog->aux->ctx_arg_info =3D kcalloc(cnt, sizeof(*info), GFP_KER=
NEL);
>
> could have been kmalloc_array.
>
> > +       if (!prog->aux->ctx_arg_info)
> > +               return -ENOMEM;
> > +
> > +       memcpy(prog->aux->ctx_arg_info, info, sizeof(*info) * cnt);
>
> Please use kmemdup().
> Otherwise cocci fans will send a patch for this tomorrow.
> imo kmalloc+memcpy is fine, but, sigh, cocci.
>

Thanks for pointing out. I will replace it with kmemdup.

> pw-bot: cr

