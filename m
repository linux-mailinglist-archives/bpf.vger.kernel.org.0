Return-Path: <bpf+bounces-71652-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFFABF973C
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 02:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7189C35364E
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 00:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A7B350A1E;
	Wed, 22 Oct 2025 00:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jR5eb9L4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630749460
	for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 00:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761092854; cv=none; b=U0ePm5PhMUccs+g9ZJkJ6690JOoKfs5FJHGU7qdoIm93M1pOUiHY6Z7qH5fZzhun83S26oS5W34RnkunnDFOUga/ezFyYm+htKprdjUphFMAvW5YbFFGkXj/AhFRXayE+7l1G74kjyeyYQsXBmrvaKaPEwQqT7fOoubmC5P6L5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761092854; c=relaxed/simple;
	bh=o7Rd1H6p5osNJle+ecy3NaXZR59NVVzp8r0xB6i6fNA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W0gm5uYZu8ea1JeUDj7E4DILurBjhK5wAkFjNoSQGhXLlPByKTdek1vBp+62h9lfdqaqbyXh2bIije6AR7CASBpihnagpom/hXHf/RuOmfIvjBgaVg+iRt9PFBEBZ7D6mFAgsbh+UHwUGEJNGB3REp2AM9yOhqXpBVLnmiDOtLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jR5eb9L4; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-33bb1701ca5so5376223a91.3
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 17:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761092853; x=1761697653; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jZ7Rwhp4E/ImzMlYgdZ4sVlKc+A0fjvq8JoHNprd9Fw=;
        b=jR5eb9L4ozxruYQ1iiSd0LLZYN6GywEzrNvpxp4oWEFz5lygBh83rFjSe/VJr91/nG
         G5gz5ctaLxNU/W9x90hqkAhs/lih4TTMRXpvAsA+vx7j7pDvcpPmMdgxJv78dtoFbQKD
         U+H0tq6cS6eyuQQZ7bvDngnYNz3W+R27y8Ee5NvscP+bjj2ET570cZRrQXC3zcQ1tVBl
         8fmTwz/JalTiYiRaxKCZ2QXcSWEUgXLkdiV0MB5plqPM6PsDnfn+Nsb6ck6K2iHYQeX2
         UifTsnJbzxQskROmVV11cHHmiJd5mH4RuI6Y6hUeNSEXraZlOQfc72Ofle0d9O7/1Yk5
         5giw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761092853; x=1761697653;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jZ7Rwhp4E/ImzMlYgdZ4sVlKc+A0fjvq8JoHNprd9Fw=;
        b=Na+MpZirsh/UwKw1hiuUvvqxqwsIwdzJeTXsBeoTH3MztdQDD4CrpKagvxY/xxIFoo
         uUJR/FFknzIjk9P6aBCI1csr42EtC3mgHbvvgZ/73jRI7MJNLu0cgGr14acRjDETTSBs
         kQVhXYPoTU3K+LfJ3eCYb+ZjtatUrem5Mgark3cvhYlcYArfKrztTBmkXcn9zirxsy6K
         tzaKoNYSOoT3VgZCAwh6ta21WsclLhrh9i3AGceBoQyhTPfieRB2aT3PD6IRgcr4KTeU
         sVWAx7/KR/rfyDmNnXAFMDoaS8xlCkTLEROjWgwVBxgKeOOgIBHn8tWWk+dHIgs3Rmci
         HI9A==
X-Gm-Message-State: AOJu0YzpBRql7rOxTjmcbnULgM5xet03kaGZG8AI2+S7TUrEKSRMXyOd
	kfaDGfo0T2lbAMd5DqLIs/mKdjx5/ZARz1Niqz8VhaD2d0l4AR/cHgTL
X-Gm-Gg: ASbGnctgAYb5GpqGf58F6E/CxGIR5uGyoxq7DiJZSwtEToh3ff9NmwmS03Hc/GgrUyG
	kumlfa53hyqFaS5gqVebDHjGLaeH9wH8VZvBFsq0//kffzEo1JyCQ4Sv649i5EsKd1/3Jq1rqCh
	jprb17MZ6kPmS8ELJV3AS4dwe8K24GZA9DVJAR+6Wwx/Z4pX8mjcANMu6w0zPqkM9efJ1hQRYK7
	UTZFAYwdNOCPnymL8ScY74WiIo2kU08VwpqeJJtOpEKbHyrbfW6VHDl1PcR0udgXfEwMA40zcmq
	G5+hQcT0n9+8oiQlHutokygpwoRHGuq/MaRHqSNyIFyASKMCoQO05P4EfFfItRLWIMCxHXo0Wl5
	+fCFcgj2K+mptM4LXPkknJppc4IcCwKBrhWfHC6WZjKua+zF7nakRjZHzQ+ESqdW2TOFqnns/lG
	iMNPwtak4KlPYFeykwWFZKl1uV
X-Google-Smtp-Source: AGHT+IEptO6TJmiv7IDPZivnt07BoIre3jKzm2t4wd6ZeKtKoQSrL9+RZE2Z3coSoHaHEs16KE7DCA==
X-Received: by 2002:a17:90b:3d87:b0:32b:baaa:21b0 with SMTP id 98e67ed59e1d1-33bcf853679mr25922839a91.6.1761092852636;
        Tue, 21 Oct 2025 17:27:32 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:84fc:875:6946:cc56? ([2620:10d:c090:500::7:6bbb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a7664b30dsm11172220a12.7.2025.10.21.17.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 17:27:32 -0700 (PDT)
Message-ID: <3a9c5da97ad4f2d3ccccf315cb855b4d896f5a7c.camel@gmail.com>
Subject: Re: [PATCH v6 bpf-next 17/17] selftests/bpf: add C-level selftests
 for indirect jumps
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>, Yonghong Song
	 <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko	 <andrii@kernel.org>, Anton Protopopov <aspsk@isovalent.com>,
 Daniel Borkmann	 <daniel@iogearbox.net>, Quentin Monnet <qmo@kernel.org>
Date: Tue, 21 Oct 2025 17:27:30 -0700
In-Reply-To: <20251019202145.3944697-18-a.s.protopopov@gmail.com>
References: <20251019202145.3944697-1-a.s.protopopov@gmail.com>
	 <20251019202145.3944697-18-a.s.protopopov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-10-19 at 20:21 +0000, Anton Protopopov wrote:

[...]

> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c b/tools/t=
esting/selftests/bpf/prog_tests/bpf_gotox.c
> new file mode 100644
> index 000000000000..4394654ac75a
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c
> @@ -0,0 +1,185 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <test_progs.h>
> +
> +#include <linux/if_ether.h>
> +#include <linux/in.h>
> +#include <linux/ip.h>
> +#include <linux/ipv6.h>
> +#include <linux/in6.h>
> +#include <linux/udp.h>
> +#include <linux/tcp.h>
> +
> +#include <sys/syscall.h>
> +#include <bpf/bpf.h>
> +
> +#include "bpf_gotox.skel.h"
> +
> +/* Disable tests for now, as CI runs with LLVM-20 */
> +#if 0

I removed all the `#if 0` and tried to compile this test using LLVM at comm=
it
1a9aba29b09e ("[RISCV] Remove unreachable break statements. NFC (#164481)")=
.

LLVM refuses to compile showing errors like below:

  CLNG-BPF [test_progs-cpuv4] bpf_gotox.bpf.o
fatal error: error in backend: Cannot select: <U+001B>[0;31mt15<U+001B>[0m:=
 ch =3D brind <U+001B>[0;30mt7<U+001B>[0m, <U+001B>[0;30mt14<U+001B>[0m
  <U+001B>[0;30mt14<U+001B>[0m: i64,ch =3D load<(invariant load (s64) from =
%ir.arrayidx)> <U+001B>[0;30mt0<U+001B>[0m, <U+001B>[0;36mt13<U+001B>[0m, u=
ndef:i64, progs/bpf_gotox.c:202:8
    <U+001B>[0;36mt13<U+001B>[0m: i64 =3D add nuw <U+001B>[0;33mt17<U+001B>=
[0m, <U+001B>[0;35mt12<U+001B>[0m, progs/bpf_gotox.c:202:8
      <U+001B>[0;33mt17<U+001B>[0m: i64 =3D LDIMM64 TargetGlobalAddress:i64=
<ptr @__const.big_jump_table.jt> 0, progs/bpf_gotox.c:202:8
      <U+001B>[0;35mt12<U+001B>[0m: i64 =3D shl nuw nsw <U+001B>[0;32mt9<U+=
001B>[0m, Constant:i64<3>, progs/bpf_gotox.c:202:8
        <U+001B>[0;32mt9<U+001B>[0m: i64 =3D and <U+001B>[0;35mt5<U+001B>[0=
m, Constant:i64<255>, progs/bpf_gotox.c:202:18
          <U+001B>[0;35mt5<U+001B>[0m: i64,ch =3D load<(load (s64) from %ir=
.ctx)> <U+001B>[0;30mt0<U+001B>[0m, <U+001B>[0;32mt2<U+001B>[0m, undef:i64,=
 progs/bpf_gotox.c:202:16
            <U+001B>[0;32mt2<U+001B>[0m: i64,ch =3D CopyFromReg <U+001B>[0;=
30mt0<U+001B>[0m, Register:i64 %5
In function: big_jump_table

CC'ing Yonghong.

[...]

