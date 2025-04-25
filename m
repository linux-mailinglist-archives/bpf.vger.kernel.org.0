Return-Path: <bpf+bounces-56715-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5646CA9D069
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 20:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E3B21BA7070
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 18:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CFD217647;
	Fri, 25 Apr 2025 18:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VBUiw78/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6917B1F4165
	for <bpf@vger.kernel.org>; Fri, 25 Apr 2025 18:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745605280; cv=none; b=BzEI1I2vECDqt6QUsBOcXxVEBbkwhJAS0WmhFj5EnG2dtq9kPbIpOgN+xIR+xXpv0iiBIKym75nTQCpwhytkXiq6qa3YtsDmXEMNunE2KTaNhpX+131uSwpdHqEZCmUw9h4AthugXZ58RY3hYX5+wBpXxDwODQHSr8dmAVuxoDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745605280; c=relaxed/simple;
	bh=qDPwEsK9ZKQb+R/hseeTUR35CzkMGSp3FxZRkooeoAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dE+w9mKdOOUKcoOROGEDni4t18yL6beEE/ZH8RlMojOXHo0IKtiqiraBQrvA7ji5bomkGIjcifM9+hGivafO1hPjMAQL+4BMATN8rEKVmOmbQd5jW++xeFxJjdMYcTm5ZFvGb40orzLVB6jy11e3K37LhmKJaF/Is+TqPPsiE4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VBUiw78/; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22c3407a87aso41188295ad.3
        for <bpf@vger.kernel.org>; Fri, 25 Apr 2025 11:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745605276; x=1746210076; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LdQp6iQlSZRzay1FYj+3LBue/QXFNZMTuwlwQXqrklQ=;
        b=VBUiw78/ohygKiN/Pgv9XMIGvHSxRL1rsy1L38z82raRcIbhLnBfJwJ6Rk4L4t/Ev5
         8rhVW6t0cw2n7XN47MRl+SHoW2TqVnY+eZ/qKA/GRHFiwezxwWD0xjNf1QDvU6qv59dd
         psILrj4MWwUk7HPMLkGFroES0MtJIDEaBa/G+NqPjvwHTdtDF5xYIJrdUl3KL2QtNtLY
         g8HG+ipUl6Dch8KDRijAvcqbv6H36xCFfNmsWenzAyH30b+H+bRqPcUCOwNQpH7KC4Dm
         slN48AZUCOgyK28x1Y4T1Z/VnwU62+6j37hxguH1+nYuLBXGu+ifEinwyQJUvYZAe7kv
         CaLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745605276; x=1746210076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LdQp6iQlSZRzay1FYj+3LBue/QXFNZMTuwlwQXqrklQ=;
        b=CR2CwQUEWRNvGCTJQzW7yF3g2bfaxj3Q6CxbzmrnMFmKjfaHUx/PSYE5vslRqky22w
         JikxjrtNUchCKyBz2e0PKtltwS0whv6JiIn5JFv/I1xXMKYssY5rUlnlCF7A703DVGNr
         kuK8+9SfKZgZ425YHBWLlRZc7OERav3S/2mLBBq81hRRjeftSNqRGdB6AvUhoZKoQu0m
         q81igo1aZcn1mOT4c5K5pvtSAWzmqDYftNsRA+oT3PbgrNfWPWwj1mV9yMuMLc6CAo6U
         nvXbsHmpQCl0eWmPBsHkVxIKIxaw2ffY1za/YmT3ZccrpSlogs6ZDxyxasLifuJ0KYuP
         g9lg==
X-Gm-Message-State: AOJu0YyHd4BT8QjEIbIisBZ4awDzUMy3jPjBE80S0Cb2+TkpZR9UJYC2
	XZf8VN92mkuOEnzLzUx1IbFJc8nUpa9WWP/8HiPcGvTanKSrEtHi1oFBqp9Crnks6BOtuSg4j1J
	qn5fdkg2ETWoQn8+0I9ry1lli/z6Yq0oe
X-Gm-Gg: ASbGnctbsnTDVfFhBlMWyYS2UAjd5rdMGT/5e+INTdJd+4M8nOuz9LbPP2c4EoINAUN
	D9cxo2ycNO105e0wIwsfu4LWEkY1trz6nWq56Kch0vMTjcM8QiiND0Pax2wgYqHpehUoI+g1pJA
	UuA8GZloRgSIGNgjf1GM4rZfkZPAurO0Z3qKpfrA==
X-Google-Smtp-Source: AGHT+IF8NDRhf+IczUE0J+wWPZOddFzRt5l2e5uw9FklsXJTn2yLqwS9uG5yMvqmYEvKOF6Zax/rbVDFbbuvTWE8dfY=
X-Received: by 2002:a17:902:ef50:b0:22d:b2c9:7fd7 with SMTP id
 d9443c01a7336-22dbf5ef7fcmr51498775ad.21.1745605276608; Fri, 25 Apr 2025
 11:21:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250425125839.71346-1-mykyta.yatsenko5@gmail.com> <20250425125839.71346-4-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250425125839.71346-4-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 25 Apr 2025 11:21:03 -0700
X-Gm-Features: ATxdqUGUwtZrZK29K6lJqTyi6sAzRKBpzgSkEg-4lbxW7xsIM3nXaUp3Vke2L6I
Message-ID: <CAEf4BzYSvXJF5eSrzMFwxZ8-rVKU_3q7HCuLbcePXBDPz4ciHQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/4] selftests/bpf: introduce tests for dynptr
 copy kfuncs
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 5:59=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Introduce selftests verifying newly-added dynptr copy kfuncs.
> Covering contiguous and non-contiguous memory backed dynptrs.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  .../testing/selftests/bpf/prog_tests/dynptr.c |  13 ++
>  .../selftests/bpf/progs/dynptr_success.c      | 201 ++++++++++++++++++
>  2 files changed, 214 insertions(+)
>

Acked-by: Andrii Nakryiko <andrii@kernel.org>

[...]

