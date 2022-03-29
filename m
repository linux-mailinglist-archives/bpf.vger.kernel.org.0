Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2EB4EB05B
	for <lists+bpf@lfdr.de>; Tue, 29 Mar 2022 17:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233601AbiC2PaC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Mar 2022 11:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238560AbiC2PaB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Mar 2022 11:30:01 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF7010B1
        for <bpf@vger.kernel.org>; Tue, 29 Mar 2022 08:28:16 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id 125so21389037iov.10
        for <bpf@vger.kernel.org>; Tue, 29 Mar 2022 08:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rbCfapO4NIDG1N5wWCt2gtNC01xY1MmMW/+32By2iZU=;
        b=DNeuoXSedKF6JFW4fZEpRDlhg3gtceUEhH8ds5WqdEbOGjU6iS92QdpByiCno6IM9W
         dLOVRK4SZKLZ2iFy9YJ2C+XrHT3OlyJ0plYeknoDqP/ts6HLxeqGSNxeNveokN07FQ8a
         A9M6kXDDGxDyriNL7ESSXXB7GR95ePKFf8lwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rbCfapO4NIDG1N5wWCt2gtNC01xY1MmMW/+32By2iZU=;
        b=65436K9tk4WfZENEcqHTO36G8T5bQqsyqvdDTiSZfauOL5wCv/YZdPspZWbk37GjQQ
         v7QYaj4IKdmhNG7R8fXl2Th/VdZbCvmJZ3+EfQAQeySO/QmigCjDEVHskcWEUNF/rbeQ
         +P2ja+ray0G57j5QEUREN4tzSHPH/d6VkqGXITCbRaed2Ojq1Oi9nSgzJQNSngPX4grE
         zXC2sm7vqEL3zzHn4moaTrKdMjF8ylHNykm91IzkhFIoQ4mMeRlD+BxSrNcb1FdCyLGa
         5189vTwwOYfL/ly8A4YZdzFhwNUSOXRiJfe6MYCuRArxow08gsDQBBafp9D1qBpeCgeb
         jOIg==
X-Gm-Message-State: AOAM530QwbTj+IekEOv6EpYxpFFmxOdx4AwZlBT1OUp1BsetECWRw9ck
        5fMew4UrLBU3DtgyNgFwsPVdWg==
X-Google-Smtp-Source: ABdhPJxJ/wUDup2pZUomjDEqgyB7uUDbTkUwJSHqKY5Dr3ShJKsEcYKZUTC/YO7+Hn/4PQQNoiMBGg==
X-Received: by 2002:a6b:d003:0:b0:646:4652:bd57 with SMTP id x3-20020a6bd003000000b006464652bd57mr9186492ioa.51.1648567695820;
        Tue, 29 Mar 2022 08:28:15 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id e18-20020a5d85d2000000b00649254a855fsm9095105ios.26.2022.03.29.08.28.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 08:28:15 -0700 (PDT)
Subject: Re: [PATCH] selftests/seccomp: Add SKIP for failed unshare()
To:     davidcomponentone@gmail.com, keescook@chromium.org
Cc:     luto@amacapital.net, wad@chromium.org, shuah@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Guang <yang.guang5@zte.com.cn>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <d623360ac7fdc3d8e1a8bc34e018f1aba6bd7e73.1648516943.git.yang.guang5@zte.com.cn>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <133fac97-f24e-ea4d-6ffb-279581550c51@linuxfoundation.org>
Date:   Tue, 29 Mar 2022 09:28:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <d623360ac7fdc3d8e1a8bc34e018f1aba6bd7e73.1648516943.git.yang.guang5@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/29/22 12:03 AM, davidcomponentone@gmail.com wrote:
> From: Yang Guang <yang.guang5@zte.com.cn>
> 
> Running the seccomp tests under the kernel with "defconfig"
> shouldn't fail. Because the CONFIG_USER_NS is not support

Nit - supported

> in "defconfig". So skip this test case is better.

Nit: "skipping this case instead if failing it."
> 
> Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
> Signed-off-by: David Yang <davidcomponentone@gmail.com>
> ---
>   tools/testing/selftests/seccomp/seccomp_bpf.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
> index 313bb0cbfb1e..e9a61cb2eb88 100644
> --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> @@ -3742,7 +3742,10 @@ TEST(user_notification_fault_recv)
>   	struct seccomp_notif req = {};
>   	struct seccomp_notif_resp resp = {};
>   
> -	ASSERT_EQ(unshare(CLONE_NEWUSER), 0);
> +	ASSERT_EQ(unshare(CLONE_NEWUSER), 0) {
> +		if (errno == EINVAL)
> +			SKIP(return, "kernel missing CLONE_NEWUSER support");> +	}
>   
>   	listener = user_notif_syscall(__NR_getppid,
>   				      SECCOMP_FILTER_FLAG_NEW_LISTENER);
> 
Looks good to me. Looks like this patch is for Linux 5.18 repo.
With the requested changes to commit log

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
