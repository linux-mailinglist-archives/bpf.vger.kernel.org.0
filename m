Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3EF6DFEDC
	for <lists+bpf@lfdr.de>; Wed, 12 Apr 2023 21:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjDLTmr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 15:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjDLTmr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 15:42:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E1810E
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 12:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681328518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PZyE3by71dhptILzoG2mMeMpC2Di8knMI/CBnTBAzKg=;
        b=XqMBELrpRO+2tg6VRh3yJlKIOJPP/KVCdkIsXqbbUIzFOx+Qpje9RM0hAqgg/mY+IXtkEA
        hBoTgOfftSd2rWsftlpwFCeymrVcBnt2XC/ot+hUQKHo9z/b5Mf+xmi15xZLFG7FDe9FTm
        PRm3E0uIsHKlqXpSwZTIym4mzB3Q6sA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-gfvmcumlPSupukhXB3N1uA-1; Wed, 12 Apr 2023 15:41:57 -0400
X-MC-Unique: gfvmcumlPSupukhXB3N1uA-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-50489c48204so2042805a12.3
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 12:41:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681328516; x=1683920516;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PZyE3by71dhptILzoG2mMeMpC2Di8knMI/CBnTBAzKg=;
        b=jtqqaT0vps6B/KVEHWL3Snmz2zOimDf9MQj28uDUqrAN/q7xIusbGKQGaISngzc7dm
         DsjEWZBMayHpxN8oTBegYaqQXE6e3INddkaRA6n+VL468BaILfm8xJ3uqF4x+Zuiqw+b
         295SlmZcGClzNIozSX6O7hB2BP91a1g9Tr+n7mDEuxJYxlt0TW4EY4a84ad7AL6xK/5d
         EJeEjVpBhyAd9+4dML9D3u3LxVdZm6XictbZlciteSZypgjcSe/qJBRK4lABmvC0P4qx
         LTnbZWSegSwSRflSnXLMn2KY1YIj8P2Ahb5FXAYGx3wFPr+qO4FSRQuTNgI2hIJ3cLNF
         x36Q==
X-Gm-Message-State: AAQBX9cUnMGNb79rzpUZM5NunmQzUKA8cmet+l/nIuwShWfPKJg3v23h
        SWMubmWvyxG2pMfHB0j/6FXfvpbBgGmk7RGEn0SM+O4Dl87weWwcfqtkqET/TZTlAOqQm6ZqvgU
        9ueXLjadjtHIN
X-Received: by 2002:a05:6402:88b:b0:504:890a:c974 with SMTP id e11-20020a056402088b00b00504890ac974mr6138363edy.39.1681328515936;
        Wed, 12 Apr 2023 12:41:55 -0700 (PDT)
X-Google-Smtp-Source: AKy350bKfHQNnSCcQvfK/hEpOM5f4Blrmw8gI9lq/WNsB4pll8gZApkmKrLoBvdug33QGekyfjyctQ==
X-Received: by 2002:a05:6402:88b:b0:504:890a:c974 with SMTP id e11-20020a056402088b00b00504890ac974mr6138342edy.39.1681328515609;
        Wed, 12 Apr 2023 12:41:55 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id o2-20020a50c282000000b004fd1ee3f723sm7128382edf.67.2023.04.12.12.41.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 12:41:55 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <7ab3bb4e-e0f0-c35e-9f39-99cbd5ce1ae6@redhat.com>
Date:   Wed, 12 Apr 2023 21:41:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Cc:     brouer@redhat.com, bpf@vger.kernel.org,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        martin.lau@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        alexandr.lobakin@intel.com, larysa.zaremba@intel.com,
        xdp-hints@xdp-project.net, anthony.l.nguyen@intel.com,
        yoong.siang.song@intel.com, boon.leong.ong@intel.com,
        intel-wired-lan@lists.osuosl.org, pabeni@redhat.com,
        jesse.brandeburg@intel.com, kuba@kernel.org, edumazet@google.com,
        john.fastabend@gmail.com, hawk@kernel.org, davem@davemloft.net,
        tariqt@nvidia.com, saeedm@nvidia.com, leon@kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH bpf V9 1/6] selftests/bpf: xdp_hw_metadata remove
 bpf_printk and add counters
Content-Language: en-US
To:     Stanislav Fomichev <sdf@google.com>
References: <168132448251.317773.2526885806604122764.stgit@firesoul>
 <168132451707.317773.15960209122204110352.stgit@firesoul>
 <CAKH8qBu0B1tQBKtGp0-n8eet+4rQRTPE3rrCr5Ve0CG6uYR7Kg@mail.gmail.com>
In-Reply-To: <CAKH8qBu0B1tQBKtGp0-n8eet+4rQRTPE3rrCr5Ve0CG6uYR7Kg@mail.gmail.com>
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


On 12/04/2023 20.56, Stanislav Fomichev wrote:
> On Wed, Apr 12, 2023 at 11:35 AM Jesper Dangaard Brouer
> <brouer@redhat.com>  wrote:
>> The tool xdp_hw_metadata can be used by driver developers
>> implementing XDP-hints metadata kfuncs.
>>
>> Remove all bpf_printk calls, as the tool already transfers all the
>> XDP-hints related information via metadata area to AF_XDP
>> userspace process.
>>
>> Add counters for providing remaining information about failure and
>> skipped packet events.
>>
>> Signed-off-by: Jesper Dangaard Brouer<brouer@redhat.com>
> Acked-by: Stanislav Fomichev<sdf@google.com>
> 
> nit: maybe those ++ should be __sync_add_and_fetch instead? Then you
> should be able to drop volatile..

That is a good suggestion.
I will update the patch and add your ACK.

--Jesper

