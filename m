Return-Path: <bpf+bounces-63659-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7476B094E2
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 21:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 684C41C80033
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 19:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC362FEE23;
	Thu, 17 Jul 2025 19:19:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FB1215075;
	Thu, 17 Jul 2025 19:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752779988; cv=none; b=StSSI2BwIWW8oWZVGC9FJnvLocnWDo9YFIshReXYdVCqggZ6D8vXfQOXA/fiEVPJDn83qCBKaOQsZhWxwc25+DimoPDBJIi+W3qbey4lNH+BJSBFGybxYpqB+bHUetrL6P7Y0AzlvGuky/SDvA8fMCXtP6oMkCoFrK2ctdXLFdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752779988; c=relaxed/simple;
	bh=kB9IkGOyhWi8aZQPMVJ3OuNL8CF6gSScMPT2UpGm2IQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VWuPT8aDCC+Qh7HvJbAlPI9hCh5q6UZCqBr/FGMjJ1zKlFcdz92xO7CHjCwnp2rYh5RArncSc16ZhL6QeZqizv4+AhIpzT098XNuu0t5VnnKNZ6ec50KCa0Nld5gV3g5ou/Jku0uVwj+8Ysr/bQiFHX1/q6x7jnsc1gdiCZGvQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id E655412C48F;
	Thu, 17 Jul 2025 19:19:38 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id 3D9E520026;
	Thu, 17 Jul 2025 19:19:35 +0000 (UTC)
Date: Thu, 17 Jul 2025 15:19:34 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, Boqun Feng <boqun.feng@gmail.com>,
 linux-rt-devel@lists.linux.dev, rcu@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Frederic Weisbecker
 <frederic@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, Josh
 Triplett <josh@joshtriplett.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Uladzislau Rezki <urezki@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 bpf@vger.kernel.org
Subject: Re: [PATCH RFC 6/4] srcu: Add guards for SRCU-fast readers
Message-ID: <20250717151934.282d8310@batman.local.home>
In-Reply-To: <58866d6b-f4d9-4aaf-abce-10ddf526c3ad@paulmck-laptop>
References: <fa80f087-d4ff-4499-aec9-157edafb85eb@paulmck-laptop>
	<29b5c215-7006-4b27-ae12-c983657465e1@efficios.com>
	<acb07426-db2f-4268-97e2-a9588c921366@paulmck-laptop>
	<ba0743dc-8644-4355-862b-d38a7791da4c@efficios.com>
	<512331d8-fdb4-4dc1-8d9b-34cc35ba48a5@paulmck-laptop>
	<bbe08cca-72c4-4bd2-a894-97227edcd1ad@efficios.com>
	<16dd7f3c-1c0f-4dfd-bfee-4c07ec844b72@paulmck-laptop>
	<20250716110922.0dadc4ec@batman.local.home>
	<895b48bd-d51e-4439-b5e0-0cddcc17a142@paulmck-laptop>
	<bb20a575-235b-499e-aa1d-70fe9e2c7617@paulmck-laptop>
	<58866d6b-f4d9-4aaf-abce-10ddf526c3ad@paulmck-laptop>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: f1i5qzt8ywhfsbut83rigxt5kcatozun
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 3D9E520026
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+ifgrOJiti0sHJLe5OjazXhA7CciV74js=
X-HE-Tag: 1752779975-430591
X-HE-Meta: U2FsdGVkX1+5v4+7LXMwBsDkgdgnLIpgKoyNFh+3UmQ965qUU1iKf3Bs59xWgb/laJhfUv1NFr4kINGSQkTItrZLg797vHx5jI3+rkbCit9duD34xgwUT1ZBjueYCuDw04kgfqkF4m9RzZAcKPodliS2aZAZjRfdWaGJ7YeXhvcrXKI2JEFJg/0NfnE7eeuXh+DBedtETAPbCxiVzxpTOD8VKfDciV2uR00x+vOtO0t87CC/WMP30i3pI2VCNAOsK0ZNdOgvJD1muUrSjK46JaQF7dSHYitJdxUHuDaBqXdnkLm3rZZeUg24TuVYxWh6aIb/cHrsLxGQ5Lxs4aGfQs6C1g3YwuenZjgd92+x6a70+U8aG9ObufPpbgVe08eQq8kxCiTkvQ9LKM5DeJgrlqtyAqcNpRHJjq3lDS1OSJaBQBlfRCm3GKS7lLrrqATaAswKow/DICIJYB6qXfRxDw==

On Thu, 17 Jul 2025 12:04:46 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> This adds the usual scoped_guard(srcu_fast, &my_srcu) and
> guard(srcu_fast)(&my_srcu).
> 
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

> ---
>  srcu.h |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> index 0aa2376cca0b1..ada65b58bc4c5 100644
> --- a/include/linux/srcu.h
> +++ b/include/linux/srcu.h
> @@ -510,6 +510,11 @@ DEFINE_LOCK_GUARD_1(srcu, struct srcu_struct,
>  		    srcu_read_unlock(_T->lock, _T->idx),
>  		    int idx)
>  
> +DEFINE_LOCK_GUARD_1(srcu_fast, struct srcu_struct,
> +		    _T->scp = srcu_read_lock_fast(_T->lock),
> +		    srcu_read_unlock_fast(_T->lock, _T->scp),
> +		    struct srcu_ctr __percpu *scp)
> +
>  DEFINE_LOCK_GUARD_1(srcu_fast_notrace, struct srcu_struct,
>  		    _T->scp = srcu_read_lock_fast_notrace(_T->lock),
>  		    srcu_read_unlock_fast_notrace(_T->lock, _T->scp),


