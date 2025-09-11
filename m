Return-Path: <bpf+bounces-68202-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD942B53E8C
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 00:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA2B61C881CD
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 22:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FB534A30D;
	Thu, 11 Sep 2025 22:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6Kddh4E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE53D342C9D
	for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 22:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757628714; cv=none; b=SvF3X2ia/XjJH2ftjP7PFPQRW8UjeIv732FrzDte6nxaw12WmwSGvQSJV0ZeCtQTu/kHy0RcYwoNYO3KrJaPPKC///VA9CY3bf9T9BpOUYwS+pmaRm6jOmNwpOScyuGfZHqbzwX67wNH+VCda5YoEXMlNsfrZULwQ/UPxQvK0gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757628714; c=relaxed/simple;
	bh=/dtwzvh9M+PgQdX8hypJZzDko9hlbh7/OsgqgQkn4Go=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IGZatFtUGYffQlcXsZGui7fn+pJm4woPayAkSYdZ29TqjsCtXGpvYNeIQ82Q6PdA8YcPBqEvoGFzOuWC8QZXU0EtK400Aewd5xDIHr968QycDA7IXp6o8s4JYDcWxrJ1mfNunCB5c43F2nmY6598jjCCFcBiG1S54ziVa+PhCmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S6Kddh4E; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45df7dc1b98so6522815e9.1
        for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 15:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757628711; x=1758233511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tls1+yb1vfMgq/iZh3MeTOsXTDuu7dvV5qBYdDLIrks=;
        b=S6Kddh4Ezlvw7SbSKvNmHSMDpK0XDe2Z7c1EetocW/+A5Smf2WScUc0Oxa3W68fspx
         1pZoGEkdSngYzcNmmgzOQXLDwLwtTV1eKrDivAS8ivGka4Z6mTmhr2WKo66XS40TNX6q
         3iJ9/DvJDIdm6+32CgIC9/03Yhz1Q4FHllZMOcPeVnJuDMeeWD23374LEEtaAhrF1HNy
         Wj4FG8BOPDT49azTv7fnpbFokh5tijrkGGGMRc2CA+/gFQMbb7clrW82pUArjwS0M3BV
         +XYoWhnb9dgctpVDk6Uky3Ue7HXguC7bjCiBBLQU1lsPmTzxlW5r6LBkRtSk6jFbncS+
         2pDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757628711; x=1758233511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tls1+yb1vfMgq/iZh3MeTOsXTDuu7dvV5qBYdDLIrks=;
        b=TmUWMLC+PTmsSSRvuAaVOBrzzeZRL0CJDrWtY1r3r4AqxUOci/0c3kygFJcFVwZO4C
         W5rbfx4jxkOke+NuaW7wLd58zw0Dj5XpHHbnjIPIOotuoTzkXymNoHBn2/z9HnpOvaH0
         2ZX3B4ox2WTXy3+oTdJbkzEc0K35IgIoUq/BPI93+YQRM9/S0TxHwA3Cl1qRMGuHBG3T
         pcyXl5rjbUi4eR9f8K7OHs130DSBAJn8o75De+o65sZ1Q/AT1dIcg42QL/1oooZLqYKF
         zmZDh6Rfil8iRz4JnRzZS4y/rVD2pWKNrv2/uZuVubHtV65CfbnRGLC33jiOHHpwzLEZ
         LLVw==
X-Forwarded-Encrypted: i=1; AJvYcCWFu0dYfkG97aRCqAiJOQL0iPQLLYWNdCjDp+BnJ7R71gQGIXIBTCsgYGzlG59L1F0t0NU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6cr6D6bKxlaTG7s4WVb0zxqmAQ0HAqcXtxIja3C6SyzTUpi5g
	qADYN5UOBnzM/K620obQzpbBN7yacKDsD+M9U/73Si1k2bByuKmEoMN6mRTyOjdpqMGGHEP7JT2
	v5N5py9mXm+ZfeNdPr6U0dULY+77fbw8=
X-Gm-Gg: ASbGncsTtm3qz/4USRqqOLGZL9KzZxfj8a8HAcgRYXmY3qQWSyHU6y79U+1ZDA+GU3x
	Vzc5Qt6tRteTA2puSL+uFr5D4RTotSRMpgYU7+isU6nsGQfV6NYjCO9vF+FMxKxmwoXPeITXDfn
	USidlAWeYfQBZD5g2EhRrSY2df6yz9T3+wVmPQPO9qZkOPTnDv2X/P9VXIdroWDzpT/GzXAKtSe
	JGvURZN5QEt1I7MW/+eTFzCwXPjJOW7cDBb5O5/vIDu0MM=
X-Google-Smtp-Source: AGHT+IGDOzDXGaTONtyBMca5RofIcMwXveTWTnti2H6JgsJgzCzIDnWonFIjFrIoP8tZJCUM2ZghM4LjzuPaCH1mugo=
X-Received: by 2002:a05:600c:1c0c:b0:45d:d099:873 with SMTP id
 5b1f17b1804b1-45f212c9668mr7139165e9.6.1757628710902; Thu, 11 Sep 2025
 15:11:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <68c272e7.050a0220.2ff435.00f3.GAE@google.com> <03440441db6f719e8576cafe0318aa9994621cab.camel@gmail.com>
 <CAADnVQKy-M2vZHaJKD1KJw9kqtL+8Ddn7NYcQTQfG4izE82FkA@mail.gmail.com> <5f0ef19a7961a6f703ea6e035ca2239865227abc.camel@gmail.com>
In-Reply-To: <5f0ef19a7961a6f703ea6e035ca2239865227abc.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 11 Sep 2025 15:11:39 -0700
X-Gm-Features: AS18NWDxjnr9Upya1b6lQlbmMufgukF6m71ysgUMhCA8QiVyogBvm1XqAdM4WKE
Message-ID: <CAADnVQKf2zauKO78qqt73=mZZD7-1ejm+C_zOQh7HUw9ExrjJw@mail.gmail.com>
Subject: Re: [syzbot ci] Re: bpf: replace path-sensitive with path-insensitive
 live stack analysis
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: syzbot ci <syzbot+ci8e503a0d4aea89ba@syzkaller.appspotmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, syzbot@lists.linux.dev, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 3:06=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Thu, 2025-09-11 at 14:58 -0700, Alexei Starovoitov wrote:
> > On Thu, Sep 11, 2025 at 2:09=E2=80=AFPM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> > >
> > > On Wed, 2025-09-10 at 23:57 -0700, syzbot ci wrote:
> > > > syzbot ci has tested the following series
> > > >
> > > > [v1] bpf: replace path-sensitive with path-insensitive live stack a=
nalysis
> > > > https://lore.kernel.org/all/20250911010437.2779173-1-eddyz87@gmail.=
com
> > > > * [PATCH bpf-next v1 01/10] bpf: bpf_verifier_state->cleaned flag i=
nstead of REG_LIVE_DONE
> > > > * [PATCH bpf-next v1 02/10] bpf: use compute_live_registers() info =
in clean_func_state
> > > > * [PATCH bpf-next v1 03/10] bpf: remove redundant REG_LIVE_READ che=
ck in stacksafe()
> > > > * [PATCH bpf-next v1 04/10] bpf: declare a few utility functions as=
 internal api
> > > > * [PATCH bpf-next v1 05/10] bpf: compute instructions postorder per=
 subprogram
> > > > * [PATCH bpf-next v1 06/10] bpf: callchain sensitive stack liveness=
 tracking using CFG
> > > > * [PATCH bpf-next v1 07/10] bpf: enable callchain sensitive stack l=
iveness tracking
> > > > * [PATCH bpf-next v1 08/10] bpf: signal error if old liveness is mo=
re conservative than new
> > > > * [PATCH bpf-next v1 09/10] bpf: disable and remove registers chain=
 based liveness
> > > > * [PATCH bpf-next v1 10/10] bpf: table based bpf_insn_successors()
> > > >
> > > > and found the following issue:
> > > > KASAN: slab-out-of-bounds Write in compute_postorder
> > > >
> > > > Full report is available here:
> > > > https://ci.syzbot.org/series/c42e236b-f40c-4d72-8ae7-da4e21c37e17
> > > >
> > > > ***
> > > >
> > > > KASAN: slab-out-of-bounds Write in compute_postorder
> > > >
> > > > tree:      bpf-next
> > > > URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git=
/bpf/bpf-next.git
> > > > base:      e12873ee856ffa6f104869b8ea10c0f741606f13
> > > > arch:      amd64
> > > > compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b79=
76-1~exp1~20250708183702.136), Debian LLD 20.1.8
> > > > config:    https://ci.syzbot.org/builds/6d2bc952-3d65-4bcd-9a84-120=
7b810a1b5/config
> > > > C repro:   https://ci.syzbot.org/findings/338e6ce4-7207-484f-a508-9=
b00b3121701/c_repro
> > > > syz repro: https://ci.syzbot.org/findings/338e6ce4-7207-484f-a508-9=
b00b3121701/syz_repro
> > > >
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > BUG: KASAN: slab-out-of-bounds in compute_postorder+0x802/0xcb0 ker=
nel/bpf/verifier.c:17840
> > > > Write of size 4 at addr ffff88801f1d4b98 by task syz.0.17/5991
> > >
> > > The error is caused by the following program:
> > >
> > >   (e5) if r15 (null) 0xffffffff goto pc-1 <---- absence of DISCOVERED=
/EXPLORED mark here
> >
> > (null) ?
>
> The `code` byte is 0xe5, BPF_OP(0xe5) =3D=3D 0xe0, which is an invalid
> opcode.  But opcodes are verified after check_cfg()/compute_postorder().

hmm.
resolve_pseudo_ldimm64() -> bpf_opcode_in_insntable()
does it before check_cfg.

