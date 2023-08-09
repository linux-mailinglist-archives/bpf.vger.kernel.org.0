Return-Path: <bpf+bounces-7388-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B0E7765B4
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 18:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E684281B88
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 16:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C841D309;
	Wed,  9 Aug 2023 16:54:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFB71D2F9
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 16:54:28 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DFA1FD8
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 09:54:27 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5840614b13cso265877b3.0
        for <bpf@vger.kernel.org>; Wed, 09 Aug 2023 09:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691600066; x=1692204866;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SAWsGOwuL4yAXs1CKu5brubSJvNLwFCwEnBAYU1CXh8=;
        b=Rl07fv4RSeZt6GHGAyYpamGkb+SpqoufXLSRmrtPvBIse+xW3keSJJ7AOj1TJ+iJ8M
         4q4PjNIl1xQrP0laoO+GUbg8Hc3y6j6Tc5RZMmObJFu6B6CBF5bY4mANDmg+KHvYraqE
         JxmayOvJBfIQzAMM9Q0kWasVrEWWSCmldQhlhat3k9SR41W4ZxVmUYNdZG2wFWC5ov5c
         +6RDeDD5+N/Cg3dy6uO54/k/5iyCbmEZJgoCrShRJj5HLwtvWPTqNSjEuAHFuElW1w7+
         iMIal4ucbGwzTbqsXKqBPwoaieRHM1+1GOxSS275hSjcM0GDbxDEeA7TOKOawb49JCfo
         WT9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691600066; x=1692204866;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SAWsGOwuL4yAXs1CKu5brubSJvNLwFCwEnBAYU1CXh8=;
        b=UDiTh8zhwtnhZKlELYUzBtRzm/4Qg1lLRYlLBhTvsdbC9mbDCu1yIu+SgBRbd80EcI
         7dHSdSaDVjFSjrtjLxPI9hBdm+rnsXY1g9bV2vmZq0zrCPaUW5vnm8UyChZ0hvcZkRHz
         Si98veCf6deCwZoZbC+v0365Ee6GAzmBpD4VFkCOk2EDwNJ1JL/YnlZMzTXIuslAZhf9
         US8fGNykTGa1NjyYevfuOn5zkF0pgu2UziNjHpkWdorkIzeHPWt9RqkxwsTT4ALKj9oi
         YldgzOExuytK89phz0n++xNYkYCC5jzJIDHCfTUcoGn4K98bGjYTbg7sdMDkxKb18CHY
         PWrw==
X-Gm-Message-State: AOJu0YyPTVQgg2/bvCKAHtvPQgZP3IqIVIS61xuQ8CYFBlEFrsN0PbKN
	p6gFYrR21xJH/krOl5lI6ZQ8dFI+LIWIa21+NvdWWYUnfewLFnVWTCqo5m/o03E6lzurwyB8rjP
	hvs3rtR+4R8+mrMOP8prwZiPPZpr1mOgvlVxbRoXTXDgEz0cArQ==
X-Google-Smtp-Source: AGHT+IFWPpFovUo3s5BJj416rEKZgDbtp3AK30mGE/86LbyaL06BbW0v0jHmX68CZLC9+YZAVa+ULA4=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:690c:3706:b0:576:e268:903d with SMTP id
 fv6-20020a05690c370600b00576e268903dmr2563ywb.2.1691600066497; Wed, 09 Aug
 2023 09:54:26 -0700 (PDT)
Date: Wed,  9 Aug 2023 09:54:12 -0700
In-Reply-To: <20230809165418.2831456-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230809165418.2831456-1-sdf@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230809165418.2831456-4-sdf@google.com>
Subject: [PATCH bpf-next 3/9] tools: ynl: print xsk-features from the sample
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
2.41.0.640.ga95def55d0-goog


