Return-Path: <bpf+bounces-56030-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C42EAA8B416
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 10:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D8627ACC52
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 08:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB71230BD5;
	Wed, 16 Apr 2025 08:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZlxbFGR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF2C22FF5E
	for <bpf@vger.kernel.org>; Wed, 16 Apr 2025 08:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744792847; cv=none; b=Q0PIjxoCuPQVSHqFcI7hXX7TrOtn7c4QN8VhPlcgXhUUAaHc30Q44LQD0LOs94U47zehMmoB4vd0HMD98ubF8Mu6ZVk5FieiYvUGBuhiA9jN2WChE4o4vQpF7NiinSZ8eWFB7HMiFyllX9YHo91KsXdONa5Z/Ms//2X4z4OmBdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744792847; c=relaxed/simple;
	bh=x49N2l6KcRx5oKgc/t5mJvumTQ5ZoK46iSO08fpthKo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ju6FtZrp+S9OcoTmwS0SjSepA49t2ebk1YVBCxCLXcrl08myEVK/T1tC4KV0TDaHurS6SWQZKSIUaaRB/5rLlP1GKMGf+dUr+YK8ZCHZB8dLD7XWrbK3sc8P+QfZnNeQVYYQDmFS7RjHRiVWy/88DntN+JuaqS9U1TWxNqmUBw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZlxbFGR; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-223f4c06e9fso4526875ad.1
        for <bpf@vger.kernel.org>; Wed, 16 Apr 2025 01:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744792844; x=1745397644; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fCb5fR9cGCSS15aDPSQ3HEExjTi4M/8vsGecCaOoIxY=;
        b=PZlxbFGR3UmZNTccrUVtdQFDFNxikqv7fNnD7SeJYJjX9v6jkaMEFAeVzaMWQYRjfs
         sWt8oOg4HbzCFjePEg4QhbYCqBoJTKYExrA2bPZdZqnZKRW832KnZlOtXXeZTuslQ80i
         NFIUvqic7ykXjs6rSxXgVxHmhV7aqHgebjq4InE4MsKFE0cj+9T8CamvLd1rcfATukGN
         mhMhddIdQD2VaaAIrYCPV/61Wyf/RO/se5lt1ypUV6l/K3g9vCn2fVRs+ygMR1klhzKa
         ZTRaOz4nq8hiMZ4AjCIpMWJ4ZmmOmb3hiiEtKhvDzolnFQB8BHXtTw30fmBzOk/tPEaM
         rpVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744792844; x=1745397644;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fCb5fR9cGCSS15aDPSQ3HEExjTi4M/8vsGecCaOoIxY=;
        b=M3+YfT8KoksHsoDjFMFTRRSv0E+g0GBrr1f8X8pDvWOz8lJytHtim8hHB/uHzWm88F
         CGOULi2jjExME/QRDMp853UIFCR3SHF0916BD94YSE7g32aWQP13v8zwtGmA8hqC38p0
         2MuxRg6E3J5McVjeHd+rBKlwv+0IWaCeYV+1+YOskiF9xRCafKSoPjOleM0+/EKxL9cl
         lSwgYzUGHP9qbnkK7WGsdP0iJmyJibmqjF428vYj2d8P6fkGN5fvZ3B/BsfQo1dvWsvq
         E+TdgTIrvbh6INLxAhJYLBEENo6pzKPZm2cjvJMd4WBAB3PGfx6377Msr9mydsOBx//S
         Q4ww==
X-Gm-Message-State: AOJu0YzUuVrCplkYu2JbA4EO5GlADdvA+axMpsZMGVj5LUepphlLYw94
	5LPBSGHbFcpo38JU8xYkUBoRDQR1oVA9cf1RCurLS9KnKJRtvwFf
X-Gm-Gg: ASbGnctumUDY1U9hK4emfBOpusjd7phW+vSNYuVfy97918jt8UcRroztd7h+ijLWf0P
	iA4BaaA9x+wnil+BLbXWrm7is6ejY1xBmFtIZeJAeCICECJXVrlOyJY+NQDyFqPgtT4Q2tZvVSa
	efT0qHy+z5mSX+c1RQpziERoDRFZVoq60sqT2hCb3t2q6uGtmBikXOt4Mu6UgCU6H/D2Pyq6X/u
	OET7r7/kQrX/AzIVCEVheaZsZbct1cmNZgKontbeHOCGjvS+PP33Ls6kcsDSee/UlwqTnErlFN/
	cxe9OjaJ3G4f+L4liHxtdl7G6faIPOkhZg==
X-Google-Smtp-Source: AGHT+IFOP9zr05L6vxPaYSdJsm4F9jTvGi72jY86tLFZStAxFyLcqqnEEml2sn1fdxyh1V3zLCCLMA==
X-Received: by 2002:a17:903:2286:b0:215:6c5f:d142 with SMTP id d9443c01a7336-22c35def229mr14544495ad.20.1744792844394;
        Wed, 16 Apr 2025 01:40:44 -0700 (PDT)
Received: from honey-badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33f1cd87sm8626795ad.73.2025.04.16.01.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 01:40:44 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,  Alexei Starovoitov <ast@kernel.org>,  Andrii
 Nakryiko <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
  Martin KaFai Lau <martin.lau@kernel.org>,  Emil Tsalapatis
 <emil@etsalapatis.com>,  Barret Rhoden <brho@google.com>,  kkd@meta.com,
  kernel-team@meta.com
Subject: Re: [RFC PATCH bpf-next/net v1 04/13] selftests/bpf: Add tests for
 dynptr source object interaction
In-Reply-To: <20250414161443.1146103-5-memxor@gmail.com> (Kumar Kartikeya
	Dwivedi's message of "Mon, 14 Apr 2025 09:14:34 -0700")
References: <20250414161443.1146103-1-memxor@gmail.com>
	<20250414161443.1146103-5-memxor@gmail.com>
Date: Wed, 16 Apr 2025 01:40:40 -0700
Message-ID: <87a58g1otz.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:

> Add a few tests to capture source object relationship with dynptr and
> their slices and ensure invalidation of everything works correctly.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

It would be great to have a bit more test cases here,
following your nice diagram from patch #1:

		  +-- orig  dptr (ref=1) --> slice 1 (ref=1)
 source (ref=1) --|-- clone dptr (ref=1) --> slice 2 (ref=1)
		  +-- clone dptr (ref=1) --> slice 3 (ref=1)

In one test (probably extending the one in this patch):
- check that both orig and clone slices can be read at some point
- destroy orig or clone and check that one of the slices can
  be read, while another can't.

In another test:
- destroy source and check that both orig and clone slices
  are no longer accessible.

Also, is it possible to conjure a test case with two hierarchies?
E.g. source1(ref=1) and source2(ref=2)?

[...]

