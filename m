Return-Path: <bpf+bounces-76724-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 973BACC4925
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 18:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1251E300887A
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 17:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332793164A5;
	Tue, 16 Dec 2025 17:10:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB4A2D3737;
	Tue, 16 Dec 2025 17:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765905022; cv=none; b=bIFwYAjrRYbKuvLsOTqrfzio6+81QuSOGtuUG3Giqp0VCv+aLPLHzxwQOREAVcKbF/T23DbQ3kJh0/w0naVi1qnzSl7fNjB/PJ5ZysYcDPuPIN2QMwon0PByjdyKNxc2FbiKlvJfftcEJKvBx3g9iw3fc+WbKDrvsA9HPbyqSdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765905022; c=relaxed/simple;
	bh=uRUPbCiHXnTghQkPKYQww7L3fIbeCceGFHxUQ+0rygM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NMJwj8msUb43R+OhVdaduAtONMWJMoOL0Az3AbWsm/tu6OLSJzEZj3SE/ARUG535SH/9P2tnmarh6rvWX68N2ILlFDE0Fnk1jjic/Tp1TsQ70AMrMPFS1Xsp5ofGku8+dPH75cC+bB+2KMJSKCGLyZtXw1qxsqJ+3mWg8DB2mRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id DF54D13668A;
	Tue, 16 Dec 2025 17:10:18 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id 8AD712F;
	Tue, 16 Dec 2025 17:10:15 +0000 (UTC)
Date: Tue, 16 Dec 2025 12:11:49 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Chenghao Duan <duanchenghao@kylinos.cn>
Cc: yangtiezhu@loongson.cn, mhiramat@kernel.org, mark.rutland@arm.com,
 hengqi.chen@gmail.com, chenhuacai@kernel.org, kernel@xen0n.name,
 zhangtianyang@loongson.cn, masahiroy@kernel.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 bpf@vger.kernel.org, youling.tang@linux.dev, jianghaoran@kylinos.cn,
 vincent.mc.li@gmail.com, linux-trace-kernel@vger.kernel.org, Youling Tang
 <tangyouling@kylinos.cn>
Subject: Re: [PATCH v3 4/4] LoongArch: ftrace: Adjust register stack restore
 order in direct call trampolines
Message-ID: <20251216121149.11ea9031@gandalf.local.home>
In-Reply-To: <20251216094753.1317231-5-duanchenghao@kylinos.cn>
References: <20251216094753.1317231-1-duanchenghao@kylinos.cn>
	<20251216094753.1317231-5-duanchenghao@kylinos.cn>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 8AD712F
X-Stat-Signature: 4xrgt7ecrnjgzky33k9harsocw9xq4wz
X-Rspamd-Server: rspamout08
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+SyrTxLqUhiKJ9s0JcpuzcjMM6kRirO2A=
X-HE-Tag: 1765905015-430425
X-HE-Meta: U2FsdGVkX1+OjztRmIC2PSbvrT1d/RFzeGvdHtT6JAM6B0NObkQEAPEzsxu1SHM6MHBk5s4ZWMOCiqh+8kDQC2AaoYxckOJUxQNfPO27ol5fs4VHCbfHDUuOM0XQ3oqeDDevDvSeSZllMeIlO+X+2kC9je5jccIxZDqJ6AmpCMJ8La+tTksKvMdVZ6n0ylfZBjiAUwA0OBX6g+z0GlXqzgv/ht2Jt9lHuOZSWn3a10gBsVr/Do+4IwXfX4HyxYBo6hcZpDoZPSQoeYOfMfMWnrOz/t7cjq00MpMzJdAPAVDtXkMvr7zUigBmZyfdaCzyekbsF7n4Sk2K+kYljcUtrhcdkyAFOv5Unoc8laUml66qQ1eITGvnFttKD9FPXQc0YUv+GMdY61OPKnGRGCzPfYDXszdRSc2M

On Tue, 16 Dec 2025 17:47:53 +0800
Chenghao Duan <duanchenghao@kylinos.cn> wrote:

> Ensure that in the ftrace direct call logic, the CPU register state
> (with ra = parent return address) is restored to the correct state
> after the execution of the custom trampoline function and before
> returning to the traced function. Additionally, guarantee the
> correctness of the jump logic for jr t0 (traced function address).
> 
> Reported-by: Youling Tang <tangyouling@kylinos.cn>
> Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
> ---
>  samples/ftrace/ftrace-direct-modify.c       | 8 ++++----
>  samples/ftrace/ftrace-direct-multi-modify.c | 8 ++++----
>  samples/ftrace/ftrace-direct-multi.c        | 4 ++--
>  samples/ftrace/ftrace-direct-too.c          | 4 ++--
>  samples/ftrace/ftrace-direct.c              | 4 ++--
>  5 files changed, 14 insertions(+), 14 deletions(-)

This is all LoongArch specific, but in case you need this to go through
your tree:

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

