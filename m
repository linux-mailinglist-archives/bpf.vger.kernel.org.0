Return-Path: <bpf+bounces-58462-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 348C8ABB0B2
	for <lists+bpf@lfdr.de>; Sun, 18 May 2025 17:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3ADA175E2B
	for <lists+bpf@lfdr.de>; Sun, 18 May 2025 15:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2ED213E78;
	Sun, 18 May 2025 15:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ofcyj02P"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD3D1E4AB
	for <bpf@vger.kernel.org>; Sun, 18 May 2025 15:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747582877; cv=none; b=mWgAUGqH301i5cvDMK6+ubeRzF492BbWQudjpgv61EnQvzMoeDBtGzCPq2EfevXqG58/6wP+vC15+5V4wZ/p4rlwK+/6nO7DwOhY26WqVSVoTh3N0D5+yjNn9u/RcWH0FKZlKnyyA/IzjLSsYVYtJMIUYpFAZvdEiIHMX1qVZFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747582877; c=relaxed/simple;
	bh=KgPU0dsqnJv8BmVzBVcP1E7dNdwtwU7sUSqfF4VOCPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sZX0nnaBiN4XE0hIwZ+LlBxF1IGb3FPvI+0eNGKAG6veikJfSZ6XmqV0xM8ulooBn1fDZAA9Ft/5UMD7v2cNZ1V79vaOv3qHPWwqUwL7HOg14EkmuorP4nR1rRoA3ZlWR0FJslzBJjz9fDWEcKJ6iJlCCjhnZ9oQ3uqpIV0rntU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ofcyj02P; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-442ed8a275fso44881485e9.2
        for <bpf@vger.kernel.org>; Sun, 18 May 2025 08:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747582872; x=1748187672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+717pseyZ/t8zVndSVWRMUqDTo7Hwy27k6f4k7VQqtw=;
        b=Ofcyj02PwrTr9dIqRzAE2lPb+h92QLQp2Agq98OSHTdbq2ZMNydu7YRBGZyiHNlX8x
         52zdJ4oXe5JegUrjQ2p7ORanTspe7b3H5ZE6te+bbHgToKMvfbY7iPKnljzgT3usujn6
         OWiJdqV8PK/Lh8VBVkWr+pj25lAsAEZ68gsqICcgqvN1ZSBwCcmHUEfMBW+Uh9dvATaZ
         qEmoEgRJ1Wm7CasO+g6GnU3Np2F6vuhCRvt3YKbgo+5i9dqkEsi8i/iH0pgX7YKDwMHN
         7A3ouY+58YUoEvUc8EhI/phknWNSh4rIt9glLWboibvIiRwUFI4folJuE2naStVKapgm
         +YKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747582872; x=1748187672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+717pseyZ/t8zVndSVWRMUqDTo7Hwy27k6f4k7VQqtw=;
        b=DVSOHC1z19QI1yhbBuU8LKNOSblQR3ZAd+BmHxghYOn4lyxViyDBww+dHuvKHMLIlj
         z1EeQj44fc+lY3pLuAOd2VVtNmA6qoc37TfhACmBmiMNdDOAqh9lH6O8nlNW5E9Go+OX
         SPV2AyCsNy9TuWrsS4EAhpiFPddc0y/cYSv+r2O84XaU/5qrOvoKxLhMrtjzVPJ/Jwxs
         /M429diTxAr9N4RhITGO48ubLXOmfWGtelXuHQoJDPTEKIgUGi18Fnlke8ZNWgsPHy6D
         8FeO24tAdFBhliZs442Q/ZoK/fl7CqO0mWcvpWKHcJuaxNS9AaZYqSHsM9i5gNdFc2sQ
         hsjw==
X-Gm-Message-State: AOJu0YzlINJ9P0+fFmAb49P7e3ZEn8+d/EnVxd+XNEHUzaKX1XwkHGKA
	eTMuiZkA2iXGmcclrQuXoeEWC8cFKYVhOq26hCm2G2AKSQlNc5kvv92YIIWBWMPkWVciA1b7+la
	DoF1kJVGsUZuIgmaDHmPm/1f/V91x7yIeTg==
X-Gm-Gg: ASbGncvFwm6/cWKo7UnweZFOwR4l0LeMZZatA1eY750pgeZtaSO6hHx2XG1Qr5wWPnZ
	VVemnyCeKnnpyUMFuma2V0BXonHYuPvLMgHd//mTsCIDinO2OBjXmNBJQFG5pmEn5QqDhcMZu/J
	+yTXs7bgQsAeJFz0cOih/I/G3IdvuvXpcWJ92mnfZ5xCOeA4hLLFntjmCjysHQig==
X-Google-Smtp-Source: AGHT+IF++JvIqrEcon4EEOnu8ox49JHjLlddZvppP7sl9bLI+4h+InY3ESRP99LoKbYKS4trpK6p0xZQoyURjEWgzSs=
X-Received: by 2002:a05:600c:46c3:b0:43d:aed:f7d0 with SMTP id
 5b1f17b1804b1-442fd671fe6mr74289305e9.28.1747582872421; Sun, 18 May 2025
 08:41:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515200635.3427478-1-yonghong.song@linux.dev>
 <CAADnVQL9A8vB-yRjnZn8bgMrfDSO17FFBtS_xOs5w-LSq+p74g@mail.gmail.com>
 <1742bbe7-7f7a-4eef-a0a9-feb2cda50bbd@linux.dev> <CAADnVQJurPs_e3Lx9O7qZ+=HPk7XarXoGXeTiARbw8bW+-txGA@mail.gmail.com>
 <b32cd638-5ba1-4af5-80e6-3103786a7c8e@linux.dev>
In-Reply-To: <b32cd638-5ba1-4af5-80e6-3103786a7c8e@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 18 May 2025 08:41:01 -0700
X-Gm-Features: AX0GCFsD5e9FbpHA8V7FlojH3pnZLCVXz_63Xgo1RaL1k5T1RRgE8eS-EF-tIrc
Message-ID: <CAADnVQKWU3Ap8Wm_DFFkYVYxenEMPdJZw7KjAPJ=RJXR9Q=FGg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Warn with new bpf_unreachable()
 kfunc maybe due to uninitialized var
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 17, 2025 at 11:14=E2=80=AFAM Yonghong Song <yonghong.song@linux=
.dev> wrote:
>
>
>
> On 5/16/25 5:31 AM, Alexei Starovoitov wrote:
> > On Fri, May 16, 2025 at 2:17=E2=80=AFPM Yonghong Song <yonghong.song@li=
nux.dev> wrote:
> >>
> >> So I then decided to add an 'exit' insn after bpf_unreachable() in llv=
m.
> >> See latest https://github.com/llvm/llvm-project/pull/131731 (commit #2=
).
> >> So we won't have any control flow issues in code. With newer llvm chan=
ge,
> > That's a good idea. Certainly better than special case this 'noreturn'
> > semantic in the verifier.
>
> Current latest llvm21 will cause kernel build failure:
>    https://patchew.org/linux/20250506-default-const-init-clang-v2-1-fcfb6=
9703264@kernel.org/
> I will wait for the fix in bpf-next and then submit v3.

that's not going to be soon. why delay the whole thing?
submit with selftests that include inline asm and delay C only selftest.

