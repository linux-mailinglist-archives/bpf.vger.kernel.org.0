Return-Path: <bpf+bounces-77470-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC48ACE6FF4
	for <lists+bpf@lfdr.de>; Mon, 29 Dec 2025 15:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75502300CB86
	for <lists+bpf@lfdr.de>; Mon, 29 Dec 2025 14:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D0831B111;
	Mon, 29 Dec 2025 14:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IyvdzOfp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D2431AF06
	for <bpf@vger.kernel.org>; Mon, 29 Dec 2025 14:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767018036; cv=none; b=NXnfKh6NyyocOth5Xlvg5vJdW5a07f+mxvbk6L+GgANwzZqE1PtFaqGnNCD59MOo+TXo61C3vivbk8iCxG3rySFFc9pJ4dexHO3UAiCJLyDTxZfjkRlLhjNiJEN9o1tU0cmeCH1/k3jMMtiB1K3dEyrqxX6EWp3SJVsRRp/ddqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767018036; c=relaxed/simple;
	bh=5QJ++AFvmfogtrUN4a0fBMa5IvH0wJTZNpmYFiqxjs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ptjFUjHJJYLnU/mg/YCSAOBupRJlfC16Ko7p7CsJ1Q2jvpaYmhNBIcW1fwnq+qu5+8I+YwjtuAfFNy4qIAgbEq2iuyl2r5q99onSnlwh7U69dRXQsSbkj2S/Oac2TJbsr4+7/dCBK7cJ5uKjCcxvQPNpYCu8PnxsvNACbt58OII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IyvdzOfp; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6598413b604so5647456eaf.0
        for <bpf@vger.kernel.org>; Mon, 29 Dec 2025 06:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767018033; x=1767622833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e007yG2Skbf3KR5PzHmbwLjVdg3gkGjb1eZAPsdnqA4=;
        b=IyvdzOfpDicwEkOlRuLEIU6Woa9gdFrYUK//B5a5AdWuFnhNKRjMGe6m9iVacVG68T
         WNG+iCBpTOSnwJmW4azdIInGpXjRapI50lFXAfo7DQ6t14DZIayIRjXhSqWOV9gh5aOT
         0Tp0htYczd9F9Vqpd8o1TnBVjEl4Xx74uTfgWcSDN9t5pFP+lFmJ7TlCpRCrRnf5WWFa
         s8soJBmdsFPtYXRVbsb/LzwET2wzmAaAlgm8qEwRwf1LzKaREiBWJ3o/JWue4tOlj+Ld
         tRWisqf+FDCA+77Em/xYoTmJQsQUWkUOQ3fHlVniOiJgI7zQ/tMa31NPb79QXYIdJeh7
         +84A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767018033; x=1767622833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e007yG2Skbf3KR5PzHmbwLjVdg3gkGjb1eZAPsdnqA4=;
        b=tvB/J/jsxsJ1Sz4cg2WGeoFsLG+5FAPi7SXV+eyEg96iSLPxJmrGaiUHX8SSu9DJL4
         GVegOirY4kViL7Q2ggjpYH4wT1pgXoUF7Yo205WoLCDKIQ7aetEYm4E/xtYIUUE7gNG5
         1QcQFnEpKesp6oLyaDF0mb0r8On4SbqcDco8FzkrqvFkdbW9tJZTYrCE4K5BHKxs/mxO
         yrWcj2CByoevYDrSnaQ2LwFeyO57Ghev2pqXBs4YDZWDKDWlCAWy6SohxrQTFwIAZx9F
         VAUm74YA0KS6lcdz6EBDvbbkxLIshdqGvTB/wQxEhoyPXt/jGMD+fg9f2mNyuz5MnYdZ
         5opw==
X-Forwarded-Encrypted: i=1; AJvYcCWkgs8cJhm/ko2ZRM8+LUAtCJT6usUZewc+UfGjXrJoTNq6OaeYVKkbpt2Xud29cSbCyeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVXpHTFjdud1A4s+CLCRvWp7LIXeoP3f0UCKaRDCkYDdEZ6PcW
	EiDM982O6LYFjS79X923HKnMHiV1OM7yl7h50UpjU6lqM5huwmOvGaIaDx56ihgl3IZ+i+G2gZC
	Y+0KYU8d70Z3K1ETqn8qModPnyzXWIN4=
X-Gm-Gg: AY/fxX5TK/HZV1DJGYUHU/VoC2yX/9kjm+qJhefWatnEFZ7sFtJohIHPwXn9CL2jmwf
	3Wd1XOxl9jrhMMitATupPEJGy46JZ22bFIYbkT3ZZSE1Yz4ztcBmp+M0FAJRAjHEKwhWSspJn3R
	oK+e5jty09va6zlRtJLqL6OIY/jWSgJhZvIw6uPSa/7YFAap35GPntJZgp820YE4+2sqr8s2GNY
	nk/xQsQ1jlB/HCce13XzQUwJsbx29AyA5mghPzOO4Hc7o1lqEWXcqurB0UcgZy2GFF5ow9BIepe
	YobSvqU=
X-Google-Smtp-Source: AGHT+IGKy+9wP2on9xI54Zjjmh+IKZvqrskm+aim9BlDVJcgl1KL2yoo/qKbXq+mzLP/C8AuY1vCtfNQkHlPXn30BUA=
X-Received: by 2002:a05:6820:4d44:10b0:659:9a49:9049 with SMTP id
 006d021491bc7-65d0e98b91dmr10194949eaf.20.1767018032872; Mon, 29 Dec 2025
 06:20:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103-1-v1-1-20e6641a57da@linux.dev> <130f896382dc8f56ead371208d9809ec06c7400c.camel@xry111.site>
 <20251229150619.0000195f@linux.dev>
In-Reply-To: <20251229150619.0000195f@linux.dev>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Mon, 29 Dec 2025 22:20:22 +0800
X-Gm-Features: AQt7F2pXotyzAFjPqoQjGStWE5-z1P1HK15voye9z6KXgDW0dWQRUKTGXQPLlOY
Message-ID: <CAEyhmHTRVfDmwwH=_hPFUnFS-_ffALNUEVrSKiO9vEznfrUSSw@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: BPF: Fix sign extension for 12-bit immediates
To: George Guo <dongtai.guo@linux.dev>
Cc: Xi Ruoyao <xry111@xry111.site>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Youling Tang <tangyouling@loongson.cn>, bpf@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, George Guo <guodongtai@kylinos.cn>, 
	Bing Huang <huangbing@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 29, 2025 at 3:06=E2=80=AFPM George Guo <dongtai.guo@linux.dev> =
wrote:
>
> On Fri, 19 Dec 2025 17:33:17 +0800
> Xi Ruoyao <xry111@xry111.site> wrote:
>
> > On Mon, 2025-11-03 at 16:42 +0800, george wrote:
> > > From: George Guo <guodongtai@kylinos.cn>
> > >
> > > When loading immediate values that fit within 12-bit signed range,
> > > the move_imm function incorrectly used zero extension instead of
> > > sign extension.
> > >
> > > The bug was exposed when scx_simple scheduler failed with -EINVAL
> > > in ops.init() after passing node =3D -1 to scx_bpf_create_dsq().
> > > Due to incorrect sign extension, `node >=3D (int)nr_node_ids`
> > > evaluated to true instead of false, causing BPF program failure.
> > >
> > > Verified by testing with the scx_simple scheduler (located in
> > > tools/sched_ext/). After building with `make` and running
> > > ./tools/sched_ext/build/bin/scx_simple, the scheduler now
> > > initializes successfully with this fix.
> > >
> > > Fix this by using sign extension (sext) instead of zero extension
> > > for signed immediate values in move_imm.
> > >
> > > Fixes: 5dc615520c4d ("LoongArch: Add BPF JIT support")
> > > Reported-by: Bing Huang <huangbing@kylinos.cn>
> > > Signed-off-by: George Guo <guodongtai@kylinos.cn>
> > > ---
> > > Signed-off-by: george <dongtai.guo@linux.dev>
> > > ---
> > >  arch/loongarch/net/bpf_jit.h | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/arch/loongarch/net/bpf_jit.h
> > > b/arch/loongarch/net/bpf_jit.h index
> > > 5697158fd1645fdc3d83f598b00a9e20dfaa8f6d..f1398eb135b69ae61a27ed81f80=
b4bb0788cf0a0
> > > 100644 --- a/arch/loongarch/net/bpf_jit.h +++
> > > b/arch/loongarch/net/bpf_jit.h @@ -122,7 +122,8 @@ static inline
> > > void move_imm(struct jit_ctx *ctx, enum loongarch_gpr rd, long imm
> > > /* addiw rd, $zero, imm_11_0 */ if (is_signed_imm12(imm)) {
> > >             emit_insn(ctx, addiw, rd, LOONGARCH_GPR_ZERO, imm);
> > > -           goto zext;
> > > +           emit_sext_32(ctx, rd, is32);
> >
> > The addi.w instruction already produces the sign-extended value.  Why
> > do we need to sign-extend it again?
> >
> Hi Ruoyao,
> I tried, it's not easy to do that.
> It's better merge this patch, then consider next step.
>

The test_bpf.ko test failed, so probably this is the wrong fix.

> Thanks!

