Return-Path: <bpf+bounces-77043-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 280B6CCDAA8
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 22:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 37144302C5CD
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 21:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B6832E697;
	Thu, 18 Dec 2025 21:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PIHdo7wx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00262E54DE
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 21:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766092866; cv=none; b=RuBD++Vnl/nkaB2MjwTteOhYpcGVL3TGEkYNsde3x/JcVwLHG/N7tHdXp/Sh7GQ0g/NXAvsftUeoNJ8EFiUCjhBMpURJwPjRj6Sul7i3ntHEc6UCStyyCaISYO2QetVkCamWcL+d9J4+OgbjX5KwhHgTvg+Of0ueYfIwRojgiv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766092866; c=relaxed/simple;
	bh=cqUjv37bQrHWjLeiJzydyeedJGJwjMmSj74naJ3C0pE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PTaEMXPZC9rG7itxl+Hn8wRA25Os6YIqDaGyXD+I8siOuW9+Xmjk7vz0hkmpefWyyTE3kuxAhaOP8wQ+/+uKSUFrcVTyq/3Ew4Y0fPp5P4rnQsuwJwDL+dInBX9ab7TNUL+D+chCqGI3W+Qb5JItBwV4wk5APuOczSH2QubZ4fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PIHdo7wx; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-3e12fd71984so823512fac.2
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 13:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766092863; x=1766697663; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c9tipiql2onxACO3kjd/0S/XiUV13p9feMh/zj3zK8U=;
        b=PIHdo7wxQ5KTyIaNvlTv/MIue42E8kFiX3o7eolqvaKRiMqnQvUJEvISy2jCJzyTFi
         CDTSvV50IUIECHO0maGBTOYAXbN/d4DaoAGhJ61TDAGYmqSyurSBMAXD/Gx/MJFBAVyp
         OzXF3Ta1ni6pAUiE9DLDMPKKJZb/Vr0IOZVCV2UvjMDT8vymowc27aNrUqSeAMiWsNbO
         x5V+ehRU/mfGNgx96RLAiRAgpwZ7rvw0sWk1sQMMEyi9cs6eol+SDxXB/mWmwHmXYIZk
         N/c6L6WZ8HQTaQQ34bXc4CvLWkJofB0dwQFP+wCDCivFZ7v4lgeJvlKZEA6TcHwxqb4p
         sr0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766092863; x=1766697663;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c9tipiql2onxACO3kjd/0S/XiUV13p9feMh/zj3zK8U=;
        b=TGSyXqFdzPY2iitZluQJgo5RdURKcMiGR2/VJ+w8S8SuvAGYQ3SF+3/ob43vP5N1CP
         NyJh+02G7g8XZsJ8uqS1HPzu7qog5iIDft/9Tr4C5mM9B26KHRsjExUbgo4J4i0jRVUa
         EI7wv7deAYlybyuN5COH0+3ndpRQVqzueJGdECwJ/AAl3HxUhG65OmW4yzNe7RI8z4Gv
         ikiaf0ku3XFrRIFdyf9eF3IIEw45O8E59FjGJSfVnk12iyzWK58Yr6npyBWaeQ34Dxn3
         g1LBT0iF0EXhvT6ptjyL/QIx7ARf8NmksKgWW0fY5XqVk/vgVriGX7nKOumMpBfvFHmk
         d91g==
X-Gm-Message-State: AOJu0Yzo/WfMRBXB++g3eXdNffawPPFJtWoxYcYLDMxEguxugpJeLxzW
	xKc23B7b9OR/xoK9uEHsF+utEFAUACGm066Bi/7gtjFVZWRnPc0smvx1
X-Gm-Gg: AY/fxX7xpFLavZaGxo9S0favyK2xPNrbIymcssAHH48H3iPI+W6LBY5f9geDKdTCzJG
	EbrUUlV/d5vDnPUUXUrkAeXm8BhaVuRbR5oITq9142dUUy7i868zrVaGb+vdySB5liz4/C13RsA
	oK0ao5iqckQYccccgR5wGdfbqJEqX66nZfO9k+n7yrfuErF4/VwbuFpZtBKmaciGks5T8nS1uvO
	d24tAc3x1pB6nqkuLvkgNoUXZ7OPjTqRv8egRcXL2kej1oMXThmE0lEp2ISARsgzuU1PcaM4Yhn
	gZAgzUFoM3/lJMla7p1x2EtSyBKsWGP4hRvcPu4VynmqkP/CpMJrafNBD5HzY3Z+rcLew/By04t
	SPamzp9rG9iwb0uTlF8nTjej3AE57W5RiBV4nFG5RYgLsnMtfm0MiWMmgjOq0VBYpmyNcQkIlYT
	Sk11DHk2FP09CNUWRL2tK/4uJE27N9PJud1MTE
X-Google-Smtp-Source: AGHT+IFmxk3YATonxLCiLcbn2iIMS7nFOUUgNJH1YIJWm9l0xXgphXvwi2zor2XCGLSbRXvcDbeAAQ==
X-Received: by 2002:a17:903:1249:b0:2a1:3cd9:a734 with SMTP id d9443c01a7336-2a2f2a4f99emr2804215ad.43.1766085667750;
        Thu, 18 Dec 2025 11:21:07 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:d912:2088:c593:6daa? ([2620:10d:c090:500::7:e642])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c9b52asm566865ad.45.2025.12.18.11.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 11:21:07 -0800 (PST)
Message-ID: <8be2cafa00b759220e73a6ce837ac9a3ff52da1f.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 5/8] kbuild: Sync kconfig when
 PAHOLE_VERSION changes
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alan Maguire	
 <alan.maguire@oracle.com>, Alexei Starovoitov <ast@kernel.org>, Andrea
 Righi	 <arighi@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
 Andrii Nakryiko	 <andrii@kernel.org>, Bill Wendling <morbo@google.com>,
 Changwoo Min	 <changwoo@igalia.com>, Daniel Borkmann
 <daniel@iogearbox.net>, David Vernet	 <void@manifault.com>, Donglin Peng
 <dolinux.peng@gmail.com>, Hao Luo	 <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, John Fastabend	 <john.fastabend@gmail.com>, Jonathan
 Corbet <corbet@lwn.net>, Justin Stitt	 <justinstitt@google.com>, KP Singh
 <kpsingh@kernel.org>, Martin KaFai Lau	 <martin.lau@linux.dev>, Nathan
 Chancellor <nathan@kernel.org>, Nick Desaulniers	
 <nick.desaulniers+lkml@gmail.com>, Nicolas Schier <nsc@kernel.org>, Shuah
 Khan	 <shuah@kernel.org>, Song Liu <song@kernel.org>, Stanislav Fomichev	
 <sdf@fomichev.me>, Tejun Heo <tj@kernel.org>, Yonghong Song	
 <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, dwarves@vger.kernel.org,
 linux-kbuild@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 sched-ext@lists.linux.dev
Date: Thu, 18 Dec 2025 11:21:04 -0800
In-Reply-To: <20251218003314.260269-6-ihor.solodrai@linux.dev>
References: <20251218003314.260269-1-ihor.solodrai@linux.dev>
	 <20251218003314.260269-6-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-12-17 at 16:33 -0800, Ihor Solodrai wrote:
> This patch implements kconfig re-sync when the pahole version changes
> between builds, similar to how it happens for compiler version change
> via CC_VERSION_TEXT.
>=20
> Define PAHOLE_VERSION in the top-level Makefile and export it for
> config builds. Set CONFIG_PAHOLE_VERSION default to the exported
> variable.
>=20
> Kconfig records the PAHOLE_VERSION value in
> include/config/auto.conf.cmd [1].
>=20
> The Makefile includes auto.conf.cmd, so if PAHOLE_VERSION changes
> between builds, make detects a dependency change and triggers
> syncconfig to update the kconfig [2].
>=20
> For external module builds, add a warning message in the prepare
> target, similar to the existing compiler version mismatch warning.
>=20
> Note that if pahole is not installed or available, PAHOLE_VERSION is
> set to 0 by pahole-version.sh, so the (un)installation of pahole is
> treated as a version change.
>=20
> See previous discussions for context [3].
>=20
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/scripts/kconfig/preprocess.c?h=3Dv6.18#n91
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/Makefile?h=3Dv6.18#n815
> [3] https://lore.kernel.org/bpf/8f946abf-dd88-4fac-8bb4-84fcd8d81cf0@orac=
le.com/
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

When building BPF selftest modules the pahole version change was
detected, but it seems that BTF rebuild was not triggered:

  $ (cd ./tools/testing/selftests/bpf/test_kmods/; make -j)
  make[1]: Entering directory '/home/ezingerman/bpf-next'
  make[2]: Entering directory '/home/ezingerman/bpf-next/tools/testing/self=
tests/bpf/test_kmods'
    CC [M]  bpf_testmod.o
    CC [M]  bpf_test_no_cfi.o
    CC [M]  bpf_test_modorder_x.o
    CC [M]  bpf_test_modorder_y.o
    CC [M]  bpf_test_rqspinlock.o
    MODPOST Module.symvers
    CC [M]  bpf_testmod.mod.o
    CC [M]  .module-common.o
    CC [M]  bpf_test_no_cfi.mod.o
    CC [M]  bpf_test_modorder_x.mod.o
    CC [M]  bpf_test_modorder_y.mod.o
    CC [M]  bpf_test_rqspinlock.mod.o
    LD [M]  bpf_test_modorder_x.ko
    LD [M]  bpf_testmod.ko
    LD [M]  bpf_test_modorder_y.ko
    LD [M]  bpf_test_no_cfi.ko
    BTF [M] bpf_test_modorder_x.ko
    LD [M]  bpf_test_rqspinlock.ko
    BTF     bpf_test_modorder_x.ko
    BTF [M] bpf_test_no_cfi.ko
    BTF [M] bpf_test_modorder_y.ko
    BTF [M] bpf_testmod.ko
    BTF     bpf_test_no_cfi.ko
    BTF     bpf_test_modorder_y.ko
    BTF [M] bpf_test_rqspinlock.ko
    BTF     bpf_testmod.ko
    BTF     bpf_test_rqspinlock.ko
    BTFIDS  bpf_test_modorder_x.ko
    BTFIDS  bpf_test_modorder_y.ko
    BTFIDS  bpf_test_no_cfi.ko
    BTFIDS  bpf_testmod.ko
    OBJCOPY bpf_test_modorder_x.ko.BTF
    BTFIDS  bpf_test_rqspinlock.ko
    OBJCOPY bpf_test_no_cfi.ko.BTF
    OBJCOPY bpf_test_modorder_y.ko.BTF
    OBJCOPY bpf_testmod.ko.BTF
    OBJCOPY bpf_test_rqspinlock.ko.BTF
  make[2]: Leaving directory '/home/ezingerman/bpf-next/tools/testing/selft=
ests/bpf/test_kmods'
  make[1]: Leaving directory '/home/ezingerman/bpf-next'
  [~/bpf-next]
  $ (cd ./tools/testing/selftests/bpf/test_kmods/; make -j)
  make[1]: Entering directory '/home/ezingerman/bpf-next'
  make[2]: Entering directory '/home/ezingerman/bpf-next/tools/testing/self=
tests/bpf/test_kmods'
  make[2]: Leaving directory '/home/ezingerman/bpf-next/tools/testing/selft=
ests/bpf/test_kmods'
  make[1]: Leaving directory '/home/ezingerman/bpf-next'

... update pahole from version 131 to 132 ...

  [~/bpf-next]
  $ (cd ./tools/testing/selftests/bpf/test_kmods/; make -j)
  make[1]: Entering directory '/home/ezingerman/bpf-next'
  make[2]: Entering directory '/home/ezingerman/bpf-next/tools/testing/self=
tests/bpf/test_kmods'
  warning: pahole version differs from the one used to build the kernel
    The kernel was built with: 131
    You are using:             132
  make[2]: Leaving directory '/home/ezingerman/bpf-next/tools/testing/selft=
ests/bpf/test_kmods'
  make[1]: Leaving directory '/home/ezingerman/bpf-next'

Is this an expected behavior?

