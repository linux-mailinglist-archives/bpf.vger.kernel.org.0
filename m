Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBF62551C4
	for <lists+bpf@lfdr.de>; Fri, 28 Aug 2020 01:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgH0X7C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Aug 2020 19:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbgH0X7B (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Aug 2020 19:59:01 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A59C06121B
        for <bpf@vger.kernel.org>; Thu, 27 Aug 2020 16:59:00 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id 60so2196160qtc.9
        for <bpf@vger.kernel.org>; Thu, 27 Aug 2020 16:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=h57l3kyoSge+DL/hTiwIZlDn37kJsV2OpP2WH0eMUrY=;
        b=qz2Q3oQfWqHwdBioUy7e30Wa5Uf6UQrbaKEU7/kqTwAwuCQh7v2CNEsybt6zayFeX1
         Rh5bUhKJE0ganW7yLCaal6Za6ej5gBHrR1m1QZdX0d0E2paVj9xDkI3Mq3s24Xw4ZJPd
         jiSlWZK/0OPd5Dd2h+a5sSFKQVNF1V8QfSb14bQtmaxM7KVYiA8lV0F8zJ5upj3RkzO/
         YYK/vm/tf+4VuZK3kdSDqCt6BvVQv+8FqA0EIf+q1twulIFvNRn6+FR4men6ZDHuAkLw
         0rE1MqNxz2Nk0hpbJEDm8CHaNSINvVW+5dv3pXbhrVNeBsOXpEl21VuheIkqk8uOBRbk
         PFgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h57l3kyoSge+DL/hTiwIZlDn37kJsV2OpP2WH0eMUrY=;
        b=d//J0BbbdZkny8sGyCHkLB0aPsPsSyTQJhn4q5hUmdExVLcYE251mTKAO4hw0iCQxr
         IHMAwbdYF9b2T1haJHwHM3UvZHW+iSsqckQyGSChez6rUtHXzSgRCyJCOXet+ILxCJRs
         gdOlhjlYITa2Qo11zNePfwouLvAPSDYnPqe4qseHdCKyUdTnBdPKHOoWLVjDclx0xybE
         d+Kmaujb8l7lYdstQeaJ11b14vxIGMFchEq5m8aMYMzYvy84zURVBBz5Q7cLBb4k65+M
         8n1QnODaqd39Q/ttmAEWX+CJzfgqBnbZh3EW3FQiU34u0SwWX1eWvNDOM2Kb3GvusWMS
         /15w==
X-Gm-Message-State: AOAM532S3uwBkHTJnDy1r7JzJBg7s+yHjWXrFenoEXtQBAYRWQ4cFu+v
        rJUDaaPxR0XghIzGgtXwkKUIqQ==
X-Google-Smtp-Source: ABdhPJx/rbRkLsrpsCZ9/p+65Is5d7p1Sr+vuIv9PqsCxxohllrQMOSFp7Kq1rbF5G2BSZ0QprMjZg==
X-Received: by 2002:ac8:4558:: with SMTP id z24mr22041157qtn.241.1598572739603;
        Thu, 27 Aug 2020 16:58:59 -0700 (PDT)
Received: from localhost.localdomain (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 9sm3161050qky.81.2020.08.27.16.58.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2020 16:58:58 -0700 (PDT)
Subject: Re: [PATCH v3 bpf-next 1/5] mm/error_inject: Fix allow_error_inject
 function signatures.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        davem@davemloft.net
Cc:     daniel@iogearbox.net, bpoirier@suse.com, akpm@linux-foundation.org,
        hannes@cmpxchg.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
References: <20200827220114.69225-1-alexei.starovoitov@gmail.com>
 <20200827220114.69225-2-alexei.starovoitov@gmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <9a4b6133-e0ca-c34e-6f85-1f04039109d5@toxicpanda.com>
Date:   Thu, 27 Aug 2020 19:58:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200827220114.69225-2-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/27/20 6:01 PM, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> 'static' and 'static noinline' function attributes make no guarantees that
> gcc/clang won't optimize them. The compiler may decide to inline 'static'
> function and in such case ALLOW_ERROR_INJECT becomes meaningless. The compiler
> could have inlined __add_to_page_cache_locked() in one callsite and didn't
> inline in another. In such case injecting errors into it would cause
> unpredictable behavior. It's worse with 'static noinline' which won't be
> inlined, but it still can be optimized. Like the compiler may decide to remove
> one argument or constant propagate the value depending on the callsite.
> 
> To avoid such issues make sure that these functions are global noinline.
> 
> Fixes: af3b854492f3 ("mm/page_alloc.c: allow error injection")
> Fixes: cfcbfb1382db ("mm/filemap.c: enable error injection at add_to_page_cache()")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
