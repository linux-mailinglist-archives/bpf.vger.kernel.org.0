Return-Path: <bpf+bounces-67959-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1FEB50ABC
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 04:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 827D01C62D26
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 02:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D3E22B8B5;
	Wed, 10 Sep 2025 02:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqNDmvbj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA29A22A7E6
	for <bpf@vger.kernel.org>; Wed, 10 Sep 2025 02:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757470025; cv=none; b=Obcf3oaFji3rcLAoSFgrDWUhWAjvzv7vCw43pZFUGlr/DwzXQsqH0eDmDynsNlmqHDwCEsIM4qjiBmC9wz7B+jCcZNelIfVHpuaC1SRT0ZedHa6OqlOE0K5DTjzH6PgUU4YkoTosDd1LXzjXgMvkLyspTzFnav3NiW6sPa1tKFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757470025; c=relaxed/simple;
	bh=XxmwLVvRPdJVtyv3IT3HKVXfV5z0ldSHFP4TASGsqCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T+pe74FvhDMetT41aNVReMQh4yGAfaFTbJZPz5f68RvMmNeui4lkQOynODDmwrEGXm1dye8o++eLKY7+ERyfncvzIRcKVgYFU5348oTiZ18HTs4+j/nmxE0B8h8kaj19r/hRvZFz/3KiSPPL8ix4i7QSoEzNW/aKa586qTaJkLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eqNDmvbj; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45decc9e83dso9377495e9.0
        for <bpf@vger.kernel.org>; Tue, 09 Sep 2025 19:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757470022; x=1758074822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XxmwLVvRPdJVtyv3IT3HKVXfV5z0ldSHFP4TASGsqCI=;
        b=eqNDmvbjocR6KQv70FyniRSWX+pxchiLunzEY7Vo/YymYH3H8NU7OAVuEV8MkLrWSe
         6nrH2X6JSh/nwPSony40ViytzOkdjDLg89HCS0SCsQnllsrRoTb732MersU18M3v5Dz+
         CpHnawrCPkhTi2ZRsvJoTh6UXwt9yJdRf7pqSYnlX2s0aNp6UiTWKQ0a1sbDdbLZ0cD0
         MmokDHbVBPPswyKKikiy55u0MnZCHLHDWam/gh3PJwOSs/MKd+tSWcAl3VX5Wf+qBdCy
         NqirxxalUDWDt6bAVamvU02ENAbtY6SwssaJIYsC0EcvLQbgPnxFoaNsBCR6IaVz4Nq9
         f8DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757470022; x=1758074822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XxmwLVvRPdJVtyv3IT3HKVXfV5z0ldSHFP4TASGsqCI=;
        b=MT2WgjAJ86/AXDGV6hu1t2k4qHjDE2mdGXzXprK+I7SSWxz9hFtxBG45FXiINmkmYz
         hOf/upXgQ7uYOS9CFDZy0l1Wo5Bn2RbvY0LatkXw/CHGnQ5pvgAWxlqjTvDqU5qz01Uo
         JV1aHaAymV1KOfPtCidfb15kW8CxNNjSuUW7QFBdaFkgxKTmKyQKGaZABVZOZJnhENAz
         qigr8cnaMXj5cheUIOTo0Xd45Sk8avO71wBqf5J6BNvHUbLQqkUrzuuHpvf4VCMjKBCh
         biS1XV/vSE0lgU8nkpfIbMelf/w6hTBN67ePBjOWsqwviskk/XoSgkSWMaG5QojAHo4v
         4dsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEXG3AV2HXOgT7DEYsqCQ9i7p6V32ONhGFPBa4ZHfg5/YpfyFux6Sq1DlBc23dCjHREtU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYyrxaNrXuD39xwNV219sqy9OSpX091CXIKYL+PENbydmAMpyX
	X3Q4Yy4lj6sYf8wlOKWkNESFyqlkXgrLZBSP7fhcv/340rQedUbppIAVPgZS55T7vTo+K33VD6U
	4Y2JQWvxf4TYCEfIV3ZOpj4xj8+Jltns=
X-Gm-Gg: ASbGnctT136ixnwfnVW2Ai4mD+gDNcONoDMCzB1rJoxHGKhEx8SRNfg5FS8SqQF724p
	4RwPHZmS5FMi7NY+L4+IGYHH6Az7rbyjoy7qPwfC6qpqvw54VYAIGjRHq1tC4pNVh3g46zr6CsR
	zIUNZ7TXGKAC5dPDa+8gVLBFiVEt4WjZicYIIVItIZmD5PaTxjiTc6WmPHQA1FHsRW6h5YzpZWq
	p4cUjMs2EM6n6FNPRQrTmrpvKurNz/L7D4m2yte830/jd4=
X-Google-Smtp-Source: AGHT+IE1reioN13frO1xULoiFOscJ81pilFbsBZ7ZJHO8o/D42iGZcsYdlSFPqEdSInpTjizdeYSbjjakuhdyyNh/zA=
X-Received: by 2002:a05:6000:178b:b0:3d0:fef3:f3e8 with SMTP id
 ffacd0b85a97d-3e6423091bamr11922452f8f.1.1757470022076; Tue, 09 Sep 2025
 19:07:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908044025.77519-1-leon.hwang@linux.dev> <20250908044025.77519-2-leon.hwang@linux.dev>
 <b0505a919d39e8151d0e14d9e41950f19d3807e0.camel@gmail.com>
 <603b37f4ef1a3ccbb661eaf11f56da9144bdcb66.camel@gmail.com>
 <aL9bvqeEfDLBiv5U@google.com> <CAADnVQ+G4u1vM7OUUKaos+jyG6FF8-72t8rMKyqRoa7nuF8xFA@mail.gmail.com>
 <cad23151-7039-4a7f-b4ea-030ec161b2ba@linux.dev>
In-Reply-To: <cad23151-7039-4a7f-b4ea-030ec161b2ba@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 9 Sep 2025 19:06:51 -0700
X-Gm-Features: AS18NWAaBCJ4JPUg2U0Kep6T7KVwTqc0xLfGxH4IjoKJ_642iCgPhRqHPo86iQQ
Message-ID: <CAADnVQ+C+Zyzz4MHU1Qh9eVuKec8+F+gnOZy5ZDVUAXWP0O9YQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Reject bpf_timer for PREEMPT_RT
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Peilin Ye <yepeilin@google.com>, Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, kernel-patches-bot@fb.com, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 7:02=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> wr=
ote:
>
>
> If I respin the patch for the bpf tree, I have to drop the part that
> skips the timer_interrupt test case. Should I?

of course.

