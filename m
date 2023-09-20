Return-Path: <bpf+bounces-10423-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C75397A6FEC
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 02:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FC321C20998
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 00:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6444717CF;
	Wed, 20 Sep 2023 00:38:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F7015B1
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 00:38:49 +0000 (UTC)
Received: from out-227.mta1.migadu.com (out-227.mta1.migadu.com [95.215.58.227])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E323EAB
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 17:38:46 -0700 (PDT)
Message-ID: <f85fbac6-a1d7-3f63-9d0f-8eaa261ddb26@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1695170325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4QRToQSLyTwhldBNMUdoQpJR/D24GBLzG7StN9xX56Y=;
	b=iLCxg5yMSRXoofiACMijrBQ0ae+s3csM9MneAFOrqQpmOtxJ1dI+ukKxo0cswLhKgeq6du
	CtsTMk7NvSLp5BcLulK8NflvFu0Ma3PQtbyivaZ6NOrYlzq4eOqO3gPC17TxqoELxgFBZ7
	90dE3LVUK6CZ7lbRc44CT1pTyLLvG0Q=
Date: Tue, 19 Sep 2023 17:38:35 -0700
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230519225157.760788-6-aditi.ghag@isovalent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 5/19/23 3:51 PM, Aditi Ghag wrote:
> +static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
> +{
> +	struct bpf_udp_iter_state *iter = seq->private;
> +	struct udp_iter_state *state = &iter->state;
> +	struct net *net = seq_file_net(seq);
> +	struct udp_table *udptable;
> +	unsigned int batch_sks = 0;
> +	bool resized = false;
> +	struct sock *sk;
> +
> +	/* The current batch is done, so advance the bucket. */
> +	if (iter->st_bucket_done) {
> +		state->bucket++;
> +		iter->offset = 0;
> +	}
> +
> +	udptable = udp_get_table_seq(seq, net);
> +
> +again:
> +	/* New batch for the next bucket.
> +	 * Iterate over the hash table to find a bucket with sockets matching
> +	 * the iterator attributes, and return the first matching socket from
> +	 * the bucket. The remaining matched sockets from the bucket are batched
> +	 * before releasing the bucket lock. This allows BPF programs that are
> +	 * called in seq_show to acquire the bucket lock if needed.
> +	 */
> +	iter->cur_sk = 0;
> +	iter->end_sk = 0;
> +	iter->st_bucket_done = false;
> +	batch_sks = 0;
> +
> +	for (; state->bucket <= udptable->mask; state->bucket++) {
> +		struct udp_hslot *hslot2 = &udptable->hash2[state->bucket];
> +
> +		if (hlist_empty(&hslot2->head)) {
> +			iter->offset = 0;
> +			continue;
> +		}
> +
> +		spin_lock_bh(&hslot2->lock);
> +		udp_portaddr_for_each_entry(sk, &hslot2->head) {
> +			if (seq_sk_match(seq, sk)) {
> +				/* Resume from the last iterated socket at the
> +				 * offset in the bucket before iterator was stopped.
> +				 */
> +				if (iter->offset) {
> +					--iter->offset;

Hi Aditi, I think this part has a bug.

When I run './test_progs -t bpf_iter/udp6' in a machine with some udp 
so_reuseport sockets, this test is never finished.

A broken case I am seeing is when the bucket has >1 sockets and bpf_seq_read() 
can only get one sk at a time before it calls bpf_iter_udp_seq_stop().

I did not try the change yet. However, from looking at the code where 
iter->offset is changed, --iter->offset here is the most likely culprit and it 
will make backward progress for the same bucket (state->bucket). Other places 
touching iter->offset look fine.

It needs a local "int offset" variable for the zero test. Could you help to take 
a look, add (or modify) a test and fix it?

The progs/bpf_iter_udp[46].c test can be used to reproduce. The test_udp[46] in 
prog_tests/bpf_iter.c needs to be changed though to ensure there is multiple sk 
in the same bucket. Probably a few so_reuseport sk should do.

Thanks.

> +					continue;
> +				}
> +				if (iter->end_


