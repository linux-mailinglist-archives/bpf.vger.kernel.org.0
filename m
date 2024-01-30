Return-Path: <bpf+bounces-20747-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC48842902
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 17:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F8CE1F269EB
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 16:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BC71272C7;
	Tue, 30 Jan 2024 16:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPDu6g7+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75563EAC7
	for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 16:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706631741; cv=none; b=C70baLghekrLv29+lmwQCkPoW9OjIWcoORp5YsnQhAHM3hDgwEqO3Ki56uHrn7Ly6/3SzFoVNcgn8DKIcGFiytEE8DQP+tksdC5y4T+VhacG18PMWRR8SZ5atfP4/Rn/uhixO3s3hC03Un19w1rN3nxfmIR5AjjkjWemNiIAeAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706631741; c=relaxed/simple;
	bh=g1nqMI831FH+CoA8PQrBehws5FVOm0gNU01pESCw7Kw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hq+uuiNL54DdHeKXaCmII0KM4auql6C3cV2ux7/1jUgGzkePfZ04o2CmOXAe3Ryf658FhTuwiKpv3bNc/8w46IGxvxOFg+cPmi55oKyPI36dh+4znzfRzmfAb6FCmgp+nZWq0+CVNacAbaAyyMXQz7vQ5yfyOwHXyCpfygS1YjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPDu6g7+; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40e8d3b29f2so48647235e9.1
        for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 08:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706631737; x=1707236537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sG4mQLc6f/8+mAWJSd6JdKnldDAb2P3Pm18yHZMJ52s=;
        b=jPDu6g7+8cA1i64CsJLUpcnRToDkUO913iWuqfqOYfz3cHpddQq1UNqCZ5Pxts6o/L
         RHIcIHXJV2qdgTPlmGUNoXrUFzT6sQpoQHkGreiEa8Cc4gjcLvcILhnZCyjRXirZIQJz
         Ib2JMyfiJHlOrMm9ZKuab62GdUhm858EOdXnUxQi4llGTvg1DLMPQ7uvf29hAXwms9y9
         vNOf7dKdFDeYzDHcFSpwmuvl/NvTwPSzrhrpMVOC5onWdD58DWKEO7YftnOSRsq3Ejrm
         fNXu1v9lCqGc5s1P1++Aibxt4LJLk1IsKaGY5bxIG3kwhAcNb1zPADvHQ4pqq49w/cLF
         f+mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706631737; x=1707236537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sG4mQLc6f/8+mAWJSd6JdKnldDAb2P3Pm18yHZMJ52s=;
        b=O/O6LGC3NnfHAj0Wd0Oj9lMuh6egU+h6/hWoHlVz7ei20zZm9UHRcxbmXinq8gBU31
         UjqcV7DI5y7z7bvBgZvMaoDSj5pmhkEvCM7DrXNVL1E7eKKnJIYLGkW7A07Eba0fVxxp
         e/MTSVHojCzNkg2pxD8pttkcqlHn/Vjp9Gs2J2/dQDiPWfxFKElrZlY3MqbxNcdG3Fef
         4HvZ7BWXZQsr8lU/OhePU3/oGGao2OzQIL59WEf/OhFcLhEvYLnscrqOEG0ilWH7dMSH
         dx//vlY6nUpuI/4r5xPWyZOopgEd7t+fSe8BkvmkXk9ioDQMf4brLitbv3KySpwLng7r
         mBXw==
X-Gm-Message-State: AOJu0Yxx7qdsmKKiC1GYkmjj5kfhlADq9zqoTVKIGRJXrNfaGooZb9d3
	mxW9hR4hqWrXQZg3I53A5pXA9WQFq5eR+9L9nnHgqpOA378WpPzo+gUhUVuNSahlpwobfTK4Ll2
	lsdiqyH2WftFXpIZfiGqL7aH41Vo=
X-Google-Smtp-Source: AGHT+IHycfZPEd6USAxYZ097JGFwdRiwjKnglAJOx/HGYPK+RkiSm1Z6adzuYl/HPM/IallhUtQu7Gm1oBn8nTyqtCU=
X-Received: by 2002:a05:600c:3547:b0:40e:f681:b7b6 with SMTP id
 i7-20020a05600c354700b0040ef681b7b6mr4741737wmq.37.1706631736878; Tue, 30 Jan
 2024 08:22:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <006601da5151$a22b2bb0$e6818310$@gmail.com> <877cjutxe9.fsf@oracle.com>
 <8734uitx3m.fsf@oracle.com> <01e601da51b7$92c4ffa0$b84efee0$@gmail.com>
 <CAADnVQK8JegsSxgbQbO=DR71cRgkvN-y9LH_ZQYxmj1a-hCz5g@mail.gmail.com> <071b01da5394$260dba30$72292e90$@gmail.com>
In-Reply-To: <071b01da5394$260dba30$72292e90$@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 30 Jan 2024 08:22:05 -0800
Message-ID: <CAADnVQJ7Phg_89MCVNtjh1EJTxEk5S++rFhpcnukMvn6sL351A@mail.gmail.com>
Subject: Re: [Bpf] ISA: BPF_MSH and deprecated packet access instructions
To: Dave Thaler <dthaler1968@googlemail.com>
Cc: "Jose E. Marchesi" <jose.marchesi@oracle.com>, Yonghong Song <yonghong.song@linux.dev>, bpf@ietf.org, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 7:51=E2=80=AFAM <dthaler1968@googlemail.com> wrote:
>
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> [...]
> > > Although the Linux verifier doesn't support them, the fact that gcc
> > > does support them tells me that it's probably safest to list the DW
> > > and LDX variants as deprecated as well, which is what the draft
> > > already did in the appendix so that's good (nothing to change there, =
I
> > > think).
> >
> > DW never existed in classic bpf, so abs/ind never had DW flavor.
> > If some assembler/compiler decided to "support" them it's on them.
> > The standard must not list such things as deprecated. They never existe=
d. So
> > nothing is deprecated.
>
> Ack, I will remove the ABS/IND + DW lines from the appendix.
>
> > Same with MSH. BPF_LDX | BPF_MSH | BPF_B is the only insn ever existed.
> > It's a legacy insn. Just like abs/ind.
>
> Should it be listed in the legacy conformance group then?
>
> Currently it's not mentioned in instruction-set.rst at all, so the opcode
> is available to use by any new instruction.  If we do list it in instruct=
ion-set.rst
> then, like abs/ind, it will be avoided by anyone proposing new instructio=
ns.

Yeah. The standard needs to mention it as legacy insn.
It's such a weird ultra specialized insn introduced for one specific
purpose parsing IP header. tcpdump only. Effectively.

