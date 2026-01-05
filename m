Return-Path: <bpf+bounces-77894-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC00CF5FC8
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 00:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E4E83065296
	for <lists+bpf@lfdr.de>; Mon,  5 Jan 2026 23:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DF82F39DE;
	Mon,  5 Jan 2026 23:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBicwwFz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79242D73A0
	for <bpf@vger.kernel.org>; Mon,  5 Jan 2026 23:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767655708; cv=none; b=rfoN8y4/VR7FFFCQAoFlBr85lpfG+E2tK5Bg2/B1kQnxitXtGsZVlh9qLtCRZhtSptahhtd77V6kioO8NvrO708DkhIE1W2Nwysj0irp/t56H/UzUvwxra4UjXakzRjs2hN+pKdDUUlLQoOCsZbukMps7BvQdILa8lhDTAsG6TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767655708; c=relaxed/simple;
	bh=U21q/lDfx/BO3V6IyHv1qFtq6LrV83MbndFcW6vb1iE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FjILRJVAfQbHGOZd/CTDFJ6pVOrR5O5viG851gnL/udX9+GGRlwgv1TtA67Dn22cGQK2aRu0W4b1kbhBzeJQcWn5XofC+8JZI22t+D9GcMLB6DFjD0zBlg5Q+zT306a+/klG2l3V6LK4nrt/rqeSGkcLPuz2QA6qA5KedgLJWhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBicwwFz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60CB0C116D0;
	Mon,  5 Jan 2026 23:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767655708;
	bh=U21q/lDfx/BO3V6IyHv1qFtq6LrV83MbndFcW6vb1iE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=YBicwwFzKdQXs1oEo7+hTDN44E9akaBi1P6qzgZZ7ykFOIOIENRi/AUeYoB0abnC5
	 W6RoAVYi9u+ThqIORZR1n44jS/C/idBwlwD+NffY6w9CLCSrtj8+JHWoCyc5HOxUEu
	 jEoc5Y3L5NEyUSQ1XXB82g3JMUPm46U6u5y24E82AZuElxP1ni1a8BznNjrm40imXW
	 FqAP+P6sPBhPjV0f/8+B8IEg9UDIdpN61wdimxpjay+oIrufL6WUYRGYdS9CTQDMO/
	 lOFP+0uBdgfBpmWwC7DLFo+u9PNNQkFrKM40ZfMCzxE1V33Yo98uFwGHspIDeeEKWr
	 kwzuRHrI4dkmw==
Date: Mon, 5 Jan 2026 16:28:26 -0700 (MST)
From: Paul Walmsley <pjw@kernel.org>
To: Lukas Gerlach <lukas.gerlach@cispa.de>
cc: bpf@vger.kernel.org, linux-riscv@lists.infradead.org, bjorn@kernel.org, 
    ast@kernel.org, daniel@iogearbox.net, luke.r.nels@gmail.com, 
    xi.wang@gmail.com, palmer@dabbelt.com, luis.gerhorst@fau.de, 
    daniel.weber@cispa.de, marton.bognar@kuleuven.be, jo.vanbulck@kuleuven.be, 
    michael.schwarz@cispa.de
Subject: Re: [PATCH] riscv, bpf: Emit fence.i for BPF_NOSPEC
In-Reply-To: <20251228173753.56767-1-lukas.gerlach@cispa.de>
Message-ID: <83981ed7-9d36-a47a-cf73-9010fceba5f1@kernel.org>
References: <20251228173753.56767-1-lukas.gerlach@cispa.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hi Lukas, 

thanks for the patch,

On Sun, 28 Dec 2025, Lukas Gerlach wrote:

> The BPF verifier inserts BPF_NOSPEC instructions to create speculation
> barriers. However, the RISC-V BPF JIT emits nothing for this
> instruction, leaving programs vulnerable to speculative execution
> attacks.
> 
> Originally, BPF_NOSPEC was used only for Spectre v4 mitigation, programs
> containing potential Spectre v1 gadgets were rejected by the verifier.
> With the VeriFence changes, the verifier now accepts these
> programs and inserts BPF_NOSPEC barriers for Spectre v1 mitigation as
> well. On RISC-V, this means programs that were previously rejected are
> now accepted but left unprotected against both v1 and v4 attacks.
> 
> RISC-V lacks a dedicated speculation barrier instruction.
> This patch uses the fence.i instruction as a stopgap solution.
> However an alternative and safer approach would be to reject vulnerable bpf
> programs again.
> 
> Fixes: f5e81d111750 ("bpf: Introduce BPF nospec instruction for mitigating Spectre v4")
> Fixes: 5fcf896efe28 ("Merge branch 'bpf-mitigate-spectre-v1-using-barriers'")
> Signed-off-by: Lukas Gerlach <lukas.gerlach@cispa.de>

Have you been able to measure whether this change results in a performance 
regression on cores that might not need these barriers, for example, 
in-order cores with limited speculation?

Am thinking that we probably should make this conditional using code 
similar to arch/arm64/kernel/proton-pack.c - and avoiding the fence.i when 
cores that aren't likely to be susceptible are detected.

Thoughts?  


- Paul

