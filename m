Return-Path: <bpf+bounces-56365-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DB0A95ABA
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 03:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E46EC7A3498
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 01:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00A7191F6D;
	Tue, 22 Apr 2025 01:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rvXC6W/Z"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FF2EAFA;
	Tue, 22 Apr 2025 01:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745286893; cv=none; b=tc5WJ1UsMmiJtRlVFrMtvSWqC56Bp/Q0M8kKsoCkWLs5FzsiLKZluflJnthip+ux2vgIbspLSKM7SanimeE5+WD5Es7v+lNl1VRi45JmR3RJD9f9KVC4fbt2/ewg92sfd6W+loqqzDLzzpFgb2u3wu0KPLZZ9Gr7JkFnWr0KOaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745286893; c=relaxed/simple;
	bh=8/yg1QcrmfXQPlf5j9BO7rsOfSHi9pXY+FMqaYDLwoU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZHVQsIiE7LIdyxVCjl+Pb+RiGdToZA9JNPhUa3F6iunzUBwuJ/rBtj3dukgxVL23+G5cFPxoKXvNCe2mV1eHKAp+RCx2o5wI62phMnPCY5dVFSOIDJeX0lMrOfczMqahHti9PaFhbaTkRm+gzj3W42jii9q2vj2/zM27gUeXGI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rvXC6W/Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52888C4CEE4;
	Tue, 22 Apr 2025 01:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745286891;
	bh=8/yg1QcrmfXQPlf5j9BO7rsOfSHi9pXY+FMqaYDLwoU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rvXC6W/ZrcopQuJIP8kTo392KNZV+CTu3aKViZpjHvJkMhDMT7Rs0/D9yHZVBJDWU
	 XEl2FELtxvfnYwnpVSSUBEBHqoAAFgPU4p+MAW9RNBtCCBCwMme2UZxsTqjhHndKZq
	 wrlOOy7TvzUi8kuv6Ujl42jUCZpPaQmgUI4JFtZ8z8CMWCuJR1cFiH1qtyrWUret0i
	 HC9Mm9LW9NXLRHE1vJH5DSuuc3I7+6q8EcMhsVmhHeF5ytlzvjoYnLDVIGkpkR1YkH
	 nhGA6mdVaiudNpqXJ/go+96uaS4tEvmiDPSx8M9wHHdMIKsl9JYra7q21QMeKPFoh+
	 m0+ObcG2vGvMA==
Date: Mon, 21 Apr 2025 18:54:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: pull-request: bpf-next 2025-04-17
Message-ID: <20250421185450.6fde6f84@kernel.org>
In-Reply-To: <20250417184338.3152168-1-martin.lau@linux.dev>
References: <20250417184338.3152168-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Apr 2025 11:43:37 -0700 Martin KaFai Lau wrote:
> 1) bpf qdisc support, from Amery Hung.
>    A qdisc can be implemented in bpf struct_ops programs and
>    can be used the same as other existing qdiscs in the
>    "tc qdisc" command.

Hm, it doesn't build in allmodconfig. Is there a strong reason for it?

