Return-Path: <bpf+bounces-66496-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3610B35194
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 04:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA32B1892703
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 02:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0995D225388;
	Tue, 26 Aug 2025 02:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Br2rGx3W"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAA71A08AF;
	Tue, 26 Aug 2025 02:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756175045; cv=none; b=iVnxWUt7ObWlbxKLf8ORKjjJ6N/YVLeBp5IpCN5FdanWolKltWDgLm5Cg18CIuymx0G/v+k0REeI2khPjNxKEAVU4p6E6Bl8PROiwt/P3wGrqAVPztuGJzaYxG1nE4H/WRNHILpThrTvofHabk6qePZoEZ94o0OZHxPh0stC+Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756175045; c=relaxed/simple;
	bh=IyryyYq9LIyTXnCp4o750OCcSejlmku3y6BBodY9pAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PT6zVCbnCIYsRNAXh2QiNfy+s6o+ZmJyEtoeews4uh9yUXkAff2EIctXxBTysP+/nR8gbg4eKUPOiHhp1i3XffY6Pu7Bn74U0b7LdvbgGqhpnQIItqEpUbXUsExe38Qz4cOF8b3CddvPmjPByZvhBY06gEct2zQ2s9kEcRVjGGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Br2rGx3W; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45a1b04f8b5so30998625e9.1;
        Mon, 25 Aug 2025 19:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756175042; x=1756779842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nnw5Io3YoXIrEN5f5+9xJT+J+1J+f3588PWlwvqSRJU=;
        b=Br2rGx3WrXpr7uVR/ccE6zYtDvDTNzDY6kMk11bTzEMxuoDdmGaFcgBK8W3TQuGXQy
         rAsDq2snPvwYL6GCRJIXLz6MbRIM3XSTFaoEHCSoJ07V7B/jx7YAUTKfjNkaA9FcQ8va
         qlLG8/HZ9X2XZhiuCc0/hWPtSdSd1Apl58zmr4bImvo5WqmP66z+OOdzOvJ2gXpR+sKS
         a2dMZiHLvFLz64a7BkQl9p5CLV2GgECHYTcF+vpOjQwKGCM2xg1d6oMVGF/uPZjzFKCw
         jzLiXm37BR+o7bb2C4ZbMU0scuzkmbeBTCXdjHS1/OlG3bNhbiL4Iu3lh1M4ZFwWmBKr
         JJBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756175042; x=1756779842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nnw5Io3YoXIrEN5f5+9xJT+J+1J+f3588PWlwvqSRJU=;
        b=tmqJSTa2pgLA61Sr6RhkFhY1PSvfWhOgybfJmN4qHyzGemcCEAbXQdiAVxAC9qF0J2
         GGhl8G/YhT4FR6Hjf3mDXuG0RnjG/pb2hvYwCgxczKMk145Pg16v4SNbpWJBiE1PpHre
         Our70HaPWB4OzteqQsLClI3Mt3gYh7uGMSLktEkpH28ZKqiOjA0N1n6sPIRmn3yD5pW0
         PVAo/BtrbC/M1RTLi5Ffx3yzs+PLTqaP/K3U4r8JMLMGYBbfQy8uYNdcEWKJpyOtRMy8
         n9X3KvmV6Hf9PnEFah6F/qDNfroCCv8kSj9eN6JwUIHf9acFwLFBr7+CndVpcNgZZmRZ
         Yl6w==
X-Forwarded-Encrypted: i=1; AJvYcCUX5B59dqHLOMvuLpuQXNAeqrk3DDbekCIRj1pIqd5NrFWX+yclQznyQXhOkIqGSgcoIVeSS+86@vger.kernel.org, AJvYcCWBQetUP521fFu8RGxfOk9YTSPHl9+RH6TNERgJUUSrxS+Vu27DfGNNH/2tFX4N36h0n68=@vger.kernel.org, AJvYcCXMLnCBDGQqchFdSmorHxmDkDqQV/CML/RdT0g/fCyeWShbt7KwCFmWVaUXtobOv2REasBwXMR75c5Gq3cX@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2PvJ4ETOJiWRCMhlSHFadjfSIAtAd5tzG+Ew2JkUjN8IuA7m4
	h+taLF2JShWd9DncgTAtfZaq0VHFB/1cI9sJ8DTHLYjSEILbgRsG2UAikefDjVP+Q9Up7FDSD9T
	I+n4aCeZ+HLe13UOZZ8UVa471mCJybG8=
X-Gm-Gg: ASbGncs0Uj4/wKvyXLQ8TxZdEMcgKZDbBg9GJCTrT1T57GazI4ZgdJMxsFxBYvS6o7g
	/pVyifP+s/oN+yb45GjCMxxmP43tmjxiJkChqTAuVYiox/B6nLDFfH14ZIhIued0THAwPl7BopV
	1r+h6IlbqVc/4my9vqF9HB6Q834DcBsULgUEkZRHXxAk//9e9Gw+Z/THlYK7/5w6a9PmR1Vz03H
	3j8nsKKD676ABoBO05/hYeeuglevWn0E8g8bfrhkimqAs8=
X-Google-Smtp-Source: AGHT+IG5ssaQcamDRDWmXnILVYwRUi/oBBKimzvnLH92kL1Jx4ptCMX3SUD+IGckg91A6UO7P/m8ZlV09CZ0UOcsnBQ=
X-Received: by 2002:a05:600c:314f:b0:456:191b:9e8d with SMTP id
 5b1f17b1804b1-45b5179f5admr114139635e9.11.1756175042128; Mon, 25 Aug 2025
 19:24:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <68ac9fd3.050a0220.37038e.0096.GAE@google.com> <50f069c5-d962-4743-a8b0-dc1bc4811599@gmail.com>
In-Reply-To: <50f069c5-d962-4743-a8b0-dc1bc4811599@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 25 Aug 2025 19:23:50 -0700
X-Gm-Features: Ac12FXxBFqcbocd5P_A4HYBlTVL4Nf-8_zzEQxpfVAjmi095qFKuKSBMMPJ8v1o
Message-ID: <CAADnVQ+p76vYLjs9zivq694PSqiPPjv7LJOSXCHsLGuMwgG1jw@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] possible deadlock in __bpf_ringbuf_reserve (2)
To: Leon Hwang <hffilwlqm@gmail.com>
Cc: syzbot <syzbot+fa5c2814795b5adca240@syzkaller.appspotmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Network Development <netdev@vger.kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Song Liu <song@kernel.org>, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 7:20=E2=80=AFPM Leon Hwang <hffilwlqm@gmail.com> wr=
ote:
>
>
>
> On 26/8/25 01:39, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    dd9de524183a xsk: Fix immature cq descriptor production
> > git tree:       bpf
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D102da862580=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dc321f33e454=
5e2a1
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3Dfa5c2814795b5=
adca240
> > compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6=
049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D142da8625=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1588aef0580=
000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/5a3389c1558f/d=
isk-dd9de524.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/c97133192a27/vmli=
nux-dd9de524.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/3ae5a1a88637=
/bzImage-dd9de524.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+fa5c2814795b5adca240@syzkaller.appspotmail.com
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > WARNING: possible recursive locking detected
> > syzkaller #0 Not tainted
> > --------------------------------------------
> > syz-execprog/5866 is trying to acquire lock:
> > ffffc900048c10d8 (&rb->spinlock){-.-.}-{2:2}, at: __bpf_ringbuf_reserve=
+0x1c7/0x5a0 kernel/bpf/ringbuf.c:423
> >
> > but task is already holding lock:
> > ffffc900048e90d8 (&rb->spinlock){-.-.}-{2:2}, at: __bpf_ringbuf_reserve=
+0x1c7/0x5a0 kernel/bpf/ringbuf.c:423
> >
> > other info that might help us debug this:
> >  Possible unsafe locking scenario:
> >
> >        CPU0
> >        ----
> >   lock(&rb->spinlock);
> >   lock(&rb->spinlock);
> >
> >  *** DEADLOCK ***
> >
> >  May be due to missing lock nesting notation
>
> Confirmed.
>
> I can reproduce this deadlock issue and will work on a fix.

Don't.

It's due to revert.
Once rqspinlock is fixed the revert will be reverted.

