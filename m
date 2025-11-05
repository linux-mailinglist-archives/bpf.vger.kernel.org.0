Return-Path: <bpf+bounces-73731-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5E5C37C91
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 21:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 27D584E53FC
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 20:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3EE2D640A;
	Wed,  5 Nov 2025 20:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDZy/Srm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F6C126C02
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 20:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762375912; cv=none; b=GoUX5z7cIQHAdTR8rNHswryRkAaUFBAP0zXDEZGAj6cpxhffd2ohYpp7b4CUKPVT2qZwoPlNwe5+n7esULFB2ygVj5be15CtYaaUodw9qRZ9DO/Il/hOfxR3kw6VY7UR+ny6z/I3meGR40X0B22xBI6qeQgODnyqApo47BSd1KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762375912; c=relaxed/simple;
	bh=enTVJjFvdsr/k7gPB2SrWdjKrIArilg9LPPzcSY9NnE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P2OvlVrvgbRcQSf+Ty3fi6+8VRrxySnene0QLVS5LIoRD2qSwHYbaDKPvzg+fNWtEXPInAfP5veTL/Fk4jemrN9PuXKXpKy4H0NmggM2BlC9zPO2tBfGsL9wqFQdMO4LtuAm1SDSV4+DnnQ+mg4IErmwqiLCx4za3BCfCXdgkgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hDZy/Srm; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-29516a36affso2509605ad.3
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 12:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762375910; x=1762980710; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i6wbZfvnN1y0YdoaRz7RbvnA5Pf9Inb0gh2m/oL7gsE=;
        b=hDZy/Srm+QjGZECPvfsuWeagAHlAx9DkBZLKv2BynlyZtzbgG4sZHEKjKrkKbriLPd
         RZyRTu9j8pkQazYSuLeVcoXjlIFAGinYQfNGnZSdPgwWpFTNPG1VE4H3d1evMoyW241/
         W4Z1Z8CXEGxj3ZGRCIOx6JpbHojN0x5Itf/qMtbe8KAz1m4xpcWZH6dmzPttkDqrvfvW
         TBTFRZohzZN2l5m+ob3+x6WpV6Gvjd7iOG0vMJkhVDrlRaM0D7/nnhDqM4aAd7GRvnCo
         bEMCB7JL9tDPgMP0tZpsyUBz2ArcL0EGSs6aLIfktKViGIXAkqzKpc5RVxqukssxoziY
         wUvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762375910; x=1762980710;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i6wbZfvnN1y0YdoaRz7RbvnA5Pf9Inb0gh2m/oL7gsE=;
        b=oGyW6zTm+I1P3isqOYs0dshwi3y4k4liovzxxH7Hzhg2VexxrQP5tGbADj5ucxJ+Y8
         /MPAkS0XRpNabxjDyy/daCoxcxkQrap4R+yAsliu9Z1UHexxCldF7BFxMnIBS8/8Dayk
         /jYDXTquHEwCCTdlbeI56pxIWDjxdIzlJEkXLefGqJDXWEiCz/eX9Kbdow9vOiPGQx0V
         IdZZq63XZdz6fTa4c3q66KkQtkk/ego0cInmDacwmtV9Hw0+hXirnvY2LsflyIhEwtw3
         shs7ET0zG0fgx/lWr7uyrrEfCLtvWGgy56CfZBgSBdEfxZPAEqTUinSVzzAORJfcVX6V
         uMZg==
X-Forwarded-Encrypted: i=1; AJvYcCXTf6PgRgfzyKMGeUW3G+ySt1OULrMClCVunO1aB/ybFHQE/tn/MYdiCxIENsCqom2XD2A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf9JxIwZke2sw/GhV/DxbOCOSJHpNfsLVGjvGSu9cntenN1RoE
	h97AJxnrwQ1ZSsp3F6SiqRmWQC5dx8RZyiqk2HRgzjjXj9OMehmZ2ldh
X-Gm-Gg: ASbGnctHRGSv9+rJ80kIArYLYw31tuq7yHGJxjfIFzv9GBSHfOLuz69dQJ02WsV5M+N
	sZdNR2RjqXVVUyWK7oR+6ASVJma/6kMhVmNAsHfVCi1o71399Fk50Y/qYtSPF3Xi9mJYYFD9vtF
	hP58IigHN1vJbTKLJr/zdIAhUUf+rcjXqsBbYqXzc/jv2SLXYtAOetxquVad+pb/e3oQB6NMuot
	1SCLP6vkGbcKhsQvpO5/lgwzlOa/bVF34/zGSv0R2CPOxyeg3tsBpJ9oM1RXCwUExr4otXOREGo
	gdJcSqCk865MMUDvOVVr4HIexomz5YqZWQAStzPCzJ3BmncSp3NR/c4EJStkMAOhbqpM0+bE65F
	zzqpJugaW2jEp/ifM/zLKSFMjd9uivcAYH1RE96BIu0jzkKGw/+vjRmT6cjzxOVq3xNfeV+NRKP
	6U33HPPrMdHXQsgMUu6T3tuYub
X-Google-Smtp-Source: AGHT+IFneyHjbL3eTm6NZ0WLmjGkIAvpVCGCp/Cu75gh6q5jA/suHpV8CyZMmxilZQEkWBtiPEfZKw==
X-Received: by 2002:a17:903:1b6d:b0:295:4936:d1e9 with SMTP id d9443c01a7336-2962ada6b5bmr63835245ad.36.1762375910046;
        Wed, 05 Nov 2025 12:51:50 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:cdf2:29c1:f331:3e1? ([2620:10d:c090:500::6:8aee])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c5e5cbsm4636795ad.42.2025.11.05.12.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 12:51:49 -0800 (PST)
Message-ID: <7463cbcabcd06016d7dfbd858f4e089c4acd88f1.camel@gmail.com>
Subject: Re: [PATCH v11 bpf-next 00/12] BPF indirect jumps
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>, bpf@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Anton
 Protopopov <aspsk@isovalent.com>,  Daniel Borkmann <daniel@iogearbox.net>,
 Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Date: Wed, 05 Nov 2025 12:51:48 -0800
In-Reply-To: <20251105090410.1250500-1-a.s.protopopov@gmail.com>
References: <20251105090410.1250500-1-a.s.protopopov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-11-05 at 09:03 +0000, Anton Protopopov wrote:
> This patchset implements a new type of map, instruction set, and uses
> it to build support for indirect branches in BPF (on x86). (The same
> map will be later used to provide support for indirect calls and static
> keys.) See [1], [2] for more context.
>=20
> Short table of contents:
>=20
>   * Patches 1-6 implement the new map of type
>     BPF_MAP_TYPE_INSN_SET and corresponding selftests. This map can
>     be used to track the "original -> xlated -> jitted mapping" for
>     a given program.
>=20
>   * Patches 7-12 implement the support for indirect jumps on x86 and add =
libbpf
>     support for LLVM-compiled programs containing indirect jumps, and sel=
ftests.
>=20
> The jump table support was merged to LLVM and now can be
> enabled with -mcpu=3Dv4, see [3]. The __BPF_FEATURE_GOTOX
> macros can be used to check if the compiler supports the
> feature or not.
>=20
> See individual patches for more details on the implementation details.

I retested this series with upstream clang [1] (includes latest
changes for relocations handling from Yonghong), and all works as
expected.

The series is ready to land from my perspective.
(AI has a few notes on tests, though).

[1] f60e69315e9e ("[llvm] Emit canonical linkage correct function
symbol (#166487)")

> v10 -> v11 (this series):
>=20
>   * rearranged patches and split libbpf patch such that first 6 patches
>     implementing instruction arrays can be applied independently

I actually tried applying first 6 patches and then removing patch #3
"libbpf: Recognize insn_array map type", nothing broke: kernel and
selftests compile, relevant selftests passing.
So, not sure if splitting patch #3 as a separate thing is really
necessary.

>=20
>   * instruction arrays:
>     * move [fake] aux->used_maps assignment in this patch
>=20
>   * indirect jumps:
>     * call clear_insn_aux_data before bpf_remove_insns (AI)
>=20
>   * libbpf:
>     * remove the relocations check after the new LLVM is released (Eduard=
, Yonghong)
>     * libbpf: fix an index printed in pr_warn (AI)
>=20
>   * selftests:
>     * protect programs triggered by nanosleep from fake runs (Eduard)
>     * patch verifier_gotox to not emit .rel.jumptables
>=20

[...]

