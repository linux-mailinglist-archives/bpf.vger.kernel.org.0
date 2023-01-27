Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6259767E05D
	for <lists+bpf@lfdr.de>; Fri, 27 Jan 2023 10:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbjA0Jfw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 04:35:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232160AbjA0Jfv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 04:35:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338525245
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 01:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674812105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yKAoa5S5GwcYsMUD12cR2wkCJgw6XMVKgF0u+zR8x+Q=;
        b=I96zvMP/odkFMAa+yttbqbqmDfJnQPkJPVgIDkJnCsxNSSVPDKl3Vc+PZGt4KK4s/OjPXg
        T/0bx/jjmXFkLmmV1nbWDIosn+dtpk7ep/YEVNfqcwsR4OLGFuSShFXoQZUb1zjDa+7QkU
        zYo+PqozVmBr6hpszXodgMq78ZmEA5Q=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-318-zmYtjV50OhauCY8Oncxb7g-1; Fri, 27 Jan 2023 04:35:00 -0500
X-MC-Unique: zmYtjV50OhauCY8Oncxb7g-1
Received: by mail-ej1-f71.google.com with SMTP id hr22-20020a1709073f9600b0086ffb73ac1cso3084274ejc.23
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 01:34:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yKAoa5S5GwcYsMUD12cR2wkCJgw6XMVKgF0u+zR8x+Q=;
        b=NTCACqeXu2jHhuYoZU9gAG6R+4JkUNfsX+eHRDjVfkhNi04dy5701BXTuui4FnWvga
         05rzeTOb0zEasA0X1SLq6VXcP8BD9E9+TmuqDlT6KzT+Y3PEQB7al08BmJaU/gtblUtE
         1NJc0uyykNMld7mbkFXdj2l0FLAV6hBlPYjAyztfxH2EWHxn169kDIJnOO9s3sTM223A
         uH5j3+D+GRZbaXHcWhGKclf4cJ5iIZNFcTJiUjhO4jzM8aIb6egA9y6kPswR6Zl/Zlqf
         36Ca3+fko8qywMtQXfKVxn5vnXjzfGK8R45Iliv2NjmX7cWM3OlxUbGUVXwNnbvOqeA4
         toLg==
X-Gm-Message-State: AFqh2krpUHtGp/6OaTikh5oQWx3oGjXaGO/WnkixWF/ITTTp+08XXsQe
        Oamcxy122v91aPcUcIC0OfEf5ZyBsq7t4JKEJczKxewuOhWEcVJaoLgATmZcvsY3pil5YxxlP4M
        0DDEEW35o3zB+
X-Received: by 2002:a17:907:a506:b0:85b:9540:4ca7 with SMTP id vr6-20020a170907a50600b0085b95404ca7mr47277951ejc.30.1674812098683;
        Fri, 27 Jan 2023 01:34:58 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvskUBwTbw6MCPqt/0/09C1myWiedTUaoAoxC2FMScEdtV8MikJsXFuPhSR5BI8Xt2ypnSYAw==
X-Received: by 2002:a17:907:a506:b0:85b:9540:4ca7 with SMTP id vr6-20020a170907a50600b0085b95404ca7mr47277930ejc.30.1674812098461;
        Fri, 27 Jan 2023 01:34:58 -0800 (PST)
Received: from [192.168.41.200] (83-90-141-187-cable.dk.customer.tdc.net. [83.90.141.187])
        by smtp.gmail.com with ESMTPSA id kv15-20020a17090778cf00b007bd28b50305sm1916177ejc.200.2023.01.27.01.34.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 01:34:57 -0800 (PST)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <43c2dbcb-5f4f-6509-f881-ccf8c707a592@redhat.com>
Date:   Fri, 27 Jan 2023 10:34:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Cc:     brouer@redhat.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org,
        Jesper Dangaard Brouer <jbrouer@redhat.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Properly enable hwtstamp in
 xdp_hw_metadata
Content-Language: en-US
To:     Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org
References: <20230125223205.3933482-1-sdf@google.com>
In-Reply-To: <20230125223205.3933482-1-sdf@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 25/01/2023 23.32, Stanislav Fomichev wrote:
> The existing timestamping_enable() is a no-op because it applies
> to the socket-related path that we are not verifying here
> anymore. (but still leaving the code around hoping we can
> have xdp->skb path verified here as well)
> 
>    poll: 1 (0)
>    xsk_ring_cons__peek: 1
>    0xf64788: rx_desc[0]->addr=100000000008000 addr=8100 comp_addr=8000
>    rx_hash: 3697961069
>    rx_timestamp:  1674657672142214773 (sec:1674657672.1422)
>    XDP RX-time:   1674657709561774876 (sec:1674657709.5618) delta sec:37.4196
>    AF_XDP time:   1674657709561871034 (sec:1674657709.5619) delta sec:0.0001 (96.158 usec)

This output contains some extra output data, which is not part of
current upstream.
I will soon submit an RFC-patch with this extra output to discuss and
figure out what timestamp type we want/expect HW to provide.

>    0xf64788: complete idx=8 addr=8000
> 
> Also, maybe something to archive here, see [0] for Jesper's note
> about NIC vs host clock delta.
> 
> 0: https://lore.kernel.org/bpf/f3a116dc-1b14-3432-ad20-a36179ef0608@redhat.com/
> 

--Jesper

