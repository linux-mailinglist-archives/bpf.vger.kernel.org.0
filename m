Return-Path: <bpf+bounces-9948-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2458579F021
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 19:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA0ED1C21393
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 17:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE5722EE6;
	Wed, 13 Sep 2023 17:14:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D89E200A8
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 17:14:00 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199FF98
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 10:13:59 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58ee4df08fbso482687b3.3
        for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 10:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694625238; x=1695230038; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+pctUSafwe4blND7eBmA4Ld3j2KByva5xmEYPxwP5JQ=;
        b=oZh+5sWvorvjXmi8QquWFzXHsQYLXwkIpRi2C7BsYZr+WNNTadvNXR5SrzP11yZAHo
         vGa7Fl03EkqtDqRtHymd/orLN/8LrwZs3HddDWUrzpl2u4FSeb1sc0SIijayUIUgDlLE
         9HVVRYAaJEus8YEBY2qRE85RICXo6LeyX4ZfzdlAnDOe5/MseafUwbDH4nMVPe4etfqF
         ah8KVpfiTiK+AmQ7UXEK4VGNu8xoKHBgnQW1MYk3fRHiKX5N1vhyuIBUnKdsKcwF02D4
         uH1PRhwDa4yYxLYA+jRBvUu7Dvmdnst2eZf+D9bsTgEzhJZ8C8QTwqowxHlGBA2pDduA
         eG4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694625238; x=1695230038;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+pctUSafwe4blND7eBmA4Ld3j2KByva5xmEYPxwP5JQ=;
        b=vNYRe3pc34Y8qEC+IZLsYh54mYSmYyK+cuAFPZmwcT+73KiG1yBB24f1Q8jaYB3rEy
         PmZOJ6FOaQt8rtiQ5E0TDCl0555k7v5UWJiACJbgKKWPtV80Ux1KWSGoP9GCMKxMS2zP
         CdakiQToQCRNRPCIsuGuZGg8SsvuXuVD42GmQCehp3cdowwjuxmlm64ZvGghINm9I8xM
         biQbmvxv2cCU0D0xdtiGiI6yBddOXoQtbjwY8J4348vQLsInzsr3zrmAFuq+Hxkk+PQa
         Hn1TgA8fPcqgZaaXav7uohL9T3noVKL1uwgW7FqwGYRHPmjE8Cw/yr4QzxwBh2fbO4WY
         HdGw==
X-Gm-Message-State: AOJu0Yx5oXXnjgAvZyyLpYaGncJ2xZsbnVoZrBmbMoxuTFuGbg2IipLo
	E/MYvl0d1BWYy0Hl5nRTlvIQjFwTNy+EdDd9Aridk51b2QtG1ljGiFKUI5XZidaP4t9zy45P5zZ
	wUL7jDe/152U6o+rJ/dLL0sPSUhcyYkMB/utippZu3DMMBOgi2w==
X-Google-Smtp-Source: AGHT+IGfya7jhXHciHY+oSoS33V/H71xWPutOFMhoGs9D/DCVKnDROKYCTt8Gpb4Sx7z6+dzWpLmA5Q=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a5b:60e:0:b0:d81:5c03:df95 with SMTP id
 d14-20020a5b060e000000b00d815c03df95mr53862ybq.12.1694625238225; Wed, 13 Sep
 2023 10:13:58 -0700 (PDT)
Date: Wed, 13 Sep 2023 10:13:50 -0700
In-Reply-To: <20230913171350.369987-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230913171350.369987-1-sdf@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230913171350.369987-4-sdf@google.com>
Subject: [PATCH bpf-next v2 3/3] tools: ynl: extend netdev sample to dump xdp-rx-metadata-features
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	netdev@vger.kernel.org, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"

The tool can be used to verify that everything works end to end.

Unrelated updates:
- include tools/include/uapi to pick the latest kernel uapi headers
- print "xdp-features" and "xdp-rx-metadata-features" so it's clear
  which bitmask is being dumped

Cc: netdev@vger.kernel.org
Cc: Willem de Bruijn <willemb@google.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/net/ynl/generated/netdev-user.c | 19 +++++++++++++++++++
 tools/net/ynl/generated/netdev-user.h |  3 +++
 tools/net/ynl/samples/Makefile        |  2 +-
 tools/net/ynl/samples/netdev.c        |  8 +++++++-
 4 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/tools/net/ynl/generated/netdev-user.c b/tools/net/ynl/generated/netdev-user.c
index 68b408ca0f7f..b5ffe8cd1144 100644
--- a/tools/net/ynl/generated/netdev-user.c
+++ b/tools/net/ynl/generated/netdev-user.c
@@ -45,12 +45,26 @@ const char *netdev_xdp_act_str(enum netdev_xdp_act value)
 	return netdev_xdp_act_strmap[value];
 }
 
+static const char * const netdev_xdp_rx_metadata_strmap[] = {
+	[0] = "timestamp",
+	[1] = "hash",
+};
+
+const char *netdev_xdp_rx_metadata_str(enum netdev_xdp_rx_metadata value)
+{
+	value = ffs(value) - 1;
+	if (value < 0 || value >= (int)MNL_ARRAY_SIZE(netdev_xdp_rx_metadata_strmap))
+		return NULL;
+	return netdev_xdp_rx_metadata_strmap[value];
+}
+
 /* Policies */
 struct ynl_policy_attr netdev_dev_policy[NETDEV_A_DEV_MAX + 1] = {
 	[NETDEV_A_DEV_IFINDEX] = { .name = "ifindex", .type = YNL_PT_U32, },
 	[NETDEV_A_DEV_PAD] = { .name = "pad", .type = YNL_PT_IGNORE, },
 	[NETDEV_A_DEV_XDP_FEATURES] = { .name = "xdp-features", .type = YNL_PT_U64, },
 	[NETDEV_A_DEV_XDP_ZC_MAX_SEGS] = { .name = "xdp-zc-max-segs", .type = YNL_PT_U32, },
+	[NETDEV_A_DEV_XDP_RX_METADATA_FEATURES] = { .name = "xdp-rx-metadata-features", .type = YNL_PT_U64, },
 };
 
 struct ynl_policy_nest netdev_dev_nest = {
@@ -97,6 +111,11 @@ int netdev_dev_get_rsp_parse(const struct nlmsghdr *nlh, void *data)
 				return MNL_CB_ERROR;
 			dst->_present.xdp_zc_max_segs = 1;
 			dst->xdp_zc_max_segs = mnl_attr_get_u32(attr);
+		} else if (type == NETDEV_A_DEV_XDP_RX_METADATA_FEATURES) {
+			if (ynl_attr_validate(yarg, attr))
+				return MNL_CB_ERROR;
+			dst->_present.xdp_rx_metadata_features = 1;
+			dst->xdp_rx_metadata_features = mnl_attr_get_u64(attr);
 		}
 	}
 
diff --git a/tools/net/ynl/generated/netdev-user.h b/tools/net/ynl/generated/netdev-user.h
index 0952d3261f4d..b4351ff34595 100644
--- a/tools/net/ynl/generated/netdev-user.h
+++ b/tools/net/ynl/generated/netdev-user.h
@@ -18,6 +18,7 @@ extern const struct ynl_family ynl_netdev_family;
 /* Enums */
 const char *netdev_op_str(int op);
 const char *netdev_xdp_act_str(enum netdev_xdp_act value);
+const char *netdev_xdp_rx_metadata_str(enum netdev_xdp_rx_metadata value);
 
 /* Common nested types */
 /* ============== NETDEV_CMD_DEV_GET ============== */
@@ -48,11 +49,13 @@ struct netdev_dev_get_rsp {
 		__u32 ifindex:1;
 		__u32 xdp_features:1;
 		__u32 xdp_zc_max_segs:1;
+		__u32 xdp_rx_metadata_features:1;
 	} _present;
 
 	__u32 ifindex;
 	__u64 xdp_features;
 	__u32 xdp_zc_max_segs;
+	__u64 xdp_rx_metadata_features;
 };
 
 void netdev_dev_get_rsp_free(struct netdev_dev_get_rsp *rsp);
diff --git a/tools/net/ynl/samples/Makefile b/tools/net/ynl/samples/Makefile
index f2db8bb78309..32abbc0af39e 100644
--- a/tools/net/ynl/samples/Makefile
+++ b/tools/net/ynl/samples/Makefile
@@ -4,7 +4,7 @@ include ../Makefile.deps
 
 CC=gcc
 CFLAGS=-std=gnu11 -O2 -W -Wall -Wextra -Wno-unused-parameter -Wshadow \
-	-I../lib/ -I../generated/ -idirafter $(UAPI_PATH)
+	-I../../../include/uapi -I../lib/ -I../generated/ -idirafter $(UAPI_PATH)
 ifeq ("$(DEBUG)","1")
   CFLAGS += -g -fsanitize=address -fsanitize=leak -static-libasan
 endif
diff --git a/tools/net/ynl/samples/netdev.c b/tools/net/ynl/samples/netdev.c
index 06433400dddd..b828225daad0 100644
--- a/tools/net/ynl/samples/netdev.c
+++ b/tools/net/ynl/samples/netdev.c
@@ -32,12 +32,18 @@ static void netdev_print_device(struct netdev_dev_get_rsp *d, unsigned int op)
 	if (!d->_present.xdp_features)
 		return;
 
-	printf("%llx:", d->xdp_features);
+	printf("xdp-features (%llx):", d->xdp_features);
 	for (int i = 0; d->xdp_features > 1U << i; i++) {
 		if (d->xdp_features & (1U << i))
 			printf(" %s", netdev_xdp_act_str(1 << i));
 	}
 
+	printf(" xdp-rx-metadata-features (%llx):", d->xdp_rx_metadata_features);
+	for (int i = 0; d->xdp_rx_metadata_features > 1U << i; i++) {
+		if (d->xdp_rx_metadata_features & (1U << i))
+			printf(" %s", netdev_xdp_rx_metadata_str(1 << i));
+	}
+
 	printf(" xdp-zc-max-segs=%u", d->xdp_zc_max_segs);
 
 	name = netdev_op_str(op);
-- 
2.42.0.283.g2d96d420d3-goog


