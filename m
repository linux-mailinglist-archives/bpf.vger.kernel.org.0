Return-Path: <bpf+bounces-65565-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 939B4B25600
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 23:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 88DDB4E3D2A
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 21:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8A82D3727;
	Wed, 13 Aug 2025 21:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6NgRWWE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A861E89C
	for <bpf@vger.kernel.org>; Wed, 13 Aug 2025 21:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755122067; cv=none; b=i5anWX9skQfNIIWuKcj+9jw9f1UIpd800ZVdvSjywfX/jihOQleuTDibRqJ8lqXDxU3vdEgl+qWalUDk9vUXRXacb8bgMvGa6xMg3ujNXQU4ftrM4e/nH2CjKyyIX36mSQ+fRQPnIYjdU8F00uO8WXiGsCgXcL5EuD3f2RupAN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755122067; c=relaxed/simple;
	bh=YbMnlQCQpQdQ0/y9XwEvymrxd/x8lSzavJidu38V99A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I75AbgyUh/RafWdc6aBfLuE9QBpNmeUCFdGRO0B6AAz979OBYgnETMgsYaMcRnjTJWAZiCwfKhtCC0/zn6+Js2QFvvl5uIyxw70OkSjqQJzhzpfqTJjba1PQLitYcAO8FtVbhkI7h9wuk3E0J/9KFjp0FUbzpXnBjhoRnrg2jRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J6NgRWWE; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-32326e5a623so336596a91.3
        for <bpf@vger.kernel.org>; Wed, 13 Aug 2025 14:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755122065; x=1755726865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ckqkrO/edq68ND5rA0nxsTF2JzzOADdBg2SqhUTW2pc=;
        b=J6NgRWWEdunAMsYloxgAP/embvSKvUcWJvZGQMkaYK0o4YEkLoRPo1YNJG6aEd7QO3
         zA+Eq683Pibw3iyRRn1rUnN5R0MYEX86PkRZp/ftmrJ2ZWeb9gJq6LOQeIuiPP6HeHo5
         PAAC8H8MMoOdD5vSNqFAQQQ2eG3s4eshzqVMdpMwvNrbWDU6oZV0Ko8ZO2kdQz+K1pFW
         4BUTL5SWx0R8gs7hh7TZUeoMcBUliZSQr8lqiAoEOeQZx8Igl2Gts/MLAPv5Sz4HckhQ
         d6ZuvA6mfcwPSnv49InIdKp8A5o6YAp/9HxpLTP0qt/QpzyBYuGtH8h7vFId6jEjJ73S
         EB3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755122065; x=1755726865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ckqkrO/edq68ND5rA0nxsTF2JzzOADdBg2SqhUTW2pc=;
        b=wVEQQsZ+WWnIYTugp/tJDhHyN/KGHyCGOYlBfwXCeisLON1S/zrMxNuqsTd7sfoLcx
         XRy/0MM6C+rDSEAa4g9X33IlkiStz9BWP3BBocEgRFc0/3xYvAADUuSCuZtCnblsGAVL
         OgNKqxZ7qcSl5SKMRKTzoYXo2Pj4TOsZNc+tdOgZbKo2PWxFvEKx+hEsdukGK7qbE/pJ
         VFYLFbFLF7HBbnIeWk1N/gUGgzdaM5GZNzjxSVOKZk4MPcVDI2JIktClWnTa7kGBhR68
         jTqI9La9jJ4NkRczp2sQzkd4gKlfTLWjRJNmV2YTdigSlgMxJn8JOa057WPHmXD5qqhH
         nejg==
X-Gm-Message-State: AOJu0YyV9W1qYwLMk2sUhvbvd4UO/6W4jHVGxoImZmIM/rMpZnMXM3HK
	MkbVg5f0PoEpi24/yOtLalapN6IZEJMNfa9CXKamDM/sI+ZzfDq22CUe+LgF/lxp5fTaL2CgtG/
	09zha20q3DU8l1x3FWvu9yHwWOIiLEoA=
X-Gm-Gg: ASbGncsOOYC2inaCcDyxadV0NoVTSUpSBHFrJ5A8PdxAFUQIVfIxzF0+YJPO9mzx3iC
	wCM/C76XaChl2oQ5ZpTc/VLIMfK0ecJ8ckbsR8eKNckLEXUrzYqXJFZX8xUfkSF8ghI8fjcaVYx
	R+Q+EqKgQ3xQuUZXqScAAEuUy/0R64O00gEmVnNPpaOspQs7ej5Q196SQxelBdL9ctCkXfZRHk8
	mgXC90Tc69xkwwuAYJZmibsEICmatvGrA==
X-Google-Smtp-Source: AGHT+IEbNrlL+ajQgwey/815geqfbPOgqK5dU0Z0HHAWvQWyI2VDP81iS6JN8bZGBE06zBGu5fZUDokqfintHZtlLJU=
X-Received: by 2002:a17:90b:6cd:b0:315:c77b:37d6 with SMTP id
 98e67ed59e1d1-32327b48f6cmr1151688a91.23.1755122064876; Wed, 13 Aug 2025
 14:54:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811212026.310901-1-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250811212026.310901-1-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 13 Aug 2025 14:54:10 -0700
X-Gm-Features: Ac12FXx708H8YVDMCRg9N6Q0gS9OyWlfbpdqSuHIiU1qsR-Bb19ZswN-lxAGR3Y
Message-ID: <CAEf4BzZ-MX4+pVcR=Ydkpeu5vk6oALUaHM+cvw2qWt=75Tq5zg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: add BPF program dump in veristat
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 2:20=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> This patch adds support for dumping BPF program instructions directly
> from veristat.
> While it is already possible to inspect BPF program dump using bpftool,
> it requires multiple commands. During active development, it's common
> for developers to use veristat for testing verification. Integrating
> instruction dumping into veristat reduces the need to switch tools and
> simplifies the workflow.
> By making this information more readily accessible, this change aims
> to streamline the BPF development cycle and improve usability for
> developers.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  tools/testing/selftests/bpf/Makefile   |   2 +-
>  tools/testing/selftests/bpf/veristat.c | 319 +++++++++++++++++++++++++
>  2 files changed, 320 insertions(+), 1 deletion(-)
>

[...]

> +static int kernel_syms_cmp(const void *sym_a, const void *sym_b)
> +{
> +       return ((struct kernel_sym *)sym_a)->address -
> +              ((struct kernel_sym *)sym_b)->address;

as I was just skimming quickly: this is a bad idea. address is 64-bit,
int is 32-bit, you are all over the place with over(under?)flows.
Compare directly and return -1, 1, or 0, as necessary.

> +}
> +
> +struct dump_context {
> +       struct bpf_prog_info *info;
> +       struct kernel_sym *kernel_syms;
> +       int kernel_sym_cnt;
> +       size_t kfunc_base_addr;
> +       char scratch_buf[512];
> +};
> +

[...]

