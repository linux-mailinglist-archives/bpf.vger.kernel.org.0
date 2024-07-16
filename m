Return-Path: <bpf+bounces-34910-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D63C39323A8
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 12:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84F621F23D22
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 10:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996C71990CE;
	Tue, 16 Jul 2024 10:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="htayENVm"
X-Original-To: bpf@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2F2196438;
	Tue, 16 Jul 2024 10:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721124829; cv=none; b=JRp2kWz8f+XOscMvOGkJpkYGFzSWz2bk7RF4S1azbujuO1cXT8Nr9fG6aTL4OV7fwWnhPONVzt22dyWLHmTjErxZTZGtxVNtY+oPW6i0eE4/RQm8WHDvGaXeED4pu5CrcMbbq28otaYmrjoIJReUssQ+8OYe8k0YCLfPNsWLIc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721124829; c=relaxed/simple;
	bh=iAo487ia/wp3XezejlFMYb+izrM0mct6oShgF6NffGU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I/id48YzFaf3RdwMGBM9ds79ooib/MrVYAXaSQn19EBOEfF9YrLI0O2dnsDPkzFH7tiWuUV+Yae5OW1tkb6w1utOReFRWMjNY8fPk3chpg/R2z6w/N4MvzEsiuGSIc03IaFtqyPEFnEO8S7l/x4tcXU06H4zTea5Z80TNExjQr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=htayENVm; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CBCBDFF805;
	Tue, 16 Jul 2024 10:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1721124824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DsUX943pSWyx64jeqbX92/+5qMtvxBsUvtsU2xaH1MQ=;
	b=htayENVmDIqSp9t+ikRRQ7L+I73RR85vsggc4bkr5bakU8hE/BSIf05y/6wp8Eo6gV3hH3
	tURe6CklAkyqBeePFMsKRaBCZraQBk4VTYry9O74Eu3IRroX1oBTgJsSORa9zprF8/yUAS
	y+ET+guFbGniI3Nd/8QaON1PQVTEyCpRQxkRNP3qjlW5n15qKwSDHyYDcwgMaZnPDTOxdD
	IikcrmRZ+ilYNPNvdYrzSO59KAg/KjyUflEsppUduWwqaLpn8GONIlytZ8GfUkJ8RdxGtF
	Y/4bSIxDoql6GSy/PpTfj53Io3Uu3156a15VIrtZLgUgGdLuPWxcvWoQULFofQ==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Tue, 16 Jul 2024 12:13:28 +0200
Subject: [PATCH v3 1/2] selftests/bpf: update xdp_redirect_map prog
 sections for libbpf
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240716-convert_test_xdp_veth-v3-1-7b01389e3cb3@bootlin.com>
References: <20240716-convert_test_xdp_veth-v3-0-7b01389e3cb3@bootlin.com>
In-Reply-To: <20240716-convert_test_xdp_veth-v3-0-7b01389e3cb3@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: ebpf@linuxfoundation.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: alexis.lothore@bootlin.com

xdp_redirect_map.c is a bpf program used by test_xdp_veth.sh, which is not
handled by the generic test runner (test_progs). To allow converting this
test to test_progs, the corresponding program must be updated to allow
handling it through skeletons generated by bpftool and libbpf.

Update programs section names to allow to manipulate those with libbpf.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/bpf/progs/xdp_redirect_map.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/xdp_redirect_map.c b/tools/testing/selftests/bpf/progs/xdp_redirect_map.c
index d037262c8937..682dda8dabbc 100644
--- a/tools/testing/selftests/bpf/progs/xdp_redirect_map.c
+++ b/tools/testing/selftests/bpf/progs/xdp_redirect_map.c
@@ -10,19 +10,19 @@ struct {
 	__uint(value_size, sizeof(int));
 } tx_port SEC(".maps");
 
-SEC("redirect_map_0")
+SEC("xdp")
 int xdp_redirect_map_0(struct xdp_md *xdp)
 {
 	return bpf_redirect_map(&tx_port, 0, 0);
 }
 
-SEC("redirect_map_1")
+SEC("xdp")
 int xdp_redirect_map_1(struct xdp_md *xdp)
 {
 	return bpf_redirect_map(&tx_port, 1, 0);
 }
 
-SEC("redirect_map_2")
+SEC("xdp")
 int xdp_redirect_map_2(struct xdp_md *xdp)
 {
 	return bpf_redirect_map(&tx_port, 2, 0);

-- 
2.45.2


