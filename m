Return-Path: <bpf+bounces-12232-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5552F7C9971
	for <lists+bpf@lfdr.de>; Sun, 15 Oct 2023 16:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 213591C20934
	for <lists+bpf@lfdr.de>; Sun, 15 Oct 2023 14:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D770679D9;
	Sun, 15 Oct 2023 14:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="ORNweTq+"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8570E6FDE
	for <bpf@vger.kernel.org>; Sun, 15 Oct 2023 14:17:30 +0000 (UTC)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEBE2F3
	for <bpf@vger.kernel.org>; Sun, 15 Oct 2023 07:17:27 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c9e06f058bso23142265ad.0
        for <bpf@vger.kernel.org>; Sun, 15 Oct 2023 07:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697379447; x=1697984247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jQwvcEuaD8qtq8qMfxzrYYiBWg40WGS1Tav8Ug6Qb8c=;
        b=ORNweTq+hN8tIEGYz2Vh0NJm1ki9R7JBN3Cu7ygENFKSagrHe+sAFwymK43LlQYa4O
         pLfz9slfiNG+0RRNCLeHSjE+nyvEweNcGW3N8QA8RS+QCC2EJBSl89uH74wr50EZjDBQ
         qMH/MRuL2GKqqeqq05HhbaVjeHaIApagYTdWuktKVf8XUonk8y1u/5Fi/N7r2Paq9Tvv
         fWhH4IsQgBXGx2w2rhz85AFWC8auPi6xNe0j1xyobcWyhLfpAek8oLyYRD3sVYOCyMy9
         DKBaKw+P5myUp+r6VCr+hSQ4skR9tM0S71bbnuzW2GeH8chz4EMyEJ1Q13HJ4LiZx35F
         5HOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697379447; x=1697984247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jQwvcEuaD8qtq8qMfxzrYYiBWg40WGS1Tav8Ug6Qb8c=;
        b=VyFMFrRr1hD9U5x5HIRphpbbAt3+f3qSVNtEyoQIC4AGbwj+APsS6PNpRvOlAqE0jJ
         EdwW1XvHTSVG2bSNp6eIcmkYu+kqfd6OBKBeYIOIfn1eOLdafnRlBng76HsNvxUen3WU
         i3XQdhSivee2cOpn8aCBwVPKOK0ZqWKNr/0X5C1Cvd/iL6AB/yogtdEkd4NCa/LwWpi2
         gC6F3pQVnmiQAUEZAGJ2EcEKIsqfudc+Jd/5xmj73LjXbVHvGQwb4hn3l0QE4xYiK/sg
         ihLQaRGmwsrk9+eIuMJb6j/WXQSgV8vl8gSraPLMK3q0u0Ygd5Mz0Kb9XLdqJ/imMGx9
         wVOg==
X-Gm-Message-State: AOJu0YwQIQm7Lf3luH2AMWjNdIXcc/4FPt1MvleIj1QXAeTXDrLZeMdp
	jn6tfAmPNslxBbh1xOqDDp0jiQ==
X-Google-Smtp-Source: AGHT+IHrFfjiox44OQRQFnZKdtFPkv5leUtQZcmEzH7FMdsenMLqiF2Tonpvh4fiH6sOm3mXPp3izQ==
X-Received: by 2002:a17:90b:124f:b0:27d:886:e2d2 with SMTP id gx15-20020a17090b124f00b0027d0886e2d2mr7855719pjb.7.1697379447008;
        Sun, 15 Oct 2023 07:17:27 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
        by smtp.gmail.com with UTF8SMTPSA id k3-20020a17090a910300b0027722832498sm2987862pjo.52.2023.10.15.07.17.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Oct 2023 07:17:26 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kselftest@vger.kernel.org,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Andrew Melnychenko <andrew@daynix.com>,
	Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [RFC PATCH v2 2/7] bpf: Add vnet_hash members to __sk_buff
Date: Sun, 15 Oct 2023 23:16:30 +0900
Message-ID: <20231015141644.260646-3-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231015141644.260646-1-akihiko.odaki@daynix.com>
References: <20231015141644.260646-1-akihiko.odaki@daynix.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

They will be used only by BPF_PROG_TYPE_VNET_HASH to tell the queues to
deliver packets and the hash values and types reported with virtio-net
headers.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/linux/filter.h         |  7 ++++
 net/core/filter.c              | 77 +++++++++++++++++++++++++++++++++-
 tools/include/uapi/linux/bpf.h |  4 ++
 3 files changed, 86 insertions(+), 2 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index bf7ad887943c..d10afe92ee45 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -643,6 +643,13 @@ struct bpf_skb_data_end {
 	void *data_end;
 };
 
+struct bpf_skb_vnet_hash_end {
+	struct qdisc_skb_cb qdisc_cb;
+	u32 hash_value;
+	u16 hash_report;
+	u16 rss_queue;
+};
+
 struct bpf_nh_params {
 	u32 nh_family;
 	union {
diff --git a/net/core/filter.c b/net/core/filter.c
index 867edbc628de..35bc60b71722 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -8435,9 +8435,15 @@ static bool bpf_skb_is_valid_access(int off, int size, enum bpf_access_type type
 	case bpf_ctx_range(struct __sk_buff, data):
 	case bpf_ctx_range(struct __sk_buff, data_meta):
 	case bpf_ctx_range(struct __sk_buff, data_end):
+	case bpf_ctx_range(struct __sk_buff, vnet_hash_value):
 		if (size != size_default)
 			return false;
 		break;
+	case bpf_ctx_range(struct __sk_buff, vnet_hash_report):
+	case bpf_ctx_range(struct __sk_buff, vnet_rss_queue):
+		if (size != sizeof(__u16))
+			return false;
+		break;
 	case bpf_ctx_range_ptr(struct __sk_buff, flow_keys):
 		return false;
 	case bpf_ctx_range(struct __sk_buff, hwtstamp):
@@ -8473,7 +8479,7 @@ static bool bpf_skb_is_valid_access(int off, int size, enum bpf_access_type type
 	return true;
 }
 
-static bool sk_filter_is_valid_access(int off, int size,
+static bool vnet_hash_is_valid_access(int off, int size,
 				      enum bpf_access_type type,
 				      const struct bpf_prog *prog,
 				      struct bpf_insn_access_aux *info)
@@ -8493,6 +8499,9 @@ static bool sk_filter_is_valid_access(int off, int size,
 	if (type == BPF_WRITE) {
 		switch (off) {
 		case bpf_ctx_range_till(struct __sk_buff, cb[0], cb[4]):
+		case bpf_ctx_range(struct __sk_buff, vnet_hash_value):
+		case bpf_ctx_range(struct __sk_buff, vnet_hash_report):
+		case bpf_ctx_range(struct __sk_buff, vnet_rss_queue):
 			break;
 		default:
 			return false;
@@ -8502,6 +8511,21 @@ static bool sk_filter_is_valid_access(int off, int size,
 	return bpf_skb_is_valid_access(off, size, type, prog, info);
 }
 
+static bool sk_filter_is_valid_access(int off, int size,
+				      enum bpf_access_type type,
+				      const struct bpf_prog *prog,
+				      struct bpf_insn_access_aux *info)
+{
+	switch (off) {
+	case bpf_ctx_range(struct __sk_buff, vnet_hash_value):
+	case bpf_ctx_range(struct __sk_buff, vnet_hash_report):
+	case bpf_ctx_range(struct __sk_buff, vnet_rss_queue):
+		return false;
+	}
+
+	return vnet_hash_is_valid_access(off, size, type, prog, info);
+}
+
 static bool cg_skb_is_valid_access(int off, int size,
 				   enum bpf_access_type type,
 				   const struct bpf_prog *prog,
@@ -8511,6 +8535,9 @@ static bool cg_skb_is_valid_access(int off, int size,
 	case bpf_ctx_range(struct __sk_buff, tc_classid):
 	case bpf_ctx_range(struct __sk_buff, data_meta):
 	case bpf_ctx_range(struct __sk_buff, wire_len):
+	case bpf_ctx_range(struct __sk_buff, vnet_hash_value):
+	case bpf_ctx_range(struct __sk_buff, vnet_hash_report):
+	case bpf_ctx_range(struct __sk_buff, vnet_rss_queue):
 		return false;
 	case bpf_ctx_range(struct __sk_buff, data):
 	case bpf_ctx_range(struct __sk_buff, data_end):
@@ -8558,6 +8585,9 @@ static bool lwt_is_valid_access(int off, int size,
 	case bpf_ctx_range(struct __sk_buff, tstamp):
 	case bpf_ctx_range(struct __sk_buff, wire_len):
 	case bpf_ctx_range(struct __sk_buff, hwtstamp):
+	case bpf_ctx_range(struct __sk_buff, vnet_hash_value):
+	case bpf_ctx_range(struct __sk_buff, vnet_hash_report):
+	case bpf_ctx_range(struct __sk_buff, vnet_rss_queue):
 		return false;
 	}
 
@@ -8799,6 +8829,10 @@ static bool tc_cls_act_is_valid_access(int off, int size,
 	}
 
 	switch (off) {
+	case bpf_ctx_range(struct __sk_buff, vnet_hash_value):
+	case bpf_ctx_range(struct __sk_buff, vnet_hash_report):
+	case bpf_ctx_range(struct __sk_buff, vnet_rss_queue):
+		return false;
 	case bpf_ctx_range(struct __sk_buff, data):
 		info->reg_type = PTR_TO_PACKET;
 		break;
@@ -9117,6 +9151,9 @@ static bool sk_skb_is_valid_access(int off, int size,
 	case bpf_ctx_range(struct __sk_buff, tstamp):
 	case bpf_ctx_range(struct __sk_buff, wire_len):
 	case bpf_ctx_range(struct __sk_buff, hwtstamp):
+	case bpf_ctx_range(struct __sk_buff, vnet_hash_value):
+	case bpf_ctx_range(struct __sk_buff, vnet_hash_report):
+	case bpf_ctx_range(struct __sk_buff, vnet_rss_queue):
 		return false;
 	}
 
@@ -9727,6 +9764,42 @@ static u32 bpf_convert_ctx_access(enum bpf_access_type type,
 						     hwtstamps, 8,
 						     target_size));
 		break;
+
+	case offsetof(struct __sk_buff, vnet_hash_value):
+		BUILD_BUG_ON(sizeof_field(struct bpf_skb_vnet_hash_end, hash_value) != 4);
+
+		off = offsetof(struct sk_buff, cb) +
+		      offsetof(struct bpf_skb_vnet_hash_end, hash_value);
+
+		if (type == BPF_WRITE)
+			*insn++ = BPF_EMIT_STORE(BPF_W, si, off);
+		else
+			*insn++ = BPF_LDX_MEM(BPF_W, si->dst_reg, si->src_reg, off);
+		break;
+
+	case offsetof(struct __sk_buff, vnet_hash_report):
+		BUILD_BUG_ON(sizeof_field(struct bpf_skb_vnet_hash_end, hash_report) != 2);
+
+		off = offsetof(struct sk_buff, cb) +
+		      offsetof(struct bpf_skb_vnet_hash_end, hash_report);
+
+		if (type == BPF_WRITE)
+			*insn++ = BPF_EMIT_STORE(BPF_H, si, off);
+		else
+			*insn++ = BPF_LDX_MEM(BPF_H, si->dst_reg, si->src_reg, off);
+		break;
+
+	case offsetof(struct __sk_buff, vnet_rss_queue):
+		BUILD_BUG_ON(sizeof_field(struct bpf_skb_vnet_hash_end, rss_queue) != 2);
+
+		off = offsetof(struct sk_buff, cb) +
+		      offsetof(struct bpf_skb_vnet_hash_end, rss_queue);
+
+		if (type == BPF_WRITE)
+			*insn++ = BPF_EMIT_STORE(BPF_H, si, off);
+		else
+			*insn++ = BPF_LDX_MEM(BPF_H, si->dst_reg, si->src_reg, off);
+		break;
 	}
 
 	return insn - insn_buf;
@@ -10969,7 +11042,7 @@ const struct bpf_prog_ops flow_dissector_prog_ops = {
 
 const struct bpf_verifier_ops vnet_hash_verifier_ops = {
 	.get_func_proto		= sk_filter_func_proto,
-	.is_valid_access	= sk_filter_is_valid_access,
+	.is_valid_access	= vnet_hash_is_valid_access,
 	.convert_ctx_access	= bpf_convert_ctx_access,
 	.gen_ld_abs		= bpf_gen_ld_abs,
 };
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 60976fe86247..298634556fab 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6112,6 +6112,10 @@ struct __sk_buff {
 	__u8  tstamp_type;
 	__u32 :24;		/* Padding, future use. */
 	__u64 hwtstamp;
+
+	__u32 vnet_hash_value;
+	__u16 vnet_hash_report;
+	__u16 vnet_rss_queue;
 };
 
 struct bpf_tunnel_key {
-- 
2.42.0


