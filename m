Return-Path: <bpf+bounces-21873-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85373853A71
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 19:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B79F41C24566
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 18:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6509F1119A;
	Tue, 13 Feb 2024 18:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmi6ZzgN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5707111A1
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 18:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707850793; cv=none; b=pC9BHD7UbaPx4RNXCGsyeILjv4qGCRhCttE7D4mRyxsyy9myMDxbU3DKH9pwf68EDF4e5YXIlF+2FJPzxO4YqYQmhg390GvLCpVCFE31+yKB6t5BHBpUsKiB/WIJwcgX6FjKZTGPrNlYs1DzDJ764UkXuP0q5voed191Xy3guyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707850793; c=relaxed/simple;
	bh=0/Aqdcqg9JuEzv3KcYXBRg5N0ErkRT22BzFMk/QTgNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NKYm8evC9G5/BtGyW5ohCTJGOYtNXUPEjNVTgR2so+fV28GNy1ZHVy5fKEr1+KRAqrH3pVzBkD0XJMLo4mCx9wzhqiQkKH9rX5LCbKckbKQGt0yikCZL6FDr6ysLmLras/72UNPhcDJzpobTzQyEY8ousljsxeqoR1T3ZixsrQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kmi6ZzgN; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-296c58a11d0so3522790a91.3
        for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 10:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707850791; x=1708455591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SiO+JHWybyaguls1WRPwlpsCnoNRLWegHYy30h0iE9w=;
        b=kmi6ZzgN1I7QDM/JO75BH576zb5nEzKkZocVjqAZue7v0H0QovsGXE/Pb4/LgObdiT
         bnyNXF9yGMCXiHkurzMreFRnIge5OpbD5UvVwYu/pFz/xsjvyvPLB388X9kIFZiK+h4R
         68FSZUFvdEaxJgPiekw7GnP5u/tKE4XkKIISa7LuSdFW/RdsMkkLHChZg/PUaoINobLh
         2pgxoVrMJJPAy6HwCrzaNqd7qxAnkoqyhhZW1qxyQmZOKPUv5ogjLaxw3HNLOUk+ExSk
         PmKRru0mJvL9jfzA2rAnJYxPQQTG9I4YaipIGDuwXHE6EpC9EI2J1uLXc4bnaixJfvsZ
         1aew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707850791; x=1708455591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SiO+JHWybyaguls1WRPwlpsCnoNRLWegHYy30h0iE9w=;
        b=eDyMibcXVChry83Os6BC6dvX7gRG4WWjNy8fiMgqF/rG04/c+Nh/KkQWsi4uUiZkCX
         JL6dvPJNI4L2BwFFHnZBq7paBA/UUhPpxNIkIZE5JDYXfkshzscyQLRC+wzoGDgNj2np
         7RYgXfEvAtRZvRZx23TJGwIjdYDvduLOWS+5XH4OnJJIsUyIAW+mmJRtjdDFxDdrLhzE
         CnyeN4LN4wYry3HjwHo/Kd2DxOR9JnUoGCMztAF3nwI37n+2NhEACkwx9DEiT+PBE0pc
         j9DxuIAy5x7R5y6wDIBsXFha1eBo3bMgI/w1NmdE0CCQidwMZSqw5zGfGKuLTC+ezNQI
         F4Lw==
X-Forwarded-Encrypted: i=1; AJvYcCU3AyntjZeE+n/ihfIjDYoV6EH9k369K5h0ZFP5Z9AfMjrUsADuufW5+23FLrxO3xs9QfOl0OywzIboJ84oUMsOEtB8
X-Gm-Message-State: AOJu0YwxG+s7IwZM2NLz3tzGSAycJQjwbXqkscaw3pL8MppAE4sL1CW9
	G0+dPPMZOpM/1G3d6ViYY8EAb9jhJlHtaD8P8crX4r+xGxOVuIpdfuxnMjAGkxA/N3GyDcuqp1C
	iyJgmd16IO3QfkJ/tux+qdlxk0wSNmuII
X-Google-Smtp-Source: AGHT+IEnhbE1bX1i2B47uSUK3JgApOyXQ4xQT5rjldeicgjjTr4i0pA9ti4iHnlV2qPZy78hAufrKn4hnm34mYBMvh0=
X-Received: by 2002:a17:90b:390d:b0:297:224e:4a5a with SMTP id
 ob13-20020a17090b390d00b00297224e4a5amr399735pjb.16.1707850790914; Tue, 13
 Feb 2024 10:59:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212233221.2575350-1-andrii@kernel.org> <20240212233221.2575350-3-andrii@kernel.org>
 <e3b68a899b8ade18addd198d6f33dcbbed473c3c.camel@gmail.com>
 <CAEf4Bza5yWU0Tu18ZfPB_XJeAKx_iKyR=FCkSvWXE17vPa73DA@mail.gmail.com>
 <4950b053549136fbf852160aa64676e2003c4255.camel@gmail.com>
 <CAEf4Bzbs=1xJmJRinNPGG+Ug8k71060CnCp1psOWCqFdxOOKnA@mail.gmail.com> <95c085046a12449df88f0f668634878289bc4f5f.camel@gmail.com>
In-Reply-To: <95c085046a12449df88f0f668634878289bc4f5f.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 13 Feb 2024 10:59:38 -0800
Message-ID: <CAEf4BzZOWtdSWii=S=eRt2pQDSs+trMgDmhR+U+53Xbt8jiXxw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/4] bpf: handle bpf_user_pt_regs_t typedef
 explicitly for PTR_TO_CTX global arg
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 10:48=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Tue, 2024-02-13 at 10:12 -0800, Andrii Nakryiko wrote:
> [...]
>
> > Yeah, and then special case, for KPROBE that `struct
> > bpf_user_pt_regs_t` (not a typedef!) is also acceptable.
>
> Hm, I missed the point that for kporbes there is a need to accept both
> simultaneously (for the same running kernel):
>
>     typedef __whatever__ bpf_user_pt_regs_t;
>     struct bpf_user_pt_regs_t {};
>
> If this is the only such case, then I agree that special case is
> simplest to implement.

Yeah, it's backwards compatibility quirk which is important to preserve

