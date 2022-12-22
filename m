Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9FEC653B81
	for <lists+bpf@lfdr.de>; Thu, 22 Dec 2022 06:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiLVFJQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Dec 2022 00:09:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiLVFJP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Dec 2022 00:09:15 -0500
Received: from out-128.mta0.migadu.com (out-128.mta0.migadu.com [IPv6:2001:41d0:1004:224b::80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8E61658A
        for <bpf@vger.kernel.org>; Wed, 21 Dec 2022 21:09:01 -0800 (PST)
Message-ID: <3d8066d4-b293-ec13-2437-1ee9b1ed4cc4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1671685737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5TOTwredCe21A6q3MNMNtWNIpYaKZWqzMmxo9tD8cXc=;
        b=QzMpagMRXt36T/J9mNQYeXm6HIKzNs9cKkfmiyv+uCMIXTOLTmooHxt+IvMon7o6OKLt74
        1PwgO0kuoyq6Olh6HdmJzBXBUnY066LKHfWgcOmAmN95dmRHUXHjACG51ij0jIdxrb35Zm
        uBiW0YtjVXf+Zk1rXY/Hr9IjSLxDcPY=
Date:   Wed, 21 Dec 2022 21:08:53 -0800
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] bpf: Add socket destroy capability
Content-Language: en-US
To:     Aditi Ghag <aditi.ghag@isovalent.com>
Cc:     sdf@google.com, edumazet@google.com, bpf@vger.kernel.org,
        Martin KaFai Lau <martin.lau@kernel.org>
References: <cover.1671242108.git.aditi.ghag@isovalent.com>
 <c3b935a5a72b1371f9262348616a7fa84061b85f.1671242108.git.aditi.ghag@isovalent.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <c3b935a5a72b1371f9262348616a7fa84061b85f.1671242108.git.aditi.ghag@isovalent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/16/22 5:57 PM, Aditi Ghag wrote:
> The socket destroy helper is used to
> forcefully terminate sockets from certain
> BPF contexts. We plan to use the capability
> in Cilium to force client sockets to reconnect
> when their remote load-balancing backends are
> deleted. The other use case is on-the-fly
> policy enforcement where existing socket
> connections prevented by policies need to
> be terminated.
> 
> The helper is currently exposed to iterator
> type BPF programs where users can filter,
> and terminate a set of sockets.
> 
> Sockets are destroyed asynchronously using
> the work queue infrastructure. This allows
> for current the locking semantics within
> socket destroy handlers, as BPF iterators
> invoking the helper acquire *sock* locks.
> This also allows the helper to be invoked
> from non-sleepable contexts.
> The other approach to skip acquiring locks
> by passing an argument to the `diag_destroy`
> handler didn't work out well for UDP, as
> the UDP abort function internally invokes
> another function that ends up acquiring
> *sock* lock.
> While there are sleepable BPF iterators,
> these are limited to only certain map types.

bpf-iter program can be sleepable and non sleepable. Both sleepable and non 
sleepable tcp/unix bpf-iter programs have been able to call bpf_setsockopt() 
synchronously. bpf_setsockopt() also requires the sock lock to be held first. 
The situation on calling '.diag_destroy' from bpf-iter should not be much 
different from calling bpf_setsockopt(). From a quick look at tcp_abort and 
udp_abort, I don't see they might sleep also and you may want to double check. 
Even '.diag_destroy' was only usable in sleepable 'bpf-iter' because it might 
sleep, the common bpf map types are already available to the sleepable programs.

At the kernel side, the tcp and unix iter acquire the lock_sock() first (eg. in 
bpf_iter_tcp_seq_show()) before calling the bpf-iter prog . At the kernel 
setsockopt code (eg. do_ip_setsockopt()), it uses sockopt_lock_sock() and avoids 
doing the lock if it has already been guaranteed by the bpf running context.

For udp, I don't see how the udp_abort acquires the sock lock differently from 
tcp_abort.  I assume the actual problem seen in udp_abort is related to the 
'->unhash()' part which acquires the udp_table's bucket lock.  This is a problem 
for udp bpf-iter only because the udp bpf-iter did not release the udp_table's 
bucket lock before calling the bpf prog.  The tcp (and unix) bpf-iter releases 
the bucket lock first before calling the bpf prog. This was done explicitly to 
allow acquiring the sock lock before calling the bpf prog because otherwise it 
will have a lock ordering issue. Hence, for this reason, bpf_setsockopt() is 
only available to tcp and unix bpf-iter but not udp bpf-iter. The udp-iter needs 
to do similar change like the tcp and unix iter 
(https://lore.kernel.org/bpf/20210701200535.1033513-1-kafai@fb.com/): batch, 
release the bucket's lock, lock the sock, and then call bpf prog.  This will 
allow udp-iter to call bpf_setsockopt() like its tcp and unix counterpart.  That 
will also allow udp bpf-iter prog to directly do '.diag_destroy'.
