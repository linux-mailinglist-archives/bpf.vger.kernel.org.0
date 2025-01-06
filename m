Return-Path: <bpf+bounces-48030-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F90EA0333A
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 00:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87D1E7A29F8
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 23:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E8C1E22E6;
	Mon,  6 Jan 2025 23:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="aKCr0QyX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-10628.protonmail.ch (mail-10628.protonmail.ch [79.135.106.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6091D90D7
	for <bpf@vger.kernel.org>; Mon,  6 Jan 2025 23:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736205499; cv=none; b=hUmd4z2CoIoiGXULQ4uwQ3EDuRhGMM0pbPItp5lWsRsAz4dXjbm7m3RrylqsE6YBjC3tUWXT8EN1qeUbYwD8WtzOgtJ9FI/4vLyYG91BKU9k7Aqu9AYycJZ3MJQHZLHod/zRJI2hPbJNzDeP/fThZdM1/w7oz8P9p/YT/oV7oc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736205499; c=relaxed/simple;
	bh=Rnd/ArPF8wkiHlGQhA6J9RCcgQE+Wt37ErXOwwJ9kiE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J3K9smm8oVfIZ08moF/I7bRVLwYkZdLNeSG8cte89jk5pozAWuLhw5IxGLdDSC38gQvaIoBxo/RlMJIt8XLOr8EsiZPEbO82Fm4oOWDZqsFOiAWyHdayyipS+QBGlpD37Elq/jzdGssG4lfHVLwVhX8Z92Iwe6enCIknJtHdcoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=aKCr0QyX; arc=none smtp.client-ip=79.135.106.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1736205494; x=1736464694;
	bh=Rnd/ArPF8wkiHlGQhA6J9RCcgQE+Wt37ErXOwwJ9kiE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=aKCr0QyXqhe1QzSdwASj3ZVbKU1dES6JHgI4C5MyAmDJJH1v6zcpOH5jSphrTqXzT
	 j7qIgD10PW8eskuxdZLnblxJM9TRRq/faAdNAMKFfZPESfggijso79WhBb/sGYxR+4
	 5d2yZQajT3ZjA5OTFLXOEeLK4wFPYGPijpn62S8mRwtx3N5JrcbCFdilAuYtXtcxEA
	 UErPR1rySNT+C71pTx2ZCF4OflnJWjHxNUXhPGT3IHsZ69NMCjg0dyPi7EcLcz25gE
	 nMI5wtLBHB/UIrmRH/c4qwo5WgPG52Y9y4r6P214EgTc98Zzhibm3Jdi784lLoF3hR
	 Q0w3fUReL+N6w==
Date: Mon, 06 Jan 2025 23:18:09 +0000
To: Eduard Zingerman <eddyz87@gmail.com>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, mykolal@fb.com, jose.marchesi@oracle.com
Subject: Re: [PATCH bpf-next] selftests/bpf: add -std=gnu17 to GCC BPF build rule
Message-ID: <EzSHGqsyeIGPaYpD8_zHxcl5KM6qQ0EwkmfgQUbU2tw6ZsmbzujDtGiNGIkUwwLchJlM6wKc9m3_Qn4cGL1J67VXzE3-RN9F7hp9Dy4pVpA=@pm.me>
In-Reply-To: <a621a6f62a3e2b30966a5f84be483f0fb6e9061a.camel@gmail.com>
References: <20250106202715.1232864-1-ihor.solodrai@pm.me> <a621a6f62a3e2b30966a5f84be483f0fb6e9061a.camel@gmail.com>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 9a3e03d03b39d3ebac1a4a7ad1359af8adc47f31
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Monday, January 6th, 2025 at 1:16 PM, Eduard Zingerman <eddyz87@gmail.co=
m> wrote:

>=20
> [...]
>=20
>=20
> From previous discussion it looks like it's better to just enable some -s=
td option for both gcc and clang.
> Kernel is compiled with -std=3Dgnu11.

Do you mean that eventually clang is going to make C23 the default too?
Yeah, considering this it's a good idea to specify the standard explicitly.

I am not sure what's the best choice though. If the tests compile currently
with gnu17, maybe we can leave it at that, and not fall back to gnu11?

> I tried adding -std=3Dgnu11 to both host and bpf side flags:
> test_progs, test_verifier, test_maps, veristat compile ok.
>=20
> > define GCC_BPF_BUILD_RULE
> > $(call msg,GCC-BPF,$4,$2)
> > - $(Q)$(BPF_GCC) $3 -DBPF_NO_PRESERVE_ACCESS_INDEX -Wno-attributes -O2 =
-c $1 -o $2
> > + $(Q)$(BPF_GCC) $3 -O2 $(GCC_BPF_CFLAGS) -c $1 -o $2
> > endef
> >=20
> > SKEL_BLACKLIST :=3D btf__% test_pinning_invalid.c test_sk_assign.c

