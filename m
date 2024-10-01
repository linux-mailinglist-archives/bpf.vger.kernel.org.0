Return-Path: <bpf+bounces-40656-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FB598BAC1
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 13:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B33B1C22B09
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 11:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45441BF33A;
	Tue,  1 Oct 2024 11:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hj/F6vR+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D384E1C2334
	for <bpf@vger.kernel.org>; Tue,  1 Oct 2024 11:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727781255; cv=none; b=VKPJHeG5VAK0hpWrW9srfIH73qonxKJMTyr9NN2qdwb0MYc3Cmk1r6vfmj9txoZW7SySrBFGPPsmQiJFQ2KrP+4rEmVjJmnXaxrCwYBLx+UxmqpkRXMxxNvoALP0/FRT2s5E+BdoqqOUltC2Qruu4LwzsWI7NqaDJRi3p7THGn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727781255; c=relaxed/simple;
	bh=GEs7iKGFzN4Ud6d/Q/e0srof+xXfc2M0KsYcsfommRM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N+Mcg1mNO6FHJcOhtXnLKdoe9+15LEy9yCvR2xl6nZrhs6NuXUTuArhp1+EVfCJQcG91mPSF53VvIMD6Yz3K8KRqJwhMX7dcm6wcSfLrB6epP03Jlp6TUf/uxWxx11uWG6LR2D/x+rb92JcsLMQCsA7gOYdYTyxNdRKyuj2T+8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hj/F6vR+; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7c1324be8easo4808410a12.1
        for <bpf@vger.kernel.org>; Tue, 01 Oct 2024 04:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727781253; x=1728386053; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ky6emhle0w3/yG6TLA4gcKrBkiaKW2vvNkvS9s0tqNc=;
        b=Hj/F6vR+cdAaAWTL0YI5x/ASVjyM6WXNJujnpVbsShzHFkIVS9w1KgivwxHBExbbgz
         vNZnlrVY3k29tSHbSVs0t+XsBHXO8kkYBGS6DoQBFAMqOnwvatrmZq+wW7LJR6hxYBhY
         LDDdcGgwIFb7yqAvfZPXJu9U3lfH87Z8DjoMiK5S+tMOdQ9f2nDhRkc1/YRGdiFXIvzZ
         HQR/x9Y2CC/ywHXSw2MOuA2PGC2MSpNtd/vMvMGqE1KBlPpBGQ2X2z97YC2dtFkIyBg/
         3tnI7X6SiiSCQmo4D6QxoMiO7gVCGFyZj7EtleROD9iW9KGykkzLKEFvPsRg/+AH82as
         kczg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727781253; x=1728386053;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ky6emhle0w3/yG6TLA4gcKrBkiaKW2vvNkvS9s0tqNc=;
        b=B3TyqyRwawiuQgPbqOYzavZqU7LsdvHaZa1JVc5f+e6gfG4ECYClrwihJKNflVUSm3
         ILkCp54FL1CAxWcwo901OhQv/CZ3d4GVPKSQhmgsDkaZf/2eWCLYys5mQ1RQAkpZOjc9
         DKDyid3pcLQeyBHRSJFU61XDYwY2zNVm7WwuHi+PsEKMpb7LwmIngvHQmat34KeJJg/j
         P97LQ2U4orgOr5IZuS0RiDgi9v+7NjmRuyh30faVBW2gL/T7/x1qpockEAFhHc2r9eBo
         MY0uh/+P80C9MRSYPS0VJ3pz8N8AsiwU5fYprY3izPzXMjI0EAXnrSUIfkHkTNhPJqV0
         xb4A==
X-Forwarded-Encrypted: i=1; AJvYcCX0Fnhh234lpG1d1IFLySWpAOgOcvhoRAf0nzw6AOU+yVNgm0HocvptXN6YS688myT6SGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoBDt0BcUV1Dis7y3mSt4IFyPG9/TNo39/1VZwe6DmnrohTdb3
	X/YogVGeoynn2f0iKKtNxuI/9SMErxmdRp88PYwNe/TU1rgphmyc
X-Google-Smtp-Source: AGHT+IEr8Fd58V85LgqUekTOkg+lwcTw6phJX+JcNdm7qaq0XuP7MTgY19fzPTgm1sP/jFvpNbsFcA==
X-Received: by 2002:a17:90b:1650:b0:2d8:7a63:f9c8 with SMTP id 98e67ed59e1d1-2e15a3105eamr4239201a91.14.1727781253141;
        Tue, 01 Oct 2024 04:14:13 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e0b6c9fa91sm9897961a91.29.2024.10.01.04.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 04:14:12 -0700 (PDT)
Message-ID: <1ea99d1e31c3f52f8962b186a150dfb0ffd23e45.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 0/4] bpf: Fix tailcall infinite loop caused
 by freplace
From: Eduard Zingerman <eddyz87@gmail.com>
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 toke@redhat.com,  martin.lau@kernel.org, yonghong.song@linux.dev,
 puranjay@kernel.org,  xukuohai@huaweicloud.com, iii@linux.ibm.com,
 kernel-patches-bot@fb.com
Date: Tue, 01 Oct 2024 04:14:08 -0700
In-Reply-To: <20240929132757.79826-1-leon.hwang@linux.dev>
References: <20240929132757.79826-1-leon.hwang@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-09-29 at 21:27 +0800, Leon Hwang wrote:
> Previously, I fixed a tailcall infinite loop issue caused by trampoline[0=
].
>=20
> At this time, I fix a tailcall infinite loop issue caused by tailcall and
> freplace combination by preventing updating extended prog to prog_array m=
ap
> and preventing extending tail callee prog with freplace:
>=20
> 1. If a prog or its subprog has been extended by freplace prog, the prog
>    can not be updated to prog_array map.
> 2. If a prog has been updated to prog_array map, it or its subprog can no=
t
>    be extended by freplace prog.

So, once this series is applied we essentially have:
- three variables:
  - tgt_prog->aux->is_extended
  - tgt_prog->aux->prog_array_member_cnt
  - trampoline->extension_prog
- four operations:
  - link/attach extension program 'prog' using trampoline 'tr'
  - unlink/detach extension program 'prog' using trampoline 'tr'
  - put program 'tgt_prog' into prog array
  - remove program 'tgt_prog' from prog array

And above four operations have the following pseudo-code with regards
to update of the variables:

- link/attach extension program 'prog' using trampoline 'tr':

    with lock(tgt_prog->ext_mutex):
      if tgt_prog->aux->prog_array_member_cnt:
         return error
      if tr->extension_prog:
         return error
      tr->extension_prog =3D prog
      tgt_prog->is_extended =3D true

- unlink/detach extension program 'prog' using trampoline 'tr':

    with lock(tgt_prog->ext_mutex):
      tr->extension_prog =3D NULL
      tgt_prog->is_extended =3D false

- put program 'tgt_prog' into prog array:

    with lock(tgt_prog->ext_mutex):
      if tgt_prog->aux->is_extended:
         return error
      tgt_prog->aux->prog_array_member_cnt++

- remove program 'tgt_prog' from prog array:

    with lock(tgt_prog->ext_mutex):
      tgt_prog->aux->prog_array_member_cnt--

I think this is correct, would be great if someone with more
concurrency related experience would take a look.

[...]


