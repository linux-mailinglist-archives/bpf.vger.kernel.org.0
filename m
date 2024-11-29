Return-Path: <bpf+bounces-45894-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D10F69DED79
	for <lists+bpf@lfdr.de>; Sat, 30 Nov 2024 00:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0719281F90
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 23:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17EE1192B83;
	Fri, 29 Nov 2024 23:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VGH2vfv3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8695815667B;
	Fri, 29 Nov 2024 23:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732921886; cv=none; b=UQiwoe1UiD9QZz9qnBOSXKjXMHYh6q24VplB1Rltkghz01auNMXwXreYbQEeGXdlfOtQbuv3RB2wY/asUGdtByN4UcVfmZim/N8FKIMJzfjWWLkhG05BHv+DKm4uDiVndaoEIVx8CZviERAwfFdmQZhySsM06LKJQxAvXHQ85Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732921886; c=relaxed/simple;
	bh=v0J4fpmnaNrMeSGiPFroHrSUm1uN3z3X3l+JJMpEmpc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ENWsr4JzCDWa5XSnfCEcWtYlApiqrg6+CZfSUL3zKxC9xm154YecGpXuEWBVm7oDfP+2LZV1djHliHzqfREZ9C+HFemIb1l+OryTt4RCJkVCO0cIzMJtGGSZMa3L4xgQnxXzVbVy+S35cNyEHpev32mqN6SRDYVpaXcfKVgeSuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VGH2vfv3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72DB8C4CECF;
	Fri, 29 Nov 2024 23:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732921885;
	bh=v0J4fpmnaNrMeSGiPFroHrSUm1uN3z3X3l+JJMpEmpc=;
	h=From:Subject:Date:To:Cc:From;
	b=VGH2vfv3OMMe4z6V0m/PjNvnSp2xku8dUTM4wFSKK5oYoPFzKnwGVx/LQEnrns2Ns
	 pBf9zlQEmKvmQ4GCmS6eJVW1gnux4LVTN163UauMAqZk/f3tJyFNgw+Xa/YUkbWu3E
	 rpvuDMbz61SbuNldidWmPXcL3ozmo73sGvO9tnA17zDNNO24xRiCfEsDRouwTPnaJs
	 sJbDh2jAohlTYpUj1bRjlackrDHW0lNe3wpDlU9IUgWJ+UQRGeg5S+7YlV+VmRa9qk
	 fdpOzINGCkVZqtBwDALEvO/KDJEKbkjD/jD1c4il4Ya6HkB2QCSgkkUgcuXk0UPKs8
	 eD9sx6En2chug==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH bpf-next 0/3] Introduce GRO support to cpumap codebase
Date: Sat, 30 Nov 2024 00:10:57 +0100
Message-Id: <20241130-cpumap-gro-v1-0-c1180b1b5758@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAFKSmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDQyNL3eSC0tzEAt30onxdE2PDtLQUA+PERNNUJaCGgqLUtMwKsGHRsbW
 1AP1ACNVcAAAA
X-Change-ID: 20241129-cpumap-gro-431ffd03aa5e
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>
Cc: Daniel Xu <dxu@dxuuu.xyz>, aleksander.lobakin@intel.com, 
 netdev@vger.kernel.org, bpf@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Add GRO support to cpumap codebase moving the cpu_map_entry kthread to a
NAPI-kthread pinned to the selected cpu.
Introduce napi_init_for_gro utility routine to initialize napi struct
subfields not dependent by net_device pointer in order to not add
net_device dependency in the cpumap_entry.
This series has been tested by Daniel using tcp_rr and tcp_stream:

Baseline (again)							

./tcp_rr -c -H $TASK_IP -p 50,90,99 -T4 -F8 -l30			        ./tcp_stream -c -H $TASK_IP -T8 -F16 -l30
							
	Transactions	Latency P50 (s)	Latency P90 (s)	Latency P99 (s)			Throughput (Mbit/s)
Run 1	2560252	        0.00009087	0.00010495	0.00011647		Run 1	15479.31
Run 2	2665517	        0.00008575	0.00010239	0.00013311		Run 2	15162.48
Run 3	2755939	        0.00008191	0.00010367	0.00012287		Run 3	14709.04
Run 4	2595680	        0.00008575	0.00011263	0.00012671		Run 4	15373.06
Run 5	2841865	        0.00007999	0.00009471	0.00012799		Run 5	15234.91
Average	2683850.6	0.000084854	0.00010367	0.00012543		Average	15191.76
							
cpumap NAPI patches v2							
							
	Transactions	Latency P50 (s)	Latency P90 (s)	Latency P99 (s)			Throughput (Mbit/s)
Run 1	2577838	        0.00008575	0.00012031	0.00013695		Run 1	19914.56
Run 2	2729237	        0.00007551	0.00013311	0.00017663		Run 2	20140.92
Run 3	2689442	        0.00008319	0.00010495	0.00013311		Run 3	19887.48
Run 4	2862366	        0.00008127	0.00009471	0.00010623		Run 4	19374.49
Run 5	2700538	        0.00008319	0.00010367	0.00012799		Run 5	19784.49
Average	2711884.2	0.000081782	0.00011135	0.000136182		Average	19820.388
Delta	1.04%	        -3.62%	        7.41%	        8.57%			        30.47%

IIUC, to be 100% honest, the above results have been obtained running
the proposed series with a different kernel version.

---
Lorenzo Bianconi (3):
      net: Add napi_init_for_gro utility routine
      net: add napi_threaded_poll to netdevice.h
      bpf: cpumap: Add gro support

 include/linux/netdevice.h |   3 ++
 kernel/bpf/cpumap.c       | 125 +++++++++++++++++++---------------------------
 net/core/dev.c            |  21 +++++---
 3 files changed, 70 insertions(+), 79 deletions(-)
---
base-commit: c8d02b547363880d996f80c38cc8b997c7b90725
change-id: 20241129-cpumap-gro-431ffd03aa5e

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


