Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B27B49BACE
	for <lists+bpf@lfdr.de>; Tue, 25 Jan 2022 18:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387355AbiAYR6k (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Jan 2022 12:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343723AbiAYR4h (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Jan 2022 12:56:37 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA5FC06175D
        for <bpf@vger.kernel.org>; Tue, 25 Jan 2022 09:56:35 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id y84so8273658iof.0
        for <bpf@vger.kernel.org>; Tue, 25 Jan 2022 09:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XIy/5ol+iJbfqfFds9B7Vb2QXVBHhtczKhdcN9qlULI=;
        b=KELgZvGwlOONd5Dg6uFQB4FQy8vdDg+arfoBd3+rSDcHudWW2XjiIJcmVveEDRjzNM
         cYxLNbpvE9Nid9F10teVG4fs7CDJwzf8A0iaNLz9p/3F3ShyIQoBRl1l3rmEOYrJMsCC
         Jo3l2XUf2oXyZmlORhLW1HKyjEZ5rlKVIfFY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XIy/5ol+iJbfqfFds9B7Vb2QXVBHhtczKhdcN9qlULI=;
        b=x1LZblp7XFrn88witHftTpliFNzb3ZUhzBeaUavCd8/M/20E2ok89IyWDOc9qLONYo
         stMMh+SNBpuupvH+a1zY8Zg7HDx6bz+LaYnFgDTxBQy+YPI+N4GPnB9P8CXhtolEjVhD
         x3RXHvPRswUY2JRjGjPMYFWBFEeSnFf6vHeJxIeh4OFSDwoRIeQmgfoc9bjN8G5NkKLF
         NEBOUqg3JhTjf1j5d0mBVWChgctXfWZvzSFksnb4b6D4BkYWq8CbzJ33IlfDGS+pAHMC
         +AMRv4qOTF0saWDs3QU5jwvpIFNTlwlJjnpB5/X77fEZEd3V1tVRWgbD4lJp4PwfwuXX
         io2w==
X-Gm-Message-State: AOAM53083pS5aqTm1OaHki/d4MI+0X2/tvUEauKe0P8X30h5b6sPLkLa
        JHosFzXr1Uw/oMjC35HJZzqQMg==
X-Google-Smtp-Source: ABdhPJxUQ6g+VkFiG2Iheaiac7jFFC/ckNeDntOOHZeUSMcRYMLPZr5vhJq62DWnKF7vyGTG/oWpNQ==
X-Received: by 2002:a05:6602:2a45:: with SMTP id k5mr11552759iov.140.1643133394587;
        Tue, 25 Jan 2022 09:56:34 -0800 (PST)
Received: from ?IPv6:2601:282:8200:4c:4ef8:d404:554b:9671? ([2601:282:8200:4c:4ef8:d404:554b:9671])
        by smtp.gmail.com with ESMTPSA id y2sm598571ilj.29.2022.01.25.09.56.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 09:56:34 -0800 (PST)
Subject: Re: [PATCH] tools headers UAPI: remove stale lirc.h
To:     Sean Young <sean@mess.org>, Shuah Khan <shuah@kernel.org>,
        linux-media@vger.kernel.org, linux-kselftest@vger.kernel.org,
        bpf@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>
References: <20220124153028.394409-1-sean@mess.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <22f46323-4443-4253-7153-546fbbbdf40f@linuxfoundation.org>
Date:   Tue, 25 Jan 2022 10:56:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220124153028.394409-1-sean@mess.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/24/22 8:30 AM, Sean Young wrote:
> The lirc.h file is an old copy of lirc.h from the kernel sources. It is
> out of date, and the bpf lirc tests don't need a new copy anyway. As
> long as /usr/include/linux/lirc.h is from kernel v5.2 or newer, the tests
> will compile fine.
> 
> Signed-off-by: Sean Young <sean@mess.org>
> ---
>   tools/include/uapi/linux/lirc.h               | 229 ------------------
>   .../selftests/bpf/test_lirc_mode2_user.c      |   1 -
>   2 files changed, 230 deletions(-)
>   delete mode 100644 tools/include/uapi/linux/lirc.h
> 

Thank you for cleaning this up. I think this will go through
bpf tree. Adding bpf maintainers.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah


