Return-Path: <bpf+bounces-45775-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 495339DAFB8
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 00:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEC07B2265B
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 23:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98CA203719;
	Wed, 27 Nov 2024 23:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ng1xCcrI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f195.google.com (mail-lj1-f195.google.com [209.85.208.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D04200132
	for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 23:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732748805; cv=none; b=G7OuzVDKreun5pETkHAes/fY2uG1jx5jetUuDlYXSUAXyJvxYqfG4Z2SLCpBXLRsXpntBxlWLzqZWSuLxF8MYZV+zN9eGv0rjFFiUzbE/ErAv15rUPdiJokcVB7yQlyXe1mV7uYUvjk3MJuGLlrOYdGropr6RzcVQVGlzugKn5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732748805; c=relaxed/simple;
	bh=1FtomIgeoEIZOICX3jk1lXNFhgDTK0tlBq7SJAVEJ3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iyBnBny0hzY8CO6ktxm0z2HUX3mJYPxO2ERLQIiQ/vwMr0PpjTR+8JTshs4gidfngrdWOOfqENfW3LplI2qgU56vZ5r/fMoAqgL3F7kcEDC1g4MT1OlVM1Eg9HvbjkhTzzKJhWCIDwS3XqvvhPPoYt6x/6xCJqpdOy3zTNLa9qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ng1xCcrI; arc=none smtp.client-ip=209.85.208.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f195.google.com with SMTP id 38308e7fff4ca-2f75c56f16aso2486571fa.0
        for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 15:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732748800; x=1733353600; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8N2/LM2Egr45MuThp0V26CZeEnR3dD23n7yvwTmRvVI=;
        b=ng1xCcrIZjL1z3Lr31fC76YfnJWSQAhSeNaKYiGk3957JKHbNnHL614Ym+o67tibvt
         ypm7pe2N6BaV23bVnErf8tXlQL+6EKP1yg08MlA/dRuAlDj1c8VaHtFaYhSXYfsPg+gb
         5/DqF9+EHwkavHE5gcyWDmN6h2GXhYqvcFAroVEw8bo789XeUXsDhteK4GTXn7jI8WH7
         UuI7+tIu2BkSfldH/xWTmPMr/tCD9aVHk5lk/KracTsRQPIpE50xlg+BCFBHdZ4bRKNG
         4PbhTomrTArMnPPU7JRbo5tEXdRTMJGmmUF9+hS1oToCIxa/1x7SudllyYFgmf1NsKYV
         6W0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732748800; x=1733353600;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8N2/LM2Egr45MuThp0V26CZeEnR3dD23n7yvwTmRvVI=;
        b=wHxLw/oKZTBq8W3yPM5KQoqilFF+3O0D4ZoWoWorAaf3WHki7cSy9dRgJPGlaImzX2
         c7UOr80H8W81r+7rXxBURkLs5JzkrwOApWxJjrcqhdMd5L0IXBjiOKIbJy/uox+SKIrJ
         Azzi+JVGu/SCbK/szmkqzaj4e2yoR1S/lbVT9QEeyc0HKlxcS12gjjzh+GfnXOKXTxt4
         b2fO0MQ4Czy4vSLU2CJ9RFfX2c4OpNyvNjjr2zc+vjIi7byU/5sgdd4S/+c4Zij006in
         5FSCw6sNksYcEVmD5asj+1dG+BXtYPqzPhpRkQEIUC9u6H/lRNeQRaqh2gNIr72FXxu6
         3o+w==
X-Gm-Message-State: AOJu0YwLovZsg0qSZp0xuTnzcPKwu1P+YHKsCWByqQdKtDMh9P7wZZmu
	3KjuSAdW+R1/vPi2btitzJ3xSMcWxXGI2L/aUBfqahmh9YCsYGc/8Dd3s1XMNjkUAbx21PEwxKV
	VMYwWKHYHK3lDZ0iLy8HTp+3kfjUE93GdCeo=
X-Gm-Gg: ASbGnct1woTtT1hk5H6oic6iKZy6eHJGodBJvXcYmJ4OdQk3Zg+gEWhZFfnS8E9tv5V
	GWfZNIxCuBfyZ6pdXRTWPZDxTQiNawmef
X-Google-Smtp-Source: AGHT+IF8p4A9omFVViYsbzSzW6btLI5pCW4UiXlPteo6do6wZk+u1Hbb+KlMiYBoKENUgtSSf3ocfcxRFq626nrFW08=
X-Received: by 2002:a2e:a547:0:b0:2ff:c027:cf5c with SMTP id
 38308e7fff4ca-2ffd60ab5fdmr27078421fa.16.1732748799746; Wed, 27 Nov 2024
 15:06:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127230147.4158201-1-memxor@gmail.com> <20241127230147.4158201-3-memxor@gmail.com>
In-Reply-To: <20241127230147.4158201-3-memxor@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 28 Nov 2024 00:06:03 +0100
Message-ID: <CAP01T7734jEchOaMVuUnovO5Nwzza8Y1D0K86M4zFrS7_8zegQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/3] bpf: Zero index arg error string for
 dynptr and iter
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Tao Lyu <tao.lyu@epfl.ch>, 
	Mathias Payer <mathias.payer@nebelwelt.net>, Meng Xu <meng.xu.cs@uwaterloo.ca>, 
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Nov 2024 at 00:01, Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> Andrii spotted that process_dynptr_func's rejection of incorrect
> argument register type will print an error string where argument numbers
> are not zero-indexed, unlike elsewhere in the verifier.  Fix this by
> subtracting 1 from regno. The same scenario exists for iterator
> messages. Fix selftest error strings that match on the exact argument
> number while we're at it to ensure clean bisection.
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> --

When working on this, I noticed the same situation exists in IRQ
save/restore v4.

There are several options:
1. If this lands after IRQ series, I can respin and fix regno use in
process_irq_flag.
2. Maintainer landing IRQ series can s/regno/regno - 1/ in
process_irq_flag, selftests don't match on argument number.
3. I can respin IRQ series v5 with this addressed now.
4. If this lands before IRQ series, I can respin IRQ series and make the fix.
5. It can be a follow up for IRQ series.

Let me know whichever seems better.

