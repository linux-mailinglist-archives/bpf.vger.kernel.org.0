Return-Path: <bpf+bounces-77041-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 235ECCCDA58
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 22:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 87AB230181DF
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 21:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B5E329C4A;
	Thu, 18 Dec 2025 21:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fT2kXbTk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0A12EC0B5
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 21:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766092302; cv=none; b=IRb6xJajlQzxZh812+V3WEsChzHqrTcSFHKD58FIXN0nRm3m21oAXczXL2cy8/Kab7JE0Qd/du4Rx6lWNQlE9kQbxf2I6me2OxuTKCyubZZtWeHtfCJeIq4M4YDonuDS0lz64iLmNwTKeTAHrnc+ak5FxSwgL0ZJ8QC895OfWx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766092302; c=relaxed/simple;
	bh=Wk9qv34inWutk0debgHw5c52MI0wE6RiXjFrTeu/W50=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i59f/TUxU9GuPrQV0AiYBVTy+hA/+89IWN9nnwhl4uQ+TTN/v2GonUjbXM6/mm/T9BLNkCs2B68/HxtTzqm+gbyKhkluIdJnQL4ELV2jzrm+T1YVuF9BSP4sFYAf7LVVzy7khnZ8ZCKAZRBH3Z0kCEaKqJUWn2mLPKpR32u40Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fT2kXbTk; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-34c21417781so1151808a91.3
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 13:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766092299; x=1766697099; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Wk9qv34inWutk0debgHw5c52MI0wE6RiXjFrTeu/W50=;
        b=fT2kXbTk2dMWCp5Ef29JRcCqU0ibvRA9d3eZb4NCRiRI7HjvavQwTs0JQymMXEGD5t
         eHhE7Lmvf8Q/ZAXtRNbLZ+hWYpJsOqbSRrPRFmTnsLkGp+mCOqGqGKrWcYiXi2xUJv+E
         OYbL2izjwKWGpi+kTifHuWl3kFzxDsLGn6OZ4z/ma45L24G3OWlTEhISrY5+EouGU4ag
         tL77QD/p7Oh818VrdkDDa5DfI1EKX4JDGcacpklAVjQrpkhAYre39zDyn29DuBEWWxz/
         IUS9kUf/BybKSk8Mm9RfaeA8qvv1vmGw1SMVNnF6hIMcO7TQAG/1qwWewrTYMIR7y+6y
         CFWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766092299; x=1766697099;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wk9qv34inWutk0debgHw5c52MI0wE6RiXjFrTeu/W50=;
        b=AQbnkjjrrDbUfXctrdM8whTt5RHGLMRW3zamSwiOADSl/q8nvueqqjec+Z8VYz1bLL
         Cx+bBJb0VREu+RZGSotRNgQsHvveehr7kW6dau20lfxpSD2TxG2JpAJPUUdRJlSeKAIw
         qf1wzLmwfG+F5Wd2Rlc0+8s6phcbEJ8hiKUwMiCJiqffibJ3RpAHk7mzcf+bezNRlhkb
         xWHbdiP/wD4Dg1wFqVN18RyodpLod6LCO2jZqSF9KvbNKBDymzzSTEn3R6sKV1aDxKK1
         CSWnCsPFrI6J70s16ktD/CaDxDBEELG63R0yZ3S8YHalM0igKDCZpSTlPfYSo9sl7JJW
         Z8jA==
X-Gm-Message-State: AOJu0YzPEucBgAoKJujnFq/FU4Fo9C7koieRH1kE18BHAwdbu7i3FoNx
	CzvNGH5pGMtcG1h8HPXuJutXkpC5jhwwGTncVwi9xYolmu/Q3GCBIzWj
X-Gm-Gg: AY/fxX496wenKygU1giG+G4sWCKuvNa2XOOiaLrgHNIZcqQ0Meydn2QVPEOwF0TT9IF
	W2HlLctSOvjFEhsLuvFrSJ4E1qOChZV6ccL6pgLptR/L8k1cC+Hv2o0oCDQbTzLVWpGw3tnIHRi
	2yaPx7Dyy/cbKnyXxjtiamo7pg+f8vLtY8lxZnUdQa8Zd5hbN4uE/6KAaNRTAWVLOx2ZBIhoKKg
	VkIHQ/4jx6cS7kwYM1PleNeAHm4HpSi1+CE3h6vKiaJXed3QLYIdSWqHlCuZo6ZfH0jnyiBTgbZ
	lZ4yz2MFxuKiGxF0Io4GhjPz2VBn7h86mCyWfQ3EIXTSEm120bRtupiItzfi5U7NidQokk22bE6
	gXt/7PgyEtcc7GwtvobKdZRpkiq/swC3ycdGxFHyG6RtmvOtRltD7OOWD+eT4JV+q4577Haa+1T
	s++n1JFXhrzOlwkE4fuZMGzZq4A8zGhUg2kA86
X-Google-Smtp-Source: AGHT+IE5wqF1Ur/4n0bAKqhUgwQpIAW7BXffJ7Vx2YXELxiT7ohVhw05y1v6Iu0zG3ReeHlWkO5oUA==
X-Received: by 2002:a05:6a00:4006:b0:7e8:4398:b362 with SMTP id d2e1a72fcca58-7ff6667949dmr378405b3a.53.1766085763362;
        Thu, 18 Dec 2025 11:22:43 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:d912:2088:c593:6daa? ([2620:10d:c090:500::7:e642])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7b127b00sm99807b3a.21.2025.12.18.11.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 11:22:43 -0800 (PST)
Message-ID: <0be0a3b4d39e31653ce38c16b413d717921f2ced.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 7/8] selftests/bpf: Run resolve_btfids only
 for relevant .test.o objects
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
Date: Thu, 18 Dec 2025 11:22:40 -0800
In-Reply-To: <20251218003314.260269-8-ihor.solodrai@linux.dev>
References: <20251218003314.260269-1-ihor.solodrai@linux.dev>
	 <20251218003314.260269-8-ihor.solodrai@linux.dev>
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
> A selftest targeting resolve_btfids functionality relies on a resolved
> .BTF_ids section to be available in the TRUNNER_BINARY. The underlying
> BTF data is taken from a special BPF program (btf_data.c), and so
> resolve_btfids is executed as a part of a TRUNNER_BINARY build recipe
> on the final binary.
>=20
> Subsequent patches in this series allow resolve_btfids to modify BTF
> before resolving the symbols, which means that the test needs access
> to that modified BTF [1]. Currently the test simply reads in
> btf_data.bpf.o on the assumption that BTF hasn't changed.
>=20
> Implement resolve_btfids call only for particular test objects (just
> resolve_btfids.test.o for now). The test objects are linked into the
> TRUNNER_BINARY, and so .BTF_ids section will be available there.
>=20
> This will make it trivial for the resolve_btfids test to access BTF
> modified by resolve_btfids.
>=20
> [1] https://lore.kernel.org/bpf/CAErzpmvsgSDe-QcWH8SFFErL6y3p3zrqNri5-UHJ=
9iK2ChyiBw@mail.gmail.com/
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

