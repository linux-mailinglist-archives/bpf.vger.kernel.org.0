Return-Path: <bpf+bounces-72247-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4943BC0A9A8
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 15:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 654FD3B1FBC
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 14:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E662ED14B;
	Sun, 26 Oct 2025 14:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="cF9GaV4I"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FC62EBDD7
	for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 14:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761488342; cv=none; b=XB0V+Fh9gsc02S4c4f0V0GE8dZnjz4cpTyJZQZreABO5uM/01bNlOSITGJXfop9SC9V3GQ/zHHcUYUWIjdkDgu4e+LzG/ekj8AapFA3AdteTAzPtL0A1kN+WFx2IoIUgZxhMqFtVKrMG0M9xBWPvNnT3aZo+3Ftk5jRTcJKcF4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761488342; c=relaxed/simple;
	bh=VUOxBzWdi/P4JXAn2CMXcBcXr7Zvc+PLt+1VnIO/4EQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qrnEHxxHd08zntyjL3fS61AO6U5DL3Y/LSkN6vmnN0sNEtfKsswDxhLVnQN4/xs+eUXjWTBmE06lK2JOKsgF3Mt9y21u/HlDu1dqrx0Gm9lay/aWb9ZA86oZ02XYuXLShi7RwfqkiVT4PzKDK4bfO7Bc9o6A2XcMOzIGDfiOADg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=cF9GaV4I; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so870657666b.3
        for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 07:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1761488339; x=1762093139; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BIYEp5jf3DF2obWH68x3Qx6ILUs6OxNZEAiHHVDWtJs=;
        b=cF9GaV4ItYZwrl6ha20zlIPWxuZSwFwOsoOe5STyD0YyE0MLsSpAVQu2ljzkPE/l9r
         LorIWrra2MhWgZ/B5FgD3zmzPoY8yG/vGiD8y2lDjd+XbXdDqY3CGaaggQqpvy3JqKCt
         ZmSrLbWyTIn+Cv5dS39uAynKpN/+C7+7RG8rD1PEiBQNHdcMRVCUKA/TpC6igap2jwlq
         o4zdGjfZIbJ9iqrsxfcqPUfOHzQcVPUyvE0NsoHPqwjVelSux0kKYyZ8V+vM45kOEiTC
         Q0OSpdL0HoyqUAKpKaTZcV6/LmVQGeZ4CORd5oHjlRbZfo/7fWfKy3//xkAWqNe6JHUo
         Qadw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761488339; x=1762093139;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BIYEp5jf3DF2obWH68x3Qx6ILUs6OxNZEAiHHVDWtJs=;
        b=Vw+x39nJsdUURDxGUnxk3jfQXlO/TH9X6YU3zoBcPsLvL5WjlCmmcCzry/OEeSRR/p
         o54qFxq4jFJ3x8zZvJMn3H6QSmm1FjA5fMRb7s7pRmHgYdkalMR5JLqET7MbIxdpB/VI
         QK+AmWFmLZcU6njpDRuD6fx8MZ5l63fypX7WK8vGlfoZSPE8D4M1Wud/SeCY5vszPijm
         7LyBZewI5RnzUS3nnoqAk33xZr19Y4Ph0cmH5doVRIj+msIZgRCYgL+Vf52WwZEeBAdW
         rbJF/PHmTJpKTYA04oN6qreoYzxSoi6QYHj4WY+1Izv6EXVIiOvQmoKhw5XTkwl7yRmf
         3RGQ==
X-Gm-Message-State: AOJu0YyW0TFe7nLiNLH7etT3361E4bf3Gn1RQOgkIQK5FhegWWPiA5of
	qksw+lt9rF3YsR707rR1z1UsK3Ed1Ale9gQ0/LclJ92HuEfPXOSNZxtmXEsnjDJXAsI=
X-Gm-Gg: ASbGncv6s932fVjOKo+U4UUdixpaVLCLpUUE51E/wwD1eLFpppiYfXMvrK3Ta1tXRgR
	wPVURLMSrC0WnntuKDzt3FdbAhJ8bGy21jE3PIVkEOtx4qzH4BuKckC0C6Z2IkVtUHcNIYHL085
	4x4ZCViB5fBuXo3yeFlYsWQZ0jH7t74Yeuk53vYLqKf/vsAfmdRkegvTxd+rOOxNRCGE1i+E3a7
	pnTGguX8nhp4Vge1cGbAnWNl6VIVoLm40oPUXcl0wW2BQVThax2x+4wi7v/rK2F6DdDaZ1I5Z5E
	NbP+IhBkjdTm9bR8s/56aP+WcFCueemSheDjcIXGpfBtHXJ61idm5m/8UN8pAFNt4Q3rEZuo3gK
	QkkMPqCUbXndMwWHk5f1Nq8Y0xgWO4L3EQwzaGTBd6OdbgSBbHypDTIvWGF5jGDfoLbXzGXOJPR
	2Pg8qucSdDVMo4QQRDwR/wKS+IZPKK4CWawdq8kH2zbprXK1D1RPWcyCrX
X-Google-Smtp-Source: AGHT+IGJUW4M0SbvZedEGnYzGrGqPLO2ylbPowgKA9waqCN8YWhkVNVzctsW90v9gw5LN9dhwbKnkg==
X-Received: by 2002:a17:907:3f21:b0:b57:78fa:db46 with SMTP id a640c23a62f3a-b6d6ffe193bmr950973066b.43.1761488339165;
        Sun, 26 Oct 2025 07:18:59 -0700 (PDT)
Received: from cloudflare.com (79.184.211.13.ipv4.supernova.orange.pl. [79.184.211.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d8992aa28sm416751566b.41.2025.10.26.07.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 07:18:58 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Sun, 26 Oct 2025 15:18:36 +0100
Subject: [PATCH bpf-next v3 16/16] selftests/bpf: Cover skb metadata access
 after bpf_skb_change_proto
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251026-skb-meta-rx-path-v3-16-37cceebb95d3@cloudflare.com>
References: <20251026-skb-meta-rx-path-v3-0-37cceebb95d3@cloudflare.com>
In-Reply-To: <20251026-skb-meta-rx-path-v3-0-37cceebb95d3@cloudflare.com>
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
 Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, 
 kernel-team@cloudflare.com
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
index 65735a134abb..ee94c281888a 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -502,6 +502,11 @@ void test_xdp_context_tuntap(void)
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
index 2fd95b80c3ef..3eab2bed3d57 100644
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


