Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD2B82B70F4
	for <lists+bpf@lfdr.de>; Tue, 17 Nov 2020 22:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725823AbgKQVdp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Nov 2020 16:33:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgKQVdo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Nov 2020 16:33:44 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBC9C0613CF
        for <bpf@vger.kernel.org>; Tue, 17 Nov 2020 13:33:44 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id v12so18151363pfm.13
        for <bpf@vger.kernel.org>; Tue, 17 Nov 2020 13:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hUaB1zwScjx73jhxVMuBCb5j2bh6ePTktk1ke7nr9rk=;
        b=JFYvqSNqyi4WhfbIp8cznUcs2B9EvtWy2hnInFGybxvfY79lwudK2stuMO8nvlv4XK
         dUr06/LEkH+jmcdsoS2Ya6OzOxRiYK8Z+KmTEE5w3TwzgOUuXmVguB/estmpbHKih0T7
         tVbw6PH7wSritwPoPqrt8evxWiu5nvTInDgpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hUaB1zwScjx73jhxVMuBCb5j2bh6ePTktk1ke7nr9rk=;
        b=YwAFsYm+llpVytyWALbTg9q6ljmRXpBM5k9ZxFbofLDGhUTiP2i7bU2tVRFukCQWuc
         Y1BqbYk0CBDP5bhYysS21md2EPw6nZ++z7GlByWXtUlIN2aNejC0tZDUesDoq/pGy/Dk
         Qdu1amIKIpGIcZlj6dRXXSxzI/LbzWCMlwB8DBMtEa19lt3DPoB0VH6jAq8y2Xpvj1OL
         cTHN5pb+ImlhCCgafud5fJvY9SoOr/p9OsfPuEuvYA9t91Rr8P8BHZnVPl9jyu/eIbgt
         g0hQ4nqxW8KRiLpStqitpHu09HpaGyoEH+48IR1PlpnFqE3Wut1b8sRTe+toOkOxSqe/
         C9yA==
X-Gm-Message-State: AOAM530snInrQposqOAMRdgZNybKWo9ruHKOTnSwgumwdkqqXGHt6QRH
        uJ5RDMqlJulb/wYofiyrY+va2w==
X-Google-Smtp-Source: ABdhPJzFakl4956d7dKMtPc85C9GfV9iMBAYJF5OBe+F6BC+H4Lh6E/Jlr0KWJRdwKJeGq67ZTPxXA==
X-Received: by 2002:a63:6c81:: with SMTP id h123mr1073673pgc.401.1605648824004;
        Tue, 17 Nov 2020 13:33:44 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a3sm3659073pgq.53.2020.11.17.13.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 13:33:43 -0800 (PST)
Date:   Tue, 17 Nov 2020 13:33:42 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Matt Mullins <mmullins@mmlx.us>,
        Ingo Molnar <mingo@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH] tracepoint: Do not fail unregistering a probe due to
 memory allocation
Message-ID: <202011171330.94C6BA7E93@keescook>
References: <20201116175107.02db396d@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116175107.02db396d@gandalf.local.home>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 16, 2020 at 05:51:07PM -0500, Steven Rostedt wrote:
> [ Kees, I added you because you tend to know about these things.
>   Is it OK to assign a void func(void) that doesn't do anything and returns
>   nothing to a function pointer that could be call with parameters? We need
>   to add stubs for tracepoints when we fail to allocate a new array on
>   removal of a callback, but the callbacks do have arguments, but the stub
>   called does not have arguments.
> 
>   Matt, Does this patch fix the error your patch was trying to fix?
> ]

As I think got discussed in the thread, what you had here wouldn't work
in a CFI build if the function prototype of the call site and the
function don't match. (Though I can't tell if .func() is ever called?)

i.e. .func's prototype must match tp_stub_func()'s.

-- 
Kees Cook
