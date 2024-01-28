Return-Path: <bpf+bounces-20527-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 739B183FB1F
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 01:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5CE41C2234C
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 00:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979FB4596D;
	Mon, 29 Jan 2024 00:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOKpoVgF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715BD4C3BC
	for <bpf@vger.kernel.org>; Mon, 29 Jan 2024 00:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706486404; cv=none; b=ayHib2S/HbbGCpNuO58HHBbUc4armXIj7nSAe+IxPmWQkgzzV2cyP+oz2ktURpRdvV0mffLxcBlVU0FMdY7kUem4revKw2o9IMEh8ef2g01hsG4X9+8Y0JXXWctQlj6pFlR90I++7SwcXqLFrSrOOhjQXwyzCjFMQzKJTjN2N7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706486404; c=relaxed/simple;
	bh=cSxIwsBYD6mkHObuKNIlyYdOdVTSKQ3insE6fqzoCMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OVhshi50/g6iECWsfRJDWaSyHq8dCFtSPiiyybNGIBaEMeC9XZnPrC4nFf57WiYB/XCYXJs2xvRRbiqY3T+MhqwrB60BNufzCwhD9p3HedVz/XbtfHljVKU8yLUbA/uOeleFGtun625vCsGB9uEbnKSHeTN6j+e7ZXOcbw33T1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bOKpoVgF; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40eacb4bfa0so28552275e9.1
        for <bpf@vger.kernel.org>; Sun, 28 Jan 2024 16:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706486400; x=1707091200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7x21MVZ3T5kHI10+76D9TW9jSjeUQJEv9vhm3J4OBM=;
        b=bOKpoVgFUUeG+KmHnL/elCkr0qND+RhO6xk3zxvD0p09BfcQcI8//EkNcHOFoQqgYc
         wJZ9INnO713SXeChDpUqH5NEVLPUyYS+TN6vdH9xlSSqe72YWwmt9fFpxEItq1nKuNmP
         3GeszcpDVVTYR8hTprJ3wZh9hlAbZelUGc3fKgM5wzJVijCyQb3fO4788AjJnzTRGRYE
         /WjiWWB7O9XeZGfhYVrccmjjW8PaQc9VOBLgkScwpYJCOgP6t8T2wvJmV6IpQo+FacNf
         I2CucsVSu7z5DrXxRJVneENydY2tLiYkP4lqPx58XDcKAWC4ChmLvcDc6X8luEoU8ULz
         qDwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706486400; x=1707091200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a7x21MVZ3T5kHI10+76D9TW9jSjeUQJEv9vhm3J4OBM=;
        b=n4IaabPXL3UZfiXSwl4n1Ic34ch4IZHuN7vvstp2C6kf60NFlzSkV7Z2Ufcrff2kS4
         fnzJmBYv7hzaDZ/GmPs9NlXIbgsz5nN0ZDcP850HN5BZU5YxSAnSxDnBbGlmaSTXvmaE
         Y+baiMcAcxNkzLwrINOOsXvgE2pnSrgUi0uBvSEu6G9A6Ts6fUtZWd/BSD+JAd1SH5uu
         h7nB0FOWMOQeqn8Z8Z2gfNSGSZNn5T3snUWnbina5+nuukTXlPIAM+xuTrKVuTDcjmm8
         EGO0qM5Qe/4mlLPt14eI+RR9Nnmcsf98N0S6UGY5pZADkbsYIAcKJ+iS4SAA4KRrR7ad
         46wg==
X-Gm-Message-State: AOJu0YzDg5EeR/j6QFqNnRsfEusksohYO5+QWvTWp2mgTOQ1hVBzp1x+
	/JBT/I3zdw5CPhDmAe8VH1bxUe0aInQ3WPUEDTP5b2fInOZjE+Gga/4VNeQd9AO7F9PNYIc7RoN
	w2xtKJJ8wH4hXRfDcMDdzBv7D3mQ=
X-Google-Smtp-Source: AGHT+IFNtPAKt8KhgVradSii0nSxKnv8/biZEE3dhq9G0z33hQn3nO3baMhjK5bh6oK7tZl//2Bhs8HvpUbpX7a9IBY=
X-Received: by 2002:a5d:51ca:0:b0:33a:ee39:5b4a with SMTP id
 n10-20020a5d51ca000000b0033aee395b4amr719969wrv.36.1706486400236; Sun, 28 Jan
 2024 16:00:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <006601da5151$a22b2bb0$e6818310$@gmail.com> <877cjutxe9.fsf@oracle.com>
 <8734uitx3m.fsf@oracle.com> <01e601da51b7$92c4ffa0$b84efee0$@gmail.com>
In-Reply-To: <01e601da51b7$92c4ffa0$b84efee0$@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 28 Jan 2024 15:59:48 -0800
Message-ID: <CAADnVQK8JegsSxgbQbO=DR71cRgkvN-y9LH_ZQYxmj1a-hCz5g@mail.gmail.com>
Subject: Re: [Bpf] ISA: BPF_MSH and deprecated packet access instructions
To: Dave Thaler <dthaler1968@googlemail.com>
Cc: "Jose E. Marchesi" <jose.marchesi@oracle.com>, Yonghong Song <yonghong.song@linux.dev>, bpf@ietf.org, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 27, 2024 at 10:59=E2=80=AFPM <dthaler1968@googlemail.com> wrote=
:
>
> I asked:
> > >> What about DW and LDX variants of BPF_IND and BPF_ABS?
>
> Jose E. Marchesi <jose.marchesi@oracle.com> wrote:
> > These we support:
> >
> >   /* Absolute load instructions, designed to be used in socket filters.
> */
> >   {BPF_INSN_LDABSB, "ldabsb%W%i32", "r0 =3D * ( u8 * ) skb [ %i32 ]",
> >    BPF_V1, BPF_CODE, BPF_CLASS_LD|BPF_SIZE_B|BPF_MODE_ABS},
> >   {BPF_INSN_LDABSH, "ldabsh%W%i32", "r0 =3D * ( u16 * ) skb [ %i32 ]",
> >    BPF_V1, BPF_CODE, BPF_CLASS_LD|BPF_SIZE_H|BPF_MODE_ABS},
> >   {BPF_INSN_LDABSW, "ldabsw%W%i32", "r0 =3D * ( u32 * ) skb [ %i32 ]",
> >    BPF_V1, BPF_CODE, BPF_CLASS_LD|BPF_SIZE_W|BPF_MODE_ABS},
> >   {BPF_INSN_LDABSDW, "ldabsdw%W%i32", "r0 =3D * ( u64 * ) skb [ %i32 ]"=
,
> >    BPF_V1, BPF_CODE, BPF_CLASS_LD|BPF_SIZE_DW|BPF_MODE_ABS},
> >
> >   /* Generic load instructions (to register.)  */
> >   {BPF_INSN_LDXB, "ldxb%W%dr , [ %sr %o16 ]", "%dr =3D * ( u8 * ) ( %sr=
 %o16
> )",
> >    BPF_V1, BPF_CODE, BPF_CLASS_LDX|BPF_SIZE_B|BPF_MODE_MEM},
> >   {BPF_INSN_LDXH, "ldxh%W%dr , [ %sr %o16 ]", "%dr =3D * ( u16 * ) ( %s=
r
> %o16
> > )",
> >    BPF_V1, BPF_CODE, BPF_CLASS_LDX|BPF_SIZE_H|BPF_MODE_MEM},
> >   {BPF_INSN_LDXW, "ldxw%W%dr , [ %sr %o16 ]", "%dr =3D * ( u32 * ) ( %s=
r
> %o16
> > )",
> >    BPF_V1, BPF_CODE, BPF_CLASS_LDX|BPF_SIZE_W|BPF_MODE_MEM},
> >   {BPF_INSN_LDXDW, "ldxdw%W%dr , [ %sr %o16 ]","%dr =3D * ( u64 * ) ( %=
sr
> > %o16 )",
> >    BPF_V1, BPF_CODE, BPF_CLASS_LDX|BPF_SIZE_DW|BPF_MODE_MEM},
>
> Yonghong Song <yonghong.song@linux.dev> wrote:
> > I don't know how to do proper wording in the standard. But DW and LDX
> > variants of BPF_IND/BPF_ABS are not supported by verifier for now and t=
hey
> > are considered illegal insns.
>
> Although the Linux verifier doesn't support them, the fact that gcc does
> support
> them tells me that it's probably safest to list the DW and LDX variants a=
s
> deprecated as well, which is what the draft already did in the appendix s=
o
> that's good (nothing to change there, I think).

DW never existed in classic bpf, so abs/ind never had DW flavor.
If some assembler/compiler decided to "support" them it's on them.
The standard must not list such things as deprecated. They never
existed. So nothing is deprecated.
Same with MSH. BPF_LDX | BPF_MSH | BPF_B is the only insn ever existed.
It's a legacy insn. Just like abs/ind.

