Return-Path: <bpf+bounces-57703-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52553AAEC9E
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 22:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 676767BE262
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 20:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25E7202F6D;
	Wed,  7 May 2025 20:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="id482y8T"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C889417A319
	for <bpf@vger.kernel.org>; Wed,  7 May 2025 20:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746648110; cv=none; b=lfy6GGcw91Vge+FgiTila0Zf00OWAHfXxktqPbYrtrYp/fKoqBSsZTW5oQyUcsBhWMzAOuATQMVv3U77Zg9CQuL5I01JPN33yX5ul2EPYZvXFoM0oVz9P5aLFd5Qbqq9VhleOoKIbw5Tr8CvCLWiQrrzjpY50wAjCuvk1Sdy4QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746648110; c=relaxed/simple;
	bh=nUGA9Fdmef3MOl25GpWQ8JpXMMCOejE4rNPvvjFQ/40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PPa+Yd2dY8BgtD93d0OKJ6AlaRzszzRBJmynO9PE03aI1ZFGrG6ZvSWdMVgZ8hNnok/R3JnnTuIN+6TrNQzCyEhpcqNy1m6dnt+RpeD7Z7RuQgLthK5t1WGJ0QEHfhU1miwaTzHpSluxp7myq+rfMz+K6Tk4F5eIInzGuLIhdy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=id482y8T; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-442d146a1aaso1255465e9.1
        for <bpf@vger.kernel.org>; Wed, 07 May 2025 13:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746648107; x=1747252907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nUGA9Fdmef3MOl25GpWQ8JpXMMCOejE4rNPvvjFQ/40=;
        b=id482y8TkOUBdqcPFE9y2l2QmV/EogF56EQdUPnKls7XhlidecYJb7y4tvGB9DEQIH
         VUM3NDWw7A4pgtuXil1usM08QALBKyTjx8fxsxmKKvO1t4oo/1Z5G1SoXnZP8ES11PhR
         voFftWvTNisG1dRnzeY9IY+KtIqucP1gFyX/tuCtdVMkA1CLFnmsSIaL2MJiBqgMfCDI
         Uw5H//EcTHkVC7Y6H6f7hl9lHYgA2QPkLOqPNCktGFomGxrS8UYGzL2azpxu0DTG3+Qw
         2V//4GpMO1z8ToNJhYN9AeGJHmCKt/F6pMrHYiskm6As52Y94hOiZ9zJv+JvW1IRGrVW
         t2CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746648107; x=1747252907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nUGA9Fdmef3MOl25GpWQ8JpXMMCOejE4rNPvvjFQ/40=;
        b=X4c4gDqyZG7hxYx7rWE5SnxwcukhvWdsxvJVSXkrBf4ZuV6lGs3VrCIRZWKbt11nrq
         KHYo9gMnTIi2a1rxEJfp+5lt1a8YlHR9pd/2qx7LBkI375kJC0Ot2ls2y28XR9W/105l
         wXnkcBNni+srXd3kSp/VNx97YlAadb9hOjfWOBnzK1PMg5Nv0KdMPsNbmlVw2bt41xbt
         D7vy/8cvwvXUFxWXHOvSArxEFPqJhxL3ArMOUkxGVMz8SP0W8RFvPc5U/d8lREX7t55X
         cRQbjOxhCrM0BlESDOJ9yWFleTbNARIWQn5DmW6tfY1V9bZp6S2qu8squ18PFFS1Jmgb
         eNZA==
X-Forwarded-Encrypted: i=1; AJvYcCXgeYGbe+Hmon4zeao5XtOKkHdjeKKaXqJE/3z0QCodhAIcj7cl88IpudVIDl6Z1IwRR/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI15nalF8DVsXBaFmUiDd0PJDkU67uDY4GFlq9Krabv4Sll0hg
	gidZCWXnfEX3m9LRu2v5uIugFnKSxU0Vcg7ZkW4S+VpWiwqMePgmRu6PwpnPSCvNV3KemLANhLp
	P7etA999//nUOoMBySiYwHpOTsoA=
X-Gm-Gg: ASbGnctg3WEQ9E5BRsgagqPBU3TFJRoqUuyHWDsMFfbWLAxrQXmudGz++9mmzDaakxG
	RhXuC8K00EXZpQF2tItyp7KXeTJUHTHDoQR4sTw8B/wAn9g5ivVnPQiOEwArNRLKSx1cAilYZY2
	xMpr2prHPh21y43YFQLy34lXIk0mGD5xJQxI7k2IO3DxRwb2mApG0Ijx1/PCEM
X-Google-Smtp-Source: AGHT+IGSgZI2TPELoB2KsioAqvlDGDnRXfgmBhGKncBVfmtbaCgWE/uDnEyflSjZvEmfyqAud3rqPj5IbuISBIOAWO8=
X-Received: by 2002:a05:600c:35cf:b0:43c:e481:3353 with SMTP id
 5b1f17b1804b1-441d44c9369mr38992135e9.17.1746648106774; Wed, 07 May 2025
 13:01:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250420105524.2115690-1-rjsu26@gmail.com> <CAC1LvL3Tkzb3RtbmzsspOHkmz+28g7qKP04Ni6+Dvj8jD2TWJg@mail.gmail.com>
In-Reply-To: <CAC1LvL3Tkzb3RtbmzsspOHkmz+28g7qKP04Ni6+Dvj8jD2TWJg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 7 May 2025 13:01:35 -0700
X-Gm-Features: ATxdqUHHQ8J-CCEF6QLUO6E-EnmHDMQn7E-Z300DJZRck_N8AxGWtyE7kEvoY6Y
Message-ID: <CAADnVQJJ-MxitkXerQ6ixTRyiHKJcHCikNyTvghxkNZEADOdfA@mail.gmail.com>
Subject: Re: [RFC bpf-next 0/4] bpf: Fast-Path approach for BPF program Termination
To: Zvi Effron <zeffron@riotgames.com>
Cc: Raj Sahu <rjsu26@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Dan Williams <djwillia@vt.edu>, miloc@vt.edu, ericts@vt.edu, rahult@vt.edu, 
	doniaghazy@vt.edu, quanzhif@vt.edu, Jinghao Jia <jinghao7@illinois.edu>, 
	Siddharth Chintamaneni <sidchintamaneni@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 11:15=E2=80=AFAM Zvi Effron <zeffron@riotgames.com> =
wrote:
>
>
> My understanding is that with the Fast-Path termination mechanism, those =
write
> instructions will still be executed and will still update the map. But if=
 the
> values they are writing are dependent on the results of any patched funct=
ion
> calls, the values will not be the intended ones which will result in data
> corruption. This corruption would not impact the safety of the kernel, bu=
t
> could cause problems for userspace applications relying on the map data.
>
> Is that a correct understanding? If so, is that a concern that should be
> addressed/mitigated?

In broad strokes it's correct.
The fast execute approach will not be stubbing out unconditional calls.
Like all bpf_rcu_read_lock, bpf_spin_lock, etc will still be executed.
Anything that returns OR_NULL will be replaced with NULL.
Like bpf_obj_new() will return NULL.
Think of it as forced ENOMEM situation where everything that can fail
is artificially failing.
There surely will be logical bugs in the program, since programmers
rarely test the logic in cases of "impossible" failures.
The kernel itself is an example. syzbot reports due to failure
injection are here to stay.
if (kmalloc() =3D=3D NULL) // just exit quickly
is a typical pattern for kernel code and for bpf progs.
In the latter case the verifier checks that the kernel is safe,
but the code may leave user space in an inconsistent state.
The fast execute approach will exacerbate this issue.
And I think it's an acceptable trade-off.

