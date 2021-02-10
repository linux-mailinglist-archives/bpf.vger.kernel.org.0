Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 945EB315B6A
	for <lists+bpf@lfdr.de>; Wed, 10 Feb 2021 01:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbhBJAig (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Feb 2021 19:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233796AbhBJAgW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Feb 2021 19:36:22 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3AFC061788
        for <bpf@vger.kernel.org>; Tue,  9 Feb 2021 16:35:35 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id r21so231548otk.13
        for <bpf@vger.kernel.org>; Tue, 09 Feb 2021 16:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dwOJXb2rZMTXAcXXquhzDrJAGp/ZNEOKDykceMWb28A=;
        b=Rw1pJIsLmw/sXXx/sFSlp0vuRw6O3I44Akle1rscvR13YwZQWie9HDEgVKQXRG48Dz
         lukNI5tedUsTmgGXXCVqBb0ADD5F+jmvkT1Z0MeEGT3cIOETNwIWLStepoBj0mz2Dk7Q
         NNWRUjkd9q6ADQg25Ra0r0+qi7bDGp+MS7WTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dwOJXb2rZMTXAcXXquhzDrJAGp/ZNEOKDykceMWb28A=;
        b=YzahoFWCzthOQE6R+e9vevCUEH6gf0PLwCBAbuNOFvzltIgpVGNY7WYU3EUrhkZ2q1
         itH9c0REokVBwW2PhULdBj+RKgZ/RCav9WZ6G4awaRrKvA23mtrNjJ7PFJivlyk98S53
         5XlkoeF+NwWDouF+GRgRySW4D+Th2Eq5x/Kz+UDN/1DKdDRYAesud6UdIFw4PFAwO0lu
         Ia1Bm39GM6QaTG28EylgfPqQ5KSkgSUY7SlqXEGyWa+dDUpsPH/hikQdWbUfx6E0Ao6R
         mlv3Mtqp9LdGUB/D64ajsRLwN/oF6lJqqlSSKUvOryDrYxAV3BVSf7edwFOd480zpk68
         l3fg==
X-Gm-Message-State: AOAM533OkquXynihi5iL+UqXHVXekWOi6x6GbRc/olhcG365NlUNxJ8Q
        70KpPJ42BmsssEgJtynjhAEesg==
X-Google-Smtp-Source: ABdhPJygWyurf7h0wIY5eUqxpUxgstMHldBRuMtondPeMYIcj+7EVNcjWXuGplid29b/vg6YQs5dbQ==
X-Received: by 2002:a05:6830:3495:: with SMTP id c21mr223719otu.97.1612917334849;
        Tue, 09 Feb 2021 16:35:34 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id x187sm102792oig.3.2021.02.09.16.35.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Feb 2021 16:35:34 -0800 (PST)
Subject: Re: [PATCH] selftests/seccomp: Accept any valid fd in
 user_notification_addfd
To:     Kees Cook <keescook@chromium.org>,
        Seth Forshee <seth.forshee@canonical.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210128161721.99150-1-seth.forshee@canonical.com>
 <202102091632.D5E0100A@keescook>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <89f34e46-17a0-e563-f75f-1206c5318a66@linuxfoundation.org>
Date:   Tue, 9 Feb 2021 17:35:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <202102091632.D5E0100A@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/9/21 5:33 PM, Kees Cook wrote:
> On Thu, Jan 28, 2021 at 10:17:21AM -0600, Seth Forshee wrote:
>> This test expects fds to have specific values, which works fine
>> when the test is run standalone. However, the kselftest runner
>> consumes a couple of extra fds for redirection when running
>> tests, so the test fails when run via kselftest.
>>
>> Change the test to pass on any valid fd number.
>>
>> Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
> 
> Thanks!
> 
> Acked-by: Kees Cook <keescook@chromium.org>
> 
> I'll snag this if Shuah doesn't first. :)
> 

I will apply this. I have several queued for 5.12-rc1 anyway.

thanks,
-- Shuah
