Return-Path: <bpf+bounces-21358-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DA784BB37
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 17:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D27DB25214
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 16:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91763469E;
	Tue,  6 Feb 2024 16:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Ur30GrIa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B22D51E
	for <bpf@vger.kernel.org>; Tue,  6 Feb 2024 16:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707237766; cv=none; b=r2PKSHaaUhp+3dfdSXnHB90ub2fK4j3NBD3zawBgswn1izASWsig7XtWHq5WujH1uh9UFVb2OvjBMMsHtbmm2ad3zwAC1jwmRwIT+9ei0WG9+2iBy0abfb5moWkaJ6maIDd0YSqkEfDh7hokR9cKoIxi52QkMG+QT5TeV03szqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707237766; c=relaxed/simple;
	bh=NtqbIdYKMGkM+TvSI6e1zLdKhIG0Y2qhx0GMlq8DfQ0=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=iKnJtT9rHEYKcg0G5yZnp4NO8ih8KVJXoxLvR1E+E4lWjTzI9yxdXkPZyQxJUdEzN9ScppvpyQvLrek59n/X8U3cq07JOBx6imepX07HZp0Qk/05hHoaM7UCRDYCuPgEY0Zt/hLMlsFL4EvQGXTgD6EGY9KEHMJP8WWrf2OMrPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Ur30GrIa; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-214dbe25f8aso3224480fac.3
        for <bpf@vger.kernel.org>; Tue, 06 Feb 2024 08:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1707237763; x=1707842563; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=FtVIdTx2855fysMh9Epuxu66E/a8+cgXbRUXIZwycHo=;
        b=Ur30GrIajLOQ2K3acoALXiKninKE9nO0HiFmQNyyRWtlZeTP/7JGo8BC2X8KsXtHbM
         NBccdgBj+HUoyuWvimMTFKq5VMVXz6XPtN0MGD0NduykutiqKVGNVh5HIscorHCe4ZMh
         riJf8qqIk28EpJmt7MPnDtHAfPmnBDIyQ4zXzrSXOXXDkRsDVNZ6i1OkVcblMv8tGI/S
         gcqiYEYRRLfsCt908IvFfNoNeBTIS4MDq+aPlvat2fTP5VB7cFG86StDlUEc2YdVwMJS
         wMVV3vPCitl9UklMV8G1FraPCXuHrt0pmph0WCxwunTnw54mNuSlqMXu0h3Y60RJurOl
         BHwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707237763; x=1707842563;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FtVIdTx2855fysMh9Epuxu66E/a8+cgXbRUXIZwycHo=;
        b=iN1wS2kdmHUjfxleyzO6QwcKlCeyGKXQhbH/Tw7Skz+jxhSnIYnLVA/GVQ2oCW4DZx
         d+sjkfD0sFCTrg7d/HDW6Xk6OAuN4v/WfkSzLRce/g5wcAyyHCkAaFz564K6AkgnmPRS
         VTnzyb9BY/5eFJ3DXo/8gN6QoJCR1YM9fOuRAYn52z5Ah3n0fcB52o1Ykt6vvC32fiZl
         vuekIf/0D3MorzqibYrjpLsiHw9YlQyz21n/Anx8F4NvRLocFHzkxLfGYSISjEj1nzn3
         uv7e9TXzVZe/t4vIltctsdRaDRRZbDGXAzCft/GFQJObemcUpAOuHeh6ggqveqOJxUt1
         R5BQ==
X-Gm-Message-State: AOJu0Yy8cjqyLLyLiJBy1xxWf8DLdqbuKdOkxDyNSPVMX46/WuVtYLz6
	BtyPJegDkwSe9dCLZ8TqaRR/52Infpexm+N7StKb6bL/REOQnVtb
X-Google-Smtp-Source: AGHT+IFkp7C+0sIDFa5q9i23dU5VJ2r2+czF/qZi6QQeSZmTolVqM6ArnoDgNOPLMs3ucDxVg2Bkpg==
X-Received: by 2002:a05:6871:821:b0:218:f4fa:bcca with SMTP id q33-20020a056871082100b00218f4fabccamr3131361oap.51.1707237763495;
        Tue, 06 Feb 2024 08:42:43 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUaGe7D0IhXmqUOdVz3g/CJcUIzjgjM6u/zyatYnuvx84rp9QXUdRpkasED/z12EvEyz7NuPfTcwrvWKqjMlBpX9qwy3GiFzPzjUWXgas4dQMP6QwD91tLqCQ2ZRF4=
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id dh1-20020a056830484100b006e1205d4578sm372390otb.23.2024.02.06.08.42.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Feb 2024 08:42:43 -0800 (PST)
From: dthaler1968@googlemail.com
X-Google-Original-From: <dthaler1968@gmail.com>
To: <bpf@ietf.org>,
	"'bpf'" <bpf@vger.kernel.org>
Cc: "'Alexei Starovoitov'" <alexei.starovoitov@gmail.com>,
	"'Jose E. Marchesi'" <jose.marchesi@oracle.com>
References: <076001da53a1$9ebfa210$dc3ee630$@gmail.com> <87wmrqiotx.fsf@oracle.com> <CAADnVQJDDHEVjrDeXyY+GOncnG+CFY=TBspuZUPzDU6nDLyo9Q@mail.gmail.com>
In-Reply-To: <CAADnVQJDDHEVjrDeXyY+GOncnG+CFY=TBspuZUPzDU6nDLyo9Q@mail.gmail.com>
Subject: RE: [Bpf] ISA: BPF_CALL | BPF_X
Date: Tue, 6 Feb 2024 08:42:41 -0800
Message-ID: <0d8301da591b$813d05a0$83b710e0$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHLEYKQbFH8DoKfsRCUXp0fT6URjgIX5UybAepfDASw+/3ZUA==
Content-Language: en-us

Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:=20
> On Tue, Jan 30, 2024 at 11:49=E2=80=AFAM Jose E. Marchesi
> <jose.marchesi@oracle.com> wrote:
> > > clang generates BPF code with opcode 0x8d (BPF_CALL | BPF_X, which
> > > it calls "callx"), when compiling with -O0 or -O1.  Of course -O2 =
is
> > > recommended, but if anyone later defines opcode 0x8d for anything
> > > other than what clang means by it, it could cause problems.
> >
> > GCC also generates BPF_CALL|BPF_X also named callx, but only if the
> > experimental -mxbpf option is passed to the compiler.
> >
> > I recommend this particular encoding to be specifically reserved for =
a
> > future `call REG' for when/if a time comes when the BPF verifier
> > supports some form of indirect calls.
>=20
> +1.
> Same thinking from llvm pov.
> CALL|X is what we will use when the kernel supports indirect calls.
> I think it means we need to add a 'reserved' category to the spec.

My reading of this thread is that there seems to be consensus that:
1) CALL|X should have an entry in the IANA registry with its own =
conformance group,
2) The intended meaning is understood,
3) clang and gcc both implement it already with the intended meaning,
4) The Linux kernel might support it someday.

I'd propose we make it its own conformance group called "callx",
which of course the Linux kernel does not yet support, but clang and gcc =
do.

Rationale:
* There may be other instructions reserved over time in the future so
   using a more specific name than just "reserved" is good since later
   additions require new groups with different names.
* Defining it now with the meaning already implemented by clang & gcc
   means that no changes are needed later once Linux supports it.
* ebpf-for-windows is likely to start supporting it in the very near =
future
   as a result of this thread. There is already a github pull request =
under
   review to add support for it in the PREVAIL verifier.

Dave
=20


