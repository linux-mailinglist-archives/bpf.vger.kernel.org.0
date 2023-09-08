Return-Path: <bpf+bounces-9568-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9D6799294
	for <lists+bpf@lfdr.de>; Sat,  9 Sep 2023 01:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67D65281F36
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 23:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C461779C4;
	Fri,  8 Sep 2023 22:58:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F61D7472
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 22:58:17 +0000 (UTC)
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACDE81FF5
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 15:58:15 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-570096f51acso2760644a12.0
        for <bpf@vger.kernel.org>; Fri, 08 Sep 2023 15:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694213895; x=1694818695; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+pctUSafwe4blND7eBmA4Ld3j2KByva5xmEYPxwP5JQ=;
        b=Wx82+IkKtUEdu12a/Bfe2zQzrciXRa4JLTVh+Fi3xtsBqFZF6lyZIhrZwdZ3rRhyP0
         hNseJfboaRhMjIYiWFhsOokz09eneAyL1se/XvjDBLtwwUGUNfnRYNavIwoO33uNW+rh
         koEcJTCSW13xC15VYGXro4BVi47CohYMkW8tK5By4cFoaSiUiOO4Hk/EVmC8pBKHmeDF
         hm9RZdnV011BOo60DzFkR5/H9rh73nsT0jBlpJcHR7AkdPrHmEbgcCKGd1M2HQ2X/p7k
         vlhkfkgAcfBj8v9QrE4Evk2qkAvh8ro+81pJCsbxzmF3t0JlVFdbu4AREsyWLdEt35kF
         LBSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694213895; x=1694818695;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+pctUSafwe4blND7eBmA4Ld3j2KByva5xmEYPxwP5JQ=;
        b=MmdQYY2iQ6EgIHj+ODETD4D1Icy26DTMWdkySJVrDYknhJdnBx2ZD27N1TgFKBBkZD
         XWImPlzBxXnCiAB+Kg/WCAChxamdxSKqud5ja/ihkmZGdVtV170bfAeNsFM5M/xigrGD
         lb1hXcyDEWQ0ftVvkpSsKmNpsuDXv7UTloonDXPOfkUe3RGMAljKd91uvDrG5MHh8klU
         TGm5v8ylLrKV5lknhITdIEYT2t6QQMtgyNs3S0lsgENxrm0pLof9hcg/FpLHlKrWD3GC
         25JG9yWjwx9VJY8IrNXt6OAPvahc2tGBSVPnCqf9ncWc3LgGmZUhiDwBPrt+aN6svRc0
         P0pQ==
X-Gm-Message-State: AOJu0YwzVS6un4eSZQIv9302ZsgWIb5qMrx6qcToXfPWfg4G8y4537je
	pKp07WshJsx6ToHZt3l8o9p6FM87yt2wBc/MtjlRN2Hb8YxqLWVdIZJzSb62Hr/F8y4WnhGxHxc
	Dbv5/58txNXstaBOVXfah/swgSgIz9CjoStatLlv5uygQRZy46A==
X-Google-Smtp-Source: AGHT+IFDKFL3tUMqNSx3DrZVfT6EPLtb1WF7YYWAmBogx+8LgoWNQKxVAHAl9Wdqs9R3pu98DyGlTkM=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:dac7:b0:1c1:df80:67ef with SMTP id
 q7-20020a170902dac700b001c1df8067efmr1393869plx.1.1694213894961; Fri, 08 Sep
 2023 15:58:14 -0700 (PDT)
Date: Fri,  8 Sep 2023 15:58:07 -0700
In-Reply-To: <20230908225807.1780455-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230908225807.1780455-1-sdf@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230908225807.1780455-4-sdf@google.com>
Subject: [PATCH bpf-next 3/3] tools: ynl: extend netdev sample to dump xdp-rx-metadata-features
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	netdev@vger.kernel.org, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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


