Return-Path: <bpf+bounces-43722-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B3A9B8FC7
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 11:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77F281F224F1
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 10:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A84517DE16;
	Fri,  1 Nov 2024 10:55:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF151714D3;
	Fri,  1 Nov 2024 10:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730458502; cv=none; b=MeKGleyk4g4+Ux9cdowHcMVazFmutVqZ0hAm5KF05Anq4l3j2uYzSvL/Z3pD8oC70eOTFDTads/MEUBFwUUM9Z2Rk5hyJjlqr4SyHltbfC7g+8KgDm0qJxuG3kGN3fjeXq3K19VOZSW0k1j92mTtiWjaLZ7tj+J1uk2BN6CJBRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730458502; c=relaxed/simple;
	bh=w4OARYNlH21vGSocyAGaNhD+J6STVANXfmJukfpuOP4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ABeB1nKGf/uF5XCIHaMCBMgnyNpYD5rE9dWoY9vRJmiBeRVxlAeuqtQPnfa0WEqcMKOfTRs3dPTNIegv2gy8bAOBaSVIcBYQYpSc6xh8ggYYx9R4KWssssMGkrHqtCr1UhcnayzSPPsxBoHhS6duybJiZ+6YQhjN6yqKzbEAg5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80D07C4CECD;
	Fri,  1 Nov 2024 10:55:00 +0000 (UTC)
Date: Fri, 1 Nov 2024 06:55:58 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 mhiramat@kernel.org, peterz@infradead.org, paulmck@kernel.org,
 jrife@google.com
Subject: Re: [PATCH trace/for-next 1/3] bpf: put bpf_link's program when
 link is safe to be deallocated
Message-ID: <20241101065558.4be28057@gandalf.local.home>
In-Reply-To: <20241031210938.1696639-1-andrii@kernel.org>
References: <20241031210938.1696639-1-andrii@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 31 Oct 2024 14:09:36 -0700
Andrii Nakryiko <andrii@kernel.org> wrote:

> In general, BPF link's underlying BPF program should be considered to be
> reachable through attach hook -> link -> prog chain, and, pessimistically,
> we have to assume that as long as link's memory is not safe to free,
> attach hook's code might hold a pointer to BPF program and use it.
> 
> As such, it's not (generally) correct to put link's program early before
> waiting for RCU GPs to go through. More eager bpf_prog_put() that we
> currently do is mostly correct due to BPF program's release code doing
> similar RCU GP waiting, but as will be shown in the following patches,
> BPF program can be non-sleepable (and, thus, reliant on only "classic"
> RCU GP), while BPF link's attach hook can have sleepable semantics and
> needs to be protected by RCU Tasks Trace, and for such cases BPF link
> has to go through RCU Tasks Trace + "classic" RCU GPs before being
> deallocated. And so, if we put BPF program early, we might free BPF
> program before we free BPF link, leading to use-after-free situation.
> 
> So, this patch defers bpf_prog_put() until we are ready to perform
> bpf_link's deallocation. At worst, this delays BPF program freeing by
> one extra RCU GP, but that seems completely acceptable. Alternatively,
> we'd need more elaborate ways to determine BPF hook, BPF link, and BPF
> program lifetimes, and how they relate to each other, which seems like
> an unnecessary complication.
> 
> Note, for most BPF links we still will perform eager bpf_prog_put() and
> link dealloc, so for those BPF links there are no observable changes
> whatsoever. Only BPF links that use deferred dealloc might notice
> slightly delayed freeing of BPF programs.
> 
> Also, to reduce code and logic duplication, extract program put + link
> dealloc logic into bpf_link_dealloc() helper.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>


Hi Andrii,

Do you want me to add this on top of my queue? If so, would it be possible
that I can get a tested-by from someone? As I don't do much to test BPF
patches.

-- Steve

