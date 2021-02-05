Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81FA8311549
	for <lists+bpf@lfdr.de>; Fri,  5 Feb 2021 23:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbhBEW1w (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Feb 2021 17:27:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbhBEOWY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Feb 2021 09:22:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51B8C06121C;
        Fri,  5 Feb 2021 07:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=p8yliEbMqP3V4TzvseSTLJIbhTkc7zBiOssiRDK3Nzk=; b=uwYQHBNsUi+sKrXn/Gp+6afzBg
        Xns98RH8bmqXcEhJIa8XRSVjoGdo4DpAwHn3yNX/rJ73sh+V204eiqAmvwGalKgqkQAghHOGKBwjN
        R4Ben6HR849Yd+CPx466InoUjG3/6v6zyhQdt0gzl9V2xt3B9iLCLpEtK0F38gpMavuyO5bW7W0jt
        ZibdfTAwuLyk6woueT/BIt9iMEdBu7xEkgsboGf0JRhKjXh+ePIbupKU1bJQ4IarZyfibFDRNL4IY
        Cnt1B3Bg1gfsBKHmBd4wasZGMrJSXKg5kQYzQKEMUjTTz9CXlZ2GUK1kx+VIXf9YdBZKFlhXoNpyv
        sboo4gUw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l83DR-002Sec-9G; Fri, 05 Feb 2021 15:40:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0DB8E3012DF;
        Fri,  5 Feb 2021 16:40:11 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EAD3D2BC43F6C; Fri,  5 Feb 2021 16:40:10 +0100 (CET)
Date:   Fri, 5 Feb 2021 16:40:10 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Brendan Jackman <jackmanb@chromium.org>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Paul Renauld <renauld@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>, pjt@google.com,
        jannh@google.com, rafael.j.wysocki@intel.com,
        keescook@chromium.org, thgarnie@chromium.org, kpsingh@google.com,
        paul.renauld.epfl@gmail.com, Brendan Jackman <jackmanb@google.com>,
        rostedt@goodmis.org
Subject: Re: [RFC] security: replace indirect calls with static calls
Message-ID: <YB1m2i6bUM0LO5wS@hirez.programming.kicks-ass.net>
References: <20200820164753.3256899-1-jackmanb@chromium.org>
 <20210205150926.GA12608@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205150926.GA12608@localhost>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 05, 2021 at 10:09:26AM -0500, Mathieu Desnoyers wrote:
> Then we should be able to generate the following using static keys as a
> jump table and N static calls:
> 
>   jump <static key label target>
> label_N:
>   stack setup
>   call
> label_N-1:
>   stack setup
>   call
> label_N-2:
>   stack setup
>   call
>   ...
> label_0:
>   jump end
> label_fallback:
>   <iteration and indirect calls>
> end:
> 
> So the static keys would be used to jump to the appropriate label (using
> a static branch, which has pretty much 0 overhead). Static calls would
> be used to implement each of the calls.
> 
> Thoughts ?

At some point I tried to extend the static_branch infra to do multiple
targets and while the low level plumbing is trivial, I ran into trouble
trying to get a sane C level API for it.


