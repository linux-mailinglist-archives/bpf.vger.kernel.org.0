Return-Path: <bpf+bounces-52605-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9002BA45324
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 03:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 327C8188CF31
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 02:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A1F21C9ED;
	Wed, 26 Feb 2025 02:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsKY188A"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9241A155C83;
	Wed, 26 Feb 2025 02:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740537430; cv=none; b=s0d6usTCB7GaidOryxkBVL0R1+TGCYxXg5gH9Qi5jzmMisv9W/eKo//NClFZQeBa9nEo5rErK6AWCQALaRYk5lfaRs9eEQTs3E4Aa/KOU49Y6Skyrnz/S2LSvtSZeGT6tkW52ZH2MmwPp1SaGMO/96riuhgPTwGzpVRyHc2Mf9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740537430; c=relaxed/simple;
	bh=fi67Cmr6PldKMUk5aVPFVp0inwBduNK5hSHSrriw+uk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cDs098nL3+SJNJA67csc8RoqiXfUqijWAIGWb2xQXsjZNQ0d8RyoJXaYLxpiKSQwNmk1rBBWNc40++Jvbv140mV+YzPi7urbGx5OVNnWaXu9/iJ+9JL8xREEpLJ4btZcGX5QmRNSyKUFPq1UgZfJBcTkRNp8nawoL2OQLr+gGPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SsKY188A; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38f6475f747so2966786f8f.3;
        Tue, 25 Feb 2025 18:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740537427; x=1741142227; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fi67Cmr6PldKMUk5aVPFVp0inwBduNK5hSHSrriw+uk=;
        b=SsKY188AXfoSGNt+BDLMmRynSRK7ei7yECTwqiO+RoQC2TyzYmN1STxmhxDStzuc/C
         sVv3uylbQQq2226NZF//WCbx9Ka19m5mQs4dFY24846Y47hqaMQ1rqmPniDRtOwW/LB1
         N8vrHlyQxO966lwXXk0uMGEyGsBGXrXamMmxYfP98Sj7rqexcFuuavef2xQCBVogtKZx
         IGgvhLg44QZYDKOZVgOvRtB0filQ5F9MJz2+813VurLCGaAiZKcRxD+GL9ojqGWAnYr4
         Rvs5Jtat8oUT5pLf4kiG1B9+lE89rKuyTkzj4moZzpEH7ZZHoxm/mxlNa8u7G3XoAVmH
         qIOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740537427; x=1741142227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fi67Cmr6PldKMUk5aVPFVp0inwBduNK5hSHSrriw+uk=;
        b=ukVObCYQdUdOIZJhgTEpWAf9xMDzj19+l8EiLx1JHA7ZB6MrzdGPQFSGrXXV/DNifq
         ry55wwCVYiB6Qxi/WJE4w0IB14Gb/qLFaMcKoNhXVAWSSihB6EDuT2mtoVwXd3p3LFwO
         f/pqs1Ocq4qKdlQn2Rs4iKIfYjEz+McJY3oozCQG4+azA2jzK9uVeM3/bTP4lOjozwJ1
         xpzZYf4eqpSK+SrudA0t1l+EY9p0WaX2Z5OcFzeK8AH/EVSzjacUucslPx4fi6Y9gF2F
         gfRJKiMal2GxGRlAepWPPogpKd9CJsgTXwGYC+iyPo82W4r7NpAPAPMrRX+Q/ZqpKw/g
         U6XQ==
X-Forwarded-Encrypted: i=1; AJvYcCUA67/9mcmeYjicIVqsDK/exy1TT9ynZ1H3hvc9u7Dah8eILYI9l9nHu97+4kSFaJDhKzU=@vger.kernel.org, AJvYcCWDBq50qIfNy75sq3+JSzklqYHwpnYvR2axc6Z2i1wcAPet0ANy0AD7+buVUhrOWH8KF8yxGPjrTqpx3JWI@vger.kernel.org, AJvYcCWubHcMgnvO+0q8zym3LhCB/pFPn+vDWncghAMNh2wcw376KO1XlkPSrs1BIRNavecZNqdnolv/FfZanatw2/45DWzg@vger.kernel.org
X-Gm-Message-State: AOJu0YyNlOGqH4wUvK2nKckW+i1+mmgv6C6wbPAzLmIUmEt9ARazVQ7w
	GznDtdseLDHra5j4gjrRJ8YZ/+mShiz/rzHy4cPjKYbfoMYlYrwnenE1lcndvWr6feGnD1VEWHf
	gxSZPxs7Fy5DvFjZPaahKbmyVBts=
X-Gm-Gg: ASbGncutzzxPoRiLHfAvnksF/GAGnSnSYfBTxSZlz4zkHMNVcHVeQgXLtWpCVGJjh5P
	1cwkdQRw6fyu0RzAuJDvZaQByFw3X0M69RfMTHlMDmZWgXhtXGwNLkwaqhQ4QsxFmtV3LoY6w+1
	nPn9JsIJEWDOjEwkxfUsaITMo=
X-Google-Smtp-Source: AGHT+IFoU/O1JoX9gM/HVElnXgX87BnqK5dtrNQHsCGw/VfbBb+iQR14xXNuwvgGfIzCDjxhz7jHAcAUeWzQagBMHvo=
X-Received: by 2002:a05:6000:1ace:b0:38f:3aae:39ef with SMTP id
 ffacd0b85a97d-38f6e95e670mr18609366f8f.21.1740537426611; Tue, 25 Feb 2025
 18:37:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224140151.667679-1-jolsa@kernel.org> <20250224140151.667679-9-jolsa@kernel.org>
 <CAADnVQJ_-7cB3OaeFWaupcq0fRPh3uP62HBGxq0QbyZsx3aHqA@mail.gmail.com>
 <Z73HDU5IZ5NV3BtM@krava> <CAADnVQKNeWKFkZxb_-Fuenvmfy47-t6Z7KLY_j3UUOrj5pFP-g@mail.gmail.com>
In-Reply-To: <CAADnVQKNeWKFkZxb_-Fuenvmfy47-t6Z7KLY_j3UUOrj5pFP-g@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 25 Feb 2025 18:36:54 -0800
X-Gm-Features: AQ5f1JrQFE6uSlXpm4LDhjZBfvba46bsAof3aU9IPeH8yk2HDtzGADPi6743rGg
Message-ID: <CAADnVQ+eKFOAM5PWpBJAy4pKokwbCOMgEghxLu92sw+HApBUYA@mail.gmail.com>
Subject: Re: [PATCH RFCv2 08/18] uprobes/x86: Add uprobe syscall to speed up uprobe
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, David Laight <David.Laight@aculab.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 10:06=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Feb 25, 2025 at 5:35=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wr=
ote:
> >
> > > In later patches I see nop5 is replaced with a call to
> > > uprobe_trampoline_entry, but which part saves
> > > rdi and other regs?
> > > Compiler doesn't automatically spill/fill around USDT's nop/nop5.
> > > Selftest is doing:
> > > +__naked noinline void uprobe_test(void)
> > > so just lucky ?
> >
> > if you mean registers that would carry usdt arguments, ebpf programs
> > access those based on assembler operand string stored in usdt record:
>
> No. I'm talking about all normal registers that trap-style uprobe
> preserves, but this nop5->call will scratch.
> Instead of void uprobe_test(void)
> add some arguments to it, and read them before and after nop5 uprobe.
> They must remain the same.

Ignore me. It's a syscall insn. All fine.

