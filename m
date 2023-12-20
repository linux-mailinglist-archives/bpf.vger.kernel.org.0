Return-Path: <bpf+bounces-18414-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EE081A72C
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 20:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD600B23B1E
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 19:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D471C482F8;
	Wed, 20 Dec 2023 19:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hsMOktk0"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2487482D8
	for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 19:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: multipart/mixed; boundary="------------1yaqfzuwdYihovwSpZrt0VVX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703099466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wcCkl1AOQIamxSZmnPGG3fIdOc3gSJQp4xeQLg1IduA=;
	b=hsMOktk0yXb9xNEeznv0ZHlDlkor8NWXEO31EHglWwQ+zE0GUFgtqjknUAuhT4f33nMLk3
	V195ntZBTuUjc05IVgbCb+QlCIf12Qlrf0f4vk16RcCWTgeWl/toe3GyZpptrJu6ockMk4
	MVDuLLhtlewrC1Gd8xd+UtjZ/jrryeE=
Message-ID: <fc1b5650-72bb-4b09-bab4-f61b2186f673@linux.dev>
Date: Wed, 20 Dec 2023 11:10:59 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf 1/2] bpf: Avoid iter->offset making backward progress
 in bpf_iter_udp
Content-Language: en-US
To: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Cc: 'Alexei Starovoitov ' <ast@kernel.org>,
 'Andrii Nakryiko ' <andrii@kernel.org>, netdev@vger.kernel.org,
 kernel-team@meta.com, Aditi Ghag <aditi.ghag@isovalent.com>
References: <20231219193259.3230692-1-martin.lau@linux.dev>
 <8d15f3a7-b7bc-1a45-0bdf-a0ccc311f576@iogearbox.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <8d15f3a7-b7bc-1a45-0bdf-a0ccc311f576@iogearbox.net>
X-Migadu-Flow: FLOW_OUT

This is a multi-part message in MIME format.
--------------1yaqfzuwdYihovwSpZrt0VVX
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/20/23 6:24 AM, Daniel Borkmann wrote:
> On 12/19/23 8:32 PM, Martin KaFai Lau wrote:
>> From: Martin KaFai Lau <martin.lau@kernel.org>
>>
>> The bpf_iter_udp iterates all udp_sk by iterating the udp_table.
>> The bpf_iter_udp stores all udp_sk of a bucket while iterating
>> the udp_table. The term used in the kernel code is "batch" the
>> whole bucket. The reason for batching is to allow lock_sock() on
>> each socket before calling the bpf prog such that the bpf prog can
>> safely call helper/kfunc that changes the sk's state,
>> e.g. bpf_setsockopt.
>>
>> There is a bug in the bpf_iter_udp_batch() function that stops
>> the userspace from making forward progress.
>>
>> The case that triggers the bug is the userspace passed in
>> a very small read buffer. When the bpf prog does bpf_seq_printf,
>> the userspace read buffer is not enough to capture the whole "batch".
>>
>> When the read buffer is not enough for the whole "batch", the kernel
>> will remember the offset of the batch in iter->offset such that
>> the next userspace read() can continue from where it left off.
>>
>> The kernel will skip the number (== "iter->offset") of sockets in
>> the next read(). However, the code directly decrements the
>> "--iter->offset". This is incorrect because the next read() may
>> not consume the whole "batch" either and the next next read() will
>> start from offset 0.
>>
>> Doing "--iter->offset" is essentially making backward progress.
>> The net effect is the userspace will keep reading from the beginning
>> of a bucket and the process will never finish. "iter->offset" must always
>> go forward until the whole "batch" (or bucket) is consumed by the
>> userspace.
>>
>> This patch fixes it by doing the decrement in a local stack
>> variable.
> 
> nit: Probably makes sense to also state here that bpf_iter_tcp does
> not have this issue, so it's clear from commit message that you did
> also audit the TCP one.

Ack.

> 
>> Cc: Aditi Ghag <aditi.ghag@isovalent.com>
>> Fixes: c96dac8d369f ("bpf: udp: Implement batching for sockets iterator")
>> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
>> ---
>>   net/ipv4/udp.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
>> index 89e5a806b82e..6cf4151c2eb4 100644
>> --- a/net/ipv4/udp.c
>> +++ b/net/ipv4/udp.c
>> @@ -3141,6 +3141,7 @@ static struct sock *bpf_iter_udp_batch(struct seq_file 
>> *seq)
>>       unsigned int batch_sks = 0;
>>       bool resized = false;
>>       struct sock *sk;
>> +    int offset;
>>       /* The current batch is done, so advance the bucket. */
>>       if (iter->st_bucket_done) {
>> @@ -3162,6 +3163,7 @@ static struct sock *bpf_iter_udp_batch(struct seq_file 
>> *seq)
>>       iter->end_sk = 0;
>>       iter->st_bucket_done = false;
>>       batch_sks = 0;
>> +    offset = iter->offset;
>>       for (; state->bucket <= udptable->mask; state->bucket++) {
>>           struct udp_hslot *hslot2 = &udptable->hash2[state->bucket];
>> @@ -3177,8 +3179,8 @@ static struct sock *bpf_iter_udp_batch(struct seq_file 
>> *seq)
>>                   /* Resume from the last iterated socket at the
>>                    * offset in the bucket before iterator was stopped.
>>                    */
>> -                if (iter->offset) {
>> -                    --iter->offset;
>> +                if (offset) {
>> +                    --offset;
>>                       continue;
>>                   }
>>                   if (iter->end_sk < iter->max_sk) {
>>
> 
> Do we also need something like :
> 
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 6cf4151c2eb4..ef4fc436253d 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -3169,7 +3169,7 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
>                  struct udp_hslot *hslot2 = &udptable->hash2[state->bucket];
> 
>                  if (hlist_empty(&hslot2->head)) {
> -                       iter->offset = 0;
> +                       iter->offset = offset = 0;
>                          continue;
>                  }
> 
> @@ -3196,7 +3196,7 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
>                          break;
> 
>                  /* Reset the current bucket's offset before moving to the next 
> bucket. */
> -               iter->offset = 0;
> +               iter->offset = offset = 0;
>          }
> 
>          /* All done: no batch made. */
> 
> For the case when upon retry the current batch is done earlier than expected ?

Good catch. It will unnecessary skip in the following batch/bucket if there is 
changes in the current batch/bucket.

 From looking at the loop again, I think it is better not to change the 
iter->offset during the for loop. Only update iter->offset after the for loop 
has concluded.

The non-zero iter->offset is only useful for the first bucket, so does a test on 
the first bucket (state->bucket == bucket) before skipping sockets. Something 
like this:

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 89e5a806b82e..a993f364d6ae 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -3139,6 +3139,7 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
  	struct net *net = seq_file_net(seq);
  	struct udp_table *udptable;
  	unsigned int batch_sks = 0;
+	int bucket, bucket_offset;
  	bool resized = false;
  	struct sock *sk;

@@ -3162,14 +3163,14 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
  	iter->end_sk = 0;
  	iter->st_bucket_done = false;
  	batch_sks = 0;
+	bucket = state->bucket;
+	bucket_offset = 0;

  	for (; state->bucket <= udptable->mask; state->bucket++) {
  		struct udp_hslot *hslot2 = &udptable->hash2[state->bucket];

-		if (hlist_empty(&hslot2->head)) {
-			iter->offset = 0;
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
+				if (state->bucket == bucket &&
+				    bucket_offset < iter->offset) {
+					++bucket_offset;
  					continue;
  				}
  				if (iter->end_sk < iter->max_sk) {
@@ -3192,10 +3194,10 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)

  		if (iter->end_sk)
  			break;
+	}

-		/* Reset the current bucket's offset before moving to the next bucket. */
+	if (state->bucket != bucket)
  		iter->offset = 0;
-	}

  	/* All done: no batch made. */
  	if (!iter->end_sk)

--------------1yaqfzuwdYihovwSpZrt0VVX
Content-Type: text/plain; charset=UTF-8;
 name="0001-bpf-Avoid-iter-offset-making-backward-progress-in-bp.patch"
Content-Disposition: attachment;
 filename*0="0001-bpf-Avoid-iter-offset-making-backward-progress-in-bp.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSAyZDcwY2JlYjkyZGFmZjg3NmRjZjg4NzMzYjhkNzQ1MzkzZjAzM2IwIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBNYXJ0aW4gS2FGYWkgTGF1IDxtYXJ0aW4ubGF1QGtl
cm5lbC5vcmc+CkRhdGU6IE1vbiwgMTggRGVjIDIwMjMgMTc6MzM6MTAgLTA4MDAKU3ViamVj
dDogW1BBVENIIHYyIGJwZiAxLzJdIGJwZjogQXZvaWQgaXRlci0+b2Zmc2V0IG1ha2luZyBi
YWNrd2FyZCBwcm9ncmVzcwogaW4gYnBmX2l0ZXJfdWRwCgpUaGUgYnBmX2l0ZXJfdWRwIGl0
ZXJhdGVzIGFsbCB1ZHBfc2sgYnkgaXRlcmF0aW5nIHRoZSB1ZHBfdGFibGUuClRoZSBicGZf
aXRlcl91ZHAgc3RvcmVzIGFsbCB1ZHBfc2sgb2YgYSBidWNrZXQgd2hpbGUgaXRlcmF0aW5n
CnRoZSB1ZHBfdGFibGUuIFRoZSB0ZXJtIHVzZWQgaW4gdGhlIGtlcm5lbCBjb2RlIGlzICJi
YXRjaCIgdGhlCndob2xlIGJ1Y2tldC4gVGhlIHJlYXNvbiBmb3IgYmF0Y2hpbmcgaXMgdG8g
YWxsb3cgbG9ja19zb2NrKCkgb24KZWFjaCBzb2NrZXQgYmVmb3JlIGNhbGxpbmcgdGhlIGJw
ZiBwcm9nIHN1Y2ggdGhhdCB0aGUgYnBmIHByb2cgY2FuCnNhZmVseSBjYWxsIGhlbHBlci9r
ZnVuYyB0aGF0IGNoYW5nZXMgdGhlIHNrJ3Mgc3RhdGUsCmUuZy4gYnBmX3NldHNvY2tvcHQu
CgpUaGVyZSBpcyBhIGJ1ZyBpbiB0aGUgYnBmX2l0ZXJfdWRwX2JhdGNoKCkgZnVuY3Rpb24g
dGhhdCBzdG9wcwp0aGUgdXNlcnNwYWNlIGZyb20gbWFraW5nIGZvcndhcmQgcHJvZ3Jlc3Mu
CgpUaGUgY2FzZSB0aGF0IHRyaWdnZXJzIHRoZSBidWcgaXMgdGhlIHVzZXJzcGFjZSBwYXNz
ZWQgaW4KYSB2ZXJ5IHNtYWxsIHJlYWQgYnVmZmVyLiBXaGVuIHRoZSBicGYgcHJvZyBkb2Vz
IGJwZl9zZXFfcHJpbnRmLAp0aGUgdXNlcnNwYWNlIHJlYWQgYnVmZmVyIGlzIG5vdCBlbm91
Z2ggdG8gY2FwdHVyZSB0aGUgd2hvbGUgImJhdGNoIi4KCldoZW4gdGhlIHJlYWQgYnVmZmVy
IGlzIG5vdCBlbm91Z2ggZm9yIHRoZSB3aG9sZSAiYmF0Y2giLCB0aGUga2VybmVsCndpbGwg
cmVtZW1iZXIgdGhlIG9mZnNldCBvZiB0aGUgYmF0Y2ggaW4gaXRlci0+b2Zmc2V0IHN1Y2gg
dGhhdAp0aGUgbmV4dCB1c2Vyc3BhY2UgcmVhZCgpIGNhbiBjb250aW51ZSBmcm9tIHdoZXJl
IGl0IGxlZnQgb2ZmLgoKVGhlIGtlcm5lbCB3aWxsIHNraXAgdGhlIG51bWJlciAoPT0gIml0
ZXItPm9mZnNldCIpIG9mIHNvY2tldHMgaW4KdGhlIG5leHQgcmVhZCgpLiBIb3dldmVyLCB0
aGUgY29kZSBkaXJlY3RseSBkZWNyZW1lbnRzIHRoZQoiLS1pdGVyLT5vZmZzZXQiLiBUaGlz
IGlzIGluY29ycmVjdCBiZWNhdXNlIHRoZSBuZXh0IHJlYWQoKSBtYXkKbm90IGNvbnN1bWUg
dGhlIHdob2xlICJiYXRjaCIgZWl0aGVyIGFuZCB0aGUgbmV4dCBuZXh0IHJlYWQoKSB3aWxs
CnN0YXJ0IGZyb20gb2Zmc2V0IDAuCgpEb2luZyAiLS1pdGVyLT5vZmZzZXQiIGlzIGVzc2Vu
dGlhbGx5IG1ha2luZyBiYWNrd2FyZCBwcm9ncmVzcy4KVGhlIG5ldCBlZmZlY3QgaXMgdGhl
IHVzZXJzcGFjZSB3aWxsIGtlZXAgcmVhZGluZyBmcm9tIHRoZSBiZWdpbm5pbmcKb2YgYSBi
dWNrZXQgYW5kIHRoZSBwcm9jZXNzIHdpbGwgbmV2ZXIgZmluaXNoLiAiaXRlci0+b2Zmc2V0
IiBtdXN0IGFsd2F5cwpnbyBmb3J3YXJkIHVudGlsIHRoZSB3aG9sZSAiYmF0Y2giIChvciBi
dWNrZXQpIGlzIGNvbnN1bWVkIGJ5IHRoZQp1c2Vyc3BhY2UuCgpUaGlzIHBhdGNoIGZpeGVz
IGl0IGJ5IGRvaW5nIHRoZSBkZWNyZW1lbnQgaW4gYSBsb2NhbCBzdGFjawp2YXJpYWJsZS4K
CkNjOiBBZGl0aSBHaGFnIDxhZGl0aS5naGFnQGlzb3ZhbGVudC5jb20+CkZpeGVzOiBjOTZk
YWM4ZDM2OWYgKCJicGY6IHVkcDogSW1wbGVtZW50IGJhdGNoaW5nIGZvciBzb2NrZXRzIGl0
ZXJhdG9yIikKU2lnbmVkLW9mZi1ieTogTWFydGluIEthRmFpIExhdSA8bWFydGluLmxhdUBr
ZXJuZWwub3JnPgotLS0KIG5ldC9pcHY0L3VkcC5jIHwgMTYgKysrKysrKysrLS0tLS0tLQog
MSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS9uZXQvaXB2NC91ZHAuYyBiL25ldC9pcHY0L3VkcC5jCmluZGV4IDg5ZTVhODA2
YjgyZS4uYTk5M2YzNjRkNmFlIDEwMDY0NAotLS0gYS9uZXQvaXB2NC91ZHAuYworKysgYi9u
ZXQvaXB2NC91ZHAuYwpAQCAtMzEzOSw2ICszMTM5LDcgQEAgc3RhdGljIHN0cnVjdCBzb2Nr
ICpicGZfaXRlcl91ZHBfYmF0Y2goc3RydWN0IHNlcV9maWxlICpzZXEpCiAJc3RydWN0IG5l
dCAqbmV0ID0gc2VxX2ZpbGVfbmV0KHNlcSk7CiAJc3RydWN0IHVkcF90YWJsZSAqdWRwdGFi
bGU7CiAJdW5zaWduZWQgaW50IGJhdGNoX3NrcyA9IDA7CisJaW50IGJ1Y2tldCwgYnVja2V0
X29mZnNldDsKIAlib29sIHJlc2l6ZWQgPSBmYWxzZTsKIAlzdHJ1Y3Qgc29jayAqc2s7CiAK
QEAgLTMxNjIsMTQgKzMxNjMsMTQgQEAgc3RhdGljIHN0cnVjdCBzb2NrICpicGZfaXRlcl91
ZHBfYmF0Y2goc3RydWN0IHNlcV9maWxlICpzZXEpCiAJaXRlci0+ZW5kX3NrID0gMDsKIAlp
dGVyLT5zdF9idWNrZXRfZG9uZSA9IGZhbHNlOwogCWJhdGNoX3NrcyA9IDA7CisJYnVja2V0
ID0gc3RhdGUtPmJ1Y2tldDsKKwlidWNrZXRfb2Zmc2V0ID0gMDsKIAogCWZvciAoOyBzdGF0
ZS0+YnVja2V0IDw9IHVkcHRhYmxlLT5tYXNrOyBzdGF0ZS0+YnVja2V0KyspIHsKIAkJc3Ry
dWN0IHVkcF9oc2xvdCAqaHNsb3QyID0gJnVkcHRhYmxlLT5oYXNoMltzdGF0ZS0+YnVja2V0
XTsKIAotCQlpZiAoaGxpc3RfZW1wdHkoJmhzbG90Mi0+aGVhZCkpIHsKLQkJCWl0ZXItPm9m
ZnNldCA9IDA7CisJCWlmIChobGlzdF9lbXB0eSgmaHNsb3QyLT5oZWFkKSkKIAkJCWNvbnRp
bnVlOwotCQl9CiAKIAkJc3Bpbl9sb2NrX2JoKCZoc2xvdDItPmxvY2spOwogCQl1ZHBfcG9y
dGFkZHJfZm9yX2VhY2hfZW50cnkoc2ssICZoc2xvdDItPmhlYWQpIHsKQEAgLTMxNzcsOCAr
MzE3OCw5IEBAIHN0YXRpYyBzdHJ1Y3Qgc29jayAqYnBmX2l0ZXJfdWRwX2JhdGNoKHN0cnVj
dCBzZXFfZmlsZSAqc2VxKQogCQkJCS8qIFJlc3VtZSBmcm9tIHRoZSBsYXN0IGl0ZXJhdGVk
IHNvY2tldCBhdCB0aGUKIAkJCQkgKiBvZmZzZXQgaW4gdGhlIGJ1Y2tldCBiZWZvcmUgaXRl
cmF0b3Igd2FzIHN0b3BwZWQuCiAJCQkJICovCi0JCQkJaWYgKGl0ZXItPm9mZnNldCkgewot
CQkJCQktLWl0ZXItPm9mZnNldDsKKwkJCQlpZiAoc3RhdGUtPmJ1Y2tldCA9PSBidWNrZXQg
JiYKKwkJCQkgICAgYnVja2V0X29mZnNldCA8IGl0ZXItPm9mZnNldCkgeworCQkJCQkrK2J1
Y2tldF9vZmZzZXQ7CiAJCQkJCWNvbnRpbnVlOwogCQkJCX0KIAkJCQlpZiAoaXRlci0+ZW5k
X3NrIDwgaXRlci0+bWF4X3NrKSB7CkBAIC0zMTkyLDEwICszMTk0LDEwIEBAIHN0YXRpYyBz
dHJ1Y3Qgc29jayAqYnBmX2l0ZXJfdWRwX2JhdGNoKHN0cnVjdCBzZXFfZmlsZSAqc2VxKQog
CiAJCWlmIChpdGVyLT5lbmRfc2spCiAJCQlicmVhazsKKwl9CiAKLQkJLyogUmVzZXQgdGhl
IGN1cnJlbnQgYnVja2V0J3Mgb2Zmc2V0IGJlZm9yZSBtb3ZpbmcgdG8gdGhlIG5leHQgYnVj
a2V0LiAqLworCWlmIChzdGF0ZS0+YnVja2V0ICE9IGJ1Y2tldCkKIAkJaXRlci0+b2Zmc2V0
ID0gMDsKLQl9CiAKIAkvKiBBbGwgZG9uZTogbm8gYmF0Y2ggbWFkZS4gKi8KIAlpZiAoIWl0
ZXItPmVuZF9zaykKLS0gCjIuMzQuMQoK

--------------1yaqfzuwdYihovwSpZrt0VVX--

