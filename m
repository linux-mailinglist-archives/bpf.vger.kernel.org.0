Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE21966897D
	for <lists+bpf@lfdr.de>; Fri, 13 Jan 2023 03:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbjAMCSZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 12 Jan 2023 21:18:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbjAMCSY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Jan 2023 21:18:24 -0500
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BB0574C7
        for <bpf@vger.kernel.org>; Thu, 12 Jan 2023 18:18:22 -0800 (PST)
X-QQ-mid: bizesmtp73t1673576280tv8rk6hx
Received: from smtpclient.apple ( [1.202.165.115])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 13 Jan 2023 10:17:58 +0800 (CST)
X-QQ-SSF: 01000000000000709000000A0000000
X-QQ-FEAT: 5q30pvLz2ichx5sXptjwqZ2oDzVMSpmCdpe/0pHi23dglGMiZfVYyFih4cqPo
        UkIz8zNYQVT1X427ZYahjkK7IdwDNzJYlqJIh9EoOW9jRGzOSS4ENIxe6weIwJ446FpDwe0
        p+qTfhUJ6YYs3FqwK5+G+++YJG/znxPOMSdXNIBrVd+nsk0t+1CpRXXdTPirYy/ZvO5VpxF
        UvdopfivIFwuZx9jz/imQxo9p8FW4CqMnjNCN5eVOdDvhJ0wNG1aORr3p4JUIzpkV5nilIS
        hbS08JXPj48Roa++G+w5BEJNs6AoUC/qI62sUWMNRPzP6hzcEUbLjcUOU3Oo/Fy4bC/OQaF
        q6m4jBWSYGLTWCEYTTxT8KXasK6bA==
X-QQ-GoodBg: 0
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [bpf-next v5 3/3] bpf: hash map, suppress false lockdep warning
From:   Tonghao Zhang <tong@infragraf.org>
In-Reply-To: <7e6d02ea-f9f7-2d09-bf10-ccd41b16a671@linux.dev>
Date:   Fri, 13 Jan 2023 10:17:58 +0800
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Hou Tao <houtao1@huawei.com>, bpf@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <97068F10-C869-4FF3-8FE0-21FA6DA82D98@infragraf.org>
References: <20230111092903.92389-1-tong@infragraf.org>
 <20230111092903.92389-3-tong@infragraf.org>
 <7e6d02ea-f9f7-2d09-bf10-ccd41b16a671@linux.dev>
To:     Martin KaFai Lau <martin.lau@linux.dev>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:infragraf.org:qybglogicsvr:qybglogicsvr5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Jan 13, 2023, at 9:53 AM, Martin KaFai Lau <martin.lau@linux.dev> wrote:
> 
> On 1/11/23 1:29 AM, tong@infragraf.org wrote:
>> +	/*
>> +	 * The lock may be taken in both NMI and non-NMI contexts.
>> +	 * There is a false lockdep warning (inconsistent lock state),
>> +	 * if lockdep enabled. The potential deadlock happens when the
>> +	 * lock is contended from the same cpu. map_locked rejects
>> +	 * concurrent access to the same bucket from the same CPU.
>> +	 * When the lock is contended from a remote cpu, we would
>> +	 * like the remote cpu to spin and wait, instead of giving
>> +	 * up immediately. As this gives better throughput. So replacing
>> +	 * the current raw_spin_lock_irqsave() with trylock sacrifices
>> +	 * this performance gain. atomic map_locked is necessary.
>> +	 * lockdep_off is invoked temporarily to fix the false warning.
>> +	 */
>> +	lockdep_off();
>>  	raw_spin_lock_irqsave(&b->raw_lock, flags);
>> -	*pflags = flags;
>> +	lockdep_on();
> 
> I am not very sure about the lockdep_off/on. Other than the false warning when using the very same htab map by both NMI and non-NMI context, I think the lockdep will still be useful
Agree, but there is no good way to fix this warning.

> to catch other potential issues. The commit c50eb518e262 ("bpf: Use separate lockdep class for each hashtab") has already solved this false alarm when NMI happens on one map and non-NMI happens on another map.
> 
> Alexei, what do you think? May be only land the patch 1 fix for now.
> 
>>  +	*pflags = flags;
>>  	return 0;
>>  }
>>  @@ -172,7 +187,11 @@ static inline void htab_unlock_bucket(const struct bpf_htab *htab,
>>  				      unsigned long flags)
>>  {
>>  	hash = hash & min_t(u32, HASHTAB_MAP_LOCK_MASK, htab->n_buckets - 1);
>> +
>> +	lockdep_off();
>>  	raw_spin_unlock_irqrestore(&b->raw_lock, flags);
>> +	lockdep_on();
>> +
>>  	__this_cpu_dec(*(htab->map_locked[hash]));
>>  	preempt_enable();
>>  }
> 
> 

