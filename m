Return-Path: <bpf+bounces-54177-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8D9A6483C
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 10:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 770713B48BB
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 09:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112D822FDEF;
	Mon, 17 Mar 2025 09:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="NQQr3nNg"
X-Original-To: bpf@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6C222B8A2
	for <bpf@vger.kernel.org>; Mon, 17 Mar 2025 09:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742205178; cv=none; b=RWEATlannNd1rWfPw6g+RRToR3Ghrg8T1Yk3HuYxoj+OQkPVO3NmZotcY91rd1lLA5l3Q1fN6pPF4Cy9rNFL9F3ArUs4ASV7rncrQquwf4JGXbZ+EEwViskalK8wffr+sm5FSv6uqMNTxvtz/NXwlBcsju0ptw77kWwfLMFywts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742205178; c=relaxed/simple;
	bh=82tdJGD188maLpcW9JOBXV02MZi3Eml1PPj6QW2Dw9U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GAdQpD4qBsCw0UDMspT5vRKfHMdB4H7UfwU39S60p4fUxfFhQyqbUZ6Q/4gO3YKcb10pIHgSVfC2Po98rgAfqAmzLYs/ziZi9f8i51zFEDdaciW8mHI7/ulOZ66lVYRdGTE6bJ8SSR682EnN1yiHS9cfGae2VB8MamacomDC8BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=NQQr3nNg; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tu79N-00DmxL-Rw; Mon, 17 Mar 2025 10:52:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From; bh=IgH9roDqhx89o+OSz4CJsyUWkfIKweUIrV6dcf09fsQ=
	; b=NQQr3nNgmI/VebugNqGrJ9G3+ApOxvZvgQL00ImY9NYkxi9H0arf1gQSPWntqLVcwlwQOhBO2
	899Qya+tgRLl75uZ0wNE9mW3bdSvoARYbMjQWcIPpJ71YNIVdJ4afurW2O+YBuYo3aqFopEyX9izR
	2LM8RW6iossoS9JOtNgYPuyvEBLX7hE2rxw6D6mcwCGjMQM7lT7z3UE1+JiI1JDGGr7x3yeTb6vuy
	JTaxzIHEnewuwtD6GOe3uyIc3K2NTXtqkBKhVfT7ZPN1U8WIV4BQcfnDKOfrO+lxf2YYx4UBx1OJP
	yTFTWsoqbCM0OM8Ty5BayguGiSZ0otvzz057ZQ==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tu79M-0006rl-HO; Mon, 17 Mar 2025 10:52:48 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tu794-00DI8D-Vj; Mon, 17 Mar 2025 10:52:31 +0100
From: Michal Luczaj <mhal@rbox.co>
Subject: [PATCH net v4 0/3] vsock/bpf: Handle races between sockmap update
 and connect() disconnecting
Date: Mon, 17 Mar 2025 10:52:22 +0100
Message-Id: <20250317-vsock-trans-signal-race-v4-0-fc8837f3f1d4@rbox.co>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANbw12cC/3XNQQ7CIBAF0KsY1o6BgYJ15T2MC0qhEg0YaIjG9
 O5iY2JddPnnZ95/kWyTt5kcNi+SbPHZx1CD2G6IuegwWPB9zQQpNpTTBkqO5gpj0iFD9kPQN0j
 aWOglOqXYvqdtS+r3PVnnH7N8IsGO5FyPF5/HmJ7zWmFz9YXVKlwYMODaaP7xXdcfUxcfOxNns
 eBCYWJdQaAgkGnBnKRO4L/Cl4pcV3hVmNJyLxGVMu1PmabpDdYy3bRNAQAA
X-Change-ID: 20250305-vsock-trans-signal-race-d62f7718d099
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Bobby Eshleman <bobby.eshleman@bytedance.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Signal delivery during connect() may disconnect an already established
socket. Problem is that such socket might have been placed in a sockmap
before the connection was closed.

PATCH 1 ensures this race won't lead to an unconnected vsock staying in the
sockmap. PATCH 2 selftests it. 

PATCH 3 fixes a related race. Note that selftest in PATCH 2 does test this
code as well, but winning this race variant may take more than 2 seconds,
so I'm not advertising it.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
Changes in v4:
- Selftest: send signal to only our own process
- Link to v3: https://lore.kernel.org/r/20250316-vsock-trans-signal-race-v3-0-17a6862277c9@rbox.co

Changes in v3:
- Selftest: drop unnecessary variable initialization and reorder the calls
- Link to v2: https://lore.kernel.org/r/20250314-vsock-trans-signal-race-v2-0-421a41f60f42@rbox.co

Changes in v2:
- Handle one more path of tripping the warning
- Add a selftest
- Collect R-b [Stefano]
- Link to v1: https://lore.kernel.org/r/20250307-vsock-trans-signal-race-v1-1-3aca3f771fbd@rbox.co

---
Michal Luczaj (3):
      vsock/bpf: Fix EINTR connect() racing sockmap update
      selftest/bpf: Add test for AF_VSOCK connect() racing sockmap update
      vsock/bpf: Fix bpf recvmsg() racing transport reassignment

 net/vmw_vsock/af_vsock.c                           | 10 ++-
 net/vmw_vsock/vsock_bpf.c                          | 24 ++++--
 .../selftests/bpf/prog_tests/sockmap_basic.c       | 99 ++++++++++++++++++++++
 3 files changed, 124 insertions(+), 9 deletions(-)
---
base-commit: da9e8efe7ee10e8425dc356a9fc593502c8e3933
change-id: 20250305-vsock-trans-signal-race-d62f7718d099

Best regards,
-- 
Michal Luczaj <mhal@rbox.co>


