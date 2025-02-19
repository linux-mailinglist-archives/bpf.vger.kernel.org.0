Return-Path: <bpf+bounces-51998-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DF4A3CC2A
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 23:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C732017481E
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 22:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04FE1CAA68;
	Wed, 19 Feb 2025 22:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LVmYhgU4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C3B286280
	for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 22:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740003427; cv=none; b=EQZChxznzNBsvMa+erfpQJ3q0cz8DgoSIvLMovLNY4OHdxwu8L3dZ8vrqVYTzgU7SKeoKd1MgPltsFeyhbjWeVcT/9NVy9Y0QsOSFjt8RiVDmg+2+a0TYmxKXdPIXFSHaQPjQasxYM1a3B9E+f6gNV2ApBZqCVRwrLOXlfmYJpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740003427; c=relaxed/simple;
	bh=NTym6u2Y0dxRJ7bcuVVcMlXTapfPORlFjAZy6LBIVe8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KLJArQcuDe2nIKVEPxEsaXObJ/RsIVUwLaRgRdM4klkXcf9gz9R8pGZX3xVKwYzNY1W9vQyu65bPkEdAxK605rL+XjcieyRs9aZCepStt7E0EqGJIV0rZWMZxqcnRIOunt3tcgUB80mtQkLDlX0/QXMNiJH46z5u//eI3zfU2J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LVmYhgU4; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43998deed24so2281505e9.2
        for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 14:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740003424; x=1740608224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NTym6u2Y0dxRJ7bcuVVcMlXTapfPORlFjAZy6LBIVe8=;
        b=LVmYhgU405quy1nPjRl17WWefOoNMODF6iICA4f7tyOlUl2uG/VQAqR9LpjCILyRox
         BbfNpmNSBfoNlrFQ2chbt+YYVw7jWiUnFu5zkpg2gmKVJAx5W6t15BQQKAUZECTuiXwR
         fnaZim8f5oAGB8MQMxn2rmlfOzBwdnPPfV1ayzHUVFDU6UO663yYUcaPycio7l/t/6kx
         iS2doYik1kQ747oV0AjWJf+jkOcRtRgKXhYRiVVOw/WTx86ewZiNHV2rBbuYm6HD/B0r
         PDscFMUlicFeKEci+WXv3rJmcglPJAx0oKPu+cCR4EPSkbb7rIPd1tdxct9Dja9CqSei
         Qc0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740003424; x=1740608224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NTym6u2Y0dxRJ7bcuVVcMlXTapfPORlFjAZy6LBIVe8=;
        b=DKG12Pdr9ohkRReFO14AYJxeZ83OsLaJ21dAx2/ibt9DQ4blBUV/v4of7sB1xplnmQ
         S1IFi6tnQcrvR7GxDtn4t+JYjfyvSVNN4VF+Fi4sAEgPcElexgTGPudHJQBI+tb0svNN
         FBXnmsuYBNwZeVxqP/krlbFm6gFzteXkY3G/30fAYq0bs9rLnk7KtWoS5+YcKbzxC5XC
         iognFk+hW7XOUyrmLKpsUXfDiXrOpexdpXTcC4a2xj55UmuRBn7myjJdorsOlFc20XN+
         mLSukcowu/+NuitwEOIY8afuwH1c7hZepEiMGEKbTuymeY41si8f7gjsP9nPDcZPMqlA
         MDRQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1Klg2fEgA3hrlIeH1TtZkxuJKKIBc+Mh9SxJNMJk+wJxjpX8uK4HKSsu3KCv+6FesLv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYVdoCL6SpB/G42T6kUguQnzUEaj5HYx68pcV1FEIpzCclHG9K
	0d+eepKHfLK9JtU+ve+5IpNsq4DIo8nUUA/z1UzhGRdjVdMyIje1Wibfa6Kgu1MbwF9RDC5uTY5
	wEhETr0wqLXU/iRA29n40r8PiZY8=
X-Gm-Gg: ASbGnct2Xy2S/tQtNn0i7mJXoW6EnhUB5PICod1aFZGER8q1JlVRkrulsWLe40eKSlk
	LsLLe520BoLUbShW1isqPm0zVN/ZBbqI6IBhvKmHnE2M6sXUBCnwD1bdRdV+GLJAqz7Lkm6XZiC
	nZefpREKfTJ4zqR4ThTNR+oDg5cD7c
X-Google-Smtp-Source: AGHT+IH5XhysPuDS2tpnyojz/Pd9HzGWsvqd+Y6kEfq2mGSHaaOvzgg6JAR/B2QqMh1gOEmkZbpKRKPGAsIDlhVDQU0=
X-Received: by 2002:a05:600c:1c9e:b0:439:88bb:d013 with SMTP id
 5b1f17b1804b1-43988bbd395mr125732545e9.7.1740003423777; Wed, 19 Feb 2025
 14:17:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219125117.1956939-1-memxor@gmail.com> <20250219125117.1956939-2-memxor@gmail.com>
 <CAP01T76aV+2Y-U79Csf4+-scG92jc2ZwJUhDC1MQcx1ZJ4vwkw@mail.gmail.com> <c947f2bc7348c62810e398f9a8322abf5ae27ac6.camel@gmail.com>
In-Reply-To: <c947f2bc7348c62810e398f9a8322abf5ae27ac6.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 19 Feb 2025 14:16:52 -0800
X-Gm-Features: AWEUYZlWzj9hwPE-pRG4BBy3Vutei3LksNUPJdhGxnD_Ae9gadEFz3_izyuM91M
Message-ID: <CAADnVQ+Zr_5--xH-6QV7Odp1bCT-p0091YwCzh4hO2HWjOv=dg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v1 1/2] bpf: Explore PTR_TO_STACK as R0 for bpf_dynptr_slice_rdwr
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, kkd@meta.com, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 1:20=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2025-02-19 at 13:56 +0100, Kumar Kartikeya Dwivedi wrote:
>
> [...]
>
> > It also leads to veristat regression (+80-100% in states) in two selfte=
sts.
> >
> > We probably want to avoid doing push_stack due to the states increase,
> > and instead mark the stack slot instead whenever the returned
> > PTR_TO_MEM is used for writing, but we'll have to keep remarking
> > whenever writes happen, so it requires stashing some stack slot state
> > in the register.
> > The other option is invalidating the returned PTR_TO_MEM when the
> > buffer on the stack is written to (i.e. the stack location gets
> > reused).
>
> Would it be wrong, to always consider r0 to be a pointer to stack if
> buffer is provided? It's like modelling the PTR_TO_MEM with some
> additional precision.
>
> Otherwise, I think push_stack() is fine, as it keeps implementation simpl=
e.

Discussed plenty of options offline with Kumar.
The next step is to experiment returning PTR_TO_STACK with mem_size.

