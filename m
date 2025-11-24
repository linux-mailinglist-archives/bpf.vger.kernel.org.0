Return-Path: <bpf+bounces-75369-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA816C81BFD
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 17:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7C4D3A9F04
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 16:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A77D3168E0;
	Mon, 24 Nov 2025 16:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s+MMjJPB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE275311C1F;
	Mon, 24 Nov 2025 16:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764003487; cv=none; b=covl162Jcv2Z9PW8zDPkwKm7Sg5jV5u6Q7geyyRFdd166QbaCfmu13ee3FknfayyPBtazTv8z6i80DIuZrpx53160heReGbmFTR+Scmdy5r7EWcRXrl7kXNbDugkyHPNJoWmtL5Kd+caBNVjs+oJ4N5IixJjMoF1lRh4ril17cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764003487; c=relaxed/simple;
	bh=AiagHG4Typ8wJVWeZPF2Qbb1jiO+yYjCPyNDw/fiyfU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=fx9oTasou7Ckr1lLRoruTCWNipRW6hzSPn9tXJyGG4FDmKjHCfoODpl/3eo18bOcc/N8Eji5jFBLq7/ef04t4c/Tt2sUaOpZX/cVwuabrzUqbMAa7RxAKjlcZtAg7qd6kmjZtJh0iRKCgbv08chaepOrMKFjaT/hIEmjOL/incs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s+MMjJPB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DECFFC4CEF1;
	Mon, 24 Nov 2025 16:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764003485;
	bh=AiagHG4Typ8wJVWeZPF2Qbb1jiO+yYjCPyNDw/fiyfU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=s+MMjJPBlpDY2VxLj/z1VCkc0oid2cTtOzTdLOZWpiRI3I2HBn8gOhs6wFsqbNyRT
	 OWgl2u3VJMeClA/vdOOENZI9owQ/rIBswGFz9TXeyefMw2yuyd6gVserdYfWMfkaN/
	 AasRrGtHSRdmp1ZsNbdgOEH9g0GZfvvUxvup6wVmOebwc+bIAIyLZMysww1K5Jz7Cm
	 JqCjUqcp/sUEGakEgg4BmmN53odJgCeLFESjM/VNxj0j/pVCMC8ONzOraOHOSBjaIe
	 GfKJQfO4gXc6nUvj76zjXJ5WysI3Z2Ivl2EI3C/l1fzJrFk3A6K9heRuFpH/Y1SdM1
	 vvEXJ3tzsV5kg==
Content-Type: multipart/mixed; boundary="===============7824916141330859013=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4d340abe294ac0290710c745f5f48bfb89b12ed3ac2be1c2df6d85848b45724f@mail.kernel.org>
In-Reply-To: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-15-8978f5054417@cloudflare.com>
References: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-15-8978f5054417@cloudflare.com>
Subject: Re: [PATCH RFC bpf-next 15/15] bpf: Realign skb metadata for TC progs using data_meta
From: bot+bpf-ci@kernel.org
To: jakub@cloudflare.com,bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,kernel-team@cloudflare.com,martin.lau@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 24 Nov 2025 16:58:04 +0000 (UTC)

--===============7824916141330859013==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


commit 9078292074a586fc1414d4e4f5a2ad2d04a9e39c
Author: Jakub Sitnicki <jakub@cloudflare.com>

bpf: Realign skb metadata for TC progs using data_meta

This commit restores BPF data_meta functionality for TC programs after
the metadata location was decoupled from MAC header offset. It introduces
bpf_skb_meta_realign() to close gaps between metadata and skb->data.

> commit 9078292074a586fc1414d4e4f5a2ad2d04a9e39c
> Author: Jakub Sitnicki <jakub@cloudflare.com>
> Date:   Mon Nov 24 17:28:51 2025 +0100
>
>     bpf: Realign skb metadata for TC progs using data_meta
>
>     After decoupling metadata location from MAC header offset, a gap can appear
>     between metadata and skb->data on L2 decapsulation (e.g., VLAN, GRE). This
>     breaks the BPF data_meta pointer which assumes metadata is directly before
>     skb->data.
>
>     Introduce bpf_skb_meta_realign() kfunc to close the gap by moving metadata
>     to immediately precede the MAC header. Inject a call to it in
>     tc_cls_act_prologue() when the verifier detects data_meta access
>     (PA_F_DATA_META_LOAD flag).
>
>     Update skb_data_move() to handle the gap case: on skb_push(), move metadata
>     to the top of the head buffer; on skb_pull() where metadata is already
>     detached, leave it in place.
>
>     This restores data_meta functionality for TC programs while keeping the
>     performance benefit of avoiding memmove on L2 decapsulation for programs
>     that don't use data_meta.
>
>     Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>

This appears to fix the bug introduced by commit 016079023cef ("net:
Track skb metadata end separately from MAC offset"). Should this include
a Fixes: tag?

The earlier commit message explicitly noted: "Note that this breaks BPF
skb metadata access through skb->data_meta when there is a gap between
meta_end and skb->data. Following BPF verifier changes address this."

This commit is one of those follow-up changes that addresses the
breakage.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19641863515

--===============7824916141330859013==--

