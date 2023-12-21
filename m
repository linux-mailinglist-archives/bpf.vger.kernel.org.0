Return-Path: <bpf+bounces-18484-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0325E81AE1B
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 05:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08110B23195
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 04:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4B38487;
	Thu, 21 Dec 2023 04:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ht5ME5rv"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDE38BED
	for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 04:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9f3697c1-ed15-4a3d-9113-c4437f421bb3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703133914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DHb76aSNb1k1y8CaP40aRSr7bCjiDbODP1MzfmC5MjU=;
	b=Ht5ME5rvebzLnnielGBDTsqP6zUs+njqfZcoCsI1DrfreqvT8cdBej7mAqHpyIEGUjMQyg
	Pf3JV5S8jaeSuT/Ugqdjpm+f3iUA40SMnr4DfMdMmiseHk5Hkitm0h4dKVRPzvnu8rDTCl
	DQJA45ckgVoVwgKtzDUceUV2n0tjnO8=
Date: Wed, 20 Dec 2023 20:45:08 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf 1/2] bpf: Avoid iter->offset making backward progress
 in bpf_iter_udp
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: 'Alexei Starovoitov ' <ast@kernel.org>,
 'Andrii Nakryiko ' <andrii@kernel.org>, netdev@vger.kernel.org,
 kernel-team@meta.com, Aditi Ghag <aditi.ghag@isovalent.com>,
 bpf@vger.kernel.org
References: <20231219193259.3230692-1-martin.lau@linux.dev>
 <8d15f3a7-b7bc-1a45-0bdf-a0ccc311f576@iogearbox.net>
 <fc1b5650-72bb-4b09-bab4-f61b2186f673@linux.dev>
In-Reply-To: <fc1b5650-72bb-4b09-bab4-f61b2186f673@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 12/20/23 11:10 AM, Martin KaFai Lau wrote:
> Good catch. It will unnecessary skip in the following batch/bucket if there is 
> changes in the current batch/bucket.
> 
>  From looking at the loop again, I think it is better not to change the 
> iter->offset during the for loop. Only update iter->offset after the for loop 
> has concluded.
> 
> The non-zero iter->offset is only useful for the first bucket, so does a test on 
> the first bucket (state->bucket == bucket) before skipping sockets. Something 
> like this:
> 
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 89e5a806b82e..a993f364d6ae 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -3139,6 +3139,7 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
>       struct net *net = seq_file_net(seq);
>       struct udp_table *udptable;
>       unsigned int batch_sks = 0;
> +    int bucket, bucket_offset;
>       bool resized = false;
>       struct sock *sk;
> 
> @@ -3162,14 +3163,14 @@ static struct sock *bpf_iter_udp_batch(struct seq_file 
> *seq)
>       iter->end_sk = 0;
>       iter->st_bucket_done = false;
>       batch_sks = 0;
> +    bucket = state->bucket;
> +    bucket_offset = 0;
> 
>       for (; state->bucket <= udptable->mask; state->bucket++) {
>           struct udp_hslot *hslot2 = &udptable->hash2[state->bucket];
> 
> -        if (hlist_empty(&hslot2->head)) {
> -            iter->offset = 0;
> +        if (hlist_empty(&hslot2->head))
>               continue;
> -        }
> 
>           spin_lock_bh(&hslot2->lock);
>           udp_portaddr_for_each_entry(sk, &hslot2->head) {
> @@ -3177,8 +3178,9 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
>                   /* Resume from the last iterated socket at the
>                    * offset in the bucket before iterator was stopped.
>                    */
> -                if (iter->offset) {
> -                    --iter->offset;
> +                if (state->bucket == bucket &&
> +                    bucket_offset < iter->offset) {
> +                    ++bucket_offset;
>                       continue;
>                   }
>                   if (iter->end_sk < iter->max_sk) {
> @@ -3192,10 +3194,10 @@ static struct sock *bpf_iter_udp_batch(struct seq_file 
> *seq)
> 
>           if (iter->end_sk)
>               break;
> +    }
> 
> -        /* Reset the current bucket's offset before moving to the next bucket. */
> +    if (state->bucket != bucket)
>           iter->offset = 0;
> -    }
> 
>       /* All done: no batch made. */
>       if (!iter->end_sk)

I think I found another bug in the current bpf_iter_udp_batch(). The 
"state->bucket--;" at the end of the batch() function is wrong also. It does not 
need to go back to the previous bucket. After realloc with a larger batch array, 
it should retry on the "state->bucket" as is. I tried to force the bind() to use 
bucket 0 and bind a larger so_reuseport set (24 sockets). WARN_ON(state->bucket 
< 0) triggered.

Going back to this bug (backward progress on --iter->offset), I think it is a 
bit cleaner to always reset iter->offset to 0 and advance iter->offset to the 
resume_offset only when needed. Something like this:

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 89e5a806b82e..184aa966a006 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -3137,16 +3137,18 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
  	struct bpf_udp_iter_state *iter = seq->private;
  	struct udp_iter_state *state = &iter->state;
  	struct net *net = seq_file_net(seq);
+	int resume_bucket, resume_offset;
  	struct udp_table *udptable;
  	unsigned int batch_sks = 0;
  	bool resized = false;
  	struct sock *sk;

+	resume_bucket = state->bucket;
+	resume_offset = iter->offset;
+
  	/* The current batch is done, so advance the bucket. */
-	if (iter->st_bucket_done) {
+	if (iter->st_bucket_done)
  		state->bucket++;
-		iter->offset = 0;
-	}

  	udptable = udp_get_table_seq(seq, net);

@@ -3166,10 +3168,9 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
  	for (; state->bucket <= udptable->mask; state->bucket++) {
  		struct udp_hslot *hslot2 = &udptable->hash2[state->bucket];

-		if (hlist_empty(&hslot2->head)) {
-			iter->offset = 0;
+		iter->offset = 0;
+		if (hlist_empty(&hslot2->head))
  			continue;
-		}

  		spin_lock_bh(&hslot2->lock);
  		udp_portaddr_for_each_entry(sk, &hslot2->head) {
@@ -3177,8 +3178,9 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
  				/* Resume from the last iterated socket at the
  				 * offset in the bucket before iterator was stopped.
  				 */
-				if (iter->offset) {
-					--iter->offset;
+				if (state->bucket == resume_bucket &&
+				    iter->offset < resume_offset) {
+					++iter->offset;
  					continue;
  				}
  				if (iter->end_sk < iter->max_sk) {
@@ -3192,9 +3194,6 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)

  		if (iter->end_sk)
  			break;
-
-		/* Reset the current bucket's offset before moving to the next bucket. */
-		iter->offset = 0;
  	}

  	/* All done: no batch made. */
@@ -3210,10 +3209,6 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
  	}
  	if (!resized && !bpf_iter_udp_realloc_batch(iter, batch_sks * 3 / 2)) {
  		resized = true;
-		/* After allocating a larger batch, retry one more time to grab
-		 * the whole bucket.
-		 */
-		state->bucket--;
  		goto again;
  	}
  done:


