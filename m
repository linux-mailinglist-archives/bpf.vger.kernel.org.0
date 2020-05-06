Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7654B1C7CDF
	for <lists+bpf@lfdr.de>; Wed,  6 May 2020 23:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729582AbgEFVzO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 May 2020 17:55:14 -0400
Received: from www62.your-server.de ([213.133.104.62]:41388 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729162AbgEFVzO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 May 2020 17:55:14 -0400
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jWS0V-0001Ra-FH; Wed, 06 May 2020 23:55:11 +0200
Received: from [178.195.186.98] (helo=pc-9.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1jWS0V-000VJu-7f; Wed, 06 May 2020 23:55:11 +0200
Subject: Re: Checksum behaviour of bpf_redirected packets
To:     Lorenz Bauer <lmb@cloudflare.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, kernel-team <kernel-team@cloudflare.com>
References: <CACAyw9-uU_52esMd1JjuA80fRPHJv5vsSg8GnfW3t_qDU4aVKQ@mail.gmail.com>
 <CAADnVQKZ63d5A+Jv8bbXzo2RKNCXFH78zos0AjpbJ3ii9OHW0g@mail.gmail.com>
 <CACAyw9_ygNV1J+PkBJ-i7ysU_Y=rN3Z5adKYExNXCic0gumaow@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <39d3bee2-dcfc-8240-4c78-2110d639d386@iogearbox.net>
Date:   Wed, 6 May 2020 23:55:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CACAyw9_ygNV1J+PkBJ-i7ysU_Y=rN3Z5adKYExNXCic0gumaow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.2/25804/Wed May  6 14:13:11 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 5/6/20 6:24 PM, Lorenz Bauer wrote:
> On Wed, 6 May 2020 at 02:28, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>> On Mon, May 4, 2020 at 9:12 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
>>>
>>> In our TC classifier cls_redirect [1], we use the following sequence
>>> of helper calls to
>>> decapsulate a GUE (basically IP + UDP + custom header) encapsulated packet:
>>>
>>>    skb_adjust_room(skb, -encap_len,
>>> BPF_ADJ_ROOM_MAC, BPF_F_ADJ_ROOM_FIXED_GSO)
>>>    bpf_redirect(skb->ifindex, BPF_F_INGRESS)
>>>
>>> It seems like some checksums of the inner headers are not validated in
>>> this case.
>>> For example, a TCP SYN packet with invalid TCP checksum is still accepted by the
>>> network stack and elicits a SYN ACK.
>>>
>>> Is this known but undocumented behaviour or a bug? In either case, is
>>> there a work
>>> around I'm not aware of?
>>
>> I thought inner and outer csums are covered by different flags and driver
>> suppose to set the right one depending on level of in-hw checking it did.
> 
> I've figured out what the problem is. We receive the following packet from
> the driver:
> 
>      | ETH | IP | UDP | GUE | IP | TCP |
>      skb->ip_summed == CHECKSUM_UNNECESSARY
> 
> ip_summed is CHECKSUM_UNNECESSARY because our NICs do rx
> checksum offloading. On this packet we run skb_adjust_room_mac(-encap),
> and get the following:
> 
>      | ETH | IP | TCP |
>      skb->ip_summed == CHECKSUM_UNNECESSARY
> 
> Note that ip_summed is still CHECKSUM_UNNECESSARY. After
> bpf_redirect()ing into the ingress, we end up in tcp_v4_rcv. There
> skb_checksum_init is turned into a no-op due to
> CHECKSUM_UNNECESSARY.
> 
> I think this boils down to bpf_skb_generic_pop not adjusting ip_summed
> accordingly. Unfortunately I don't understand how checksums work
> sufficiently. Daniel, it seems like you wrote the helper, could you
> take a look?

Right, so in the skb_adjust_room() case we're not aware of protocol
specifics. We do handle the csum complete case via skb_postpull_rcsum(),
but not CHECKSUM_UNNECESSARY at the moment. I presume in your case the
skb->csum_level of the original skb prior to skb_adjust_room() call
might have been 0 (that is, covering UDP)? So if we'd add the possibility
to __skb_decr_checksum_unnecessary() via flag, then it would become
skb->ip_summed = CHECKSUM_NONE? And to be generic, we'd need to do the
same for the reverse case. Below is a quick hack (compile tested-only);
would this resolve your case ...

 >>>    skb_adjust_room(skb, -encap_len, BPF_ADJ_ROOM_MAC, BPF_F_ADJ_ROOM_FIXED_GSO|BPF_F_ADJ_ROOM_DEC_CSUM_LEVEL)
 >>>    bpf_redirect(skb->ifindex, BPF_F_INGRESS)

 From 7439724fcfff7742223198c620349a4fc89d4835 Mon Sep 17 00:00:00 2001
Message-Id: <7439724fcfff7742223198c620349a4fc89d4835.1588801971.git.daniel@iogearbox.net>
From: Daniel Borkmann <daniel@iogearbox.net>
Date: Wed, 6 May 2020 23:50:31 +0200
Subject: [PATCH bpf-next] bpf: inc/dec csum level for csum_unnecessary in skb_adjust_room

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
  include/uapi/linux/bpf.h |  2 ++
  net/core/filter.c        | 23 ++++++++++++++++++++---
  2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index b3643e27e264..9877807b8f28 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3279,6 +3279,8 @@ enum {
  	BPF_F_ADJ_ROOM_ENCAP_L3_IPV6	= (1ULL << 2),
  	BPF_F_ADJ_ROOM_ENCAP_L4_GRE	= (1ULL << 3),
  	BPF_F_ADJ_ROOM_ENCAP_L4_UDP	= (1ULL << 4),
+	BPF_F_ADJ_ROOM_INC_CSUM_LEVEL	= (1ULL << 5),
+	BPF_F_ADJ_ROOM_DEC_CSUM_LEVEL	= (1ULL << 6),
  };

  enum {
diff --git a/net/core/filter.c b/net/core/filter.c
index dfaf5df13722..10551dabb7b5 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3008,7 +3008,9 @@ static u32 bpf_skb_net_base_len(const struct sk_buff *skb)
  					 BPF_F_ADJ_ROOM_ENCAP_L4_GRE | \
  					 BPF_F_ADJ_ROOM_ENCAP_L4_UDP | \
  					 BPF_F_ADJ_ROOM_ENCAP_L2( \
-					  BPF_ADJ_ROOM_ENCAP_L2_MASK))
+					  BPF_ADJ_ROOM_ENCAP_L2_MASK) | \
+					 BPF_F_ADJ_ROOM_INC_CSUM_LEVEL | \
+					 BPF_F_ADJ_ROOM_DEC_CSUM_LEVEL)

  static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
  			    u64 flags)
@@ -3019,6 +3021,10 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
  	unsigned int gso_type = SKB_GSO_DODGY;
  	int ret;

+	if (unlikely(flags & ~(BPF_F_ADJ_ROOM_MASK &
+			       ~(BPF_F_ADJ_ROOM_DEC_CSUM_LEVEL))))
+		return -EINVAL;
+
  	if (skb_is_gso(skb) && !skb_is_gso_tcp(skb)) {
  		/* udp gso_size delineates datagrams, only allow if fixed */
  		if (!(skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4) ||
@@ -3105,6 +3111,9 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
  		shinfo->gso_segs = 0;
  	}

+	if (flags & BPF_F_ADJ_ROOM_INC_CSUM_LEVEL)
+		__skb_incr_checksum_unnecessary(skb);
+
  	return 0;
  }

@@ -3113,7 +3122,8 @@ static int bpf_skb_net_shrink(struct sk_buff *skb, u32 off, u32 len_diff,
  {
  	int ret;

-	if (flags & ~BPF_F_ADJ_ROOM_FIXED_GSO)
+	if (unlikely(flags & ~(BPF_F_ADJ_ROOM_FIXED_GSO |
+			       BPF_F_ADJ_ROOM_DEC_CSUM_LEVEL)))
  		return -EINVAL;

  	if (skb_is_gso(skb) && !skb_is_gso_tcp(skb)) {
@@ -3143,6 +3153,9 @@ static int bpf_skb_net_shrink(struct sk_buff *skb, u32 off, u32 len_diff,
  		shinfo->gso_segs = 0;
  	}

+	if (flags & BPF_F_ADJ_ROOM_DEC_CSUM_LEVEL)
+		__skb_decr_checksum_unnecessary(skb);
+
  	return 0;
  }

@@ -3163,7 +3176,11 @@ BPF_CALL_4(bpf_skb_adjust_room, struct sk_buff *, skb, s32, len_diff,
  	u32 off;
  	int ret;

-	if (unlikely(flags & ~BPF_F_ADJ_ROOM_MASK))
+	if (unlikely((flags & ~BPF_F_ADJ_ROOM_MASK) ||
+		     ((flags & (BPF_F_ADJ_ROOM_INC_CSUM_LEVEL |
+				BPF_F_ADJ_ROOM_DEC_CSUM_LEVEL)) ==
+		      (BPF_F_ADJ_ROOM_INC_CSUM_LEVEL |
+		       BPF_F_ADJ_ROOM_DEC_CSUM_LEVEL))))
  		return -EINVAL;
  	if (unlikely(len_diff_abs > 0xfffU))
  		return -EFAULT;
-- 
2.21.0


