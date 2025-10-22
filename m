Return-Path: <bpf+bounces-71660-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 507B8BF9B51
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 04:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AE563B94E7
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 02:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8349B211472;
	Wed, 22 Oct 2025 02:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTgCsn4k"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFF12AE8D
	for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 02:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761099658; cv=none; b=dV9Lsq1VZJ62971KCD8G5VIWNVfGoBo9/G1c5TMRM5XOE70C0nyEQVmdrZfSp66a//cOojcvXyAMq+QEuV//lPr5Pna01+Bwkt9XTbKaPjFq+gcLfndAi9EeRA6ypHiYuHFS02+jIWrCx9X27Ru/8co0SPmdqELEXS/CbqY+fTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761099658; c=relaxed/simple;
	bh=9w1DUCmOfCZAHtJVXeOcZYre55yk+JeYJm86v3KWBZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dGOJxe62SuO5WxLx7EzSgXTDN9sRxIlQ7m7fXmEoQZknOVtk6GpD9sOWQz9upagRXT1Yqo/BeeirtJVnG9w7JP/Lat4HNH6LvnC4X/TsQdFwaT9l2tgVTCLPam/CVL0TBHicSfU73KTZln6r9NTvo/YFdMefGeckktF6TX3e91w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTgCsn4k; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46fcf9f63b6so35095785e9.2
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 19:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761099655; x=1761704455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9w1DUCmOfCZAHtJVXeOcZYre55yk+JeYJm86v3KWBZU=;
        b=jTgCsn4k7g9ENPzvULXZLDMnyMv9bhWQ9C9GRPq458wM2A+ueLSzSyMEpij2XRXIIb
         jQKmCe9//Imn+Jm3xX5CyQIrvZCCnTkThQOE0doPZK+fXghCLJDjeabIeD1AKvqe0be2
         5tuTV0Cca2NreevIDOYsxZPqSaQiM7axtTYqlCC44OI+0QDlAw/R4tP0t3eGplm7cCaP
         3awr5Lg3H0oo6LG0/PZO96lOWZk8O7bCyPGsyNVbKkN/6b6a/5wpDxqlPg64sWATG6ss
         QWjT9CwRF66COuKZgMAvSRazivDkDOGuUFeVuh05RdDif88JNGGAjd7hkngssQSLdwmN
         YG7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761099655; x=1761704455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9w1DUCmOfCZAHtJVXeOcZYre55yk+JeYJm86v3KWBZU=;
        b=nZg8dcKu5yzxHtKXUikVTjpaMlDl9Gn31/IvHhwJHf1ywxgnb+Y2y9sbepWXMAP/MG
         pZFzncqMDanKq7sJaujHfXS/5S2RAyyp4DPkX9CHrNkFoaOy4VDQb2N9s/QENWRhrrqy
         l2ebxhwoXCPtF7m6F1idEBFLQXeQVnSqLyRecNoZDS2QnrhYnDI7v+YtTYpi1iCrZ1r9
         sBM/GTUNoAAxXUIi+Q9V8z3QYt/xfSTt999C7++FlE+/Paf5xpJiOFJYyGksul71PNdx
         7+7AGXsR3f1q8A8MVOnz+NfXuuvu+ZjYsTz7iZaSdUKJSl/zjFoelF3tCecv+DwZBkQv
         kvrg==
X-Forwarded-Encrypted: i=1; AJvYcCW+/inU5LAN2X7YNpfqVUWbFuDGv4VipAhvBMR/cZlP/8OzktK6kU6YEET+rPsvbFB95IE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhyN9bXL1UPcjTFma8MM4Vn5F8kiE4w72ubM71TZiTvG/MSYJs
	rrfKPb2iVCAed2NB+IzQtzmT6Nj93SsgWsC9/UsvReeReIlnDTlaqszZanOmvmeLXmDHjINA6bu
	KzxH8Ki7j/2EVvHYxI+065rTrZDv6/aw=
X-Gm-Gg: ASbGncuJ+9zN0CeaLSi8WqVVRI+xyUE17FPIt74W2shIUdMqdBGmz/mvy2epAFHSeHW
	CIb2xzPPZMJzDeb7P+/0srKFk3BlK1yib7ytHNWNzdaVIgNu1kkXUObLct6NM28RzvqSJTBeJwX
	GPGKKdLkji2k4KsJsDLb3YlMl2m+3PrJ2u/4BQbCjzaaUZSrBr3kuq2bszifsajb97/4iFLA1TR
	RkudspNF57Hh5bX/st9mHK76N9mZ/FlmKb3F5nABfT0EA04SXuX9BwxqtF3ARLJ6IeqNBA=
X-Google-Smtp-Source: AGHT+IEHk93Zs+AUl+qe4b9DHkCdK9hbG8miPLlGO5hjCVqqEhbETnx2QS90Xo4P/AYO/ca+DkPcah4GGQOAYpxTMiA=
X-Received: by 2002:a05:6000:2507:b0:427:370:20a3 with SMTP id
 ffacd0b85a97d-42704d96174mr14537971f8f.38.1761099654621; Tue, 21 Oct 2025
 19:20:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <636d45a8-cdc4-46ce-b1cb-6d2e4e3226ae@hust.edu.cn>
 <CAADnVQLFuMAYHXXd_=2ebnhsE_tECKrVcLwuOt9b0dK4-Ww+gQ@mail.gmail.com> <034fed44-2640-4338-8f7a-89a4c9c4af6f@hust.edu.cn>
In-Reply-To: <034fed44-2640-4338-8f7a-89a4c9c4af6f@hust.edu.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 21 Oct 2025 19:20:43 -0700
X-Gm-Features: AS18NWCRKzw-MAOSGUrBjJpAgvxXDEBSqA57rOHGonvS9hNQuqs4Wv2slob_JtI
Message-ID: <CAADnVQJ4HeTzm+2DNSFG83HF01OxN98QLXZ_zUVThsMzSF6=CA@mail.gmail.com>
Subject: Re: Information Leakage via Type Confusion in bpf_snprintf_btf()
To: Yinhao Hu <dddddd@hust.edu.cn>
Cc: Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, dzm91@hust.edu.cn, 
	M202472210@hust.edu.cn, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 6:42=E2=80=AFPM Yinhao Hu <dddddd@hust.edu.cn> wrot=
e:
>
> Hi,
>
> Thank you for reviewing our report.
> We have verified the content in the report. Could you please point out
> which specific part caused confusion? We would be happy to provide
> additional details or clarification.

Do not top-post.

Am I talking to a person or an AI bot?

Did you read what you wrote: "programs with `CAP_SYS_ADMIN`
to leak kernel memory" and that made sense to you?

> On 10/22/25 2:08 AM, Alexei Starovoitov wrote:
> > On Sun, Oct 19, 2025 at 8:24=E2=80=AFPM Yinhao Hu <dddddd@hust.edu.cn> =
wrote:
> >>
> >> Our fuzzer tool discovered a type confusion vulnerability in the
> >> `bpf_snprintf_btf()` helper function within the Linux kernel's BPF
> >> subsystem. This vulnerability allows BPF programs with `CAP_SYS_ADMIN`
> >> to leak kernel memory by constructing fake `btf_ptr` structures with
> >> user-controlled addresses.
> >
> > Do you proofread what AI generates for you?
> > Please do. It's hard to take your reports seriously.
>
>

