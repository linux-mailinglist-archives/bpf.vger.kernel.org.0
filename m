Return-Path: <bpf+bounces-35994-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B152C94062F
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 06:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 625501F22346
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 04:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4AB4824AF;
	Tue, 30 Jul 2024 04:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VupqGauX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0FC14F9FF
	for <bpf@vger.kernel.org>; Tue, 30 Jul 2024 04:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722312206; cv=none; b=ra29nzer9u5tMcff8aerQcqIRiXdsc8QWqwWn+iW4ZxOqV32aRCl6h9ZcI96lRFRLR3rikP7lrbqtqS5h+39XnN/UwpXZkgD3h8HXfTOJalEp+x0lbx/3YT6GW+3USkEgtkbht1ODp73MJbvBu9U3Y5wl916neHizobr0T5zewI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722312206; c=relaxed/simple;
	bh=Z+SMYeydwX1Qzl1Cy8MC1pcDBex74AHSy/EUw6AbNVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fkVaWwicvEQjcaHaUGSmkb/MQyE3AVmp4r6z2RQF4cvcDwsODCjW/LyplPyhuJcltD8uiAiDE0G35HUmTL4LtzZGuTJfyg53US2itjDADFmjGqBFaAp0eFBB8x6WKnj7tbLJBGY7dqIcdHFrpDHPAzRxUrUkxJFLJMU4yGhmYCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VupqGauX; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3687fd09251so1829794f8f.0
        for <bpf@vger.kernel.org>; Mon, 29 Jul 2024 21:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722312203; x=1722917003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o2Vecz+P6JqpnNnEp4EQHBcBAACXpMapuvyrxi3d8U4=;
        b=VupqGauXGP+emASj45+TWVYXg+taOGOpTLbaAxlzNXU6BrG7Bnd6EOnpYmFT+gXEW5
         /LCvaxBBMR89xMUt14DdpRRxwb5sOOmfRUaSoTfPdSbq2AmDzCDgmwJuATmvHm9FE9JS
         qW3yW+Jk52b6amDoueFj5WYmvFqm8VvaAtKLgCKSyuh5LlgGWwavTTfHqPXJuy9LAVkH
         M3GGH9+tNn6fs2x+nJul7hrwNf5FMRTwqCEy+HIfwf2tp1ECa30HkjSdMQxl5dMaQCWb
         LN1qbcyoTUH7lPDMTxtAo+7BUZT7C8bydhpJcQdgdkF3HNcoSUoOd/pcOyAb+K6AzMc5
         mY6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722312203; x=1722917003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o2Vecz+P6JqpnNnEp4EQHBcBAACXpMapuvyrxi3d8U4=;
        b=q5S2QNu9hnGn8IXdx3ZflTUhebybywA96inURuw042UuhZV2doZBYKynNDyWA9Bog8
         jbg1LcRPjvTiKDnEXQx46s4DHlLxV3K3tV+7wWlrjvfr4kCRScb5I6ZxCfFSHIcH2m1s
         M03CKu+LBz3Q5E0UMirZjEn8+KyK0DhCzLkS1ZTv8pR2WOE1dgQudpZpHV229Q9ssYWx
         ykOBgYa0Ro6xQdpyw5t2U6mivMDu2v5+yYpIA7lp5ZqhO1oTFkQxdfZfZ0/vxt6Fin+Y
         4VHOZpnuBeT/ZJhkTFZc1U/0b3Ie+JC0DvK/TGBTiW3l1QJw/p6AOKpZALjJ8iwbRz25
         z/fQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1FpL+N/rJtCFnKoY/Mzkd+q3MzitbM+9lAym7BxcmmITU3/TlnEKi6tMyVHMYND3JZWYEKH5O7AHhc9p8FjaHX05E
X-Gm-Message-State: AOJu0YyZiPs2jkYkKM0hXls+bmLo4lM5IroTWvrSyl3/6lg/E/MPFcGc
	IVkbJadY5ZsI0MBW5AZOZK/KqoQqM56b65fe3kytyzR/32cZ30haqY4ErY8ng/ThjEzgResgGAU
	n30EWyfwc5k5gq9z0p7oeC7Xwb3g=
X-Google-Smtp-Source: AGHT+IGO345CxwtAhr9PNXDBFptp7P4PTDrr9iJtJT7HfJV7wSlBlTGT+bYArE/ZSKcHiLnbyJw8p0XzRsfG2uigeZE=
X-Received: by 2002:a5d:6448:0:b0:368:6562:9024 with SMTP id
 ffacd0b85a97d-36b5ceeeb61mr6774974f8f.18.1722312202675; Mon, 29 Jul 2024
 21:03:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729183246.4110549-1-yepeilin@google.com> <CAADnVQJqGzH+iT9M8ajT62H9+kAw1RXAdB42G3pvcLKPVmy8tg@mail.gmail.com>
 <9fd26a67-f39f-4ff7-b433-612351e5ebc3@paulmck-laptop>
In-Reply-To: <9fd26a67-f39f-4ff7-b433-612351e5ebc3@paulmck-laptop>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 29 Jul 2024 21:03:11 -0700
Message-ID: <CAADnVQ+ro9KetgBU7GrFnXhRgmq4FqJoiVAjQ+rgThzfemP7jA@mail.gmail.com>
Subject: Re: Supporting New Memory Barrier Types in BPF
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Peilin Ye <yepeilin@google.com>, Yonghong Song <yonghong.song@linux.dev>, 
	"Jose E. Marchesi" <jemarch@gnu.org>, bpf <bpf@vger.kernel.org>, Josh Don <joshdon@google.com>, 
	Barret Rhoden <brho@google.com>, Neel Natu <neelnatu@google.com>, 
	Benjamin Segall <bsegall@google.com>, Alexei Starovoitov <ast@kernel.org>, David Vernet <dvernet@meta.com>, 
	Dave Marchevsky <davemarchevsky@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 8:49=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
> > > instruction with 'asm volatile ("" ::: "memory");' semantics might be=
 tricky.
> >
> > It can be a standalone insn that is a compiler barrier only but that fe=
els like
> > a waste of an instruction. So depending how we end up encoding various
> > real barriers
> > there may be a bit to spend in such a barrier insn that is only a
> > compiler barrier.
> > In this case optimizing JIT barrier.
>
> When reading BPF instructions back into a compiler backend, would
> it make sense to convert an acquire-load instruction back to
> __atomic_load_n(... memorder=3D__ATOMIC_ACQUIRE)?  Or the internal
> representation thereof?

Internal representation?
We need to pick asm mnemonics for ld_acq insn, but pushing
C-like asm to emit __atomic_load_n() in disasm is imo too much.
Currently LDX insn will be disasm-ed to r1 =3D *(u32 *)r2;
For load acquire insn we can emit r1 =3D smp_load_acquire_u32(r2);
or r1 =3D load_acquire((u32 *)r2);

