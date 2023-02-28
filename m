Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF656A6069
	for <lists+bpf@lfdr.de>; Tue, 28 Feb 2023 21:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjB1UcT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Feb 2023 15:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjB1UcS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Feb 2023 15:32:18 -0500
Received: from out-23.mta1.migadu.com (out-23.mta1.migadu.com [95.215.58.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A80333468
        for <bpf@vger.kernel.org>; Tue, 28 Feb 2023 12:32:16 -0800 (PST)
Message-ID: <d3517701-7027-3750-3ac3-aeb9ac8600c8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1677616334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LH19PKEJQZLb9AapiOJSwtVNs9nGAOCLqJt9VGu6hgw=;
        b=CWpRTUgfHdNkagH9+BmFdapzsW3sjNh1KKCTu4PZ+t61xGZ4MrNftNCtkgOdtxenvIeWJA
        u7TAH9uQ3IH8I/l4GqCMUgWinQ+liri40lIeQP6j2mqfVVMm15E5mayBeNT4DRvvatGsv6
        vw+15MSWvyLUKVI+VOwRjREQ9+UaHQs=
Date:   Tue, 28 Feb 2023 12:32:09 -0800
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf-next 1/3] bpf: Implement batching in UDP iterator
Content-Language: en-US
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, kafai@fb.com, edumazet@google.com,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Aditi Ghag <aditi.ghag@isovalent.com>
References: <20230223215311.926899-1-aditi.ghag@isovalent.com>
 <20230223215311.926899-2-aditi.ghag@isovalent.com>
 <Y/k68KV9GDakrKQ1@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <Y/k68KV9GDakrKQ1@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/24/23 2:32 PM, Stanislav Fomichev wrote:
>> +    unsigned int cur_sk;
>> +    unsigned int end_sk;
>> +    unsigned int max_sk;
>> +    struct sock **batch;
>> +    bool st_bucket_done;
> 
> Any change we can generalize some of those across tcp & udp? I haven't
> looked too deep, but a lot of things look like a plain copy-paste
> from tcp batching. Or not worth it?

The batching has some small but subtle differences between tcp and udp, so not 
sure if it can end up sharing enough codes.

>>   static int udp_prog_seq_show(struct bpf_prog *prog, struct bpf_iter_meta *meta,
>>                    struct udp_sock *udp_sk, uid_t uid, int bucket)
>>   {
>> @@ -3172,18 +3307,34 @@ static int bpf_iter_udp_seq_show(struct seq_file *seq, 
>> void *v)
>>       struct bpf_prog *prog;
>>       struct sock *sk = v;
>>       uid_t uid;
>> +    bool slow;
>> +    int rc;
> 
>>       if (v == SEQ_START_TOKEN)
>>           return 0;
> 
>> +    slow = lock_sock_fast(sk);
> 
> Hm, I missed the fact that we're already using fast lock in the tcp batching
> as well. Should we not use fask locks here? On a loaded system it's
> probably fair to pay some backlog processing in the path that goes
> over every socket (here)? Martin, WDYT?

hmm... not sure if it is needed. The lock_sock_fast was borrowed from 
tcp_get_info() which is also used in inet_diag iteration. bpf iter prog should 
be doing something pretty fast also. In the future, it could allow the bpf-iter 
program to acquire the lock by itself only when it is necessary if the current 
always lock strategy is too expensive.


