Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E22686D6F
	for <lists+bpf@lfdr.de>; Wed,  1 Feb 2023 18:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjBARyf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 12:54:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjBARye (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 12:54:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9F038028
        for <bpf@vger.kernel.org>; Wed,  1 Feb 2023 09:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675274029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y3C/jKpTygMNBKacLgOlja89rzh1jqDZR0L6gDa+JpI=;
        b=WwoDIHq+bKeALx13ah4SAYQYpEKWNZXVMxUjxutBSHyLfBzjIswpzS5nSj7eOgvd2VhE5J
        8azGX9xo7jwKloOvalT5msF4DFdLYbJ6EUnPaFRRAIRpJf7F9l7NmC96hxx3aPxX8S3nn1
        M1Rgz4yYNRaOT0E8HDxWxFEXiUtliOo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-542-Lbg7khnqO-idc4qa5wzrQw-1; Wed, 01 Feb 2023 12:53:48 -0500
X-MC-Unique: Lbg7khnqO-idc4qa5wzrQw-1
Received: by mail-ej1-f70.google.com with SMTP id ds1-20020a170907724100b008775bfcef62so12453632ejc.9
        for <bpf@vger.kernel.org>; Wed, 01 Feb 2023 09:53:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:cc:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y3C/jKpTygMNBKacLgOlja89rzh1jqDZR0L6gDa+JpI=;
        b=gBAfpeVuuhS5kUxz3lOk0xhBPVjHfjx003dnEfODa7GucG5oXbnK0lgK4jWk9s05oP
         Vxi7FssiKJfKLmRer7PLT6ILYrekutveFTduhj+81mbhBWl4zgqjhkLQyi+QNimT+JXv
         aoNObYGiYa1dXjut9LdJ9hM6Lm5xnjIC4LF7QcJlm6fnaDmpFK5N4zH5BSSlAM3FWp6x
         Ov+P+ts8b3AeBQlI+WjvN7mumC4mZ8KF5kKyuiZaVA9T0RtB1vkG1RpMPUc99h5qKPnV
         mUKANCQduHiI3biwY508H9HaE3AHaZKul5D7zQg2RdwMO9yPrLpZZPO7yfXrCauTNxBo
         FbXA==
X-Gm-Message-State: AO0yUKVbt9zoPeulLZdsMnRmCnYax9PRYzAi+UkPvmJGbC/sA+LUXxDE
        g/Xxh6ShJEAV9qdFmKgivqkBBe7LSjALzI8CH1nGGOT/Rh8O2kUirz8IIhLHi+WsKLs4EnzTFsQ
        AL4tuesK9pCfP
X-Received: by 2002:a17:907:9914:b0:878:8237:7abb with SMTP id ka20-20020a170907991400b0087882377abbmr4047794ejc.35.1675274026735;
        Wed, 01 Feb 2023 09:53:46 -0800 (PST)
X-Google-Smtp-Source: AK7set9iaHy0dAJGKxRMQzkfuhvMi3UlE3SQOtU6bDESavzDpTPXmKddwsC1a4XXH1ARn7hHErTIlg==
X-Received: by 2002:a17:907:9914:b0:878:8237:7abb with SMTP id ka20-20020a170907991400b0087882377abbmr4047778ejc.35.1675274026560;
        Wed, 01 Feb 2023 09:53:46 -0800 (PST)
Received: from [192.168.42.222] (nat-cgn9-185-107-15-52.static.kviknet.net. [185.107.15.52])
        by smtp.gmail.com with ESMTPSA id o18-20020a170906359200b0088dc98e4510sm1279111ejb.112.2023.02.01.09.53.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 09:53:46 -0800 (PST)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <73d3e5c5-a38b-6f83-3022-b0442203ad6b@redhat.com>
Date:   Wed, 1 Feb 2023 18:53:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Cc:     brouer@redhat.com, netdev@vger.kernel.org, martin.lau@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        dsahern@gmail.com, willemb@google.com, void@manifault.com,
        kuba@kernel.org, xdp-hints@xdp-project.net, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next V2 2/4] selftests/bpf: xdp_hw_metadata cleanup
 cause segfault
To:     Martin KaFai Lau <martin.lau@linux.dev>,
        Stanislav Fomichev <sdf@google.com>
References: <167527267453.937063.6000918625343592629.stgit@firesoul>
 <167527271533.937063.5717065138099679142.stgit@firesoul>
 <484ca75b-d5f0-31db-6f81-2fb17ce0702e@linux.dev>
Content-Language: en-US
In-Reply-To: <484ca75b-d5f0-31db-6f81-2fb17ce0702e@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 01/02/2023 18.46, Martin KaFai Lau wrote:
> On 2/1/23 9:31 AM, Jesper Dangaard Brouer wrote:
>> diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c 
>> b/tools/testing/selftests/bpf/xdp_hw_metadata.c
>> index 3823b1c499cc..438083e34cce 100644
>> --- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
>> +++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
>> @@ -121,7 +121,7 @@ static void close_xsk(struct xsk *xsk)
>>           xsk_umem__delete(xsk->umem);
>>       if (xsk->socket)
>>           xsk_socket__delete(xsk->socket);
>> -    munmap(xsk->umem, UMEM_SIZE);
>> +    munmap(xsk->umem_area, UMEM_SIZE);
> 
> Ah. Good catch. This should also explain a similar issue that CI is 
> seeing in the prog_tests/xdp_metadata.c.

Yes, very likely same bug in prog_tests/xdp_metadata.c.

It was super tricky (and time consuming) to find as I was debugging in
GDB and it didn't make sense that checking a value against NULL would
cause a segfault.  Plus, sometimes it worked without issues.

We also need this fix:

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c 
b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
index e033d48288c0..241909d71c7e 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
@@ -121,7 +121,7 @@ static void close_xsk(struct xsk *xsk)
                 xsk_umem__delete(xsk->umem);
         if (xsk->socket)
                 xsk_socket__delete(xsk->socket);
-       munmap(xsk->umem, UMEM_SIZE);
+       munmap(xsk->umem_area, UMEM_SIZE);
  }

