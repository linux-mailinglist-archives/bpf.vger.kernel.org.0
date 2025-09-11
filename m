Return-Path: <bpf+bounces-68195-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7524B53E3F
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 23:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71532AA67FC
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 21:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E8C2E2DEF;
	Thu, 11 Sep 2025 21:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Smj8zC+K"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A3D2E2661
	for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 21:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757627897; cv=none; b=pJuKyFrYzJr9Zi2/R25mauGJ9dzI43Af/acfPYbRBlwdZWehoj+tNaJS32KTAnw+pV2+sKN5ZOae3iGUKbrOGkxpVoLw8+4uqElGBr/0IT3/fXJPRCYrOIOVtWFyI3NX4m3WE/Q8S7mNvp4XlzdpTYdTctnYdhULXssh7hJaOBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757627897; c=relaxed/simple;
	bh=68pKP6lHrNCkCT8/RtaCJnVNqQJ8/CLctda9VgSZtfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oooOf+sQjrEz/Q77hZOLqQcNcHAsZlJCf5+yGUOemTeOj4k9SxBDYBSI8Tn4HVfQxUF9CbFA0UliHQgE99c4uLO3/0XNmjff4qOL8oIIrxTBTgez4J0FKoJUDylmQ3FG08mkwXX29vkNlwMnkewg3h8DrEI5yQipPf4PoEdB6Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Smj8zC+K; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45dd5e24d16so11474715e9.3
        for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 14:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757627894; x=1758232694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GP6RF6kCjZ3VDkcp5w1NSNG2p/MkocRDipud3ftD670=;
        b=Smj8zC+K5ZM6dzh4ttKL6ee9oGLwewTXHnGnrwrpM+HWVB4c/PGpZ+gJbmY1X7yOxM
         19nvVUdtTY+RUDW9RImU3CAh3chn6HL/I2Y9pWNGMZt1VE7wfZlt86xqE6XXliwTJIRt
         csoNTWa1u5MBU0sV15nI/cUxkEgzlA/KdXovD5E97NicqtwVqGDAAPjrj3wKatWSjEE1
         ZYEprdjGz9JnusYB0sWOUTrR19GUz9HsNPTWvjtAVTn6ERUiXHnX6SdL6EccoGOlE8L3
         rKpBbYgkrOYfFgDtMUU9yc1FNK80PwQH03dD/wXsFpADYOHs/eIxOJtRZlEReOr/Ge0R
         9aZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757627894; x=1758232694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GP6RF6kCjZ3VDkcp5w1NSNG2p/MkocRDipud3ftD670=;
        b=H2a7XFMEv4xpO7uQgdRWfaxrXMu9CO/58ELSfdcnthpLke0vcnCzP7R5XMZr5Aa888
         6j5aSGhtzgnAVK+vbfHupqArg5vGbbPLeLSCo4fjzA1yooEzLNUJpj37CVpgy8ucyEDI
         CwXaqNTyiXurZAHeQ68tgRKov+fpAsZpx01BN+kAHZPxEAf8ZOfd0DbgRqaaOhh1w2df
         mW2aCxHGI7RAih+/E6Vvhn5pb9N5Con6oovJbaU9ROorUxEqWcyDaR7+XlkNuK9K9kVA
         SGzjBAS2Z5a+AJkZSmz9av7IhagnEHNHB3RW7pYh5br+trKhbacG4QXAx+lCPztWuuLJ
         XidA==
X-Forwarded-Encrypted: i=1; AJvYcCVEsVeOzqSTyjE2EpdU0sU3e7Ly2PW0Q2iRFmda15ejCxgaZSQCOIfTA8kUHuDnTYm/tSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZkagW3ii4ZbeoQNrZ4hmsKrdL2hf2OGIv5z6w8s19gk1iCBCt
	Pc/mVSF1zhKJQT6LEVsfpUO2S/RYa1HwWonuOq4DDOyKSmdIhXrYp+wgTLhdLWnmMwgje1VM7y/
	M2wPXDtrgQ+CYdhZ1bxEqVSsgAKbuINU=
X-Gm-Gg: ASbGncuZ5LdsN4hRyZxy7b0yKEfIiasykwCZnTogozIZAQLiR9d8hfj8pmZ8Eh8NjV2
	8VDfI9hMzTywj9VU4BI1JIRk8DtOhg3pB9Kh5Im5cVbAyWzi673If3QQ4a36giainUHzzyd1atJ
	i+nRz0zhaBcuoID2wNwBZLzckRyx5Z440SWBXHSR7WQn48f+Cm2uA8q8IGmEkmgLfN5SMq/DNsY
	lIiPYB4RRO1O2xFydEWmRBV6gV6FB+VcUP/
X-Google-Smtp-Source: AGHT+IEVWhz35ntPFTjYvctt0a2DeSRsRSpvM+yFAL+cwwpq2/9cGWb1HCO2KujAOrIcy2YD8YWE58MCgePG2chULos=
X-Received: by 2002:a05:600c:138a:b0:45d:d97c:235e with SMTP id
 5b1f17b1804b1-45f211c8caamr9675615e9.12.1757627894088; Thu, 11 Sep 2025
 14:58:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <68c272e7.050a0220.2ff435.00f3.GAE@google.com> <03440441db6f719e8576cafe0318aa9994621cab.camel@gmail.com>
In-Reply-To: <03440441db6f719e8576cafe0318aa9994621cab.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 11 Sep 2025 14:58:01 -0700
X-Gm-Features: AS18NWDNK5jIn3ZXKIPIjDFRrjiHS2Qn0_gdDvA7KEClycS3Kv4Ateq65CqC5gE
Message-ID: <CAADnVQKy-M2vZHaJKD1KJw9kqtL+8Ddn7NYcQTQfG4izE82FkA@mail.gmail.com>
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

On Thu, Sep 11, 2025 at 2:09=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2025-09-10 at 23:57 -0700, syzbot ci wrote:
> > syzbot ci has tested the following series
> >
> > [v1] bpf: replace path-sensitive with path-insensitive live stack analy=
sis
> > https://lore.kernel.org/all/20250911010437.2779173-1-eddyz87@gmail.com
> > * [PATCH bpf-next v1 01/10] bpf: bpf_verifier_state->cleaned flag inste=
ad of REG_LIVE_DONE
> > * [PATCH bpf-next v1 02/10] bpf: use compute_live_registers() info in c=
lean_func_state
> > * [PATCH bpf-next v1 03/10] bpf: remove redundant REG_LIVE_READ check i=
n stacksafe()
> > * [PATCH bpf-next v1 04/10] bpf: declare a few utility functions as int=
ernal api
> > * [PATCH bpf-next v1 05/10] bpf: compute instructions postorder per sub=
program
> > * [PATCH bpf-next v1 06/10] bpf: callchain sensitive stack liveness tra=
cking using CFG
> > * [PATCH bpf-next v1 07/10] bpf: enable callchain sensitive stack liven=
ess tracking
> > * [PATCH bpf-next v1 08/10] bpf: signal error if old liveness is more c=
onservative than new
> > * [PATCH bpf-next v1 09/10] bpf: disable and remove registers chain bas=
ed liveness
> > * [PATCH bpf-next v1 10/10] bpf: table based bpf_insn_successors()
> >
> > and found the following issue:
> > KASAN: slab-out-of-bounds Write in compute_postorder
> >
> > Full report is available here:
> > https://ci.syzbot.org/series/c42e236b-f40c-4d72-8ae7-da4e21c37e17
> >
> > ***
> >
> > KASAN: slab-out-of-bounds Write in compute_postorder
> >
> > tree:      bpf-next
> > URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/bpf=
/bpf-next.git
> > base:      e12873ee856ffa6f104869b8ea10c0f741606f13
> > arch:      amd64
> > compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1=
~exp1~20250708183702.136), Debian LLD 20.1.8
> > config:    https://ci.syzbot.org/builds/6d2bc952-3d65-4bcd-9a84-1207b81=
0a1b5/config
> > C repro:   https://ci.syzbot.org/findings/338e6ce4-7207-484f-a508-9b00b=
3121701/c_repro
> > syz repro: https://ci.syzbot.org/findings/338e6ce4-7207-484f-a508-9b00b=
3121701/syz_repro
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > BUG: KASAN: slab-out-of-bounds in compute_postorder+0x802/0xcb0 kernel/=
bpf/verifier.c:17840
> > Write of size 4 at addr ffff88801f1d4b98 by task syz.0.17/5991
>
> The error is caused by the following program:
>
>   (e5) if r15 (null) 0xffffffff goto pc-1 <---- absence of DISCOVERED/EXP=
LORED mark here

(null) ?
Is it jset again? but insn_successors() handles it already.
Or pc-1 infinite loop caused it?
but we have pc-1 selftest...

>   (71) r1 =3D *(u8 *)(r1 +70)                     leads to instruction be=
ing put on stack second time
>   (85) call pc+2
>   (85) call bpf_get_numa_node_id#42
>   (95) exit
>   (95) exit
>
> And this is the fix:
>
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -17840,6 +17840,7 @@ static int compute_postorder(struct bpf_verifier_=
env *env)
>                 stack_sz =3D 1;
>                 do {
>                         top =3D stack[stack_sz - 1];
> +                       state[top] |=3D DISCOVERED;
>                         if (state[top] & EXPLORED) {
>                                 postorder[cur_postorder++] =3D top;
>                                 stack_sz--;
> [...]

