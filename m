Return-Path: <bpf+bounces-31077-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9D28D6CE3
	for <lists+bpf@lfdr.de>; Sat,  1 Jun 2024 01:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD4DF1F24BB3
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 23:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1CB12F392;
	Fri, 31 May 2024 23:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fT/YcguP"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6C381AB1
	for <bpf@vger.kernel.org>; Fri, 31 May 2024 23:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717198789; cv=none; b=Ypwk9YC+isH1pUzZjt4lEgJZHoNRdAjZMdjbxZDwcUWNFF5xu3wqmHl9lzqO32ihHJIH534keCuNHQ566xhUjEMG47MY7oJSMY57Ij/kFHzLplHEYTIvzIgiOxkFy0dadGB4OV2rWGOAi/N85uC6N5ff8cHkKEgOQyhwxNu7B+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717198789; c=relaxed/simple;
	bh=j3fan/vkii84V5n4yulJlipmYhcnKuTyRy5Xh8/wtYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jk1ttHeA0aq78+HJX9OkVFpRuyjpLGbceNV8ky0ohW8VCDbIovaj9yuRMqOLs/QVTnE1d/FNOnKQLirf0BcoM2+RGvyyeB2GiHx5pzJlXzE2E5qkqQEl/vq/C5ADfJR/9/o0JQ0E3sB2+7amRQxKkow+tCKsbdaY1YHjpUQiiHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fT/YcguP; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: vbabka@suse.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717198785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QLMB9tJ301/rLUk13wKnKotC95IcSNp342uZrlGl3Ns=;
	b=fT/YcguPRBykza/O/N6SplR+kYvMGw63MZgVRIRCV13FZWCvYkSzvNVC0+ZXn0PLFysf1f
	dLYXEikbM7zhhyE4cY31XbHpskmn1I7FcfH5F03lqHDAQijs0mi9LWdL1vY3tKUsvTEPSN
	gc6t+IllOKGxK+nxCEIMdV6Hx0lFd+w=
X-Envelope-To: akinobu.mita@gmail.com
X-Envelope-To: cl@linux.com
X-Envelope-To: rientjes@google.com
X-Envelope-To: ast@kernel.org
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: andrii@kernel.org
X-Envelope-To: naveen.n.rao@linux.ibm.com
X-Envelope-To: anil.s.keshavamurthy@intel.com
X-Envelope-To: davem@davemloft.net
X-Envelope-To: mhiramat@kernel.org
X-Envelope-To: rostedt@goodmis.org
X-Envelope-To: mark.rutland@arm.com
X-Envelope-To: jolsa@kernel.org
X-Envelope-To: 42.hyeyoo@gmail.com
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Date: Fri, 31 May 2024 16:39:38 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
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
	Steven Rostedt <rostedt@goodmis.org>,
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/4] static key support for error injection functions
Message-ID: <ZlpfuiLRKa7wGD9y@P9FQF9L96D.corp.robot.car>
References: <20240531-fault-injection-statickeys-v1-0-a513fd0a9614@suse.cz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240531-fault-injection-statickeys-v1-0-a513fd0a9614@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Fri, May 31, 2024 at 11:33:31AM +0200, Vlastimil Babka wrote:
> Incomplete, help needed from ftrace/kprobe and bpf folks.
> 
> As previously mentioned by myself [1] and others [2] the functions
> designed for error injection can bring visible overhead in fastpaths
> such as slab or page allocation, because even if nothing hooks into them
> at a given moment, they are noninline function calls regardless of
> CONFIG_ options since commits 4f6923fbb352 ("mm: make should_failslab
> always available for fault injection") and af3b854492f3
> ("mm/page_alloc.c: allow error injection").
> 
> Live patching their callsites has been also suggested in both [1] and
> [2] threads, and this is an attempt to do that with static keys that
> guard the call sites. When disabled, the error injection functions still
> exist and are noinline, but are not being called. Any of the existing
> mechanisms that can inject errors should make sure to enable the
> respective static key. I have added that support to some of them but
> need help with the others.

I think it's a clever idea and makes total sense!

> 
> - the legacy fault injection, i.e. CONFIG_FAILSLAB and
>   CONFIG_FAIL_PAGE_ALLOC is handled in Patch 1, and can be passed the
>   address of the static key if it exists. The key will be activated if the
>   fault injection probability becomes non-zero, and deactivated in the
>   opposite transition. This also removes the overhead of the evaluation
>   (on top of the noninline function call) when these mechanisms are
>   configured in the kernel but unused at the moment.
> 
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
> 
>   If ftrace can only observe the function being called, maybe it
>   wouldn't be wrong to just observe nothing if the static key isn't
>   enabled because nobody is doing the fault injection?
> 
> - bpftrace, as can be seen from the example in commit 4f6923fbb352
>   description. I suppose bpf is already aware what functions the
>   currently loaded bpf programs hook into, so that it could look up the
>   static key and control it. Maybe using again the metadata from patch 2,
>   or extending its own, as I've noticed there's e.g. BTF_ID(func,
>   should_failslab)
> 
> Now I realize maybe handling this at the k(ret)probe level would be
> sufficient for all cases except the legacy fault injection from Patch 1?
> Also wanted to note that by AFAIU by using the static_key_slow_dec/inc
> API (as done in patches 1/2) should allow all mechanisms to coexist
> naturally without fighting each other on the static key state, and also
> handle the reference count for e.g. active probes or bpf programs if
> there's no similar internal mechanism.
> 
> Patches 3 and 4 implement the static keys for the two mm fault injection
> sites in slab and page allocators. For a quick demonstration I've run a
> VM and the simple test from [1] that stresses the slab allocator and got
> this time before the series:
> 
> real    0m8.349s
> user    0m0.694s
> sys     0m7.648s
> 
> with perf showing
> 
>    0.61%  nonexistent  [kernel.kallsyms]  [k] should_failslab.constprop.0
>    0.00%  nonexistent  [kernel.kallsyms]  [k] should_fail_alloc_page                                                                                                                                                                                        ▒
> 
> And after the series
> 
> real    0m7.924s
> user    0m0.727s
> sys     0m7.191s

Is "user" increase a measurement error or it's real?

Otherwise, nice savings!

