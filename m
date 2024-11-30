Return-Path: <bpf+bounces-45899-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA28A9DEDC5
	for <lists+bpf@lfdr.de>; Sat, 30 Nov 2024 01:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CB32163702
	for <lists+bpf@lfdr.de>; Sat, 30 Nov 2024 00:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222F3C8DF;
	Sat, 30 Nov 2024 00:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+8KGkQd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3470B849C;
	Sat, 30 Nov 2024 00:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732925869; cv=none; b=kXQT3/utPvHF8LHOQP+qzLVl0CqR1rmyd1IyCEceEwRayHWLwkjfQ0Id2nzPJc8oqEeNQsOqTN6cJ6rf+eMXa1A6XzvElT9u/7IBk/FC7VleZGmzDeCJAMfqIWW85aBhd6EvHkw35Ch0bilsoZ1Srmq7DxY8zqnz6hkV/pe8tmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732925869; c=relaxed/simple;
	bh=XvILSMoX9L/CJISt2uT30YecYQnMiSlDojV8+2QY7as=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XiHRurSyWc4FTgUWkAJsc7hZVXezCONo2619AWj//R79DaR1BzbQ4dQX1P8Lm1z6iW+EsitgTVBCO1HNVEPNTOjcDitNuAbwklhwyCbIZB2ALKDLyw+lTC4FnzudnpD3Vih4liCmz0Dcl7vKBO2oprjOK0m6Vi09LDPLQLjDiQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+8KGkQd; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-723f37dd76cso2092037b3a.0;
        Fri, 29 Nov 2024 16:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732925867; x=1733530667; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Hn3XKu0MWS7iflwBtx3ENVfzSkmQK9xwaff2FPKlJgw=;
        b=H+8KGkQdTBzkrMA4eWwJWi9mIS4SPGqljtSSNRK7iHPtDp4WFsuY+1usQNKnBstJ/c
         ctLDoG4V52/KGlAawCDNW2eaxc88AmLa7PWrcc17C72gKRwjqNmlw2c7FDebNrPIsHcf
         nJDXpFdoZwQRaOBi9oxDUXVN/StJhAwHWZPJmmwO3Tm+gUL38yZnHeeeVJM1H10Cms/l
         6NxZ9VjeHQtD2Mxdng8SSNobtZpVcheDHaZYwJ21CzB6+lUflKlXx1yXFaTr4lszvmjM
         gJ6Vzrip1F2CYktu3a4ZAlwY9HaQ1JhjfYU+E5/jk4o70em/Pd2PBSpb5YBUScGyklTq
         q/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732925867; x=1733530667;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hn3XKu0MWS7iflwBtx3ENVfzSkmQK9xwaff2FPKlJgw=;
        b=mkkfQQYDjJIo5NYaGDtSOWUaePrgZUTxdDcsThC8g4bLvgaU0jalU4hSHnFVDZfPFs
         vELhGeQGcozPskz/exXni7JcHvTX/D4UWj28lBxfA4u0Gnh5kk+hl4Z5m2pNAioqqoxz
         b2nK9PIhBJ4Nio/EvuW3t94lVo+D49tHyyQDrsipm+rNzjxohvzKvvOdvNl+6dp9sF1w
         kOb7Nun0cc6Cs1XNYODkqL6KV06nOAlh3dggS4RBs+IUl3JOIi4jGT33rPPjtTD3NfwR
         qFN2jhrvqKJXsUsjJtw6/sbQ38dc5asJgnSGSLN3vTeV21Y1SxRbyDx/fUlNyl5d4Udl
         DyHw==
X-Forwarded-Encrypted: i=1; AJvYcCWnKWOrRHvc9TcZMrOdGVtVF960xenwAieoTmtX+RGDY+e9EqPa3ctIxZ0hrJN2uhcbp2OAZWr/@vger.kernel.org
X-Gm-Message-State: AOJu0YyxeKc1oEZMCFT1NC/ZY2JIGEph4FIuqbAlWIqbQC9X2tDWsGUV
	dO07AG0BO0Lgz1srggrvDQQG6tGm31QL6QMFBapbfXd58UXOpGOH
X-Gm-Gg: ASbGnctCXdkh5QzmyeOjSTOm0Tp/IezAq36WJVKbNB0xF2gICZpXOXg20PS53pMIAAl
	bx5FDHDWr0+oXOWALSSHDN310bA0A1qeurgOCe/TTjB7pvOgvnHVIXrEHt3+qIkMyxRBCOfwyMW
	QhELVJhw1JfYwDa0tQYyQWlXDBJWJQX0E8pFiO44Du2OFf1RHmUAXvyCCbdTp54igXoYD7uck0P
	oC30982kuA0ALXp4pwjMEL4v3BHE1P1mI8ahjhDjr5CAEE=
X-Google-Smtp-Source: AGHT+IHen5UGh6KPvlw6ijsYglIQTEwxChl2HaMiyKdLXvFHlVpEuSgF0Z/NOzNWiSUsG4/EZQrOFg==
X-Received: by 2002:aa7:88c3:0:b0:71e:db72:3c87 with SMTP id d2e1a72fcca58-72530103f57mr20929773b3a.20.1732925867343;
        Fri, 29 Nov 2024 16:17:47 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72541764196sm4077567b3a.2.2024.11.29.16.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 16:17:46 -0800 (PST)
Message-ID: <450a352e713902e4fa091163d283b91786fb8605.camel@gmail.com>
Subject: Re: [RFC PATCH 9/9] pahole: faster reproducible BTF encoding
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@pm.me>, dwarves@vger.kernel.org, 
	acme@kernel.org
Cc: bpf@vger.kernel.org, alan.maguire@oracle.com, andrii@kernel.org, 
	mykolal@fb.com
Date: Fri, 29 Nov 2024 16:17:41 -0800
In-Reply-To: <20241128012341.4081072-10-ihor.solodrai@pm.me>
References: <20241128012341.4081072-1-ihor.solodrai@pm.me>
	 <20241128012341.4081072-10-ihor.solodrai@pm.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-11-28 at 01:24 +0000, Ihor Solodrai wrote:
> Change multithreaded implementation of BTF encoding:
>=20
>   * Use a single btf_encoder accumulating BTF for all compilation units
>   * Make BTF encoding routine exclusive: only one thread at a time may
>     execute btf_encoder__encode_cu
>   * Introduce CU ids: an id is an index of a CU, in order they are
>     created in dwarf_loader.c
>   * Introduce CU__PROCESSED cu_state to inidicate what CUs have been
>     processed by the encoder
>   * Enforce encoding order of compilation units (struct cu) loaded
>     from DWARF by utilizing global struct cus as a queue
>   * reproducible_build option is now moot: BTF encoding is always
>     reproducible with this change
>   * Most of the code that merged the results of multiple BTF encoders
>     into one BTF after CU processing is removed
>=20
> Motivation behind this change and analysis that led to it are in the
> cover letter to the patch series.
>=20
> In short, this implementation of BTF encoding makes it reproducible
> without sacrificing the performance gains from parallel
> processing. The speed in terms of wall-clock time is comparable to
> non-reproducible runs on pahole/next [1]. The memory footprint is
> lower with increased number of threads.
>=20
> pahole/next (12ca112):
>=20
>             Performance counter stats for '/home/theihor/dev/dwarves/buil=
d/pahole -J -j24 --btf_features=3Dencode_force,var,float,enum64,decl_tag,ty=
pe_tag,optimized_func,consistent_func,decl_tag_kfuncs --btf_encode_detached=
=3D/dev/null --lang_exclude=3Drust /home/theihor/git/kernel.org/bpf-next/kb=
uild-output/.tmp_vmlinux1' (13 runs):
>=20
>     50,493,244,369      cycles                                           =
                       ( +-  0.26% )
>=20
>             1.6863 +- 0.0150 seconds time elapsed  ( +-  0.89% )
>=20
> jobs 1, mem 546556 Kb, time 4.53 sec
> jobs 2, mem 599776 Kb, time 2.81 sec
> jobs 4, mem 661756 Kb, time 2.05 sec
> jobs 8, mem 764584 Kb, time 1.58 sec
> jobs 16, mem 844856 Kb, time 1.59 sec
> jobs 32, mem 1047880 Kb, time 1.69 sec
>=20
> This patchset on top of pahole/next:
>=20
>  Performance counter stats for '/home/theihor/dev/dwarves/build/pahole -J=
 -j24 --btf_features=3Dencode_force,var,float,enum64,decl_tag,type_tag,opti=
mized_func,consistent_func,decl_tag_kfuncs --btf_encode_detached=3D/dev/nul=
l --lang_exclude=3Drust /home/theihor/git/kernel.org/bpf-next/kbuild-output=
/.tmp_vmlinux1' (13 runs):
>=20
>     31,175,635,417      cycles                                           =
                       ( +-  0.22% )
>=20
>            1.58644 +- 0.00501 seconds time elapsed  ( +-  0.32% )
>=20
> jobs 1, mem 544780 Kb, time 4.47 sec
> jobs 2, mem 553944 Kb, time 4.68 sec
> jobs 4, mem 563352 Kb, time 2.36 sec
> jobs 8, mem 585508 Kb, time 1.73 sec
> jobs 16, mem 635212 Kb, time 1.61 sec
> jobs 32, mem 772752 Kb, time 1.59 sec
>=20
> [1]: https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?h=3Dn=
ext&id=3D12ca11281912c272f931e836b9160ee827250716
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
> ---

I think this is a solid idea and a good observation,
but implementation inherits unnecessary complexity from the previous design=
.
There is no real need to keep single-threaded and multi-threaded modes
separate, instead:
- main thread can serve as a dedicated "collector" thread,
  waiting sequentially for CUs with ids ranging from 0 to number of cus;
- configurable number of worker threads can parse DWARF concurrently
  and put CU objects to the processing queue;
- the queue size has to be bounded to keep memory consumption within
  certain limits (but be careful, a simple bounded queue protected by
  semaphore won't do, as the queue might get fully filled with ids
  different from expected, in case when first CU takes a very long time
  to process and N CUs after it take very short time to process).

[...]


