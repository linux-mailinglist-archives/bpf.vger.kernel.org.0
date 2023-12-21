Return-Path: <bpf+bounces-18528-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6137181B73E
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 14:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E19FD28251A
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 13:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD63745D7;
	Thu, 21 Dec 2023 13:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="OoYjPYUG"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5109D745CC;
	Thu, 21 Dec 2023 13:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=wwWMQfUL6iKPUoSxhiX/ttRfS/vrNijPEc/Z4JqDUGA=; b=OoYjPYUG+ngLrXiDih9AxnQYA9
	51xNyY+yitE1GQBfslcaQRR8509iB9M/oS5HB5J9t91ylqdMAXlDqCRu/iTDpsNr1/BXPQ2N/eDtr
	xV/d42v2vOJifzPRe97tn89KH74+LPeYJcwM6+rcINgFuO4/tC6m3APyX4Y8NaFP/jma8H0z6bcUV
	FWHfmBIfZ6gg2vZhNLfJhi/hf8ORJ1Q958/o4ivFf2LZbJMDCG3xPaUCHOrQ0wQwx6EXaTALRCWOn
	Xolwd8PYpRu/h8gcOtbn8VXA2VMYI5kQU+YcGEhuo5AyAAfNLKJ6cggUN+UlmUUlWwsnEeOQpkEja
	bGAZwX2g==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rGIzh-000IbH-GS; Thu, 21 Dec 2023 14:21:45 +0100
Received: from [178.197.249.15] (helo=linux.home)
	by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1rGIzg-0004Ww-Rv; Thu, 21 Dec 2023 14:21:44 +0100
Subject: Re: [PATCH bpf 1/2] bpf: Avoid iter->offset making backward progress
 in bpf_iter_udp
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: 'Alexei Starovoitov ' <ast@kernel.org>,
 'Andrii Nakryiko ' <andrii@kernel.org>, netdev@vger.kernel.org,
 kernel-team@meta.com, Aditi Ghag <aditi.ghag@isovalent.com>,
 bpf@vger.kernel.org
References: <20231219193259.3230692-1-martin.lau@linux.dev>
 <8d15f3a7-b7bc-1a45-0bdf-a0ccc311f576@iogearbox.net>
 <fc1b5650-72bb-4b09-bab4-f61b2186f673@linux.dev>
 <9f3697c1-ed15-4a3d-9113-c4437f421bb3@linux.dev>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <8787f5c0-fed0-b8fa-997b-4d17d9966f13@iogearbox.net>
Date: Thu, 21 Dec 2023 14:21:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <9f3697c1-ed15-4a3d-9113-c4437f421bb3@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27130/Thu Dec 21 10:38:20 2023)

On 12/21/23 5:45 AM, Martin KaFai Lau wrote:
> On 12/20/23 11:10 AM, Martin KaFai Lau wrote:
>> Good catch. It will unnecessary skip in the following batch/bucket if there is changes in the current batch/bucket.
>>
>>  From looking at the loop again, I think it is better not to change the iter->offset during the for loop. Only update iter->offset after the for loop has concluded.
>>
>> The non-zero iter->offset is only useful for the first bucket, so does a test on the first bucket (state->bucket == bucket) before skipping sockets. Something like this:
>>
>> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
>> index 89e5a806b82e..a993f364d6ae 100644
>> --- a/net/ipv4/udp.c
>> +++ b/net/ipv4/udp.c
>> @@ -3139,6 +3139,7 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
>>       struct net *net = seq_file_net(seq);
>>       struct udp_table *udptable;
>>       unsigned int batch_sks = 0;
>> +    int bucket, bucket_offset;
>>       bool resized = false;
>>       struct sock *sk;
>>
>> @@ -3162,14 +3163,14 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
>>       iter->end_sk = 0;
>>       iter->st_bucket_done = false;
>>       batch_sks = 0;
>> +    bucket = state->bucket;
>> +    bucket_offset = 0;
>>
>>       for (; state->bucket <= udptable->mask; state->bucket++) {
>>           struct udp_hslot *hslot2 = &udptable->hash2[state->bucket];
>>
>> -        if (hlist_empty(&hslot2->head)) {
>> -            iter->offset = 0;
>> +        if (hlist_empty(&hslot2->head))
>>               continue;
>> -        }
>>
>>           spin_lock_bh(&hslot2->lock);
>>           udp_portaddr_for_each_entry(sk, &hslot2->head) {
>> @@ -3177,8 +3178,9 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
>>                   /* Resume from the last iterated socket at the
>>                    * offset in the bucket before iterator was stopped.
>>                    */
>> -                if (iter->offset) {
>> -                    --iter->offset;
>> +                if (state->bucket == bucket &&
>> +                    bucket_offset < iter->offset) {
>> +                    ++bucket_offset;
>>                       continue;
>>                   }
>>                   if (iter->end_sk < iter->max_sk) {
>> @@ -3192,10 +3194,10 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
>>
>>           if (iter->end_sk)
>>               break;
>> +    }
>>
>> -        /* Reset the current bucket's offset before moving to the next bucket. */
>> +    if (state->bucket != bucket)
>>           iter->offset = 0;
>> -    }
>>
>>       /* All done: no batch made. */
>>       if (!iter->end_sk)
> 
> I think I found another bug in the current bpf_iter_udp_batch(). The "state->bucket--;" at the end of the batch() function is wrong also. It does not need to go back to the previous bucket. After realloc with a larger batch array, it should retry on the "state->bucket" as is. I tried to force the bind() to use bucket 0 and bind a larger so_reuseport set (24 sockets). WARN_ON(state->bucket < 0) triggered.
> 
> Going back to this bug (backward progress on --iter->offset), I think it is a bit cleaner to always reset iter->offset to 0 and advance iter->offset to the resume_offset only when needed. Something like this:

Hm, my assumption was.. why not do something like the below, and fully start over?

I'm mostly puzzled about the side-effects here, in particular, if for the rerun the sockets
in the bucket could already have changed.. maybe I'm still missing something - what do
we need to deal with exactly worst case when we need to go and retry everything, and what
guarantees do we have?

(only compile tested)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 89e5a806b82e..ca62a4bb7bec 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -3138,7 +3138,8 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
  	struct udp_iter_state *state = &iter->state;
  	struct net *net = seq_file_net(seq);
  	struct udp_table *udptable;
-	unsigned int batch_sks = 0;
+	int orig_bucket, orig_offset;
+	unsigned int i, batch_sks = 0;
  	bool resized = false;
  	struct sock *sk;

@@ -3149,7 +3150,8 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
  	}

  	udptable = udp_get_table_seq(seq, net);
-
+	orig_bucket = state->bucket;
+	orig_offset = iter->offset;
  again:
  	/* New batch for the next bucket.
  	 * Iterate over the hash table to find a bucket with sockets matching
@@ -3211,9 +3213,15 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
  	if (!resized && !bpf_iter_udp_realloc_batch(iter, batch_sks * 3 / 2)) {
  		resized = true;
  		/* After allocating a larger batch, retry one more time to grab
-		 * the whole bucket.
+		 * the whole bucket. Drop the current refs since for the next
+		 * attempt the composition could have changed, thus start over.
  		 */
-		state->bucket--;
+		for (i = 0; i < iter->end_sk; i++) {
+			sock_put(iter->batch[i]);
+			iter->batch[i] = NULL;
+		}
+		state->bucket = orig_bucket;
+		iter->offset = orig_offset;
  		goto again;
  	}
  done:

