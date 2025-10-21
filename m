Return-Path: <bpf+bounces-71634-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F07DBF8B1C
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 22:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E28535002B1
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 20:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1E327702E;
	Tue, 21 Oct 2025 20:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJdYat4Y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41B71BFE00
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 20:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761077848; cv=none; b=ZJY+ot2fDr+uXEpaZssPrIs9ODhsufo1B76/SnVNRa7r1wWw93cJ2BLfvxcRTk/fjgKaKR5DoVAgXamziDr1+ax3KTguKGKL3HyysFJjdus/DLKxLDVsrO3dMFpQEhHlKehuNN7lmFvDi4jG6d8jpPQEkVuLIY0gDyeiH3YEDHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761077848; c=relaxed/simple;
	bh=uuKYZzhrJBlhDs2WNe/l5k9/ssushHuPi6UdpGhAJOY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MO9CiupU+RbSPl9upAPvmNgIguwxYW+sTO+tSOnNqX0PyOm3PenJHUXzad9vKGRzDVVCtQDRqAJeucsJlPaFQL8lH3fS4Qefih/ytBNpiLm7U3y5hI2jloT+uT+HcbJGDvqu/bxDQwcuMiAp9YMVHtGeBn+IRhxGQZ3S4hziS8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJdYat4Y; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so292236b3a.1
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 13:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761077846; x=1761682646; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3SxDQ0Dea2EN9Mhin9m5QYocP5g7vCDjjHVPltnRVPE=;
        b=KJdYat4Yh7QZQVRemvLIw/NKpgcsmft61Ktn6nuSMWYKR1JM4EZXyMp9xJl+pNmXBs
         bWEhPfARriawQf8tYYa7j/JHxrpPEuPe+ahVHz9jwfwhVZpuFyJNmQydsngriG2bMT+b
         zwP61o5dawi7bXHpIpI4VC6Zkwxm6X+XYNMWTXg9XsaIAY2+Nn5YNw3oxWqt5Vw7wu9L
         igDVntkMBANl2LYb1JkI12iDpxobsRumPcbqx5vjyGjrL0X1ON/bzulvH30LsCrZQwQU
         KRU63iRpcbPra9AXiBprE026jNYs9+lMNdk9JAyMZ1ebR+0Aa+A0e1TuHTujMJeVPQYB
         EW8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761077846; x=1761682646;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3SxDQ0Dea2EN9Mhin9m5QYocP5g7vCDjjHVPltnRVPE=;
        b=barLojQaT+ab9NvTAHo8OdXvU/wVEz3G8ure8hMUnE0jE2tyZu1h5YOiQACIq+dMWk
         kVQKgqxFXOvv3FlAtyQ7lg3F9H43T8r2WthdhB9gxx+xlKtU+JfQ0qhpYut8Swza3z6z
         ZxsR2a4KTV0xSFTw3aY/R5oVJWMqzucx8wPKNovumGZG0jVRvVt1ww1kgQY3DgikY/6T
         T2AkN2rLS+/O/QkuHd9/UkJDly+KG6YMXE6v0aG3B0m+3i+xXQDwydaRA/jSudQrahnm
         Jn1rSvhdYSUQzAcWshh7JffJL3kaqyC5eKHY9kS8gYk9BSUDmUlrOBswh6k089Rs2H4o
         o4Hg==
X-Gm-Message-State: AOJu0YxjM7b/w5JCE10w+Y3Jy5Ejb1VbgarHvnOnyChRl7GAgW0Croe/
	zyrU8dD1v9R393K6rVCFUpbtxDB8ljXIO3CDp2YldtaRw+Qg2hqaqswt
X-Gm-Gg: ASbGncvvfjObYuWps2VAmU+wG61VXvm9MV37W7W26JPGy+NBdvnq7l7Ao8ij/FmcbF9
	DRemesne6OvehLqOVLSEhsTHAsztzo1ZnSwOlOXdTJdifBE5LNmqTVynSrc8UJ8npbomq2jXvlN
	QOuJ+mnqEc9Giql+dDXJ5SUxxrt/1XmWsixkJwbCzdvkrAwp+JfS/3XhA7mq0mwDeINTpmCg0VQ
	vDXkVpgmDA5q/oEDcZOfepOb3eW5Wfmh08zybrVwmXia3Dnn/WgtKKnTIULbTqE6HkE6w/QjTq3
	2b0SZR7hXSyxtq+3oSKHzbGDaUdfKTAIRo2rwbzdtYeg8X6+goPG2/rC1z8oz8wvbGenCxtHHeI
	EPqN/fM1miiJ9Hm8a2jn18Lnxxd7kSx8uGllhIQ2mV0Yv/YwzcCgCZ42x9KIpR4GkR4HAOJlUec
	2ZuAVWUGPIWkbHh3vQUOkaW61XB8Rhb/eaq8I=
X-Google-Smtp-Source: AGHT+IFp64i21ms5AO0A4F5ZzFLRZjyXe060rK8G8UrMc11xUXUkghqJi3P2NuJUUfewYUeTvho1Aw==
X-Received: by 2002:a05:6a20:2583:b0:2cb:519b:33fe with SMTP id adf61e73a8af0-33aa7976967mr1265925637.21.1761077845756;
        Tue, 21 Oct 2025 13:17:25 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:84fc:875:6946:cc56? ([2620:10d:c090:500::7:6bbb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a2300f253csm12198467b3a.47.2025.10.21.13.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 13:17:25 -0700 (PDT)
Message-ID: <3d2acb79f963a2af3db078210d625b201c045559.camel@gmail.com>
Subject: Re: [PATCH v6 bpf-next 12/17] bpf, docs: do not state that indirect
 jumps are not supported
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko	 <andrii@kernel.org>, Anton Protopopov <aspsk@isovalent.com>,
 Daniel Borkmann	 <daniel@iogearbox.net>, Quentin Monnet <qmo@kernel.org>,
 Yonghong Song	 <yonghong.song@linux.dev>
Date: Tue, 21 Oct 2025 13:17:24 -0700
In-Reply-To: <aPfkI9r6YnS7QNKz@mail.gmail.com>
References: <20251019202145.3944697-1-a.s.protopopov@gmail.com>
	 <20251019202145.3944697-13-a.s.protopopov@gmail.com>
	 <83225612f07f1d0f2f488efaee9c075b44e8cc03.camel@gmail.com>
	 <aPffwozAdFGGgyc3@mail.gmail.com>
	 <0c18d017a9faeef2dfdf970683b0fe7b9d63faa1.camel@gmail.com>
	 <aPfkI9r6YnS7QNKz@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-10-21 at 19:50 +0000, Anton Protopopov wrote:

[...]

> Stack was the first thing I've bumped into:
>=20
>     progs/bpf_arena_spin_lock.h:164:12: error: Looks like the BPF stack l=
imit is exceeded. Please move large on stack variables into BPF per-cpu arr=
ay map. For non-kernel uses, the stack can be
>           increased using -mllvm -bpf-stack-size.
>=20
>       164 |         } while (!atomic_try_cmpxchg_relaxed(&lock->val, &old=
, new));
>           |                   ^

I mean, this makes sense =C2=AF\_(=E3=83=84)_/=C2=AF.

> But then also some things, say
>=20
>     tools/testing/selftests/bpf/tools/include/bpf/bpf_helpers.h:169:15: e=
rror: invalid operand for inline asm constraint 'i'
>       169 |         asm volatile("r1 =3D %[ctx]\n\t"
>           |                      ^
>                                  "r2 =3D %[map]\n\t"
>                                  "r3 =3D %[slot]\n\t"
>                                  "call 12"
>                                  :: [ctx]"r"(ctx), [map]"r"(map), [slot]"=
i"(slot)
>                                  : "r0", "r1", "r2", "r3", "r4", "r5");

That's probably because of the missing constant propagation.

