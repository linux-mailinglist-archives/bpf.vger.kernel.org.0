Return-Path: <bpf+bounces-49356-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7627A17B73
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 11:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D6DB3A4A9E
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 10:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAE41F2C4D;
	Tue, 21 Jan 2025 10:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FXvhedEX"
X-Original-To: bpf@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A951F193D;
	Tue, 21 Jan 2025 10:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737454950; cv=none; b=fGt88XDAv2zJfgVEI2AGPvHB3abXfRFNXmbilMcmYmRvDCYDoEz0WZv0aIsUyH2+j6tVcgyep1jAVhwJvVeW6aO4+KAuOTVxssG+Z+a3H9rf82pWgbVuZw0Nz2IZeqffXU/azFFIVyMSdfSLiZJVm601x1LZ9dIdW6lEg57DlaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737454950; c=relaxed/simple;
	bh=qTZdAVqTCVeAqEizvFVaev31Vb5y2TYBJi728gKqK4E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uauS5oZcf9zyi+AEeNGOiGBmqq7J+r6AejEIU4P/nyhCdGhzSaSZv46h82hlI5QZf5RVYc/H/Yaok2DIxYk/ZBS0iEN8bXlX4Ns67Hz1dguod+I6iYEgtPaFnxPQ1/fgWofUTQlWiGEM/Y5+aEwn7JJZel02LRmrV7ebWHFID34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FXvhedEX; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 53A8524001A;
	Tue, 21 Jan 2025 10:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1737454946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j+Xkf/WzzwJ3LU071pjuWxrwQ79eZhQK0SANIpM2J8A=;
	b=FXvhedEXUOeRFPE34/q/6gMUqndSNpGrX5LQvS0KInw2kW2O1JHjeuunF5YW9ip9lnEDj0
	YUOhFXC/vlqTsUaIMi8t37cFdYP3C1x8PCkaW+RG2ZbUiW07A8hVyPZULPVL0ZOW+n2gKR
	8yG1pibt8k0p5DcmtX7Dxk1kQrlMvxVUubOkuBzjkSNoOVI2oNvLrdUw9NB3/lpDRjnvjg
	XQh19kwRd/Yxeg8FGceMNwbGzonh2gAu1DXWLycQZI8nbFqr3m9oqz2DCI3NpbNq27D7UR
	VitPjv2gqSwH68p9+zJIdHHvf5OmqYMfPsCTWNh0rvIqbYoimjcMfLtA7Q2mjQ==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Tue, 21 Jan 2025 11:22:21 +0100
Subject: [PATCH bpf-next 07/10] selftests/bpf: Optionally select
 broadcasting flags
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250121-redirect-multi-v1-7-b215e35ff505@bootlin.com>
References: <20250121-redirect-multi-v1-0-b215e35ff505@bootlin.com>
In-Reply-To: <20250121-redirect-multi-v1-0-b215e35ff505@bootlin.com>
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
 Shuah Khan <shuah@kernel.org>
Cc: Alexis Lothore <alexis.lothore@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: bastien.curutchet@bootlin.com

Broadcasting flags are hardcoded for each kind for protocol.

Create a redirect_flags map that allows to select the broadcasting flags
to use in the bpf_redirect_map(). The protocol ID is used as a key.
Set the old hardcoded values as default if the map isn't filled by the
BPF caller.

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 .../selftests/bpf/progs/xdp_redirect_multi_kern.c  | 41 +++++++++++++++-------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/xdp_redirect_multi_kern.c b/tools/testing/selftests/bpf/progs/xdp_redirect_multi_kern.c
index 97b26a30b59a758f5a5f2152af509acef80031ce..bc2945ed8a8017021c2792671b4de9aa4928a3e4 100644
--- a/tools/testing/selftests/bpf/progs/xdp_redirect_multi_kern.c
+++ b/tools/testing/selftests/bpf/progs/xdp_redirect_multi_kern.c
@@ -34,6 +34,14 @@ struct {
 	__uint(max_entries, 128);
 } mac_map SEC(".maps");
 
+/* map to store redirect flags for each protocol*/
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, __u16);
+	__type(value, __u64);
+	__uint(max_entries, 16);
+} redirect_flags SEC(".maps");
+
 SEC("xdp")
 int xdp_redirect_map_multi_prog(struct xdp_md *ctx)
 {
@@ -41,25 +49,34 @@ int xdp_redirect_map_multi_prog(struct xdp_md *ctx)
 	void *data = (void *)(long)ctx->data;
 	int if_index = ctx->ingress_ifindex;
 	struct ethhdr *eth = data;
+	__u64 *flags_from_map;
 	__u16 h_proto;
 	__u64 nh_off;
+	__u64 flags;
 
 	nh_off = sizeof(*eth);
 	if (data + nh_off > data_end)
 		return XDP_DROP;
 
-	h_proto = eth->h_proto;
-
-	/* Using IPv4 for (BPF_F_BROADCAST | BPF_F_EXCLUDE_INGRESS) testing */
-	if (h_proto == bpf_htons(ETH_P_IP))
-		return bpf_redirect_map(&map_all, 0,
-					BPF_F_BROADCAST | BPF_F_EXCLUDE_INGRESS);
-	/* Using IPv6 for none flag testing */
-	else if (h_proto == bpf_htons(ETH_P_IPV6))
-		return bpf_redirect_map(&map_all, if_index, 0);
-	/* All others for BPF_F_BROADCAST testing */
-	else
-		return bpf_redirect_map(&map_all, 0, BPF_F_BROADCAST);
+	h_proto = bpf_htons(eth->h_proto);
+
+	flags_from_map = bpf_map_lookup_elem(&redirect_flags, &h_proto);
+
+	/* Default flags for IPv4 : (BPF_F_BROADCAST | BPF_F_EXCLUDE_INGRESS) */
+	if (h_proto == ETH_P_IP) {
+		flags = flags_from_map ? *flags_from_map : BPF_F_BROADCAST | BPF_F_EXCLUDE_INGRESS;
+		return bpf_redirect_map(&map_all, 0, flags);
+	}
+	/* Default flags for IPv6 : 0 */
+	if (h_proto == ETH_P_IPV6) {
+		flags = flags_from_map ? *flags_from_map : 0;
+		return bpf_redirect_map(&map_all, if_index, flags);
+	}
+	/* Default flags for others BPF_F_BROADCAST : 0 */
+	else {
+		flags = flags_from_map ? *flags_from_map : BPF_F_BROADCAST;
+		return bpf_redirect_map(&map_all, 0, flags);
+	}
 }
 
 /* The following 2 progs are for 2nd devmap prog testing */

-- 
2.47.1


