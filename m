Return-Path: <bpf+bounces-45432-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DED19D56B3
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 01:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D7A71F22AD8
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 00:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E508C1E;
	Fri, 22 Nov 2024 00:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tc1TXwct"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C114479C8
	for <bpf@vger.kernel.org>; Fri, 22 Nov 2024 00:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732235084; cv=none; b=tIN3TC7tqYZt5QwC4c5K3vWGbEtlx+HFX54mchAai2x3E/Wp6sf4s/FGh6jvB8C79VwqIPfpCzETZccUaWiZmiMaZYRTdLvRJG9f98/LQ9T8fOvl36oVchfeZ4AUCWbAyPemrs0/iifLEQ8X6HaMe+FdchZRRP7USp/6Rme1rh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732235084; c=relaxed/simple;
	bh=fhN21rdHz0xgIvCg8BX2yzj8sNmzAXFHP75K5WecszQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PIx1nZORIXksiZutFRx1Szuwrr+TMOJMC/VcKUUxdwAG7zYPBjtlQIMj0OAeQ/m8DdTs897IPdTZk3zvi7At3W2woLbTcnB/H3nEwtBcWRmHVstSf3UxLem2P+f/V8NhbTeOEB/gJ/CIb+NSPF4ZHOgl/iPrJtGgiP8ELxhVI54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tc1TXwct; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4316cce103dso17610995e9.3
        for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 16:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732235080; x=1732839880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhN21rdHz0xgIvCg8BX2yzj8sNmzAXFHP75K5WecszQ=;
        b=Tc1TXwctcl/+xAYtD+4DFkZAXUI4sL6pDpbb8GCGgxKYNWqZtI/uPeF2qCei4YJfG4
         /ShScMW3otFdfMhi/rm3nYrb+Yh3/A2iB9s9n9xG2t7d8opLZbRaPSGtjSXTZOgBau51
         W9GoPHu19ndSyhb9VM5GUqjP3j6Nbt+RC5+dGkv+YGf3hYO19YTEMBVjywwTa9/fsFUu
         Q5dxaYp0DWt8QBl10FBM5AsxGB/fG+IoVKOgHHHN00Km03FybxQZZn6G7m3tfIT9pyoY
         IEQoS1zxOlmr6+O55DWSJr2WfmwChFVjtmJ4fsrMEdLB851cKJbX7+bJg6o9AIuPdPmn
         Qytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732235080; x=1732839880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fhN21rdHz0xgIvCg8BX2yzj8sNmzAXFHP75K5WecszQ=;
        b=BIw3GrOk85nwA0Bzj7biiun4UpvcUhbanshCP6pFGZJQzGeVa6qfdb7Un8J/3ovBey
         X80A5tcE3bLVV56L6FtbeitEfLFntEtxlA1ym89GEqFM1ZhVKLdpStARpbRM00RvqNIW
         CEN7nzbCrJmPtMNq0uV/9REZJcy49kM6DAujO7AALtf1p4g1PDILYC91nYGhvHxzfEvj
         dqFB7Pwze7d6wm2zAWi7bw+i7Tp3g8iMKDttPa8iC5V5jZvK6MJ6nnueBfg66i3Tnmj7
         YmZwVwS28vhDjekJlHOgZNGTeeSBRo9SFK0oK+QSHbuVWLRziJ8yds42xJ1JBC3TODEr
         vjzQ==
X-Gm-Message-State: AOJu0YwDgow6WWUhVvyoSKE5Wt9KC2xJFW400k/jO0cUkf/B/X7gxbBe
	y7JYpHykPw3Ge9+/l2y3geNibp5l3+nT9K+Cg7fyN7TWyhvp6lKH2wiV4WXHpfyMhV5S43GUBMC
	o88LoQX87J/GsYVy/+CSGgc02EV0=
X-Gm-Gg: ASbGnct9aJAqsp+oKzQb7Wk+uzVq5+Aut3vEZn2g9F5/hBz8/GYjmVMzq1RB9/R+Udq
	iacyNBQLPICsLlDoK+4Ami4ov5v9FnA==
X-Google-Smtp-Source: AGHT+IGmXm27xFDdqCZdfi+6hEDy12OgLsRGIyaJ3LKmk3bvMb9fOyzypoZrOetQA6tDOeWDma/zigRRYkOpPRpNvqY=
X-Received: by 2002:a5d:6d8c:0:b0:382:51ae:755c with SMTP id
 ffacd0b85a97d-38260bc6d05mr1025759f8f.46.1732235079790; Thu, 21 Nov 2024
 16:24:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121005329.408873-1-memxor@gmail.com> <20241121005329.408873-2-memxor@gmail.com>
In-Reply-To: <20241121005329.408873-2-memxor@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 21 Nov 2024 16:24:28 -0800
Message-ID: <CAADnVQKr+5=3OnikYGjFU39Lcbox0HKFjaVeDGeF_UoULGh1gQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/7] bpf: Refactor and rename resource management
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, kkd@meta.com, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 4:53=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> With the commit f6b9a69a9e56 ("bpf: Refactor active lock management"),
> we have begun using the acquired_refs array to also store active lock
> metadata, as a way to consolidate and manage all kernel resources that
> the program may acquire.
>
> This is beginning to cause some confusion and duplication in existing
> code, where the terms references now both mean lock reference state and
> the references for acquired kernel object pointers. To clarify and
> improve the current state of affairs, as well as reduce code duplication,
> make the following changes:
>
> Rename bpf_reference_state to bpf_resource_state, and begin using
> resource as the umbrella term. This terminology matches what we use in
> check_resource_leak. Next, "reference" now only means RES_TYPE_PTR, and
> the usage and meaning is updated accordingly.


Sorry I don't like this renaming.
reference state is already understood as a set of resources that
were acquired.
Whether it's an object allocated by bpf_obj_new or any other
resource.
I think this patch has a net negative effect.
People familiar with the verifier already understand what
refsafe() or acquired_refs are for.
Calling them slightly different names adds confusion, not clarity.

pw-bot: cr

