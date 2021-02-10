Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85D18315B62
	for <lists+bpf@lfdr.de>; Wed, 10 Feb 2021 01:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbhBJAhW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Feb 2021 19:37:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233731AbhBJAdw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Feb 2021 19:33:52 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8C3C06174A
        for <bpf@vger.kernel.org>; Tue,  9 Feb 2021 16:33:12 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id x9so248916plb.5
        for <bpf@vger.kernel.org>; Tue, 09 Feb 2021 16:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=W9BJoRdCc8YZnOo7oaJ+mST3GsJkGFlQgGwy1YFljFo=;
        b=QaMnQciGBp+PwMsVjqHJq1hNWlQ7kaL1APi3yZbWKY3k5Twk/UGPUmX7LfAqVmQ+bx
         0j7SCOROogYatOy05lCNrI3Bx10ArTee6SMJFPXAlLXxqVlmDVLiW5eTpUGreId95J5E
         Ng9orIM39lQ8Ml+G8VY8H8j7ACYZ5+Rvh1tMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W9BJoRdCc8YZnOo7oaJ+mST3GsJkGFlQgGwy1YFljFo=;
        b=BAif+LXWfHoZl1dRMryFnbbyOrfH4xOsIRppvS5DdRbAqdjQyuE9dQMLh7R4bjgeju
         UZNgubbw8mfrpNcgQgPoCkpc08P6bAToCJl+3A6NHDAtEsPblzE7Q/dloWOfudFxJ/mk
         Jo4nNf3eoMuxrVKuP5Y3P29EwzNu7aDwxRvFjV+lZlM6XOPuLUFHagIBRG3MQ6KBxQ0n
         jcmX1AIJ9tnaoFPciqCKfCLDdUdme3ikPHT5H+7Jrbqms4LuzdOQdatwS2s+4yLvMvZd
         cP9TMzo9+GdPiTUgci1nvqe4hNNSfduueNr9j381sk34aHsL0A6DGQf2/VoL5VIqeb8G
         08PQ==
X-Gm-Message-State: AOAM530Ad5fs71b2wMSbFE+4muyO1ULtVBEmTegJtK+Tw7U24u9AIepU
        3qsLefWvYRnupP2hfSfGx1AmxA==
X-Google-Smtp-Source: ABdhPJx6ORN//J1stbfWGHNujgSBkXvMha9uuYPOQCCAGGQdZIn3a45ciNO1XqWRaiA3FwTI7a00aQ==
X-Received: by 2002:a17:90a:5403:: with SMTP id z3mr495324pjh.198.1612917192393;
        Tue, 09 Feb 2021 16:33:12 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n142sm97479pfd.82.2021.02.09.16.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 16:33:11 -0800 (PST)
Date:   Tue, 9 Feb 2021 16:33:10 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Seth Forshee <seth.forshee@canonical.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/seccomp: Accept any valid fd in
 user_notification_addfd
Message-ID: <202102091632.D5E0100A@keescook>
References: <20210128161721.99150-1-seth.forshee@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210128161721.99150-1-seth.forshee@canonical.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 28, 2021 at 10:17:21AM -0600, Seth Forshee wrote:
> This test expects fds to have specific values, which works fine
> when the test is run standalone. However, the kselftest runner
> consumes a couple of extra fds for redirection when running
> tests, so the test fails when run via kselftest.
> 
> Change the test to pass on any valid fd number.
> 
> Signed-off-by: Seth Forshee <seth.forshee@canonical.com>

Thanks!

Acked-by: Kees Cook <keescook@chromium.org>

I'll snag this if Shuah doesn't first. :)

-Kees

> ---
>  tools/testing/selftests/seccomp/seccomp_bpf.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
> index 26c72f2b61b1..9338df6f4ca8 100644
> --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> @@ -4019,18 +4019,14 @@ TEST(user_notification_addfd)
>  
>  	/* Verify we can set an arbitrary remote fd */
>  	fd = ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD, &addfd);
> -	/*
> -	 * The child has fds 0(stdin), 1(stdout), 2(stderr), 3(memfd),
> -	 * 4(listener), so the newly allocated fd should be 5.
> -	 */
> -	EXPECT_EQ(fd, 5);
> +	EXPECT_GE(fd, 0);
>  	EXPECT_EQ(filecmp(getpid(), pid, memfd, fd), 0);
>  
>  	/* Verify we can set an arbitrary remote fd with large size */
>  	memset(&big, 0x0, sizeof(big));
>  	big.addfd = addfd;
>  	fd = ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD_BIG, &big);
> -	EXPECT_EQ(fd, 6);
> +	EXPECT_GE(fd, 0);
>  
>  	/* Verify we can set a specific remote fd */
>  	addfd.newfd = 42;
> -- 
> 2.29.2
> 

-- 
Kees Cook
