Return-Path: <bpf+bounces-10842-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFF47AE4D3
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 07:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 62A7D2811B7
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 05:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535751C37;
	Tue, 26 Sep 2023 05:02:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00B8187B
	for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 05:02:12 +0000 (UTC)
Received: from out-190.mta1.migadu.com (out-190.mta1.migadu.com [IPv6:2001:41d0:203:375::be])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C655E9
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 22:02:10 -0700 (PDT)
Message-ID: <7075f350-80c7-b3a9-c1e7-65b8546dbc1f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1695704528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TBaeHqvtqkjYIBXgCaqzXwR2YJjTmZY3k6QbF3dkWCE=;
	b=n2LfIbqSxbJ3/0w0tjR6dVhjMAXAv6nFDZgQLI8aPoCvXdmeKNVMUW0ZLIQM7DBY4YfSm/
	Thy3m0bU9M3iZQMwwkAObB8yo/Qon1t5jItz8xnHH0jgUr6aaBvHChnsr0pHKvv0BYAirP
	RwH5NWTRm24298vJGCIKUZiKR66bnbA=
Date: Mon, 25 Sep 2023 22:02:02 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v9 bpf-next 5/9] bpf: udp: Implement batching for sockets
 iterator
Content-Language: en-US
To: Aditi Ghag <aditi.ghag@isovalent.com>
Cc: sdf@google.com, Martin KaFai Lau <martin.lau@kernel.org>,
 bpf@vger.kernel.org, Network Development <netdev@vger.kernel.org>
References: <20230519225157.760788-1-aditi.ghag@isovalent.com>
 <20230519225157.760788-6-aditi.ghag@isovalent.com>
 <f85fbac6-a1d7-3f63-9d0f-8eaa261ddb26@linux.dev>
 <0B548508-C9AD-476C-A934-5D9D9B5DECB0@isovalent.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <0B548508-C9AD-476C-A934-5D9D9B5DECB0@isovalent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/25/23 4:34 PM, Aditi Ghag wrote:
> 
> 
>> On Sep 19, 2023, at 5:38 PM, Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 5/19/23 3:51 PM, Aditi Ghag wrote:
>>> +static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
>>> +{
>>> +	struct bpf_udp_iter_state *iter = seq->private;
>>> +	struct udp_iter_state *state = &iter->state;
>>> +	struct net *net = seq_file_net(seq);
>>> +	struct udp_table *udptable;
>>> +	unsigned int batch_sks = 0;
>>> +	bool resized = false;
>>> +	struct sock *sk;
>>> +
>>> +	/* The current batch is done, so advance the bucket. */
>>> +	if (iter->st_bucket_done) {
>>> +		state->bucket++;
>>> +		iter->offset = 0;
>>> +	}
>>> +
>>> +	udptable = udp_get_table_seq(seq, net);
>>> +
>>> +again:
>>> +	/* New batch for the next bucket.
>>> +	 * Iterate over the hash table to find a bucket with sockets matching
>>> +	 * the iterator attributes, and return the first matching socket from
>>> +	 * the bucket. The remaining matched sockets from the bucket are batched
>>> +	 * before releasing the bucket lock. This allows BPF programs that are
>>> +	 * called in seq_show to acquire the bucket lock if needed.
>>> +	 */
>>> +	iter->cur_sk = 0;
>>> +	iter->end_sk = 0;
>>> +	iter->st_bucket_done = false;
>>> +	batch_sks = 0;
>>> +
>>> +	for (; state->bucket <= udptable->mask; state->bucket++) {
>>> +		struct udp_hslot *hslot2 = &udptable->hash2[state->bucket];
>>> +
>>> +		if (hlist_empty(&hslot2->head)) {
>>> +			iter->offset = 0;
>>> +			continue;
>>> +		}
>>> +
>>> +		spin_lock_bh(&hslot2->lock);
>>> +		udp_portaddr_for_each_entry(sk, &hslot2->head) {
>>> +			if (seq_sk_match(seq, sk)) {
>>> +				/* Resume from the last iterated socket at the
>>> +				 * offset in the bucket before iterator was stopped.
>>> +				 */
>>> +				if (iter->offset) {
>>> +					--iter->offset;
>>
>> Hi Aditi, I think this part has a bug.
>>
>> When I run './test_progs -t bpf_iter/udp6' in a machine with some udp so_reuseport sockets, this test is never finished.
>>
>> A broken case I am seeing is when the bucket has >1 sockets and bpf_seq_read() can only get one sk at a time before it calls bpf_iter_udp_seq_stop().
> 
> Just so that I understand the broken case better, are you doing something in your BPF iterator program so that "bpf_seq_read() can only get one sk at a time"?
> 
>>
>> I did not try the change yet. However, from looking at the code where iter->offset is changed, --iter->offset here is the most likely culprit and it will make backward progress for the same bucket (state->bucket). Other places touching iter->offset look fine.
>>
>> It needs a local "int offset" variable for the zero test. Could you help to take a look, add (or modify) a test and fix it?
>>
>> The progs/bpf_iter_udp[46].c test can be used to reproduce. The test_udp[46] in prog_tests/bpf_iter.c needs to be changed though to ensure there is multiple sk in the same bucket. Probably a few so_reuseport sk should do.
> 
> 
> The sock_destroy patch set had added a test with multiple so_reuseport sks in a bucket in order to exercise batching [1]. I was wondering if extending the test with an additional bucket should do it, or some more cases are required (asked for clarification above) to reproduce the issue.

Number of bucket should not matter. It should only need a bucket to have 
multiple sockets.

I did notice test_udp_server() has 5 so_reuseport udp sk in the same bucket when 
trying to understand how this issue was missed. It is enough on the hashtable 
side. This is the easier part and one start_reuseport_server() call will do. 
Having multiple sk in a bucket is not enough to reprod though.

The bpf prog 'iter_udp6_server' in the sock_destroy test is not doing 
bpf_seq_printf(). bpf_seq_printf() is necessary to reproduce the issue. The 
read() buf from the userspace program side also needs to be small. It needs to 
hit the "if (seq->count >= size) break;" condition in the "while (1)" loop in 
the kernel/bpf/bpf_iter.c.

You can try to add both to the sock_destroy test. I was suggesting 
bpf_iter/udp[46] test instead (i.e. the test_udp[46] function) because the 
bpf_seq_printf and the buf[] size are all aligned to reprod the problem already. 
  Try to add a start_reuseport_server(..., 5) to the beginning of test_udp6() in 
prog_tests/bpf_iter.c to ensure there is multiple udp sk in a bucket. It should 
be enough to reprod.

In the final fix, I don't have strong preference on where the test should be.
Modifying one of the two existing tests (i.e. sock_destroy or bpf_iter) or a 
completely new test.

Let me know if you have problem reproducing it. Thanks.

> 
> 
> [1] https://elixir.bootlin.com/linux/v6.5/source/tools/testing/selftests/bpf/prog_tests/sock_destroy.c#L146
> 
>>
>> Thanks.
>>
>>> +					continue;
>>> +				}
>>> +				if (iter->end_
>>
> 


