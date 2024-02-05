Return-Path: <bpf+bounces-21217-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E418499DF
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 13:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B36B71C2227B
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 12:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FE21B94B;
	Mon,  5 Feb 2024 12:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="KUdQD6H3"
X-Original-To: bpf@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530431B940
	for <bpf@vger.kernel.org>; Mon,  5 Feb 2024 12:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707135046; cv=none; b=ed4qSLiwI0kv/CdhtHGYlsn8/9hk0wJtF/Vf5lVHIcKMFP2yiwaStcMV4G1aJsP8rPzJ5Udn0wX4p+WZRIK2q48uG7IT0x4UWmxZmvT/vIEWYYSR6/tqk8uKwkLwNHlby0pCURKk0fZQhi4pqcKlYb0b/cYNblwuLaUUADKcrPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707135046; c=relaxed/simple;
	bh=bmWW9azefKWVXvvPaC6Rbgf6MIu3v6TE2z+L9wuD+ys=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cn0N/bFdHLCM1ys0U1YJ7W8UiLj0NQNR5YIC5NAwB7eq3ZvLrmEOEPOcyof90/q9LuWWJAlWtZKq29/98WQUimD3hOi+uqbOf2GmURCyRyVBpzaSFOy4E64r5KYTaPGuOhksVvr3Hv5GQYBb5BhgOoZ+xhltfOY/pd3io1nnO8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=KUdQD6H3; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1707135041; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=436JHI4TNmxKB9kPzaqunFDwFm+p1yrlpEfFii5wkBw=;
	b=KUdQD6H32PTvT4H4tuCckXt0xaMHD0wyf9/nnfb9JvnuvFsxu0DgxAo/9wL3oa3tEquRFpHQ/3KRljbBHXwdUZtGAg3ioaR9GFjIt8T3yTIXRQBPxcXLfFrgMv9KpmEc6dToDITO0tw8OTNV8+0F3ROvuceAEd3vatn7hAayd44=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=lulie@linux.alibaba.com;NM=1;PH=DS;RN=25;SR=0;TI=SMTPD_---0W0AO6D8_1707135038;
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0W0AO6D8_1707135038)
          by smtp.aliyun-inc.com;
          Mon, 05 Feb 2024 20:10:39 +0800
From: Philo Lu <lulie@linux.alibaba.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	xuanzhuo@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	alibuda@linux.alibaba.com,
	guwen@linux.alibaba.com,
	hengqi@linux.alibaba.com
Subject: [PATCH bpf-next] bpf: allow bpf_skb_load_bytes in tracing prog
Date: Mon,  5 Feb 2024 20:10:38 +0800
Message-Id: <20240205121038.41344-1-lulie@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow using helper bpf_skb_load_bytes with BPF_PROG_TYPE_TRACING, which
is useful for skb parsing in raw_tp/fentry/fexit, especially for
non-linear paged skb data.

Selftests will be added if this patch is acceptable.

Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
---
 kernel/trace/bpf_trace.c |  3 +++
 net/core/filter.c        | 13 +++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 241ddf5e3895..4b928d929962 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1945,6 +1945,7 @@ static const struct bpf_func_proto bpf_perf_event_output_proto_raw_tp = {
 extern const struct bpf_func_proto bpf_skb_output_proto;
 extern const struct bpf_func_proto bpf_xdp_output_proto;
 extern const struct bpf_func_proto bpf_xdp_get_buff_len_trace_proto;
+extern const struct bpf_func_proto bpf_skb_load_bytes_trace_proto;
 
 BPF_CALL_3(bpf_get_stackid_raw_tp, struct bpf_raw_tracepoint_args *, args,
 	   struct bpf_map *, map, u64, flags)
@@ -2048,6 +2049,8 @@ tracing_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_get_socket_ptr_cookie_proto;
 	case BPF_FUNC_xdp_get_buff_len:
 		return &bpf_xdp_get_buff_len_trace_proto;
+	case BPF_FUNC_skb_load_bytes:
+		return &bpf_skb_load_bytes_trace_proto;
 #endif
 	case BPF_FUNC_seq_printf:
 		return prog->expected_attach_type == BPF_TRACE_ITER ?
diff --git a/net/core/filter.c b/net/core/filter.c
index 9f806cfbc654..ec5622ae8770 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -1764,6 +1764,19 @@ static const struct bpf_func_proto bpf_skb_load_bytes_proto = {
 	.arg4_type	= ARG_CONST_SIZE,
 };
 
+BTF_ID_LIST_SINGLE(bpf_skb_load_bytes_btf_ids, struct, sk_buff)
+
+const struct bpf_func_proto bpf_skb_load_bytes_trace_proto = {
+	.func		= bpf_skb_load_bytes,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_BTF_ID,
+	.arg1_btf_id	= &bpf_skb_load_bytes_btf_ids[0],
+	.arg2_type	= ARG_ANYTHING,
+	.arg3_type	= ARG_PTR_TO_UNINIT_MEM,
+	.arg4_type	= ARG_CONST_SIZE,
+};
+
 int __bpf_skb_load_bytes(const struct sk_buff *skb, u32 offset, void *to, u32 len)
 {
 	return ____bpf_skb_load_bytes(skb, offset, to, len);
-- 
2.32.0.3.g01195cf9f


