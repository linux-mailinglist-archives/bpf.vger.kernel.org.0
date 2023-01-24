Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410C76797EF
	for <lists+bpf@lfdr.de>; Tue, 24 Jan 2023 13:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbjAXMZv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Jan 2023 07:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbjAXMZq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Jan 2023 07:25:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBCA7EF3
        for <bpf@vger.kernel.org>; Tue, 24 Jan 2023 04:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674563035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g+LfH6VeKj6sLIThRnQmmpIRj8db3/PJxpTjT61GUMA=;
        b=V+dykI7W9UzOqFlSPb+8487AnoYlnVrb7aMd+ngZ/XvkZmHr8z85xwTlOTDZUHzzSbTiX+
        6ptxS3WAWLLEOcj4BVYQms9wdAm4T9jFr8F27iuXrx7NIHZulpcu+0+WGHnBAtbZYwFNBo
        AmN57gNucY1tcuc7sa0MIaXmS9WsD+g=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-507-OzIz_C2uM_ueue9riTxcag-1; Tue, 24 Jan 2023 07:23:53 -0500
X-MC-Unique: OzIz_C2uM_ueue9riTxcag-1
Received: by mail-ed1-f69.google.com with SMTP id s14-20020a056402520e00b0049e0bea1c3fso10530933edd.3
        for <bpf@vger.kernel.org>; Tue, 24 Jan 2023 04:23:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g+LfH6VeKj6sLIThRnQmmpIRj8db3/PJxpTjT61GUMA=;
        b=AdK7RkijH91X6/Iy08OYrPGTW55YIFkC/Y+9vaJsAuAYaT2w7YgZJRAmv8/tzIn7FI
         GzntvMgxCEJCT7576HOuOSVqpkApIni1XD1sKW6LEyoOgpP+814CiGnULorCBrDBH2cs
         6fucyukENxcfgM1gC4uNDYNBM7hQQ9VCLD6YBQEYZdSuWkLPNqOmu4mbwhq2hlezMcCM
         zGVGvpbJroJMxWET0GF7K5p/1t2K2fz7gH9fX9ecZD0xwNPe5QzBOzJOvApDOHmdKMf1
         LUx7tdiWUxaEM4A210071xijWwP78izN5sjiPzCxfTc7SwybKlvn0swRzz1a8vBor5La
         VrAg==
X-Gm-Message-State: AO0yUKWNf8KC5Cauz+menBOyas0tkgFmUV94HjJxikfnyK/w1Z5kTOiS
        GnJ74lO/cAJF4iZwWACkaf8noVI/NgJBHhXJHC3s5gms3iz1Q+j0IrPIUTIaWpxbnrpZogIghRP
        58w10lQcBEMuD
X-Received: by 2002:aa7:cd6c:0:b0:4a0:90cf:2232 with SMTP id ca12-20020aa7cd6c000000b004a090cf2232mr132268edb.27.1674563032371;
        Tue, 24 Jan 2023 04:23:52 -0800 (PST)
X-Google-Smtp-Source: AK7set/AGz7aqFGfsCwbtAAgOXUa2iUOH9MTJsLbnmhnuLJvNXNwcws5qQaSwx/ySYVoIk000QtbmQ==
X-Received: by 2002:aa7:cd6c:0:b0:4a0:90cf:2232 with SMTP id ca12-20020aa7cd6c000000b004a090cf2232mr132255edb.27.1674563032147;
        Tue, 24 Jan 2023 04:23:52 -0800 (PST)
Received: from [192.168.41.200] (83-90-141-187-cable.dk.customer.tdc.net. [83.90.141.187])
        by smtp.gmail.com with ESMTPSA id u4-20020a50eac4000000b0048ebe118a46sm658978edp.77.2023.01.24.04.23.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 04:23:51 -0800 (PST)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <da633a14-0d0e-0be3-6291-92313ab1550d@redhat.com>
Date:   Tue, 24 Jan 2023 13:23:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Cc:     brouer@redhat.com, Martin KaFai Lau <martin.lau@linux.dev>,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org,
        David Ahern <dsahern@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Anatoly Burakov <anatoly.burakov@intel.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: Re: [xdp-hints] Re: [PATCH bpf-next v8 00/17] xdp: hints via kfuncs
Content-Language: en-US
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Stanislav Fomichev <sdf@google.com>
References: <20230119221536.3349901-1-sdf@google.com>
 <901e1a7a-bb86-8d62-4bd7-512a1257d3b0@linux.dev>
 <CAKH8qBs=1NgpJBNwJg7dZQnSAAGpH4vJj0+=LNWuQamGFerfZw@mail.gmail.com>
 <5b757a2a-86a7-346c-4493-9ab903de19e4@intel.com> <87lelsp2yl.fsf@toke.dk>
In-Reply-To: <87lelsp2yl.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 24/01/2023 12.49, Toke Høiland-Jørgensen wrote:
> Alexander Lobakin <alexandr.lobakin@intel.com> writes:
> 
>> From: Stanislav Fomichev <sdf@google.com>
>> Date: Mon, 23 Jan 2023 10:55:52 -0800
>>
>>> On Mon, Jan 23, 2023 at 10:53 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>>>
>>>> On 1/19/23 2:15 PM, Stanislav Fomichev wrote:
>>>>> Please see the first patch in the series for the overall
>>>>> design and use-cases.
>>>>>
>>>>> See the following email from Toke for the per-packet metadata overhead:
>>>>> https://lore.kernel.org/bpf/20221206024554.3826186-1-sdf@google.com/T/#m49d48ea08d525ec88360c7d14c4d34fb0e45e798
>>>>>
>>>>> Recent changes:
>>>>> - Keep new functions in en/xdp.c, do 'extern mlx5_xdp_metadata_ops' (Tariq)
>>>>>
>>>>> - Remove mxbuf pointer and use xsk_buff_to_mxbuf (Tariq)
>>>>>
>>>>> - Clarify xdp_buff vs 'XDP frame' (Jesper)
>>>>>
>>>>> - Explicitly mention that AF_XDP RX descriptor lacks metadata size (Jesper)
>>>>>
>>>>> - Drop libbpf_flags/xdp_flags from selftests and use ifindex instead
>>>>>     of ifname (due to recent xsk.h refactoring)
>>>>
>>>> Applied with the minor changes in the selftests discussed in patch 11 and 17.
>>>> Thanks!
>>>
>>> Awesome, thanks! I was gonna resend around Wed, but thank you for
>>> taking care of that!
>> Great stuff, congrats! :)
> 
> Yeah! Thanks for carrying this forward, Stanislav! :)

+1000 -- great work everybody! :-)

To Alexander (Cc Jesse and Tony), do you think someone from Intel could
look at extending drivers:

  drivers/net/ethernet/intel/igb/ - chip i210
  drivers/net/ethernet/intel/igc/ - chip i225
  drivers/net/ethernet/stmicro/stmmac - for CPU integrated LAN ports

We have a customer that have been eager to get hardware RX-timestamping
for their AF_XDP use-case (PoC code[1] use software timestamping via
bpf_ktime_get_ns() today).  Getting driver support will qualify this
hardware as part of their HW solution.

--Jesper
[1] 
https://github.com/xdp-project/bpf-examples/blob/master/AF_XDP-interaction/af_xdp_kern.c#L77

