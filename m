Return-Path: <bpf+bounces-5777-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0A576037A
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 02:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C3A21C20C8B
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 00:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C541154A9;
	Tue, 25 Jul 2023 00:00:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC1A1548D
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 00:00:08 +0000 (UTC)
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBE91732
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 17:00:07 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-55be4f03661so4378691a12.1
        for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 17:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690243207; x=1690848007;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fYPI2K6JBOjd1+pY70YCu9jKXxrCOX47P33ZqKkUSxc=;
        b=QmlwXkHzEauxPVcwS/n3ZMJfn8iybVtAxsXTt/jaraqj2wtVmuNQznBojqOs9mpncn
         gn7/j0AErZmAlABS/aKjbVs1z+rZjuKvA0c29UKOlbUvfb9KrQ9SvceBjKFu0mNn85vA
         TdTlzL5/EFeOZv9QJDIfd0u79hSm9opBGH31Uzok4NmSzGK7vyggYoAf+IRhM/ZwIYRi
         kVY3A4FYXXY7rlRIo3IiodHnnMXiJdpi549lX0dPk8fMEROEAnPnstVSuPrm3zGCPclX
         xYaRkHiQ8NYDnJ6n4zN49ngvBy+i1Nf9a8Kl9fqqFnrcP+3bIlKeuS8mzBejPuyYiTPE
         QLoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690243207; x=1690848007;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fYPI2K6JBOjd1+pY70YCu9jKXxrCOX47P33ZqKkUSxc=;
        b=bzsnUJ9OlrL1B752nglhf7aHiOZP6m6vXYxPCcqq8H+ZCG8I5pXJPXeI3lMVUF++s+
         L3pyXwmSlpmN7I8Gvy8WmeEb+5UIA9gdaz8XUHNOTN3hoeaxLWHFfo173w4A6RBztpdY
         x0Pja9ZSy/fbSVDIT6G1gMWYRDMTV4DAKDsRBa6JiI+ByzSSjeAn+5GZYjrsUCxRUZUg
         B2kYfCSbMsNr4Id5rlhN9KBATtrGmYBMk4NVUz+KWPe9Kjn3Jw72slLUxaXOu4slsIlj
         NBfuurF2661bgrIhlAJDKCXwnFvJIcUNRY2G8VUbTBCE17kB8oZlwgPWOvKbKS82DSVc
         8psA==
X-Gm-Message-State: ABy/qLbAVaRdK2816pSoGhtAYNS1mVX/5odkIisdLhL2Kx4xX1upnWuc
	umXSwBfkZs7JPNItdJWdhZg4v67KtX3Jw8rIb0WCPQbIfuZSvX+JhvssTKdahdxMc/xQO100fQv
	hk+8mQSiJjBapDVCzVuZfYmZ1WptmlUBV3la/FD1OFBySYqv8ww==
X-Google-Smtp-Source: APBJJlFE7wvCOtlI7Fx3yby8NAxK/U/VrkbEPfZrMzF0UfynwcVjEOofhg7KEXtL9k65YABa1rP174s=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:7702:0:b0:55f:e64f:d3e0 with SMTP id
 s2-20020a637702000000b0055fe64fd3e0mr45840pgc.4.1690243206840; Mon, 24 Jul
 2023 17:00:06 -0700 (PDT)
Date: Mon, 24 Jul 2023 16:59:53 -0700
In-Reply-To: <20230724235957.1953861-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230724235957.1953861-1-sdf@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230724235957.1953861-5-sdf@google.com>
Subject: [RFC net-next v4 4/8] tools: ynl: update netdev sample to dump xsk-features
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	kuba@kernel.org, toke@kernel.org, willemb@google.com, dsahern@kernel.org, 
	magnus.karlsson@intel.com, bjorn@kernel.org, maciej.fijalkowski@intel.com, 
	hawk@kernel.org, netdev@vger.kernel.org, xdp-hints@xdp-project.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

While at it, also dump recently added ZC max segs (and rename
it to use dashes). Plus fix small spelling issue.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 Documentation/netlink/specs/netdev.yaml |  6 ++++--
 tools/include/uapi/linux/netdev.h       | 15 +++++++++++++++
 tools/net/ynl/generated/netdev-user.c   | 25 +++++++++++++++++++++++++
 tools/net/ynl/generated/netdev-user.h   |  5 +++++
 tools/net/ynl/samples/netdev.c          |  8 ++++++++
 5 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index bf9c1cc32614..9002b37b7676 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -14,7 +14,7 @@ name: netdev
       -
         name: basic
         doc:
-          XDP feautues set supported by all drivers
+          XDP features set supported by all drivers
           (XDP_ABORTED, XDP_DROP, XDP_PASS, XDP_TX)
       -
         name: redirect
@@ -76,7 +76,7 @@ name: netdev
         enum: xdp-act
         enum-as-flags: true
       -
-        name: xdp_zc_max_segs
+        name: xdp-zc-max-segs
         doc: max fragment count supported by ZC driver
         type: u32
         checks:
@@ -102,6 +102,8 @@ name: netdev
           attributes:
             - ifindex
             - xdp-features
+            - xdp-zc-max-segs
+            - xsk-features
       dump:
         reply: *dev-all
     -
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index bf71698a1e82..cf1e11c76339 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -37,11 +37,26 @@ enum netdev_xdp_act {
 	NETDEV_XDP_ACT_MASK = 127,
 };
 
+/**
+ * enum netdev_xsk_flags
+ * @NETDEV_XSK_FLAGS_TX_TIMESTAMP: HW timestamping egress packets is supported
+ *   by the driver.
+ * @NETDEV_XSK_FLAGS_TX_CHECKSUM: L3 checksum HW offload is supported by the
+ *   driver.
+ */
+enum netdev_xsk_flags {
+	NETDEV_XSK_FLAGS_TX_TIMESTAMP = 1,
+	NETDEV_XSK_FLAGS_TX_CHECKSUM = 2,
+
+	NETDEV_XSK_FLAGS_MASK = 3,
+};
+
 enum {
 	NETDEV_A_DEV_IFINDEX = 1,
 	NETDEV_A_DEV_PAD,
 	NETDEV_A_DEV_XDP_FEATURES,
 	NETDEV_A_DEV_XDP_ZC_MAX_SEGS,
+	NETDEV_A_DEV_XSK_FEATURES,
 
 	__NETDEV_A_DEV_MAX,
 	NETDEV_A_DEV_MAX = (__NETDEV_A_DEV_MAX - 1)
diff --git a/tools/net/ynl/generated/netdev-user.c b/tools/net/ynl/generated/netdev-user.c
index 4eb8aefef0cd..f8dd6aa0ad97 100644
--- a/tools/net/ynl/generated/netdev-user.c
+++ b/tools/net/ynl/generated/netdev-user.c
@@ -45,11 +45,26 @@ const char *netdev_xdp_act_str(enum netdev_xdp_act value)
 	return netdev_xdp_act_strmap[value];
 }
 
+static const char * const netdev_xsk_flags_strmap[] = {
+	[0] = "tx-timestamp",
+	[1] = "tx-checksum",
+};
+
+const char *netdev_xsk_flags_str(enum netdev_xsk_flags value)
+{
+	value = ffs(value) - 1;
+	if (value < 0 || value >= (int)MNL_ARRAY_SIZE(netdev_xsk_flags_strmap))
+		return NULL;
+	return netdev_xsk_flags_strmap[value];
+}
+
 /* Policies */
 struct ynl_policy_attr netdev_dev_policy[NETDEV_A_DEV_MAX + 1] = {
 	[NETDEV_A_DEV_IFINDEX] = { .name = "ifindex", .type = YNL_PT_U32, },
 	[NETDEV_A_DEV_PAD] = { .name = "pad", .type = YNL_PT_IGNORE, },
 	[NETDEV_A_DEV_XDP_FEATURES] = { .name = "xdp-features", .type = YNL_PT_U64, },
+	[NETDEV_A_DEV_XDP_ZC_MAX_SEGS] = { .name = "xdp-zc-max-segs", .type = YNL_PT_U32, },
+	[NETDEV_A_DEV_XSK_FEATURES] = { .name = "xsk-features", .type = YNL_PT_U64, },
 };
 
 struct ynl_policy_nest netdev_dev_nest = {
@@ -91,6 +106,16 @@ int netdev_dev_get_rsp_parse(const struct nlmsghdr *nlh, void *data)
 				return MNL_CB_ERROR;
 			dst->_present.xdp_features = 1;
 			dst->xdp_features = mnl_attr_get_u64(attr);
+		} else if (type == NETDEV_A_DEV_XDP_ZC_MAX_SEGS) {
+			if (ynl_attr_validate(yarg, attr))
+				return MNL_CB_ERROR;
+			dst->_present.xdp_zc_max_segs = 1;
+			dst->xdp_zc_max_segs = mnl_attr_get_u32(attr);
+		} else if (type == NETDEV_A_DEV_XSK_FEATURES) {
+			if (ynl_attr_validate(yarg, attr))
+				return MNL_CB_ERROR;
+			dst->_present.xsk_features = 1;
+			dst->xsk_features = mnl_attr_get_u64(attr);
 		}
 	}
 
diff --git a/tools/net/ynl/generated/netdev-user.h b/tools/net/ynl/generated/netdev-user.h
index 5554dc69bb9c..b8c5cdb331b4 100644
--- a/tools/net/ynl/generated/netdev-user.h
+++ b/tools/net/ynl/generated/netdev-user.h
@@ -18,6 +18,7 @@ extern const struct ynl_family ynl_netdev_family;
 /* Enums */
 const char *netdev_op_str(int op);
 const char *netdev_xdp_act_str(enum netdev_xdp_act value);
+const char *netdev_xsk_flags_str(enum netdev_xsk_flags value);
 
 /* Common nested types */
 /* ============== NETDEV_CMD_DEV_GET ============== */
@@ -47,10 +48,14 @@ struct netdev_dev_get_rsp {
 	struct {
 		__u32 ifindex:1;
 		__u32 xdp_features:1;
+		__u32 xdp_zc_max_segs:1;
+		__u32 xsk_features:1;
 	} _present;
 
 	__u32 ifindex;
 	__u64 xdp_features;
+	__u32 xdp_zc_max_segs;
+	__u64 xsk_features;
 };
 
 void netdev_dev_get_rsp_free(struct netdev_dev_get_rsp *rsp);
diff --git a/tools/net/ynl/samples/netdev.c b/tools/net/ynl/samples/netdev.c
index d31268aa47c5..06377e3f1df5 100644
--- a/tools/net/ynl/samples/netdev.c
+++ b/tools/net/ynl/samples/netdev.c
@@ -38,6 +38,14 @@ static void netdev_print_device(struct netdev_dev_get_rsp *d, unsigned int op)
 			printf(" %s", netdev_xdp_act_str(1 << i));
 	}
 
+	printf(" %llx:", d->xsk_features);
+	for (int i = 0; d->xsk_features > 1U << i; i++) {
+		if (d->xsk_features & (1U << i))
+			printf(" %s", netdev_xsk_flags_str(1 << i));
+	}
+
+	printf(" xdp-zc-max-segs=%u", d->xdp_zc_max_segs);
+
 	name = netdev_op_str(op);
 	if (name)
 		printf(" (ntf: %s)", name);
-- 
2.41.0.487.g6d72f3e995-goog


