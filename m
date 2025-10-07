Return-Path: <bpf+bounces-70473-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BD002BBFE85
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 03:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 762F04EAC53
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 01:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441601E1C22;
	Tue,  7 Oct 2025 01:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V4XBo5R9"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1794EF9C1
	for <bpf@vger.kernel.org>; Tue,  7 Oct 2025 01:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759799426; cv=none; b=Ku9HGJ62e6ejBFVqRT2zINyiC0zhbLgNr2bb263SiTJzZl7g773o4TnaAKx14s4E+hRy20T2YbaaKAe4+71xZ0ob4UbvBDK5Hwv9R6ViQ5S8qIJn0XmErM1K3NloFujsLr3IRedcBPVtsu2O6uWyNB5cMSxPfBThjfnmZcVtFxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759799426; c=relaxed/simple;
	bh=JlSaKWGuV5dim81gtrAXDpQsohCMts943PFDEhkU/Ao=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=vCrxoidozkwZS/5+SSvOxGrs/lJO3aK3Du+hpWIDVCIdfRmZT8lvwRjcoXbl+IuINYoTzvswmpwNavSKUflcr72wY+jrfO29vYlQxjzGVhoSIimvoGO3ggbfjYHel3WjjM5T3Xs4WtYv6JQv4YaOxMG1qodFEJgb2CPlDmaoc8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V4XBo5R9; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759799417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4IYA9vOqgZNsg468nDc3Sy33/MTaTQ7pzXXNVegBBCg=;
	b=V4XBo5R9e3GtTvE4tPnliRP7jzbjOuOLkj6jk04LW+fO4OraRRkoGe4U/Tj2BdSxpcegUv
	9Zy+DfP9kELq4uUtjkTjzB4V9VOVOfq3O9s1AbH0xMBryQVXPfio1m2yHO9mXGkEcckROO
	NALsV4+6wrPwFGLI2P74KaiWqAu6ur0=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>,  Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,  Martin
 KaFai Lau <martin.lau@linux.dev>,  John Fastabend
 <john.fastabend@gmail.com>,  Stanislav Fomichev <sdf@fomichev.me>,  "David
 S. Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,
  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Neal
 Cardwell <ncardwell@google.com>,  Willem de Bruijn <willemb@google.com>,
  Mina Almasry <almasrymina@google.com>,  Kuniyuki Iwashima
 <kuni1840@gmail.com>,  bpf@vger.kernel.org,  netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next/net 0/6] bpf: Allow opt-out from
 sk->sk_prot->memory_allocated.
In-Reply-To: <20251007001120.2661442-1-kuniyu@google.com> (Kuniyuki Iwashima's
	message of "Tue, 7 Oct 2025 00:07:25 +0000")
References: <20251007001120.2661442-1-kuniyu@google.com>
Date: Mon, 06 Oct 2025 18:10:09 -0700
Message-ID: <87ldlnfrf2.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Kuniyuki Iwashima <kuniyu@google.com> writes:

> This series allows opting out of the global per-protocol memory
> accounting if socket is configured as such by sysctl or BPF prog.
>
> This series is v11 of the series below [0], but I start as a new series
> because the changes now fall in net and bpf subsystems only.
>
> I discussed with Roman Gushchin offlist, and he suggested not mixing
> two independent subsystems and it would be cleaner not to depend on
> memcg.
>
> So, sk->sk_memcg and memcg code are no longer touched, and instead we
> use another hole near sk->sk_prot to store a flag for the net feature.
>
> Overview of the series:
>
>   patch 1 is misc cleanup
>   patch 2 allows opt-out from sk->sk_prot->memory_allocated
>   patch 3 introduces net.core.bypass_prot_mem
>   patch 4 & 5 supports flagging sk->sk_bypass_prot_mem via bpf_setsockopt()
>   patch 6 is selftest

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
for the series.

Thanks!

