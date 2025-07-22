Return-Path: <bpf+bounces-64058-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D2DB0DEF9
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 16:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79901AC43C5
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 14:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A97E2EA499;
	Tue, 22 Jul 2025 14:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s5v6arL6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC7B2E92C7
	for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 14:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753194860; cv=none; b=oHBBNkeSCFgs9D2l3Tw7SYuHNpUlr6vmhIixfMbo2GjeVpmQdeIDJS8m0paw3ZGUxa+mh8R/4VfG49dsJZ9zv60UnocCMZG5JOK5o6owtv2mzZKaw+ZWhRlN4XeRH8Fc0H71xuWv/zPBzm/aN3BeTB3CMUN3fxiSWrUVz+rpY58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753194860; c=relaxed/simple;
	bh=tTaaoCIOiIiKq0geWq6x9SoXkVZFzNZhOavzs9Ddr2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JbnitUOWc0OBLCqONE2I3sJhZZX7hAATkzxgsJLMKZGjZ5Ujuz58tfEF+hB1F5/DjbLiJVNHBkn3P+24O5SrDOx2yc69Ku0aJ/vwdWirw98rSlv7PuzccRnXYfjShs0+6xYbQU1k0WUV/0ShgZ+XTOXz6mHSDaRMCzwl+1EeLGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s5v6arL6; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-235e389599fso224855ad.0
        for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 07:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753194858; x=1753799658; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTuXuP+3bZghdz+mkEOJA+9pHpr2ihbN2H3rGh74pds=;
        b=s5v6arL6EvWT3Z4BNQsMDHyQaJVcSFKr/DeoYANdZUwKSz7g7cHe3yr+6jAaBros+C
         Zi7/JFt4DVzUZLDXFASICFLt/zOkdlkF87NOnKWUIttrrALOhfX3MfxaEEXs4JSP4yHR
         JIO7j/5fsJeFEeUaaKJ2KSsckTys2DUrkLJs1QbuK0y3K74XO7IsoL/GShIaPn9lSZeB
         1Myp7BimhBu3Geiu4A35mAXMyPH3uRIXMSkCgLhNmRxz4ILmJHHV80xL28cqqJautJs2
         aUR4xajW9BCnZYKd926oX5K2cbSCu9hCenS6AUTRO3tk+ZOkbkmV3vIHQXj18TjznmHh
         CS5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753194858; x=1753799658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cTuXuP+3bZghdz+mkEOJA+9pHpr2ihbN2H3rGh74pds=;
        b=BfH1dwYSOyqJaDR/9j3opEMeBn8bTE5XK4aksYA98EQVDeSUSQK2Uo8SktmyGTpP5f
         ymcFu0cx1gZBYhvnVOIgNaVMpP8yzBwTFqv2R394fxLDPwIVan44IQAssqoNf2iK0c6R
         9zdaHSP8uUE5gsTJiFMgtz3qpQElXQcyeEC+hWl0PGrO6W1IZI+/945dm2fH1ym39vVN
         IRk98Kt/1IurMF2AaiHfVX1buKJpmqNODU4Tdl5l6S8WF5f4lxl5t7iCsAF8AOX7kVRw
         fAnHN8CdSCaWVylm8L0fAWy0NzVRlr8KV9IOx6SRt4Xpbb3IBCaCuXHn1gF3RcXXfFNY
         iF6Q==
X-Gm-Message-State: AOJu0YwPh5U2RzlzQekl7qMlRGVnVk0IxgtZ70Xp/UKBYI/fzeffoJo+
	o7ga/Jrewz2headC3I5XvNxmGv5DPb9RqnHe03mKz8RupzpTzOQT1zPICrLQ/V6LTXx9ACLC33T
	Dkp6mkPnOhlIo3pCJUfBN5xW8ob0Tr3voTV9S0uL+
X-Gm-Gg: ASbGncs+rr2TeGrSrocBkOCzJ444RhkUiJvmYjCww1KT0Aan6/znhRkAoACd+Mn983O
	TrwJurepWUOT46pGmgMr4hof3qYh6q/SE3xvz+s77+x96WV5+dkXsWhwHVLGp9KY72wa8JjFEqt
	Kq/NtxQt9U32xOJd0FVMcCjHXnZ0ASAmeN86lrwOI2yVFD5pij92YnIDWJ27vrxyORyzOZFBx16
	rv2
X-Google-Smtp-Source: AGHT+IEC0LjPp4D4nb/8yDJGDSW5ow7uyVR9e8P45jSv6/mggQkYh+PG6iWMUWSWD3lY3B0VJst7mPo59OeYvbX8olQ=
X-Received: by 2002:a17:903:19e5:b0:22e:1858:fc25 with SMTP id
 d9443c01a7336-23f8cf87d00mr3114605ad.9.1753194857672; Tue, 22 Jul 2025
 07:34:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721202015.3530876-5-samitolvanen@google.com>
 <20250721202015.3530876-8-samitolvanen@google.com> <74bd0822-c8c1-47cc-b816-78036abff8ee@huaweicloud.com>
In-Reply-To: <74bd0822-c8c1-47cc-b816-78036abff8ee@huaweicloud.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Tue, 22 Jul 2025 07:33:40 -0700
X-Gm-Features: Ac12FXx5EtR43-0uezus7W46478LtdegGDxxKuOynwE5VCpfViAuraSoEJ6DyfU
Message-ID: <CABCJKucpfQ2nsmo8npc96SAQeQbTJiMcseWA1L-oNEJzF=Hu0g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v12 3/3] arm64/cfi,bpf: Support kCFI + BPF on arm64
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, Puranjay Mohan <puranjay@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Maxwell Bland <mbland@motorola.com>, Puranjay Mohan <puranjay12@gmail.com>, 
	Dao Huang <huangdao1@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 21, 2025 at 8:44=E2=80=AFPM Xu Kuohai <xukuohai@huaweicloud.com=
> wrote:
>
> On 7/22/2025 4:20 AM, Sami Tolvanen wrote:
> > +static inline void emit_kcfi(u32 hash, struct jit_ctx *ctx)
> > +{
> > +     if (IS_ENABLED(CONFIG_CFI_CLANG))
> > +             emit(hash, ctx);
>
> I guess this won't work on big-endian cpus, since arm64 instructions
> are always stored in little-endian, but data not.

Nice catch! I'll send a new version with your suggested fix.

> > +}
> > +
> >   /*
> >    * Kernel addresses in the vmalloc space use at most 48 bits, and the
> >    * remaining bits are guaranteed to be 0x1. So we can compose the add=
ress
> > @@ -476,7 +483,6 @@ static int build_prologue(struct jit_ctx *ctx, bool=
 ebpf_from_cbpf)
> >       const bool is_main_prog =3D !bpf_is_subprog(prog);
> >       const u8 fp =3D bpf2a64[BPF_REG_FP];
> >       const u8 arena_vm_base =3D bpf2a64[ARENA_VM_START];
> > -     const int idx0 =3D ctx->idx;
> >       int cur_offset;
> >
> >       /*
> > @@ -502,6 +508,9 @@ static int build_prologue(struct jit_ctx *ctx, bool=
 ebpf_from_cbpf)
> >        *
> >        */
> >
> > +     emit_kcfi(is_main_prog ? cfi_bpf_hash : cfi_bpf_subprog_hash, ctx=
);
> > +     const int idx0 =3D ctx->idx;
>
> move the idx0 definition back to its original position to match the
> coding style of the rest of the file?

The const definition needs to happen after emit_kcfi, because we
increment ctx->idx when CFI is enabled.

Sami

