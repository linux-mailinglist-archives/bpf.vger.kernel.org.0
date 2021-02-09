Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1ACC3144B6
	for <lists+bpf@lfdr.de>; Tue,  9 Feb 2021 01:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbhBIAOB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Feb 2021 19:14:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbhBIAN4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Feb 2021 19:13:56 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD2DC061786
        for <bpf@vger.kernel.org>; Mon,  8 Feb 2021 16:13:15 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id f20so3450842ioo.10
        for <bpf@vger.kernel.org>; Mon, 08 Feb 2021 16:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Fe+y9pZY3NRHqBpGSHuyrgHsj4ZHTbVB5p2fxahRQWk=;
        b=Q6DaEqx4A+iBVy7YRMlaUyyXnb+L45lTvR1BvL+b4ESejICeM/vwlwo4HuII997S0M
         X6BYdHwWYISSV4mLTarvF0jBVCg1JcuUb45eQPTsZ5rX5lhiOF4gJSZlntZfIfAkDJFx
         s+veA3H9159YWwlkCqjs1s2DW5yvFMcdL1+0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Fe+y9pZY3NRHqBpGSHuyrgHsj4ZHTbVB5p2fxahRQWk=;
        b=ZjXTqvIo/ekYQ5YhJN2yWkZyWA8DOLgDwxzmPYJCOiFIzzXLChtBc0vZ5/wuJwz+C2
         tbrJrZrDVQg5LIJnRDR/aLmB6Fqzs1RF8DHKESP4ArBETALbYVwGbu+aAJp3HZ2AvJNv
         reS0eilRZd/o2gosrAKCDlAZ4JmpE1EWseF8PmZ9ePP1rW1BRTedpPjnW5+uc3BDyegZ
         kO8oA6GiCCqjWSiEz6N2KGzLX2TWh11KB7psksEOaZOQ3hqlp/C22ddGzN//qplFoAcz
         NeaEapB48IdWO43VlSj13f5YZkNN/tXWVfKN5YKfTJmnrHYgCt+v2WNoXFdRW4dhN+Vj
         KaWA==
X-Gm-Message-State: AOAM532SVnwWG4CjKIYbbqeefO8OCE+GwTb6hEKzWqF+WFSTwgQBvuFb
        CO5aPKazrD4okneQlmxT+Sbgdw==
X-Google-Smtp-Source: ABdhPJwUrZMKcMXsTpO7CvtbHQefSTAqW5Gye4EmU10Oo/d/85AWx/zdCuVC1ggD7yLwc9AcF9FFog==
X-Received: by 2002:a5d:9717:: with SMTP id h23mr17219731iol.4.1612829594800;
        Mon, 08 Feb 2021 16:13:14 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id l7sm9655945ilq.26.2021.02.08.16.13.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 16:13:14 -0800 (PST)
Subject: Re: [PATCH] selftests/seccomp: Accept any valid fd in
 user_notification_addfd
To:     Seth Forshee <seth.forshee@canonical.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210128161721.99150-1-seth.forshee@canonical.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <ff36fb27-5b6c-cecb-7661-fab83fdbf66a@linuxfoundation.org>
Date:   Mon, 8 Feb 2021 17:13:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210128161721.99150-1-seth.forshee@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/28/21 9:17 AM, Seth Forshee wrote:
> This test expects fds to have specific values, which works fine
> when the test is run standalone. However, the kselftest runner
> consumes a couple of extra fds for redirection when running
> tests, so the test fails when run via kselftest.
> 
> Change the test to pass on any valid fd number.
> 
> Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
> ---
>   tools/testing/selftests/seccomp/seccomp_bpf.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
> index 26c72f2b61b1..9338df6f4ca8 100644
> --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> @@ -4019,18 +4019,14 @@ TEST(user_notification_addfd)
>   
>   	/* Verify we can set an arbitrary remote fd */
>   	fd = ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD, &addfd);
> -	/*
> -	 * The child has fds 0(stdin), 1(stdout), 2(stderr), 3(memfd),
> -	 * 4(listener), so the newly allocated fd should be 5.
> -	 */
> -	EXPECT_EQ(fd, 5);
> +	EXPECT_GE(fd, 0);
>   	EXPECT_EQ(filecmp(getpid(), pid, memfd, fd), 0);
>   
>   	/* Verify we can set an arbitrary remote fd with large size */
>   	memset(&big, 0x0, sizeof(big));
>   	big.addfd = addfd;
>   	fd = ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD_BIG, &big);
> -	EXPECT_EQ(fd, 6);
> +	EXPECT_GE(fd, 0);
>   
>   	/* Verify we can set a specific remote fd */
>   	addfd.newfd = 42;
> 

Here is my Ack if Kees wants to take it through seccomp.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

