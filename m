Return-Path: <bpf+bounces-56395-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F80A96C7A
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 15:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0385C3AF3A8
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 13:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC4628469B;
	Tue, 22 Apr 2025 13:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b="M6mvyPDO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uRo843GA"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED586283CA4;
	Tue, 22 Apr 2025 13:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745328242; cv=none; b=LC+JPZFBsD86dfzzFlLcm2jaH3lYvmchpEz/u7GvNit8GRNa2gFaAqlYaD5DCFomzoSA+/f+QeTAebRqmTHjLWQ9O4p9w6BHRvoytKeKTGmKO+PIXuEC3BXxmAl3wgDKFFbIKxkxYzNAcECZTIKHRCwuBA+LL4vKkoCqDqaUhW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745328242; c=relaxed/simple;
	bh=DF0WJCNKYiWA0yeDMisao9g+A+1vkqXsDhmrw/J4O9w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EX143VVPrJYzTC29m3Grbe7bXpR6sXe6lk3mvYY1VRUAP34bhLnjPQag/CI/9PAeCJbSbO21B1u3JW6sjSWbgzzlkkVVXezlDJxfTyyTNksDlIx6wVEpMxjFNP3hK4Rtz0QQaFCNpyFvkn8aFvlthFr1ZqwkI7022Q1/G7K/4+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com; spf=pass smtp.mailfrom=arthurfabre.com; dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b=M6mvyPDO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uRo843GA; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arthurfabre.com
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C22F725401F7;
	Tue, 22 Apr 2025 09:23:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 22 Apr 2025 09:24:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arthurfabre.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1745328239; x=1745414639; bh=FaBr4P0Vwm0ushiISHWv8AdkfyybPPt6
	ymVYt7MWMzM=; b=M6mvyPDOoX64zymsvNXLHDzdU09QD6KkcBpdXFBzOHaPBLCW
	9Aw/1OsL6q+jwToQYeoXZiKw7NA2NNaINxltwPmNg/EK9PoMeImXgvoxA2Zvit/7
	XLJkYHOeCW+4aRqYDHuqz1yzmn2/lv25an+4fgt/Gg+opOgVDlDkkYlmgEvGrBcM
	NwKvtivIM6NObVLbpAcFm3oCkDQ1TmhXP9wpoXz+RSfS/HCAVEBlYczvj3xIJk7B
	4N5cZlGI3+okGz/9VlHpCjUqGevXbZ8T32cCZo6bLkbNPJSdKll2K1NDLo7Tcrff
	So7yPEaJoczyX/moup+zzPkVeuBoz0o5hclUlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1745328239; x=
	1745414639; bh=FaBr4P0Vwm0ushiISHWv8AdkfyybPPt6ymVYt7MWMzM=; b=u
	Ro843GAR0WkLjvsaUnfKnkU+XequVJyG++ySw0FNFfV9URLbae6LBj9T8Qn69iKS
	HllkmFE+Ngm+Tqkl37IQkvkTVtJAlnJLoZlKUGk0K2TOSVFyUMOFrpTujn+zkcwR
	oe1DmlyQkT3DQJrVL05rIgta37Cnrkmgtjr6MTrVAdybRtzgvxLjFuOGl558s49k
	r3OrvdjQolqY00HTQNLicFKrY9n8CFYBdD8M0cle7LDmRXwpECxXC3MeeILj51To
	U2eQExxLnS45jLgfYVO+AYKEhUzEeMTrjtJPtkL6v78xV6UCw4N/tDA2+BX0LSd/
	nVUtV2WQpzfIUZECd2dDQ==
X-ME-Sender: <xms:b5gHaOte1xPWwILDFAEZWHI82lf1l6WonFxSuB0bICdYBUf8qq1RXw>
    <xme:b5gHaDeolITdqaT1XEojaSp7kHIOri3IW16LhZlLUUz-O5cII6QJFWrPOlGjH0VcN
    DIAnCIeLQWXQ4Kw3r8>
X-ME-Received: <xmr:b5gHaJxhgb5M_47zcoaSLqj9IYge5rxa1Ns6IS9dJ2wRRKEEZuALD2f17xEb70hUh4WWBt2RmsUQaNOR6fQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeefkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheptehrthhhuhhrucfhrggs
    rhgvuceorghrthhhuhhrsegrrhhthhhurhhfrggsrhgvrdgtohhmqeenucggtffrrghtth
    gvrhhnpeejkeehffejvdefhedtleetgfeivdetgfefffetkeelieefvdefhfeuveevhffh
    ueenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hthhhurhesrghrthhhuhhrfhgrsghrvgdrtghomhdpnhgspghrtghpthhtohepuddvpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohephigrnhestghlohhuughflhgrrhgvrdgtohhmpdhrtghpthhtohepnhgv
    thguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgrfihksehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhm
    pdhrtghpthhtohepthhhohhilhgrnhgusehrvgguhhgrthdrtghomhdprhgtphhtthhope
    hjsghrrghnuggvsghurhhgsegtlhhouhgufhhlrghrvgdrtghomhdprhgtphhtthhopegs
    phhfsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghstheskhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:b5gHaJMjfOMk91CmJsQpORnzXVEDUa4NJDcpZJF4JKn_wdF8kY5Kww>
    <xmx:b5gHaO_7mOWwIkuhO9hEK2F92PX-sLSW-E-Vumyk-y_IpHNPUZNvQQ>
    <xmx:b5gHaBWbtjdG6peO_pQhScgllQuJ4H6O0T8jZp9CGygOv66J0o6gvA>
    <xmx:b5gHaHd3DmhCjZrFDL37Uie10Vn0HqW1GCYsy8MX0uRJmxGAk2Etxg>
    <xmx:b5gHaHSxwW6Jhol_mEArfQkdpNq0TeQWA-9RjCMcewh4ixFdmPH0Tq2I>
Feedback-ID: i25f1493c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Apr 2025 09:23:57 -0400 (EDT)
From: Arthur Fabre <arthur@arthurfabre.com>
Date: Tue, 22 Apr 2025 15:23:33 +0200
Subject: [PATCH RFC bpf-next v2 04/17] trait: XDP selftest
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250422-afabre-traits-010-rfc2-v2-4-92bcc6b146c9@arthurfabre.com>
References: <20250422-afabre-traits-010-rfc2-v2-0-92bcc6b146c9@arthurfabre.com>
In-Reply-To: <20250422-afabre-traits-010-rfc2-v2-0-92bcc6b146c9@arthurfabre.com>
To: netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: jakub@cloudflare.com, hawk@kernel.org, yan@cloudflare.com, 
 jbrandeburg@cloudflare.com, thoiland@redhat.com, lbiancon@redhat.com, 
 ast@kernel.org, kuba@kernel.org, edumazet@google.com, 
 Arthur Fabre <arthur@arthurfabre.com>
X-Mailer: b4 0.14.2

Check traits work for all sizes, and that only xdp_adjust_meta() or
xdp_trait_set() can be used at the same time.

Signed-off-by: Arthur Fabre <arthur@arthurfabre.com>
---
 .../testing/selftests/bpf/prog_tests/xdp_traits.c  |  33 ++++
 .../testing/selftests/bpf/progs/test_xdp_traits.c  | 206 +++++++++++++++++++++
 2 files changed, 239 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_traits.c b/tools/testing/selftests/bpf/prog_tests/xdp_traits.c
new file mode 100644
index 0000000000000000000000000000000000000000..3e3e1b2fa73eb2ff94884fba3536b25f1b089fdd
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_traits.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <network_helpers.h>
+
+void test_xdp_traits(void)
+{
+	const char *file = "./test_xdp_traits.bpf.o";
+	struct bpf_object *obj;
+	struct bpf_program *prog;
+	int err, prog_fd;
+	struct bpf_test_run_opts topts;
+
+	err = bpf_prog_test_load(file, BPF_PROG_TYPE_XDP, &obj, &prog_fd);
+	if (!ASSERT_OK(err, "test_xdp_traits"))
+		return;
+
+	bpf_object__for_each_program(prog, obj) {
+		if (test__start_subtest(bpf_program__name(prog))) {
+			LIBBPF_OPTS_RESET(topts,
+				.data_in = &pkt_v4,
+				.data_size_in = sizeof(pkt_v4),
+				.repeat = 1,
+			);
+
+			prog_fd = bpf_program__fd(prog);
+			err = bpf_prog_test_run_opts(prog_fd, &topts);
+			ASSERT_OK(err, "prog_run");
+			ASSERT_EQ(topts.retval, XDP_PASS, "retval");
+		}
+	}
+
+	bpf_object__close(obj);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_traits.c b/tools/testing/selftests/bpf/progs/test_xdp_traits.c
new file mode 100644
index 0000000000000000000000000000000000000000..e020acae6b56cb55f455075341159993c20f4c9e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_xdp_traits.c
@@ -0,0 +1,206 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <errno.h>
+
+/* TODO - can we plumb better constants through here?
+ * 40: sizeof(struct xdp_frame)
+ * 16: sizeof(struct __trait_hdr)
+ */
+#define MAX_SPACE (XDP_PACKET_HEADROOM - 40 - 16)
+
+/* For xdp_adjust_meta() */
+#ifndef ENOTSUPP
+#define ENOTSUPP 524
+#endif
+
+extern int bpf_xdp_trait_set(const struct xdp_md *xdp, __u64 key,
+			     const void *val, __u64 val__sz,
+			     __u64 flags) __ksym;
+extern int bpf_xdp_trait_get(const struct xdp_md *xdp, __u64 key, void *val,
+			     __u64 val__sz) __ksym;
+extern int bpf_xdp_trait_del(const struct xdp_md *xdp, __u64 key) __ksym;
+extern int bpf_xdp_trait_is_set(const struct xdp_md *xdp, __u64 key) __ksym;
+
+#define ASSERT_CALL(WANT, CALL) do {							\
+	int _ret = CALL;								\
+	if (_ret != WANT) {								\
+		bpf_printk("%d: %s ret %d want %d", __LINE__, #CALL, _ret, WANT);	\
+		return XDP_DROP;							\
+	}										\
+} while (0)
+
+#define ASSERT_VAL(WANT, GOT, PTRSIZE) do {								\
+	if (__builtin_memcmp(WANT, GOT, PTRSIZE)) {							\
+		switch (PTRSIZE) {									\
+		case 0:											\
+			return XDP_DROP;								\
+		case 4:											\
+			bpf_printk("%d: got %d want %d", __LINE__, *(__u32 *)GOT, *(__u32 *)WANT);	\
+			return XDP_DROP;								\
+		case 8:											\
+			bpf_printk("%d: got %d want %d", __LINE__, *(__u64 *)GOT, *(__u64 *)WANT);	\
+			return XDP_DROP;								\
+		}											\
+	}												\
+} while (0)
+
+#define FILL(PTR, PTRSIZE, VAL) do {			\
+	int _i;						\
+	for (_i = 0; _i < PTRSIZE; _i++)		\
+		*(((__u8 *)(PTR))+_i) = (__u8)VAL;	\
+} while (0)
+
+static __always_inline int test(struct xdp_md *xdp, void *val, void *got, int valsize)
+{
+	int i, numkeys;
+
+	numkeys = 64;
+	if (valsize * numkeys > MAX_SPACE)
+		numkeys = MAX_SPACE / valsize;
+
+	/* No keys to start */
+	for (i = 0; i < numkeys; i++) {
+		ASSERT_CALL(-ENOENT, bpf_xdp_trait_get(xdp, i, val, valsize));
+		ASSERT_CALL(-ENOENT, bpf_xdp_trait_del(xdp, i));
+		ASSERT_CALL(0, bpf_xdp_trait_is_set(xdp, i));
+	}
+
+	/* Set all keys */
+	for (i = 0; i < numkeys; i++) {
+		FILL(val, valsize, i);
+		ASSERT_CALL(0, bpf_xdp_trait_set(xdp, i, val, valsize, 0));
+
+		ASSERT_CALL(valsize, bpf_xdp_trait_get(xdp, i, got, valsize));
+		ASSERT_VAL(val, got, valsize);
+		ASSERT_CALL(1, bpf_xdp_trait_is_set(xdp, i));
+	}
+
+	/* Get all keys back out */
+	for (i = 0; i < numkeys; i++) {
+		FILL(val, valsize, i);
+
+		ASSERT_CALL(valsize, bpf_xdp_trait_get(xdp, i, got, valsize));
+		ASSERT_VAL(val, got, valsize);
+		ASSERT_CALL(1, bpf_xdp_trait_is_set(xdp, i));
+	}
+
+	/* Overwrite all keys */
+	for (i = 0; i < numkeys; i++) {
+		FILL(val, valsize, i+128);
+		ASSERT_CALL(0, bpf_xdp_trait_set(xdp, i, val, valsize, 0));
+	}
+
+	/* Delete all even keys */
+	for (i = 0; i < numkeys; i++) {
+		if (!(i & 1))
+			ASSERT_CALL(0, bpf_xdp_trait_del(xdp, i));
+	}
+
+	/* Check remaining keys */
+	for (i = 0; i < numkeys; i++) {
+		if (!(i & 1)) {
+			ASSERT_CALL(-ENOENT, bpf_xdp_trait_get(xdp, i, val, valsize));
+			ASSERT_CALL(0, bpf_xdp_trait_is_set(xdp, i));
+		} else {
+			FILL(val, valsize, i+128);
+
+			ASSERT_CALL(valsize, bpf_xdp_trait_get(xdp, i, got, valsize));
+			ASSERT_VAL(val, got, valsize);
+		}
+	}
+
+	return XDP_PASS;
+}
+
+SEC("xdp")
+int xdp_traits_0(struct xdp_md *xdp)
+{
+	return test(xdp, NULL, NULL, 0);
+}
+
+SEC("xdp")
+int xdp_traits_4(struct xdp_md *xdp)
+{
+	__u32 a, b;
+
+	return test(xdp, &a, &b, sizeof(a));
+}
+
+SEC("xdp")
+int xdp_traits_8(struct xdp_md *xdp)
+{
+	__u64 a, b;
+
+	return test(xdp, &a, &b, sizeof(a));
+}
+
+SEC("xdp")
+int xdp_traits_invalid_key(struct xdp_md *xdp)
+{
+	ASSERT_CALL(-EINVAL, bpf_xdp_trait_get(xdp, 65, NULL, 0));
+	ASSERT_CALL(-EINVAL, bpf_xdp_trait_set(xdp, 65, NULL, 0, 0));
+	ASSERT_CALL(-EINVAL, bpf_xdp_trait_del(xdp, 65));
+	ASSERT_CALL(-EINVAL, bpf_xdp_trait_is_set(xdp, 65));
+	return XDP_PASS;
+}
+
+SEC("xdp")
+int xdp_traits_invalid_len(struct xdp_md *xdp)
+{
+	__u8 v;
+
+	ASSERT_CALL(-EINVAL, bpf_xdp_trait_set(xdp, 0, &v, sizeof(v), 0));
+	return XDP_PASS;
+}
+
+SEC("xdp")
+int xdp_traits_len_too_small(struct xdp_md *xdp)
+{
+	__u8 v1;
+	__u32 v4;
+
+	ASSERT_CALL(0, bpf_xdp_trait_set(xdp, 0, &v4, sizeof(v4), 0));
+	ASSERT_CALL(-ENOSPC, bpf_xdp_trait_get(xdp, 0, &v1, sizeof(v1)));
+	return XDP_PASS;
+}
+
+SEC("xdp")
+int xdp_traits_different_len(struct xdp_md *xdp)
+{
+	__u32 v;
+
+	ASSERT_CALL(0, bpf_xdp_trait_set(xdp, 0, &v, sizeof(v), 0));
+	ASSERT_CALL(-EBUSY, bpf_xdp_trait_set(xdp, 0, NULL, 0, 0));
+	return XDP_PASS;
+}
+
+SEC("xdp")
+int xdp_traits_no_space(struct xdp_md *xdp)
+{
+	int i;
+	__u64 v;
+
+	for (i = 0; i < MAX_SPACE / 8; i++)
+		ASSERT_CALL(0, bpf_xdp_trait_set(xdp, i, &v, sizeof(v), 0));
+	ASSERT_CALL(-ENOSPC, bpf_xdp_trait_set(xdp, i+1, &v, sizeof(v), 0));
+	return XDP_PASS;
+}
+
+SEC("xdp")
+int xdp_meta_then_traits(struct xdp_md *xdp)
+{
+	ASSERT_CALL(0, bpf_xdp_adjust_meta(xdp, -8));
+	ASSERT_CALL(-EOPNOTSUPP, bpf_xdp_trait_set(xdp, 0, NULL, 0, 0));
+	return XDP_PASS;
+}
+
+SEC("xdp")
+int xdp_traits_then_meta(struct xdp_md *xdp)
+{
+	ASSERT_CALL(0, bpf_xdp_trait_set(xdp, 0, NULL, 0, 0));
+	ASSERT_CALL(-ENOTSUPP, bpf_xdp_adjust_meta(xdp, -8));
+	return XDP_PASS;
+}
+
+char _license[] SEC("license") = "GPL";

-- 
2.43.0


