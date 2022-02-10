Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D8B4B11F1
	for <lists+bpf@lfdr.de>; Thu, 10 Feb 2022 16:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243731AbiBJPpt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Feb 2022 10:45:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239919AbiBJPps (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Feb 2022 10:45:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4F29419B
        for <bpf@vger.kernel.org>; Thu, 10 Feb 2022 07:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644507948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=urAoWZA9cY9CneK14fA7mIsxjD/CWWERVubOGJ2e0L4=;
        b=XHBhFVUXmTcrx6q71VyVqqyuBjPbhJU8crXNRSxK/BhsRxa7nCX3Y7kBspMA5gB6Z5Va3q
        hRJgmjOmp9228EnLMgwoBX9hKLeQKK+rGajiWb27RaK//+xYnT+dq/SyHJkzwYLn6KogRv
        FY81NsebJvWP5cT2iIzuShCjzi7KZG8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-262-JTmDROj-OYqOilJr8gpq6g-1; Thu, 10 Feb 2022 10:45:46 -0500
X-MC-Unique: JTmDROj-OYqOilJr8gpq6g-1
Received: by mail-ej1-f71.google.com with SMTP id m4-20020a170906160400b006be3f85906eso2902051ejd.23
        for <bpf@vger.kernel.org>; Thu, 10 Feb 2022 07:45:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=urAoWZA9cY9CneK14fA7mIsxjD/CWWERVubOGJ2e0L4=;
        b=foi9evFG+waWRHKKUsqpcPnt2t3dcbZTvafvBpBQxnV4q82MhluKGq/6Kj0wdcMA2n
         Q4PZt8OKMKa2TcEvbyt8YbZmKMl2uRy/4uDL8rnywNo2XM1TCkiJS1yhrl4Oky9WE9WX
         hXkokkG0IFrGkzWxZWk1ZkJ++56SDPq9mlrVmUxe/s9lba5QuJUoWFNYX//z9MSNYLxH
         Ld9lwl4nQXIUYx7EuTLILS2FMCJ2WqNMBFF1nQSYdTzTjakdUliC5u0opZ5gQsBkmdXI
         KKcFMurYkwgvoc4J2d1GIfpvKEoqDMyjB9pauxxKjXzmd6UpODvSa5rKlCiq0vk6kS3g
         Jsdg==
X-Gm-Message-State: AOAM531V1c2si03iYLBOYZj4i7m0YKEOQhqlrgzX2VtWcLplX74NyvXo
        bl/w/eP+31+BabEvYynVEUX9ShUYBmJsOx/zCLN8u5y8xOASd13tVgq7niYKHt1Zj2GbIKdKUi0
        qssLLaKRlBNqj
X-Received: by 2002:a17:906:519b:: with SMTP id y27mr6797466ejk.18.1644507945394;
        Thu, 10 Feb 2022 07:45:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx+oLm5OWY+yb22r2ZTF3kwJrcHsI2Dv7SJV68W/rbM7pX3sMkzy4AieP0+rle1eFMDJsfcKQ==
X-Received: by 2002:a17:906:519b:: with SMTP id y27mr6797443ejk.18.1644507945148;
        Thu, 10 Feb 2022 07:45:45 -0800 (PST)
Received: from ?IPV6:2a00:fb8:34ab:1700:30c4:3db1:6d5a:b924? ([2a00:fb8:34ab:1700:30c4:3db1:6d5a:b924])
        by smtp.gmail.com with ESMTPSA id q7sm4065798ejj.8.2022.02.10.07.45.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 07:45:44 -0800 (PST)
Message-ID: <f18b9e66-8494-f335-13cc-a9b30a90e32e@redhat.com>
Date:   Thu, 10 Feb 2022 16:45:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH bpf-next v2] bpf: Do not try bpf_msg_push_data with len 0
Content-Language: en-US
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org
References: <df69012695c7094ccb1943ca02b4920db3537466.1644421921.git.fmaurer@redhat.com>
 <cd545202-d948-2ce5-dfae-362822766f90@fb.com>
From:   Felix Maurer <fmaurer@redhat.com>
In-Reply-To: <cd545202-d948-2ce5-dfae-362822766f90@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 09.02.22 18:06, Yonghong Song wrote:
> On 2/9/22 7:55 AM, Felix Maurer wrote:
>> If bpf_msg_push_data is called with len 0 (as it happens during
>> selftests/bpf/test_sockmap), we do not need to do anything and can
>> return early.
>>
>> Calling bpf_msg_push_data with len 0 previously lead to a wrong ENOMEM
>> error: we later called get_order(copy + len); if len was 0, copy + len
>> was also often 0 and get_order returned some undefined value (at the
>> moment 52). alloc_pages caught that and failed, but then
>> bpf_msg_push_data returned ENOMEM. This was wrong because we are most
>> probably not out of memory and actually do not need any additional
>> memory.
>>
>> v2: Add bug description and Fixes tag
>>
>> Fixes: 6fff607e2f14b ("bpf: sk_msg program helper bpf_msg_push_data")
>> Signed-off-by: Felix Maurer <fmaurer@redhat.com>
> 
> LGTM. I am wondering why bpf CI didn't catch this problem. Did you
> modified the test with length 0 in order to trigger that? If this
> is the case, it would be great you can add such a test to the
> test_sockmap.

I did not modify the tests to trigger that. The state of the selftests
around that is unfortunately not very good. There is no explicit test
with length 0 but bpf_msg_push_data is still called with length 0,
because of what I consider to be bugs in the test. On the other hand,
explicit tests with other lengths are sometimes not called as well. I'll
elaborate on that in a bit.

Something easy to fix is that the tests do not check the return value of
bpf_msg_push_data which they probably should. That may have helped find
the problem earlier.

Now to the issue mentioned in the beginning: Only some of the BPF
programs used in test_sockmap actually call bpf_msg_push_data. However,
they are not always attached, just for particular scenarios:
txmsg_pass==1, txmsg_redir==1, or txmsg_drop==1. If none of those apply,
bpf_msg_push_data is never called. This happens for example in
test_txmsg_push. Out of the four defined tests only one actually calls
the helper.

But after a test, the parameters in the map are reset to 0 (instead of
being removed). Therefore, when the maps are reused in a subsequent test
which is one of the scenarios above, the values are present and
bpf_msg_push_data is called, albeit with the parameters set to 0. This
is also what triggered the wrong behavior fixed in the patch.

Unfortunately, I do not have the time to fix these issues in the test at
the moment.

> Acked-by: Yonghong Song <yhs@fb.com>

Thanks!

