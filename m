Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C17AF456198
	for <lists+bpf@lfdr.de>; Thu, 18 Nov 2021 18:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234136AbhKRRkF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Nov 2021 12:40:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233940AbhKRRkF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Nov 2021 12:40:05 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5AB9C06173E
        for <bpf@vger.kernel.org>; Thu, 18 Nov 2021 09:37:04 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id u17so5872566plg.9
        for <bpf@vger.kernel.org>; Thu, 18 Nov 2021 09:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=y6JG8t+9/4oW2UNmN7dKbz4GRgFS2eQMvm+xiLNfXHc=;
        b=e4Wjrj7DLSd4a2YD6Nm6tCYLhb+dDkXTgVSPv5j8hlt2HW3kihvhx9KMbj3m30tihB
         OtrrQmz4iEVmErJyMO7QQgD/Dv1Q+gjYoiEv+qNiPVDAjaIykVmEE28y9jVTra6Hf1Af
         r0voEroSpcHGkunCrJ1o6s/wdGcMOXBjlJOe8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y6JG8t+9/4oW2UNmN7dKbz4GRgFS2eQMvm+xiLNfXHc=;
        b=tkH7+XTfvd7lcenog5PIZ2odUTqhGbsBMGZRY9zM9ctqqg76lKxD+Y2dOhLQm4uI8U
         bmQ/qZ1CNs3sqATOIgYMuLz0BhFvfVb28MQDlHzAmUtOHUwGsQg7mKUIGUZGJLkEjQX5
         pOKj03us1VAZgxwWYvkEOtAZkQCW93L8tMskZAE2nZz+ihzS9R6wDNhHbdRKEfERiXND
         W6fE3q68GcAyq07AmRyay6hxrVo0KyQhMrBWh4PRNzUuOjOfko6REP9iZo06Rbio7+h0
         qLKM6rmaPSOnqRyq3HMOrSZho6i5+g7Qys4/l5tKAcvYt9Wf8GH4Qf5cCLSfI3zZQsnb
         TspQ==
X-Gm-Message-State: AOAM532eOd0flzZ2NPfPlpUDAvUlLYj3PlRJ3n7qDxezj6NwMOYwjrf1
        hiW2j8+6XqThoU8lLc1kRC100g==
X-Google-Smtp-Source: ABdhPJwz/SCMC1A/H+aQ5Qi8UQ+2A92EEqkr1i9U9wbEjc2GAiyfw6LUpHMj9IhIWbrkaDafzAmexA==
X-Received: by 2002:a17:902:7797:b0:143:88c3:7ff1 with SMTP id o23-20020a170902779700b0014388c37ff1mr67380354pll.22.1637257024390;
        Thu, 18 Nov 2021 09:37:04 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j18sm221300pgi.39.2021.11.18.09.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 09:37:04 -0800 (PST)
Date:   Thu, 18 Nov 2021 09:37:03 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/seccomp: fix check of fds being assigned
Message-ID: <202111180933.BE5101720@keescook>
References: <20211115165227.101124-1-andrea.righi@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115165227.101124-1-andrea.righi@canonical.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 15, 2021 at 05:52:27PM +0100, Andrea Righi wrote:
> There might be an arbitrary free open fd slot when we run the addfd
> sub-test, so checking for progressive numbers of file descriptors
> starting from memfd is not always a reliable check and we could get the
> following failure:
> 
>   #  RUN           global.user_notification_addfd ...
>   # seccomp_bpf.c:3989:user_notification_addfd:Expected listener (18) == nextfd++ (9)

What injected 9 extra fds into this test?

>   # user_notification_addfd: Test terminated by assertion
> 
> Simply check if memfd and listener are valid file descriptors and start
> counting for progressive file checking with the listener fd.

Hm, so I attempted to fix this once already:
93e720d710df ("selftests/seccomp: More closely track fds being assigned")
so I'm not sure the proposed patch really improves it in the general
case.

> Fixes: 93e720d710df ("selftests/seccomp: More closely track fds being assigned")
> Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
> ---
>  tools/testing/selftests/seccomp/seccomp_bpf.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
> index d425688cf59c..4f37153378a1 100644
> --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> @@ -3975,18 +3975,17 @@ TEST(user_notification_addfd)
>  	/* There may be arbitrary already-open fds at test start. */
>  	memfd = memfd_create("test", 0);
>  	ASSERT_GE(memfd, 0);
> -	nextfd = memfd + 1;
>  
>  	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
>  	ASSERT_EQ(0, ret) {
>  		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
>  	}
>  
> -	/* fd: 4 */
>  	/* Check that the basic notification machinery works */
>  	listener = user_notif_syscall(__NR_getppid,
>  				      SECCOMP_FILTER_FLAG_NEW_LISTENER);
> -	ASSERT_EQ(listener, nextfd++);
> +	ASSERT_GE(listener, 0);
> +	nextfd = listener + 1;

e.g. if there was a hole in the fd map for memfd, why not listener too?

Should the test dup2 memfd up to fd 100 and start counting there or
something? What is the condition that fills the fds for this process?

-Kees

>  
>  	pid = fork();
>  	ASSERT_GE(pid, 0);
> -- 
> 2.32.0
> 

-- 
Kees Cook
