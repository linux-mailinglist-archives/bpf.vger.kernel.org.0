Return-Path: <bpf+bounces-58078-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF402AB48E7
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 03:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB86C19E7D32
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 01:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A65918FC84;
	Tue, 13 May 2025 01:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLgu+jIG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E23A923
	for <bpf@vger.kernel.org>; Tue, 13 May 2025 01:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747100548; cv=none; b=Hy+T9aqkNOWRJ+2op5qYo7hskdxSxxrjBzl5D5viiAQC6ZdFbbeOaE4KH+67kZWnlR5DkHMeek04JKCNh7p9DDQsjHbCL++PsbgOWCbo6W5+d+mPEuc6uSFNSSPuhE8v2z6ef1wFp6ttjghqX2Yn6An2DmmfIUw1pJSpX4eWCwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747100548; c=relaxed/simple;
	bh=tAZCr1YrYm0d4k3QcmNeiJUWxPyTC2o8sh2EmUgyE3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=abMGIL1c9s4eVFR0DlHM0Po3AXUKTZklLVqEYNl/AN5qu1AybBKYT1VnyRFDR56MLwGfe83vD05MnvUiCI6A3vL9hyoZKaRgYUiJzzJzNNKYaa9tX4715wwH8KLZkX6k2I1riDbE4USrgNXo9p2j1g2m9qoKffopLHTtE8Rr9/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LLgu+jIG; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a1f5d2d91eso2802370f8f.1
        for <bpf@vger.kernel.org>; Mon, 12 May 2025 18:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747100545; x=1747705345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tAZCr1YrYm0d4k3QcmNeiJUWxPyTC2o8sh2EmUgyE3E=;
        b=LLgu+jIGo8tAEjqUrnwA0MDsDd36awqkUUXe2rZLo8gWa9Raj7pm7f6ApBFx6rgzVL
         1rz8A4djJ5a6gT+pozpvv1mE4B4iq53DlE/WoAw7nMG8iBXJRRbGKIuRwN3SMYmcfVO/
         zo5DvktuBG214i3+u1vNZZelBlyn2JBusFYo/Z66PEDbSKBo7VIGWZCmufz42MMdN3Y5
         RLTiTrJKNtOfW64z6OADnMvQrOIIfoA0yFKj1NtsSYULk5C6LHiRpayFpKAovBFb+bms
         4zkNduOd+SlSLavgyThmttOjBtakkDGEOwER37Id/dTKo9ciYN4xsEr++SROwp70zS8d
         gDEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747100545; x=1747705345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tAZCr1YrYm0d4k3QcmNeiJUWxPyTC2o8sh2EmUgyE3E=;
        b=M2STpjnFFez5PzECd9tvTy/IDR6crEHEN0mt4vkexdZF2vOBYuK+ES/aSPACGaceAj
         vFDBjWeY/egniD2XTQHHNkvrlw3ULXqh7g+23Z7bxw4FjpUtD76Q9ee2zZoz/Onc/4k1
         qErKj2FMVNxRp667vi34PPP505IRbLyrUFBAOKbtZ16sZWQ1nfLxkbbwJD2Ik3SYEta3
         K4FiUjpMywl6k+FGWBUOK51hMX5PY0iYOvOf35KC9Zen/66aM2od2S+luXncdMtsYWYD
         G3volF0lC/INNEg3+nlINqIpBv+76Q8OSodqfS/taN1OvnIBs6LE4+nW+eT8OSXo5OEB
         B4PA==
X-Gm-Message-State: AOJu0YwO9dtUtEZ1b+auw96ahWR9P2Afb79I2wCN11lhlSHl86TCgHl7
	hA+uloFsU42NgR3uW+LWYH0JKOKhm9sKKPBTfTdz5z1d7OF14caJ5aEj7AbT9qL1CxAPdZNQgAJ
	rwG5iUcKLGi696k0+aHbmr4X+QY4=
X-Gm-Gg: ASbGncsEo62D4Gq6TrRoiSzxvvqmU+KIaVQvVk94K0Yw7DY0wKpQimKaDckjADM01JX
	lFA2JdxKJ8cORK1eIkcim5cMXYOqAWnHXFj7LBRi5QwoLZk+gphuB6FdiNO7fYsFS5i4Ny4CM1n
	Wk7JKK/NeDkRTL8wsK3ndMk14tFK6gzbxrAqiH6bA4AE4sLchBhKl88bECHqIP939TZfXajm8z
X-Google-Smtp-Source: AGHT+IGk/9cA6LCUDXm1q/MKkEe8qR5P7OkQtzPpdm1kBB5v028OrLoPmzKFKLA67I6oXErkNhLyaaE1+p3sSIrVO50=
X-Received: by 2002:a05:6000:2207:b0:3a1:4c72:9072 with SMTP id
 ffacd0b85a97d-3a1f6438490mr12112084f8f.17.1747100545186; Mon, 12 May 2025
 18:42:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512205348.191079-1-mykyta.yatsenko5@gmail.com> <20250512205348.191079-3-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250512205348.191079-3-mykyta.yatsenko5@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 12 May 2025 18:42:12 -0700
X-Gm-Features: AX0GCFuCeGI9N3ghjoh9G8igb8tVf1sHDoXJllY5oun0fqqfXUgbh-M7FWCf7R4
Message-ID: <CAADnVQJZPNW2ZEfq=CjB5UMgVu8SCJhzfT5H9=Gho0b9TxeSnA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/3] bpf: implement dynptr copy kfuncs
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Eduard <eddyz87@gmail.com>, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 1:53=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
>
> +typedef int (*copy_fn_t)(void *dst, const void *src, u32 size, struct ta=
sk_struct *tsk);
> +
> +/* The __always_inline is to make sure the compiler doesn't

moved it to new line as:
/*
 * The __always_inline is to make sure the compiler doesn't

Please use the kernel coding style instead of the old networking
style from now on.


> + * generate indirect calls into callbacks, which is expensive,
> + * on some kernel configurations. This allows compiler to put
> + * direct calls into all the specific callback implementations
> + *(copy_user_data_sleepable, copy_user_data_nofault, and so on)

Added extra space after *

> + */

while applying.

