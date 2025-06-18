Return-Path: <bpf+bounces-60890-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7657FADE1A0
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 05:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C9DD3BC337
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 03:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70841D5CEA;
	Wed, 18 Jun 2025 03:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aGpCUanU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E8939FD9
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 03:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750217102; cv=none; b=pDH26uHxbsqHtD+OcZ6o98reCOd09it7tz7/RX5lf883a/p4hAlfSZjKkSZDpCwqjLUzazmIjxj0M8oro4taPAxw6jr9GFvcTooX43qioU+eyRT8VGD9gUHk8nAkd1n5ju+JzCU+DzK5lsJjB3yqNtxLOdbGgUrUaU+vogyIL3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750217102; c=relaxed/simple;
	bh=o2RZmxw7DZbMMO5Hwmh6XG81I+QOYqM5rgBrCOyLmKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mVaJd73JyfF2wGB3p+8rhnY06jWx6tG9lxzXfwD+ifMAtcUULsuF1/k6O6WhtJMxNgLQMCfMz1u7f2Sh9jc8vBrTzhPWdE8euOhdvNkZXsp5GuQvpy3QoizVX4f7ZRU8x4ImBebpKnPSKNvcMXI7LrFbQb/gLLnVSYdKq5Ftx4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aGpCUanU; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a588da60dfso1043058f8f.1
        for <bpf@vger.kernel.org>; Tue, 17 Jun 2025 20:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750217099; x=1750821899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wmTimzCijhEoqSkS1eOLhxd7yWZzFzdP8OzYjsDkE7Q=;
        b=aGpCUanUdCJQ2vhSUq9CMN9Ql+jVWp+EkmeymcLlZN8ZQegv0nrhuBghezYZTPT+Hp
         pKHPefSbFuJDHRZdEJBMRaZb60xOmz0RxOtknuoMYcMFUeo132PXloTFFPpjXAHqAZxO
         qjU10R1eJunNlbu91rrODcecxoegO53AUGBrsULqAi//f+TxO4iGfxfGzZbU9UX2+yLQ
         598Uy3kwQwmywvHMm+bdPVXgMcgJz7HmG+QCFfrSvckXTN1wiIfpEz0tKU1sPp2vkuOu
         kFfBSyPYHgivUVNADv14QG+64rKkQWcNScSVQZ/QkoVUy4PuP1ggTrzo/VVQk5gDcxYl
         4Syw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750217099; x=1750821899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wmTimzCijhEoqSkS1eOLhxd7yWZzFzdP8OzYjsDkE7Q=;
        b=OhQy13XQkHMOFoCXPq0K/DZ/bzqxirjFTHSnK5/bpHMv+OGvAkvDTZLN6kU0wWbeOI
         N+/GLWG29jlV1qmfxxweLRxiSAzMWi1w2tyPxAKXBcOG16WaMr44+Af3Pq6RUaHFJT2f
         G3jwtAHoyaz7RHRff2S2t9QU8QRnz5yIemt+k819nPdJaOKebj8bwZGAcd0MWztskQuG
         +gFgX+Lnps3ALJ783rc8ig9mcfWf1ykYiqE+WxAmVoPSajf3a44Pnw/1KrJcya+Vb5qL
         rSDm21Bo8Yol4y2ayJ44mkzqHi87UgZbwnY2NfPWjYbV1R5CBAkt7UXk5CJrnZRNJijI
         mPUA==
X-Gm-Message-State: AOJu0YyOqfcJ9KVL4KcaTR9RD/2jnjL4TNxHyO1hr1drf0gF959CQdon
	EeohSfdMPuPVJrE6ZG6buEkYy+tHt7Ken3OXBGfiBWi6o0a3wE+WA9InDQmtGAtP/NZrOXwq9f0
	py5Vj4B9x/hWboPrUqOuS6cZdAwaFA4M=
X-Gm-Gg: ASbGncudSpfzNTEqIfvDjbD66Sd9xPrh9tbt3dTIX2lDlZwx9Lyt1PcJwB2bfmIV3rG
	9UH+9ryU43GGeaYy95Z9ZfScFFtgFrzsYK8jkcaizCTFRmFBn1FgYLZJgXDnCgi2bE6mQIyNiq2
	ByKTznwN7etY7SIZYpnrEkXXE5OqsO9pP0fnbPxdWiDmQE5ow3J40VY0c3r3gorMijwVAmJgZZ
X-Google-Smtp-Source: AGHT+IHbnQ38nWzH7idNM+Ux9w9NkAaB7lJWH1Sb2m1IjgrM0gmbQTdHAvK67JnPoqrSQ4U2VTKuI4xoRnrGSGJYdiI=
X-Received: by 2002:a05:6000:711:b0:3a5:27ba:47a8 with SMTP id
 ffacd0b85a97d-3a572e99895mr11970090f8f.52.1750217098841; Tue, 17 Jun 2025
 20:24:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250615085943.3871208-1-a.s.protopopov@gmail.com> <20250615085943.3871208-10-a.s.protopopov@gmail.com>
In-Reply-To: <20250615085943.3871208-10-a.s.protopopov@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 17 Jun 2025 20:24:47 -0700
X-Gm-Features: Ac12FXyy3gUtcmAD3QPM6hbSB2SHXVcMzRHqkz-n2tJ1JEf39uqGy4sxTRK0qkI
Message-ID: <CAADnVQKPbBRGOj2mB5Um80VFUh_vVg=oRJCdYUgyz_DrObuagQ@mail.gmail.com>
Subject: Re: [RFC bpf-next 9/9] selftests/bpf: add selftests for indirect jumps
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Anton Protopopov <aspsk@isovalent.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 15, 2025 at 1:55=E2=80=AFAM Anton Protopopov
<a.s.protopopov@gmail.com> wrote:
> +SEC("syscall")
> +int two_towers(struct simple_ctx *ctx)
> +{
> +       switch (ctx->x) {
>

Not sure why you went with switch() statements everywhere.
Please add few tests with explicit indirect goto
like interpreter does: goto *jumptable[insn->code];

Remove all bpf_printk() too and get easy on names.
i_am_a_little_tiny_foo() sounds funny today, but
it won't be funny at all tomorrow.

