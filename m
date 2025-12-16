Return-Path: <bpf+bounces-76744-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63ED5CC4DB3
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 19:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10455306C737
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 18:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8463446BD;
	Tue, 16 Dec 2025 18:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCHE4r6O"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AEE3446AA
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 18:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765909021; cv=none; b=A+iePQSXIVn3Hj5WQdAgjIBFWV3UkDkbmglNMvyQ3abTC7EypO5vspHYL72H8gThc5MASDwX5qJVP3Dnc1wGXGNqUrG0mXjqhycsxyw0dVsREjY8j6CqSq4Rc2iwDrzDF8Kk2lQMhd6GgYwqIovpcNUNM5n7sWpkvHmJrMFRDLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765909021; c=relaxed/simple;
	bh=KvCMie/6qcZHjHhCk3Px+lZVz1Tyak43ACcklwIW9VA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ub6GWYqAYyRDeibkfKz/PGSVrV7HceUt4X431RdPLDsf/dj7qNmr1Z7TTlyDhDBJ/eH2wrDe+uavB7MSIlHQQXYQiGvfxH5zjkv9aWRGKr+IFATU8xim3TePbaIHoDw+lVJEArH212DeHxUIfELLzks3lOotBNCiEKW/t2+HwEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QCHE4r6O; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7f1243792f2so3294069b3a.1
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 10:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765909020; x=1766513820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DqdwfT9jQv14SWCzH+5xSCjiylSXLId1RXHgfGmZ+fk=;
        b=QCHE4r6O+B8T5PnCLcHsNE469pBrVANQxXtxZv9DySffwlVvvp5z2FXw0ubwYusK1e
         mTOILqQGYb5rM9AwKE3lqSXukARAm/PFqgTe09VHwz3W3udMCW8sAMI/YFjPl5OErYfF
         6Q1y0jnDs+YU02MH+hUvAepniSB0VBC+EeH0kMNI6sSiq81sDVUG5BH3KrKogTSAz0Mz
         8F8MspPzENnzyqH0xahlMq2xiM7jXgjc0d/CzuwmDQ68o+vJMBk8fD6kjYpK+3cp4XrW
         cPEtfWGy26IoJLzOsR2lQzgJenw0BRlKDAqQ6UZNjthBnLOrUgiFnVd7XMmxcUA3PCJ7
         3xkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765909020; x=1766513820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DqdwfT9jQv14SWCzH+5xSCjiylSXLId1RXHgfGmZ+fk=;
        b=a8PaZfOhioYvnTV96ra2LbIjxr9X3/IbmrM9Et/FnrYa7eiwp4gfYyAM/6cYihhIvX
         MZCeXYPYJgfmKzNUnWGiBr5dC+/axKn0C5e47DVFEYwWIgcL0nSqBKfpB1psL7Dt3x5h
         StF8MIrxb/XdOW0vUwF9vsK2KZ+Vl/Q7cKhNdwpBkjxPWamVzPMzv0GXOgSSn6G4CE/g
         l3kbnrovD9EE9wV+3YBSMbiY0oBaa8/NJcg+0nD8S8tQOKOo436AA5wS5X8jtZYQo5Gj
         e8fXzNEESgIFvoWfoMUbgkRW/IUG9Z9cfl1cDmqkra8sr1TeALhZhey3MqGt8ubsGyS9
         gj5g==
X-Gm-Message-State: AOJu0Yy1GDBQSaSb9O2Fk2pck5mfQf/AcwcwHYk89WWYtLf4JQRxbbLZ
	PMyP1/K2ecW6U1vbjQeW5PUJbLRThLT8fyh0PFwGXXdb03UVvs2mAn7G8LoecHDNF3MBky8s0UG
	nm89ErLebqPlFhVhwELL+DS3aE9v83uo=
X-Gm-Gg: AY/fxX4SLP/lubbuZO3XJ+ikHM+6gEonVZNFrBYcaRyWbfFZ4fn/oTFLujUgL4q32FT
	DXywxa03yZLLEwMsIV2Uq5nNLnIfIDEmjtMQueFbUzlZomu9GPvWDgbQcGGlPp42hBjAAA8tCau
	KnxMbEasX7y0g+YRgFvxVHn0RFhngDQXoVoBoT/GRlYpFueWgFBV+S/xctPABz8aYUwfDJFFw7+
	+4Sl9pGD8EvalSWrS1f9YzFINcdwOBS4wbru6RBiP/CRy0hZ/TiSdvR66ysRFf0f/4B5sKfa/Rl
	X6by1naqWQQ=
X-Google-Smtp-Source: AGHT+IGPlVPwrzSdeGZl65PGmpEh+HjErNUvKnuS53Fu7z5APtZFChtUYfm2RrnzI0QL7QktR/aAVL+xvxr1o7nZbfA=
X-Received: by 2002:a05:6a20:2443:b0:35d:d477:a7e9 with SMTP id
 adf61e73a8af0-369ae0ac3acmr16280227637.35.1765909019519; Tue, 16 Dec 2025
 10:16:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1765343385.git.skb99@linux.ibm.com>
In-Reply-To: <cover.1765343385.git.skb99@linux.ibm.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 16 Dec 2025 10:16:47 -0800
X-Gm-Features: AQt7F2rnNRMrfQOUmQAMtLTW3ciVgE59OOt1kNPKB6b0_n4gpnuuStY7i-VF9zM
Message-ID: <CAEf4BzbiyJwSoaSRDtSRetze-yST-NQX83FyECSmRex9szx0NQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 0/2] powerpc64/bpf: Inline helper in powerpc JIT
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>
Cc: bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, hbathini@linux.ibm.com, sachinpb@linux.ibm.com, 
	venkat88@linux.ibm.com, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	christophe.leroy@csgroup.eu, naveen@kernel.org, maddy@linux.ibm.com, 
	mpe@ellerman.id.au, npiggin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 9, 2025 at 10:51=E2=80=AFPM Saket Kumar Bhaskar <skb99@linux.ib=
m.com> wrote:
>
> This series add support for internal only per-CPU instructions,
> inlines the bpf_get_smp_processor_id() and bpf_get_current_task()
> helper calls for powerpc BPF JIT.
>

This is marked for bpf-next tree, but I think this should actually go
through ppc64-specific tree, is that right?

> Changes since v3:
> * Added break after computing per cpu address so that the computed
>   address is not overwritten by src_reg as suggested by AI bot.
>
> v3: https://lore.kernel.org/all/cover.1764930425.git.skb99@linux.ibm.com/
>
> Changes since v2:
> * Collected Reviewed-by tag.
> * Inlined bpf_get_current_task/btf().
> * Fixed addressing of src_reg and BPF_REG_0. (Christophe)
> * Fixed condition for non smp case as suggested by Christophe.
>
> v2: https://lore.kernel.org/all/cover.1762422548.git.skb99@linux.ibm.com/
>
> Changes since v1:
> * Addressed Christophe's comments.
> * Inlined bpf_get_current_task() as well.
>
> v1: https://lore.kernel.org/all/20250311160955.825647-1-skb99@linux.ibm.c=
om/
>
> Saket Kumar Bhaskar (2):
>   powerpc64/bpf: Support internal-only MOV instruction to resolve
>     per-CPU addrs
>   powerpc64/bpf: Inline bpf_get_smp_processor_id() and
>     bpf_get_current_task/_btf()
>
>  arch/powerpc/net/bpf_jit_comp.c   | 17 +++++++++++++++++
>  arch/powerpc/net/bpf_jit_comp64.c | 21 +++++++++++++++++++++
>  2 files changed, 38 insertions(+)
>
> --
> 2.51.0
>

