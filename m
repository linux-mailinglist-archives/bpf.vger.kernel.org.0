Return-Path: <bpf+bounces-77884-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 123BCCF5B1D
	for <lists+bpf@lfdr.de>; Mon, 05 Jan 2026 22:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6584C300CF37
	for <lists+bpf@lfdr.de>; Mon,  5 Jan 2026 21:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CE2310627;
	Mon,  5 Jan 2026 21:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GACMB06i"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD54D2D63F6
	for <bpf@vger.kernel.org>; Mon,  5 Jan 2026 21:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767649271; cv=none; b=XPsbzEvJE/5mJGj56//lKo37asi8hM6i9NK5EZ6GOBIoVzJPvU7kXz6bYnRwqd4ygwaQBL4XczabYAvjhE0LcnYGKr/LRMgfOJTSSndTnTi4newHXN1NGVKdUmY8nAItEPRGqckYjvBF5mzthTc5zIoCVA3HxjhNR6nvfwuBcOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767649271; c=relaxed/simple;
	bh=2ITIBGKJ58N/QJjwr5Glsm//oS2lKXU/Wi0YEsXklzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nMC7oUa2/fVzOLYaB3GaSs/niU5+2utg8VzEbjzY0ADh7BNCCzrFs9Z139Q8JzfqO8Xmrh4fqdife6oiFCkau1xbXKc36fMobaq5AKWaOMfw6i60Fj11tBd5Mcw25AN8WLRSNBvZVi/MQOcUETTh7w/I93MuoMEvZSbu9lO2OWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GACMB06i; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-34c84ec3b6eso569247a91.3
        for <bpf@vger.kernel.org>; Mon, 05 Jan 2026 13:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767649269; x=1768254069; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sn0DCnKIdWqQbx9oUlSjP29HAs/aUKrPzgxlC26KjEY=;
        b=GACMB06iGbRs2Hv8YL6VRfuQuHuEiAlayqR9xGgfNZcOoDihjf0qfRlW9Mtu787/wa
         vUVm+MX3bIe36dwUXIabp3sv8bHVto3cqqoMIu8ta/5EHQzqleDs74uhwVXv3ybuCZwc
         +tVMUIFErZACAc9wqTGXBfbg4zcyB2tA9Um9Po1Du58AVOTatOpG5hTtG3NC9yMlaHKx
         3gpAwcfrlWB6jDOf2A5M+4KR/tco3mVy52ejPya2f0/ezUXGIn5zV/YZi4+8x44X7u5i
         QYT2CS2mPcHMd9/wZTEn6x4QEg3LLz9Cz0RL8JlmPDvv9HtBBmuCW09/AiLgz+53OC4p
         L9iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767649269; x=1768254069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Sn0DCnKIdWqQbx9oUlSjP29HAs/aUKrPzgxlC26KjEY=;
        b=vOlAtpTJTQg2hc/bLztOSJfVYVJobT7eIuhCnfb35hWl22VhzjqEWycdy9yDJkwVkc
         2CRu+SaLPYnbnshEvYbDP2t5lzMNhcSs5DRgNxv2Z48fSREMN6J6WU3+nzucVIMxJkOz
         kiKKC4Ns+fBgQRxRy3ZFWYdctTTZ8lzHRUVrNj/KhhUgixUoaHjfu61zw3eJYFNmQsta
         iVm4ByS6VoTUZ1kMqMePxabJyZi5H6lkzhqzhKqJuax7IiAZn3r5tfEr+t1FAFTkiYgG
         2f3ZMNaQ1Sk6GzBWDsJt0KZwug2L4PYdzyz5E2E7wdhI5Wmnd3BenwpuyGXJ5MhAK0l7
         6Wtw==
X-Gm-Message-State: AOJu0YxDZB6PeJHACaSLWlScwde187uPh2vUbWo00phbixJF5ADb0L9E
	qy5/CZBl3+G+LNlIzSBt30H8ghatAptO7W/vgBLWnb8z7t4kuvPJc4Umz8wz4o1GrCt1Egsx9uY
	vRplWf/T6jFLbzn8/b/ixGCShuVxDFhY=
X-Gm-Gg: AY/fxX6mn/peB4BkRbn0gUa2J6OOGivOBhYtrbI7hv/ApaGu/CwfewAgcwRKISgFzzg
	K9KE6+E8g5Eqnhrgt3u+WK1Qfoeil7ZXfZ7yz5qiCOevaz+EY7jRxHUV7SVYt/iDhz8M3ko2LY+
	fJ46WLvtRony/XEBxR0m7fRl5SVg5RC1ky84xsdbJ9ZhkHdglq6n8aEIbhoCgwzzDXaPYbOLRGR
	ZBkL9zi7nD8YI3g3ytMTqslHjQFmrtxZrj716KfTK1gtpUyn9/CBHZj0Q2H30Ry63K15bo/rYZb
	973Xq5Ol/CE=
X-Google-Smtp-Source: AGHT+IEI1NgjeidWr59K3qgIRCcopLk5RQbT+WvevAru+tDHcTPd/xfCZc8KafkwvMhBBv1B+Dx3Jpfr4tyjeFRaqlU=
X-Received: by 2002:a17:90b:3d45:b0:341:88c1:6a7d with SMTP id
 98e67ed59e1d1-34f5f2fb26dmr521314a91.18.1767649268950; Mon, 05 Jan 2026
 13:41:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADNPQri-onx+S+PqHKsOJwgwRKT6YBPyBt+U1hkDKgUr=05sPw@mail.gmail.com>
In-Reply-To: <CADNPQri-onx+S+PqHKsOJwgwRKT6YBPyBt+U1hkDKgUr=05sPw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 5 Jan 2026 13:40:56 -0800
X-Gm-Features: AQt7F2q76T1QnMEhw-e2wSzIQqKsNmBz4MDukfQi0BdnPoDJ2UzSEpRnEOMoQII
Message-ID: <CAEf4BzY8gDnZCNCGL=_hXXNwXkJmHdaJ8acFFrwU=Lm5Ht6FEA@mail.gmail.com>
Subject: Re: [BUG] bpf/verifier: kernel crash in is_state_visited() during
 bpf_prog_load (5.4.139 elrepo)
To: Hui Fei <feihui.ustc@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, kafai@fb.com, 
	songliubraving@fb.com, yhs@fb.com, andriin@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 4, 2026 at 2:01=E2=80=AFAM Hui Fei <feihui.ustc@gmail.com> wrot=
e:
>
> Hi BPF folks,
>
> Sorry, please ignore the previous email. I forgot to disable HTML
> formatting. I=E2=80=99m resending the message in plain text.
>
> We hit a kernel crash while loading/using BPF programs. The crash happens=
 in the
> BPF verifier path during bpf_prog_load() and takes down the server.
>
> Kernel:
>   5.4.139-1.el7.elrepo.x86_64 #1 SMP Sat Aug 7 08:29:46 EDT 2021
>   x86_64 GNU/Linux
>
> Hardware:
>   KAYTUS KR4276-X2-A0-R0-00, BIOS 06.07.00 (10/14/2024)
>   processor : 63
>   vendor_id : GenuineIntel
>   cpu family : 6
>   model : 143
>   model name : Intel(R) Xeon(R) Gold 5416S
>
> Workload:
>   - BPF is used by: parca-agent which is a profiling tool
>
> Crash / oops (key parts):
>   BUG: unable to handle page fault for address: 00000e4900000e48
>   #PF: supervisor read access in kernel mode
>   RIP: __kmalloc_track_caller+0xa6/0x270
>   ...
>   Call Trace:
>     push_jmp_history.isra.0+0x3e/0x80
>     krealloc+0x84/0xb0
>     push_jmp_history.isra.0+0x3e/0x80
>     is_state_visited+0x48b/0x930
>     do_check+0x136/0x15a0
>     bpf_check+0x357/0x1440
>     bpf_prog_load+0x3fd/0x6f0
>     __do_sys_bpf+0x16a/0x11c0
>     __x64_sys_bpf+0x1a/0x20
>     entry_SYSCALL_64_after_hwframe+0x44/0xa9
>   CR2: 00000e4900000e48
>
> Tainted: G        W         5.4.139-1.el7.elrepo.x86_64
>
> We can provide:
>   - full dmesg around the crash
>   - the BPF program / verifier log (if you tell us which knobs you want)
>   - a vmcore if needed
>
> Questions:
>   1) Is this a known issue in 5.4.y verifier (is_state_visited /
> push_jmp_history)?

5.4 is quite old, no one will remember by now. But we did have some
fixes for push_jmp_history, which all should be in the bpf tree. Can
you check git blame and see if there are any relevant commits in that
area?

>   2) What additional info would be most useful to collect (verifier
> logs, config,
>      reproducer, etc.) to narrow this down?
>   3) Any workaround to avoid the crash?
>
> Thanks,
> Hui Fei
>

