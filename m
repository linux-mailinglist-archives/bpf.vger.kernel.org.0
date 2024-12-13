Return-Path: <bpf+bounces-46818-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4909F0332
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 04:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B6751698BC
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 03:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE61185949;
	Fri, 13 Dec 2024 03:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ieWDVYOo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BE817C7B6;
	Fri, 13 Dec 2024 03:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734061288; cv=none; b=tp8SJLi8r0dFCarHgG8JHjWp+JvhigtRDFVrICZ3tuuEZ80XmQ8GCVv5bfqZwFcGfLZAPbmIxsQHu9jcPz6koV4uwDDfZiIZul58hbVthOahaDGGn/mKjv7mtlKPLG+YkqEdYcBPmlcxeiY3FyzcjxHj9LXeAoyIHHzBTKCjbMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734061288; c=relaxed/simple;
	bh=zCPcFgBnPamFfN7DsvHQMVtxIk/seoeTP7ChxI3lvFc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gnkhOZyO+CtltvBcqN/pIFt6ROFFhPAGBfIQlC3Z6NwovNtqAOFPi42iuTDQMpAbYlTKa6scSFlwKeZ/csgl+PXSV75oyNBBGC3JKSHX5poVJK1fkPPQYoZ6JRVbw5ozjNpcqzRIVDdPI421JCXEAVlppxJ8wLm9MNaaKnYiW90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ieWDVYOo; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2164b662090so11412315ad.1;
        Thu, 12 Dec 2024 19:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734061285; x=1734666085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XgNdDeabAnBFetUbQgXcB335tM2WwuBxGGqB8IHkehk=;
        b=ieWDVYOokga5CSqm50wnjuhAEittFkr+xIW2Cxoq5SOT0IMER3CBPzKh+NvcZOFWuB
         VY6wSIRcJrRsZSiiOBb1JbsPDyG95ZVVZVj3ZwtbW9vSdmL117U+I1guyUYsDU9jpFOu
         ZtbEELbKq8ZwPlblBjjdEFpaW7z2rJGrDgJsMFBMVBCWyiNGLN8al0E1HM3uLpmJewbc
         JUolm4rR9ebKreEVuBuGA8I4RZrbAjecXFL97qsLUtNCRegwtTilNzvvsHGNyjX0kSm2
         NGCF54C+lti9C8A2WymBSqmcbXfAmBYcT5sIDr4j5xydYVZQ/zz4QuGJWZvONpFJr9bI
         pvzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734061285; x=1734666085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XgNdDeabAnBFetUbQgXcB335tM2WwuBxGGqB8IHkehk=;
        b=jkWrX5d/Chc3fjfJRUaoMLNKH4XjNi1zD5ZWfLER8np6f+JVu9varudWVf8qoCcnpj
         f5C/W7AUUvX7Dq6Gg89o1W8/WA9MI1hJcyFwE9MXVLGXKwRuHxNscsBbrrTJKm8BOs3f
         /aFPYxAQ559e2Uq6p8PRicMlAMqQJi/+JEDdprLJWMg7wyx1vycOggi03IOtKk5KNBzn
         a629kG6o5O8ytM+5ZQsenO0HKblEQywmQ9S4hj8Gpl55+rB7QF4nAnnllqs2N+x60/bY
         HoJQrqeHghRINIre6QmOfishhEGWhdbzTvToE49qrz4jxZI3YUNYoXypKNzY9uIz7YG2
         IoHA==
X-Gm-Message-State: AOJu0Yzdz1YP9PCxpXcv18wXpLFeVCsbDf4etK0U8yDkPreLuqsIrOnQ
	qUMcdbva8XCbSH3k5SIvba9YLEZKMtzQbvQ53u0Gc5uemiS21vYvRi+IYQ==
X-Gm-Gg: ASbGncuMunaH3+rWhNezBZR744eo7xfUiUbVTXH3lWRd4BLs5L0kY3PE2BWKBnjci5B
	N4lCSXe2S1ew76JIDEr7JXOdfA25eGDdPNYfX8RDOqcz7fsAziop4w2PhXuo6Cu9maq2vedySnR
	3KNvzo2vFhnfiFfywUaCsCYfujbI7cCsOqMUgIFEOTzVTKdofNzyNjcWLWEOJPYnYPbs80vOgK8
	ZjCVzj9dd37lIw0sNRYGUotFSt9DQHYi0vGrAYhW+GYQ/DGbvqIamBiiMrVn4yydfRw6rjzZBRu
	0l3YCdWARg==
X-Google-Smtp-Source: AGHT+IH4diViilRBfBpfw/ycMTCUrj5R8k5SWNL36hgK35hnJpw9CMwzYB1c4jnAB/A2JwNCnlzpog==
X-Received: by 2002:a17:902:fc86:b0:216:31aa:12eb with SMTP id d9443c01a7336-218929fb5camr19907855ad.31.1734061285045;
        Thu, 12 Dec 2024 19:41:25 -0800 (PST)
Received: from pop-os.hsd1.ca.comcast.net ([2601:647:6881:9060:a642:75a1:c5bb:c287])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2163725faf4sm89526435ad.196.2024.12.12.19.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 19:41:24 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	Cong Wang <cong.wang@bytedance.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Zijian Zhang <zijianzhang@bytedance.com>
Subject: [Patch bpf v3 4/4] selftests/bpf: Test bpf_skb_change_tail() in TC ingress
Date: Thu, 12 Dec 2024 19:40:57 -0800
Message-Id: <20241213034057.246437-5-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213034057.246437-1-xiyou.wangcong@gmail.com>
References: <20241213034057.246437-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cong Wang <cong.wang@bytedance.com>

Similarly to the previous test, we also need a test case to cover
positive offsets as well, TC is an excellent hook for this.

Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Tested-by: Zijian Zhang <zijianzhang@bytedance.com>
Signed-off-by: Cong Wang <cong.wang@bytedance.com>
---
 .../selftests/bpf/prog_tests/tc_change_tail.c |  62 ++++++++++
 .../selftests/bpf/progs/test_tc_change_tail.c | 106 ++++++++++++++++++
 2 files changed, 168 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tc_change_tail.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_tc_change_tail.c

diff --git a/tools/testing/selftests/bpf/prog_tests/tc_change_tail.c b/tools/testing/selftests/bpf/prog_tests/tc_change_tail.c
new file mode 100644
index 000000000000..74752233e779
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/tc_change_tail.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <error.h>
+#include <test_progs.h>
+#include <linux/pkt_cls.h>
+
+#include "test_tc_change_tail.skel.h"
+#include "socket_helpers.h"
+
+#define LO_IFINDEX 1
+
+void test_tc_change_tail(void)
+{
+	LIBBPF_OPTS(bpf_tcx_opts, tcx_opts);
+	struct test_tc_change_tail *skel = NULL;
+	struct bpf_link *link;
+	int c1, p1;
+	char buf[2];
+	int ret;
+
+	skel = test_tc_change_tail__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_tc_change_tail__open_and_load"))
+		return;
+
+	link = bpf_program__attach_tcx(skel->progs.change_tail, LO_IFINDEX,
+				     &tcx_opts);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_tcx"))
+		goto destroy;
+
+	skel->links.change_tail = link;
+	ret = create_pair(AF_INET, SOCK_DGRAM, &c1, &p1);
+	if (!ASSERT_OK(ret, "create_pair"))
+		goto destroy;
+
+	ret = xsend(p1, "Tr", 2, 0);
+	ASSERT_EQ(ret, 2, "xsend(p1)");
+	ret = recv(c1, buf, 2, 0);
+	ASSERT_EQ(ret, 2, "recv(c1)");
+	ASSERT_EQ(skel->data->change_tail_ret, 0, "change_tail_ret");
+
+	ret = xsend(p1, "G", 1, 0);
+	ASSERT_EQ(ret, 1, "xsend(p1)");
+	ret = recv(c1, buf, 2, 0);
+	ASSERT_EQ(ret, 1, "recv(c1)");
+	ASSERT_EQ(skel->data->change_tail_ret, 0, "change_tail_ret");
+
+	ret = xsend(p1, "E", 1, 0);
+	ASSERT_EQ(ret, 1, "xsend(p1)");
+	ret = recv(c1, buf, 1, 0);
+	ASSERT_EQ(ret, 1, "recv(c1)");
+	ASSERT_EQ(skel->data->change_tail_ret, -EINVAL, "change_tail_ret");
+
+	ret = xsend(p1, "Z", 1, 0);
+	ASSERT_EQ(ret, 1, "xsend(p1)");
+	ret = recv(c1, buf, 1, 0);
+	ASSERT_EQ(ret, 1, "recv(c1)");
+	ASSERT_EQ(skel->data->change_tail_ret, -EINVAL, "change_tail_ret");
+
+	close(c1);
+	close(p1);
+destroy:
+	test_tc_change_tail__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_tc_change_tail.c b/tools/testing/selftests/bpf/progs/test_tc_change_tail.c
new file mode 100644
index 000000000000..28edafe803f0
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_tc_change_tail.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <linux/if_ether.h>
+#include <linux/in.h>
+#include <linux/ip.h>
+#include <linux/udp.h>
+#include <linux/pkt_cls.h>
+
+long change_tail_ret = 1;
+
+static __always_inline struct iphdr *parse_ip_header(struct __sk_buff *skb, int *ip_proto)
+{
+	void *data_end = (void *)(long)skb->data_end;
+	void *data = (void *)(long)skb->data;
+	struct ethhdr *eth = data;
+	struct iphdr *iph;
+
+	/* Verify Ethernet header */
+	if ((void *)(data + sizeof(*eth)) > data_end)
+		return NULL;
+
+	/* Skip Ethernet header to get to IP header */
+	iph = (void *)(data + sizeof(struct ethhdr));
+
+	/* Verify IP header */
+	if ((void *)(data + sizeof(struct ethhdr) + sizeof(*iph)) > data_end)
+		return NULL;
+
+	/* Basic IP header validation */
+	if (iph->version != 4)  /* Only support IPv4 */
+		return NULL;
+
+	if (iph->ihl < 5)  /* Minimum IP header length */
+		return NULL;
+
+	*ip_proto = iph->protocol;
+	return iph;
+}
+
+static __always_inline struct udphdr *parse_udp_header(struct __sk_buff *skb, struct iphdr *iph)
+{
+	void *data_end = (void *)(long)skb->data_end;
+	void *hdr = (void *)iph;
+	struct udphdr *udp;
+
+	/* Calculate UDP header position */
+	udp = hdr + (iph->ihl * 4);
+	hdr = (void *)udp;
+
+	/* Verify UDP header bounds */
+	if ((void *)(hdr + sizeof(*udp)) > data_end)
+		return NULL;
+
+	return udp;
+}
+
+SEC("tc/ingress")
+int change_tail(struct __sk_buff *skb)
+{
+	int len = skb->len;
+	struct udphdr *udp;
+	struct iphdr *iph;
+	void *data_end;
+	char *payload;
+	int ip_proto;
+
+	bpf_skb_pull_data(skb, len);
+
+	data_end = (void *)(long)skb->data_end;
+	iph = parse_ip_header(skb, &ip_proto);
+	if (!iph)
+		return TCX_PASS;
+
+	if (ip_proto != IPPROTO_UDP)
+		return TCX_PASS;
+
+	udp = parse_udp_header(skb, iph);
+	if (!udp)
+		return TCX_PASS;
+
+	payload = (char *)udp + (sizeof(struct udphdr));
+	if (payload + 1 > (char *)data_end)
+		return TCX_PASS;
+
+	if (payload[0] == 'T') { /* Trim the packet */
+		change_tail_ret = bpf_skb_change_tail(skb, len - 1, 0);
+		if (!change_tail_ret)
+			bpf_skb_change_tail(skb, len, 0);
+		return TCX_PASS;
+	} else if (payload[0] == 'G') { /* Grow the packet */
+		change_tail_ret = bpf_skb_change_tail(skb, len + 1, 0);
+		if (!change_tail_ret)
+			bpf_skb_change_tail(skb, len, 0);
+		return TCX_PASS;
+	} else if (payload[0] == 'E') { /* Error */
+		change_tail_ret = bpf_skb_change_tail(skb, 65535, 0);
+		return TCX_PASS;
+	} else if (payload[0] == 'Z') { /* Zero */
+		change_tail_ret = bpf_skb_change_tail(skb, 0, 0);
+		return TCX_PASS;
+	}
+	return TCX_DROP;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.34.1


