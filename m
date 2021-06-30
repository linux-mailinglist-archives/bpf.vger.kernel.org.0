Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B86653B8507
	for <lists+bpf@lfdr.de>; Wed, 30 Jun 2021 16:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235079AbhF3O3J (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Jun 2021 10:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235027AbhF3O3J (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Jun 2021 10:29:09 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612A2C061756
        for <bpf@vger.kernel.org>; Wed, 30 Jun 2021 07:26:39 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso2849510otu.10
        for <bpf@vger.kernel.org>; Wed, 30 Jun 2021 07:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=z2Iu71LlSiUWQlG2rUQa7t4KLO97oiNLZE5NJsIn9DE=;
        b=B2ViN+/GF8ijlm73PEc1thl1Iw7JgzBf2oLOzSf+5L26Lwo0gQmuYbMaPIdlvRIUDE
         Brv94kIIHz+RYwMtZIAtkvHYPEFC8G3rh2nfNAw5uleut17CXINxIhDw1n6zwmix5Ihp
         0wNMtN3JFNtD267cDCk0G4cj+dbvStW0YznUEvHc2XJFi5vZDXyz7iWtgWx0jI9xHk/h
         lQQYyflj2vC0CanMePiFyO4WbqB12SiVxVYX7ypwtZyPFYqlh+hOCo76l+kksUbd00Vn
         xPDyifd1Izf+y5rR+JBvOjN32cWeIZxotGpCoGi0J1vi9VZmMU11UlmtLwO5Z2A1yYPH
         mCVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z2Iu71LlSiUWQlG2rUQa7t4KLO97oiNLZE5NJsIn9DE=;
        b=fkMynq532HzFpzg8OlCZEzdPbOksI89Xg65fH/6zUqWDvlywQJ8+S8Qeo/ZlNiyVYK
         pXtc32jzR5okO8VXC+XIFt18i7hMlLCBlOCXE2vrd46pWnK9zd9M6cWyN2qZ8+9MNmW6
         XU6m78J8dbXXFVimDPJbNz9rG6t3cr0AKO1URqHAgBgvyeXiglJEKqrPLR5Zc+o+dCCd
         pgNfBkg3ooWHeR/1QdX4qHgOsUy0WowNlgjsIrkPg7YWZx31EgZF3gBpjZrlbXtgAvnI
         lfT0Btbe76SEibBr11trcCFERH65K8sONKdrveuUfKaGM15M2tUHDR2cyB99IvIW+uFx
         RZ6Q==
X-Gm-Message-State: AOAM532c4O5PdEzI97SJhRX+1QgfuSQNRT8b+OMP4s9++EuAGwbKpz4R
        OnDaQhQGXSIpz1P8SVURRyI=
X-Google-Smtp-Source: ABdhPJw9qeKID3FAH/BBmBofttcZtoLT2JpZknY9IH9HCvX9cu0shJfphUSdQEHkbj403QrlEsrAgg==
X-Received: by 2002:a05:6830:611:: with SMTP id w17mr9099266oti.127.1625063198501;
        Wed, 30 Jun 2021 07:26:38 -0700 (PDT)
Received: from Davids-MacBook-Pro.local ([8.48.134.38])
        by smtp.googlemail.com with ESMTPSA id u12sm67482oiu.7.2021.06.30.07.26.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jun 2021 07:26:38 -0700 (PDT)
Subject: Re: [PATCH 1/3] bpf: Add support for mark with bpf_fib_lookup
To:     Greg KH <gregkh@linuxfoundation.org>,
        Rumen Telbizov <rumen.telbizov@menlosecurity.com>
Cc:     bpf@vger.kernel.org, David Ahern <dsahern@kernel.org>
References: <20210629185537.78008-1-rumen.telbizov@menlosecurity.com>
 <20210629185537.78008-2-rumen.telbizov@menlosecurity.com>
 <YNwCiZpNoKaL6fa1@kroah.com>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <23256157-cbd1-f616-858a-efa63dd2c43b@gmail.com>
Date:   Wed, 30 Jun 2021 08:26:37 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YNwCiZpNoKaL6fa1@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 6/29/21 11:35 PM, Greg KH wrote:
> On Tue, Jun 29, 2021 at 11:55:35AM -0700, Rumen Telbizov wrote:
>> From: David Ahern <dsahern@kernel.org>
>>
>> Add support for policy routing via marks to the bpf_fib_lookup
>> helper. The bpf_fib_lookup struct is constrained to 64B for
>> performance. Since the smac and dmac entries are used only for
>> output, put them in an anonymous struct and then add a union
>> around a second struct that contains the mark to use in the FIB
>> lookup.
>>
>> Signed-off-by: Rumen Telbizov <rumen.telbizov@menlosecurity.com>
>> ---
> 
> Any reason that David didn't also sign off on this?
> 

I did; just confusion by a first timer in taking my patch and adding his
patches to it. It will be fixed in v2.
