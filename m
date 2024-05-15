Return-Path: <bpf+bounces-29771-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 661108C699E
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 17:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 039B81F2300F
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 15:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E0E155A2B;
	Wed, 15 May 2024 15:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eySLR15T"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C3315573E;
	Wed, 15 May 2024 15:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715786744; cv=none; b=VcJWkHqiL0P3YPA+cBjo5HAiXeAuCmPZWmhCkpQanq316rqlDJaKkJdoFv676vfSKSI4KHRST77qkzcpuqvgTcsZHBlTQOC2SKlh19bwmFWcmJqx4C4fYJcELDmrvqaVVusVoT0KAWO0XVTVReedQ9pPxuh6K66yj74B8dKxqqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715786744; c=relaxed/simple;
	bh=ekQu6l8UVVNVkUjVcmcdczKoulddjvrzz3Upabd+m2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BgOGodr+x03/P9IifXOUkECS1WZXrPWd9nt2r3riZm8iZZqeVzDSDNITgpl4VdoJw8/7dly8sYOQH5LAqeZLIDq9mQ8ZI8GefBl06FK1cr405jHSSt3pQ3vLxAPGuygs3XcL3MO3A5/F8dVKhDniB0ply5PYqjXRgTtp0wJpXSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eySLR15T; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-5709cb80b03so2225747a12.2;
        Wed, 15 May 2024 08:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715786740; x=1716391540; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ekQu6l8UVVNVkUjVcmcdczKoulddjvrzz3Upabd+m2c=;
        b=eySLR15T+OBYzI0z8b7iPHcuVh8vP8xK0vhPP1/NMQ2bXT430X7He50SDNxzOrkgWN
         VlESHN20t/sGXp/RxAPVK90fgCJKVWuPlZQ1zGiz/Zw/Jsl+6vI4Bbv+HjlknCdk33gE
         Yse+CU9+irjF5NIGZhRJuFY+a9ECzr5v29FFs5gPIvis23rgGSUxnuV1dq8QobG86+U4
         ftdAaRs46kPcp2e/CfKGxf64Nr00O3SdUnuM5HJjvd90ZQX3Ud6pg9HJQOuTUCsIDhqn
         6TRzq49/U+yjjRzNP7r2zYrPgcBedwK6JbmNn4QLkevU8UU9BeRCXpyEVn2w/ivWTof7
         O3XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715786740; x=1716391540;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ekQu6l8UVVNVkUjVcmcdczKoulddjvrzz3Upabd+m2c=;
        b=bCMYoVnSSNNY0vTHPYxzlrjpau6u5thyAnHkdMGuNbw8JW7rEQRTl5PBul3MmpwnLE
         Ng0AbxRsET16jdr2H+4m0EMvgimw2MU0W6mZ7ECoWitY7DT+aLo+ebB10I2APNE0tz1A
         hQi56mot13hjYe+zrX0MJhN0+uT7SVmPQccuM6CJwk/Clx4QMvEWgBWAgq5CjQKlQEeu
         GalbR3iHst8dMoYXOK8A80WccF+dAbf4xLQJ5yd8FqWfAm2YlN+LQroOVImAv3dalLkP
         jeAE2k8x97nv+f4QYRrxifMz3eSUYrgCOZpCo3m+XmAjtoM5aot3/ZQKhxTUxCEZzy7R
         AkRg==
X-Forwarded-Encrypted: i=1; AJvYcCVH/afRyl2rwAH9/N//A/n2FL2ocqOgCc1oFI0S8hJLmQendwm8pRKVc0ddTt2iwC1KIq7mYWxLMAyZAOx2dxlKW0u1
X-Gm-Message-State: AOJu0YyeeS/YhdUlIS1jZEZVc1QOKU4Qba0tJ4+Rp5eeMqE1Taqhqvqr
	4OyhCPUpFXLGTqTsnq51qPcfY/3aaT5RaUCQfQASCLwdiqLlJEdu3IF/9Sk+HjGPtNUkMrRDqE5
	DcnFzOLeCJh9Qu0htHJRUsD0w3I8=
X-Google-Smtp-Source: AGHT+IFOOz6XjLsCUnykrsTh4I2zrKCNz//LZi0zmMAPj4wBAZcDL/1aJOqWR2rhv263BtLvZWbhkl1FLEFVI4kvUYE=
X-Received: by 2002:a50:a417:0:b0:572:9503:4f8c with SMTP id
 4fb4d7f45d1cf-5734d67aed2mr10313575a12.34.1715786739755; Wed, 15 May 2024
 08:25:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515062440.846086-1-andrii@kernel.org>
In-Reply-To: <20240515062440.846086-1-andrii@kernel.org>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 15 May 2024 17:25:03 +0200
Message-ID: <CAP01T74yJD508cSUtb4pFpuj0M8AM+t-sbxE8BE9Wt7zj4gHmg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] bpf: save extended inner map info for percpu
 array maps as well
To: Andrii Nakryiko <andrii@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, torvalds@linux-foundation.org, 
	Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 May 2024 at 08:24, Andrii Nakryiko <andrii@kernel.org> wrote:
>
> ARRAY_OF_MAPS and HASH_OF_MAPS map types have special logic to save
> a few extra fields required for correct operations of ARRAY maps, when
> they are used as inner maps. PERCPU_ARRAY maps have similar
> requirements as they now support generating inline element lookup
> logic. So make sure that both classes of maps are handled correctly.
>
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> Fixes: db69718b8efa ("bpf: inline bpf_map_lookup_elem() for PERCPU_ARRAY maps")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

