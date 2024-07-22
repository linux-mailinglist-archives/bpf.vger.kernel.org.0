Return-Path: <bpf+bounces-35290-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1C7939728
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 01:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E97191F222C6
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 23:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D664C61FD7;
	Mon, 22 Jul 2024 23:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNcE6kkg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53C617BCD
	for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 23:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721692423; cv=none; b=jUQdb34s4BtabxOIqc78X1wWTjUg30FsaVu35sS4/Tgly5o/EzD6DxZNPV2EpgbrtejTvMxNWBvcU+LzCwrg0ZZlevvNjhuULIGCzmim606RfLK0RXl5IpXCNBuK9Itr5FvAg7GdJUQsBYTMr7j6OIn5QzGLoCiQmjCeDsHvem4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721692423; c=relaxed/simple;
	bh=XcFYIGPOc8eeI+9HeqP4B8rGs5MW3eKu788CbDz2ahI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SB5tAnBZHzYp1r40kzZqefAqmJvKmneGVR//IlM/SXtZptCeypP9506teeUrLExh2Mv6AOGKPl65iccIialhLV50Y6Yt/BCbg3Mf+nj2nP6Bwcs8nw5k1enW2HyiaFuWSDvYbQktKX06m55luf96WewbTWOiFI8cXicNGu6FNrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WNcE6kkg; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-369c609d0c7so2105703f8f.3
        for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 16:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721692420; x=1722297220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XcFYIGPOc8eeI+9HeqP4B8rGs5MW3eKu788CbDz2ahI=;
        b=WNcE6kkg4yXUa5XvkeuyAPaaLOJaqmXvl4b7h/I0j7EYuE4jRLU0VG4Qkbk1eyiwHp
         TWcmya2a1rni/xk/0/IJsneURkzJSM2jatn2IyoTfD7iDlRZu9S3TkTfLuKTUrqqGRbC
         nMsehmIpqw4sBPl+A2e7tPIAVyqOpZiry0z2kVibjFJX2Bx2+46E0skTFSXlyqZWyDfJ
         44PhToCJBY317maWP8rAXOP1StgF634bt0dxZ6aOPr1MsdTtW6qPZxbceywY5FaymR1I
         vdS8J3TOfcvIxY877w0sPR/IAjqvY1Z9tbO+jdxWnP7Nh64q8wQLr/AoaisbEj4Emd8l
         RLRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721692420; x=1722297220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XcFYIGPOc8eeI+9HeqP4B8rGs5MW3eKu788CbDz2ahI=;
        b=wKMS8Tl6XTtrSnabPxZACTJNcLfIs6a8SH5YBF7iF1RomvJcnMXKbq/MXGr30zhyhC
         hR24JKax48uHiHtzQraHwfyRnhoEXp82Y174DCY39h14F5W0Bvr+E3rApc42S8nTs8og
         jgYmkB4JvNt0V+Zb02v+ul2kAK6fiSCsdCualgLL2wNRyNC0+jtNmyH7Sv5iocq2G1tm
         WjLDRR6tMuvJ4pBR8jGqYW+Nz6Hqj9yYWg6IeuaC3kDU4hxl8UjLp+HlCpctoHyE8Z5h
         vHxRDONzBz2SZhsgZbvRra3llkHdaxN3ZCVz0LAW8OQLvnSQ6DeqDBz5DZsIj9cH7dE2
         kQiw==
X-Gm-Message-State: AOJu0Yz3r2wOe62dVz/4FMh165D/Nqo6i+vzUbwfcT3gCGUbU7N94qF9
	GSQK7MFNbg8t/bl1Siz+wab+JL3B6BPj8J6lMuOqvDA+CMojS2ZsEGt00lbv22rt9QF0AQhbVfV
	imqj712vhX5c7GXrZd2RjGFmah9k=
X-Google-Smtp-Source: AGHT+IGU/pbse9kICvTCJthMyW4D1+IW9iDVvpl7PORMM09tZRANk3fZ1qN/1iD9TtQgtPQYC1fZXbIJAe0GuahqDDA=
X-Received: by 2002:a5d:6d0a:0:b0:368:7943:8b1f with SMTP id
 ffacd0b85a97d-369bb2b3bd5mr7101859f8f.43.1721692420067; Mon, 22 Jul 2024
 16:53:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240602122421.50892-1-hffilwlqm@gmail.com> <20240602122421.50892-2-hffilwlqm@gmail.com>
 <172a5daf-8a3b-44d1-8719-301a6e8d196a@gmail.com>
In-Reply-To: <172a5daf-8a3b-44d1-8719-301a6e8d196a@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 22 Jul 2024 16:53:28 -0700
Message-ID: <CAADnVQKac5ALSF3EkUwvdvVj7JceiPXGE_5p_aCSXwng1Wcj8w@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 1/2] bpf: Fix updating attached freplace to
 PROG_ARRAY map
To: Leon Hwang <hffilwlqm@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 7:43=E2=80=AFAM Leon Hwang <hffilwlqm@gmail.com> wr=
ote:
>
>
> Hi,
>
> If no better idea to discuss, I'll respin the PATCH.
>
> And then, I'm planning to fix another tailcall issue caused by
> 1c123c567fb1 ("bpf: Resolve fext program type when checking map
> compatibility"), which is able to produce panic:

Pls go ahead. Don't delay.

