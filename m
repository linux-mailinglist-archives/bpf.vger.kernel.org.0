Return-Path: <bpf+bounces-18389-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A08A981A113
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 15:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C53BB1C2284F
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 14:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38A338F8B;
	Wed, 20 Dec 2023 14:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="oHd6XX0s"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454CC38F88;
	Wed, 20 Dec 2023 14:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=UPAY1E0wL5ALLv3v/5uHx+POKgAXUCszv3g45qkQTjg=; b=oHd6XX0s3bO+S+CzpEF1RTTZFV
	m/CMlkVGJbqr1N/CjXZ7ZniNZTrIdnV3G4bASNiR5MQ0W9b7pDQJjrsZffGg6N1i5J4z3HjiZadZv
	WTKaVfyzKWZ5TUP4y0Uw9s5YhziZTGSoapPjU6xAVqriw8yF126YSb5l26kd4iFTDO04L31lTlphG
	QUVyUq1cK38ZJvmVNphfUWru7saRl6Py2+jvoyx4rPMTLXhxfhSLTW2MbrFQ4EBfpZkaUco/ALBeG
	9mR40hJ8usNIoBuwprpDq9heJ5aU10dQPNj/HXZaZlRq/sMrbGbuKJ5gDmqkXGnBnXNXN4CojYzfq
	GrtEks2g==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rFxV0-000H7f-7K; Wed, 20 Dec 2023 15:24:38 +0100
Received: from [178.197.249.36] (helo=linux.home)
	by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1rFxUz-0005Ld-Ok; Wed, 20 Dec 2023 15:24:37 +0100
Subject: Re: [PATCH bpf 1/2] bpf: Avoid iter->offset making backward progress
 in bpf_iter_udp
To: Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Cc: 'Alexei Starovoitov ' <ast@kernel.org>,
 'Andrii Nakryiko ' <andrii@kernel.org>, netdev@vger.kernel.org,
 kernel-team@meta.com, Aditi Ghag <aditi.ghag@isovalent.com>
References: <20231219193259.3230692-1-martin.lau@linux.dev>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <8d15f3a7-b7bc-1a45-0bdf-a0ccc311f576@iogearbox.net>
Date: Wed, 20 Dec 2023 15:24:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231219193259.3230692-1-martin.lau@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27129/Wed Dec 20 10:38:37 2023)

On 12/19/23 8:32 PM, Martin KaFai Lau wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
> 
> The bpf_iter_udp iterates all udp_sk by iterating the udp_table.
> The bpf_iter_udp stores all udp_sk of a bucket while iterating
> the udp_table. The term used in the kernel code is "batch" the
> whole bucket. The reason for batching is to allow lock_sock() on
> each socket before calling the bpf prog such that the bpf prog can
> safely call helper/kfunc that changes the sk's state,
> e.g. bpf_setsockopt.
> 
> There is a bug in the bpf_iter_udp_batch() function that stops
> the userspace from making forward progress.
> 
> The case that triggers the bug is the userspace passed in
> a very small read buffer. When the bpf prog does bpf_seq_printf,
> the userspace read buffer is not enough to capture the whole "batch".
> 
> When the read buffer is not enough for the whole "batch", the kernel
> will remember the offset of the batch in iter->offset such that
> the next userspace read() can continue from where it left off.
> 
> The kernel will skip the number (== "iter->offset") of sockets in
> the next read(). However, the code directly decrements the
> "--iter->offset". This is incorrect because the next read() may
> not consume the whole "batch" either and the next next read() will
> start from offset 0.
> 
> Doing "--iter->offset" is essentially making backward progress.
> The net effect is the userspace will keep reading from the beginning
> of a bucket and the process will never finish. "iter->offset" must always
> go forward until the whole "batch" (or bucket) is consumed by the
> userspace.
> 
> This patch fixes it by doing the decrement in a local stack
> variable.

nit: Probably makes sense to also state here that bpf_iter_tcp does
not have this issue, so it's clear from commit message that you did
also audit the TCP one.

> Cc: Aditi Ghag <aditi.ghag@isovalent.com>
> Fixes: c96dac8d369f ("bpf: udp: Implement batching for sockets iterator")
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> ---
>   net/ipv4/udp.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 89e5a806b82e..6cf4151c2eb4 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -3141,6 +3141,7 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
>   	unsigned int batch_sks = 0;
>   	bool resized = false;
>   	struct sock *sk;
> +	int offset;
>   
>   	/* The current batch is done, so advance the bucket. */
>   	if (iter->st_bucket_done) {
> @@ -3162,6 +3163,7 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
>   	iter->end_sk = 0;
>   	iter->st_bucket_done = false;
>   	batch_sks = 0;
> +	offset = iter->offset;
>   
>   	for (; state->bucket <= udptable->mask; state->bucket++) {
>   		struct udp_hslot *hslot2 = &udptable->hash2[state->bucket];
> @@ -3177,8 +3179,8 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
>   				/* Resume from the last iterated socket at the
>   				 * offset in the bucket before iterator was stopped.
>   				 */
> -				if (iter->offset) {
> -					--iter->offset;
> +				if (offset) {
> +					--offset;
>   					continue;
>   				}
>   				if (iter->end_sk < iter->max_sk) {
> 

Do we also need something like :

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 6cf4151c2eb4..ef4fc436253d 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -3169,7 +3169,7 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
                 struct udp_hslot *hslot2 = &udptable->hash2[state->bucket];

                 if (hlist_empty(&hslot2->head)) {
-                       iter->offset = 0;
+                       iter->offset = offset = 0;
                         continue;
                 }

@@ -3196,7 +3196,7 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
                         break;

                 /* Reset the current bucket's offset before moving to the next bucket. */
-               iter->offset = 0;
+               iter->offset = offset = 0;
         }

         /* All done: no batch made. */

For the case when upon retry the current batch is done earlier than expected ?

Thanks,
Daniel

