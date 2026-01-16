Return-Path: <bpf+bounces-79165-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FDBD295BC
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 01:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C742A3095666
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 00:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E709182D0;
	Fri, 16 Jan 2026 00:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVLnGMSk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8F44A33
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 00:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768521715; cv=none; b=iD20hDV3/JRvg8ZQsnqt+YsXSNmbl6TWQhFa7rdCvBf147wb5zOOHYC6JlOox5U0I8YcbbJSKDY8UHXb3Dp598nqPAB+ckMPqo42W9Y5qIJrcfM4rAwHWXoTfTSrfkJzRuOXlbUU4mi4Lf38FUeX06HAfxcEIzekCSaU8euBYRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768521715; c=relaxed/simple;
	bh=RBHd85gTgMlOXzW8Emf4jIFY5yTFoU0FHpK6Lpeu8fo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X0SB9PUuaM1R3jbzHucc2JX+ykT7LJaecwUtG/NQDOEcqaVNgOLRysnGC2TNeBnhBTA7VllFGI2oUTEBmUovr3epgjOwbW4gV3edIUT4mEvs8p1WfIpW5S/zhAo11mPLRkiHkXqfQBmXq8j9pXPk2tODH+3FSDmha0M0Japay5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hVLnGMSk; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-81f3d6990d6so848317b3a.3
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 16:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768521714; x=1769126514; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yAyzR2eIOc+lY7Rf7i/Pm0Hu72g1HVBOoPuAS26txlw=;
        b=hVLnGMSk0TLVey1SoQdYyZIJq7KN46fkSIkNagH2TcB8y4jWgNZGkmmg8tDQ8DtBTn
         OtPx+2JS0gT+DMK8sA0HDJ1T6YOxJYISaN1pFX6XpSAB298J19w3Jq2zrFDkK8hyXiRE
         5M7H12KVkyL1P1sb7z0ZoirxtOK/Mfxd7B/brygkW2NRU2Gw/iU4wvfKnh5QILE/jumR
         t5RJ9bTzdHiOAADnjTBuK34fblYYICXFn11ilnv39a/8pV25FVOau+UjOWDHbTkIsKmD
         o0UjxgGaLlzOaQCQQ4CTg6RZCvbiLkwcMVYU0oApPFRvDyHr7GeYY57pER6/U9LKdvGF
         Rx5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768521714; x=1769126514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yAyzR2eIOc+lY7Rf7i/Pm0Hu72g1HVBOoPuAS26txlw=;
        b=J3/iXySDyV/6YxFrOv8Imm6yfEN4lbDMyi15YmxUr0p1ij9M1kfoLG7yv4zWLwinI6
         cPYbKH+rG44cxQr43vCA8rHla05ZxB49josSWIU9AZtid+myUZHbKrtH+w7T8eEFgI4m
         qE+c6ymj1sRXUfAff4NuEkBmRsugckmyNKrggGIWf3DLc2Qv6yNOxhLzqINCUkbbYF0n
         CwquWwHsReWOtCqp6rc+iKK4PdLJBAsWfp5rxByyRup7WaX9InHElAcytbhJJPeFGto2
         3yisNsfe3mE3sK2/5D2IK9ZlX+EFQy9tZi4/SmVRnZvR/9+/qDa0hteDgTqUC8S2vPM4
         k+tw==
X-Gm-Message-State: AOJu0YxZ2cyOEbPBW/55gWEoruSxUgddM8AFqtetsKfs+PS7eDxnONmm
	XkZmZTX1uInQYWntYlIxn4QPTGhC5BHsMnhkYXOBwPS8Nc5N7ezmpYGhemH4pQ5CnBHuEUOyONz
	vz65znNmv2N4ZxgIqCVAlR3QU47i+TMY=
X-Gm-Gg: AY/fxX4rh1znz0H4RGO/x/OaVvtm8I9U/Q/g4Gkfcd/k1XN5lyFylS2kv/jc2rb8oab
	olAnt62RsL3lgfU8mQGdHXJ2rwOFX2SiOBM0tZCkiictZW216cEFkM8PEFMCs2Fx+s5LObuZQjl
	Wimg0L7eH7IN/UyNz4GOdUlp7OQgmb7S2PnxoIPsDeMY935eYC3j2unT4e/rv10FE3AJAExPUeX
	8PL1StC4plbo9z07Ru7zmLtO58RIG2i7F5DOxa+Ak0PLh5pUXBNtumwAqsQKqsInx8eSxlUjAzg
	3wUF0759
X-Received: by 2002:a17:90b:134d:b0:340:c179:3666 with SMTP id
 98e67ed59e1d1-35272ef6dffmr763443a91.8.1768521713769; Thu, 15 Jan 2026
 16:01:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115-timer_nolock-v5-0-15e3aef2703d@meta.com> <20260115-timer_nolock-v5-4-15e3aef2703d@meta.com>
In-Reply-To: <20260115-timer_nolock-v5-4-15e3aef2703d@meta.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 15 Jan 2026 16:01:40 -0800
X-Gm-Features: AZwV_QgJn9jN1GW0JT7BCvtKNRtb9AcoBPOJzojtsqwaMdUvDqMSvWHlRwJMfTI
Message-ID: <CAEf4BzZ0aEVc_k0J-vvKa5CRh-KQJYCBuGDM6FYsTyDg_oNcxg@mail.gmail.com>
Subject: Re: [PATCH RFC v5 04/10] bpf: Simplify bpf_timer_cancel()
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, memxor@gmail.com, 
	eddyz87@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 10:29=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Remove lock from the bpf_timer_cancel() helper. The lock does not
> protect from concurrent modification of the bpf_async_cb data fields as
> those are modified in the callback without locking.
>
> Use guard(rcu)() instead of pair of explicit lock()/unlock().
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  kernel/bpf/helpers.c | 27 +++++++++++----------------
>  1 file changed, 11 insertions(+), 16 deletions(-)
>

LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>

[...]

