Return-Path: <bpf+bounces-77656-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A01E2CECAD9
	for <lists+bpf@lfdr.de>; Thu, 01 Jan 2026 00:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F1B53013941
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 23:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75EE930FC10;
	Wed, 31 Dec 2025 23:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dyGPlc6J"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E88130F52B
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 23:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767224588; cv=none; b=IVrGbenFUNXito9+wesq+9scfJ7YpnLf7VZnLqgRqIGvIgCXfMqLAglnOlT5vFB3rzVb3Ug2Wmsp6SDr0/DmJrsx4sMbSeJKHZE04N8iqP+BmEaTwFzRhukrTQL2PfHQQlWEq0LTg8c2PnvgWNWLz2dpGuxkdVbynJS8jxduo0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767224588; c=relaxed/simple;
	bh=+0stAk6ImH/vJo9e6NcJEEmw0IMH+jXKAdlnG5vDVQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=opI9dcRR96zJe7nQHDbSddoXg8iOaIl4QUVQyyzs8bVK+/ZcwNQ5yUaeoJHF7ZnLNOZO3+RtS474NakC3V4aK2n9Gle7DqYIHmdHeMYygl8dzkH/vhqySONVjpFCIFYtinSObLsVwm4dDZ74pZZuVcxdvF1r2p2Rd33OGZD9KbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dyGPlc6J; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4308d81fdf6so5279842f8f.2
        for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 15:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767224584; x=1767829384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UCSjdjeP6wv02gMzLdG5ZEhqOeL47Bx23tYEHf0X0q8=;
        b=dyGPlc6Jw/OKb5cEjhtx4ukFyNwHyJyHyDMwQ9Wd1wKVe4hQEnVSGW1ApGEhhPsLHG
         6WGybhdPb9kqfu0Gm+uUzeI3/DTJn++BatTSlqHu7LSpH4k70UMaL48qLU6GBE6kLsmK
         JfLQqETeyE3NemXinGTW6R5w9eOffGmphlpfOgVjn70pON2Me9P1iCMFFEwe3dQIgfEr
         f3NMVXZdx9gZ43Wjyx4rhY9j2tHiTw9u2vIfvNPDQnAk0V4Hic82M/2hJQDTnaCx1dUy
         BYe+Ykj+7lyOyDnIjeT7LjP1YFl+wtQIqTOjDwTT6ImbGbHI9bGPiNHeNnHHZZsByOl/
         R/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767224584; x=1767829384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UCSjdjeP6wv02gMzLdG5ZEhqOeL47Bx23tYEHf0X0q8=;
        b=sIoLvEDS1g3aaCbJWteyXnGrMA3omLAubQ03mZdFPWkBsClmK0fEc+/ozeWptK+/hU
         HC2twYQF4UCGyFNWiH2v7xDPLL9LEa5w+EVBN5NfneaUSm30poS7lUsrYgKyzoe/sraL
         FpAw8uc8BOo7rNyOpyq24VfufAsgxMbaonCtiGDsjEYq2Ru+4tzRZazEBhaxw7g1Jlnt
         1Q9QwCQIcXOzI+CfRPe0GIXGYN42xbtbM4F4yl8eK5oPKNtQU/2+6WrOZvvWibBjosUT
         OZS5+ct1K2zLN086UGzrD1agiyo/eRUcXDgKlk1P361eiIbfl0ELK5/h5lhVz0Gvs84k
         fedA==
X-Forwarded-Encrypted: i=1; AJvYcCUzhPKPRDrn9YDOkvwFZLw2Q7zuCJnq2Yi0ku92l1A2jQVuctbT5r0D+u9+4s35J2LMhbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuG2UI3gCw6AZmTp0K/mKmUv0NMAmUoXEMXJyK9M1fJBMbxHM0
	N1TDSUYClFC+YP6HLhXPhKpoNRKUsAKzgcsMgZOMB+0AnEf6DjEGGprcuT8mjCLUjmBHb9pQrW/
	ve06/PxA9/zdm+ET98CglPjMe0ieeuJw=
X-Gm-Gg: AY/fxX5NBMPynMxGhnTTc2lq2ormG0EMb4CeOjUGe5HHjNh17SynUWLQxYLteJxFldP
	LVNNkmRig7u0IZ0dzUAhbVg/iJSmGPz3neDACVb3UqB7RsLg3eMkyeleoDwK0zdOxD8Sj5GMDcp
	AM8Q9UJ4NbaIoxYkQm9yz03tcBqgkVYwF3Tfft19tUczUUTbV6c0M0g+M9sgMfXZ3zdLTxZVv5r
	MX0wiTy57r6BG+dWKmM2tafZfEtZAEoMicV/Tt79/yn29g/RABz9r5Qw4/5XlrVX3+ZfQ7aXKYH
	Kv0RKvugcQMA/qmIN1aTtXS7V39q
X-Google-Smtp-Source: AGHT+IFSbwiuD/i0T04F0mhar9N+XHMaBOuMG441ksaJapwgoq69pO7jteBU9Ee+Owfps+x47XBk8HPzvgUPAcrlvIc=
X-Received: by 2002:a05:6000:400d:b0:432:8585:6830 with SMTP id
 ffacd0b85a97d-43285856833mr21138853f8f.45.1767224584320; Wed, 31 Dec 2025
 15:43:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251227081033.240336-1-xukuohai@huaweicloud.com> <ce484a55ffa709dcfcacd631213b3b1ff1938c7a.camel@gmail.com>
In-Reply-To: <ce484a55ffa709dcfcacd631213b3b1ff1938c7a.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 31 Dec 2025 15:42:52 -0800
X-Gm-Features: AQt7F2pEUn4u1ZCW7Qjo-1BH08YdoY8PZaZbgP_eGT8UGzret5RJ_2GdRsH0sV8
Message-ID: <CAADnVQJp7bqUynwYtmbuCJVbMoN++Va63OA+8NFgW4PoPKRgKQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] bpf: arm64: Fix panic due to missing BTI at
 indirect jump targets
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Xu Kuohai <xukuohai@huaweicloud.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	Puranjay Mohan <puranjay@kernel.org>, Anton Protopopov <a.s.protopopov@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 31, 2025 at 2:35=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Sat, 2025-12-27 at 16:10 +0800, Xu Kuohai wrote:
> > From: Xu Kuohai <xukuohai@huawei.com>
> >
> > When BTI is enabled, the indirect jump selftest triggers BTI exception:
> >
> > Internal error: Oops - BTI: 0000000036000003 [#1]  SMP
> > ...
> > Call trace:
> >  bpf_prog_2e5f1c71c13ac3e0_big_jump_table+0x54/0xf8 (P)
> >  bpf_prog_run_pin_on_cpu+0x140/0x464
> >  bpf_prog_test_run_syscall+0x274/0x3ac
> >  bpf_prog_test_run+0x224/0x2b0
> >  __sys_bpf+0x4cc/0x5c8
> >  __arm64_sys_bpf+0x7c/0x94
> >  invoke_syscall+0x78/0x20c
> >  el0_svc_common+0x11c/0x1c0
> >  do_el0_svc+0x48/0x58
> >  el0_svc+0x54/0x19c
> >  el0t_64_sync_handler+0x84/0x12c
> >  el0t_64_sync+0x198/0x19c
> >
> > This happens because no BTI instruction is generated by the JIT for
> > indirect jump targets.
> >
> > Fix it by emitting BTI instruction for every possible indirect jump
> > targets when BTI is enabled. The targets are identified by traversing
> > all instruction arrays of jump table type used by the BPF program,
> > since indirect jump targets can only be read from instruction arrays
> > of jump table type.
> >
> > Fixes: f4a66cf1cb14 ("bpf: arm64: Add support for indirect jumps")
> > Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> > ---
> > v3:
> > - Get rid of unnecessary enum definition (Yonghong Song, Anton Protopop=
ov)
> >
> > v2: https://lore.kernel.org/bpf/20251223085447.139301-1-xukuohai@huawei=
cloud.com/
> > - Exclude instruction arrays not used for indirect jumps (Anton Protopo=
pov)
> >
> > v1: https://lore.kernel.org/bpf/20251127140318.3944249-1-xukuohai@huawe=
icloud.com/
> > ---
>
> Hi Xu, Anton, Alexei,
>
> Sorry, I'm a bit late to the discussion, ignored this patch-set
> because of the "arm64" tag.
>
> What you are fixing here for arm64 will be an issue for x86 with CFI
> as well, right?
>
> If that is the case, I think that we should fix this in a "generic"
> way from the start. What do you think about the following:
> - add a field 'bool indirect_jmp_target' to 'struct bpf_insn_aux_data'

makes sense to me. u8 :1 pls.

> - set this field to true for each jump target inspected by the
>   verifier.c:check_indirect_jump()
> - use this field in the jit to decide if to emit BTI instruction.
>
> Seems a bit simpler than what is discussed in this patch-set.
> Wdyt?
>
> [...]

