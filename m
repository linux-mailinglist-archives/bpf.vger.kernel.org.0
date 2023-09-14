Return-Path: <bpf+bounces-10080-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3137A0F7F
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 23:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EF9B1C20CE0
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 21:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5547273C9;
	Thu, 14 Sep 2023 21:05:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1FE26E0F
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 21:05:01 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462352700
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 14:05:01 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d80db590b1cso2747701276.0
        for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 14:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694725500; x=1695330300; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=s8lJ/wwRdtQO1FPJ3x7uMnAOgiGCvLMvp8mW8wlA0oo=;
        b=yHP0JIars7HQmA5a3s3DoCjzBZHqVmgW2MVO7hTfbOuBq/savYnh4pQiRGQIS+2Gf/
         ESTS50FpbRbBtq5msFNYq4QAq12AcUxKz9ehsuY6hs0UQH5yAk2bEGxHvpH3TElY/Btm
         Yao+E6heXgMH+OF7xi/8gTUjMfC6kGBy4C6SBnqlRstX+ueWWsez6C/oGAdb5hbXLEMw
         88xjt/zicDdFkvZWDccYUTP8VSrnPYB9yOxb2TEiwNWgI+ERvbpItMwdSXFFOX/MyE8V
         GmuFUHLZhHS7R4zzSygnjTlwL3ZiMC4WUY/lCYdEywdN5odB4DpimwvSB0NaVzoxUfSK
         L5rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694725500; x=1695330300;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s8lJ/wwRdtQO1FPJ3x7uMnAOgiGCvLMvp8mW8wlA0oo=;
        b=MsSvcILOnZnhZbNMBoOVzrUjpZPzOfZ2OjcC3ZGVqWu97HTQvilAFlCdVPnRXEj1D0
         mF5egoaWS2TIKv7nhoqrlsz7IpkB0uw0NBCr9Fm3aUUr8xAsn4mdLDE2ehayIaZtXqkL
         lSYtPuq9UlSCLuyLdjZgm/FXliusIcrfN786QyxF5buu1Hhcj85a6E6siFbOGuEnr9cM
         GIj2dmqMivfIGi765/5OBkFp4VPwSMbmjKXU8EJGbzMEBS44c80yT6e0ohE7oZ+qMpKN
         D18Yxeo7PiJx7Va2aVI6h3j8BuCWA/TuMvfzG0DaMXGvHSFh5zMeycK2SMRbQ63t9W6U
         Qeiw==
X-Gm-Message-State: AOJu0Yy42Ppw0MgilevxBOV/gCax4LSH8cINilzFi0JiGTqSUBNaygvQ
	jI0kFE52LRL2OedKo9u3GjEkFn9BnwPpfjwOLdXBkzsFQ1SbE5C2YkaHLEHL3pOhOpk1P/pEnOT
	PtVvmaCp6AMT2LdedDlRpy38BAIYGbZH2e83gOGEohImq7d7U4g==
X-Google-Smtp-Source: AGHT+IGBVfjbSsKj7d7DebQnG2T8uSrtj2rRYcb2IwJR9AmePoOHHNUoBNQun7eAKz/+4xI5vDVwGVs=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:d141:0:b0:d77:fb00:b246 with SMTP id
 i62-20020a25d141000000b00d77fb00b246mr87035ybg.1.1694725500261; Thu, 14 Sep
 2023 14:05:00 -0700 (PDT)
Date: Thu, 14 Sep 2023 14:04:46 -0700
In-Reply-To: <20230914210452.2588884-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230914210452.2588884-1-sdf@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230914210452.2588884-4-sdf@google.com>
Subject: [PATCH bpf-next v2 3/9] tools: ynl: print xsk-features from the sample
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	kuba@kernel.org, toke@kernel.org, willemb@google.com, dsahern@kernel.org, 
	magnus.karlsson@intel.com, bjorn@kernel.org, maciej.fijalkowski@intel.com, 
	hawk@kernel.org, yoong.siang.song@intel.com, netdev@vger.kernel.org, 
	xdp-hints@xdp-project.net
Content-Type: text/plain; charset="UTF-8"

Regenerate the userspace specs and print xsk-features bitmask.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/net/ynl/generated/netdev-user.c | 19 +++++++++++++++++++
 tools/net/ynl/generated/netdev-user.h |  3 +++
 tools/net/ynl/samples/netdev.c        |  6 ++++++
 3 files changed, 28 insertions(+)

diff --git a/tools/net/ynl/generated/netdev-user.c b/tools/net/ynl/generated/netdev-user.c
index 68b408ca0f7f..f8dd6aa0ad97 100644
--- a/tools/net/ynl/generated/netdev-user.c
+++ b/tools/net/ynl/generated/netdev-user.c
@@ -45,12 +45,26 @@ const char *netdev_xdp_act_str(enum netdev_xdp_act value)
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
 	[NETDEV_A_DEV_XDP_ZC_MAX_SEGS] = { .name = "xdp-zc-max-segs", .type = YNL_PT_U32, },
+	[NETDEV_A_DEV_XSK_FEATURES] = { .name = "xsk-features", .type = YNL_PT_U64, },
 };
 
 struct ynl_policy_nest netdev_dev_nest = {
@@ -97,6 +111,11 @@ int netdev_dev_get_rsp_parse(const struct nlmsghdr *nlh, void *data)
 				return MNL_CB_ERROR;
 			dst->_present.xdp_zc_max_segs = 1;
 			dst->xdp_zc_max_segs = mnl_attr_get_u32(attr);
+		} else if (type == NETDEV_A_DEV_XSK_FEATURES) {
+			if (ynl_attr_validate(yarg, attr))
+				return MNL_CB_ERROR;
+			dst->_present.xsk_features = 1;
+			dst->xsk_features = mnl_attr_get_u64(attr);
 		}
 	}
 
diff --git a/tools/net/ynl/generated/netdev-user.h b/tools/net/ynl/generated/netdev-user.h
index 0952d3261f4d..b8c5cdb331b4 100644
--- a/tools/net/ynl/generated/netdev-user.h
+++ b/tools/net/ynl/generated/netdev-user.h
@@ -18,6 +18,7 @@ extern const struct ynl_family ynl_netdev_family;
 /* Enums */
 const char *netdev_op_str(int op);
 const char *netdev_xdp_act_str(enum netdev_xdp_act value);
+const char *netdev_xsk_flags_str(enum netdev_xsk_flags value);
 
 /* Common nested types */
 /* ============== NETDEV_CMD_DEV_GET ============== */
@@ -48,11 +49,13 @@ struct netdev_dev_get_rsp {
 		__u32 ifindex:1;
 		__u32 xdp_features:1;
 		__u32 xdp_zc_max_segs:1;
+		__u32 xsk_features:1;
 	} _present;
 
 	__u32 ifindex;
 	__u64 xdp_features;
 	__u32 xdp_zc_max_segs;
+	__u64 xsk_features;
 };
 
 void netdev_dev_get_rsp_free(struct netdev_dev_get_rsp *rsp);
diff --git a/tools/net/ynl/samples/netdev.c b/tools/net/ynl/samples/netdev.c
index 06433400dddd..06377e3f1df5 100644
--- a/tools/net/ynl/samples/netdev.c
+++ b/tools/net/ynl/samples/netdev.c
@@ -38,6 +38,12 @@ static void netdev_print_device(struct netdev_dev_get_rsp *d, unsigned int op)
 			printf(" %s", netdev_xdp_act_str(1 << i));
 	}
 
+	printf(" %llx:", d->xsk_features);
+	for (int i = 0; d->xsk_features > 1U << i; i++) {
+		if (d->xsk_features & (1U << i))
+			printf(" %s", netdev_xsk_flags_str(1 << i));
+	}
+
 	printf(" xdp-zc-max-segs=%u", d->xdp_zc_max_segs);
 
 	name = netdev_op_str(op);
-- 
2.42.0.459.ge4e396fd5e-goog


