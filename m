Return-Path: <bpf+bounces-47613-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 368259FC6A1
	for <lists+bpf@lfdr.de>; Wed, 25 Dec 2024 23:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60D5D1629BB
	for <lists+bpf@lfdr.de>; Wed, 25 Dec 2024 22:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC171BC069;
	Wed, 25 Dec 2024 21:59:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2874D14D29B;
	Wed, 25 Dec 2024 21:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735163996; cv=none; b=Z6q/yT8UfOG/iHUfIAFc0SCoUDRDNu+DzW8bjEC6HZpBjY/6pEsErBFCJE77zjFWzvuPEyHrZQF4Ygw3nh0vWf2DhetafaV/AMUf6UTaJGV7S0U7psKsJ1pbJMYodH0bdP+IG8EIM6t73aCMtzpFps3h92Rdg87Ajb4WGtco5t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735163996; c=relaxed/simple;
	bh=qpPGukD0lWUd8f7aIzu9seGNNiARwpK8dZpGs6l4AiA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BMJKluvuxb11RcsNDpMRe+RI+yz/ULfbzSd7svngrr0wBuwwZ0YCOREsdRiQELe/OFfxWy/yPMqUuCZ+s+Vww/fN5600La2QmfiQEDdP90MaFaLUuXZN/wnVpVSHAmfyQ38B+cNFanEhy77RRr7EiOnOdM4sBbHpHMumTY4vPLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 335C9C4CECD;
	Wed, 25 Dec 2024 21:59:54 +0000 (UTC)
Date: Wed, 25 Dec 2024 16:59:54 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Sven Schnelle <svens@linux.ibm.com>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>, Donglin
 Peng <dolinux.peng@gmail.com>, Zheng Yejian <zhengyejian@huaweicloud.com>,
 bpf@vger.kernel.org
Subject: Re: [PATCH v2 1/4] ftrace: Add print_function_args()
Message-ID: <20241225165954.35bcce5f@batman.local.home>
In-Reply-To: <20241225221555.092d66edb15d7693646c7945@kernel.org>
References: <20241223201347.609298489@goodmis.org>
	<20241223201541.898496620@goodmis.org>
	<20241225221555.092d66edb15d7693646c7945@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Dec 2024 22:15:55 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> >  
> > +config FUNCTION_TRACE_ARGS
> > +       bool
> > +	depends on HAVE_FUNCTION_ARG_ACCESS_API
> > +	depends on DEBUG_INFO_BTF  
> 
> For using the BTF APIs, we also needs BPF_SYSCALL (DEBUG_INFO_BTF just
> compiles the BTF info into the kernel binary.)
> 
> Others looks good to me.

Hmm, I removed it due to this feedback:

  https://lore.kernel.org/linux-trace-kernel/20240909225614.4f6d022e58f1276113c8492b@kernel.org/


> 
> Revewied-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

-- Steve

