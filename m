Return-Path: <bpf+bounces-40208-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 149A397ED79
	for <lists+bpf@lfdr.de>; Mon, 23 Sep 2024 16:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC44B281B00
	for <lists+bpf@lfdr.de>; Mon, 23 Sep 2024 14:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2364199FB2;
	Mon, 23 Sep 2024 14:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="VeBVNI3S"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B6881720
	for <bpf@vger.kernel.org>; Mon, 23 Sep 2024 14:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727103380; cv=none; b=AAJ/PjS3IWDMrqcyEB9T66AtOQ0ntRy97yKwLjAxN7SjxH4jGcw9ph/QBKkA/tmjGngKF0VNVE7MpDTmMLenYXO47o84U4EGF2BErKekTRL0cRsXNUbWI1ClTmftIuQpdiB9Ony1cXlhDTTe1MJ2jko+EbSH2UHpbRS5rqVEbx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727103380; c=relaxed/simple;
	bh=35fDDCX/93J0kbWox71MdRxHl5eHRVht19QYjtIq2cs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tb5AQZyCPRTbkikLeCLvm1+1yfHlQpPQYVELZTMutumNx63L3dTSksjTPJattt66eopcDBhheqYAAByhR/J6Q7u4JiEAXL7NFjeT8rOynoymSeuEWEYu8y286rcYKr3lBLTdrymd1L+6hXrroTeb0ChaRHEE1SVIk55PYMrdWxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=VeBVNI3S; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53654e2ed93so5027803e87.0
        for <bpf@vger.kernel.org>; Mon, 23 Sep 2024 07:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1727103377; x=1727708177; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8TouiKInAZyp7A4NllO+s2pCA1AZNyg8dLTYskVXxqA=;
        b=VeBVNI3Smv8DQzg+QGw5QVCDrnv+nQiwZYkKtML2ykOWDajrPf7EF7hbmrYfiGXA2t
         C4Nz09/a99qQVFySgYaDIb0ujqGMxZyJwfSHTvIe896BrNX+gU5svr0eyF2kUxoT3b/t
         fh6DMkk7lUW3qcQ2w9TUo1ANQTXoYPC1vxyoQU+lK1RnBcBDXL1Vuaz4o1EtUGNa93QT
         TjctoUhIkw1saeIwHB6+31UTr5qKcZcWE0j442TM6DgZoUCj8Eg2gft879uN3PDrEteS
         IbqIGv+0h8qMBLM/TMimTxS7QWkIYSVzo1cDb8bFbEhbX7aUMS1E3HdtNt2UFxgBbE1Z
         dqTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727103377; x=1727708177;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8TouiKInAZyp7A4NllO+s2pCA1AZNyg8dLTYskVXxqA=;
        b=PT19sHAV1stBnX+gnm+aR7H1CAUazcpTxzmuyNTAxDtT9NfgbXr6Os2aRjSLYVUMlc
         Tu6XygZX1wXYBc8gzv5bqdH5EDdE4e+4tCOLfvWbXkDyffM78wiPEE6TIKjAeOqfFI4D
         9/gjy+Ye6R9Dn5btfQFpkrs1MWxRNTehYKWTKCKO7cvv85m6+ziCcMxHXDCO3Z4ZA126
         A83p9RROvTf8K60Xe3LbZdVRfI9bzYYh9c72UTC5SAk+BJ1MrixMyh91ODEl1Bgv5Qpd
         13IgLbu/gq1L7SZeDToh1pkTA5cjGSBxx/eXp7V3Wx04MKMgjyNt5bP/ODCHyqHvrih9
         UYZA==
X-Forwarded-Encrypted: i=1; AJvYcCXpOq0CwWttftpw+6kG5P1+YLjRD2b2iwBhl1ja9KujW4S0uaX7Elb2mPcCkGg8WMU4Eqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIWgnHxfQRdnjBeZHnDQlJqH+Ls4IeXE63lRMp+tA1Mazl1lrg
	SzttM9EV0J7Lyp7J54eRJd5hUIBwSE0eQKfk6SltwNI4bO5WyzW4vbzaUPZoBK8=
X-Google-Smtp-Source: AGHT+IFtctpIpHZZluG6jxwXspd1B7Jih0sI66CeI59ggyuziZylKFdo52u5V/SrOpq7q1GVzbgpYg==
X-Received: by 2002:a05:6512:15a2:b0:52c:842b:c276 with SMTP id 2adb3069b0e04-536ad3d49c4mr5769201e87.53.1727103376589;
        Mon, 23 Sep 2024 07:56:16 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:5a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bc898f3sm10373677a12.82.2024.09.23.07.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 07:56:15 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: David Laight <David.Laight@ACULAB.COM>, Martin KaFai Lau
 <martin.lau@linux.dev>, 'Tiago Lam' <tiagolam@cloudflare.com>, Eric
 Dumazet <edumazet@google.com>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,  David Ahern
 <dsahern@kernel.org>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  Alexei Starovoitov <ast@kernel.org>,  Daniel
 Borkmann <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,  Song Liu <song@kernel.org>,
  "Yonghong Song" <yonghong.song@linux.dev>,  John Fastabend
 <john.fastabend@gmail.com>,  "KP Singh" <kpsingh@kernel.org>,  Stanislav
 Fomichev <sdf@fomichev.me>,  Hao Luo <haoluo@google.com>,  Jiri Olsa
 <jolsa@kernel.org>,  Mykola Lysenko <mykolal@fb.com>,  Shuah Khan
 <shuah@kernel.org>,  "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
  "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
  "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
  "kernel-team@cloudflare.com" <kernel-team@cloudflare.com>
Subject: Re: [RFC PATCH v2 2/3] ipv6: Support setting src port in sendmsg().
In-Reply-To: <855fc71343a149479c7da96438bf9e32@AcuMS.aculab.com> (David
	Laight's message of "Mon, 23 Sep 2024 13:08:36 +0000")
References: <20240920-reverse-sk-lookup-v2-0-916a48c47d56@cloudflare.com>
	<20240920-reverse-sk-lookup-v2-2-916a48c47d56@cloudflare.com>
	<855fc71343a149479c7da96438bf9e32@AcuMS.aculab.com>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Mon, 23 Sep 2024 16:56:14 +0200
Message-ID: <87r09a771t.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Sep 23, 2024 at 01:08 PM GMT, David Laight wrote:
> From: Tiago Lam <tiagolam@cloudflare.com>

[...]

>> To limit its usage, a reverse socket lookup is performed to check if the
>> configured egress source address and/or port have any ingress sk_lookup
>> match. If it does, traffic is allowed to proceed, otherwise it falls
>> back to the regular egress path.
>
> Is that really useful/necessary?

We've been asking ourselves the same question during Plumbers with
Martin.

Unprivileges processes can already source UDP traffic from (almost) any
IP & port by binding a socket to the desired source port and passing
IP_PKTINFO. So perhaps having a reverse socket lookup is an overkill.

We should probably respect net.ipv4.ip_local_reserved_ports and
net.ipv4.ip_unprivileged_port_start system settings, though, or check
for relevant caps.

Open question if it is acceptable to disregard exclusive UDP port
ownership by sockets binding to a wildcard address without SO_REUSEADDR?

[...]





> The check (but not the commit message) implies that some 'bpf thingy'
> also needs to be enabled.
> Any check would need to include the test that the program sending the packet
> has the ability to send a packet through the ingress socket.
> Additionally a check for the sending process having (IIRC) CAP_NET_ADMIN
> (which would let the process send the message by other means) would save the
> slow path.
>
> The code we have sends a lot of UDP RTP (typically 160 bytes of audio every 20ms).
> There is actually no reason for there to be a valid matching ingress path.
> (That code would benefit from being able to bind a lot of ports to the same
> UDP socket.)
>
> 	David
>
>> 
>> Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
>> Signed-off-by: Tiago Lam <tiagolam@cloudflare.com>
>> ---
>>  net/ipv6/datagram.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  net/ipv6/udp.c      |  8 ++++--
>>  2 files changed, 85 insertions(+), 2 deletions(-)
>> 
>> diff --git a/net/ipv6/datagram.c b/net/ipv6/datagram.c
>> index fff78496803d..369c64a478ec 100644
>> --- a/net/ipv6/datagram.c
>> +++ b/net/ipv6/datagram.c
>> @@ -756,6 +756,29 @@ void ip6_datagram_recv_ctl(struct sock *sk, struct msghdr *msg,
>>  }
>>  EXPORT_SYMBOL_GPL(ip6_datagram_recv_ctl);
>> 
>> +static inline bool reverse_sk_lookup(struct flowi6 *fl6, struct sock *sk,
>> +				     struct in6_addr *saddr, __be16 sport)
>> +{
>> +	if (static_branch_unlikely(&bpf_sk_lookup_enabled) &&
>> +	    (saddr && sport) &&
>> +	    (ipv6_addr_cmp(&sk->sk_v6_rcv_saddr, saddr) ||
>> +	    inet_sk(sk)->inet_sport != sport)) {
>> +		struct sock *sk_egress;
>> +
>> +		bpf_sk_lookup_run_v6(sock_net(sk), IPPROTO_UDP, &fl6->daddr,
>> +				     fl6->fl6_dport, saddr, ntohs(sport), 0,
>> +				     &sk_egress);
>> +		if (!IS_ERR_OR_NULL(sk_egress) && sk_egress == sk)
>> +			return true;
>> +
>> +		net_info_ratelimited("No reverse socket lookup match for local addr %pI6:%d remote addr
>> %pI6:%d\n",
>> +				     &saddr, ntohs(sport), &fl6->daddr,
>> +				     ntohs(fl6->fl6_dport));
>> +	}
>> +
>> +	return false;
>> +}
>> +
>>  int ip6_datagram_send_ctl(struct net *net, struct sock *sk,
>>  			  struct msghdr *msg, struct flowi6 *fl6,
>>  			  struct ipcm6_cookie *ipc6)
>> @@ -844,7 +867,63 @@ int ip6_datagram_send_ctl(struct net *net, struct sock *sk,
>> 
>>  			break;
>>  		    }
>> +		case IPV6_ORIGDSTADDR:
>> +			{
>> +			struct sockaddr_in6 *sockaddr_in;
>> +			struct net_device *dev = NULL;
>> +
>> +			if (cmsg->cmsg_len < CMSG_LEN(sizeof(struct sockaddr_in6))) {
>> +				err = -EINVAL;
>> +				goto exit_f;
>> +			}
>> +
>> +			sockaddr_in = (struct sockaddr_in6 *)CMSG_DATA(cmsg);
>> +
>> +			addr_type = __ipv6_addr_type(&sockaddr_in->sin6_addr);
>> +
>> +			if (addr_type & IPV6_ADDR_LINKLOCAL)
>> +				return -EINVAL;
>> +
>> +			/* If we're egressing with a different source address
>> +			 * and/or port, we perform a reverse socket lookup. The
>> +			 * rationale behind this is that we can allow return
>> +			 * UDP traffic that has ingressed through sk_lookup to
>> +			 * also egress correctly. In case the reverse lookup
>> +			 * fails, we continue with the normal path.
>> +			 *
>> +			 * The lookup is performed if either source address
>> +			 * and/or port changed, and neither is "0".
>> +			 */
>> +			if (reverse_sk_lookup(fl6, sk, &sockaddr_in->sin6_addr,
>> +					      sockaddr_in->sin6_port)) {
>> +				/* Override the source port and address to use
>> +				 * with the one we got in cmsg and bail early.
>> +				 */
>> +				fl6->saddr = sockaddr_in->sin6_addr;
>> +				fl6->fl6_sport = sockaddr_in->sin6_port;
>> +				break;
>> +			}
>> 
>> +			if (addr_type != IPV6_ADDR_ANY) {
>> +				int strict = __ipv6_addr_src_scope(addr_type) <= IPV6_ADDR_SCOPE_LINKLOCAL;
>> +
>> +				if (!ipv6_can_nonlocal_bind(net, inet_sk(sk)) &&
>> +				    !ipv6_chk_addr_and_flags(net,
>> +							     &sockaddr_in->sin6_addr,
>> +							     dev, !strict, 0,
>> +							     IFA_F_TENTATIVE) &&
>> +				    !ipv6_chk_acast_addr_src(net, dev,
>> +							     &sockaddr_in->sin6_addr))
>> +					err = -EINVAL;
>> +				else
>> +					fl6->saddr = sockaddr_in->sin6_addr;
>> +			}
>> +
>> +			if (err)
>> +				goto exit_f;
>> +
>> +			break;
>> +			}
>>  		case IPV6_FLOWINFO:
>>  			if (cmsg->cmsg_len < CMSG_LEN(4)) {
>>  				err = -EINVAL;
>> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
>> index 6602a2e9cdb5..6121cbb71ad3 100644
>> --- a/net/ipv6/udp.c
>> +++ b/net/ipv6/udp.c
>> @@ -1476,6 +1476,12 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>> 
>>  	fl6->flowi6_uid = sk->sk_uid;
>> 
>> +	/* We use fl6's daddr and fl6_sport in the reverse sk_lookup done
>> +	 * within ip6_datagram_send_ctl() now.
>> +	 */
>> +	fl6->daddr = *daddr;
>> +	fl6->fl6_sport = inet->inet_sport;
>> +
>>  	if (msg->msg_controllen) {
>>  		opt = &opt_space;
>>  		memset(opt, 0, sizeof(struct ipv6_txoptions));
>> @@ -1511,10 +1517,8 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>> 
>>  	fl6->flowi6_proto = sk->sk_protocol;
>>  	fl6->flowi6_mark = ipc6.sockc.mark;
>> -	fl6->daddr = *daddr;
>>  	if (ipv6_addr_any(&fl6->saddr) && !ipv6_addr_any(&np->saddr))
>>  		fl6->saddr = np->saddr;
>> -	fl6->fl6_sport = inet->inet_sport;
>> 
>>  	if (cgroup_bpf_enabled(CGROUP_UDP6_SENDMSG) && !connected) {
>>  		err = BPF_CGROUP_RUN_PROG_UDP6_SENDMSG_LOCK(sk,
>> 
>> --
>> 2.34.1
>> 
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)

