Return-Path: <bpf+bounces-39814-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A80C977C66
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 11:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED7171F21FBB
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 09:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A268E1D933B;
	Fri, 13 Sep 2024 09:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="L6C0V1B9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CC71D7E34
	for <bpf@vger.kernel.org>; Fri, 13 Sep 2024 09:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726220370; cv=none; b=lvCdo2OnwTplxyB74WfgkXAVkTeJ45l5Lp1OljzptV0miGMZROmQ5cZ9uR1fE9g2nfXN51bbzvtfDKjcXG1iRLLUKT+B8sF51uz4OwOxVf0HGhPKBlbUc55g3i75t91x2pbypjVPBq3TQOEzqqKGz7ueMaKFZKNBwNNo3kTX1eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726220370; c=relaxed/simple;
	bh=14Em+5LUfU07AZhRuhVZlV8I2kuQVcaRcYhuB3emakA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BO/c3GespiYYZtqWD2jb6rewj+YCmZBf3EnJcB1Ozmgc2JRGCYxQX6beSvzc4VA0Z9bMI3qDFZgNV6mETFuWspDzajcXJOauygMqT17+t4EFwW+kPSSDgaIlpEI6WiSCdi2p4wcLvu1VabZWAlXWhPx6TEoz4tMLb3sM2gYNR+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=L6C0V1B9; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-374c6187b6eso1527785f8f.0
        for <bpf@vger.kernel.org>; Fri, 13 Sep 2024 02:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1726220366; x=1726825166; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8SPUqN3GZrlcNjwE+u8cOJWfk91PGP0vK3hoXybkak4=;
        b=L6C0V1B9ThCrvHNddoT3ljveUKthVAwHmpOMbVvijk+yXwYtNmcNyorq7uVlnS/XEh
         I2YxoCo/5/SqWFzdfSvLSdu1rD+e/6HrZm5O6ClpO3KujnXuAUjUvRghtp4nzfs5MvqA
         B0XmM0avdW7fy2vNtkvckbZ42nK+93NKL+m9OnCBPR6pEvuSMXzNSI4A3Mp7DfnkZ89Z
         F9/jV66nd5IGX3oOReLmT3dFnADxYDXr7VneQqkap225cS33dXbNtWDYjV4GUN9Yfr1u
         nvyspk7NYMTVdKHRKEcg7lMmTzZJO9U55IeFyt2CAIh8EmdwGKc3tfQo3qCBa+ZjVbtZ
         014g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726220366; x=1726825166;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8SPUqN3GZrlcNjwE+u8cOJWfk91PGP0vK3hoXybkak4=;
        b=onD9/KFCxBZZTOUie5Iy/PE5eCa++1DzFfuly9ytsMWL/rnKfklDi7U6cwfkOHlnK5
         wA2fFvLJQFDY984X2vofeuAUDcwyYB/okKPfDakzB+R/Y4D2+2r/2IDLjRwihN4YdanF
         y/DJhbpl9hBeb5bdS1O0DRugFzIOVVyuwNSHl+33ycViiLl6WckoBNg1/8EXFuxatiSB
         X293nf4N4vmjFBkTFcW0+t7S74f1XAqxieX59+3LEf3QCYxFbPvPR1V/c+OlViB4g1nT
         slcJH8TWp1alluIgzg+NvXcbCRLg5HqTSczX2vyun2lJMMgQmUDmyAa9F5SnI/N3q28N
         BzSA==
X-Forwarded-Encrypted: i=1; AJvYcCVuiwTJA4Pyz3vmI0pinXwLTKc4vau2ob8Y76W8Ki0+3TaqqDtcq65x+d+/KaTxqZIp1FM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1afQx8dlsiH1xPx+/RDbv7FVOFQUk+fJ9C8ioR6LOmOuOk0o9
	3dYQ/60Pi2ECMoZmV+E+PzcNlAndRvXxtNtPHTD91JgNxHmysftTB6zQe0E6+8k=
X-Google-Smtp-Source: AGHT+IEP6gH+9G56Ca89xPoHtYf+GM04fd32svCb2j76cjibtD28Ka5SMKWWnsCP22WUeZmsjTzWEA==
X-Received: by 2002:a05:6000:e09:b0:374:ca92:5e44 with SMTP id ffacd0b85a97d-378c2d121d6mr3535737f8f.32.1726220365954;
        Fri, 13 Sep 2024 02:39:25 -0700 (PDT)
Received: from [127.0.1.1] ([2a09:bac5:3802:d2::15:37a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895665548sm16474484f8f.34.2024.09.13.02.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 02:39:25 -0700 (PDT)
From: Tiago Lam <tiagolam@cloudflare.com>
Date: Fri, 13 Sep 2024 10:39:20 +0100
Subject: [RFC PATCH 2/3] ipv6: Run a reverse sk_lookup on sendmsg.
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-reverse-sk-lookup-v1-2-e721ea003d4c@cloudflare.com>
References: <20240913-reverse-sk-lookup-v1-0-e721ea003d4c@cloudflare.com>
In-Reply-To: <20240913-reverse-sk-lookup-v1-0-e721ea003d4c@cloudflare.com>
To: "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Jakub Sitnicki <jakub@cloudflare.com>, Tiago Lam <tiagolam@cloudflare.com>, 
 kernel-team@cloudflare.com
X-Mailer: b4 0.14.1

This follows the same rationale provided for the ipv4 counterpart, where
it now runs a reverse socket lookup when source addresses and/or ports
are changed, on sendmsg, to check whether egress traffic should be
allowed to go through or not.

As with ipv4, the ipv6 sendmsg path is also extended here to support the
IPV6_ORIGDSTADDR ancilliary message to be able to specify a source
address/port.

Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
Signed-off-by: Tiago Lam <tiagolam@cloudflare.com>
---
 net/ipv6/datagram.c | 76 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 net/ipv6/udp.c      |  8 ++++--
 2 files changed, 82 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/datagram.c b/net/ipv6/datagram.c
index fff78496803d..4214dda1c320 100644
--- a/net/ipv6/datagram.c
+++ b/net/ipv6/datagram.c
@@ -756,6 +756,27 @@ void ip6_datagram_recv_ctl(struct sock *sk, struct msghdr *msg,
 }
 EXPORT_SYMBOL_GPL(ip6_datagram_recv_ctl);
 
+static inline bool reverse_sk_lookup(struct flowi6 *fl6, struct sock *sk,
+				     struct in6_addr *saddr, __be16 sport)
+{
+	if (static_branch_unlikely(&bpf_sk_lookup_enabled) &&
+	    (saddr && sport) &&
+	    (ipv6_addr_cmp(&sk->sk_v6_rcv_saddr, saddr) || inet_sk(sk)->inet_sport != sport)) {
+		struct sock *sk_egress;
+
+		bpf_sk_lookup_run_v6(sock_net(sk), IPPROTO_UDP, &fl6->daddr, fl6->fl6_dport,
+				     saddr, ntohs(sport), 0, &sk_egress);
+		if (!IS_ERR_OR_NULL(sk_egress) &&
+		    atomic64_read(&sk_egress->sk_cookie) == atomic64_read(&sk->sk_cookie))
+			return true;
+
+		net_info_ratelimited("No reverse socket lookup match for local addr %pI6:%d remote addr %pI6:%d\n",
+				     &saddr, ntohs(sport), &fl6->daddr, ntohs(fl6->fl6_dport));
+	}
+
+	return false;
+}
+
 int ip6_datagram_send_ctl(struct net *net, struct sock *sk,
 			  struct msghdr *msg, struct flowi6 *fl6,
 			  struct ipcm6_cookie *ipc6)
@@ -844,7 +865,62 @@ int ip6_datagram_send_ctl(struct net *net, struct sock *sk,
 
 			break;
 		    }
+		case IPV6_ORIGDSTADDR:
+			{
+			struct sockaddr_in6 *sockaddr_in;
+			struct net_device *dev = NULL;
+
+			if (cmsg->cmsg_len < CMSG_LEN(sizeof(struct sockaddr_in6))) {
+				err = -EINVAL;
+				goto exit_f;
+			}
+
+			sockaddr_in = (struct sockaddr_in6 *)CMSG_DATA(cmsg);
+
+			addr_type = __ipv6_addr_type(&sockaddr_in->sin6_addr);
+
+			if (addr_type & IPV6_ADDR_LINKLOCAL)
+				return -EINVAL;
+
+			/* If we're egressing with a different source address and/or port, we
+			 * perform a reverse socket lookup.  The rationale behind this is that we
+			 * can allow return UDP traffic that has ingressed through sk_lookup to
+			 * also egress correctly. In case the reverse lookup fails, we
+			 * continue with the normal path.
+			 *
+			 * The lookup is performed if either source address and/or port changed, and
+			 * neither is "0".
+			 */
+			if (reverse_sk_lookup(fl6, sk, &sockaddr_in->sin6_addr,
+					      sockaddr_in->sin6_port)) {
+				/* Override the source port and address to use with the one we
+				 * got in cmsg and bail early.
+				 */
+				fl6->saddr = sockaddr_in->sin6_addr;
+				fl6->fl6_sport = sockaddr_in->sin6_port;
+				break;
+			}
 
+			if (addr_type != IPV6_ADDR_ANY) {
+				int strict = __ipv6_addr_src_scope(addr_type) <= IPV6_ADDR_SCOPE_LINKLOCAL;
+
+				if (!ipv6_can_nonlocal_bind(net, inet_sk(sk)) &&
+				    !ipv6_chk_addr_and_flags(net,
+							     &sockaddr_in->sin6_addr,
+							     dev, !strict, 0,
+							     IFA_F_TENTATIVE) &&
+				    !ipv6_chk_acast_addr_src(net, dev,
+							     &sockaddr_in->sin6_addr))
+					err = -EINVAL;
+				else
+					fl6->saddr = sockaddr_in->sin6_addr;
+			}
+
+			if (err)
+				goto exit_f;
+
+			break;
+			}
 		case IPV6_FLOWINFO:
 			if (cmsg->cmsg_len < CMSG_LEN(4)) {
 				err = -EINVAL;
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 6602a2e9cdb5..6121cbb71ad3 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1476,6 +1476,12 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 	fl6->flowi6_uid = sk->sk_uid;
 
+	/* We use fl6's daddr and fl6_sport in the reverse sk_lookup done
+	 * within ip6_datagram_send_ctl() now.
+	 */
+	fl6->daddr = *daddr;
+	fl6->fl6_sport = inet->inet_sport;
+
 	if (msg->msg_controllen) {
 		opt = &opt_space;
 		memset(opt, 0, sizeof(struct ipv6_txoptions));
@@ -1511,10 +1517,8 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 	fl6->flowi6_proto = sk->sk_protocol;
 	fl6->flowi6_mark = ipc6.sockc.mark;
-	fl6->daddr = *daddr;
 	if (ipv6_addr_any(&fl6->saddr) && !ipv6_addr_any(&np->saddr))
 		fl6->saddr = np->saddr;
-	fl6->fl6_sport = inet->inet_sport;
 
 	if (cgroup_bpf_enabled(CGROUP_UDP6_SENDMSG) && !connected) {
 		err = BPF_CGROUP_RUN_PROG_UDP6_SENDMSG_LOCK(sk,

-- 
2.34.1


