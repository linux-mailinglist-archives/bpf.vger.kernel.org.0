Return-Path: <bpf+bounces-60927-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B16A6ADEE48
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 15:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F25D7AD7CB
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 13:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27D02EA734;
	Wed, 18 Jun 2025 13:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S62GXtaD"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2652EA72C;
	Wed, 18 Jun 2025 13:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750254416; cv=none; b=VgprZ5VHraexH9ZBGFZpetFywftaR5Ej8qqNCzM3VPYmZ2E1obXhVLYUh3m4nG60Czrwms65KdWbACO+C3O0KcqDrkBsLtGEjXQsDOZHbVyo2dJw4wd8YiFYKZxA0L1D/c8WPcuCRoRaNtfYjX689NTpXp6raAWbpt71OtGWP60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750254416; c=relaxed/simple;
	bh=Losyn9nm+aZwZ+6Ag2jILDFw7Orn8sAev+dIcg1/bvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gPqi5tsTkZb8ICPU+5/CVUAvpRCKVDv0iMjfLL8oZZs5/ZmN4NbOSTpgOwhRPgW2eLvTkakLpjrRIRkLTQhqQghchkCJHwq3f1N4SVbDxyUE0FvK/VsCogaw36FzA39kkFOB5KUF0lP+rxpHvHyv+StXD0KcJy7EQH3bUrN727Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=S62GXtaD; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nQfAjPcRHPaRXr9YZUZxCpH5t/zDnAeC5NrEv6EAiGE=; b=S62GXtaD7FXRPvUVz70nXR7XnN
	QMECWJWCUuNZASEE0MGUw7V3BMzwJu9X4dhXX7+OaY8d0HGPurwjeRD/0TSN0Vaywbl/ppsD92eHG
	6nPUYMEMN0KkSZ8echa50tDx6KLWLZpQwwHYBnH3AGvAQiHxCB9tV70tXNFM6BkPbPO6TGNeYLkYR
	IlYjJoMGXBP2Jh3S36SyVFsEobBQKGJXAWD6/XBI2k8AoiDreh0pw5XkJr7A36NPH/h8FtyP8Mhi+
	UhBYj5G0IhkgLB4f905tbYsaM0QBc1HUrhZxfUELUX6JTKJDv0feCUomAFNLi010bue3uoaGcJayU
	LNcvINeQ==;
Received: from 2001-1c00-8d82-d000-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d82:d000:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRt7j-00000003hLX-2fLK;
	Wed, 18 Jun 2025 13:46:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 63930307FB7; Wed, 18 Jun 2025 15:46:41 +0200 (CEST)
Date: Wed, 18 Jun 2025 15:46:41 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org, x86@kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrii Nakryiko <andrii@kernel.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v10 03/14] unwind_user: Add compat mode frame pointer
 support
Message-ID: <20250618134641.GJ1613376@noisy.programming.kicks-ass.net>
References: <20250611005421.144238328@goodmis.org>
 <20250611010428.261095906@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611010428.261095906@goodmis.org>

On Tue, Jun 10, 2025 at 08:54:24PM -0400, Steven Rostedt wrote:
> diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
> index 4fc550356b33..29e1f497a26e 100644
> --- a/kernel/unwind/user.c
> +++ b/kernel/unwind/user.c
> @@ -12,12 +12,32 @@ static struct unwind_user_frame fp_frame = {
>  	ARCH_INIT_USER_FP_FRAME
>  };
>  
> +static struct unwind_user_frame compat_fp_frame = {
> +	ARCH_INIT_USER_COMPAT_FP_FRAME
> +};
> +
>  static inline bool fp_state(struct unwind_user_state *state)
>  {
>  	return IS_ENABLED(CONFIG_HAVE_UNWIND_USER_FP) &&
>  	       state->type == UNWIND_USER_TYPE_FP;
>  }
>  
> +static inline bool compat_state(struct unwind_user_state *state)

Consistency would mandate this thing be called: compat_fp_state().

> +{
> +	return IS_ENABLED(CONFIG_HAVE_UNWIND_USER_COMPAT_FP) &&
> +	       state->type == UNWIND_USER_TYPE_COMPAT_FP;
> +}
> +
> +#define UNWIND_GET_USER_LONG(to, from, state)				\

Do we have to shout this?

> +({									\
> +	int __ret;							\
> +	if (compat_state(state))					\
> +		__ret = get_user(to, (u32 __user *)(from));		\
> +	else								\
> +		__ret = get_user(to, (unsigned long __user *)(from));	\
> +	__ret;								\
> +})
> +
>  int unwind_user_next(struct unwind_user_state *state)
>  {
>  	struct unwind_user_frame *frame;

