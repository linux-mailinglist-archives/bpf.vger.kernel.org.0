Return-Path: <bpf+bounces-59991-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CE5AD0BF7
	for <lists+bpf@lfdr.de>; Sat,  7 Jun 2025 10:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC3EF1892D95
	for <lists+bpf@lfdr.de>; Sat,  7 Jun 2025 08:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE8F1FBEA8;
	Sat,  7 Jun 2025 08:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xqcd8z2U"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11BA184F
	for <bpf@vger.kernel.org>; Sat,  7 Jun 2025 08:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749284011; cv=none; b=eNXcw35GQTBMeig+sU+bWL1hwIZuBZPtZkJQN6GuPFmXeiybawnDdg1EXi/3TG+jqXXras5G8fdXIDRxXN8zMTHkdKrN8Bvihj1dTTpPMFDnuSIwekiwmb26PrBBORMqjj6JeS6WsA/fQgO88jRnp/VTkNk4tN1ZCDR1T2Kk+20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749284011; c=relaxed/simple;
	bh=7/fsjhUJlKrW1XPn4BNIL3kjwsPLgH543YHeXofckWk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lvbCYNu4UvnX2BhRSdlXhGO6WrsS+gxHxvo9WJCnrb59ndMzz2L66epSVTZj9ht/n2rhiKqvAUPskqGzqArBIAAp4CEEMMtB3AH73V5IAjsJWPRPL+AG4fUlHOfIHIdlvRfes33vMvl+ggKUJ4XKyYMplY+TQ5c7Tvip1nZal8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xqcd8z2U; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-31332cff2d5so2075994a91.1
        for <bpf@vger.kernel.org>; Sat, 07 Jun 2025 01:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749284009; x=1749888809; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z1bBfwpPJkB1WWfdIQjxKEJ8JENPWh0D9QKUoUQFuY8=;
        b=Xqcd8z2Ub6gWdbfmkMYrTL8bTzQMfhNLN3PZZ8SP8o32ikYamqxZcHzqvJgiD9rGvL
         9kTlEqoU01Fj6tmEr89wjlbdlSFkRqTioK2XSkJMxDk8508ajjxXa7MMlBEEmnpusoqn
         60qj3qZnGjOPzQ546iiOqUDz+9+XtrnN/zwG27kC0p/HKUghZMucGa0X85QdGpnNrH/x
         /Xt24+E4OyEq6SwB4nT1CzN3GV+U4lxMUEIcZianyxzeTNPZDOoApgGWbdyDQmYECR6w
         BvtKxy3n2C9GjcL0M05Xk76sbsW+53aD+OLec6EhxIIiRObTvIdR2KpIZTbUcOMo7D4m
         SYag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749284009; x=1749888809;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z1bBfwpPJkB1WWfdIQjxKEJ8JENPWh0D9QKUoUQFuY8=;
        b=uahQruJk97FNp9wQex//zQF3V9B1loXVbfUQsQw6XaBzi6SwM9CGcJnr62AD/miXZg
         CRzJeDmBP6HRQxyJnbSJ7SFwfYWHjKB1SVTNh/+0ewAR6zdShKcyy6mM6X7J8JT2C8vN
         KdflWcZLln0yUYnP8F39J/hBYqSitoPYiikq2BwInMywb+eWwX72qXT9jVfQ43s3YKet
         qm66weG6tt3yOumonElctBNFiBr8I9JlK/AZ1Xxli2BMS95EFvv8grEk+ceikM026xgk
         tPHVQLUzW/MpYOPKiSmxu6avzdFilBY/3rM6WQ9f45t/3uAFdm26NCUUTYJFPcZaAMTK
         4LdA==
X-Forwarded-Encrypted: i=1; AJvYcCVv4Y0bAkdNNakq0nNfvj584kf6LAH/oFgapuvFfudL5PQxepeJPTBIb1qT3pLNM47X44k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxOlC5E4cSk3oVpSeQSSrKM5LvgQ60fcaCY8f8c7E0/Jf4TXqh
	OatG2hsyBzxZoRfO3dVCLGMVxPN9e9Caq4QrQ17gdC9hxyBbchJtK+P9WJ/A0Vvc
X-Gm-Gg: ASbGnctYwCDwSD41c96JC+KYluJWxD6XIo6qqVxUoN1rTV/d5sHuoclNqsbxY/W2J+S
	5T1at453cCSa8gM+s38yqmbZhy9F9SJGbg0seAXSEwodgstL7aexSwB2rQfw9Zl7kYNaEWW8aIu
	sA0GfkyHRdHnpFJpu0f9Nree6yjWWjuGz1M7AEZtSbZYRNdqZh34Jbqcoy6Pj4XO206239D8REH
	tmBU+vE8tFHSGSxGer0+uOBa6TWC4eZjJVIQruwx4E4UZIQaHFVq07EF8NvXMD0wNYNKIPX94ex
	l/e0IgZuUk55DrqbVWveohOyPUSNeCUpambHaDQyR3MIDXyHB//oDI3LOg==
X-Google-Smtp-Source: AGHT+IGliPMRrc7wHdX98WMDMaLKYLKjeyIERUvx8BmMigeQHaiz3SRFpk8qBKtrKatP9q1ZFHy0Jg==
X-Received: by 2002:a17:90b:3c04:b0:311:ba2e:bdca with SMTP id 98e67ed59e1d1-31347065472mr9510308a91.28.1749284009008;
        Sat, 07 Jun 2025 01:13:29 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31349fe0048sm2361695a91.42.2025.06.07.01.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jun 2025 01:13:28 -0700 (PDT)
Message-ID: <ae7b709f618ecd75214e62f2a300fe2949d9b567.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 2/2] veristat: memory accounting for bpf
 programs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, 	kernel-team@fb.com, yonghong.song@linux.dev
Date: Sat, 07 Jun 2025 01:13:26 -0700
In-Reply-To: <CAEf4BzY2CzZy8DMe==F7OmvEO2gkGG___SaZgu8dGDJd4LG4_Q@mail.gmail.com>
References: <20250605230609.1444980-1-eddyz87@gmail.com>
	 <20250605230609.1444980-3-eddyz87@gmail.com>
	 <3dd16f19-63a4-4090-abd0-9b84fb07346b@gmail.com>
	 <efe0cc259f70b11ffd3e398441efd0de5aa98c3e.camel@gmail.com>
	 <CAEf4BzY2CzZy8DMe==F7OmvEO2gkGG___SaZgu8dGDJd4LG4_Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-06-06 at 11:19 -0700, Andrii Nakryiko wrote:

[...]

> Looking at memory_peak_write() in mm/memcontrol.c it looks reasonable
> and should have worked (we do reset pc->local_watermark). But note if
> (usage > peer_ctx->value) logic and /* initial write, register watcher
> */ comment. I'm totally guessing and speculating, but maybe you didn't
> close and re-open the file in between and so you had stale "watcher"
> with already recorded high watermark?..
>=20
> I'd try again but be very careful what cgroup and at what point this
> is being reset...

The way I read memcontrol.c:memory_peak_write(), it always transfers
current memcg->memory (aka memory.current) to the ofp->value of the
currently open file (aka memory.peak). So this should work as
documentation suggests: one needs to keep a single fd for memory.peak
and periodically write something to it to reset the value.

---

I tried several versions with selftests and scx BPF binaries:
- version as in this patch-set, aka "many cg";
- version with a single control group that writes to memory.reclaim
  and then to memory.peak between program verifications (while holding
  same FDs for these files), aka "reset+reclaim", implementation is in [1];
- version with a single control group same as "reset+reclaim" but
  without "reclaim" part, aka "reset only", implementation can be
  trivially derived from [1].

Here are stats for each of the versions, where I try to figure out the
stability of results. Each version was run twice and generated results
compared.

|                                    |         |        one cg |     one cg=
 |        |
|                                    | many cg | reclaim+reset | reset only=
 | master |
|------------------------------------+---------+---------------+-----------=
-+--------|
| SCX                                |         |               |           =
 |        |
|------------------------------------+---------+---------------+-----------=
-+--------|
| running time (sec)                 |      48 |            50 |         46=
 |     43 |
| jitter mem_peak_diff!=3D0  (of 172)  |       3 |            93 |         =
80 |        |
| jitter mem_peak_diff>256 (of 172)  |       0 |             5 |          7=
 |        |
|------------------------------------+---------+---------------+-----------=
-+--------|
| selftests                          |         |               |           =
 |        |
|------------------------------------+---------+---------------+-----------=
-+--------|
| running time (sec)                 |     108 |           140 |         90=
 |     86 |
| jitter mem_peak_diff!=3D0  (of 3601) |     195 |          1751 |       11=
81 |        |
| jitter mem_peak_diff>256 (of 3601) |       1 |            22 |         14=
 |        |

- "jitter mem_peak_diff!=3D0" means that veristat was run two times and
  results were compared to produce a number of differences:
  `veristat -C -f "mem_peak_diff!=3D0" first-run.csv second-run.csv| wc -l`
- "jitter mem_peak_diff>256" is the same, but the filter expression
  was "mem_peak_diff>256", meaning difference is greater than 256KiB.

The big jitter comes from `0->256KiB` and `256KiB->0` transitions
occurring to very small programs. There are a lot of such programs in
selftests.

Comparison of results quality between many cg and other types (same
metrics as above, but different veristat versions were used to produce
CSVs for comparison):

|                                    |          many cg |       many cg |
|                                    | vs reset+reclaim | vs reset-only |
|------------------------------------+------------------+---------------|
| SCX                                |                  |               |
|------------------------------------+------------------+---------------|
| jitter mem_peak_diff!=3D0  (of 172)  |              108 |            70 |
| jitter mem_peak_diff>256 (of 172)  |                6 |             2 |
|------------------------------------+------------------+---------------|
| sleftests                          |                  |               |
|------------------------------------+------------------+---------------|
| jitter mem_peak_diff!=3D0  (of 3601) |             1885 |           942 |
| jitter mem_peak_diff>256 (of 3601) |               27 |            11 |


As can be seen, most of the difference in collected stats is not
bigger than 256KiB.

---

Given above I'm inclined to stick with "many cg" approach, as it has
less jitter and is reasonably performant. I need to wrap-up parallel
veristat version anyway (and many cg should be easier to manage for
parallel run).

---

[1] https://github.com/eddyz87/bpf/tree/veristat-memory-accounting.one-cg

P.S.

The only difference between [1] and my initial experiments is that I
used dprintf instead of pwrite to access memory.{peak,reclaim},
=C2=AF\_(=E3=83=84)_/=C2=AF.



