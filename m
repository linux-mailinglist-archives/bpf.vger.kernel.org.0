Return-Path: <bpf+bounces-50834-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FFAA2D2EB
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 03:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 949117A1B3A
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 02:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD9314900F;
	Sat,  8 Feb 2025 02:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B0iPr+38"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B4E8F5C
	for <bpf@vger.kernel.org>; Sat,  8 Feb 2025 02:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738980693; cv=none; b=CPzsUTYK0Sfnf7wkPXOvytDuy22BnaNOzQne7QJr8Ondi3n1f4X5lRXuS6z5UNsKA3biouukDCH5IQbvacLxfFRQ4kT8nL/Ntsiuzs0zqL+768sLBg8uOlJVmD17NXpArsbv4YIEzmObVfnQCVDlX2tIxPG6xi0qXk/01h7QGv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738980693; c=relaxed/simple;
	bh=rFIgJLjvjBmdQVj7HpSX+tKQz1B4bFr6HVBzXz3wTfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LnZ7lY6cGYWgHi4SFQdb+L1trOXIouwx02GvO77B/jMAmKJcFCaa9Pnt8Zzy5qwUD2i0+tWT00P6i+xnkM690lAAasmgw5H7B0PJ5bJX9Phgi+y0OVO3tH/0y3QqUw9biqDnv8A1u7PedlxR7qAXIq+nIK0U4U1G2StnsuYsmUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B0iPr+38; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1ef7e85b-03b7-4baa-aca2-3c18bf1e16e2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738980688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q2gaEnQLodJsUm1DrhM24t55LvTy5gaOhj7VJhAMMe0=;
	b=B0iPr+38lR+DQUu/Ygu9ZN0sKDbeN+UjKQ+njOGIr5hYyh+QQBeD4O7iPHsyWXb6hVCjLB
	2wcAZsqAYKvNX2p4HUF472E4bD+ZBueQ79Xp9WHgfdOedn7ghLdtzfjCVE0RZkMqKlncKU
	Qy8zCgIU/N9zMplzLmZa7RzR2J2oBhI=
Date: Fri, 7 Feb 2025 18:11:15 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v8 10/12] bpf: make TCP tx timestamp bpf
 extension work
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, horms@kernel.org,
 bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20250204183024.87508-1-kerneljasonxing@gmail.com>
 <20250204175744.3f92c33e@kernel.org>
 <e894c427-b4b3-4706-b44c-44fc6402c14c@linux.dev>
 <CAL+tcoCQ165Y4R7UWG=J=8e=EzwFLxSX3MQPOv=kOS3W1Q7R0A@mail.gmail.com>
 <0a8e7b84-bab6-4852-8616-577d9b561f4c@linux.dev>
 <CAL+tcoAp8v49fwUrN5pNkGHPF-+RzDDSNdy3PhVoJ7+MQGNbXQ@mail.gmail.com>
 <CAL+tcoC5hmm1HQdbDaYiQ1iW1x2J+H42RsjbS_ghyG8mSDgqqQ@mail.gmail.com>
 <67a424d2aa9ea_19943029427@willemb.c.googlers.com.notmuch>
 <CAL+tcoCPGAjs=+Hnzr4RLkioUV7nzy=ZmKkTDPA7sBeVP=qzow@mail.gmail.com>
 <67a42ba112990_19c315294b7@willemb.c.googlers.com.notmuch>
 <CAL+tcoC_5106onp6yQh-dKnCTLtEr73EZVC31T_YeMtqbZ5KBw@mail.gmail.com>
 <b158a837-d46c-4ae0-8130-7aa288422182@linux.dev>
 <CAL+tcoCUjxvE-DaQ8AMxMgjLnV+J1jpYMh7BCOow4AohW1FFSg@mail.gmail.com>
 <739d6f98-8a44-446e-85a4-c499d154b57b@linux.dev>
 <CAL+tcoA14HKQmG9dtMdRVqgJJ87hcvynPjqVLkAbHnDcsq-RzQ@mail.gmail.com>
 <CAL+tcoD9qZvbo53QsUcC27Dp=tJshBFdjoM9RCHxHEsYjwaXWg@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAL+tcoD9qZvbo53QsUcC27Dp=tJshBFdjoM9RCHxHEsYjwaXWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2/7/25 4:07 AM, Jason Xing wrote:
> On Fri, Feb 7, 2025 at 10:18 AM Jason Xing <kerneljasonxing@gmail.com> wrote:
>>
>> On Fri, Feb 7, 2025 at 10:07 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>>
>>> On 2/5/25 10:56 PM, Jason Xing wrote:
>>>>>> I have to rephrase a bit in case Martin visits here soon: I will
>>>>>> compare two approaches 1) reply value, 2) bpf kfunc and then see which
>>>>>> way is better.
>>>>>
>>>>> I have already explained in details why the 1) reply value from the bpf prog
>>>>> won't work. Please go back to that reply which has the context.
>>>>
>>>> Yes, of course I saw this, but I said I need to implement and dig more
>>>> into this on my own. One of my replies includes a little code snippet
>>>> regarding reply value approach. I didn't expect you to misunderstand
>>>> that I would choose reply value, so I rephrase it like above :)
>>>
>>> I did see the code snippet which is incomplete, so I have to guess. afaik, it is
>>> not going to work. I was hoping to save some time without detouring to the
>>> reply-value path in case my earlier message was missed. I will stay quiet and
>>> wait for v9 first then to avoid extending this long thread further.
>>
>> I see. I'm grateful that you point out the right path. I'm still
>> investigating to find a good existing example in selftests and how to
>> support kfunc.
> 
> Martin, sorry to revive this thread.
> 
> It's a little bit hard for me to find a proper example to follow. I
> tried to call __bpf_kfunc in the BPF_SOCK_OPS_TS_SND_CB callback and
> then failed because kfunc is not supported in the sock_ops case.
> Later, I tried to kprobe to hook a function, say,
> tcp_tx_timestamp_bpf(), passed the skb parameter to the kfunc and then
> got an error.
> 
> Here is code snippet:
> 1) net/ipv4/tcp.c
> +__bpf_kfunc static void tcp_init_tx_timestamp(struct sk_buff *skb)
> +{
> +       struct skb_shared_info *shinfo = skb_shinfo(skb);
> +       struct tcp_skb_cb *tcb = TCP_SKB_CB(skb);
> +
> +       printk(KERN_ERR "jason: %d, %d\n\n", tcb->txstamp_ack,
> shinfo->tx_flags);
> +       /*
> +       tcb->txstamp_ack = 2;
> +       shinfo->tx_flags |= SKBTX_BPF;
> +       shinfo->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;
> +       */
> +}
> Note: I skipped copying some codes like BTF_ID_FLAGS...

This part is missing, so I can only guess again. This BTF_ID_FLAGS
and the kfunc registration part went wrong when trying to add the
new kfunc for the sock_ops program. There are kfunc examples for
netdev related bpf prog in filter.c. e.g. bpf_sock_addr_set_sun_path.

[ The same goes for another later message where the changes in
   bpf_skops_tx_timestamping is missing, so I won't comment there. ]

> 
> 2) bpf prog
> SEC("kprobe/tcp_tx_timestamp_bpf") // I wrote a new function/wrapper to hook
> int BPF_KPROBE(kprobe__tcp_tx_timestamp_bpf, struct sock *sk, struct
> sk_buff *skb)
> {
>          tcp_init_tx_timestamp(skb);
>          return 0;
> }
> 
> Then running the bpf prog, I got the following message:
> ; tcp_init_tx_timestamp(skb); @ so_timestamping.c:281
> 1: (85) call tcp_init_tx_timestamp#120682
> arg#0 pointer type STRUCT sk_buff must point to scalar, or struct with scalar
> processed 2 insns (limit 1000000) max_states_per_insn 0 total_states 0
> peak_states 0 mark_read 0
> -- END PROG LOAD LOG --
> libbpf: prog 'kprobe__tcp_tx_timestamp_bpf': failed to load: -22
> libbpf: failed to load object 'so_timestamping'
> libbpf: failed to load BPF skeleton 'so_timestamping': -22
> test_so_timestamping:FAIL:open and load skel unexpected error: -22
> 
> If I don't pass any parameter in the kfunc, it can work.
> 
> Should we support the sock_ops for __bpf_kfunc?

sock_ops does support kfunc. The patch 12 selftest is using the
bpf_cast_to_kern_ctx() and it is a kfunc:

--------8<--------
BTF_KFUNCS_START(common_btf_ids)
BTF_ID_FLAGS(func, bpf_cast_to_kern_ctx, KF_FASTCALL)
-------->8--------

It just the new kfunc is not registered at the right place, so the verifier
cannot find it.

Untested code on top of your v8, so I don't have your latest
changes on the txstamp_ack_bpf bits...etc.

diff --git i/kernel/bpf/btf.c w/kernel/bpf/btf.c
index 9433b6467bbe..740210f883dc 100644
--- i/kernel/bpf/btf.c
+++ w/kernel/bpf/btf.c
@@ -8522,6 +8522,7 @@ static int bpf_prog_type_to_kfunc_hook(enum bpf_prog_type prog_type)
  	case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
  	case BPF_PROG_TYPE_CGROUP_SOCKOPT:
  	case BPF_PROG_TYPE_CGROUP_SYSCTL:
+	case BPF_PROG_TYPE_SOCK_OPS:
  		return BTF_KFUNC_HOOK_CGROUP;
  	case BPF_PROG_TYPE_SCHED_ACT:
  		return BTF_KFUNC_HOOK_SCHED_ACT;
diff --git i/net/core/filter.c w/net/core/filter.c
index d3395ffe058e..3bad67eb5c9e 100644
--- i/net/core/filter.c
+++ w/net/core/filter.c
@@ -12102,6 +12102,30 @@ __bpf_kfunc int bpf_sk_assign_tcp_reqsk(struct __sk_buff *s, struct sock *sk,
  #endif
  }
  
+enum {
+	BPF_SOCK_OPS_TX_TSTAMP_TCP_ACK = 1 << 0,
+};
+
+__bpf_kfunc int bpf_sock_ops_enable_tx_tstamp(struct bpf_sock_ops_kern *skops, int flags)
+{
+	struct sk_buff *skb;
+
+	if (skops->op != BPF_SOCK_OPS_TS_SND_CB)
+		return -EOPNOTSUPP;
+
+	if (flags & ~BPF_SOCK_OPS_TX_TSTAMP_TCP_ACK)
+		return -EINVAL;
+
+	skb = skops->skb;
+	/* [REMOVE THIS COMMENT]: sk_is_tcp check will be needed in the future */
+	if (flags & BPF_SOCK_OPS_TX_TSTAMP_TCP_ACK)
+		TCP_SKB_CB(skb)->txstamp_ack_bpf = 1;
+	skb_shinfo(skb)->tx_flags |= SKBTX_BPF;
+	skb_shinfo(skb)->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;
+
+	return 0;
+}
+
  __bpf_kfunc_end_defs();
  
  int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
@@ -12135,6 +12159,10 @@ BTF_KFUNCS_START(bpf_kfunc_check_set_tcp_reqsk)
  BTF_ID_FLAGS(func, bpf_sk_assign_tcp_reqsk, KF_TRUSTED_ARGS)
  BTF_KFUNCS_END(bpf_kfunc_check_set_tcp_reqsk)
  
+BTF_KFUNCS_START(bpf_kfunc_check_set_sock_ops)
+BTF_ID_FLAGS(func, bpf_sock_ops_enable_tx_tstamp, KF_TRUSTED_ARGS)
+BTF_KFUNCS_END(bpf_kfunc_check_set_sock_ops)
+
  static const struct btf_kfunc_id_set bpf_kfunc_set_skb = {
  	.owner = THIS_MODULE,
  	.set = &bpf_kfunc_check_set_skb,
@@ -12155,6 +12183,11 @@ static const struct btf_kfunc_id_set bpf_kfunc_set_tcp_reqsk = {
  	.set = &bpf_kfunc_check_set_tcp_reqsk,
  };
  
+static const struct btf_kfunc_id_set bpf_kfunc_set_sock_ops = {
+	.owner = THIS_MODULE,
+	.set = &bpf_kfunc_check_set_sock_ops,
+};
+
  static int __init bpf_kfunc_init(void)
  {
  	int ret;
@@ -12173,6 +12206,7 @@ static int __init bpf_kfunc_init(void)
  	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &bpf_kfunc_set_xdp);
  	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
  					       &bpf_kfunc_set_sock_addr);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SOCK_OPS, &bpf_kfunc_set_sock_ops);
  	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_tcp_reqsk);
  }

