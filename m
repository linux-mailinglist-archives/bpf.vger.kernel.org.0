Return-Path: <bpf+bounces-51612-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EBCA36769
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 22:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FD8516ECCE
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 21:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC281DA634;
	Fri, 14 Feb 2025 21:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aU7Z9YgL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9225158870;
	Fri, 14 Feb 2025 21:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739568010; cv=none; b=BLGQ6RKlQyewtVN4BfRddDMT4birJzNCxxNLZdYhrMmfqTLz1bb+UxXnkGRymJOUxOLUSIJzn0/7ke+uE+TnPVok4OJ4f6dk40mrdUMsWRJOhH2tywvObvjiYe+C66xSNljMPXI/LwcXeBuNbBk75XatLVC5/RV/Z+JJ3WO35c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739568010; c=relaxed/simple;
	bh=7Bz6zsV8G0KelhMQC/n7HDA0e50TvIelUa+YzRPtv0I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NZFhxVCVyAA3j5gVOOTw8Sd9ictRJUN8ibUC9/9f4gQeAHyVKj8zgDpoNJZo4eGHFzieTjCQv36XcVHVVxHqKubX6T6HT8h0J5RM7myuYUsqJrtJnlNJz6CzqFYNVfBm81iUxS4j4Nv1tg87+Msd1KWa5AxMz98yEXf35DL//gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aU7Z9YgL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F521C4CED1;
	Fri, 14 Feb 2025 21:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739568009;
	bh=7Bz6zsV8G0KelhMQC/n7HDA0e50TvIelUa+YzRPtv0I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aU7Z9YgL9uMd/MjkiSsN8zEGiS0VtEtagk1gc9XSw4PWDNWmBO6fxCcwKhFfzgPYe
	 +GVfdbsFkPv8SKkarkA/jl8Ptpsbwx3ySIH6nBqGAYKFQM1riqNe+QClmM4sDtUqYh
	 1jGGwYWusdwaykuFAnjP5jbG82ev90j5j9EsVv4aNtYu2h1nAYn51nWfSL/v71rAQ3
	 Eefvo666R2zoWOFCEVwxnnQP4qrXOp1fzNuWvbO5RU6v1W2ZQTObz6DNjGtqRiYCWt
	 X8Oqh4rFDOQyLOzW7hvS66sH4ekLua2Lla3+hohMJKVIoLjoEkZ1pnWvEW8Cs29CSw
	 9bzyQ0a5gtS+A==
Date: Fri, 14 Feb 2025 13:20:07 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: zhangmingyi <zhangmingyi5@huawei.com>, kernel test robot
 <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, Xin Liu
 <liuxin350@huawei.com>, netdev@vger.kernel.org, bpf@vger.kernel.org,
 mptcp@lists.linux.dev, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 linux-kernel@vger.kernel.org, yanan@huawei.com, wuchangye@huawei.com,
 xiesongyang@huawei.com, liwei883@huawei.com, tianmuyang@huawei.com
Subject: Re: [PATCH v2 1/2] bpf-next: Introduced to support the ULP to get
 or set sockets
Message-ID: <20250214132007.54dd0693@kernel.org>
In-Reply-To: <62294c30-ca75-4075-8d4b-3801194bd92c@linux.dev>
References: <202502140959.f66e2ba6-lkp@intel.com>
	<62294c30-ca75-4075-8d4b-3801194bd92c@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Feb 2025 22:23:39 -0800 Martin KaFai Lau wrote:
> On 2/13/25 6:13 PM, kernel test robot wrote:
> > [ 71.196846][ T3759] ? tls_init (net/tls/tls_main.c:934 net/tls/tls_main.c:993)
> > [ 71.196856][ T3759] ? __schedule (kernel/sched/core.c:5380)
> > [ 71.196866][ T3759] __mutex_lock (kernel/locking/mutex.c:587 kernel/locking/mutex.c:730)
> > [ 71.196872][ T3759] ? tls_init (net/tls/tls_main.c:934 net/tls/tls_main.c:993)
> > [ 71.196878][ T3759] ? rcu_read_unlock (include/linux/rcupdate.h:335)
> > [ 71.196885][ T3759] ? mark_held_locks (kernel/locking/lockdep.c:4323)
> > [ 71.196889][ T3759] ? lock_sock_nested (net/core/sock.c:3653)
> > [ 71.196898][ T3759] mutex_lock_nested (kernel/locking/mutex.c:783)  
> 
> This is probably because __tcp_set_ulp is now under the rcu_read_lock() in patch 1.
> 
> Even fixing patch 1 will not be enough. The bpf cgrp prog (e.g. sockops) cannot 
> sleep now, so it still cannot call bpf_setsockopt(TCP_ULP, "tls") which will 
> take a mutex. This is a blocker :(

Oh, kbuild bot was nice enough to CC netdev, it wasn't CCed on 
the submission.

I'd really rather we didn't allow setting ULP from BPF unless there 
is a strong and clear use case. The ULP configuration and stacking
is a source of many bugs. And the use case here AFAIU is to allow
attaching some ULP from an OOT module to a socket, which I think
won't make core BPF folks happy either, right?

