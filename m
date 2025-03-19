Return-Path: <bpf+bounces-54381-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09899A69453
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 17:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8AF77A4672
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 16:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B321D61A5;
	Wed, 19 Mar 2025 16:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eisGPEEM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15271CB337;
	Wed, 19 Mar 2025 16:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742400413; cv=none; b=ZMLbzydh40dgqN97t/nitdhOndBZoDJL8VNLbOIUdvo9ThntgGjQWwXs2S/6EAy6AOHprCIJo57olbVd/O5jSdgehkZhwfOrH9Ds3S336HH0kD8TK6pKgDLUpWL5yNAN6kTNm+3oMdZneH+/RnEJCKfoZz0KyN2G1ZrvgCeJE8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742400413; c=relaxed/simple;
	bh=GIegq0oT6qB1JtJRey7NbwCdp+CUQJQWDDvFEpMnnUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ACff3LvgVucDRRqllsDFt8ZF5CCxCi+Xzh09eqER9uL+A9/U9mmR8iCv0gfUz15mDArT408UgcdDwMyMlULopeKD4ZtRU8JRiSyC53JjzHlBYNbR6EHN+vHPHTTBqREAqiG/2vAN2TjJBseYuAlLwq69rRNgNRadTY6qrgqdn5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eisGPEEM; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5499c5d9691so7523583e87.2;
        Wed, 19 Mar 2025 09:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742400410; x=1743005210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GIegq0oT6qB1JtJRey7NbwCdp+CUQJQWDDvFEpMnnUs=;
        b=eisGPEEMV3CypfbbqyfWUJ/2ly/FXL6QsoFEqckkgtm8sdIPUtasAHpkb9WvmZjQVl
         zf9x2kAx6tuDghtOInC8GgADMBGWPDFxWgHRaBy98XECNsbUwFrc5mcuPrOZgK4A6yG5
         rVRa0otoLfDDmVN7osxb7bCGBhUkI+6sE/63m2oFn6rnbNuFAmubW8M9aIWM5wG1cP+3
         yV/aBtARbQ7uiYEA9OqbeKUlcHmfLjVWzpFuK2y1cKXaXRapnDstPyMFfU0eQf2I3N1h
         LvvDzWZImpqBAkl1QstxNhZK7EZ7OsgXq87Vr9Cy8NKJ8uQNS/nN8OimUUa2iBPjeviF
         84VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742400410; x=1743005210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GIegq0oT6qB1JtJRey7NbwCdp+CUQJQWDDvFEpMnnUs=;
        b=qnEw7WsnLXsLYjAqbJFOOVuH/HXTVuy2PgKVsraGde9CI+BdaVdUqrKrSbqj99DSwi
         bnWxpSnb1Fop18FkDHkl0sfZsbk682vRCLp6ApaYLM7qdLvwT6lGx7dDZ4qYq9QMzBbI
         9YIqNV+zKSLxLF/IARQUzLQt4MRQhexDzk8vEKUcY3D+cs3QAUSSN3wf60r9IuD0WKnJ
         ODJwwBxH+geqzwHJ3O5c0eGQ7VOAe+8hVftmvnj7NO71IF5utw8tDt3Sbm7tkhGuBZ6N
         OckXF+Va6xYzTnMSHme5C9TUSePZUStLcOZS7IYbqfX7uZbK34WgGQzs4XkI9h8Cb+ov
         J34g==
X-Forwarded-Encrypted: i=1; AJvYcCUCAC/EzvItOV/v5R9L8zARj1Fod4jrNpLIZDjtwBfZAj9ua8UXabpXA0piNJmJQqxzeKAeb4/xjXOOzA==@vger.kernel.org, AJvYcCUlWuPv4drDk/fBkzxTwmvdiSCT8atjOMHDMN4TPwI3q5kok8TOQnBSs8JIFTIOKV3pkPU=@vger.kernel.org, AJvYcCWFMhC6J2XKof28CmebTggvnfUW+ytYph7bGIfSlO1p9I8xY7IcL8Nzn5QAemanJKOSQIZDmYJwp+cJGdX/@vger.kernel.org, AJvYcCX98xLW1LTGIme1Nd4RYrLfkKZcXLe9HGNwY+Ku12ypBPjUGkgyepN+o8IcvpATj65X7NFz4sv6@vger.kernel.org
X-Gm-Message-State: AOJu0Ywezc7I8bWteMn+fZY8U7JytK7nPYP/QbVxAohdamVSP4vzeavk
	F/RDNA3QV0zr5pfQ7hSx7hAIsphvNlFNWQzwLFciw/LLRhaJVAEPKOUuZdsc4Fh5yJegyAPW280
	pz0b/e0JCgrJWeiLk7nB6ocr4kOEfhqVM/YxC6Q==
X-Gm-Gg: ASbGncvyQHwUxyoagxtH2Q9RvAu4QXQzcuXnbWkKmhva44C6z2mHU+je8+1EPsBeJUv
	bG9KuczZ3n2sAOsuGpxrxe3xW6LD0BJl9iMLabaDMYzfTtJceiPqa8eY2qSjQwU3HUf+v7Zrkjf
	VxR/weiJUcgOy/V3J3r2a2ae4+7g==
X-Google-Smtp-Source: AGHT+IHmMFBxgWTdhY8PJN51uSi03KQFkFqruTJL/3AzgzUJ2KoIhJ4kJd2FL5HM00A/MVSkbE9sDGmCM2sChyyPNxA=
X-Received: by 2002:a05:6512:a90:b0:549:4a13:3a82 with SMTP id
 2adb3069b0e04-54acb1bf76fmr1334884e87.21.1742400409265; Wed, 19 Mar 2025
 09:06:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319133309.6fce6404@canb.auug.org.au> <CAADnVQKotSrp8CkVpFw-y800NJ_R7An-iw-twrQZaOdYUeRtqQ@mail.gmail.com>
 <CAP01T76CqOxzEiMLKJ2y_YD=qDgWq+Fq5Zy-fnKP4AAyS30Dwg@mail.gmail.com>
 <CAP01T77_qMiMmyeyizud=-sbBH5q1jvY_Jkj-QLZqM1zh0a2hg@mail.gmail.com>
 <CAP01T77St7cpkvJ7w+5d3Ji-ULdz04QhZDxQWdNSBX9W7vXJCw@mail.gmail.com> <CAADnVQ+8apdQtyvMO=SKXCE_HWpQEo3CaTUwd39ekYEj-D4TQA@mail.gmail.com>
In-Reply-To: <CAADnVQ+8apdQtyvMO=SKXCE_HWpQEo3CaTUwd39ekYEj-D4TQA@mail.gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Wed, 19 Mar 2025 17:06:37 +0100
X-Gm-Features: AQ5f1JqZYR9VPu0HjinWzHMC5L1Scq9q3VwTd7PzyM-8Rfg9zsp8PFtqKud26SI
Message-ID: <CAFULd4brsMuNX3-jJ44JyyRZqN1PO9FwJX7N3mvMwRzi8XYLag@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the bpf-next tree
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, bpf <bpf@vger.kernel.org>, 
	Networking <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 3:55=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Mar 19, 2025 at 7:36=E2=80=AFAM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > > >
> > > > I've sent a fix [0], but unfortunately I was unable to reproduce th=
e
> > > > problem with an LLVM >=3D 19 build, idk why. I will try with GCC >=
=3D 14
> > > > as the patches require to confirm, but based on the error I am 99%
> > > > sure it will fix the problem.
> > >
> > > Probably because __seg_gs has CC_HAS_NAMED_AS depends on CC_IS_GCC.
> > > Let me give it a go with GCC.
> > >
> >
> > Can confirm now that this fixes it, I just did a build with GCC 14
> > where Uros's __percpu checks kick in.
>
> Great. Thanks for checking and quick fix.
>
> btw clang supports it with __attribute__((address_space(256))),
> so CC_IS_GCC probably should be relaxed.

https://github.com/llvm/llvm-project/issues/93449

needs to be fixed first. Also, the feature has to be thoroughly tested
(preferably by someone having a deep knowledge of clang) before it is
enabled by default.

Thanks,
Uros.

