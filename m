Return-Path: <bpf+bounces-46315-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A70FB9E782E
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 19:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8321D168D3C
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 18:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB301D63C7;
	Fri,  6 Dec 2024 18:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQzgkOjU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F4B198837
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 18:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733510278; cv=none; b=mxP97v+HInBoC4qjY6rTxmtnJD/hLfdhyL2met/9jZhu4umtYT6jwwOa5pcQXQExQSC0XYZQKyphJw849Q3LaLY/MDco2gKes7l/ksjpY+pTkJ22woiy3yCXVnnPzmIFHsh8MHPrQlI8RRlugMdSU2D2scoKIc/5HxO19orLx0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733510278; c=relaxed/simple;
	bh=1oVYtCfU2EnZBVmEVJb3ASFGz6ScRPr0EBOGgz0Q+vw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qdKreDUGyHOBSvbT/5ZcSj4H26b2BbmTPphAnWu7NrIdOrCQ4/l9WG3TmDXCz/HpeuRKNGIi11E9t4VoO9A0DYrmaaBUPQ4GcdKV/Gph7qGilp/bWvDwQS/moHVR0zxTKDrdPg5LcQ+Z8TIPxJbu01UyC/0uljVMbUR82P+JkEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PQzgkOjU; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-385deda28b3so1849259f8f.0
        for <bpf@vger.kernel.org>; Fri, 06 Dec 2024 10:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733510276; x=1734115076; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1oVYtCfU2EnZBVmEVJb3ASFGz6ScRPr0EBOGgz0Q+vw=;
        b=PQzgkOjUhnn7eGamfYpmy6L7gSM9Pujnzs4S0IUhgJWhOu8+YR14TjVQHtJ24kP5hf
         kyWr1pShsJVi53ZnwqYMg9lT30b4JEaH64XOwDKONil//G8nHRbVdvlizin1EJrdL23c
         d3m9j/BmNS5a6+iWnJz0frQv5+G8go9x/UzLomHFnsHk/g+docSKQLyDzl9NGn/L+L3e
         5N0HHK/GuWEwJMbcorDWuOv+0bajwBAcvCdZq8QsK6OZkcB7sOrgD2zJxiVG0yPj/I2q
         hRxDyWQYoEt+/lEaN8iRxXh30gYpK31/Hd4sGbm7AKMZIwSwAPTdt2b3N/V2M74Wtxy5
         HQgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733510276; x=1734115076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1oVYtCfU2EnZBVmEVJb3ASFGz6ScRPr0EBOGgz0Q+vw=;
        b=HC98UkAXmWPzV+NVPv3A/8YpC4gmFKeAHw+G4LxnwfxGhuET5Wxsfs04ZVt7PWpVT5
         G0e65XdouDku22YhETB90gUb5mZMyQsxEZhcd7oN0roBiLT8t0VtLWR8Bdsbi1GghsLl
         94ZlzkGus09u/hVkkyyhoO0nTGvcDSEQCKQsCilosu93gjmm9ySsS547AsEPX02HQmVX
         0pMsbt/+WSm7ElUmKwauPTS+OSjewAtyYx0ZQwHEt7L8pIXP7PFUjqq208H1vaygIBZL
         vS3NnyKsFNvoWpos3//AtdTHy0N+2bm3l31flSnmBqxKzPo1Kn8X6o8lJu/splZr3xP8
         x9uw==
X-Forwarded-Encrypted: i=1; AJvYcCVLnbYFIXryGGWt3/HQNLLjmERPgkoTmE+xgv1GonDzJNOMeUvRTR4PJ7A0ZFXdC627xN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB4E0grzr4w8W7Gj3tVOvoEO61I96NmzylmRCquoK0pTtzCV/I
	GKB0igRQKpjDhUWb38CAkibkQuM6okG5qGoB9zx6BM1syew67o0jpLIItIPlXiyxrG6u96Eh+Pv
	DUcAT86oPPWUsJY7T2ZGm7O+It3M=
X-Gm-Gg: ASbGnct0Dsg27DrYWxkhy8JzjEIaP5Cyy8h7yXXBFkF6Ly4JFKdem2ncpeFSTFEj5eb
	AzmGIqN0P3O+VKNVxY7uZ39efZAcc2kZcpBv/pxVePoYA3vY=
X-Google-Smtp-Source: AGHT+IH/wUILAGUM9cBpL3FRDYcdsyupvoOnkYwLDOc1bjO6XwGKbijWCQhkorybXwC32SuUbBcU51qP+CZFXjiqjVg=
X-Received: by 2002:a5d:5f8f:0:b0:385:de67:228d with SMTP id
 ffacd0b85a97d-3862b36ccf8mr2597984f8f.21.1733510275727; Fri, 06 Dec 2024
 10:37:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206161053.809580-1-memxor@gmail.com> <20241206161053.809580-3-memxor@gmail.com>
 <CAADnVQ+_XGVsxYji3WYNj1-KhYZwKaFCgQ6aN=yFB3YWpRT78A@mail.gmail.com> <CAP01T75PQ3RENtQMD+JkB9DZcsUYp+AH6VJURGO730DkuLUMmA@mail.gmail.com>
In-Reply-To: <CAP01T75PQ3RENtQMD+JkB9DZcsUYp+AH6VJURGO730DkuLUMmA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 6 Dec 2024 10:37:43 -0800
Message-ID: <CAADnVQLrPWQe__jPWN3SPvJkOQc=7LxfesB74XH8Er052_wixA@mail.gmail.com>
Subject: Re: [PATCH bpf v3 2/3] bpf: Do not mark NULL-checked raw_tp arg as scalar
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, kkd@meta.com, 
	Manu Bretelle <chantra@meta.com>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 10:11=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
> > I think we need to revert the raw_tp masking hack and
> > go with denylist the way Jiri proposed:
> > https://lore.kernel.org/bpf/ZrIj9jkXqpKXRuS7@krava/

...

> Jiri, do you have the diff around for that attempt? Could you post a
> revert of the patches and then the diff you shared?

the link above.

