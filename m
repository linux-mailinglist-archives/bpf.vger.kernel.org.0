Return-Path: <bpf+bounces-68200-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB8AB53E72
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 00:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 015BB1C86028
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 22:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0E834166B;
	Thu, 11 Sep 2025 22:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tn79HJpP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9402E6114
	for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 22:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757628420; cv=none; b=TTabTJMGmC3IpIdgjUkxjM8R9axU34vy+yO+uqB41NN7k3ayrE9iAvTCFvseiW/dVqYUlAZO9tFpGcdbwlQkyYDFIpcrcyXpRGt0ct2ycVmHUXe1HieqnTEuLjp9tcCCC7pbNwJSRbElVa/UKH9jvLr+BCT5pzfeq9ohgg7ndjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757628420; c=relaxed/simple;
	bh=ZZJ2grqLL8Fqy5I4BP+Z6fTe+JP94/SaKVMrj4tLpLU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Se6jI9cZMpy5MhWfUQjfjRBBuKszR4Q3ZmleFwnFkiTjhL2IMvH3VYao5FPsvFq3xJ/03E+eWuVPWFsLTQUbuItWeuvhrtF7YqoVkRjvUmgxE2+SQyzJJp+RruYwo/ddqR2UAmZV1+Fx9KlB2mKSZDsC1VTDAdPd/4ulv5V5Rj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tn79HJpP; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-32bae4bcd63so888253a91.2
        for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 15:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757628419; x=1758233219; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bonWt9ZGWLjOJbFQA74GLeDy739Dy64l0gYa4dZMRGE=;
        b=Tn79HJpPGp2h17s4MtCjPbbGvpOHweFwXuHoN+CTxLxX7gOaWrC7EXoCd38LVaGNOO
         xr1eaBySYag5dBMExTTqMsovoGWfFdo/BBQEF51bIaLZv7bh9R5ukVpCxKoDafNwAJNc
         D9x9cJ1PQbKKDSkOGF150L7VITKxlEWTgvrjHBXywCmLnsn2oOckFRPl0daQescMNRnm
         QjQnzEZRGfouNP0svgPypTNGG6mHrNNhbjzzJYW35w8y7u0y3vuENtZhn+sdI+Ffs3Ao
         oUJ6Eh58UFNc90il0g+tF6WaFgmvqyVXS/h34qtbHPieCSoOIPJnwP51n80ygQJ/d0iH
         FM8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757628419; x=1758233219;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bonWt9ZGWLjOJbFQA74GLeDy739Dy64l0gYa4dZMRGE=;
        b=cfNgimlF8A5GB5bz9Bw1dYZ6drMo3JWYlyWVZSYGlECLuX3ZXF54wthnTgKc49eJpB
         bPLDl0dT/81ocHB3ymhBFUTpfqLNRxNFOAx4cVPaV1rwekRvT1b9igFpP6Y2lb8amo5v
         zLkUxkI5t7uaQ3fWcT+qEfGi453PRYFA8KS/1LKFKeiZ2Dveewfhtz7/hXyI7gZ0ysgo
         AkFzWUqOU42jQNhFVIXgi9ABctuubPvp3apQiuh2N3cJ9ENT4wS+gJdGqEXsSP1v1FDj
         fcIvtAVx3cxDTGts4SfapaulVQR6c8TY4TgHuZ2K+uFAX2suBUx+czMpmU+1dciiup4u
         51Xw==
X-Forwarded-Encrypted: i=1; AJvYcCV143yRwx8Oy37SDaWl2edtLYLzKYTnY/aOP4/fkFyfccUCLj+bk92skIZZZqWFkt6+Wrk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6SJfbyYiMN+ovV3qhfe5OlmLkWI9v/OqQsTWIdA/ito9sM8ik
	FdGJE3dc4E21GaybbkkX0FRnye85fx/+10Rrnm2rvKup3t8PmHAMbDh+
X-Gm-Gg: ASbGncuW7E1ujCboBuSBQUWDVBSL9jzuuBfZkZ/Flcdw5rI7WzSyB8mXFPmqCiJWvRL
	1OwLD9twGzc1OmzuwCZi3ii+U0Ez/XEw5hqhGL0mtmMQNiRUM4Sbkq4NVkpodgyELtpUNxKjaQM
	CzX1OAfvVSir3+tvw6Ht3Vt44CMx8bm0u7pkgauOT77sm7vrEruXV28k9JrHvxqCkTExmFFqfQX
	y67dMc1D5N8JKGMcuoBIwL4joUyApFK2aPsX3RbcQmrmIsUnFCHRYXxvcIwISdxSduss/KncrXK
	2CSt8iZBkJPPnx5Dri1vvNXOryg+BzOsD9C7qberj6m23HCL2BKXT1yM5o0R7MkPh69SMqF8azu
	0BzIuo9cKVh4CxYzk+baBFFSIrOB5xQ==
X-Google-Smtp-Source: AGHT+IFdY15i8F6EfNnCGUseItDeh0p6MR37I8aTzP+cpxUS/SuvO1rf0YfM/xLlIwhuq2caGPq/8g==
X-Received: by 2002:a17:90b:4a8e:b0:32b:94a2:b0d6 with SMTP id 98e67ed59e1d1-32de4e7d0d1mr715598a91.3.1757628418576;
        Thu, 11 Sep 2025 15:06:58 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dd63268dcsm3804654a91.26.2025.09.11.15.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 15:06:58 -0700 (PDT)
Message-ID: <5f0ef19a7961a6f703ea6e035ca2239865227abc.camel@gmail.com>
Subject: Re: [syzbot ci] Re: bpf: replace path-sensitive with
 path-insensitive live stack analysis
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: syzbot ci <syzbot+ci8e503a0d4aea89ba@syzkaller.appspotmail.com>,  Andrii
 Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, bpf
 <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Kernel Team
 <kernel-team@fb.com>, Martin KaFai Lau	 <martin.lau@linux.dev>, Yonghong
 Song <yonghong.song@linux.dev>, 	syzbot@lists.linux.dev, syzkaller-bugs
 <syzkaller-bugs@googlegroups.com>
Date: Thu, 11 Sep 2025 15:06:55 -0700
In-Reply-To: <CAADnVQKy-M2vZHaJKD1KJw9kqtL+8Ddn7NYcQTQfG4izE82FkA@mail.gmail.com>
References: <68c272e7.050a0220.2ff435.00f3.GAE@google.com>
	 <03440441db6f719e8576cafe0318aa9994621cab.camel@gmail.com>
	 <CAADnVQKy-M2vZHaJKD1KJw9kqtL+8Ddn7NYcQTQfG4izE82FkA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-09-11 at 14:58 -0700, Alexei Starovoitov wrote:
> On Thu, Sep 11, 2025 at 2:09=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > On Wed, 2025-09-10 at 23:57 -0700, syzbot ci wrote:
> > > syzbot ci has tested the following series
> > >=20
> > > [v1] bpf: replace path-sensitive with path-insensitive live stack ana=
lysis
> > > https://lore.kernel.org/all/20250911010437.2779173-1-eddyz87@gmail.co=
m
> > > * [PATCH bpf-next v1 01/10] bpf: bpf_verifier_state->cleaned flag ins=
tead of REG_LIVE_DONE
> > > * [PATCH bpf-next v1 02/10] bpf: use compute_live_registers() info in=
 clean_func_state
> > > * [PATCH bpf-next v1 03/10] bpf: remove redundant REG_LIVE_READ check=
 in stacksafe()
> > > * [PATCH bpf-next v1 04/10] bpf: declare a few utility functions as i=
nternal api
> > > * [PATCH bpf-next v1 05/10] bpf: compute instructions postorder per s=
ubprogram
> > > * [PATCH bpf-next v1 06/10] bpf: callchain sensitive stack liveness t=
racking using CFG
> > > * [PATCH bpf-next v1 07/10] bpf: enable callchain sensitive stack liv=
eness tracking
> > > * [PATCH bpf-next v1 08/10] bpf: signal error if old liveness is more=
 conservative than new
> > > * [PATCH bpf-next v1 09/10] bpf: disable and remove registers chain b=
ased liveness
> > > * [PATCH bpf-next v1 10/10] bpf: table based bpf_insn_successors()
> > >=20
> > > and found the following issue:
> > > KASAN: slab-out-of-bounds Write in compute_postorder
> > >=20
> > > Full report is available here:
> > > https://ci.syzbot.org/series/c42e236b-f40c-4d72-8ae7-da4e21c37e17
> > >=20
> > > ***
> > >=20
> > > KASAN: slab-out-of-bounds Write in compute_postorder
> > >=20
> > > tree:      bpf-next
> > > URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/b=
pf/bpf-next.git
> > > base:      e12873ee856ffa6f104869b8ea10c0f741606f13
> > > arch:      amd64
> > > compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976=
-1~exp1~20250708183702.136), Debian LLD 20.1.8
> > > config:    https://ci.syzbot.org/builds/6d2bc952-3d65-4bcd-9a84-1207b=
810a1b5/config
> > > C repro:   https://ci.syzbot.org/findings/338e6ce4-7207-484f-a508-9b0=
0b3121701/c_repro
> > > syz repro: https://ci.syzbot.org/findings/338e6ce4-7207-484f-a508-9b0=
0b3121701/syz_repro
> > >=20
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > BUG: KASAN: slab-out-of-bounds in compute_postorder+0x802/0xcb0 kerne=
l/bpf/verifier.c:17840
> > > Write of size 4 at addr ffff88801f1d4b98 by task syz.0.17/5991
> >=20
> > The error is caused by the following program:
> >=20
> >   (e5) if r15 (null) 0xffffffff goto pc-1 <---- absence of DISCOVERED/E=
XPLORED mark here
>=20
> (null) ?

The `code` byte is 0xe5, BPF_OP(0xe5) =3D=3D 0xe0, which is an invalid
opcode.  But opcodes are verified after check_cfg()/compute_postorder().

> Is it jset again? but insn_successors() handles it already.
> Or pc-1 infinite loop caused it?
> but we have pc-1 selftest...

It's not infinite, but it causes instruction to be put twice on the
stack array, and this array is allocated expecting max prog->len
instructions. KASAN would only catch this error if program really
needs to consume full stack depth during postorder construction,
as far as I understand.

[...]

