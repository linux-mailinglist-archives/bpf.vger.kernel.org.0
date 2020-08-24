Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D355325010D
	for <lists+bpf@lfdr.de>; Mon, 24 Aug 2020 17:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgHXPGV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Aug 2020 11:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbgHXPFb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Aug 2020 11:05:31 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A607FC0617AA
        for <bpf@vger.kernel.org>; Mon, 24 Aug 2020 08:05:16 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id t2so8437287wma.0
        for <bpf@vger.kernel.org>; Mon, 24 Aug 2020 08:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4Z9CfRsQ0JPDJK+OdpY56vYSFlw0MvtWCYo+D9zzr0o=;
        b=lB8woOsvvYhCqqAhBrrOI4RyghVGWXTQFIz7QP/geKRTgxJ5Ydbnf0ULekEb2fnx6E
         LIx5ZXOroEf5QkkzXGFUuatWpWzKU8BXTOBLol8vcK0GyEzvqLzwcxlZnouQiPxO3vQ9
         YGWWtTbmSO/FTFZTk4MxFuHaMnbSLcTjsA1ixnxCiRwMl/N9Pfkdkvi4wlAN5mU6s9lB
         gfGU+rWbIdYtgAAD952agaykme1dVHqFB5Gh+HyTuc0ShwRZSGX5SVSVxfFojiNsdqwW
         dbYPzTJBm3+Wps1nFdfCfuJTK4Z1wFTBwlBSW4yF/FROXrF4h55RK2I5C2uAGtuCIbGW
         1k+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4Z9CfRsQ0JPDJK+OdpY56vYSFlw0MvtWCYo+D9zzr0o=;
        b=tcxMCyB24BBFflfi4RLAp0Atj7fzI+VD0wwc8BrwN2BPlRQ2wS8z1g9sN6hEw+hqKb
         WRer3Jn/h7TCgNZUfuIReVkO5VlawASszkm1f/LdhF+f0tg7e60sSMyDzWLZh1I9cw9M
         puGO2ZToMzm0A9lLl/b/4PErKzfcwYEomcjCbrJwfMg0BH30B3P5/3hVit///YCOEX7e
         5D2sbb/gRKkZlpGO7KsqEJlnxNzX7ylof7z/4ncf+BErIQTtOIhvFAqLr5M6RbpJbV7j
         bzD91Be+dGYmqlo8Q0lS/qvCfE/5g0vOwdQq8yyDEr/JTcFi1d/BRsw/r6YsHItV38Zy
         KDzQ==
X-Gm-Message-State: AOAM531cBgDwMaWvFUOyMD4ozI3ratE8BLAtxIevYm6EUw1lBrm0i45j
        hKk5OHdSiqd30a6UoT1JM9yNag==
X-Google-Smtp-Source: ABdhPJz3KjGHHQA/f94TebnygpE4VIUsNqkOfejclgeosK32BVVg2F+4exTc1VOTgF6WyK7QdPxObw==
X-Received: by 2002:a7b:cd88:: with SMTP id y8mr5875966wmj.14.1598281509685;
        Mon, 24 Aug 2020 08:05:09 -0700 (PDT)
Received: from google.com ([2a00:79e0:42:204:1ea0:b8ff:fe80:839])
        by smtp.gmail.com with ESMTPSA id y13sm14526834wrn.48.2020.08.24.08.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 08:05:08 -0700 (PDT)
Date:   Mon, 24 Aug 2020 17:05:04 +0200
From:   Brendan Jackman <jackmanb@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>, pjt@google.com,
        Jann Horn <jannh@google.com>, rafael.j.wysocki@intel.com,
        thgarnie@chromium.org, KP Singh <kpsingh@google.com>,
        paul.renauld.epfl@gmail.com
Subject: Re: [RFC] security: replace indirect calls with static calls
Message-ID: <20200824150504.GA575149@google.com>
References: <20200820164753.3256899-1-jackmanb@chromium.org>
 <202008201435.97CF8296@keescook>
 <CA+i-1C0XEuWWRm5nMPWCzEPUao7rp5346Eotpt1A_S3Za3Wysw@mail.gmail.com>
 <20200824143344.GB3982@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824143344.GB3982@worktop.programming.kicks-ass.net>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 24, 2020 at 04:33:44PM +0200, Peter Zijlstra wrote:
> On Mon, Aug 24, 2020 at 04:09:09PM +0200, Brendan Jackman wrote:
> 
> > > > Why this trick with a switch statement? The table of static call is defined
> > > > at compile time. The number of hook callbacks that will be defined is
> > > > unknown at that time, and the table cannot be resized at runtime.  Static
> > > > calls do not define a conditional execution for a non-void function, so the
> > > > executed slots must be non-empty.  With this use of the table and the
> > > > switch, it is possible to jump directly to the first used slot and execute
> > > > all of the slots after. This essentially makes the entry point of the table
> > > > dynamic. Instead, it would also be possible to start from 0 and break after
> > > > the final populated slot, but that would require an additional conditional
> > > > after each slot.
> > >
> > > Instead of just "NOP", having the static branches perform a jump would
> > > solve this pretty cleanly, yes? Something like:
> > >
> > >         ret = DEFAULT_RET;
> > >
> > >         ret = A(args); <--- direct call, no retpoline
> > >         if ret != 0:
> > >                 goto out;
> > >
> > >         ret = B(args); <--- direct call, no retpoline
> > >         if ret != 0:
> > >                 goto out;
> > >
> > >         goto out;
> > >         if ret != 0:
> > >                 goto out;
> > >
> > > out:
> > >         return ret;
> > 
> > Hmm yeah that's a cool idea. This would either need to be implemented
> > with custom code-modification logic for the LSM hooks, or we'd need to
> > think of a way to express it in a sensible addition to the static_call
> > API. I do wonder if the latter could take the form of a generic system
> > for arrays of static calls.
> 
> So you basically want something like:
> 
> 	if (A[0] && (ret = static_call(A[0])(...)))
> 		return ret;
> 
> 	if (A[1] && (ret = static_call(A[1])(...)))
> 		return ret;
> 
> 	....
> 
> 	return ret;
> 
> Right? The problem with static_call_cond() is that we don't know what to
> do with the return value when !func, which is why it's limited to void
> return type.
> 
> You can however construct something like the above with a combination of
> static_branch() and static_call() though. It'll not be pretty, but it
> ought to work:
> 
> 	if (static_branch_likely(A[0].key)) {
> 		ret = static_call(A[0].call)(...);
> 		if (ret)
> 			return ret;
> 	}
> 
> 	...
> 
> 	return ret;
> 
Right. That's actually exactly what Paul's first implementation
looked like for call_int_hook. But we thought the switch thing was
easier to understand.

> 
> > It would also need to handle the fact that IIUC at the moment the last
> > static_call may be a tail call, so we'd be patching an existing jump
> > into a jump to a different target, I don't know if we can do that
> > atomically.
> 
> Of course we can, the static_call() series supports tail-calls just
> fine. In fact, patching jumps is far easier, it was patching call that
> was the real problem because it mucks about with the stack.
> 
OK great. I had a vague apprehension that we could only patch to or from
a NOP.
