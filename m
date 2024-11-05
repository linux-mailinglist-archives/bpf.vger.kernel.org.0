Return-Path: <bpf+bounces-43984-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 845E19BC2C4
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 02:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D326282207
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 01:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC63A27713;
	Tue,  5 Nov 2024 01:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xS0x3T97"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AF822F1C
	for <bpf@vger.kernel.org>; Tue,  5 Nov 2024 01:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730771474; cv=none; b=j9rd0EhVxoaAEJo83lFA/cSJJXU+yB8gLqsdOVR2/2x0UIibrnP0/dcKrLIOFR0FnUQcl5gPdHJURDii67edDmduMZgQfaJehan6dsnjzRYp3eAX2U7OShAd7GwhTSfemd0v6/LJvE5jP5hAzwnHV3E7ETTydXz5XmWFE5PaHaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730771474; c=relaxed/simple;
	bh=Lk1jP7OrYR9UC4DLddIR64oH0vcuoRshn46247wRpjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EOYUUf2LgMF7iC4yQgTr2gIoxwhIK3I8+hGr23evan/Qm6T0zs8CWUAYwq2zG2n7h9mmiTY+orMkUDNkYHslQU5scNNOujpKrMOhrhAFSk42P2pb0ZXlP5tErec/5K6yh+3Btxp0iNNxcb97SwlnPXWYNlUy7HsF3/5SSaBtVyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xS0x3T97; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <651bd5a4-adb8-4f18-8eb7-cc781495fcb3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730771469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7wGIMjrLgfL/vvxCG6N7sGg/ILvycsqy3QYg21UjOL4=;
	b=xS0x3T97vKWAmBBNuaErB1/IS7DFtCornjwZwL15L/GrWbDWXhMe92cpncotbzqCiHOZ/J
	TRxco5lP16xzyH7MbObUCIorwauyqGRsvf4rbEnuoXwVR/4yBu/uIBCftYivG2mPOwYuZr
	/RjZ2ZBOMStjJ1r5NfokOkTcNp7pNYQ=
Date: Mon, 4 Nov 2024 17:50:58 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3 02/14] net-timestamp: allow two features to
 work parallelly
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, willemb@google.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 ykolal@fb.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jason Xing <kernelxing@tencent.com>
References: <20241028110535.82999-1-kerneljasonxing@gmail.com>
 <67218fb61dbb5_31d4d029455@willemb.c.googlers.com.notmuch>
 <CAL+tcoBhfZ4XB5QgCKKbNyq+dfm26fPsvXfbWbV=jAEKYeLDEg@mail.gmail.com>
 <67219e5562f8c_37251929465@willemb.c.googlers.com.notmuch>
 <CAL+tcoDonudsr800HmhDir7f0B6cx0RPwmnrsRmQF=yDUJUszg@mail.gmail.com>
 <3c7c5f25-593f-4b48-9274-a18a9ea61e8f@linux.dev>
 <CAL+tcoAy2ryOpLi2am=T68GaFG1ACCtYmcJzDoEOan-0u3aaWw@mail.gmail.com>
 <672269c08bcd5_3c834029423@willemb.c.googlers.com.notmuch>
 <CAL+tcoA7Uddjx3OJzTB3+kqmKRt6KQN4G1VDCbE+xwEhATQpQQ@mail.gmail.com>
 <CAL+tcoDL0by6epqExL0VVMqfveA_awZ3PE9mfwYi3OmovZf3JQ@mail.gmail.com>
 <d138a81d-f9f5-4d51-bedd-3916d377699d@linux.dev>
 <CAL+tcoBfuFL7-EOBY4RLMdDZJcUSyq20pJW13OqzNazUP7=gaw@mail.gmail.com>
 <67237877cd08d_b246b2942b@willemb.c.googlers.com.notmuch>
 <CAL+tcoBpdxtz5GHkTp6e52VDCtyZWvU7+1hTuEo1CnUemj=-eQ@mail.gmail.com>
 <65968a5c-2c67-4b66-8fe0-0cebd2bf9c29@linux.dev>
 <CAL+tcoD6fqrDhYDCFkuSuy-HgORo-qxLLwm+=WQqdQA1=C_S3w@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <CAL+tcoD6fqrDhYDCFkuSuy-HgORo-qxLLwm+=WQqdQA1=C_S3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/1/24 12:47 AM, Jason Xing wrote:

>> If it prefers to stay with bpf_setsockopt (which is fine), it needs a bpf
>> specific optname like the current TCP_BPF_SOCK_OPS_CB_FLAGS which currently sets
>> the tp->bpf_sock_ops_cb_flags. May be a new SK_BPF_CB_FLAGS optname for setting
>> the sk->sk_bpf_cb_flags, like bpf_setsockopt(skops_ctx, SOL_SOCKET,
> 
>> SK_BPF_CB_FLAGS, &val, sizeof(val)) and handle it in the sol_socket_sockopt()
>> alone without calling into sk_{set,get}sockopt. Add a new enum for the optval
>> for the sk_bpf_cb_flags:
>>
>> enum {
>>          SK_BPF_CB_TX_TIMESTAMPING = (1 << 0),
>>          SK_BPF_CB_RX_TIEMSTAMPING = (1 << 1),
>> };
> 
> Then it will involve more strange modification in sol_socket_sockopt()
> to retrieve the opt value like what I did in V2 (see
> https://lore.kernel.org/all/20241012040651.95616-3-kerneljasonxing@gmail.com/).
> It's the reason why I did set and get operation in
> sk_{set,get}sockopt() in this series to keep align with other flags.
> Handling it in sk_{set,get}sockopt() is not a bad idea and easy to
> implement, I feel.

This will look very different now. It is handling bpf specific
optname and accessing the bpf specific field in sk->sk_bpf_cb_flags.

I really don't see why it needs to spill over to sk_{set,get}sockopt()
to handle sk->sk_bpf_cb_flags.

I have quickly typed out a small part of discussion so far.
It is likely buggy and not compiler tested. Pieces are still missing.
The bpf_tstamp_ack will need a few more changes in the
tcp_{input,output}.c. May be merging with the tstamp_ack to become
2 bits will be cleaner, not sure.

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 39f1d16f3628..0b4913315854 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -488,6 +488,7 @@ enum {
  
  	/* generate software time stamp when entering packet scheduling */
  	SKBTX_SCHED_TSTAMP = 1 << 6,
+	SKBTX_BPF = 1 << 7,
  };
  
  #define SKBTX_ANY_SW_TSTAMP	(SKBTX_SW_TSTAMP    | \
diff --git a/include/net/sock.h b/include/net/sock.h
index f29c14448938..4ec27c524f49 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -234,6 +234,20 @@ struct sock_common {
  struct bpf_local_storage;
  struct sk_filter;
  
+enum {
+	SK_BPF_CB_TX_TIMESTAMPING = BIT(0),
+	SK_BPF_CB_RX_TIEMSTAMPING = BIT(1),
+	SK_BPF_CB_MASK		= BIT(2) - 1,
+};
+
+#ifdef CONFIG_BPF_SYSCALL
+#define SK_BPF_CB_FLAG_TEST(SK, FLAG) ((SK)->sk_bpf_cb_flags & (FLAG))
+void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb);
+#else
+#define SK_BPF_CB_FLAG_TEST(SK, FLAG)
+static inline void bpf_skops_timestamping(struct sock *sk, struct sk_buff *skb) {}
+#endif
+
  /**
    *	struct sock - network layer representation of sockets
    *	@__sk_common: shared layout with inet_timewait_sock
@@ -444,7 +458,10 @@ struct sock {
  	socket_lock_t		sk_lock;
  	u32			sk_reserved_mem;
  	int			sk_forward_alloc;
-	u32			sk_tsflags;
+	u16			sk_tsflags;
+#ifdef CONFIG_BPF_SYSCALL
+	u16			sk_bpf_cb_flags;
+#endif
  	__cacheline_group_end(sock_write_rxtx);
  
  	__cacheline_group_begin(sock_write_tx);
diff --git a/include/net/tcp.h b/include/net/tcp.h
index d1948d357dad..224b697bae9d 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -961,7 +961,8 @@ struct tcp_skb_cb {
  	__u8		txstamp_ack:1,	/* Record TX timestamp for ack? */
  			eor:1,		/* Is skb MSG_EOR marked? */
  			has_rxtstamp:1,	/* SKB has a RX timestamp	*/
-			unused:5;
+			bpf_txstamp_ack:1,
+			unused:4;
  	__u32		ack_seq;	/* Sequence number ACK'd	*/
  	union {
  		struct {
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index f28b6527e815..2ff7ff0ebdab 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7014,6 +7014,7 @@ enum {
  					 * by the kernel or the
  					 * earlier bpf-progs.
  					 */
+	BPF_SOCK_OPS_TX_TIMESTAMPING_CB,
  };
  
  /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
@@ -7080,6 +7081,7 @@ enum {
  	TCP_BPF_SYN_IP		= 1006, /* Copy the IP[46] and TCP header */
  	TCP_BPF_SYN_MAC         = 1007, /* Copy the MAC, IP[46], and TCP header */
  	TCP_BPF_SOCK_OPS_CB_FLAGS = 1008, /* Get or Set TCP sock ops flags */
+	SK_BPF_CB_FLAGS		= 1009,
  };
  
  enum {
diff --git a/net/core/filter.c b/net/core/filter.c
index e31ee8be2de0..81a36e50047b 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5206,6 +5206,19 @@ static const struct bpf_func_proto bpf_get_socket_uid_proto = {
  	.arg1_type      = ARG_PTR_TO_CTX,
  };
  
+static int sk_bpf_cb_flags(struct sock *sk, int sk_bpf_cb_flags, bool getopt)
+{
+	if (getopt)
+		return -EINVAL;
+
+	if (sk_bpf_cb_flags & ~SK_BPF_CB_MASK)
+		return -EINVAL;
+
+	sk->sk_bpf_cb_flags = sk->sk_bpf_cb_flags;
+
+	return 0;
+}
+
  static int sol_socket_sockopt(struct sock *sk, int optname,
  			      char *optval, int *optlen,
  			      bool getopt)
@@ -5222,6 +5235,7 @@ static int sol_socket_sockopt(struct sock *sk, int optname,
  	case SO_MAX_PACING_RATE:
  	case SO_BINDTOIFINDEX:
  	case SO_TXREHASH:
+	case SK_BPF_CB_FLAGS:
  		if (*optlen != sizeof(int))
  			return -EINVAL;
  		break;
@@ -5231,6 +5245,9 @@ static int sol_socket_sockopt(struct sock *sk, int optname,
  		return -EINVAL;
  	}
  
+	if (optname == SK_BPF_CB_FLAGS)
+		return sk_bpf_cb_flags(sk, *(int *)optval, getopt);
+
  	if (getopt) {
  		if (optname == SO_BINDTODEVICE)
  			return -EINVAL;
diff --git a/net/core/sock.c b/net/core/sock.c
index 039be95c40cf..d0406639cee9 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -137,6 +137,7 @@
  #include <linux/sock_diag.h>
  
  #include <linux/filter.h>
+#include <linux/bpf-cgroup.h>
  #include <net/sock_reuseport.h>
  #include <net/bpf_sk_storage.h>
  
@@ -946,6 +947,20 @@ int sock_set_timestamping(struct sock *sk, int optname,
  	return 0;
  }
  
+#ifdef CONFIG_BPF_SYSCALL
+void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb)
+{
+	struct bpf_sock_ops_kern sock_ops;
+
+	memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp));
+	sock_ops.op = BPF_SOCK_OPS_TX_TIMESTAMPING_CB;
+	sock_ops.is_fullsock = 1;
+	sock_ops.sk = sk;
+	sock_ops.skb = skb;
+	__cgroup_bpf_run_filter_sock_ops(sk, &sock_ops, CGROUP_SOCK_OPS);
+}
+#endif
+
  void sock_set_keepalive(struct sock *sk)
  {
  	lock_sock(sk);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 4f77bd862e95..1e7f2d5fd792 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -491,6 +491,15 @@ static void tcp_tx_timestamp(struct sock *sk, u16 tsflags)
  		if (tsflags & SOF_TIMESTAMPING_TX_RECORD_MASK)
  			shinfo->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;
  	}
+
+	if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
+	    SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_TX_TIMESTAMPING))
+		/* The bpf prog can do:
+		 * shinfo->tx_flags |= SKBTX_BPF,
+		 * tcb->bpf_txstamp_ack = 1,
+		 * shinfo->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1 (if tskey not set)
+		 */
+		bpf_skops_tx_timestamping(sk, skb);
  }


> 
> Overall the suggestion looks good to me. I can give it a try :)
> 
> I'm thinking of another approach to using bpf_sock_ops_cb_flags_set()
> instead of bpf_setsockopt() when sockops like
> BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB is triggered. I can modify the
> bpf_sock_ops_cb_flags_set like this:
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 58761263176c..001140067c1a 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -5770,14 +5770,25 @@ BPF_CALL_2(bpf_sock_ops_cb_flags_set, struct
> bpf_sock_ops_kern *, bpf_sock,
>             int, argval)
>   {
>          struct sock *sk = bpf_sock->sk;
> -       int val = argval & BPF_SOCK_OPS_ALL_CB_FLAGS;
> +       int val = argval;
> 
> -       if (!IS_ENABLED(CONFIG_INET) || !sk_fullsock(sk))
> +       if (!IS_ENABLED(CONFIG_INET))
>                  return -EINVAL;
> 
> -       tcp_sk(sk)->bpf_sock_ops_cb_flags = val;
> +       if (sk_is_tcp(sk)) {
> +               val = argval & BPF_SOCK_OPS_ALL_CB_FLAGS;
> +               if (!sk_fullsock(sk))
> +                       return -EINVAL;
> +
> +               tcp_sk(sk)->bpf_sock_ops_cb_flags = val;
> +
> +               val = argval & (~BPF_SOCK_OPS_ALL_CB_FLAGS);
> +       } else {
> +               sk->bpf_sock_ops_cb_flags = val;

Why separate tcp vs non-tcp case? The tcp_sk(sk)->bpf_sock_ops_cb_flags
is running out of bits anyway for tcp specific callback.

just keep the SK_BPF_CB_{TX,RX}_TIEMSTAMPING in sk->sk_bpf_cb_flags
for all tcp/udp/raw/...

> +               val = argval &
> (~(SK_BPF_CB_TX_TIEMSTAMPING|SK_BPF_CB_RX_TIEMSTAMPING));

imo, we also don't need to return val to tell the caller what
is not supported in the running kernel. The BPF CO-RE can
handle this also, so less reason to keep extending the
bpf_sock_ops_cb_flags_set API for non tcp.

>>>> For datagrams (UDP as well as RAW and many non IP protocols), an
>>>> alternative still needs to be found.
>>
>> In udp/raw/..., I don't know how likely is the user space having "cork->tx_flags
>> & SKBTX_ANY_TSTAMP" set but has neither "READ_ONCE(sk->sk_tsflags) &
>> SOF_TIMESTAMPING_OPT_ID" nor "cork->flags & IPCORK_TS_OPT_ID" set. If it is
>> unlikely, may be we can just disallow bpf prog from directly setting
>> skb_shinfo(skb)->tskey for this particular skb.
>>
>> For all other cases, in __ip[6]_append_data, directly call a bpf prog and also
>> pass the kernel decided tskey to the bpf prog.
> 
> I'm a bit confused here. IIUC, we need to support the tskey like what
> we did in this series to handle non TCP cases?

Like tcp, I don't think it really needs to use the sk->sk_tskey to mark the
ID of a skb for the non tcp cases also. will comment on another thread.


