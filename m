Return-Path: <bpf+bounces-46219-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B6B9E6235
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 01:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6CA31884D2A
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 00:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356C91802B;
	Fri,  6 Dec 2024 00:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EwqeT2Hr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551C3C2F2
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 00:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733444955; cv=none; b=oINTnNpmm3xRmeyyF48NLiwkx32USdJhZcooPOytRWP9c9epHdjw3UG/ib+Sol4rcjV6US6r/W2SuvUBLtaetMudA8nrCCQ7RTAR4iX7Lh4d9leGQwwIMICyjursBf5XOmp+Xrcz+m15oCw+B0OoXqGeS5Jt7b+Va0ylX34SFqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733444955; c=relaxed/simple;
	bh=sMQ+3ERA+wfDxszAMaBfduNZGqwQh2uGSmWtRC+PYqI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dEtvD0Zzpp0rMGTQQuvfLEQW6OB3ZZH/nyAf3NpdU1vq1BL/0S2D9Yh9Mw9gSke1JdioI5+jneEt4q/6HBeuXmtE4creJbQ62It4lUO+k3yziPk061z14rzKO/ceRWqYMELaOB7T+jx8Si03yez+9aS/QX0orjVw7QNULTV47t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EwqeT2Hr; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7242f559a9fso1662378b3a.1
        for <bpf@vger.kernel.org>; Thu, 05 Dec 2024 16:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733444953; x=1734049753; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j7LeE4A8Qm1SO+c9AfH5c1CsrlApjLWBAoy3ZwrVX80=;
        b=EwqeT2HrVKr3loOHubNwBtC6eINOqBnipGecmx8M7ZBjax/qNeGOSDDCo0eCaQDfgi
         frxLclYbLnWLvAymQi7zFjCf84wHE0JrsC77GED/F5dN+ejHuyDOvQQ8hRCosXf7UH8n
         EY/ikfZrA5k7fVm71TSqPfbiHxhXckNhgZQ+XJJq1s1seLYEmSG1ksTvHtdWnQCChaW2
         622PtVUebZxlbDGwouDDPflxS+LaXSpEmmv1rmExFJSmJAWmxrEEfPA9uxZRTxM8i3Gl
         vbjtBfR3n8hIPPt5vb4RwHIX5zZAuC6Kaepuup34pRtfGVy4ABM43NLievFGGIm9U8hL
         nUDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733444953; x=1734049753;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j7LeE4A8Qm1SO+c9AfH5c1CsrlApjLWBAoy3ZwrVX80=;
        b=XLMXfgYrzqErKwCokSCWTr+CK4+2PvlccYWeiLgv17FrAa73yRpJhJ6G7Dz2MGKHff
         k2QXiJp9m39B4KVmZCO//W03pundMtpQni8gRWeJVOfa9u9sgi3+zC4uLwcF7HW0ZcDd
         KvkJL2EoU2JkENUCXl2RzA9I4zEe/7GuT46doSOxwqFEwCyHgh+Y/JhknMbr2ldI4fpQ
         BGcj991v0usL/KO/c2jzZYyRwxWa4D90nUDrydddQmSANPIUzDPc7HjJkBhN+QQlwPF5
         LxKbdos4KzUUVC4zrpMitBhXBn+MkZJhGumz69+oNMFFwTnTqOWPFhjqckrsfyQxZfYD
         978Q==
X-Forwarded-Encrypted: i=1; AJvYcCW5UiU3gUVHxPErAvxW9DZVv8U7xhqCRSSJSp4NtZeDSSxNICosJCzQHypchN+7x2PYRHs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv+jPQHVAaEM2BFjXOJZIgxUZ1oN2QucX9Lx1c1wunVuHcOszD
	iBkSSzPBUbJJBfJ7UuNX3xdh3PDGOme1SXdnmbkKYHZ9DOocfetx
X-Gm-Gg: ASbGncv9/v4JahLZUxtMJOxK6FY8o2UKqM4wDKoqmcJ7ky2dTm7+HcDe4kchXxxW+sh
	9bruwyn/k8L2npJ9qdTe/j7gJjfrfD9tlZFnBAnyWfJJxVaI8xSFZKdOO+muEIXidwaPTJ8IZy0
	D28su5RVxyBx15ruD71BOiWnGX9WAF6MjlE2oWvz2hbBA9LaHwexci1syzpVCTb+LzLcLDKJwtB
	l1S6Y8zdnqL09lq9OHooh7ay4En2ELF19EY8ynuzk1APnE=
X-Google-Smtp-Source: AGHT+IGIPIYA0aDnrkx2lsfm/qazxCV5LAFX57fX6CIw/pDOl6l8rouaJSNU54Ks0E4yekaj1f+/CQ==
X-Received: by 2002:a05:6a00:815:b0:724:c054:b046 with SMTP id d2e1a72fcca58-725b8170eccmr1738864b3a.18.1733444953479;
        Thu, 05 Dec 2024 16:29:13 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725a2a8f5c5sm1897257b3a.121.2024.12.05.16.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 16:29:12 -0800 (PST)
Message-ID: <4bbdf595be6afbe52f44c362be6d7e4f22b8b00f.camel@gmail.com>
Subject: Re: Packet pointer invalidation and subprograms
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, andrii <andrii@kernel.org>, Nick
 Zavaritsky <mejedi@gmail.com>, bpf@vger.kernel.org, memxor@gmail.com
Date: Thu, 05 Dec 2024 16:29:08 -0800
In-Reply-To: <CAEf4BzZBPp40E-_itj1jFT2_+VSL9QcqjK4OQvt6sy5=iJx8Yw@mail.gmail.com>
References: <0498CA22-5779-4767-9C0C-A9515CEA711F@gmail.com>
	 <1b8e139bd6983045c747f1b6d703aa6eabab2c82.camel@gmail.com>
	 <47f2a827d4946208e984110541e4324e653338e0.camel@gmail.com>
	 <CAEf4BzZBPp40E-_itj1jFT2_+VSL9QcqjK4OQvt6sy5=iJx8Yw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-12-05 at 16:03 -0800, Andrii Nakryiko wrote:

[...]

> > There are several ways to fix this:
> > - The "dumb" way:
> >   - forbid calling helpers that bpf_helper_changes_pkt_data()
> >     from global functions.
> > - The "simple" way:
> >   - at some early stage:
> >     - scan all global functions, to see if there are any calls to
> >       helpers that bpf_helper_changes_pkt_data(). If there are,
> >       remember this as an "effect" of the function;
> >     - build a call-graph of global functions and propagate computed
> >       effects over this call-graph (if A calls B and B does
> >       clear_all_pkt_pointers(), then A also does it).
> >   - during main verification phase, if a call to a global function is
> >     verified, check it's effects and update state accordingly
> >     (e.g. call clear_all_pkt_pointers()).
> > - The "correct" way:
> >   - build a call-graph of global functions;
> >   - verify these functions in a post-order;
> >   - while verifying, collect "effects" information
> >     (so far, the single effect is whether or not
> >      clear_all_pkt_pointers() had been ever called for the function);
>=20
> So this is the only "side effect" we have right now? Are there any
> others we have already or can reasonably anticipate? I'm just trying
> to decide if we need to generalize this concept.

Don't have anything to add to Kumar's answer.

> >   - if a call to global function is verified, check it's effects and
> >     update state accordingly (e.g. call clear_all_pkt_pointers()).
> >=20
> > "dumb" is probably a no-go as it is too restrictive.
> > The only advantage of "simple" over "correct" that I see is
> > that the logic for clear_all_pkt_pointers() remains confined
> > to check_helper_call() and is not duplicated in a separate pass.
>=20
> "simple" doesn't take into account dead code elimination, undermining
> BPF CO-RE-based feature detection, so I think this is also a no-go

That's a bummer :)
I takled with Alexei yesterday and he preferred "simple",
so I went ahead and the fix does look simple:
https://github.com/eddyz87/bpf/tree/skb-pull-data-global-func-bug

> > > In theory, this also allows to compute more complex function effects
> > on the main verification pass.
> >=20
> > I think "simple" is a way to go at the moment.
>=20
> I think neither of the above are fully valid, tbh. "correct" will do
> eager subprog validation, even if due to dead code elimination that
> global function might not have been called.
>=20
> From the outset, I think the "right" way to solve this would be to
> start verification from the main program. When we encounter global
> subprog verification, we pause verification for the main program,
> create a new isolated verifier state, proceed with global subprog
> verification, and so on until we check everything. So basically a
> stack of subprogs to validate.

This might be not that hard to do, actually.

If global function had not been verified yet, and a call to such
function is encountered:
- setup arguments as for global function verification;
- keep stack and BPF_EXIT processing as for non-global functions;

> This is PITA, of course, just for this (which is also the question
> about the generalization of the "side effects" concept). So I don't
> know, maybe for now the "dumb" way is the way?

Idk, "dumb" seems too restrictive.


