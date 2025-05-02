Return-Path: <bpf+bounces-57259-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB69AA7921
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 20:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F6681C047BD
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 18:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938D8267393;
	Fri,  2 May 2025 18:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLmnvIl+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F6F42A87
	for <bpf@vger.kernel.org>; Fri,  2 May 2025 18:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746209395; cv=none; b=VmQam/8motYUSylLCpiPy72nqsQW++PjdrS27PzaNKNoG2HTtHC+m6mBYSVEHnE35dZ8wdjOkRzBU8UAEpfoWPHbh2E/ZtkBwFot9Hr60Ox9vmYoMecrwXLrMfpFzQgFc13VHyWeGrxt7k+BDp6nXqEjcoN1etiXcaLkvGYVGq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746209395; c=relaxed/simple;
	bh=rcCrLN/kccrQypKJkRdAp4NIqaNnzfTtnN/k8NiaJCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qc0JMI1hB4nD7DaXzfwf+NqfnYZQ5iJ3Uz8Lj6XwBxqunRa2/ARK6VBTYQVLm/9latpDIXPofAkSsjvVyEa2r7+EmqFEjqeIq/v0LJSPguySZJO57Rmucfz0hjM8wITU0GyRtkaY97Hbt/AxcNIyXQtznORczxhwWP3KYxrfcu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DLmnvIl+; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-39c13fa05ebso1299708f8f.0
        for <bpf@vger.kernel.org>; Fri, 02 May 2025 11:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746209392; x=1746814192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rcCrLN/kccrQypKJkRdAp4NIqaNnzfTtnN/k8NiaJCU=;
        b=DLmnvIl+LICAIfoeTPj1/Ll6x/nQytRu8CcRsJRyhDviNHUGPl3e17YPMVbCkyS432
         OnYd6H7PapoajeN6l3t2k/zyDcOL2zaAnYW0imF4WOi5Q/4OqXEseNXsahVVziHqKUd4
         XVcVzVLqMRKAEdYypOx+mZ5hiytkzYTmy+ouKetZ97zgrA5bZ0dSORkfVzqOm2oau3gY
         LR7sBQ+j2hqABb++IyVy24lhSbhpchtpNnHpJSQh23SXij3ievkNDHpl5nDHXsYcBnuz
         WbJp7rhtNyrP3ta3StZ1yGjuGxuufQHuTT9rPeEn7PCev+e+c1xrvsBoG3NYO2XiG7uX
         BZ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746209392; x=1746814192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rcCrLN/kccrQypKJkRdAp4NIqaNnzfTtnN/k8NiaJCU=;
        b=jfoqpEqODkcnm/Cuz8/r8lsfWLieoOnQ4kKeWKb7aZ25UGYtg6mV3DFxXUadiA0OKp
         4nkcenfJxEj4ki4jzxFhEuq3EnTglcwooFK6Zh/AWsEXl7wsNUe2bzi2fjglwjj6iy4l
         BCrq5AStCEn+InQqVVlLWW3zlbP+GFRUf6nzNfXRZA225ABpLgqNpZ4pkeuU1aq4nO8D
         QOwljlI+MiWEcNmnmpBF4ILm510+HpmvT8t+x/hjNlgTvPkkjp479lJ6GKkg19fTMXcB
         AbZGPYTgIEn8SZNfdoZLpnsgHRDd9ZhDIdDKwG6ZtCkYnoqCPTND3KOhd6egzFN0ZYST
         XsEw==
X-Forwarded-Encrypted: i=1; AJvYcCUXNzioEE1LvVS1B6AsCzJLdGLqYkRqMX8VT5JiOhnmEirssBW7GRlmG8LWOPET47ntKpE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7uHOSW0ydjoZR/zxlfXBC6zmeSxe5awaqeCHe9GHfBlyaSBFx
	qMhUT8oD//2pNWVWNXkB+kyv+11yMfgQe2gcSwmOP8RQZEGh++z7A6FFgv/BrsvyowESGAqyXuV
	2bhC35lI+igiUm/r980nXCPEI8wA=
X-Gm-Gg: ASbGncuofWgYUw/wxslowDCfu6NmgjDvAzVMho/4BCUjgyNmIJfD19rugyOXUtOuHlA
	lWmohO6sdv2e3/v5dZEQxuI3SS0NFLpmKI00iw01uC3yTpb7n8ZuTVUYSkYK+GvX+JFdpNij29t
	Qleb9smOjOT3yeAEWYcFnLWLI6ST4WHI/TBpEvjA==
X-Google-Smtp-Source: AGHT+IERZpTPi48vK1COoBZDo40VpESY8BnwHPo9gotesMSWbuhX8X9OdFZ99aGxsszftm+FR4GnSBZuMDHku5xSeKo=
X-Received: by 2002:a05:6000:430d:b0:391:3f4f:a169 with SMTP id
 ffacd0b85a97d-3a099add0b7mr2977978f8f.32.1746209391676; Fri, 02 May 2025
 11:09:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501235231.1339822-1-andrii@kernel.org> <95dbb7e5-c2aa-4114-bdb9-9d9ea53653f0@oracle.com>
In-Reply-To: <95dbb7e5-c2aa-4114-bdb9-9d9ea53653f0@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 2 May 2025 11:09:40 -0700
X-Gm-Features: ATxdqUEUE8C9h8mdl0APuNkYe9fO_JFfLUhM53EtMS_hwWQdAov-S396h6WPzOU
Message-ID: <CAADnVQKmQKVTkf28Ex6T8Y03xDQ6-3o-rEcOM3vGZcVHGcrfSA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: improve BTF dedup handling of
 "identical" BTF types
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 2, 2025 at 2:32=E2=80=AFAM Alan Maguire <alan.maguire@oracle.co=
m> wrote:
>
> >
> > On the other hand, this seems to help to reduce duplication across many
> > kernel modules. In my local test, I had 639 kernel module built. Overal=
l
> > .BTF sections size goes down from 41MB bytes down to 5MB (!), which is
> > pretty impressive for such a straightforward piece of logic added. But
> > it would be nice to validate independently just in case my bash and
> > Python-fu is broken.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
> Looks great!
>
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
>
> Should have some numbers on the module size differences with this change
> by Monday, had to dash before my build completed.

I'm curious what BTF sizes you'll see.

Sounds like dwarf has more cases of "same type but different id"
than we expected.
So existing workarounds are working only because we have very
few modules that rely on proper dedup of kernel types.
Beyond array/struct/ptrs, I wonder, what else is there.

