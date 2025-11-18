Return-Path: <bpf+bounces-74843-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 028ACC66FC2
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 03:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D0C364F061B
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 02:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6EC309F1B;
	Tue, 18 Nov 2025 02:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iak9aBMG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D901D243954;
	Tue, 18 Nov 2025 02:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763431793; cv=none; b=hC00BxjAxLt2UdYjcxIqqghG0+K0iQEUubEbNrcPsyWEfNrV6csj5gI85+LurAFgr+1ZlGFFy32mHFM+3g6Co0wdIHvOG/zmCJEiNKCUrwiQEDCUPQR/dNp3ckEvMIZiuet7LQzQ/Dv6eR4DIUsNSeGOwXypCX9dYJ5OoMcQirc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763431793; c=relaxed/simple;
	bh=WW99lHBxpZW1iRW+EUshaaol52KfCnDwjzxBleNBscA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=dOQh1XqTxDgMnpy3heYubzZBYT5KYIRWmp5qOhp4GAqbn+uk8QaAMByMHIRZDF6e8rygh4KB0kU7bS/TVC1SS+Pe0mJBtAHIpwn+6TNGiG628vZYcwa2p67LlZTCMbgNdIHqUP4MEfWjhiIhGZugAm1qsDXorE32NyHjiQj7iHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iak9aBMG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06876C2BC87;
	Tue, 18 Nov 2025 02:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763431791;
	bh=WW99lHBxpZW1iRW+EUshaaol52KfCnDwjzxBleNBscA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iak9aBMGQgdL6X1JA81G5bTx3eh5kxMHeKJLzjx5x5BugkYwf8QZawYedba2IVVyc
	 KS8xNYDuMrQTuYOqkcO0nvryzYj/Kfb/UoAhWMHyQtSiSNrJ1SoMmDNZzAsb3LcmPB
	 wvwzH1Thz8jJnwlzuSChvMIMPKTPNfKZhkPZL5EFEsJzBdYAyDvYFtd53OHP9Or4Cu
	 LnYPUnPjtqL6rub58FT9EDSzoNYN2on0T0jrFnHUVHngucaJrnT+FjfH673tUc/WkO
	 AK8gdmanU4vYTSPhQMM+Hi4MLZafJBs3Rl/H05U4p9y7MbvxONOnDNHBlzugO1B2NY
	 E8dbfoKbfcgTg==
Date: Tue, 18 Nov 2025 11:09:46 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>,
 Ivan Pravdin <ipravdin.official@gmail.com>, Crystal Wood
 <crwood@redhat.com>, John Kacur <jkacur@redhat.com>, Costa Shulyupin
 <costa.shul@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>,
 linux-trace-kernel@vger.kernel.org (open list:Real-time Linux Analysis
 (RTLA) tools), linux-kernel@vger.kernel.org (open list),
 bpf@vger.kernel.org (open list:BPF [MISC]:Keyword:(?:\b|_)bpf(?:\b|_))
Subject: Re: [rtla 01/13] rtla: Check for memory allocation failures
Message-Id: <20251118110946.2e154e8c88b3edd31cc3113a@kernel.org>
In-Reply-To: <20251117184409.42831-2-wander@redhat.com>
References: <20251117184409.42831-1-wander@redhat.com>
	<20251117184409.42831-2-wander@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Nov 2025 15:41:08 -0300
Wander Lairson Costa <wander@redhat.com> wrote:

> The actions_init() and actions_new() functions did not check the
> return value of calloc() and realloc() respectively. In a low
> memory situation, this could lead to a NULL pointer dereference.
> 
> Add checks for the return value of memory allocation functions
> and return an error in case of failure. Update the callers to
> handle the error properly.
> 
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> ---
>  tools/tracing/rtla/src/actions.c       | 26 +++++++++++++++++++++++---
>  tools/tracing/rtla/src/actions.h       |  2 +-
>  tools/tracing/rtla/src/timerlat_hist.c |  7 +++++--
>  tools/tracing/rtla/src/timerlat_top.c  |  7 +++++--
>  4 files changed, 34 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/tracing/rtla/src/actions.c b/tools/tracing/rtla/src/actions.c
> index 8945aee58d511..01648a1425c10 100644
> --- a/tools/tracing/rtla/src/actions.c
> +++ b/tools/tracing/rtla/src/actions.c
> @@ -11,11 +11,13 @@
>  /*
>   * actions_init - initialize struct actions
>   */
> -void
> +int
>  actions_init(struct actions *self)
>  {
>  	self->size = action_default_size;
>  	self->list = calloc(self->size, sizeof(struct action));
> +	if (!self->list)
> +		return -1;

Can you return -ENOMEM?

>  	self->len = 0;
>  	self->continue_flag = false;
>  
> @@ -23,6 +25,7 @@ actions_init(struct actions *self)
>  
>  	/* This has to be set by the user */
>  	self->trace_output_inst = NULL;
> +	return 0;
>  }
>  
>  /*
> @@ -50,8 +53,13 @@ static struct action *
>  actions_new(struct actions *self)
>  {
>  	if (self->len >= self->size) {
> -		self->size *= 2;
> -		self->list = realloc(self->list, self->size * sizeof(struct action));
> +		const size_t new_size = self->size * 2;
> +		void *p = reallocarray(self->list, new_size, sizeof(struct action));
> +
> +		if (!p)
> +			return NULL;
> +		self->list = p;
> +		self->size = new_size;
>  	}
>  
>  	return &self->list[self->len++];
> @@ -65,6 +73,9 @@ actions_add_trace_output(struct actions *self, const char *trace_output)
>  {
>  	struct action *action = actions_new(self);
>  
> +	if (!action)
> +		return -1;

I think !action should return -ENOMEM too.

> +
>  	self->present[ACTION_TRACE_OUTPUT] = true;
>  	action->type = ACTION_TRACE_OUTPUT;
>  	action->trace_output = calloc(strlen(trace_output) + 1, sizeof(char));
> @@ -83,6 +94,9 @@ actions_add_signal(struct actions *self, int signal, int pid)
>  {
>  	struct action *action = actions_new(self);
>  
> +	if (!action)
> +		return -1;
> +
>  	self->present[ACTION_SIGNAL] = true;
>  	action->type = ACTION_SIGNAL;
>  	action->signal = signal;
> @@ -99,6 +113,9 @@ actions_add_shell(struct actions *self, const char *command)
>  {
>  	struct action *action = actions_new(self);
>  
> +	if (!action)
> +		return -1;
> +
>  	self->present[ACTION_SHELL] = true;
>  	action->type = ACTION_SHELL;
>  	action->command = calloc(strlen(command) + 1, sizeof(char));
> @@ -117,6 +134,9 @@ actions_add_continue(struct actions *self)
>  {
>  	struct action *action = actions_new(self);
>  
> +	if (!action)
> +		return -1;
> +
>  	self->present[ACTION_CONTINUE] = true;
>  	action->type = ACTION_CONTINUE;
>  

The above same patterns too.

Thank you,



-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

