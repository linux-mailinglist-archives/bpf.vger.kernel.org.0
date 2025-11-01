Return-Path: <bpf+bounces-73217-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3936DC273FB
	for <lists+bpf@lfdr.de>; Sat, 01 Nov 2025 01:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4C80D4EC55E
	for <lists+bpf@lfdr.de>; Sat,  1 Nov 2025 00:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD59125557;
	Sat,  1 Nov 2025 00:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMzV1Tof"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36123635;
	Sat,  1 Nov 2025 00:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761955641; cv=none; b=WZKMk4/NSLHKu5pecqjgWuM3qNM1Ppeqd0ZJ48QDOqIL+0aqhP7DiqMd5Qa0lxdiup+Bjd6FDKxkiojESgjNtDrqTKMJVpeHJqaj+ZaQugLlazNmK6HoFGRAM9Z3jFte3xFKDA2S+mSCPxGSLI1rIWXm6F7QOFNRbqhGZYH+bUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761955641; c=relaxed/simple;
	bh=Fo1WINFuQMShbmvz9bMKJ+8UIVwRxjXiEVc+Pska/M4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dVYhyDOS5Ss02zJ0QbNAd//RCfa1szjXce7DfdPmNrpG07d3Qo7s5WfAkUVT70TI9ZqXdaMtDgIJpC+GN4ykKyt6+MmhBH+uU+mTaMuXjK8vEPhUysnzw5bOcl+PLJ9a/YlD7cM036r2vHC0zWTqX8pseBMweA2cB+NHEODHvbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nMzV1Tof; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F8B5C4CEE7;
	Sat,  1 Nov 2025 00:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761955640;
	bh=Fo1WINFuQMShbmvz9bMKJ+8UIVwRxjXiEVc+Pska/M4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nMzV1TofbV9YcclehoK85/+kD8MuyWc9b6sHhb5Cr79oyo+CBVTz8c9nngjKxTcta
	 CjdaDs0nnZZpSMeNwT22Dyet0FmhgMrEvH3nz/XmtVJ316M4BepuxDAyesmDvEVzJg
	 WmVnNUhlnD9K2MxrIaKwjf9i8iFlYXVnyb5qGwldS2NlcHE8onTKwyS7A613qoQ76v
	 oRv9yDjWOTMow6+JngLyXgOdGSQe9JXV/uxAVfmeGPIOvTTbLP3oe6xiEs8WARdWes
	 OwpwExvIcxa1DxUlm8+UfVtdTD8eJIir8OlAtgDr4YdK05CBLF5ynmHVeBCFgYmKC8
	 rJvKO/3ffaPSw==
Date: Fri, 31 Oct 2025 17:07:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, "Gustavo A. R. Silva"
 <gustavo@embeddedor.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [net-next PATCH v4 0/7] net: Introduce struct sockaddr_unsized
Message-ID: <20251031170719.65fb8163@kernel.org>
In-Reply-To: <20251029214355.work.602-kees@kernel.org>
References: <20251029214355.work.602-kees@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Oct 2025 14:43:57 -0700 Kees Cook wrote:
> The historically fixed-size struct sockaddr is part of UAPI and embedded
> in many existing structures. The kernel uses struct sockaddr extensively
> within the kernel to represent arbitrarily sized sockaddr structures,
> which caused problems with the compiler's ability to determine object
> sizes correctly. The "temporary" solution was to make sockaddr explicitly
> use a flexible array, but this causes problems for embedding struct
> sockaddr in structures, where once again the compiler has to guess about
> the size of such objects, and causes thousands of warnings under the
> coming -Wflex-array-member-not-at-end warning.
> 
> Switching to sockaddr_storage internally everywhere wastes a lot of memory,
> so we are left with needing two changes:
> - introduction of an explicitly arbitrarily sized sockaddr struct
> - switch struct sockaddr back to being fixed size
> 
> Doing the latter step requires all "arbitrarily sized" uses of struct
> sockaddr to be replaced with the new struct from the first step.
> 
> So, introduce the new struct and do enough conversions that we can
> switch sockaddr back to a fixed-size sa_data.

This doesn't apply to net-next.. Now I kinda wondering if maybe you
skipped a patch? The code itself LGTM.

