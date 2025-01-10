Return-Path: <bpf+bounces-48586-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2ECA09C84
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 21:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B9AE16B4FC
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 20:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23EF214A9E;
	Fri, 10 Jan 2025 20:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="W7WLw5yK"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12DE217705
	for <bpf@vger.kernel.org>; Fri, 10 Jan 2025 20:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736541386; cv=none; b=tXMivjh9VBNxbYYDBuIjzdzMWrixdBeI+lF5AIMZvQKmSffJx7QQpWILDXPyMEpaTEW5I9mdbKb7YsB7ALkBZ8jRyJfVcHR+tflVcJ8iEkhuDeUs8/1gLT7PCH4ti4gi466/QWQZFgOo4w2JJ2BbFmTaekv9Co3VrYDhRzCuXWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736541386; c=relaxed/simple;
	bh=BZdSok9f0meTDSP3Jg10Byz5VF4Lmr6GW56mmZpWeF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=riIzvYqul4hEHdbY86dzbCRKL6vnCj/7bRdT2s0f4nCWYSmsdpeqohzCcmgKv47WBoTP6ERRLUmTJ4iVXESJZrtntIA2nOcbsgviOUDj/tDnQOwRPpcuf2p+lKKQbq0654ClOeDUWI4k9L1k3fsieO5GXn6JeG91PBJjwQescL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=W7WLw5yK; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <13c5a76b-0635-42ed-8dfa-4f656a03a564@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736541366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fwTQN/pQB2BWOlmjlcqzPPtf3JOgHNG/OoTOYZ4cqBk=;
	b=W7WLw5yK/CAAq5XOdVTYJi+j2GDfTrhP/mfD6We8UgqjoWrc4reXyavXTJJkIg5baCjyit
	5j8TEmB2EsNQJarD/DJu94gu4+lRTBSU3QW8o9MHbK2kh+La8MkhpLquC4KaGhpBjOLMXC
	EeVVUukjDCaUWWlL2jGlSm4jI98N2wY=
Date: Fri, 10 Jan 2025 12:35:57 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4 10/11] net-timestamp: export the tskey for TCP
 bpf extension
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
References: <20241207173803.90744-1-kerneljasonxing@gmail.com>
 <20241207173803.90744-11-kerneljasonxing@gmail.com>
 <9f5081bb-ed66-4171-acef-786ae02cf69c@linux.dev>
 <CAL+tcoCSrBBaW3Rg1hD0mBAGu_ZTCTfjVBGe_7B=_JB+uJTuYA@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAL+tcoCSrBBaW3Rg1hD0mBAGu_ZTCTfjVBGe_7B=_JB+uJTuYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/7/25 8:21 PM, Jason Xing wrote:
> Hi Martin,
> 
>>> -     bpf_skops_tx_timestamping(sk, skb, op, 2, args);
>>> +     if (sk_is_tcp(sk))
>>> +             args[2] = skb_shinfo(skb)->tskey;
>>
>> Instead of only passing one info "skb_shinfo(skb)->tskey" of a skb, pass the
>> whole skb ptr to the bpf prog. Take a look at bpf_skops_init_skb. Lets start
>> with end_offset = 0 for now so that the bpf prog won't use it to read the
>> skb->data. It can be revisited later.
>>
>>          bpf_skops_init_skb(&sock_ops, skb, 0);
>>
>> The bpf prog can use bpf_cast_to_kern_ctx() and bpf_core_cast() to get to the
>> skb_shinfo(skb). Take a look at the md_skb example in type_cast.c.
> 
> In recent days, I've been working on this part. It turns out to be
> infeasible to pass "struct __sk_buff *skb" as the second parameter in
> skops_sockopt() in patch [11/11]. I cannot find a way to acquire the
> skb itself

I didn't mean to pass skb in sock_ops_kern->args[] or pass skb to the bpf prog
"SEC("sockops") skops_sockopt(struct bpf_sock_ops *skops, struct sk_buff *skb)".
The bpf prog can only take one ctx argument which is
"struct bpf_sock_ops *skops" here.

I meant to have kernel initializing the sock_ops_kern->skb by doing
"bpf_skops_init_skb(&sock_ops, skb, 0);" before running the bpf prog.

The bpf prog can read the skb by using bpf_cast_to_kern_ctx() and bpf_core_cast().

Something like the following. I directly change the existing test_tcp_hdr_options.c.
It has not been changed to use the vmlinux.h, so I need to redefine some parts of
the sk_buff, skb_shared_info, and bpf_sock_ops_kern. Your new test should directly
include <vmlinux.h> and no need to redefine them.

Untested code:

diff --git i/tools/testing/selftests/bpf/progs/test_tcp_hdr_options.c w/tools/testing/selftests/bpf/progs/test_tcp_hdr_options.c
index 5f4e87ee949a..c98ebe71f6ba 100644
--- i/tools/testing/selftests/bpf/progs/test_tcp_hdr_options.c
+++ w/tools/testing/selftests/bpf/progs/test_tcp_hdr_options.c
@@ -12,8 +12,10 @@
  #include <linux/types.h>
  #include <bpf/bpf_helpers.h>
  #include <bpf/bpf_endian.h>
+#include <bpf/bpf_core_read.h>
  #define BPF_PROG_TEST_TCP_HDR_OPTIONS
  #include "test_tcp_hdr_options.h"
+#include "bpf_kfuncs.h"
  
  #ifndef sizeof_field
  #define sizeof_field(TYPE, MEMBER) sizeof((((TYPE *)0)->MEMBER))
@@ -348,9 +350,63 @@ static int current_mss_opt_len(struct bpf_sock_ops *skops)
  	return CG_OK;
  }
  
+struct sk_buff {
+	unsigned int		end;
+	unsigned char		*head;
+} __attribute__((preserve_access_index));
+
+struct skb_shared_info {
+	__u8		flags;
+	__u8		meta_len;
+	__u8		nr_frags;
+	__u8		tx_flags;
+	unsigned short	gso_size;
+	unsigned short	gso_segs;
+	unsigned int	gso_type;
+	__u32		tskey;
+} __attribute__((preserve_access_index));
+
+struct bpf_sock_ops_kern {
+	struct	sock *sk;
+	union {
+		__u32 args[4];
+		__u32 reply;
+		__u32 replylong[4];
+	};
+	struct sk_buff	*syn_skb;
+	struct sk_buff	*skb;
+	void	*skb_data_end;
+	__u8	op;
+	__u8	is_fullsock;
+	__u8	remaining_opt_len;
+	__u64	temp;			/* temp and everything after is not
+					 * initialized to 0 before calling
+					 * the BPF program. New fields that
+					 * should be initialized to 0 should
+					 * be inserted before temp.
+					 * temp is scratch storage used by
+					 * sock_ops_convert_ctx_access
+					 * as temporary storage of a register.
+					 */
+} __attribute__((preserve_access_index));
+
  static int handle_hdr_opt_len(struct bpf_sock_ops *skops)
  {
  	__u8 tcp_flags = skops_tcp_flags(skops);
+	struct bpf_sock_ops_kern *skops_kern;
+	struct skb_shared_info *shared_info;
+	struct sk_buff *skb;
+
+	skops_kern = bpf_cast_to_kern_ctx(skops);
+	skb = skops_kern->skb;
+
+	if (skb) {
+		shared_info = bpf_core_cast(skb->head + skb->end, struct skb_shared_info);
+		/* printk as an example. don't do that in selftests. */
+		bpf_printk("tskey %u gso_size %u gso_segs %u gso_type %u flags %x\n",
+			   shared_info->tskey, shared_info->gso_size,
+			   shared_info->gso_segs, shared_info->gso_type, shared_info->flags);
+	}
  
  	if ((tcp_flags & TCPHDR_SYNACK) == TCPHDR_SYNACK)
  		return synack_opt_len(skops);



