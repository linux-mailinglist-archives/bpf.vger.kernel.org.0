Return-Path: <bpf+bounces-45974-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A029E0F87
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 01:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FC4D28304B
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 00:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A4E64D;
	Tue,  3 Dec 2024 00:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/QDZQKM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B3C645
	for <bpf@vger.kernel.org>; Tue,  3 Dec 2024 00:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733184762; cv=none; b=Y4Vn2RJeMyrMlg38ETqXmjEalUf5dq4KoDXWyiCrY1LIzMsbcTIavQYXNNCN7DPfz064Ceypj9gy+/Hb4hqNMwzO+AE1UBgvsY4y7CoW4xb9q8bj2XINRXfxiKARk6jPjTo+7vCzouYxo0Fx6qtS/KkOYc0ieBm5nfdEzK2yc8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733184762; c=relaxed/simple;
	bh=O9HVTooewHVgzonDCUgP6ZJlVIpMZlSgW5pD7NnDj0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NZskNC6jW5GpAfg8sIWscb8Jz6iPYsflB2irH/WZwunzJDX1zMsFvI5HPxmrM40rZoDPatXcd8y3QubInZcLz2q2VuzJByc6WjKHTIBSGBDsMclXGU3VCIhVOyUmcYYJ76NFye/Uh3XPZF+QL/NNo7p5jhN1/jrOMojMqAnwrHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/QDZQKM; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7256dc42176so1737127b3a.3
        for <bpf@vger.kernel.org>; Mon, 02 Dec 2024 16:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733184760; x=1733789560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=32b/TNjpz3VtxXO0V4WqJBlen5RbaE/+VM0A44tcRDM=;
        b=H/QDZQKMHjZ4u1ZJSzuALzEOAUlc8IGAi04X88RCSZMgzQQXWdW0FkPdb10SevxZ0v
         Wd1Xg1nbT2jM2B35siBB7QdfLUjHiq6fDV29lvK90SYtqUUXh8zQjzY/eFKhz19bUefs
         yO4V6I0WQRjgewr6XnpP9YpoEYSzoeiCS2feFGfT3Cw0V2oVKzrM3Tu0MBnTivbHlVUt
         9FDwEyWvhyAyoHq0i/039CJokk9UqMneqhJNUVnNpmVswTSdgQrRkXWYSenujcrDDpbD
         QwqQayqpAn/+MoXZ8da/YfZQwgGShNmjyrW5PI6dRUj3/rBNP9tYia4SgdWK9nqQjNvC
         od/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733184760; x=1733789560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=32b/TNjpz3VtxXO0V4WqJBlen5RbaE/+VM0A44tcRDM=;
        b=Oo2KYf9CCgvaAYHiUW7JTCvKYyo9tufWmcMzR1c4iTmk30LvhmodcTfGOyfEGV4nQ0
         o0cGq+X1dGUgIRSvG3b0C32aAz8oZSehGe4u+9zB8hEuCqPxgyzBDgXZ0IYJuRzwmjT8
         3FDGj9EVBiYLJzAKp27mshOT31WxZKMgTXrB78K9pS8U18muo9AzW9kAzehv6G+yLAbD
         04QzKs5kMKPCSsAelLSczr9su8bfHj8w6jkHJtMJs1wZga2NpnPVBw6q4aXrG4a3Olxz
         X0nNoETBkT3L8kpo/KxViFL96pKsJzuWPME5Y+O+xYRSiwMYNp5TRriGnloTwDnvc+Q9
         +Fmg==
X-Gm-Message-State: AOJu0YwRM7ZPN/xScmjQLKtbdOXZqR0bB7KLemfs7niUPldXlOChbWjw
	SxwPMEZ8OfyfSI1Yih/Hsh1CvkjT3gPaQd2/SOIBgBdqTDyhIetVbvfrj1N7T468X0Q0rNJqfJU
	9UXAU+CcpPdMmu8NhjCbp3juRVJNz3cNL
X-Gm-Gg: ASbGncsmDBmVnN65dqsTKKl4UbDmmqxDs9q9uXpMO+oceYArwYixGEpoPmUUzeo7mWR
	LnaLnYV+cX/c2ngxVhJB0Nz4XkVSZCeFVl/lSiHiCQIISmZM=
X-Google-Smtp-Source: AGHT+IHnUW9/bHeud/bUWTGTc2bdNks8Sh8sONKK1nXtrfhNnxfVxkq0sARdRI6QzjyCAM6LhrqkBQq5+WSqu/4mCbU=
X-Received: by 2002:a17:90b:4c8e:b0:2ee:4513:f1d5 with SMTP id
 98e67ed59e1d1-2ef012426femr818789a91.29.1733184760401; Mon, 02 Dec 2024
 16:12:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202083814.1888784-1-memxor@gmail.com> <20241202083814.1888784-3-memxor@gmail.com>
In-Reply-To: <20241202083814.1888784-3-memxor@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 2 Dec 2024 16:12:26 -0800
Message-ID: <CAEf4BzbaiwsBW-QoZYXDiTZ-otCt52-y1-QHBhT-9DimfnCVeQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/5] bpf: Fix narrow scalar spill onto 64-bit
 spilled scalar slots
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, kkd@meta.com, Eduard Zingerman <eddyz87@gmail.com>, 
	Tao Lyu <tao.lyu@epfl.ch>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Mathias Payer <mathias.payer@nebelwelt.net>, Meng Xu <meng.xu.cs@uwaterloo.ca>, 
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 12:38=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> From: Tao Lyu <tao.lyu@epfl.ch>
>
> When CAP_PERFMON and CAP_SYS_ADMIN (allow_ptr_leaks) are disabled, the
> verifier aims to reject partial overwrite on an 8-byte stack slot that
> contains a spilled pointer.
>
> However, in such a scenario, it rejects all partial stack overwrites as
> long as the targeted stack slot is a spilled register, because it does
> not check if the stack slot is a spilled pointer.
>
> Incomplete checks will result in the rejection of valid programs, which
> spill narrower scalar values onto scalar slots, as shown below.
>
> 0: R1=3Dctx() R10=3Dfp0
> ; asm volatile ( @ repro.bpf.c:679
> 0: (7a) *(u64 *)(r10 -8) =3D 1          ; R10=3Dfp0 fp-8_w=3D1
> 1: (62) *(u32 *)(r10 -8) =3D 1
> attempt to corrupt spilled pointer on stack
> processed 2 insns (limit 1000000) max_states_per_insn 0 total_states 0 pe=
ak_states 0 mark_read 0.
>
> Fix this by expanding the check to not consider spilled scalar registers
> when rejecting the write into the stack.
>
> Previous discussion on this patch is at link [0].
>
>   [0]: https://lore.kernel.org/bpf/20240403202409.2615469-1-tao.lyu@epfl.=
ch
>
> Fixes: ab125ed3ec1c ("bpf: fix check for attempt to corrupt spilled point=
er")
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Tao Lyu <tao.lyu@epfl.ch>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  kernel/bpf/verifier.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c6a5c431495c..51f7a846d719 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -4703,6 +4703,7 @@ static int check_stack_write_fixed_off(struct bpf_v=
erifier_env *env,
>          */
>         if (!env->allow_ptr_leaks &&
>             is_spilled_reg(&state->stack[spi]) &&
> +           !is_spilled_scalar_reg(&state->stack[spi]) &&

Makes sense:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>             size !=3D BPF_REG_SIZE) {
>                 verbose(env, "attempt to corrupt spilled pointer on stack=
\n");
>                 return -EACCES;
> --
> 2.43.5
>

