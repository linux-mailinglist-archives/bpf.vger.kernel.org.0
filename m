Return-Path: <bpf+bounces-78634-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE66D16388
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 02:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4F40A300D423
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 01:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6DE2820A4;
	Tue, 13 Jan 2026 01:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U0WmTyuS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3BB28136F
	for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 01:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768269116; cv=none; b=oxHNGAXVndDnf1+YxbGfusCehdhCpIPv7QHYr2PbVcGN8m4OXsc6Jp+5eO//lubfOsCq6F4EtFRxUVpZushW5/MAy1i0pwgWA7PstUz/gOQ/EUXEKVdA34BRaxKiu7V1egAaJZB5ZWJMc/f0U3JE6EPMuBvsSsvokJUDlzzBKww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768269116; c=relaxed/simple;
	bh=jqyuwK6rVatG5SgEyHj8Jgxvss1mk94ml+mkdOlelwI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=nj9LG01/OfM+OoaTfc265oXxK9raIMNk/2ufFP9oaBN3+mGN1n5TW5FaWRfWeO0RS8aLzyVKmZZfgknXLEKsHTEZd7ljHMGccgoEdo6zv0dg77VMwuYT0ByQknsgMNs3wwAZ83iakoZtEKDXU/MYJVhePRSghzkqPGY7XeepBOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U0WmTyuS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 168AAC116D0;
	Tue, 13 Jan 2026 01:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768269112;
	bh=jqyuwK6rVatG5SgEyHj8Jgxvss1mk94ml+mkdOlelwI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=U0WmTyuSCqAnqH3aFvsMV5z9wqf8M8aCsqMf1cZJMztZ83fyCz4dkS4vedTwKjkBE
	 JOFzYZ94+KvLMSHCzaS0X/+UT0EmbcG6X6kyQcKN1TQ7B5x1x3dZ/lkEYeLUeIhlre
	 qpI5ED79kAwui4V7xdCpcul+EQmlzMEE5PNk+/GxmBVZC7FPBN36kiSgnjtD3pEF2D
	 O/hVXLuc6MM+8LNP1MTJSpS3S5Nv0fyKir9FsrPJF9NdOzMfm5e3x/bq/QCt3sbgTj
	 QFsUbr/I4LyZsew56MA0m7bzsC4HP3wjjKySpVhjoMNpOaV2DPkeGLvZNlurJIX2ud
	 fRc5A12MdKtuA==
Date: Mon, 12 Jan 2026 18:51:48 -0700 (MST)
From: Paul Walmsley <pjw@kernel.org>
To: Bo Gan <ganboing@gmail.com>
cc: Lukas Gerlach <lukas.gerlach@cispa.de>, bpf@vger.kernel.org, 
    linux-riscv@lists.infradead.org, tech-speculation-barriers@lists.riscv.org, 
    bjorn@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
    luke.r.nels@gmail.com, xi.wang@gmail.com, palmer@dabbelt.com, 
    luis.gerhorst@fau.de, daniel.weber@cispa.de, marton.bognar@kuleuven.be, 
    jo.vanbulck@kuleuven.be, michael.schwarz@cispa.de
Subject: Re: [PATCH] riscv, bpf: Emit fence.i for BPF_NOSPEC
In-Reply-To: <b39e9af7-bdbf-4e02-ab7e-ec24626cada4@gmail.com>
Message-ID: <65f1b958-e420-c517-9a60-86f9085de702@kernel.org>
References: <20251228173753.56767-1-lukas.gerlach@cispa.de> <b39e9af7-bdbf-4e02-ab7e-ec24626cada4@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hi,

On Mon, 12 Jan 2026, Bo Gan wrote:

> Please also check out Ved's response from the Speculation Barrier TG:
> 
> https://lists.riscv.org/g/tech-speculation-barriers/message/21
> 
> I think the best way forward is to wait for the TG to clearly define
> speculation barrier instructions, and use them for future cores. 

Waiting for the speculation barriers TG to complete their work is 
unfortunately a non-starter.  It seems unlikely to do so for quite some 
time.  Even once the extension is ratified, it's likely to take years 
before these instructions enter silicon and are widely available.  
Meanwhile, there are already newer designs in silicon targeting use cases 
that will need mitigations.

> For existing HW, emit a warning and do nothing. 

Can we really assume that this use case is the same as everyone else's?  
So far the Linux approach to microarchitectural attacks is to implement 
mitigations, with the expensive ones switchable, and then to give users 
the choice as to whether to disable mitigations for their use case.  Is 
there a reason for arch/riscv to take a substantially different approach?

> I don't want to see bpf doing fence.i universally for all riscv.

I think there's already agreement here - 

  https://lore.kernel.org/linux-riscv/20260106084410.94496-1-lukas.gerlach@cispa.de/

> Neither do I like it guessing this and that specific core implementation 
> needing fence.i or not. We simply don't know how each vendor design 
> their cores. Let the vendor tell us what's the best instruction to use 
> for our existing HW.  E.g., for JH7110, it's really U74 from Sifive, so 
> we can ask them to fill-in

We should make sure that the sequence used can be determined per- 
microarchitecture.  But if there's no guidance from the vendor, then the 
community should implement something that seems to work.  This should also 
encourage vendors to engage with us to make sure that the most efficient 
workarounds or mitigations are implemented.  That hopefully should also 
encourage vendors to design hardware that don't have these known 
vulnerabilities.


- Paul

