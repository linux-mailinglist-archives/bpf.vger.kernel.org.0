Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C434D60A93B
	for <lists+bpf@lfdr.de>; Mon, 24 Oct 2022 15:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235795AbiJXNRD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Oct 2022 09:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233430AbiJXNPY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Oct 2022 09:15:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8B74B987
        for <bpf@vger.kernel.org>; Mon, 24 Oct 2022 05:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666614195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IpngcHCWXOEB2RUy/1H4V+ZSqfQykCkjdv8Mle+909c=;
        b=XKToQduzPeJJfytrRIkVokDqUOley2M8TWal+GDWqSJb1+3+qPQQ41AMmwIIvXeYypqj9P
        HjCl0H9Njxe9qseJeQSyZadh5hRIjzmZanglaeBNyJhXX1tzM/TbqfP+9n7l1a5IB+vjIK
        U3SzKH5so511I/mVw6Gh1XTtI4tjPcM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-342-C4Tha0r-NSqBRuNXulackw-1; Mon, 24 Oct 2022 08:12:55 -0400
X-MC-Unique: C4Tha0r-NSqBRuNXulackw-1
Received: by mail-ed1-f72.google.com with SMTP id c9-20020a05640227c900b0045d4a88c750so9362807ede.12
        for <bpf@vger.kernel.org>; Mon, 24 Oct 2022 05:12:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IpngcHCWXOEB2RUy/1H4V+ZSqfQykCkjdv8Mle+909c=;
        b=oVVH16IOpO0ITJaExb5uID6E4fh7VloE+FgDM+C/qANLvRdqW6a96VmrsogpCCISyb
         VLiqYLxtXs8e7jsry6I2LzfOiFfLiARC+e+n82rIGWP6M2s3S4jEwlQEgrckAHoJYVDD
         Akxw40huN/C7HtrdKKuLu7CU7rKTLSsfosKfjnZ7TBXOKVjH3uc3A2FFOD+M0VDhJHrg
         tDZUkjolu3SE1owMBZztmpiKXAcM0bwyQHca3LrzrWu8HfX4bPnyu32ZKuUUgHH+Z4Bf
         S9NvDGrMf+hYDW5/7Swu/H/e7LWZOscajkkamQa/3k/AYswKhE6kcFe6v3ytirH3r+6m
         wnDw==
X-Gm-Message-State: ACrzQf37VT1oM+qAzNRCEpYdQuqAh1sQ1TFCUM44fLgMsFXSiDB5aQAN
        yB7btyDb1Y0itkDnA2881WwGYfMtOd4BCuPWBpMr9hOfGnq8BlbGN1ETE6nYftnrs9r6SnSN24b
        rTFf0BPCIqd/O
X-Received: by 2002:a05:6402:4445:b0:461:b506:de51 with SMTP id o5-20020a056402444500b00461b506de51mr6016602edb.388.1666613574778;
        Mon, 24 Oct 2022 05:12:54 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4XIUGG3NXBCwfUFhJ/dHHjY+VmgLvC7hF3ZxCcaiztCUDIp+ADR/uUE+QiwIp27yGapEPpLw==
X-Received: by 2002:a05:6402:4445:b0:461:b506:de51 with SMTP id o5-20020a056402444500b00461b506de51mr6016587edb.388.1666613574560;
        Mon, 24 Oct 2022 05:12:54 -0700 (PDT)
Received: from [192.168.41.200] (83-90-141-187-cable.dk.customer.tdc.net. [83.90.141.187])
        by smtp.gmail.com with ESMTPSA id n2-20020a170906378200b0078b1bb98615sm15505137ejc.51.2022.10.24.05.12.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 05:12:53 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <afc6d835-3988-0b4a-afd6-496f392324dd@redhat.com>
Date:   Mon, 24 Oct 2022 14:12:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Cc:     brouer@redhat.com
Subject: Re: [PATCH bpf-next v3 1/1] doc: DEVMAPs and XDP_REDIRECT
Content-Language: en-US
To:     mtahhan@redhat.com, bpf@vger.kernel.org, linux-doc@vger.kernel.org
References: <20221017094753.1564273-1-mtahhan@redhat.com>
 <20221017094753.1564273-2-mtahhan@redhat.com>
In-Reply-To: <20221017094753.1564273-2-mtahhan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


First of all, I'm super happy that we are getting documentation added 
for this.

Comments inlined below.

On 17/10/2022 11.47, mtahhan@redhat.com wrote:
> diff --git a/Documentation/bpf/redirect.rst b/Documentation/bpf/redirect.rst
> new file mode 100644
> index 000000000000..5a0377a67ff0
> --- /dev/null
> +++ b/Documentation/bpf/redirect.rst

Naming the file 'redirect.rst' is that in anticipating that TC-BPF also 
support invoking the bpf_redirect helper?

IMHO we should remember to *also* promote TC-BPF redirect, and it would 
likely be good to have this in same file with XDP-redirect so end-users 
see this.


> @@ -0,0 +1,46 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +.. Copyright (C) 2022 Red Hat, Inc.
> +
> +============
> +XDP_REDIRECT
> +============
> +
> +XDP_REDIRECT works by a three-step process, implemented as follows:
> +
> +1. The ``bpf_redirect()`` and ``bpf_redirect_map()`` helpers will lookup the
> +   target of the redirect and store it (along with some other metadata) in a
> +   per-CPU ``struct bpf_redirect_info``. This is where the maps above come into
> +   play.
> +
> +2. When the program returns the ``XDP_REDIRECT`` return code, the driver will
> +   call ``xdp_do_redirect()`` which will use the information in ``struct
> +   bpf_redirect_info`` to actually enqueue the frame into a map type-specific
> +   bulk queue structure.
> +
> +3. Before exiting its NAPI poll loop, the driver will call ``xdp_do_flush()``,
> +   which will flush all the different bulk queues, thus completing the
> +   redirect.

Is this text more or less copied from net/core/filter.c ?

I will suggest directly including this from the code via the DOC text
trick.  (note I've added these DOC tags in other XDP + page_pool code,
but not fully utilized these yet).


> +Pointers to the map entries will be kept around for this whole sequence of
> +steps, protected by RCU. However, there is no top-level ``rcu_read_lock()`` in
> +the core code; instead, the RCU protection relies on everything happening
> +inside a single NAPI poll sequence.
> +
> +.. note::
> +    Not all drivers support transmitting frames after a redirect, and for
> +    those that do, not all of them support non-linear frames. Non-linear xdp
> +    bufs/frames are bufs/frames that contain more than one fragment.
> +

I would like for us to extend this redirect.rst document with
information on how to troubleshoot when XDP-redirect "silently" drops
packets.

Above note it one issue (but not visible to readers).
Plus we should describe how to catch these silent drops, via tracepoints
and even point to xdpdump tool.

I recently helped someone on Slack debug a XDP redirect issue.
During this session I wrote some bpftrace oneliners, that I added to 
XDP-tutorial sub-README[1]

[1] 
https://github.com/xdp-project/xdp-tutorial/blob/master/tracing02-xdp-monitor/README.org


> +XDP_REDIRECT works with the following map types:
> +
> +- BPF_MAP_TYPE_DEVMAP
> +- BPF_MAP_TYPE_DEVMAP_HASH
> +- BPF_MAP_TYPE_CPUMAP
> +- BPF_MAP_TYPE_XSKMAP
> +
> +For more information on these maps, please see the specific map documentation.
> +
> +References
> +===========
> +
> +-https://elixir.bootlin.com/linux/latest/source/net/core/filter.c#L4106

I don't think this reference with a line-number will be stable.

--Jesper

