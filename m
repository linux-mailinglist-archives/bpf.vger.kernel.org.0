Return-Path: <bpf+bounces-77662-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C6663CECDC4
	for <lists+bpf@lfdr.de>; Thu, 01 Jan 2026 07:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5185B3007C70
	for <lists+bpf@lfdr.de>; Thu,  1 Jan 2026 06:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7342264C0;
	Thu,  1 Jan 2026 06:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iilfxzqd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E951F2A1BB
	for <bpf@vger.kernel.org>; Thu,  1 Jan 2026 06:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767250037; cv=none; b=ry2Q1wc2oFHUaa0rdpebCxhLoNrouaDrBAdsuWknwoWgJwCyOV4erw+AYo5ybyv4RKjNEAOMfLoSPcUCdLy9B45C8gyQ6R9H0JIFphqI/RoLTJX8C7FZjCsDcpIR3EOYoyUzPrDABMPYVvNcZa1i7G5keiYt/ZFjqwRnovbKVck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767250037; c=relaxed/simple;
	bh=ATjO1UhJyMMtmvFka3tftyPnmIYerwlGFpnQk/gKMwo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FeVC3Qf5rl0fXinMSFJslvwsiqb4Ei3XpueDRhLhbG7vDGBojwoqI1nfw1jAjhd0YPcx88GKLoYBDaQbC6M3+l1ywA5yJ2e+DO/fIfXf0v9Fwr57mrqWBc1IhAnPB+qn0x4QMHquXyQvtFIw4oZUivt8WbsGIgW+HKAiuLxCRjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iilfxzqd; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-78fba1a1b1eso135583327b3.1
        for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 22:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767250035; x=1767854835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mb06TLmZ6pBItnpUEEfjEYhqebLE+edRh1t0ZqeEVsc=;
        b=IilfxzqdgYCdRTGakonK0sIScjQ7qHgIR8U8RtPplf0nxEmJoCBXDkpEr6nJaSxHyf
         Tp627E3oTs/yP835dtEjL92g5xvTocl4Hq2/B5KD8bsvFIp6twW7Tx2ya4Lm0AZ+UInf
         LTyBL7WLHOT6wpx0ptcarB0AsJFQrjbFHPPQjGcMUMjDGf/3heOZlgs4mply1lTGqjwP
         AejR5ZFEjIFt4HJbQdcRB+QM4T0E6KNF+81T+kPlb7dRT6XIg5b3w7Oo5mD6S0lNLCmL
         09+qz3DqZxHK9gCnFGger/z7fsDM54E9gmga+Fh+vowkYPV3lK29yoNrrc6UDncM0rIw
         epkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767250035; x=1767854835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mb06TLmZ6pBItnpUEEfjEYhqebLE+edRh1t0ZqeEVsc=;
        b=RwK/KvDOBvQtrw8Uzwqga9mEY7izYamTRQLy7HHFs7vf/SG3Sg0XGNKZR+b97wvfMh
         xFbASNoKXWh7uAGPodZv/mQ1+T0KB+Fi1P2KLbgdb1/O3ajWTKd2RShjN6mFrbmIaaQ1
         xh0FMBmkZnlxkk3u3RUyE8YKLVnpoc2DhYgdhFqDVYE3r+93sde/Nphs0QHm1bAVLfS4
         tpEbUS0xtaPAJfip5JJuCiaWls8V+m/MKsy0rjCnSW1LsSKNcXMUARRQkmy1VNhFy5nG
         MtFwHmqgq5u+Uyva4V//qPBfgVsnLBO034l0MdQPELPpEZDBg6+nGH80TERZ6bHcwZV0
         tYcg==
X-Forwarded-Encrypted: i=1; AJvYcCWaoPUwB9w2xTHBdUvM4s0fDWYsCbH9Xliicq3zw11HHXf470KCCG6sQeOrDIXEMXDLwiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQCBJ88c4VKOZtuY0PxN0lcPOz8TDZwiztYrrUDnhDDvmIwEYd
	Yewgg42DldgEx6hA2CNxZgKa8kAHrQ9oeK76ax079sOTf/qR58qKXJxf2cu6jCVa5TpoYg7Q/14
	ddFqm/hPtGYxLSj9J9xb4BiqFZFll2jg=
X-Gm-Gg: AY/fxX7cGcHoT+LVWAbh2QGz3hRNeSTsPi6NWD7PrmJX91JdLJ37nqdf+NnSB1bhvNY
	G3Hw0PDszdB4Jc/nCCvXtH1yOczMGWZ4R2T/puJjPa5VF+uXDZsgr2Nh4AAvHKHFoCWL1W+QY9D
	m3WWqVq6nlktsANyIUXASr5cnyfXyfprw9q91Z+pcyp3pbeDkiNrlE93bMDYozc2rvf6ZRmj6RW
	QS9yiP4l85UzKvkFk9LklwPoL+QoaUHAz7KpBnS/lFMTXYQZU3Qaqh5wa7P0FUw9/zZ+Co+sbsC
	lJImFT3Ky6NjBzs73LJC9pVLhxL/LK1Ob/b0xF4=
X-Google-Smtp-Source: AGHT+IEOSABsH2Q4CMvNeKVpWGJdSUdrBZ0Z38mtQEFB1w2kA2H4Ad6NJsmWthsD4pbUlT4hb6YD/4CYiXZ6vki1y70=
X-Received: by 2002:a05:690c:6:b0:790:43e0:8b06 with SMTP id
 00721157ae682-79043e092a3mr77974057b3.27.1767250034837; Wed, 31 Dec 2025
 22:47:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251227081033.240336-1-xukuohai@huaweicloud.com> <ce484a55ffa709dcfcacd631213b3b1ff1938c7a.camel@gmail.com>
In-Reply-To: <ce484a55ffa709dcfcacd631213b3b1ff1938c7a.camel@gmail.com>
From: Anton Protopopov <a.s.protopopov@gmail.com>
Date: Thu, 1 Jan 2026 07:47:03 +0100
X-Gm-Features: AQt7F2pA6myXkmb_LzlDnWN_oaB4RRYlMPJbgpAZkAwWeFub81vbfHu5_R96FaY
Message-ID: <CAGn_itzctCsfuK7in=gLQLeSGS-8WL8SWEH5AxxGrV1x9+rkRw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] bpf: arm64: Fix panic due to missing BTI at
 indirect jump targets
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	Puranjay Mohan <puranjay@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 31, 2025 at 11:35=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
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

yes, thanks, this looks better

> - set this field to true for each jump target inspected by the
>   verifier.c:check_indirect_jump()
> - use this field in the jit to decide if to emit BTI instruction.
>
> Seems a bit simpler than what is discussed in this patch-set.
> Wdyt?
>
> [...]
>

