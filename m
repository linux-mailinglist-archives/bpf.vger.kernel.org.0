Return-Path: <bpf+bounces-68203-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD94CB53F0C
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 01:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E5F4583F0E
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 23:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7E72F616D;
	Thu, 11 Sep 2025 23:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b="ebbjXFRj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992D52F39B8
	for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 23:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757633010; cv=none; b=cf2De0+COOgotOnNh8nY28+ndsW3qg9MnzA/KGfTU1fY5c77VYhLpZs16KatbadkS9Hpck1PYRrAHRK0GJw4Oif7sp26LB/jIT/HrRvR5GoR+/wdWhqrudSFcPt7rhVrr1q7yU6nQ0XrMTCpy8491VIkmL9UXYLDqRqrJ71e0Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757633010; c=relaxed/simple;
	bh=OK4EM30A44/2NRD+i7sqe2wrH7v7/w7Fs43IiXrmW/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OLorXKIy7TR5lKxsRw+odYYkvqLeDJgk6BlMUVcyc2mMzy538lhr0Hu8ECKGPXl67fQNMFaGE7e8U1z7sadTTJGNoCNxd2Gfi1yuLv+mTOGowu7SBuevwayTkzS2BfR9IqIvF252Qa4M76yoNWMlfrQ7+K/DC0r3ljSWMazmorI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=allelesecurity.com; spf=pass smtp.mailfrom=allelesecurity.com; dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b=ebbjXFRj; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=allelesecurity.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=allelesecurity.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-76e6cbb991aso1326237b3a.1
        for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 16:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=allelesecurity.com; s=google; t=1757633008; x=1758237808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xUAVZ0bvWLEB4KH4GpIrKampHs79U2eTT5vozQ57bm4=;
        b=ebbjXFRjyCj5eIvDcF1CwlLMPTmbjFm2KyQj2hoge9FYUM2k7WThi235HJJRA6KNBd
         aDAAMUIG9xAnvGOvxnSoKFglsrCwUo/FO+UGeGY4MZ6RVTMxGEsJ2UqhWZV//8CbUX9d
         stHyBOPWq4s6RkJYoHvWBD0qSiCfIhHrcnU24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757633008; x=1758237808;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xUAVZ0bvWLEB4KH4GpIrKampHs79U2eTT5vozQ57bm4=;
        b=UPf1Q3n2l31rzcYY9i790tEtOU8CSkiKspTKpND1aiFqh6Lomb+sjk0ZkTZN1hFNCj
         AC00ZeC7xkAdW72RvhC7EsdEUndLIXJkgPsh2njeABn2D9opExK9TvNkvXKiPSW8+j63
         oa68Nc0NBVxBZ9CFy2crSnUJASNw3ww/UEC7XltGU7POakap/lzlot6Jj273tmhQVRF3
         s2id2WIwptXemHhuYhE+BdO1cZxjWwku5J0P7txJxRJMQp4lRqD1ZYl4WOoEF5O7vsTH
         IvKItnkvVHfCDcd7vfP1TSqIWDtmnwp3dPusy+JRZWuQlk8SHrMMTvBM43yO8ogDP3fA
         /Mhw==
X-Forwarded-Encrypted: i=1; AJvYcCWJiU6ZXA6D7yi/xydPfJm6tFk6IyStEkkpPg6aOqXC3UvssWH0gtv3Q+1gmVICilJaKIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfxU9XQOJ20YVsJWD3XZr+pNLI22saUbfdvl671YwdqPs41qH5
	/hdhsHoOmSVBWDSNdvFPhWos4oyrsaXMvOTLz8+IjZWi6Jt1jaM6mR7Lnez3zg0t8JQ=
X-Gm-Gg: ASbGncvzzTfdYNykqPEEYpcdkGXzt+f8t6aEZlfk0aZIbBvt8644B0Aj0APtRVEauFZ
	qLlkW85wyKVMaMp8QZo5V8j0+s2m2zPt29gvXnNgZxa6KxF70rDdEcM1KjmyZVnjTbBN9g4HVEg
	GstaeFneY94E2A7Cb2D3uT+S1g68CEIOc3yeECQXFGpMZsNp7054ZNWlqKdqQoZE4ie1AqpFe/L
	N+5OYqaQBhmCbg9iMSY3cNLqYAU5M+vL0YjrVkv+VKDtXTQw+VPCP9RODq239NHJNuMYsrrou31
	1GMeaVAs99LJsixvZW6N5CzslGfj7eRjrkr9Lnl78zFpnWVm/5CCrV7KLGhHOluZd5Pdm66WHWu
	Yf/XNg3bGMPzplfJ9YmMSAyw4QRtHkyW8Ak2AIFopJntX3Ns=
X-Google-Smtp-Source: AGHT+IFvKd338ahGShVcXp/lcPNOy/KrM/N8yKlB9s8nlHQO0F4Ghy1Sxbe8aSBOfbnPHwLPS++9sg==
X-Received: by 2002:a05:6a00:b4e:b0:771:e451:4ee3 with SMTP id d2e1a72fcca58-776120e50c8mr1094199b3a.12.1757633007810;
        Thu, 11 Sep 2025 16:23:27 -0700 (PDT)
Received: from fedoraserver42research ([179.105.152.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7760955263fsm2927152b3a.8.2025.09.11.16.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 16:23:27 -0700 (PDT)
From: Anderson Nascimento <anderson@allelesecurity.com>
To: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Dmitry Safonov <0x7f454c46@gmail.com>,
	Salam Noureddine <noureddine@arista.com>,
	Francesco Ruggeri <fruggeri@arista.com>
Cc: Anderson Nascimento <anderson@allelesecurity.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v3] net/tcp: Fix a NULL pointer dereference when using TCP-AO with TCP_REPAIR
Date: Thu, 11 Sep 2025 20:07:44 -0300
Message-ID: <20250911230743.2551-3-anderson@allelesecurity.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A NULL pointer dereference can occur in tcp_ao_finish_connect() during a
connect() system call on a socket with a TCP-AO key added and TCP_REPAIR
enabled.

The function is called with skb being NULL and attempts to dereference it
on tcp_hdr(skb)->seq without a prior skb validation.

Fix this by checking if skb is NULL before dereferencing it.

The commentary is taken from bpf_skops_established(), which is also called
in the same flow. Unlike the function being patched,
bpf_skops_established() validates the skb before dereferencing it.

int main(void){
	struct sockaddr_in sockaddr;
	struct tcp_ao_add tcp_ao;
	int sk;
	int one = 1;

	memset(&sockaddr,'\0',sizeof(sockaddr));
	memset(&tcp_ao,'\0',sizeof(tcp_ao));

	sk = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);

	sockaddr.sin_family = AF_INET;

	memcpy(tcp_ao.alg_name,"cmac(aes128)",12);
	memcpy(tcp_ao.key,"ABCDEFGHABCDEFGH",16);
	tcp_ao.keylen = 16;

	memcpy(&tcp_ao.addr,&sockaddr,sizeof(sockaddr));

	setsockopt(sk, IPPROTO_TCP, TCP_AO_ADD_KEY, &tcp_ao,
	sizeof(tcp_ao));
	setsockopt(sk, IPPROTO_TCP, TCP_REPAIR, &one, sizeof(one));

	sockaddr.sin_family = AF_INET;
	sockaddr.sin_port = htobe16(123);

	inet_aton("127.0.0.1", &sockaddr.sin_addr);

	connect(sk,(struct sockaddr *)&sockaddr,sizeof(sockaddr));

return 0;
}

$ gcc tcp-ao-nullptr.c -o tcp-ao-nullptr -Wall
$ unshare -Urn
# ip addr add 127.0.0.1 dev lo
# ./tcp-ao-nullptr

BUG: kernel NULL pointer dereference, address: 00000000000000b6
PGD 1f648d067 P4D 1f648d067 PUD 1982e8067 PMD 0
Oops: Oops: 0000 [#1] SMP NOPTI
Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop
Reference Platform, BIOS 6.00 11/12/2020
RIP: 0010:tcp_ao_finish_connect (net/ipv4/tcp_ao.c:1182)

Fixes: 7c2ffaf ("net/tcp: Calculate TCP-AO traffic keys")
Signed-off-by: Anderson Nascimento <anderson@allelesecurity.com>
---
Changes in v3
- Remove the attribution of 'ao->risn' to '0' in the else case.
- Do not add the full decoded stack trace
- Link to v2: https://lore.kernel.org/all/20250911034337.43331-2-anderson@allelesecurity.com/
Changes in v2:
- Wrap the description at 75 columns
- Add full decoded stack trace
- Link to v1: https://lore.kernel.org/all/20250911013052.2233-1-anderson@allelesecurity.com/

 net/ipv4/tcp_ao.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index bbb8d5f0eae7..3338b6cc85c4 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -1178,7 +1178,9 @@ void tcp_ao_finish_connect(struct sock *sk, struct sk_buff *skb)
 	if (!ao)
 		return;
 
-	WRITE_ONCE(ao->risn, tcp_hdr(skb)->seq);
+	/* sk with TCP_REPAIR_ON does not have skb in tcp_finish_connect */
+	if (skb)
+		WRITE_ONCE(ao->risn, tcp_hdr(skb)->seq);
 	ao->rcv_sne = 0;
 
 	hlist_for_each_entry_rcu(key, &ao->head, node, lockdep_sock_is_held(sk))
-- 
2.51.0


