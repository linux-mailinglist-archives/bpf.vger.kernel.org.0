Return-Path: <bpf+bounces-41676-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 768579999BC
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 03:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B5CA1F24906
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 01:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F22FBF0;
	Fri, 11 Oct 2024 01:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cM2BqjPT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB6D11C83
	for <bpf@vger.kernel.org>; Fri, 11 Oct 2024 01:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728611060; cv=none; b=tYxA/66IOPfB3WKh/VXXcAdYgcs3TEjiySeY9111j68wjCyuPmssuuwf0ZZu5oCXWTvX5bCukXT2YQwCCDzQlj1i/IuPTuLARtaHTv22ONUMDtTn+Hn2zy5QuKHHKU07jE0LUPcx1J4d096hYu+oA8t1bFj4TOOBFJyZdX4XPnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728611060; c=relaxed/simple;
	bh=m+NJZYQ4Cq292uTgR5ixu+20ZFUiMfAjUpGB8IM5cQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PWbkfc2UZGXEDFTk8om+p0urvsZ+wgnR+6jfgCfGXHeyCPHFEqGMvzH/hVuCwZZLCs5Csi/krRbtF6cO4GfEYgIb6IjzvIykKRX73GElYC/ygwbnGl6qsPCUL8NrlywR3z+aN8MwuSLj5yAsP54e1mhy8j7Q5/t92kCL4H0LeO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cM2BqjPT; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7163489149eso1174786a12.1
        for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 18:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728611058; x=1729215858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1SnG7yKqdqm9bGa8VzAS2jwiHU/bAl5wrLUqN2dQLRQ=;
        b=cM2BqjPT3W8NUsHC32Jajp51mY0Xu6qyheIx8agDVuwrCO20umT8TAizfCD6XOjvyF
         yQ1oPdtXFAPC2OJ5tmEcP/W2b0cJ+yZWPMTHhOXkDlt/5/lL9qn9zJ+JFJQokgGYL/F/
         MPBOSXewCXKQuvUQxsmXh3/Bj0oTMHhoyLAJfRFBjRTSfNGkSrhx08AxwvxC49sfp5BW
         9tNJJedwT5ANdO5NaYZ4ZroGFA58Y/VNsrhgoAGd73y75VpgVBVMp6B0lmXBRdOdmO01
         gfRYkZqL8CY9r3wQUmqfmvHgoqoeC/AJFx+WuN2C/8hAIDhAptM+4uE5Vxlwff4C5W8q
         iQnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728611058; x=1729215858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1SnG7yKqdqm9bGa8VzAS2jwiHU/bAl5wrLUqN2dQLRQ=;
        b=eB14fxPdF03XuGkOLBF9IAj1isVPqzvUe1pA2Fyf+oP0OZYc60KTLPSggKvobjKhXC
         xBhaue3V3LYXP3yBJhVyF5fAtIgtK3rHsge+bdf7bKLcVUbiN2wQdtT+3+3GnQL2N5wX
         wUyiLLDLpPShwJ8Pm/kbdR33nZl3sY9NVxmAO1AVFgxEkUwhgveg3p6IcEXHQSmTo5M1
         wKP1an9Q73c5+93JMo1N/WgiyunAYaDr7IG2aPxAhtAK4hYw+WSIZ62Zg4Jq6PelNlbr
         7eh2nWh+8I93R8R7NSG4gfr1dfd1cvhzUvk2MYDQJpLDihbDUiKI0hxyx+A11UmhHSvs
         8qHw==
X-Forwarded-Encrypted: i=1; AJvYcCUTq7fvfbGNmUAfaqyrooeH9sUHFOoH49JYKTsAPXaJFtw7fMTQ+1OPXHXGqDWgTwI2xTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YybbwbB3sfpjR+hE77DZavLK2OSki91OgoRvSPZMFn7X/MYai8W
	qcffGQdUdhVrUW1Kj+t9paQPYH7lKU6qEXaL0hGH+3G88FiVP5KESmBF1/DFXOo8igjpdyPbb65
	lmWq1RUYJK5XJSc5Rp+1uEFboL6E=
X-Google-Smtp-Source: AGHT+IE/VZ3j5IY3dTy7amVNgFvvPPR9X5Z3y7gRxR51IpBtt3jDFM0LgMyBIrNnu644SjQqdyPx/FKFyKWhaRH555k=
X-Received: by 2002:a17:90a:348c:b0:2e0:b26c:906f with SMTP id
 98e67ed59e1d1-2e2f0dfe42emr1579335a91.27.1728611057671; Thu, 10 Oct 2024
 18:44:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009021254.2805446-1-eddyz87@gmail.com> <46ff5f908c2ba69ebfa2033456425632c5f74c6f.camel@gmail.com>
 <CAADnVQK8mTA_3y8YG6stQW_2yRFUOjLx2Qt1fB4SSS2Sa_0JMg@mail.gmail.com>
 <CAEf4BzZf1qr-ukaSHkv=pgCfEN5LQER7b4EovUM-TVtdwgJrZw@mail.gmail.com> <5c4eca8da640c4be42edca1fc3ffcd0650f69b08.camel@gmail.com>
In-Reply-To: <5c4eca8da640c4be42edca1fc3ffcd0650f69b08.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 10 Oct 2024 18:44:05 -0700
Message-ID: <CAEf4BzapU+-BUJ4LnZk8i_EwGLNLBS1hLCjwjPs2EuxHZ+y+MA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: force checkpoints at loop back-edges
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Kernel Team <kernel-team@fb.com>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 3:40=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Thu, 2024-10-10 at 15:13 -0700, Andrii Nakryiko wrote:
> > On Wed, Oct 9, 2024 at 6:09=E2=80=AFPM Alexei Starovoitov
>
> [...]
>
> > > Something should be done about:
> > >           71.25%        [k] __mark_chain_precision
> > >           24.81%        [k] bt_sync_linked_regs
> > > as well.
> > > The algorithm there needs some tweaks.
> >
> > If we were to store bpf_jmp_history_entry for each instruction (and we
> > can do that efficiently, memory-wise, I had the patch), and then for
> > each instruction we maintained a list of "input" regs/slots and
> > corresponding "output" regs/slots as we simulate each instruction
> > forward, I think __mark_chain_precision would be much simpler and thus
> > faster. We'd basically just walk backwards instruction by instruction,
> > check if any of the output regs/slots need to be precise (few bitmasks
> > intersection), and if yes, set all input regs/slots as "need
> > precision", and just continue forward.
> >
> > I think it's actually a simpler approach and should be faster. Simpler
> > because it's easy to tell inputs/outputs while doing forward
> > instruction processing. Faster because __mark_chain_precision would
> > only do very simple operation without lots of branching and checks.
>
> I think this would bring significant speedup.
> Not sure it would completely fix the issue at hand,
> as mark_chain_precision() walks like 100 instructions back on each
> iteration of the loop, but it might be a step in the right direction.
>
> Do you mind if I refresh your old patches for jump history,
> or do you want to work on this yourself?

No, I don't mind at all. Go ahead.

>
> [...]

