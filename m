Return-Path: <bpf+bounces-53323-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DD5A50213
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 15:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC9B43AF1AF
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 14:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A5424EF65;
	Wed,  5 Mar 2025 14:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b="mh3YLQou";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jwrandt0"
X-Original-To: bpf@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E561E24E4AD;
	Wed,  5 Mar 2025 14:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741185205; cv=none; b=V/lhYWbooTnY2u41CoTlrv8QUaINLF1ZmPtxl2Smsnu1yGWf3HR4LqDaWKWMOtT4WwvEF6bP0DejtIA10dgK2u9uNbjg6asRgOMZxXdaBaAKFLBLeNaAo9HyKHc+ynLaCw5KCS1XF9yCRGlTsRTVzzvFCEpnd0ayM25YFC3Y9oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741185205; c=relaxed/simple;
	bh=dwv28XE92+KFkMambh3tbhhkQP8E/Fx8xkgHETK/91k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hHnAEO1uJfP4/ae4ItHCR1PzzF0diLVYdjLKn5uM/WhBruQriHCr+9SIPlLK1o/XutTWFtM3dLJe/4gK+BPcWV0KBQHFRLQuKBaYRUeEjLBUqCPW15PbfQUSA7+1iQR4Is0KmvGbEy1b4FDVa0XRjZOhK02ff6+sbkJDxaj8Se4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com; spf=pass smtp.mailfrom=arthurfabre.com; dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b=mh3YLQou; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jwrandt0; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arthurfabre.com
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id F21CA13826E6;
	Wed,  5 Mar 2025 09:33:22 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 05 Mar 2025 09:33:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arthurfabre.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1741185202; x=1741271602; bh=dAehco09VFBKaKPWvptrONpyGISZqDUV
	oIUUtWKA6As=; b=mh3YLQousOW4VoHH1hhxC3tEQNUkSugDzPgLvsiyTGS9eYj3
	tzQHTCMacN5GjqXX9gFIMjaDLWbBHOXiZZfMWNBwn+CiGMgBY/ijYsJLp7ZBIAFN
	Mi1OHnGJzzHMZEYSb6+aVS7mKMMqaUX+2nEfRkVzr16rPL44fMLTGxDZ3IvuWm2b
	i80VjEjkyv/hT4UFZeCLqDI004dqdUGNszfaG1pTf4bNCszTy6Uml3VWQvpZhyep
	8AMbB62zKHSWpgP32CSVjHWc/b6OvX8j63uP8M5RKcN1Ej3/2bknMqb5sGo+MZZQ
	fYNk/IqAMy7yhlWHti/n+kSeSAaxxM28OUBl8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741185202; x=
	1741271602; bh=dAehco09VFBKaKPWvptrONpyGISZqDUVoIUUtWKA6As=; b=j
	wrandt0A1YR84+H28Rvvs6CWeIycZsMHsjWD2OI77x/FrcyATKsBjLz3Y+1aH5Hq
	pOU4AoR1fL6zL5FH/AmNKOaVlxq97VaP+aGaWXzpdFZhLHkOQBV8n2GYcMDwYl+d
	QoMpBm835e7uBic24UBLR9pBsC7EjIe0AzyH/vieqNUFxXa9xfzH+e9MIhUOeNC1
	ePndSE1QdVinNqX1RjCeEb129nPjIH8eMTJd/NIyymerWXT+6ZlR2UjmM34qB++F
	Hez6ng4TsHvOpBvWYbAxvjSjoRHgWmrZbViIM/MsqyUGdy5ddtrWKlzzHyjxySgu
	R3IrvPNSUB7VdErotTHrg==
X-ME-Sender: <xms:smDIZ8LJaoZFrNFivqJAW-JF1Ky_cDcVn_fCVI0iMHYiLeQArWMbtQ>
    <xme:smDIZ8JPiq8JYjauJHPQvYvTkH-BhSHM1rv3r8n3_1Unxf1ts25epWhBf3Ucg8kKL
    JmzVDQbcrtKufC50f0>
X-ME-Received: <xmr:smDIZ8uZxLuTciMFBCYf21g-_VSIP18Q6UU1pI6nOrLWmuWeovBHY7WdqAVkaMgzlvYYbpKNngpVNA1MYMo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdehtdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpegrrhhthhhurhesrghrthhhuhhrfhgrsghrvgdrtghomhenucggtf
    frrghtthgvrhhnpeffueehtddtkeetgfelteejledvjeekgeduleffjeetfeekveeggffh
    fefhvdegffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrrhhthhhurhesrghrthhhuhhrfhgrsghrvgdrtghomhdpnhgspghrtghpthhtohep
    ledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhhohhilhgrnhgusehrvgguhh
    grthdrtghomhdprhgtphhtthhopehlsghirghntghonhesrhgvughhrghtrdgtohhmpdhr
    tghpthhtohephhgrfihksehkvghrnhgvlhdrohhrghdprhgtphhtthhopegsphhfsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghfrggsrhgvsegtlhhouhgufhhl
    rghrvgdrtghomhdprhgtphhtthhopehjrghkuhgssegtlhhouhgufhhlrghrvgdrtghomh
    dprhgtphhtthhopeihrghnsegtlhhouhgufhhlrghrvgdrtghomhdprhgtphhtthhopehn
    vghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjsghrrghnug
    gvsghurhhgsegtlhhouhgufhhlrghrvgdrtghomh
X-ME-Proxy: <xmx:smDIZ5ZJ6ap0T8z-hSVRnOAu3EG5bQJqiaamRlih9SnS0hW_4JEn4A>
    <xmx:smDIZzbd_INVixRG3C1OyPwDYxYaR_4TVkloZ6sqH0AA6oZ6rpnOcw>
    <xmx:smDIZ1BQF6SDj4iSWf5S1xxnmrbylO_H-21EPy7_AeuuV_4VlKkfMQ>
    <xmx:smDIZ5ajcqzxKUeRrpaJqb0HrV33O1B2Rj3qy9oYwHVt-qSE_XdKtw>
    <xmx:smDIZ9n72-wLWaEVzmRGDl2eAWVuNb9ps_B8DpRP4yEVmK11uEBWb6jL>
Feedback-ID: i25f1493c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Mar 2025 09:33:21 -0500 (EST)
From: arthur@arthurfabre.com
Date: Wed, 05 Mar 2025 15:32:00 +0100
Subject: [PATCH RFC bpf-next 03/20] trait: basic XDP selftest
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-afabre-traits-010-rfc2-v1-3-d0ecfb869797@cloudflare.com>
References: <20250305-afabre-traits-010-rfc2-v1-0-d0ecfb869797@cloudflare.com>
In-Reply-To: <20250305-afabre-traits-010-rfc2-v1-0-d0ecfb869797@cloudflare.com>
To: netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: jakub@cloudflare.com, hawk@kernel.org, yan@cloudflare.com, 
 jbrandeburg@cloudflare.com, thoiland@redhat.com, lbiancon@redhat.com, 
 Arthur Fabre <afabre@cloudflare.com>
X-Mailer: b4 0.14.2

From: Arthur Fabre <afabre@cloudflare.com>

Doesn't test interop with the "data_meta" area yet, or error cases.

Signed-off-by: Arthur Fabre <afabre@cloudflare.com>
---
 .../testing/selftests/bpf/prog_tests/xdp_traits.c  | 35 ++++++++
 .../testing/selftests/bpf/progs/test_xdp_traits.c  | 94 ++++++++++++++++++++++
 2 files changed, 129 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_traits.c b/tools/testing/selftests/bpf/prog_tests/xdp_traits.c
new file mode 100644
index 0000000000000000000000000000000000000000..4175b28d45e91e82435e646e5edd783980d5fe70
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_traits.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <network_helpers.h>
+
+static void _test_xdp_traits(void)
+{
+	const char *file = "./test_xdp_traits.bpf.o";
+	struct bpf_object *obj;
+	int err, prog_fd;
+	char buf[128];
+
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in = &pkt_v4,
+		.data_size_in = sizeof(pkt_v4),
+		.data_out = buf,
+		.data_size_out = sizeof(buf),
+		.repeat = 1,
+	);
+
+	err = bpf_prog_test_load(file, BPF_PROG_TYPE_XDP, &obj, &prog_fd);
+	if (!ASSERT_OK(err, "test_xdp_traits"))
+		return;
+
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "prog_run");
+	ASSERT_EQ(topts.retval, XDP_PASS, "retval");
+
+	bpf_object__close(obj);
+}
+
+void test_xdp_traits(void)
+{
+	if (test__start_subtest("xdp_traits"))
+		_test_xdp_traits();
+}
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_traits.c b/tools/testing/selftests/bpf/progs/test_xdp_traits.c
new file mode 100644
index 0000000000000000000000000000000000000000..79e0b0dedb5c05792579861975e8caf290f5f42b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_xdp_traits.c
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <errno.h>
+
+extern int bpf_xdp_trait_set(const struct xdp_md *xdp, __u64 key,
+			     const void *val, __u64 val__sz,
+			     __u64 flags) __ksym;
+extern int bpf_xdp_trait_get(const struct xdp_md *xdp, __u64 key, void *val,
+			     __u64 val__sz) __ksym;
+extern int bpf_xdp_trait_del(const struct xdp_md *xdp, __u64 key) __ksym;
+
+SEC("xdp")
+int _xdp_traits(struct xdp_md *xdp)
+{
+	int ret;
+	__u16 val, got, want;
+
+	// No keys to start.
+	for (int i = 0; i < 64; i++) {
+		ret = bpf_xdp_trait_get(xdp, i, &val, sizeof(val));
+		if (ret != -ENOENT) {
+			bpf_printk("get(%d) ret %d", i, ret);
+			return XDP_DROP;
+		}
+	}
+
+	// Set 64 2 byte KVs.
+	for (int i = 0; i < 64; i++) {
+		val = i << 8 | i;
+		ret = bpf_xdp_trait_set(xdp, i, &val, sizeof(val), 0);
+		if (ret < 0) {
+			bpf_printk("set(%d) ret %d\n", i, ret);
+			return XDP_DROP;
+		}
+		bpf_printk("set(%d, 0x%04x)\n", i, val);
+	}
+
+	// Check we can get the 64 2 byte KVs back out.
+	for (int i = 0; i < 64; i++) {
+		ret = bpf_xdp_trait_get(xdp, i, &got, sizeof(got));
+		if (ret != 2) {
+			bpf_printk("get(%d) ret %d", i, ret);
+			return XDP_DROP;
+		}
+		want = (i << 8) | i;
+		if (got != want) {
+			bpf_printk("get(%d) got 0x%04x want 0x%04x\n", i, got,
+				   want);
+			return XDP_DROP;
+		}
+		bpf_printk("get(%d) 0x%04x\n", i, got);
+	}
+
+	// Overwrite all 64 2 byte KVs.
+	for (int i = 0; i < 64; i++) {
+		val = i << 9 | i << 1;
+		ret = bpf_xdp_trait_set(xdp, i, &val, sizeof(val), 0);
+		if (ret < 0) {
+			bpf_printk("set(%d) ret %d\n", i, ret);
+			return XDP_DROP;
+		}
+		bpf_printk("set(%d, 0x%04x)\n", i, val);
+	}
+
+	// Delete all the even KVs.
+	for (int i = 0; i < 64; i += 2) {
+		ret = bpf_xdp_trait_del(xdp, i);
+		if (ret < 0) {
+			bpf_printk("del(%d) ret %d\n", i, ret);
+			return XDP_DROP;
+		}
+	}
+
+	// Read out all the odd KVs again.
+	for (int i = 1; i < 63; i += 2) {
+		ret = bpf_xdp_trait_get(xdp, i, &got, sizeof(got));
+		if (ret != 2) {
+			bpf_printk("get(%d) ret %d", i, ret);
+			return XDP_DROP;
+		}
+		want = (i << 9) | i << 1;
+		if (got != want) {
+			bpf_printk("get(%d) got 0x%04x want 0x%04x\n", i, got,
+				   want);
+			return XDP_DROP;
+		}
+		bpf_printk("get(%d) 0x%04x\n", i, got);
+	}
+
+	return XDP_PASS;
+}
+
+char _license[] SEC("license") = "GPL";

-- 
2.43.0


