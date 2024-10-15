Return-Path: <bpf+bounces-41937-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F6799DBD1
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 03:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFB741F235F9
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 01:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B1F156243;
	Tue, 15 Oct 2024 01:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYBk9dhW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAAA231C83;
	Tue, 15 Oct 2024 01:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728956662; cv=none; b=C73ZACFVnB7EY/5e9okzo9KT8fC838sczDyBmMiCfrIRPpiSHQeG1tJIhHKKkwW3TVwC3j+HyPCltaSCwVMHgRNv0Lb4+LdotpJS3Wqj98WVtwxMBb7//0NNtdOwfZ9PWPyeO8iSas2ms8yXc9tFE0+35C3897nSzsqkfrtgILc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728956662; c=relaxed/simple;
	bh=tww0EGrZFM9yVGnZdp4n9r3fv/kb01t6NO9UadJtPjM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=G3UgLrRZR63kvKHSzcT0xTQ8K6OBXPghtn0y9YAulVZjUUh4YwViprTFCuyv2vl2AlqIqsdfjM9t3U8UD40FML/mlRngzWY/4i+4RDQ2Xb+y/MHfg1pe5kglgJw4iMLrubX3BFREGnKOG6r85CFePvX86A2gKN5wFX2yRNuXLkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jYBk9dhW; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-45f091bf433so40635501cf.3;
        Mon, 14 Oct 2024 18:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728956659; x=1729561459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aBHY8mZ3RrM997cJNFxWigaDQUGN/daRlYu9/8k9Erk=;
        b=jYBk9dhWL+CgICrdQZq3uulhD4AGyQHBpic76MasqR732psh/2ckcnwGACdmwBVQG0
         PnOjiWAjKAZWYwluX1neD7vVyhtocDr9itlYO625fYSy8g/uxEbYhapH4t8LXZKQy62b
         XBw6dKaLrjKyxgOujoNXIrRYaK2tv46xGeIw3+oL+6VZtAWJ/c3DsYNAPo101IV8oEDC
         19dvHhmySySvLrQ1MzlrioRWwed0oZ1QqEHiFHBG2G1BG35X+Ng71d3qmHK8ARPjftjo
         bedl2D62tvC4f0CYEMZ0UZoDo+2Jc5MXeJ/baB/KhMbJWwT7lIjulcpObURbM2WgbB+c
         jvLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728956659; x=1729561459;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aBHY8mZ3RrM997cJNFxWigaDQUGN/daRlYu9/8k9Erk=;
        b=wEJx7mM1MU+cFHfdvz3xsDu0pRTwqsTzj42A8/I6E1RBCZ8e1ZbjgwA55HllmSRY88
         fdF+gxvmX1LpnvPFvFeuRrULmzuCk7F97k0kYefWbgnQMKP19LZkY0EHygUHzbKlY3PN
         ia6epWlA+X/7tdkls/ghshCkLJDm0oOyDX+KjQjvNGXEaDNMcFg9Vn2X0G114OVHYKj3
         gqp61DL2OWjSkWziOiMhsmpRutSXN3kWlSw6blgWEfa6nLM25JSyEIbuuW9ksqmCePD6
         4n1+LwkanmG2FXu1UtQxUZ2/KGJlDoYS0g5Ci28nLcmkrBmPpgzkYKEst3Iy9KTEAL56
         P0GQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1k5ZEYgitX29D2aJBLISddnO8xJHvbLKzBf+FfP4S7Bj15mUWDTtXOU+g0ZqggQfAf5JjaFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUYSl5C+mmdlwVGeZYwxQzQPzffLZLWY5A/qmOREnIcTJMEK4M
	eBMPt2LurY1ZykMhr0fEzC0Kmi3W60uIC4vF6JV8L/hqRg5EFZiH
X-Google-Smtp-Source: AGHT+IG5s5iBo2CCV1YydlaBmAMqYOH8b86VVxAmgnYGmb1dRqhBKf/KrK6/rCowrTr6J6jgPp+asQ==
X-Received: by 2002:a05:620a:4485:b0:7af:c59c:95ca with SMTP id af79cd13be357-7b11a3c2e2dmr2028852385a.64.1728956658798;
        Mon, 14 Oct 2024 18:44:18 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b13617a452sm13170485a.67.2024.10.14.18.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 18:44:18 -0700 (PDT)
Date: Mon, 14 Oct 2024 21:44:17 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 willemb@google.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 martin.lau@linux.dev, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org
Cc: bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <670dc8f1c9e3d_2e1742294ad@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241012040651.95616-12-kerneljasonxing@gmail.com>
References: <20241012040651.95616-1-kerneljasonxing@gmail.com>
 <20241012040651.95616-12-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next v2 11/12] net-timestamp: add bpf framework for rx
 timestamps
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Prepare for later changes in this series. Here I use u32 for
> bpf_sock_ops_cb_flags for better extension and introduce a new
> rx bpf flag to control separately.
> 
> Main change is let userside set through bpf_setsockopt() for
> SO_TIMESTAMPING feature.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  include/linux/tcp.h            |  2 +-
>  include/net/tcp.h              |  2 +-
>  include/uapi/linux/bpf.h       |  5 ++++-
>  net/core/filter.c              |  6 +++++-
>  net/ipv4/tcp.c                 | 13 ++++++++++++-
>  tools/include/uapi/linux/bpf.h |  5 ++++-
>  6 files changed, 27 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> index 6a5e08b937b3..e21fd3035962 100644
> --- a/include/linux/tcp.h
> +++ b/include/linux/tcp.h
> @@ -446,7 +446,7 @@ struct tcp_sock {
>  
>  /* Sock_ops bpf program related variables */
>  #ifdef CONFIG_BPF
> -	u8	bpf_sock_ops_cb_flags;  /* Control calling BPF programs
> +	u32	bpf_sock_ops_cb_flags;  /* Control calling BPF programs
>  					 * values defined in uapi/linux/tcp.h
>  					 */
>  	u8	bpf_chg_cc_inprogress:1; /* In the middle of
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 739a9fb83d0c..728db7107074 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -423,7 +423,7 @@ int tcp_set_rcvlowat(struct sock *sk, int val);
>  int tcp_set_window_clamp(struct sock *sk, int val);
>  void tcp_update_recv_tstamps(struct sk_buff *skb,
>  			     struct scm_timestamping_internal *tss);
> -void tcp_recv_timestamp(struct msghdr *msg, const struct sock *sk,
> +void tcp_recv_timestamp(struct msghdr *msg, struct sock *sk,
>  			struct scm_timestamping_internal *tss);
>  void tcp_data_ready(struct sock *sk);
>  #ifdef CONFIG_MMU
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 1b478ec18ac2..d2754f155cf7 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -6903,8 +6903,11 @@ enum {
>  	/* Call bpf when the kernel is generating tx timestamps.
>  	 */
>  	BPF_SOCK_OPS_TX_TIMESTAMPING_OPT_CB_FLAG = (1<<7),
> +	/* Call bpf when the kernel is generating rx timestamps.
> +	 */
> +	BPF_SOCK_OPS_RX_TIMESTAMPING_OPT_CB_FLAG = (1<<8),
>  /* Mask of all currently supported cb flags */
> -	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0xFF,
> +	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0x1FF,
>  };
>  
>  /* List of known BPF sock_ops operators.
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 3b4afaa273d9..36b357b76f4a 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -5216,14 +5216,18 @@ static int bpf_sock_set_timestamping(struct sock *sk,
>  		return -EINVAL;
>  
>  	if (!(flags & (SOF_TIMESTAMPING_TX_SCHED | SOF_TIMESTAMPING_TX_SOFTWARE |
> -	      SOF_TIMESTAMPING_TX_ACK)))
> +	      SOF_TIMESTAMPING_TX_ACK | SOF_TIMESTAMPING_RX_SOFTWARE)))
>  		return -EINVAL;
>  
>  	ret = sock_set_tskey(sk, flags, BPFPROG_TS_REQUESTOR);
>  	if (ret)
>  		return ret;
>  
> +	if (flags & SOF_TIMESTAMPING_RX_SOFTWARE)
> +		sock_enable_timestamp(sk, SOCK_TIMESTAMPING_RX_SOFTWARE);
> +
>  	WRITE_ONCE(sk->sk_tsflags[BPFPROG_TS_REQUESTOR], flags);
> +
>  	static_branch_enable(&bpf_tstamp_control);
>  
>  	return 0;
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index d37e231b2737..0891b41bc745 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -2260,14 +2260,25 @@ static int tcp_zerocopy_receive(struct sock *sk,
>  }
>  #endif
>  
> +static void tcp_bpf_recv_timestamp(struct sock *sk, struct scm_timestamping_internal *tss)
> +{
> +	struct tcp_sock *tp = tcp_sk(sk);
> +
> +	if (BPF_SOCK_OPS_TEST_FLAG(tp, BPF_SOCK_OPS_RX_TIMESTAMPING_OPT_CB_FLAG))
> +		return;
> +}
> +
>  /* Similar to __sock_recv_timestamp, but does not require an skb */
> -void tcp_recv_timestamp(struct msghdr *msg, const struct sock *sk,
> +void tcp_recv_timestamp(struct msghdr *msg, struct sock *sk,
>  			struct scm_timestamping_internal *tss)
>  {
>  	int new_tstamp = sock_flag(sk, SOCK_TSTAMP_NEW);
>  	u32 tsflags = READ_ONCE(sk->sk_tsflags[SOCKETOPT_TS_REQUESTOR]);
>  	bool has_timestamping = false;
>  
> +	if (static_branch_unlikely(&bpf_tstamp_control))
> +		tcp_bpf_recv_timestamp(sk, tss);
> +
>  	if (tss->ts[0].tv_sec || tss->ts[0].tv_nsec) {
>  		if (sock_flag(sk, SOCK_RCVTSTAMP)) {
>  			if (sock_flag(sk, SOCK_RCVTSTAMPNS)) {

tcp_recv_timestamp is called from tcp_recvmsg only conditionally:

        if ((cmsg_flags || msg->msg_get_inq) && ret >= 0) {
                if (cmsg_flags & TCP_CMSG_TS)
                        tcp_recv_timestamp(msg, sk, &tss);

How do you get this triggered for your BPF program?

And also check the other caller, tcp_zc_finalize_rx_tstamp.

