Return-Path: <bpf+bounces-21429-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB0384D2AD
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 21:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38D352861A6
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 20:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D278126F0C;
	Wed,  7 Feb 2024 20:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WkhU+xv4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC49126F00
	for <bpf@vger.kernel.org>; Wed,  7 Feb 2024 20:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707337005; cv=none; b=LuKgAEcEhWcyraCxjmnM73HG805CnlasCSUoaaqqJ6XNeMa2CnJreuTx/Sx/dI9SmflrhHAqqKFGjIgwEXj7uptabdDlpcCUwcAKQoK4zZHyqsiS/UgZTResag/pln+SYryekQhRVsxZ1txihbDfz8lQJXcTcw78m78q3oFX2Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707337005; c=relaxed/simple;
	bh=WZ5BNhrxj+AroJC0o30K5GXDi3t87uaeKp9pVpQk5OI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ohJFJmiIw9r8cPXvrEL14OE9G+UrE/PnEr18nhJD1r/aNSP3CyLY8/KTBocCg2mxUnvhW+EmY6KTDMWAT4/0MlY4m9/ymWNGjyzlxg9EX0IdAsuy9XkVcOB+q31Pfod0i7pjSAqHEPGp+bCsNHPdu/+WhsUx6GLbdmLS7rbLoGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WkhU+xv4; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51165efb684so1993520e87.3
        for <bpf@vger.kernel.org>; Wed, 07 Feb 2024 12:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707337001; x=1707941801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=urfBalHM/lpE/zs6IYZJfZlsMup4laKpIiZw1D8GkoE=;
        b=WkhU+xv4/idtVpyFG0OpTSc5aee0R3CRM9JyCp3w6xeq+xznzfGj/CUCp1FwRxB7RC
         fwPH0e9kohm4RqNluwas9h5HWsGJif7+MpcYLA1SGV9JaWjt+ieLbw8x1LH58xf8Ea59
         8rhRyyDIxKN+MveGF/+yA1RaboutZNBSxhRlg2mX0CnfjH2Z/6xyHWsyZ/RG2Iva4js6
         duc0re4I6VvmDN0PPOEkVaOJyWFt6cvRXIdMoti7oAxAn1BVwmToeZVdVpsnX2o1uLhc
         5LQp0flOWk3U59J/RUmfeGg4968pyTJ0E6Sjkzr2tQRtOKiBan1Gp2+GsPgyjMhz36V6
         t29w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707337001; x=1707941801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=urfBalHM/lpE/zs6IYZJfZlsMup4laKpIiZw1D8GkoE=;
        b=RhYgcXBm4tzLw9fjN+Wag8HE13tDIISJ1NfTyeAqpo3GWIHjkN/jmmE9PK+55QjdxX
         U0POzcIsVz9Afdec17H+I+hPCEVTCxcbIJDOlRKg6qRO27CEVRBS/+vSsTvwykznmbe9
         VQuF3CAdnMAAkSXa5fsJpPbfonn3W+9aj/z97sNAHkU/3/Qa4YmLADf5QqXc7I7zOkW3
         rm5Opk46XEyXbFech7ISHPGJ9PcVAHGmOJNwb/TgU9rRo8iDbTasOyPRV9ia/ouX+0Pf
         bSDhVXaSWqkNBlSg/w2+z7ojBzym7PlmUFdO3sxB6yr13k5sfhVZGGkIl2i9MWgURJWU
         0l2w==
X-Gm-Message-State: AOJu0Yy7xlIS8DzFgM69NDJpMJ9H2+znGzF9k4v0fRkN6PG/H/euMzDu
	sL34wKl8csAxLAArv78le9VIflnZPJQVU2Ooab/cLlXdTqZFvrZHNYH6jzoK4R9AG//HYXcNipM
	SACxb6vQxryVRzmyOqckF6i3j5Pg=
X-Google-Smtp-Source: AGHT+IH54T3BN8foucrCLjthHsx9YDk1U7hvUU8G9Qon3vzgtBtwc/fmRUsZzlG4tAcmzmG+k/1XoyKluX0aiJK/XqE=
X-Received: by 2002:ac2:44d5:0:b0:511:4edb:501a with SMTP id
 d21-20020ac244d5000000b005114edb501amr4824997lfm.15.1707337001022; Wed, 07
 Feb 2024 12:16:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206220441.38311-1-alexei.starovoitov@gmail.com>
 <m2h6iktpv7.fsf@gmail.com> <b97c5318-ccd9-428c-95ca-7c120eb7c089@google.com>
In-Reply-To: <b97c5318-ccd9-428c-95ca-7c120eb7c089@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 7 Feb 2024 12:16:29 -0800
Message-ID: <CAADnVQL8mQeG24gymydL6ZzazLTkdQQJ=_g5T2CcEfNhLsxuag@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/16] bpf: Introduce BPF arena.
To: Barret Rhoden <brho@google.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eddy Z <eddyz87@gmail.com>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-mm <linux-mm@kvack.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 5:33=E2=80=AFAM Barret Rhoden <brho@google.com> wrot=
e:
>
>
> if i knew userspace wasn't going to follow pointers, NO_USER_CONV would
> both be a speedup and make it so i don't have to worry about mmapping to
> the same virtual address in every process that shares the arena map.
> though this latter feature isn't in the code.  right now you have to
> have it mmapped at the same user_va in all address spaces.  that's not a
> huge deal for me either way.

Not quite. With:

struct {
   __uint(type, BPF_MAP_TYPE_ARENA);
...
   __ulong(map_extra, 2ull << 44); /* start of mmap() region */
...
} arena SEC(".maps");

the future user_vm_start will be specified at map creation time,
so arena doesn't have to be mapped to be usable.
But having an address known early helps potential future mmap-s.
Like to examine the state of the arena with bpftool.

