Return-Path: <bpf+bounces-21903-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 092B9853E9F
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 23:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 983AA1F28277
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 22:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7216627F5;
	Tue, 13 Feb 2024 22:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOU0yir5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD94A626CD
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 22:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707863344; cv=none; b=EcUVyrPkoEuXPINph4emo+2FMHeGSCAACO6XN2Z5tBG/546P6od+d8X/eNcF40N66+q5zN0YXjMGqOdvoCR6P9Zl9x9qXyryb6ahWZbz/J7+FP9rrPJ5I/6HaX4sL5njwad4EZtoXlwgPDdj2+3ot4ifxfuEXl4UzbBPv7kHufE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707863344; c=relaxed/simple;
	bh=nP/IQGQAjE2d52/gQM8i8UGtqFYQlEtaIIrM6eiboVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RjLxEVrZE8LaCFH+mf5HUmlTrbWfVvLg4T4l01gYXKVvvVWNkPwUKLVpi2b5XuZ9+/ZypZVIwNfqQTi+zvLZyPp9wQeWRdERVqcBbNg4wlE6b/5eDqleXYg+AeFeLoudtWFYI1d2dfJNbyJNgFTs2bPmj9l9Yfr9WBlO9KT+lTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QOU0yir5; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33b18099411so2833323f8f.0
        for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 14:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707863341; x=1708468141; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q27x056zBoPvuVX+ohul+xPYgSSVDtsic42J3hrVKy0=;
        b=QOU0yir59ssgct7n2g91hzMJsD7nInrIGnqNnOcIJqNelejWtKB4OLqzTZmVYm8Y7p
         9BtGQW8UvsqJlJV6ypECcMkij33sKSPR6+ntKnG/Levdp7NkYWloZBnH3suOOy1VrhAY
         qyU0gXr65ZuaSfnUTFD/W1NZZYXIEID0CEsWL77PaMaZbakWmmqRNJL5gWFSkJdmXX1C
         jgsxCkzqmldYotCLoEsf8xuUV0wy7Az0HbKMqbiwITK3hwIPl1tWmAjTJgGYNkKJ9IB4
         4IKCoaCXvRIaaYc8knmZ69RMPfSZm4tlNe1/kRWnn8AdfGYQzNiWVto73l1NBN9oglMA
         KxXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707863341; x=1708468141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q27x056zBoPvuVX+ohul+xPYgSSVDtsic42J3hrVKy0=;
        b=NvOLHKcxCBWz77u6XiofVDXExYVqYDU+T7/S/pTsKRE602mpE3ZA8Pl/z7oy7l/nW7
         s/oRQBt5f1gh9lRqHzdsERgmOxTL2yGNAeDj1pEx/HhYxi4w+2M142yZMZQ2Y9OwrNLQ
         swh7uUZ7AahV9NXKTIzy8ARpI8mY0nCw1aBGYAqJab8qAkwivjVf/+HXjwqhaVlk2CO/
         K+0iYN11yKNEmAgQMsqgADrqi3IHzK5+6O9HPn0sHOD/GXc31Ll4sLRB6JcJth7CpcvC
         USu6M14M1gPzGKhWLFueXRDl/1Lh9icKFYPSvBWMPvzn2WgqoAABIIlCzsyEYi4l3xxd
         k6gQ==
X-Gm-Message-State: AOJu0YxIvXct5vU8GY5tzfJs9GNqG3Vw7f5HUe4Jh7BOOCZxeSLzHBvU
	qcS0kZh5Sf1bS7LYKxCeipI2DZhxIINw6XTiOuGa4KYYe+iatczk3VPJFnbDYX+RfLY4WWAJej8
	8Oeq2/TsiY73T6v9rF/grXfZoBT0=
X-Google-Smtp-Source: AGHT+IF1A/OBCIbPFfxClyz67B2Psv3gbkW9pB1saS0tPR1/scKRn5/qo2cStLULYg8kjpiTSkOO9MmeQF+JbEdSkro=
X-Received: by 2002:a5d:4986:0:b0:337:8f98:8ab4 with SMTP id
 r6-20020a5d4986000000b003378f988ab4mr386149wrq.37.1707863340960; Tue, 13 Feb
 2024 14:29:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
 <20240209040608.98927-9-alexei.starovoitov@gmail.com> <CAP01T76JMbnS3PSpontzWmtSZ9cs97yO772R8zpWH-eHXviLSA@mail.gmail.com>
In-Reply-To: <CAP01T76JMbnS3PSpontzWmtSZ9cs97yO772R8zpWH-eHXviLSA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 13 Feb 2024 14:28:49 -0800
Message-ID: <CAADnVQJXJC4VLP5A-3dVNyULECs-fjUiaqMZ=AMOyGuxgNO6Wg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 08/20] bpf: Add x86-64 JIT support for
 bpf_cast_user instruction.
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eddy Z <eddyz87@gmail.com>, Tejun Heo <tj@kernel.org>, 
	Barret Rhoden <brho@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>, linux-mm <linux-mm@kvack.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 10, 2024 at 12:40=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Fri, 9 Feb 2024 at 05:06, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > LLVM generates bpf_cast_kern and bpf_cast_user instructions while trans=
lating
> > pointers with __attribute__((address_space(1))).
> >
> > rX =3D cast_kern(rY) is processed by the verifier and converted to
> > normal 32-bit move: wX =3D wY
> >
> > bpf_cast_user has to be converted by JIT.
> >
> > rX =3D cast_user(rY) is
> >
> > aux_reg =3D upper_32_bits of arena->user_vm_start
> > aux_reg <<=3D 32
> > wX =3D wY // clear upper 32 bits of dst register
> > if (wX) // if not zero add upper bits of user_vm_start
> >   wX |=3D aux_reg
> >
>
> Would this be ok if the rY is somehow aligned at the 4GB boundary, and
> the lower 32-bits end up being zero.
> Then this transformation would confuse it with the NULL case, right?

yes. it will. I tried to fix it by reserving a zero page,
but the end result was bad. See discussion with Barret.
So we decided to drop this idea.
Might come back to it eventually.
Also, I was thinking of doing
if (rX) instead of if (wX) to mitigate a bit,
but that is probably wrong too.
The best is to mitigate this inside bpf program by never returning lo32 zer=
o
from bpf_alloc() function.
In general with the latest llvm we see close to zero cast_user
when bpf prog is not mixing (void *) with (void __arena *) casts,
so it shouldn't be an issue in practice with patches as-is.

