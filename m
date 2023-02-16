Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1374699899
	for <lists+bpf@lfdr.de>; Thu, 16 Feb 2023 16:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjBPPS5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Feb 2023 10:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjBPPS4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Feb 2023 10:18:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C39E93FA
        for <bpf@vger.kernel.org>; Thu, 16 Feb 2023 07:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676560670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hu0NDPUgPtJQPv1XAu2IlR0R1Izce8nrz7t5aM+xvQk=;
        b=imSjoBPZi8GH44bbXhpMnMqGs3hRUIPHFwVtsPhPI1p+OZld+9IfqwQIfpgq/n5AXIdSo0
        pKn00CLo6d2nnSf46eOp31XlTCGdNPtzGyg0+b2D33w1ncAGspeFF6eCUmpy4cotw80UJC
        P41uDbaF9jKWUhOF7bG6fj1kd539NpQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-39-ZDjLo6PVNhS7JbbrG5JcMg-1; Thu, 16 Feb 2023 10:17:49 -0500
X-MC-Unique: ZDjLo6PVNhS7JbbrG5JcMg-1
Received: by mail-ed1-f70.google.com with SMTP id bo27-20020a0564020b3b00b004a6c2f6a226so1990516edb.15
        for <bpf@vger.kernel.org>; Thu, 16 Feb 2023 07:17:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:cc:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hu0NDPUgPtJQPv1XAu2IlR0R1Izce8nrz7t5aM+xvQk=;
        b=4QB5M27PU6aMWrMwTp4nozXydhxlPwEaz7aAt+uyAyEx2SDdumoNjwgQeJJhVvgode
         zRv8VAJl82gzkdKf7tu2e2Ww0BdVD+pl81wR+sETxONrBgOpUXfCAnHSinynQBwBMEmp
         reBay7/AAWDErh7okCcajw034Nvxw+47SHwKr+NwDew0Y+GLoK9+4OdfUZqdMG3n09su
         jmscwMMnCNvp7OvL+lcH0DlqgLs8DuT56dcDj/h3nezGMZIdXxPswl9edUs8w77YSojh
         ibhGl/ly74pCi8ficv7jtQJ3n+s/Jv6Qow9pI6IEBkz40HNe2UpZu1kfMy27Ux8S30Jl
         lvcg==
X-Gm-Message-State: AO0yUKXYaSAR3tfyH+q9+vyCG5N/y2nAcC/dJo7k190d65Z7FenOFq07
        0vitEkOeZxzPGGQXbqO0dEhthxzOneu9UZ3/oLpQEf0SZAJAln+PgJqg2c9u09wfptzyh+MjFuF
        Yyd5lQ1Myd+qW
X-Received: by 2002:aa7:cfc6:0:b0:4ab:2503:403a with SMTP id r6-20020aa7cfc6000000b004ab2503403amr5969371edy.34.1676560668571;
        Thu, 16 Feb 2023 07:17:48 -0800 (PST)
X-Google-Smtp-Source: AK7set/e0ygiKMDvoNKR1sy40kN4i/T2Q1Ay4lVRellixuesMpm665RS/+dBn5HBdKLkS/bSjZzPIQ==
X-Received: by 2002:aa7:cfc6:0:b0:4ab:2503:403a with SMTP id r6-20020aa7cfc6000000b004ab2503403amr5969337edy.34.1676560668263;
        Thu, 16 Feb 2023 07:17:48 -0800 (PST)
Received: from [192.168.42.100] (nat-cgn9-185-107-15-52.static.kviknet.net. [185.107.15.52])
        by smtp.gmail.com with ESMTPSA id t9-20020a50d709000000b004a249a97d84sm995434edi.23.2023.02.16.07.17.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 07:17:47 -0800 (PST)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <9a7a44a6-ec0c-e5e9-1c94-ccc0d1755560@redhat.com>
Date:   Thu, 16 Feb 2023 16:17:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc:     brouer@redhat.com, bpf@vger.kernel.org, xdp-hints@xdp-project.net,
        martin.lau@kernel.org, daniel@iogearbox.net,
        netdev@vger.kernel.org, ast@kernel.org,
        Stanislav Fomichev <sdf@google.com>,
        yoong.siang.song@intel.com, anthony.l.nguyen@intel.com,
        intel-wired-lan@lists.osuosl.org
Subject: Re: [xdp-hints] Re: [Intel-wired-lan] [PATCH bpf-next V1] igc: enable
 and fix RX hash usage by netstack
To:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>
References: <167604167956.1726972.7266620647404438534.stgit@firesoul>
 <6a5ded96-2425-ff9b-c1b1-eca1c103164c@molgen.mpg.de>
 <b6143e67-a0f1-a238-f901-448b85281154@intel.com>
Content-Language: en-US
In-Reply-To: <b6143e67-a0f1-a238-f901-448b85281154@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 14/02/2023 16.13, Alexander Lobakin wrote:
> From: Paul Menzel <pmenzel@molgen.mpg.de>
> Date: Tue, 14 Feb 2023 16:00:52 +0100
>>
>> Am 10.02.23 um 16:07 schrieb Jesper Dangaard Brouer:
>>> When function igc_rx_hash() was introduced in v4.20 via commit 0507ef8a0372
>>> ("igc: Add transmit and receive fastpath and interrupt handlers"), the
>>> hardware wasn't configured to provide RSS hash, thus it made sense to not
>>> enable net_device NETIF_F_RXHASH feature bit.
>>>
[...]
>>
>>> hash value doesn't include UDP port numbers. Not being PKT_HASH_TYPE_L4, have
>>> the effect that netstack will do a software based hash calc calling into
>>> flow_dissect, but only when code calls skb_get_hash(), which doesn't
>>> necessary happen for local delivery.
>>
>> Excuse my ignorance, but is that bug visible in practice by users
>> (performance?) or is that fix needed for future work?
> 
> Hash calculation always happens when RPS or RFS is enabled. So having no
> hash in skb before hitting the netstack slows down their performance.
> Also, no hash in skb passed from the driver results in worse NAPI bucket
> distribution when there are more traffic flows than Rx queues / CPUs.
> + Netfilter needs hashes on some configurations.
> 

Thanks Olek for explaining that.

My perf measurements show that the expensive part is that netstack will
call the flow_dissector code, when the hardware RX-hash is missing.

>>
>>> Fixes: 2121c2712f82 ("igc: Add multiple receive queues control
>>> supporting")
>>> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
> 
> [...]
> 
> Nice to see that you also care about (not) using short types on the stack :)

As can be seen by godbolt.org exploration[0] I have done, the stack
isn't used for storing the values.

  [0] 
https://github.com/xdp-project/xdp-project/tree/master/areas/hints/godbolt/

I have created three files[2] with C-code that can be compiled via 
https://godbolt.org/.  The C-code contains a comment with the ASM code 
that was generated with -02 with compiler x86-64 gcc 12.2.

The first file[01] corresponds to this patch.

  [01] 
https://github.com/xdp-project/xdp-project/blob/master/areas/hints/godbolt/igc_godbolt01.c
  [G01] https://godbolt.org/z/j79M9aTsn

The second file igc_godbolt02.c [02] have changes in [diff02]

  [02] 
https://github.com/xdp-project/xdp-project/blob/master/areas/hints/godbolt/igc_godbolt02.c
  [G02] https://godbolt.org/z/sErqe4qd5
  [diff02] https://github.com/xdp-project/xdp-project/commit/1f3488a932767

The third file igc_godbolt03.c [03] have changes in [diff03]

  [03] 
https://github.com/xdp-project/xdp-project/blob/master/areas/hints/godbolt/igc_godbolt03.c
  [G03] https://godbolt.org/z/5K3vE1Wsv
  [diff03] https://github.com/xdp-project/xdp-project/commit/aa9298f68705

Summary, the only thing we can save is replacing some movzx
(zero-extend) with mov instructions.

>>
>> [1]: https://notabs.org/coding/smallIntsBigPenalty.htm
> 
> Thanks,
> Olek
> 

