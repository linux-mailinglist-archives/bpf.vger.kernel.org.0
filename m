Return-Path: <bpf+bounces-71309-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 552FEBEE575
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 14:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 280024EB7B2
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 12:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4E92E973F;
	Sun, 19 Oct 2025 12:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="OE3Gki4S"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E522E9754
	for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 12:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760877976; cv=none; b=Z2AGLqMADpgfUqqqbGf/wCT+5yXCTifL4kybaeenu+PhUGThHmAsrwh8Ezyxdi/GTQWbpEaipawv2zHkxqLtEAuhm+7JHGrfdrOHgrydQB5j+04byXmJKdzxRSR+MLKyWOVKxKAz1zXsy6CBGA2t0TTZul84MAFS1t9NoUKeE/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760877976; c=relaxed/simple;
	bh=YHy9xHMIb4yPr7wULSwsiYknsP7ln6RhfLiqyDd6n6E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=En6ssXSe+MGHpOx4OT06DZDZWNuVqQi5nAbZKSaAY1m4NXMAL4nNpeRbPHOVcEVMxhGapi53k00QKL4Wl9rHO0nA5wCwjALpg9X5q7pR3vIhgPcp0MD7qqNxU+DQPL/F253hP9ERTBGUDQ6OpRoJhan0SUQx9DzB4QL70cOdx6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=OE3Gki4S; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-63c4b41b38cso3167463a12.3
        for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 05:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1760877971; x=1761482771; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HmhrtKbFOuYR/bZCr0kTJtzEL+ndRJ/n7qpkLkm0d34=;
        b=OE3Gki4SRzL4h4IkAc0nlnF+xris8u5W+k6RkFYckNuy87GGNYZvFg+NUeYtm1B41F
         xgWKn5veO7y7aM94NsrhXhuTYzTkHhvwuEBYOCDtnqxr6RA4SNdJTPGQg3SNkLH2rMBK
         9PjVBGExhaovRYxTAdNvfkmewuEsvDaR3rvN8TehQMag2n1XQC3h8tSqvzdCG1edLaj8
         S+rZbEzn4KYd2HhUYmabeJY7vtvhqhHMaU6TwC7M7mhEK4KEfpN6V2vF/Ss1TG69Gd0M
         t0o1256TPrjkH4UspnqsdLE8m0GGiXMgma/qR21VVrO4v6RbX0N73yW04zACApLnrTHN
         ZsyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760877971; x=1761482771;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HmhrtKbFOuYR/bZCr0kTJtzEL+ndRJ/n7qpkLkm0d34=;
        b=GI4pHvNM5h4ykUTVAMw1AOBPsCJ2uHWDRy6FIzuRtvDcYeoNSrPV4pH3rw/CryDTQQ
         TD7PW0PvZSHBCHcUq3MJuIbX6g6du+Cfddv41/nCSJplibSgzxbAbotABlKAhj8puZgV
         LDhDCjjwNemF4xs0ts4Xh2Yo3f4fGUb7pyA0snIt+Xce0mBg8Iz+Tj6tRLb3is2USGGf
         vOi22ngA/bLLqkJa2BR2hCbkhHqTk22gLIkc7qGgMWfDMaaBQNGnpwNhlO+935+t+pM9
         T5ousmUrDAEoutMzocz+aNtV8Zw3CLgnCbCO4Tx8/4IOCcPDgi6Yw7wL1XXO1AV7LDPV
         F4Jg==
X-Gm-Message-State: AOJu0YwkJLpOIne66tXfk7oNDXUCt+//OFpCwfEUf/CkC1qwMyepHrfo
	OLzhXoEJevUsCIExy2elwfMTyzJmSoEnJfdLaejWUxGD3yCfImoYq6En8fFqfTxKSJw=
X-Gm-Gg: ASbGncu1KEPV4rFNAQqi8wH8V1Gcnnr3C5G00XkbBMVWz2lxfCUe+sYzIYtT8W9Mxmm
	rUDiaUY1lWTz0y8kDTsvlyTYRYXUZPVQKknhUADcxUip1eM3e2JIlUMjXv84wqFE6CIJd0sBTax
	/doqHVI12quYgVtmlvnIwhjO4KahHj9ScewtjhDZU63MdpGEHCOjOb8YwjhgR8/y0DBlOixvVM1
	U/L50Sr9qI4Rm3c0UX23EJ6J5gcGbkqoTxx2dlO+dWMCWxGH7uCFWB2YQbqRNAM8euiYlAdMTOP
	YYWrlrvH1emXFGQgzF6unK/LaakuLH+/bu0LfJ2oLVEc+ZXPvImkeLFlCpgXaLhiSk0SxuYE0/f
	gMDVq106xRuid0BFFNeRtCQAQgFDO5DlaftZlU3WcJr3U877FLzm/4kpp5mcZwOL8PAh80oyzAQ
	NAR2mJyaBaWttauwU7gG+8wDoNlea2XfQqfPIbEgZJhydib8fn
X-Google-Smtp-Source: AGHT+IEVT1XLwp7GU591cSJDVF20RqDyC+AqhaMHKO08eKKyCbozzhN9a7ZNM8oCKN0SRLEhux4Uzg==
X-Received: by 2002:a05:6402:518b:b0:63b:6b46:a494 with SMTP id 4fb4d7f45d1cf-63c1f645584mr9302179a12.14.1760877970780;
        Sun, 19 Oct 2025 05:46:10 -0700 (PDT)
Received: from cloudflare.com (79.184.180.133.ipv4.supernova.orange.pl. [79.184.180.133])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb526175sm498321866b.56.2025.10.19.05.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 05:46:10 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Sun, 19 Oct 2025 14:45:39 +0200
Subject: [PATCH bpf-next v2 15/15] selftests/bpf: Cover skb metadata access
 after bpf_skb_change_proto
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251019-skb-meta-rx-path-v2-15-f9a58f3eb6d6@cloudflare.com>
References: <20251019-skb-meta-rx-path-v2-0-f9a58f3eb6d6@cloudflare.com>
In-Reply-To: <20251019-skb-meta-rx-path-v2-0-f9a58f3eb6d6@cloudflare.com>
To: bpf@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
 KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Arthur Fabre <arthur@arthurfabre.com>, 
 netdev@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

Add a test to verify that skb metadata remains accessible after calling
bpf_skb_change_proto(), which modifies packet headroom to accommodate
different IP header sizes.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../bpf/prog_tests/xdp_context_test_run.c          |  5 +++++
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 25 ++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index 8880feb84cbf..6272d0451d23 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -506,6 +506,11 @@ void test_xdp_context_tuntap(void)
 			    skel->progs.helper_skb_change_head_tail,
 			    NULL, /* tc prio 2 */
 			    &skel->bss->test_pass);
+	if (test__start_subtest("helper_skb_change_proto"))
+		test_tuntap(skel->progs.ing_xdp,
+			    skel->progs.helper_skb_change_proto,
+			    NULL, /* tc prio 2 */
+			    &skel->bss->test_pass);
 
 	test_xdp_meta__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index 30ad4b1d00d5..6e4abac63e68 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -4,6 +4,7 @@
 #include <linux/if_ether.h>
 #include <linux/pkt_cls.h>
 
+#include <bpf/bpf_endian.h>
 #include <bpf/bpf_helpers.h>
 #include "bpf_kfuncs.h"
 
@@ -645,4 +646,28 @@ int helper_skb_change_head_tail(struct __sk_buff *ctx)
 	return TC_ACT_SHOT;
 }
 
+SEC("tc")
+int helper_skb_change_proto(struct __sk_buff *ctx)
+{
+	int err;
+
+	err = bpf_skb_change_proto(ctx, bpf_htons(ETH_P_IPV6), 0);
+	if (err)
+		goto out;
+
+	if (!check_skb_metadata(ctx))
+		goto out;
+
+	err = bpf_skb_change_proto(ctx, bpf_htons(ETH_P_IP), 0);
+	if (err)
+		goto out;
+
+	if (!check_skb_metadata(ctx))
+		goto out;
+
+	test_pass = true;
+out:
+	return TC_ACT_SHOT;
+}
+
 char _license[] SEC("license") = "GPL";

-- 
2.43.0


