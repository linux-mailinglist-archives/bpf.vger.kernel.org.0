Return-Path: <bpf+bounces-77466-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3853BCE6111
	for <lists+bpf@lfdr.de>; Mon, 29 Dec 2025 08:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A346D3000DFC
	for <lists+bpf@lfdr.de>; Mon, 29 Dec 2025 06:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB85D2D29C7;
	Mon, 29 Dec 2025 06:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XKUXZswo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C3426ED37;
	Mon, 29 Dec 2025 06:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766991592; cv=none; b=NN2aG5ZFU44WVwi4K0KpoZ2Wf2VDCvgCx5N9cx4NK40diQOa6V7zLmLoNb8yTkR5psY0B6heNqN8HtoxNaBbE5Fwgy7V+PNEo662yyd4H0wi1f2G67GV4VGyKuOZcGu0bLudGNQ1VDjoL+b3qR0JqiFaJmAB/0jYBgW9pCEUgGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766991592; c=relaxed/simple;
	bh=g2/WFFx72wxYpqQ1Gbnm76IBQ55BtmP8Gs2PWdPLj3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A9sUAc7e/L9Msx29ferZqws4AtAjY3qA0V54AINWCNryychRzQusv4OwkP+qK4U3tQE9OOC25m/TA6zswA1rrmQ/eL9yrdUJZ/Z5l8VNLc5QMOitgEAScbSuPRPtnzAxDjJmAkKzFrjoH2DYR9ET7NoewGG/fe/j68BxsOhGEgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XKUXZswo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70D89C4CEF7;
	Mon, 29 Dec 2025 06:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1766991590;
	bh=g2/WFFx72wxYpqQ1Gbnm76IBQ55BtmP8Gs2PWdPLj3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XKUXZswoeNg6cLuY75yCBRRbOqcfxBrF9wUYZakqcRLhDVcrTP8PRMxiaXBMW8Fwi
	 6Nz4ULTn6G0uZcQgI4tIF5f8Wlht8PRKaFwh92rPdIvuQpyzaIVSGxDRq30gJitygx
	 znw8OjRKHpxrakqLA+OO9vTe0CdCOSpQnNwuDIN0=
Date: Mon, 29 Dec 2025 07:59:46 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: MCB-SMART-BOY <mcb2720838051@gmail.com>
Cc: rust-for-linux@vger.kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/1] Rust BPF Verifier Implementation
Message-ID: <2025122915-distort-concrete-2e5f@gregkh>
References: <20251228190455.176910-1-mcb2720838051@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251228190455.176910-1-mcb2720838051@gmail.com>

On Sun, Dec 28, 2025 at 07:04:55PM +0000, MCB-SMART-BOY wrote:
> Hello Rust for Linux and BPF maintainers,
> 
> I would like to submit an RFC for a complete Rust implementation of the
> Linux kernel's BPF verifier (kernel/bpf/verifier.c) as part of the Rust
> for Linux project.

This was already discussed and rejected (i.e. do not rewrite existing
C code in rust unless you are the owner/maintainer of it).  Why bring
this up again?

thanks,

greg k-h

