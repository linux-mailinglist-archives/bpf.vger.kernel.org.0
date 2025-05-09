Return-Path: <bpf+bounces-57924-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A895AB1DBE
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 22:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 105EF3B06C0
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 20:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773BB25EF88;
	Fri,  9 May 2025 20:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+ARQcWF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6072376F2
	for <bpf@vger.kernel.org>; Fri,  9 May 2025 20:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746821453; cv=none; b=ms2Tn+L0fYGhUVSxzp4aCsfxD9+47QCGfpfZK4qYxEl/MGhho3C6q9LSrlMM4H6uWnXOdnYA2+khsO0aGhRy9nXFbiGSO9ew4X2yUz19eqtBPyn0LkI8fVk2s6if8s2FW8L+I3gFG0+1LEiQ/Bh/dsJvxj9CcwDMjEuy73ki+qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746821453; c=relaxed/simple;
	bh=fM2230YVqIytnWJu4Bl4dM77ZtiRykf/Ys/VqyQLms4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PT3y2+0OuzvCSJTCgb4DCX3z0BGSSFTnsNV/2wtvUEfisjuaK07/Mi7TjGoAVCACnebfKu7y5PKvOVNHCu/BV6dgiKhTiERHjDUeULemNoJgvTWHx5lj1fzMnMkjHskIM/gWDaxQcC6bk9DT3U7HQGua3DF3sdxmd4Cvb5eT8UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+ARQcWF; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-ac289147833so490421566b.2
        for <bpf@vger.kernel.org>; Fri, 09 May 2025 13:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746821449; x=1747426249; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IjQQ9RCoiPN+i2GBiOYJ/AtWB8eFMtcGIf4eL6zjF10=;
        b=b+ARQcWFEnn0RpaHTfEmek6b2HEP56Cx6NIFs0yFDbwAoqCwQ53jyqMm9Lm+Wu5dpU
         +G4tvhO05S7b2HQdyF3q3JzN++uIOoflhlISUTD9kfQ5/IkuZB4fsQQkfp6TB6nTrqpy
         K85h2V/meojMGchgMMTKaHX2qiDLE9LCFM53uHPyK7zy8TJAIglpvB/bbAQp8BsugjWy
         mOkDiLTm5IwbjgJS9SzS2hA65igxf4VHij3fN8NgRD42F3FEmYitOqgHQVqLIChPRbFx
         F195kI0S+PlpMpTpbLx/1lrhcNJDV+9fNFuDqmFMI5HDQHNlPswC3fjoQbgEZFKANu6f
         Jr8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746821449; x=1747426249;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IjQQ9RCoiPN+i2GBiOYJ/AtWB8eFMtcGIf4eL6zjF10=;
        b=mh9QtIYgTRNxT0BU5C65dh30Ucohje8Ef92oZT/SWQ+r/rcTluvHqnLEFkXIIi/s+F
         0AkCNWcnvPfcpBaBD1CyjkCVgmUhvysO/jBUM7dlKPwYQ3sJmodS74dWHiinZNNRDGgO
         BBYI3tk3Tz9Dyz0cZDm2d6QfAKofnB9Zkar1PER+KgsroGvJODpQaUBwfGos909zye0j
         prtopJ+JLR5TAxKjmnUEdb0sYb6z5IlJ6Q2iVgWna2q3C+QjN8Hv2WmBWCbrhiL/tJEu
         ZoEROLaZjA9/c5/rcDKmjy5ClsLw4MJoMEB1ZEaBeS9gaLn8J+HXLzLLf4XrdvwUyqcI
         UdvA==
X-Gm-Message-State: AOJu0YzLS/vVpjNaImvGbL3yXiFs3K66uLO+BaNO7HAc7A8/etjrDwYM
	p3mooHUM8yfBxqhuUpeAZ03E8YJc6dxp1QyhMHe8CKXQnFt2sFnExcTW8bcriQ5T1yu6mu5oo4k
	bMrmYI7w4NCVqIYtHBpn+EvJkXsw=
X-Gm-Gg: ASbGncv4y184BvU1VR/bdkP8e0Kfd2PP/HpW5s68gt+S1WqSjk/Lqj/pZRUkN6+b1zI
	6D7TUbAJcvqhUgPDZh9x7Wit5k+1kUAVbmOFf1/JvRqKzfv95YL3waKAttPnw6lkD03r9of7tby
	LxMhh0xsdRLm+85HCg95z5L6IFiOtkxSegA0M063YU2AFAv/wZcvDqmsbY6nJ5GBwRzEA=
X-Google-Smtp-Source: AGHT+IFXqFlut0L5hwr1vGWFq77w6SUPxG6WxgUUcTj3lVsz4WOo6QLA4qGTgmQv5qeUXGCY1UjyOEZXPcfwqTpN910=
X-Received: by 2002:a17:907:969f:b0:ace:bead:5ee1 with SMTP id
 a640c23a62f3a-ad219131246mr478173066b.42.1746821449407; Fri, 09 May 2025
 13:10:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507171720.1958296-1-memxor@gmail.com> <20250507171720.1958296-9-memxor@gmail.com>
 <a071c33a195642de5530f897880e44bc1416a86b.camel@gmail.com>
 <CAP01T74uq5Uyy6VHXyA_yVeO9rdU7svnQv90Z7auerApjbRfQA@mail.gmail.com> <e78b2cf09f6931ec8e7791e35c8b49f19bf1d4b5.camel@gmail.com>
In-Reply-To: <e78b2cf09f6931ec8e7791e35c8b49f19bf1d4b5.camel@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 9 May 2025 22:10:11 +0200
X-Gm-Features: AX0GCFtED2IsrvxCbQdnAzpJGVcrRFUYwKcuIilJHhmmrMBOGkv0kf1eFS3ByMg
Message-ID: <CAP01T770Qt4-S6hVvxzMsyDhsOm3-fEJ1+HgsjikdBfkUjdyFg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 08/11] bpf: Report arena faults to BPF stderr
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Barret Rhoden <brho@google.com>, Matt Bobrowski <mattbobrowski@google.com>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 May 2025 at 22:07, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Fri, 2025-05-09 at 22:01 +0200, Kumar Kartikeya Dwivedi wrote:
>
> [...]
>
> > > >  bool ex_handler_bpf(const struct exception_table_entry *x, struct pt_regs *regs)
> > > >  {
> > > > -     u32 reg = x->fixup >> 8;
> > > > +     u32 arena_reg = (x->fixup >> 8) & 0xff;
> > > > +     bool is_arena = !!arena_reg;
> > > > +     u32 reg = x->fixup >> 16;
> > > > +     unsigned long addr;
> > > > +
> > > > +     /* Read here, if src_reg is dst_reg for load, we'll write 0 to it. */
> > > > +     if (is_arena)
> > > > +             addr = *(unsigned long *)((void *)regs + arena_reg);
> > >
> > > Is it necessary to also take offset into account when calculating address?
> > >
> >
> > Not sure what you mean? "arena_reg" is basically the offset of the
> > register holding the arena address within pt_regs.
>
> Arena access is translated as an instruction with three operands, e.g.:
>
>   `movzx <dst>, byte ptr [<src> + r12 + <off>]`
>
> As far as I understand the code, currently `addr` takes into account
> `<src>` value, but not the `<off>` value.

Ah, good point. We could certainly reconstruct it.
I'll look into it.
For prog authors I think giving them src + off in the output is the clearest?
IIUC that's what they'll see when they bpf_printk the pointer, too, right?
LLVM wouldn't insert cast insns unless the pointer is being loaded from.

>
> [...]
>

