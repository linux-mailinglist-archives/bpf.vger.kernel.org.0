Return-Path: <bpf+bounces-34313-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA5E92C6BC
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 01:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14CAE28341B
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 23:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E5118563A;
	Tue,  9 Jul 2024 23:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYpir5Vp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6158E1474BE
	for <bpf@vger.kernel.org>; Tue,  9 Jul 2024 23:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720568808; cv=none; b=gYaRs7xVAU5DxuqwsYDCH8m4WfmwcSt76z9MZX1y95tppT8omO8b1s/TEmYMweVpO2dKPlo/mB1j+BzAaSN5F8Sqf9X6digJS8XQehnHFFA0fHqj5j/xhmrhPzCztDtxj0qG/SmyTS2InfKhDyeHCYooVEoNCNopoffxS8rEkf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720568808; c=relaxed/simple;
	bh=deuiscx/AchUQ8Ztmdap9QSGxuusnV7UaDZEV//hIL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sFoDL607zmQG/bKFuGz7dOFY00ghBStsGZcdxEeUI4ME2co2NQBDKVmk1D5quPUToHMWQWobKkqTuWvtFJXFu9E37EK4KFTeF9JZtKCAmTzQ7ilNjdjvOZsIR1DAIBJl8WNuUfQZT+QBaT+Ye48ifGWED2/YvZQbsWzle6Q8wx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nYpir5Vp; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fbc3a9d23bso6681695ad.1
        for <bpf@vger.kernel.org>; Tue, 09 Jul 2024 16:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720568807; x=1721173607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0CsglZlkB+enBZEQLFS1QV5ckMF/yAyT/mSSmbQLLas=;
        b=nYpir5Vptyro4ovPCeAmDWrFzCwep5YEuLhlRjfFWG6GbU2LY4GwEp/fikIuQhkP8u
         lVuSgx04RcmzoADbB8jbdihqdjHVk/zEx5O/6yBJ42S9yuAOWsUz8Qc8z8zzgq5aQrUU
         u1av13q/ZSOEvV6Ko4h9Plps3Ufm3zurP/CtZUSTSqQv2/ciHlYESKVJnX+EIKBh+HI9
         /qsxA1+z4QK/kz6wY7HH0EhrV87lJ+9JLIT0xo+uRMtYZV+KMoKNTM9huVmx7peY7M5L
         M//6BULGMlrat20f/i8S32/zwBHapaa50E8OE3itshm9Dey4T0nQT+QGyRZ5riQWUR5a
         hh+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720568807; x=1721173607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0CsglZlkB+enBZEQLFS1QV5ckMF/yAyT/mSSmbQLLas=;
        b=H6PIx71/gPiGqaHwzJtz0mBOJkMAijWMaASzl3xrIwO+hFkHi5qBX8FcgIQrEXlPbM
         FOfcNv4FggeEfW2VT1POqZGpO/+HxXl0llM+B9fkPGoUaM/qkBBDpmANigZ9rMAjDrGl
         rmjVYwqSmWmf81f39h1yj9tu/rmD/WwJogh5E5mmfR9DZPLUYonSndYdDoYeoUAXDqdi
         ZggC9Ww2NlAAwKKBwbAQF5EETfgSm81MIZhmxP872COI4KAcGHjCN1S7+I7hj1VGWtLc
         mXSNplc/gtOwtepN6JcON3T6rUXbulK7xBQ8kAFqeGMYgvR9qleHGvWMutqHGaotteOA
         DG/A==
X-Gm-Message-State: AOJu0YwnaAS7QMUKWxMG1dBH0WTa/n82A27p0q1HN+LCrd7jcg2l7wmZ
	XKHKviWKob5o9QhYdhgF7HCnaPdERDFvje6BI1+2h1m/KD1/RLggPNSamzha8nzB0ZyeHl+4bW4
	75IrdsypvUbbBCDW8QpyCLQXLG5o=
X-Google-Smtp-Source: AGHT+IEjHeMoaZe7uZYsvNp2mtQmZJxRBvWe6md8nWMxeZq3y89cQZ7rkZ1lKSv73KQ4FSoNHXfOKdko78xN3gL3R1k=
X-Received: by 2002:a17:90a:de8b:b0:2c9:6aae:ac08 with SMTP id
 98e67ed59e1d1-2ca35c332b3mr3108412a91.17.1720568806569; Tue, 09 Jul 2024
 16:46:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704102402.1644916-1-eddyz87@gmail.com> <20240704102402.1644916-5-eddyz87@gmail.com>
In-Reply-To: <20240704102402.1644916-5-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 9 Jul 2024 16:46:34 -0700
Message-ID: <CAEf4BzboE70mUuajJQe2S8Nzkvamk4Y3d=07KSvrdrLYv0r5Jg@mail.gmail.com>
Subject: Re: [RFC bpf-next v2 4/9] selftests/bpf: extract utility function for
 BPF disassembly
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, puranjay@kernel.org, jose.marchesi@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 3:24=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> struct bpf_insn *disasm_insn(struct bpf_insn *insn, char *buf, size_t buf=
_sz);
>
>   Disassembles instruction 'insn' to a text buffer 'buf'.
>   Removes insn->code hex prefix added by kernel disassembly routine.
>   Returns a pointer to the next instruction
>   (increments insn by either 1 or 2).
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  tools/testing/selftests/bpf/Makefile          |  1 +
>  tools/testing/selftests/bpf/disasm_helpers.c  | 51 +++++++++++++
>  tools/testing/selftests/bpf/disasm_helpers.h  | 12 +++
>  .../selftests/bpf/prog_tests/ctx_rewrite.c    | 74 +++----------------
>  tools/testing/selftests/bpf/testing_helpers.c |  1 +
>  5 files changed, 75 insertions(+), 64 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/disasm_helpers.c
>  create mode 100644 tools/testing/selftests/bpf/disasm_helpers.h
>

LGTM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

[...]

