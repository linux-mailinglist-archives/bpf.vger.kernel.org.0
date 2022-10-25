Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48BF60C677
	for <lists+bpf@lfdr.de>; Tue, 25 Oct 2022 10:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbiJYIcP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Oct 2022 04:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbiJYIcO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Oct 2022 04:32:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0B29C2EC
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 01:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666686732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vI19L+Wyz3SmxlOUmvxXkSqYI58k5J89otQKSgEB9hY=;
        b=itvOPor6z5QVRAPMhudPmlp4C3XnqWgqZlsbqXG2yCd554XxRMwXQOYSaV2j/44yX+/IB0
        T+oI7JUm7NlkqyCSbvt/UKQQO2zSTY8HDBmqAti0KW1YUegx5kfjiRwzXUAMz3dgU4Rr5K
        Zt6av2teo34XrkS6Ji5sL3GX5WDh94A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-445-oI93Z49aPGOqHelaksh9xg-1; Tue, 25 Oct 2022 04:32:05 -0400
X-MC-Unique: oI93Z49aPGOqHelaksh9xg-1
Received: by mail-wm1-f69.google.com with SMTP id c130-20020a1c3588000000b003b56be513e1so4943220wma.0
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 01:32:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vI19L+Wyz3SmxlOUmvxXkSqYI58k5J89otQKSgEB9hY=;
        b=ymrApjilegOhz3KBoEodWHgqpefePZctKrPrYnHDLV6NEwBUpqY9UN24w1wirXW+4l
         YXZGIQiF2WbGj3pO+q7WmZZy/ds+bZTYbiuK8hmfqlmzZyXyg0mAy4H7dPbr6Vso8xZ7
         nGVgUfVLUdshAIAe4FmEUXIOnoSikFnZ6uDBjOLaTMR3xBmMjQLWfjNRv/g2njwt6tqW
         2APq56ZYI9EiDFPUx95zbtCIJKR7E4hMSFheI0fungdOQJSqw2dJQyF4Xr0k9e8AF0KK
         PxqSuyzHiu9k8Z+QrFYYdMcvMCpE1MtQGR1xAnAi7aC+wgKgy7Ay+tmVo52OT0KxZLcA
         Eqcg==
X-Gm-Message-State: ACrzQf1cBpbQOcOT07ZBp99qzomUO8XBD5PUtfZTR8MJM13Cj7zGQjYe
        xF2P7Kt3G67UrvyJy+W1A1XK3mB6SIdHIr3OthCImmGA+Bz0cpHo3OqVqE2wf+Y+LB5u56/Tcz6
        CyA9QcAfSITR5
X-Received: by 2002:a05:6000:1b85:b0:230:3652:335 with SMTP id r5-20020a0560001b8500b0023036520335mr23926358wru.467.1666686724755;
        Tue, 25 Oct 2022 01:32:04 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6n/99R+3jgCVQqtk86ipmjKyrKefyZqABmfW2gR3xga7MiiY/0BITq9gZbQxBIar2Bc5hWMQ==
X-Received: by 2002:a05:6000:1b85:b0:230:3652:335 with SMTP id r5-20020a0560001b8500b0023036520335mr23926336wru.467.1666686724408;
        Tue, 25 Oct 2022 01:32:04 -0700 (PDT)
Received: from [192.168.0.4] ([78.19.70.238])
        by smtp.gmail.com with ESMTPSA id k7-20020a7bc407000000b003a83ca67f73sm1936596wmi.3.2022.10.25.01.32.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 01:32:03 -0700 (PDT)
Message-ID: <da45c2cb-72a0-066c-019e-c6f3f01c2093@redhat.com>
Date:   Tue, 25 Oct 2022 09:32:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH bpf-next v3 1/1] doc: DEVMAPs and XDP_REDIRECT
Content-Language: en-US
To:     Jesper Dangaard Brouer <jbrouer@redhat.com>, bpf@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     brouer@redhat.com
References: <20221017094753.1564273-1-mtahhan@redhat.com>
 <20221017094753.1564273-2-mtahhan@redhat.com>
 <afc6d835-3988-0b4a-afd6-496f392324dd@redhat.com>
From:   Maryam Tahhan <mtahhan@redhat.com>
In-Reply-To: <afc6d835-3988-0b4a-afd6-496f392324dd@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 24/10/2022 13:12, Jesper Dangaard Brouer wrote:
> 
> First of all, I'm super happy that we are getting documentation added 
> for this.
> 
> Comments inlined below.
> 
> On 17/10/2022 11.47, mtahhan@redhat.com wrote:
>> diff --git a/Documentation/bpf/redirect.rst 
>> b/Documentation/bpf/redirect.rst
>> new file mode 100644
>> index 000000000000..5a0377a67ff0
>> --- /dev/null
>> +++ b/Documentation/bpf/redirect.rst
> 
> Naming the file 'redirect.rst' is that in anticipating that TC-BPF also 
> support invoking the bpf_redirect helper?
> 
> IMHO we should remember to *also* promote TC-BPF redirect, and it would 
> likely be good to have this in same file with XDP-redirect so end-users 
> see this.
> 

So I will leave the name as is...

> 
>> @@ -0,0 +1,46 @@
>> +.. SPDX-License-Identifier: GPL-2.0-only
>> +.. Copyright (C) 2022 Red Hat, Inc.
>> +
>> +============
>> +XDP_REDIRECT
>> +============
>> +
>> +XDP_REDIRECT works by a three-step process, implemented as follows:
>> +
>> +1. The ``bpf_redirect()`` and ``bpf_redirect_map()`` helpers will 
>> lookup the
>> +   target of the redirect and store it (along with some other 
>> metadata) in a
>> +   per-CPU ``struct bpf_redirect_info``. This is where the maps above 
>> come into
>> +   play.
>> +
>> +2. When the program returns the ``XDP_REDIRECT`` return code, the 
>> driver will
>> +   call ``xdp_do_redirect()`` which will use the information in ``struct
>> +   bpf_redirect_info`` to actually enqueue the frame into a map 
>> type-specific
>> +   bulk queue structure.
>> +
>> +3. Before exiting its NAPI poll loop, the driver will call 
>> ``xdp_do_flush()``,
>> +   which will flush all the different bulk queues, thus completing the
>> +   redirect.
> 
> Is this text more or less copied from net/core/filter.c ?
> 
> I will suggest directly including this from the code via the DOC text
> trick.  (note I've added these DOC tags in other XDP + page_pool code,
> but not fully utilized these yet).
> 

Ok, I will update this. I had the v5 sent in before I saw your email.

> 
>> +Pointers to the map entries will be kept around for this whole 
>> sequence of
>> +steps, protected by RCU. However, there is no top-level 
>> ``rcu_read_lock()`` in
>> +the core code; instead, the RCU protection relies on everything 
>> happening
>> +inside a single NAPI poll sequence.
>> +
>> +.. note::
>> +    Not all drivers support transmitting frames after a redirect, and 
>> for
>> +    those that do, not all of them support non-linear frames. 
>> Non-linear xdp
>> +    bufs/frames are bufs/frames that contain more than one fragment.
>> +
> 
> I would like for us to extend this redirect.rst document with
> information on how to troubleshoot when XDP-redirect "silently" drops
> packets.
> 
> Above note it one issue (but not visible to readers).
> Plus we should describe how to catch these silent drops, via tracepoints
> and even point to xdpdump tool.
> 
> I recently helped someone on Slack debug a XDP redirect issue.
> During this session I wrote some bpftrace oneliners, that I added to 
> XDP-tutorial sub-README[1]
> 
> [1] 
> https://github.com/xdp-project/xdp-tutorial/blob/master/tracing02-xdp-monitor/README.org
> 
Ok, I will see what I can do.

> 
>> +XDP_REDIRECT works with the following map types:
>> +
>> +- BPF_MAP_TYPE_DEVMAP
>> +- BPF_MAP_TYPE_DEVMAP_HASH
>> +- BPF_MAP_TYPE_CPUMAP
>> +- BPF_MAP_TYPE_XSKMAP
>> +
>> +For more information on these maps, please see the specific map 
>> documentation.
>> +
>> +References
>> +===========
>> +
>> +-https://elixir.bootlin.com/linux/latest/source/net/core/filter.c#L4106
> 
> I don't think this reference with a line-number will be stable.

Yep, will move to the doc reference as you suggested earlier.

> 
> --Jesper
> 

