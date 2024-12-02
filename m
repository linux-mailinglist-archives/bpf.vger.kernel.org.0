Return-Path: <bpf+bounces-45951-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D609E0D23
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2024 21:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 392D8281F41
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2024 20:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA591DED7B;
	Mon,  2 Dec 2024 20:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mr3WGCxi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508651DED4E;
	Mon,  2 Dec 2024 20:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733172003; cv=none; b=ikcEnk3s+uzJWawjtz8+5eLIWo2ZRgQvha+Vg7ksT24oDJpRsR19ZaI1RMxgEgtUO60jdMgFCmxRFP0dQePRooZF4j4JThKlYsSFWAHPAQrpeQoCRb0oEHJmMOOVvoiaskgER3jgdwGPwR5G48f8yZs54h2YVqrSE9czxmepXTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733172003; c=relaxed/simple;
	bh=cyxcPd52gACP8SxGjZ4luSPaose5u0/LNbMFAm5Cf7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Md2AMMajTU93qI06RBfy/ItT4ByijZyi7ydGm/RjfXCm5ACBuQGGLpChPDzoh89J78DAZ6cy8Ymp/WyiXsiqSMr8it/gknqbkM1ZOsoU59CtyJeh1OuOOT29PvFdMz9Seh+qFXIzKSBCW4cG4OOtp26nMle/VM0hykBH+71XXO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mr3WGCxi; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ee6abf124aso2606397a91.3;
        Mon, 02 Dec 2024 12:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733172001; x=1733776801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bLRpz1Zk+hfN1AHa7tmG/5rj2S8mobqC+RuZhy+4X2I=;
        b=mr3WGCxiPWlALVF/GglKzjFGx8BTRMlH28HIsD3AWb+pcmVadn1IN9o0ohPziHNncx
         qsIkmWveC73wnJBWdcUbd6LO1KFy+PoHhgTtl8IGSv8hLqpq5Xfj9uktTqbpvPKiiK7m
         3X0eWHvfNB2TxwahYMouVUWlTvAJqtpQG0BvVTy1UdfvcYE1/EfD2IiLENNpWICIs7Gq
         QvlIxJ5SivFBlgbFjloqY4FHMwM+1MN5e90/iNlMrrWDdPzLveiORGTa7EVynMyovewn
         O4UX71uNciN0Uf2yi30eoZaJPvoo7ddnORxAxERtf1JGawkslxKteMMoXf3iMsr8wnxQ
         dfhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733172001; x=1733776801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bLRpz1Zk+hfN1AHa7tmG/5rj2S8mobqC+RuZhy+4X2I=;
        b=O86qA9fSdeWnRYBnBQo/D2jqDGnerMheZwkdwjvpnmtmyWEyifkSMmjhR5aGBlOnrC
         Hw7DVPQWnoCnIbw9e222egubkPKEp9c4GaCs3EWm41mMcL2gu3g9nyEEQ1RXRQOwjaZ6
         zMlJ+rWx2Q5jDRCYcyIQENT80Vb4OEkjJp1PF9j12ogWQeDIW51LWKRed01VJMCHhdYM
         2AvwuMQQ57H+evGNLbmIxPE/etCv5GrKIwi1DnGPI/+qsdwcS1oClBPP+a0aTrDETuin
         CBsStSU0A1POG4p7nDPJy2g6hlQnayMyj5osP+PAA+DHhK1B0M7SQ/crRDIYY7kNR0ff
         RV1A==
X-Forwarded-Encrypted: i=1; AJvYcCU4rKc15/8n42sFg9EPvSwNRHunzj9VmRQLD7FL9FM8xHYzh6XKm94YTPqMr4pDzhU6zVg=@vger.kernel.org, AJvYcCUGP2XQ4TutWJzeNTOu26lix4hIvV7JW+A2HEiFoKlTGhGXAwM9K/YvK69woluQ3inGrqTVIYSdBMcwLR+3@vger.kernel.org
X-Gm-Message-State: AOJu0YyLfe579LaaS4BbrMDVXmJOkES62Aa9jYaoIQUAA2JUCf+l3Rbm
	JkdrdsEJYDZFcf6B+mIBa9ZOJdh29t4z/sowQgnih7fMBZKZT0KJF7B/xk+w4q4vMgnGZyzlxLN
	0uRQsECe9h6BflzDISmyzEq3LFm4=
X-Gm-Gg: ASbGncsCif1PlAPXTUwWKjG5l1V7/dPfsB9r4lDtez+R09BNtgawyYKbOeJOFfwOdfn
	3/uixOqQCjgH445OMJNfzMzQCAE3k
X-Google-Smtp-Source: AGHT+IHmtqRzaVmAlDgjKyNEPsGkR13thUm6uPwrECK1jcapO0NEnL6jvuXlh2uXpxWOxWfIFYP5kAQjGVrojGvK4z0=
X-Received: by 2002:a17:90b:1d0f:b0:2ee:d433:7c54 with SMTP id
 98e67ed59e1d1-2eed4337dbfmr6055343a91.19.1733172001590; Mon, 02 Dec 2024
 12:40:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241129091003.87716-1-jameshongleiwang@126.com>
In-Reply-To: <20241129091003.87716-1-jameshongleiwang@126.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 2 Dec 2024 12:39:49 -0800
Message-ID: <CAEf4BzYAG320uwJrtehe-7j1vsta1JwHT9JJs_DcmX892W736A@mail.gmail.com>
Subject: Re: [PATCH] sched_ext: Add __weak to fix the build errors
To: Honglei Wang <jameshongleiwang@126.com>
Cc: tj@kernel.org, void@manifault.com, nathan@kernel.org, 
	ndesaulniers@google.com, morbo@google.com, justinstitt@google.com, 
	haoluo@google.com, brho@google.com, joshdon@google.com, vishalc@linux.ibm.com, 
	hongyan.xia2@arm.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2024 at 1:36=E2=80=AFAM Honglei Wang <jameshongleiwang@126.=
com> wrote:
>
> commit 5cbb302880f5 ("sched_ext: Rename
> scx_bpf_dispatch[_vtime]_from_dsq*() -> scx_bpf_dsq_move[_vtime]*()")
> introduced several new functions which caused compilation errors when
> compiled with clang.
>
> Let's fix this by adding __weak markers.
>
> Signed-off-by: Honglei Wang <jameshongleiwang@126.com>
> ---
>  tools/sched_ext/include/scx/common.bpf.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/i=
nclude/scx/common.bpf.h
> index 2f36b7b6418d..625f5b046776 100644
> --- a/tools/sched_ext/include/scx/common.bpf.h
> +++ b/tools/sched_ext/include/scx/common.bpf.h
> @@ -40,9 +40,9 @@ void scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_=
id, u64 slice, u64 enq_fl
>  void scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq_id, u64 sli=
ce, u64 vtime, u64 enq_flags) __ksym __weak;
>  u32 scx_bpf_dispatch_nr_slots(void) __ksym;
>  void scx_bpf_dispatch_cancel(void) __ksym;
> -bool scx_bpf_dsq_move_to_local(u64 dsq_id) __ksym;
> -void scx_bpf_dsq_move_set_slice(struct bpf_iter_scx_dsq *it__iter, u64 s=
lice) __ksym;
> -void scx_bpf_dsq_move_set_vtime(struct bpf_iter_scx_dsq *it__iter, u64 v=
time) __ksym;
> +bool scx_bpf_dsq_move_to_local(u64 dsq_id) __ksym __weak;
> +void scx_bpf_dsq_move_set_slice(struct bpf_iter_scx_dsq *it__iter, u64 s=
lice) __ksym __weak;
> +void scx_bpf_dsq_move_set_vtime(struct bpf_iter_scx_dsq *it__iter, u64 v=
time) __ksym __weak;

Ack, this is the way!

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  bool scx_bpf_dsq_move(struct bpf_iter_scx_dsq *it__iter, struct task_str=
uct *p, u64 dsq_id, u64 enq_flags) __ksym __weak;
>  bool scx_bpf_dsq_move_vtime(struct bpf_iter_scx_dsq *it__iter, struct ta=
sk_struct *p, u64 dsq_id, u64 enq_flags) __ksym __weak;
>  u32 scx_bpf_reenqueue_local(void) __ksym;
> --
> 2.45.2
>
>

