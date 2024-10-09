Return-Path: <bpf+bounces-41482-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1BA9974E2
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 20:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89CBB1C23128
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 18:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF491DFE2B;
	Wed,  9 Oct 2024 18:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AhlMcnPk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D151DE4CE;
	Wed,  9 Oct 2024 18:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728498450; cv=none; b=GlAgtvyAUHEwlaCVvHRnOz+nm58bQhMC8ZIqsMbHof9JwvSiOh0L2tM1Jg/U0uVbjZy17lTsfQWw48UFnCIppbqP4clT1WNBe0HnSpTWaLeLbYHmQnX6r5x9mzDaAqWB5qitgQmy5LiJttz9S86iRoD9b2J7uJBOTfLUIN0IwkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728498450; c=relaxed/simple;
	bh=icD6oDjk9SU4vvPr7VlMmj5ZCwZfB0LtWsNfm1gram8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e70okoK8aDpAfy7jwN0twr5jZHrvSR9YhJN8lBqklBi/1YJQuUD0s6DB6LsxEm/0ZAIwDvq0fikNxQ84JeyG5thcsoXD1igmxe20stbd352ZBUKY0Ba7UkL7/OgArlITke2QdBO3v/4dBR6CDemDJrTxyXuu0iA36q9Qb/ocC3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AhlMcnPk; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42cb6f3a5bcso724965e9.2;
        Wed, 09 Oct 2024 11:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728498447; x=1729103247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f2r/bFblN9V4MmjFbmDYE2AhavkhB01rk4LY2aZjy0I=;
        b=AhlMcnPkblnZhjJErxNPTQNcx60Yw/k3ZO7OKheF04biPJ6seixkp0vzK/SI+acgD0
         wVFnz8qY7ZRUIrteXuAukU/qLTSEp0VTexyxk3gANCAGGA0X5nWJIPukQa8VqEhDytDH
         aaAWaDeBcJW5kXgRElBpVcz48Ugc2gxaK8Mtdg7GKl7VfenUxlV8u+usaR5swhed6TrR
         gTahyD3qr6ocNo6Q3Nw8KY6wxVKSxN8mSyljqP/e3aqkdRd3Trg42vjchZPZZG8DIdJs
         0Nkrkf7IGxrd+7yyQ/d9Bjfu6uamwlom36pIRBKFm5IfT8mjuSulMJ1ID04XgrQbdmBK
         U39w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728498447; x=1729103247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f2r/bFblN9V4MmjFbmDYE2AhavkhB01rk4LY2aZjy0I=;
        b=qRi+kT4u+XcyC3/2IrfnP6/vf7E/uiycUkYwMOCCvidfOj+c8XI+DPxt0UqiA6Ns/D
         BvLwh89LSl0c2agpuByz6PLn2B/XQZAJQr/+zdwSKXW4oh0oFk39tbf9if9zwR20lGOB
         H4SZAcaLgMLQhTdEu/G3r47anb6NQuLpkuIx4qPaxU0jRhxnQ3jxkSTX/Zl/2qhJmS9M
         FczGkkQuKawAdbmozf9mxC0sLViDctZ7pglIQTOSgY+GvlcZCt1yWRiJ3E17fki6/cjv
         TV7Z4hwsXfKHa/pUauliDt6O1MamoxhkSnBgvf34PTAyMZ9vd93jcsT0i5f3DMJfaTCC
         1IBA==
X-Forwarded-Encrypted: i=1; AJvYcCVatfBi4tMLT45iZTZtz16Jhv385dSpN7vGDdJElJHhf++AHE53EoiQXd6mWVdA6j9UgM4=@vger.kernel.org, AJvYcCWFW0zAXq94qn/hkqPgSN0e7JX2ZE3Zn9A0P98AIX1AG76zxW9xzkWQ9uoaIBjiicMrUPd/F/WD82oYWlsT@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+sSlkUbXKI3dZj3Bt28kFduJr6gAWYEAzwEXlI/bRxNMhFnF0
	MCMUsp3vvJTKQ7XNmQIE+6YN7ismRsiNDWGRZI1Oum+U37nknkQbbdtpN2esLALPyJUc0Te5y6E
	krNsbdFjtVQwHdZ4Cn4v7PYKiAKbULIxF
X-Google-Smtp-Source: AGHT+IGxNDr8I+CHIy7TM8Mpvkn88RZfcj0cijc4x/3bxuCJG1Tr4Q3LqU7Ai6CT0pQZveCAagiV32/I0EocyANTa/k=
X-Received: by 2002:a05:6000:12d0:b0:37d:37a6:f4e3 with SMTP id
 ffacd0b85a97d-37d3aa41f7fmr2754212f8f.23.1728498446749; Wed, 09 Oct 2024
 11:27:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009180500.87367-1-technoboy85@gmail.com>
In-Reply-To: <20241009180500.87367-1-technoboy85@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 9 Oct 2024 11:27:15 -0700
Message-ID: <CAADnVQJGQ8b+E5m09Gd=bZAqQ2bLpHk+1r9vhB0As_PcmCzWpA@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: fix argument type in bpf_loop documentation
To: Matteo Croce <technoboy85@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	LKML <linux-kernel@vger.kernel.org>, clang-built-linux <llvm@lists.linux.dev>, 
	Matteo Croce <teknoraver@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 11:05=E2=80=AFAM Matteo Croce <technoboy85@gmail.com=
> wrote:
>
> From: Matteo Croce <teknoraver@meta.com>
>
> The `index` argument to bpf_loop() is threaded as an u64.
> This lead in a subtle verifier denial where clang cloned the argument
> in another register[1].
>
> [1] https://github.com/systemd/systemd/pull/34650#issuecomment-2401092895
>
> Signed-off-by: Matteo Croce <teknoraver@meta.com>
> ---
>  include/uapi/linux/bpf.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 8ab4d8184b9d..874af0186fe8 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -5371,7 +5371,7 @@ union bpf_attr {
>   *             Currently, the **flags** must be 0. Currently, nr_loops i=
s
>   *             limited to 1 << 23 (~8 million) loops.
>   *
> - *             long (\*callback_fn)(u32 index, void \*ctx);
> + *             long (\*callback_fn)(u64 index, void \*ctx);

Good catch.
Please update other places too:
static int set_loop_callback_state(struct bpf_verifier_env *env,
                                   struct bpf_func_state *caller,
                                   struct bpf_func_state *callee,
                                   int insn_idx)
{
        /* bpf_loop(u32 nr_loops, void *callback_fn, void *callback_ctx,
         *          u64 flags);
         * callback_fn(u32 index, void *callback_ctx);
         */
        callee->regs[BPF_REG_1].type =3D SCALAR_VALUE;
..

tools/include/uapi/linux/bpf.h

pw-bot: cr

