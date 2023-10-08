Return-Path: <bpf+bounces-11656-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 712047BCC4D
	for <lists+bpf@lfdr.de>; Sun,  8 Oct 2023 07:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26134281DA0
	for <lists+bpf@lfdr.de>; Sun,  8 Oct 2023 05:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BC01FDD;
	Sun,  8 Oct 2023 05:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="ICOmV4uF"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55324404
	for <bpf@vger.kernel.org>; Sun,  8 Oct 2023 05:22:36 +0000 (UTC)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863EFCA
	for <bpf@vger.kernel.org>; Sat,  7 Oct 2023 22:22:33 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6c67060fdfbso2526204a34.2
        for <bpf@vger.kernel.org>; Sat, 07 Oct 2023 22:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1696742553; x=1697347353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WXV1DoyjPp87oCp4GdEnt0NdQQSYrGAY7Po/ZL34Lp4=;
        b=ICOmV4uFzFgRoMojgZRrOjVo8ihVN+OsyeC2HpGHwhZhTv+S8pS5zv3E3EvwRfWK6c
         nlrLF4V5PzUsvWf0BGN8ri0n+NhVsZER9ZJrByrLKYqAL2fpupRS3aqSONte+GM6UbSZ
         DJ4AsQlyvf6/U4EJbLAU3mu0HAS/VTNuTYn3SjSKSSBKcG9BYHjVMAFTOjMqNSVVwlzF
         fkOQmg64wFEX33Wgc/U4OEz8L+e80ulBU8Oox9UD8bYILWIeZ0iEEllRrs5n6b+KIu6U
         nRHPgrBH1PFJ5wFUL5GEaWeu63FU0sSB7sEZxXAoQ1Vl0g7hJYsMi+KLKQF2AYoAwD0H
         A/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696742553; x=1697347353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WXV1DoyjPp87oCp4GdEnt0NdQQSYrGAY7Po/ZL34Lp4=;
        b=hv+dISgVxd9+EfJ3bsZQMRzKguuWmejyskUO0JRZpZ4znwajerUQ04pihIlnbTfKrM
         XxEnLfsDzZSq+M7eJ96qMZI3V9DV9cmasrXgDmvNoTjKLjUXjUge8VFczxjLc5ZFxk9e
         /bKtDOrnPrRilgSbpONEmTN4jWHJc3ogWq7IF03q9ejKNGUKznX6Wem4LD9x3CLKz+Q4
         l1tASwIPV2UC4N2SpKt9LOZhBZLBtDhVnTpECUSatvMRqb56VxXwQuXrLU9xjjb44Lz3
         vnUegdQYLWrVuqLfUyJi7dkhR4KA7tql4dnDEhNWI3IOTsgqCh5dbIUcF92bhHjLKgi7
         yLvw==
X-Gm-Message-State: AOJu0YwuHZEFJ8jSSxZPdGCSPd9alGXZ3DGUfySne8bwMuOPs/oOxCZT
	HcPJ+jxVVCKTohUeNfvhLBzm2A==
X-Google-Smtp-Source: AGHT+IEnM/w6bYhuIff7nAc+N4szl0w92GRiQtiPkGnHsbTVEUpZD8V3VNSUvSGiEbmYvN35F3h12A==
X-Received: by 2002:a05:6870:9602:b0:1dd:443c:57a8 with SMTP id d2-20020a056870960200b001dd443c57a8mr16038022oaq.26.1696742552670;
        Sat, 07 Oct 2023 22:22:32 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
        by smtp.gmail.com with UTF8SMTPSA id e4-20020a170902d38400b001bb9bc8d232sm6796924pld.61.2023.10.07.22.22.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Oct 2023 22:22:32 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo Shuah Khan <"xuanzhuo@linux.alibaba.comshuah"@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
	songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
	kpsingh@kernel.org, rdunlap@infradead.org, willemb@google.com,
	gustavoars@kernel.org, herbert@gondor.apana.org.au,
	steffen.klassert@secunet.com, nogikh@google.com, pablo@netfilter.org,
	decui@microsoft.com, cai@lca.pw, jakub@cloudflare.com,
	elver@google.com, pabeni@redhat.com,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [RFC PATCH 4/7] virtio_net: Add functions for hashing
Date: Sun,  8 Oct 2023 14:20:48 +0900
Message-ID: <20231008052101.144422-5-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231008052101.144422-1-akihiko.odaki@daynix.com>
References: <20231008052101.144422-1-akihiko.odaki@daynix.com>
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

They are useful to implement VIRTIO_NET_F_RSS and
VIRTIO_NET_F_HASH_REPORT.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/linux/virtio_net.h | 157 +++++++++++++++++++++++++++++++++++++
 1 file changed, 157 insertions(+)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 7b4dd69555e4..f05781ddc261 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -7,6 +7,143 @@
 #include <uapi/linux/udp.h>
 #include <uapi/linux/virtio_net.h>
 
+struct virtio_net_hash {
+	u32 value;
+	u16 report;
+};
+
+struct virtio_net_toeplitz_state {
+	u32 hash;
+	u32 key_buffer;
+	const u32 *key;
+};
+
+#define VIRTIO_NET_SUPPORTED_HASH_TYPES (VIRTIO_NET_RSS_HASH_TYPE_IPv4 | \
+					 VIRTIO_NET_RSS_HASH_TYPE_TCPv4 | \
+					 VIRTIO_NET_RSS_HASH_TYPE_UDPv4 | \
+					 VIRTIO_NET_RSS_HASH_TYPE_IPv6 | \
+					 VIRTIO_NET_RSS_HASH_TYPE_TCPv6 | \
+					 VIRTIO_NET_RSS_HASH_TYPE_UDPv6)
+
+static inline void virtio_net_toeplitz(struct virtio_net_toeplitz_state *state,
+				       const u32 *input, size_t len)
+{
+	u32 key;
+
+	while (len) {
+		state->key++;
+		key = ntohl(*state->key);
+
+		for (u32 bit = BIT(31); bit; bit >>= 1) {
+			if (*input & bit)
+				state->hash ^= state->key_buffer;
+
+			state->key_buffer =
+				(state->key_buffer << 1) | !!(key & bit);
+		}
+
+		input++;
+		len--;
+	}
+}
+
+static inline u8 virtio_net_hash_key_length(u32 types)
+{
+	size_t len = 0;
+
+	if (types & VIRTIO_NET_HASH_REPORT_IPv4)
+		len = max(len,
+			  sizeof(struct flow_dissector_key_ipv4_addrs));
+
+	if (types &
+	    (VIRTIO_NET_HASH_REPORT_TCPv4 | VIRTIO_NET_HASH_REPORT_UDPv4))
+		len = max(len,
+			  sizeof(struct flow_dissector_key_ipv4_addrs) +
+			  sizeof(struct flow_dissector_key_ports));
+
+	if (types & VIRTIO_NET_HASH_REPORT_IPv6)
+		len = max(len,
+			  sizeof(struct flow_dissector_key_ipv6_addrs));
+
+	if (types &
+	    (VIRTIO_NET_HASH_REPORT_TCPv6 | VIRTIO_NET_HASH_REPORT_UDPv6))
+		len = max(len,
+			  sizeof(struct flow_dissector_key_ipv6_addrs) +
+			  sizeof(struct flow_dissector_key_ports));
+
+	return 4 + len;
+}
+
+static inline void virtio_net_hash(const struct sk_buff *skb,
+				   u32 types, const u32 *key,
+				   struct virtio_net_hash *hash)
+{
+	u16 report = VIRTIO_NET_HASH_REPORT_NONE;
+	struct virtio_net_toeplitz_state toeplitz_state = {
+		.key_buffer = ntohl(*key),
+		.key = key
+	};
+	struct flow_keys flow;
+
+	if (!skb_flow_dissect_flow_keys(skb, &flow, 0))
+		return;
+
+	switch (flow.basic.n_proto) {
+	case htons(ETH_P_IP):
+		if (flow.basic.ip_proto == IPPROTO_TCP &&
+		    (types & VIRTIO_NET_RSS_HASH_TYPE_TCPv4)) {
+			report = VIRTIO_NET_HASH_REPORT_TCPv4;
+			virtio_net_toeplitz(&toeplitz_state,
+					    (u32 *)&flow.addrs.v4addrs,
+					    sizeof(flow.addrs.v4addrs) / 4);
+			virtio_net_toeplitz(&toeplitz_state, &flow.ports.ports,
+					    1);
+		} else if (flow.basic.ip_proto == IPPROTO_UDP &&
+			   (types & VIRTIO_NET_RSS_HASH_TYPE_UDPv4)) {
+			report = VIRTIO_NET_HASH_REPORT_UDPv4;
+			virtio_net_toeplitz(&toeplitz_state,
+					    (u32 *)&flow.addrs.v4addrs,
+					    sizeof(flow.addrs.v4addrs) / 4);
+			virtio_net_toeplitz(&toeplitz_state, &flow.ports.ports,
+					    1);
+		} else if (types & VIRTIO_NET_RSS_HASH_TYPE_IPv4) {
+			report = VIRTIO_NET_HASH_REPORT_IPv4;
+			virtio_net_toeplitz(&toeplitz_state,
+					    (u32 *)&flow.addrs.v4addrs,
+					    sizeof(flow.addrs.v4addrs) / 4);
+		}
+		break;
+
+	case htons(ETH_P_IPV6):
+		if (flow.basic.ip_proto == IPPROTO_TCP &&
+		    (types & VIRTIO_NET_RSS_HASH_TYPE_TCPv6)) {
+			report = VIRTIO_NET_HASH_REPORT_TCPv6;
+			virtio_net_toeplitz(&toeplitz_state,
+					    (u32 *)&flow.addrs.v6addrs,
+					    sizeof(flow.addrs.v6addrs) / 4);
+			virtio_net_toeplitz(&toeplitz_state, &flow.ports.ports,
+					    1);
+		} else if (flow.basic.ip_proto == IPPROTO_UDP &&
+			   (types & VIRTIO_NET_RSS_HASH_TYPE_UDPv6)) {
+			report = VIRTIO_NET_HASH_REPORT_UDPv6;
+			virtio_net_toeplitz(&toeplitz_state,
+					    (u32 *)&flow.addrs.v6addrs,
+					    sizeof(flow.addrs.v6addrs) / 4);
+			virtio_net_toeplitz(&toeplitz_state, &flow.ports.ports,
+					    1);
+		} else if (types & VIRTIO_NET_RSS_HASH_TYPE_IPv6) {
+			report = VIRTIO_NET_HASH_REPORT_IPv6;
+			virtio_net_toeplitz(&toeplitz_state,
+					    (u32 *)&flow.addrs.v6addrs,
+					    sizeof(flow.addrs.v6addrs) / 4);
+		}
+		break;
+	}
+
+	hash->value = toeplitz_state.hash;
+	hash->report = report;
+}
+
 static inline bool virtio_net_hdr_match_proto(__be16 protocol, __u8 gso_type)
 {
 	switch (gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {
@@ -216,4 +353,24 @@ static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
 	return 0;
 }
 
+static inline int virtio_net_hdr_v1_hash_from_skb(const struct sk_buff *skb,
+						  struct virtio_net_hdr_v1_hash *hdr,
+						  bool has_data_valid,
+						  int vlan_hlen,
+						  const struct virtio_net_hash *hash)
+{
+	int ret;
+
+	memset(hdr, 0, sizeof(*hdr));
+
+	ret = virtio_net_hdr_from_skb(skb, (struct virtio_net_hdr *)hdr,
+				      true, has_data_valid, vlan_hlen);
+	if (!ret) {
+		hdr->hash_value = cpu_to_le32(hash->value);
+		hdr->hash_report = cpu_to_le16(hash->report);
+	}
+
+	return ret;
+}
+
 #endif /* _LINUX_VIRTIO_NET_H */
-- 
2.42.0


