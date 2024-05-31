Return-Path: <bpf+bounces-31038-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0345A8D65CB
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 17:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 932F31F21A5E
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 15:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986EC158A28;
	Fri, 31 May 2024 15:31:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CA739FF3;
	Fri, 31 May 2024 15:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717169487; cv=none; b=XOTibFL6ba3umTM4/Qb0+ubrcSK2tx297wL1b8619btJDLi23Ss8vod1DF922tuOZo2jyEf8LfoPwOBGvMWSwtTB0UKK/eZRNAZoGsfUH5sdH4dzeAMj3w9KNWQ0KYMae3t2VD92tJh3pAApldxCKUPaELcaEXVZ6nddRxcWHE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717169487; c=relaxed/simple;
	bh=wb1cOchvcOujs9HWcw7r/ZrIUMH4fHWuktSZkjSAwAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iwNtD4RhyRW0yjyAzAjMb8qB1VuGonUFFeUZwOvUU8D/1uBwtPWvgRYUQFA7JXCEt0kthWjMVjGLBG9htgc8LVhfIml0QAJKGdptfB3pXj6oP6AvC6e5e+XOnkHEvmihfUqZuwKyUvveuP9+QeXOz9w3RiwCkDlrKTg1tqwxG1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 559941424;
	Fri, 31 May 2024 08:31:49 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A56163F641;
	Fri, 31 May 2024 08:31:21 -0700 (PDT)
Date: Fri, 31 May 2024 16:31:14 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Akinobu Mita <akinobu.mita@gmail.com>, Christoph Lameter <cl@linux.com>,
	David Rientjes <rientjes@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Jiri Olsa <jolsa@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/4] static key support for error injection functions
Message-ID: <ZlntQn-a7Ycko_j5@J2N7QTR9R3>
References: <20240531-fault-injection-statickeys-v1-0-a513fd0a9614@suse.cz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531-fault-injection-statickeys-v1-0-a513fd0a9614@suse.cz>

Hi,

On Fri, May 31, 2024 at 11:33:31AM +0200, Vlastimil Babka wrote:
> Incomplete, help needed from ftrace/kprobe and bpf folks.

> - the generic error injection using kretprobes with
>   override_function_with_return is handled in patch 2. The
>   ALLOW_ERROR_INJECTION() annotation is extended so that static key
>   address can be passed, and the framework controls it when error
>   injection is enabled or disabled in debugfs for the function.
> 
> There are two more users I know of but am not familiar enough to fix up
> myself. I hope people that are more familiar can help me here.
> 
> - ftrace seems to be using override_function_with_return from
>   #define ftrace_override_function_with_return but I found no place
>   where the latter is used. I assume it might be hidden behind more
>   macro magic? But the point is if ftrace can be instructed to act like
>   an error injection, it would also have to use some form of metadata
>   (from patch 2 presumably?) to get to the static key and control it.

I don't think you've missed anything; nothing currently uses
ftrace_override_function_with_return(). I added that in commit:

  94d095ffa0e16bb7 ("ftrace: abstract DYNAMIC_FTRACE_WITH_ARGS accesses")

... so that it was possible to do anything that was possible with
FTRACE_WITH_REGS and/or kprobes, under the expectation that we might
want to move fault injection and BPF probes over to fprobes in future,
as ftrace/fprobes is generally faster than kprobes (e.g. for
architectures that can't do KPROBES_ON_FTRACE or OPTPROBES).

That's just the mechanism for the handler to use; I'd expect whatever
registered the handler to be responsible for flipping the static key,
and I don't think anything needs to change within ftrace itself.

>   If ftrace can only observe the function being called, maybe it
>   wouldn't be wrong to just observe nothing if the static key isn't
>   enabled because nobody is doing the fault injection?

Yep, that sounds right to me.

Mark.

