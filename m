Return-Path: <bpf+bounces-50514-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53EA7A294DA
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 16:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 845D53AA75B
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 15:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16AB15CD74;
	Wed,  5 Feb 2025 15:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JzqYBdGB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D684CDF71;
	Wed,  5 Feb 2025 15:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738769065; cv=none; b=ukUkK78PiDoUBwt+h5vH7DtLG/63zqi4YrHgv+q+zlK/bYA3Qm22A6AoQkDb/OGUJH9kZPKdCSUCo78qF6VRckMWEXKip+0B06pGTZhFdXWfpRhXTEOBQvo4Y/EwvEiylpbhFiD/1qM3eE/8olkUC5YM3NHYWFP/DbV/9wzb6kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738769065; c=relaxed/simple;
	bh=dv8HLP3F05PqYdwV87e/ievn/CuyNpwK2YX7NHxjO0U=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=QR7u1t0PhYP/VbVx+Zd7l7qFaRPDFxTs8WtNtZPBHEyFTgoH29RwmfsAkSWuLkFnnQPwgI88Tc8F+GqMOWsJQpLuAnEV3W7VmB+S5spr3krCaRVKg3mMRPo9TynkJR3wqWckLMqylXxu2GkqRxIDQBKbZDEkrwGSF/ogZqdeDtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JzqYBdGB; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5187aa2c97dso2289627e0c.2;
        Wed, 05 Feb 2025 07:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738769062; x=1739373862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rKNbZe7n3E6nqx/odfEQajGrQCQKrsVd8pvAp8GgF6A=;
        b=JzqYBdGBlzz5DgJzzvSJAuklTnkbq72JuG9JUuk2ng1Wann7Z+TnWIIJfJqNwg96PZ
         VIG7mkiVM1TVl+dBMo+cSRsMBC/vLOvcKKfvBK/SoG5IHw9gvD83rQvIXCD6+FkCn4vM
         Jg3Rcv+dHiji73oonkF1K6UzmNhfPF/lJs9nF69zoZK4U559VMCPbE5PcECt1t+NRDQ9
         vNmzM0B6AFeDyQUn3pcYmyuMAW1QbbAML/ycByGQ6cU7eGYEuZ2/PuL2JSBZaxSpmwL0
         Ff09a029AS8V3MfpiDdMB7lvDfQdnf1mhJwc9u1+Eq2MOLvhIqtPWRd3gzOzyxiocjhP
         agOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738769062; x=1739373862;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rKNbZe7n3E6nqx/odfEQajGrQCQKrsVd8pvAp8GgF6A=;
        b=ioxLE58yjm95JpdzWY26qvWXIjODlqs3lOBxPXLWA2vMoEkoSq7VNztms15ldmL4nq
         V85OyYvFcxp/PKXvlh581MW/2H98IHzF7r+2SdbJCKsKu83ovLuo/kJAhy18yIPe9WFu
         dOdcqAPskvI6CoRBhr7ukD4yE2Tvaq8zT2Nt+M5uKH7SjPWsdcLITB1gIlHnLzxGU0UC
         IXLGppt4rkE52ouVNWWJAvbYdU7VchAFDS7R5F6xbutE/O5M5GF1UyaXwrezBnbDBOSm
         28s6ymbvRRAtLjgCnW9NZBYYvcHX/9WGDdOg2o9pNAGQl2r6LUwE1muA+3SJW/pc5U8N
         yCgw==
X-Forwarded-Encrypted: i=1; AJvYcCXagADRg0WbqXA6h4scJHK4w88CUZP845WZb/pXYgk869nNotNgQDIJLgW1yMZFeE48c2r+I7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBibZbKkd3ku5RNlGQkyXE7m/s026x76eFUinK8ClTjGHJVXeX
	xXaCN0QGhiojh1bA/GI2doLMcKnL/dU0oQfgJmXp45uyLk1DhrC9
X-Gm-Gg: ASbGncsQXBofZhOwBoO0QXE+7EfHyf/zBl+qiIdJI9pYP70kqMa6EVlulw0pRecUVgu
	kG9OPmt54U68LxlHlhsSkGIeLjISG7aJyPtfvYpKtJjsDReLvCEMfd6eZwkVoAsmaM5iI1oG/ub
	OIpzrmHrsI5lRkpxPtk01oHBnTZfcDBJTi0LFfC7PN/D8kbyd1jB28osr5+2a1Z/mNlW8Jm/X74
	tyAREp2cfdW4TzrSHrkMqCtsDYwmLbR9b/RAWF0l7c3SCsR0UiD3p6DY7gcThBSSj6I35m3SikB
	ab5PeEte3XSvNFzjz0D8sJagiqsFo0FxFB4HzhxcfV22NgUImLJuyXqAfoe+/2c=
X-Google-Smtp-Source: AGHT+IHAaJ9yYPgKgFnuicKzcw2l8m4hKNslINX9n+UuU0d5Ul/LZnX1Azl9WOim7Gse1fDEPIt+rQ==
X-Received: by 2002:a05:6122:378b:b0:51b:a11f:cbdb with SMTP id 71dfb90a1353d-51f0c380b69mr2392399e0c.4.1738769062530;
        Wed, 05 Feb 2025 07:24:22 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-51eb1c0e085sm1824188e0c.11.2025.02.05.07.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 07:24:21 -0800 (PST)
Date: Wed, 05 Feb 2025 10:24:21 -0500
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
 jolsa@kernel.org, 
 horms@kernel.org
Cc: bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kerneljasonxing@gmail.com>
Message-ID: <67a382a56d206_14e083294ef@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250204183024.87508-4-kerneljasonxing@gmail.com>
References: <20250204183024.87508-1-kerneljasonxing@gmail.com>
 <20250204183024.87508-4-kerneljasonxing@gmail.com>
Subject: Re: [PATCH bpf-next v8 03/12] bpf: stop unsafely accessing TCP fields
 in bpf callbacks
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
> The "allow_tcp_access" flag is added to indicate that the callback
> site has a tcp_sock locked.
> 
> Applying the new member allow_tcp_access in the existing callbacks
> where is_fullsock is set to 1 can stop UDP socket accessing struct
> tcp_sock and stop TCP socket without sk lock protecting does the
> similar thing, or else it could be catastrophe leading to panic.
> 
> To keep it simple, instead of distinguishing between read and write
> access, users aren't allowed all read/write access to the tcp_sock
> through the older bpf_sock_ops ctx. The new timestamping callbacks
> can use newer helpers to read everything from a sk (e.g. bpf_core_cast),
> so nothing is lost.
> 
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> ---
>  include/linux/filter.h | 5 +++++
>  include/net/tcp.h      | 1 +
>  net/core/filter.c      | 8 ++++----
>  net/ipv4/tcp_input.c   | 2 ++
>  net/ipv4/tcp_output.c  | 2 ++
>  5 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index a3ea46281595..1569e9f31a8c 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -1508,6 +1508,11 @@ struct bpf_sock_ops_kern {
>  	void	*skb_data_end;
>  	u8	op;
>  	u8	is_fullsock;
> +	u8	allow_tcp_access;	/* Indicate that the callback site
> +					 * has a tcp_sock locked. Then it
> +					 * would be safe to access struct
> +					 * tcp_sock.
> +					 */

perhaps no need for explicit documentation if the variable name is
self documenting: is_locked_tcp_sock

>  	u8	remaining_opt_len;
>  	u64	temp;			/* temp and everything after is not
>  					 * initialized to 0 before calling
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 5b2b04835688..293047694710 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -2649,6 +2649,7 @@ static inline int tcp_call_bpf(struct sock *sk, int op, u32 nargs, u32 *args)
>  	memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp));
>  	if (sk_fullsock(sk)) {
>  		sock_ops.is_fullsock = 1;
> +		sock_ops.allow_tcp_access = 1;
>  		sock_owned_by_me(sk);
>  	}
>  
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 1c6c07507a78..dc0e67c5776a 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -10381,10 +10381,10 @@ static u32 sock_ops_convert_ctx_access(enum bpf_access_type type,
>  		}							      \
>  		*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(			      \
>  						struct bpf_sock_ops_kern,     \
> -						is_fullsock),		      \
> +						allow_tcp_access),	      \
>  				      fullsock_reg, si->src_reg,	      \
>  				      offsetof(struct bpf_sock_ops_kern,      \
> -					       is_fullsock));		      \
> +					       allow_tcp_access));	      \
>  		*insn++ = BPF_JMP_IMM(BPF_JEQ, fullsock_reg, 0, jmp);	      \
>  		if (si->dst_reg == si->src_reg)				      \
>  			*insn++ = BPF_LDX_MEM(BPF_DW, reg, si->src_reg,	      \
> @@ -10469,10 +10469,10 @@ static u32 sock_ops_convert_ctx_access(enum bpf_access_type type,
>  					       temp));			      \
>  		*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(			      \
>  						struct bpf_sock_ops_kern,     \
> -						is_fullsock),		      \
> +						allow_tcp_access),	      \
>  				      reg, si->dst_reg,			      \
>  				      offsetof(struct bpf_sock_ops_kern,      \
> -					       is_fullsock));		      \
> +					       allow_tcp_access));	      \
>  		*insn++ = BPF_JMP_IMM(BPF_JEQ, reg, 0, 2);		      \
>  		*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(			      \
>  						struct bpf_sock_ops_kern, sk),\
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index eb82e01da911..77185479ed5e 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -169,6 +169,7 @@ static void bpf_skops_parse_hdr(struct sock *sk, struct sk_buff *skb)
>  	memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp));
>  	sock_ops.op = BPF_SOCK_OPS_PARSE_HDR_OPT_CB;
>  	sock_ops.is_fullsock = 1;
> +	sock_ops.allow_tcp_access = 1;
>  	sock_ops.sk = sk;
>  	bpf_skops_init_skb(&sock_ops, skb, tcp_hdrlen(skb));
>  
> @@ -185,6 +186,7 @@ static void bpf_skops_established(struct sock *sk, int bpf_op,
>  	memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp));
>  	sock_ops.op = bpf_op;
>  	sock_ops.is_fullsock = 1;
> +	sock_ops.allow_tcp_access = 1;
>  	sock_ops.sk = sk;
>  	/* sk with TCP_REPAIR_ON does not have skb in tcp_finish_connect */
>  	if (skb)
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 0e5b9a654254..695749807c09 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -522,6 +522,7 @@ static void bpf_skops_hdr_opt_len(struct sock *sk, struct sk_buff *skb,
>  		sock_owned_by_me(sk);
>  
>  		sock_ops.is_fullsock = 1;
> +		sock_ops.allow_tcp_access = 1;
>  		sock_ops.sk = sk;
>  	}
>  
> @@ -567,6 +568,7 @@ static void bpf_skops_write_hdr_opt(struct sock *sk, struct sk_buff *skb,
>  		sock_owned_by_me(sk);
>  
>  		sock_ops.is_fullsock = 1;
> +		sock_ops.allow_tcp_access = 1;
>  		sock_ops.sk = sk;
>  	}
>  
> -- 
> 2.43.5
> 



