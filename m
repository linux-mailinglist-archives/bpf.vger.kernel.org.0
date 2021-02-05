Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE273113E9
	for <lists+bpf@lfdr.de>; Fri,  5 Feb 2021 22:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbhBEVnQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Feb 2021 16:43:16 -0500
Received: from mail.efficios.com ([167.114.26.124]:47352 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232887AbhBEO74 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Feb 2021 09:59:56 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 474922F508D;
        Fri,  5 Feb 2021 10:09:28 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id I1BKq0K46zNG; Fri,  5 Feb 2021 10:09:27 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id C7ACB2F47DC;
        Fri,  5 Feb 2021 10:09:27 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com C7ACB2F47DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1612537767;
        bh=Ck2u+dtqWB3vlWMCLhAAtvbRHCvY9B7KyJIHvTSoVLw=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Dg9QxwlDor6mV+Sd/7v2A2FNlCVCqONKIDCfJ5pPW985k1yaeewq+nbNNTD4pUp3t
         TC9ObNTj2NTsybUWlMO64/79q8pQwpJq9P6KTE2v7wCFIrSAEnFP5NZoQc1APdG91g
         W+tVqCDNKPbwPKtnKwaP0hUpyVkSPGArjzUSVmTDYroEfSK5CdkcxT9gjOS4o/VEaD
         rg+PKRjalZaZaWG+vQo8R/hQ0erCl879OYg4AcBoljX7FI4dhA9VV6S786L7HNgWy5
         Im3dWaO3fFMZMMcra/wSdT3T4n0A4cKocH3EU/qkXPf06nJT4EWycVnYG2hsflgS1C
         d1kALGNJXTP0A==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9R2Zsrk1ft6s; Fri,  5 Feb 2021 10:09:27 -0500 (EST)
Received: from localhost (unknown [192.222.236.144])
        by mail.efficios.com (Postfix) with ESMTPSA id 6ECB52F4D5A;
        Fri,  5 Feb 2021 10:09:27 -0500 (EST)
Date:   Fri, 5 Feb 2021 10:09:26 -0500
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Brendan Jackman <jackmanb@chromium.org>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Paul Renauld <renauld@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>, pjt@google.com,
        jannh@google.com, peterz@infradead.org, rafael.j.wysocki@intel.com,
        keescook@chromium.org, thgarnie@chromium.org, kpsingh@google.com,
        paul.renauld.epfl@gmail.com, Brendan Jackman <jackmanb@google.com>,
        mathieu.desnoyers@efficios.com, rostedt@goodmis.org
Subject: Re: [RFC] security: replace indirect calls with static calls
Message-ID: <20210205150926.GA12608@localhost>
References: <20200820164753.3256899-1-jackmanb@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820164753.3256899-1-jackmanb@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 20-Aug-2020 06:47:53 PM, Brendan Jackman wrote:
> From: Paul Renauld <renauld@google.com>
> 
> LSMs have high overhead due to indirect function calls through
> retpolines. This RPC proposes to replace these with static calls [1]
> instead.
> 
> This overhead is especially significant for the "bpf" LSM which supports
> the implementation of LSM hooks with eBPF programs (security/bpf)[2]. In
> order to facilitate this, the "bpf" LSM provides a default nop callback for
> all LSM hooks. When enabled, the "bpf", LSM incurs an unnecessary /
> avoidable indirect call to this nop callback.
> 
> The performance impact on a simple syscall eventfd_write (which triggers
> the file_permission hook) was measured with and without "bpf" LSM
> enabled. Activating the LSM resulted in an overhead of 4% [3].
> 
> This overhead prevents the adoption of bpf LSM on performance critical
> systems, and also, in general, slows down all LSMs.
> 
> Currently, the LSM hook callbacks are stored in a linked list and
> dispatched as indirect calls. Using static calls can remove this overhead
> by replacing all indirect calls with direct calls.
> 
> During the discussion of the "bpf" LSM patch-set it was proposed to special
> case BPF LSM to avoid the overhead by using static keys. This was however
> not accepted and it was decided to [4]:
> 
> - Not special-case the "bpf" LSM.
> - Implement a general solution benefitting the whole LSM framework.
> 
> This is based on the static call branch [5].

Hi!

So I reviewed this quickly, and hopefully my understanding is correct.
AFAIU, your approach is limited to scenarios where the callbacks are
known at compile-time. It also appears to add the overhead of a
switch/case for every function call on the fast-path.

I am the original author of the tracepoint infrastructure in the Linux
kernel, which also needs to iterate on an array of callbacks. Recently,
Steven Rostedt pushed a change which accelerates the single-callback
case using static calls to reduce retpoline mitigation overhead, but I
would prefer if we could accelerate the multiple-callback case as well.
Note that for tracepoints, the callbacks are not known at compile-time.

This is where I think we could come up with a generic solution that
would fit both LSM and tracepoint use-cases.

Here is what I have in mind. Let's say we generate code to accelerate up
to N calls, and after that we have a fallback using indirect calls.

Then we should be able to generate the following using static keys as a
jump table and N static calls:

  jump <static key label target>
label_N:
  stack setup
  call
label_N-1:
  stack setup
  call
label_N-2:
  stack setup
  call
  ...
label_0:
  jump end
label_fallback:
  <iteration and indirect calls>
end:

So the static keys would be used to jump to the appropriate label (using
a static branch, which has pretty much 0 overhead). Static calls would
be used to implement each of the calls.

Thoughts ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
