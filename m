Return-Path: <bpf+bounces-73417-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 10AB7C2F842
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 07:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C42F84F25FB
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 06:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7DB1A9F94;
	Tue,  4 Nov 2025 06:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQPm7gJR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1E92DEA83
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 06:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762239199; cv=none; b=gx83bIyRkQVxSXNAH1WwJKsjPEWd75ZuenzMfqdpVJt+Xg17axj3k30Qz05AmQ99eYYfKYnNB3nHGE6z0QJ6AwnQKvZmpGwfncjJb0frRFAZx1g2cgidBSRZ6CNkbAFmcbaHqsh1M8tacNsuJsGOLQmfKpEtzi8hkqQMbm9v/sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762239199; c=relaxed/simple;
	bh=8p0MCf6z8owtO8dtPW0HAmvbfGUyTkXxQfEU6TFdLiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=myNjvD1tCpDbNCVcZNRN9OJKMnGd1hWyAZfJsiRQTqoLQC9iBXTQDO1Jt/8DOh4kNLOcwe0CzpfGtqy+N3G51p2b7v4m851ylpAdL/dkmt/KH0aR9vYXI0zqZcVslNbfNZF1eMxulnpkDqbXMEjy2pxBfSL5+JZtrcNGDwr2uOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQPm7gJR; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-373b7e07182so3504818fac.0
        for <bpf@vger.kernel.org>; Mon, 03 Nov 2025 22:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762239196; x=1762843996; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yunsIVG2xwSWPJMISQ9png0ZDy6Yvl2IENc61OHh6yo=;
        b=QQPm7gJRofS9D7nRw7wDMcJlvvp4BRJ7YHUqz6RvqdkJawLZxIgJcbO3dWCXoELFIU
         r/SdWtzVCMOuVmmqtmItfYBQKSp/Jw8pACs3yiIUS9+bxoELE8f9iKdBn+CFfQ8VxP0O
         RkEtwf5SjcQG+zKYGaWzps3uXxj7EvP6YJWq/Y8Kfg5cQm246RTTENMJEd3euywR6B1h
         bQ59VcozYZMYS2FdjcDo8XJJ4oYTPQD9dC38Kg5tjsB9z0syk1kqZ2vk00rQVJGXcmJY
         y84u2WHQl1ggkG/e72/d0JRvtf3uhyRWM8ftqEuZpI1VgE/CILT4lBq50AoTF9J1oCOu
         M2Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762239196; x=1762843996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yunsIVG2xwSWPJMISQ9png0ZDy6Yvl2IENc61OHh6yo=;
        b=WRMfdeoKI5aMv5Fsx2jLaE3Kp5+f8AouTy4NvBhqmqQ9+M9eVO0wTXVFRL4cR969lB
         BUCxojnKjpd4I/MLClccv0a+sHboZR4VQw3ms+vsOKdEIO+dtip9EdabFakrSko9SQFQ
         cYmvopxHNQNNvC0MAEcdFblNJa0uKeChOO0FC5/AXBnh744I5vV3dmXY4bUWiMOcX42r
         fCTSr6nVbI2H9qRQSc3jh2iDC2FIVFBCpILHoeCa00favPQnzU9BgZKEFvk9PMan2igi
         7XWjLF8uL3VxDwbOn0UyyOlyyNfqUsIwFoEG9mimgFakti7s82Xb0a+mhWQl2DvrOF8l
         4aUA==
X-Forwarded-Encrypted: i=1; AJvYcCW2yoJVbnwo1Q24PmMqJ3NrI6wYCwIJIQvTlNnOJ8txq2YgjlMcj8r+VPTS3iHfbJ9azto=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoEizZKYGOjiA72GoVwXwINhh5RkFY3/IU7x+U8O+PrUxvHmaG
	9hi5AVu9NVlKG3vV27fTzztsnCYaSUfxbEiVdB50hM/47YhiLnc5Aq3p8TwOMYNCvQ5tthBKwGj
	sxDNLlgoFhTL8BzlrU23oog9XrC9u5ro=
X-Gm-Gg: ASbGncvmRnah4IN8XaXreYb0gYgdOWhYA3tNBU94cQAxCFttnIhEBVRNsl/8z9QLVmE
	A18cSipyhhcnjJ0tBb85rdGZGksQmSlrneNISUiwHqbosKXb/FRaEYcIip4cLmytSM0qDAq+/wu
	Cx169Y9NO6a/7uE15TmLdI8faouK8r2M+r1bP0J2LQi8aF4i90O+j+OjDQMHsI7hu7Rc+Fzdm25
	HAsER1+EjyTa60lk7ielsE+LScGauvy0h6hhdUCjbr4II9lzhfaZrpYpBINo8Es5EWAtg==
X-Google-Smtp-Source: AGHT+IGbn2X2/1JEEhqo1wnJ78iL2FeGF989Bo4JAY/FmMP1S8eKH8fgHgNdc4dVIuvXBjYdomI/sa/SfD70vvNJUAI=
X-Received: by 2002:a05:6808:10c3:b0:43f:7dee:4693 with SMTP id
 5614622812f47-44f95e27868mr6890297b6e.14.1762239195781; Mon, 03 Nov 2025
 22:53:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103-1-v1-1-20e6641a57da@linux.dev>
In-Reply-To: <20251103-1-v1-1-20e6641a57da@linux.dev>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Tue, 4 Nov 2025 14:53:04 +0800
X-Gm-Features: AWmQ_bnyRUlNuwLxwBl63QPbG926jSDDFvsN0rhY6T22CSGWWq6GN0Hkme8uPf4
Message-ID: <CAEyhmHQoLF9dcZ2CaasrpeH7RMiaQKyo0pFTrr7Nt1T64+dhuw@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: BPF: Fix sign extension for 12-bit immediates
To: george <dongtai.guo@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Youling Tang <tangyouling@loongson.cn>, bpf@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, George Guo <guodongtai@kylinos.cn>, 
	Bing Huang <huangbing@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 4:42=E2=80=AFPM george <dongtai.guo@linux.dev> wrote=
:
>
> From: George Guo <guodongtai@kylinos.cn>
>
> When loading immediate values that fit within 12-bit signed range,
> the move_imm function incorrectly used zero extension instead of
> sign extension.
>
> The bug was exposed when scx_simple scheduler failed with -EINVAL
> in ops.init() after passing node =3D -1 to scx_bpf_create_dsq().
> Due to incorrect sign extension, `node >=3D (int)nr_node_ids`
> evaluated to true instead of false, causing BPF program failure.
>

Which bpf prog are you referring to?

> Verified by testing with the scx_simple scheduler (located in
> tools/sched_ext/). After building with `make` and running
> ./tools/sched_ext/build/bin/scx_simple, the scheduler now
> initializes successfully with this fix.
>
> Fix this by using sign extension (sext) instead of zero extension
> for signed immediate values in move_imm.
>
> Fixes: 5dc615520c4d ("LoongArch: Add BPF JIT support")
> Reported-by: Bing Huang <huangbing@kylinos.cn>
> Signed-off-by: George Guo <guodongtai@kylinos.cn>
> ---
> Signed-off-by: george <dongtai.guo@linux.dev>
> ---
>  arch/loongarch/net/bpf_jit.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/net/bpf_jit.h b/arch/loongarch/net/bpf_jit.h
> index 5697158fd1645fdc3d83f598b00a9e20dfaa8f6d..f1398eb135b69ae61a27ed81f=
80b4bb0788cf0a0 100644
> --- a/arch/loongarch/net/bpf_jit.h
> +++ b/arch/loongarch/net/bpf_jit.h
> @@ -122,7 +122,8 @@ static inline void move_imm(struct jit_ctx *ctx, enum=
 loongarch_gpr rd, long imm
>         /* addiw rd, $zero, imm_11_0 */
>         if (is_signed_imm12(imm)) {
>                 emit_insn(ctx, addiw, rd, LOONGARCH_GPR_ZERO, imm);
> -               goto zext;
> +               emit_sext_32(ctx, rd, is32);
> +               return;
>         }

This causes kernel panic on existing bpf selftests.

>
>         /* ori rd, $zero, imm_11_0 */
>
> ---
> base-commit: 6146a0f1dfae5d37442a9ddcba012add260bceb0
> change-id: 20251103-1-96faa240e8f4
>
> Best regards,
> --
> george <dongtai.guo@linux.dev>
>

