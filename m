Return-Path: <bpf+bounces-53340-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D56A5024E
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 15:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1360B189A967
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 14:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F21B252914;
	Wed,  5 Mar 2025 14:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b="I2MnrdAO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bo0nl3QL"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2382C252903;
	Wed,  5 Mar 2025 14:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741185234; cv=none; b=k/kwlzZAXODwRYwQGvcx9lyipvzcj3nVVjH5c/LBu+oa8V9aiYfSVEg9gIcHvyM6vhuPrpcvDa9bqk0TkYDgdjpTFAnUJ7Tf3EZeZV4o4b2ysNFIZO4NFHxCr35XuDmGXAcvU1hdZ+ceTyH9qU75Gf79ePvpNdE0MO82SAIxuc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741185234; c=relaxed/simple;
	bh=UyzCQ+1TEf63QXbFVHZfqRUApOl37dvhkdRu2DAyPbM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dQ4iRbG/dtliojw2cVcMjKbpVRgiBNkxWCh0bWmD54atAcmiWCzh04ywXcyj6xd0hcNTZr7Llg5OR66sxSsviM+miV6ttlTLMr7R1kGSwuW8E/eQoRt6vmM9DcjV8n6Z0L0kzH1ciOcIAO1NcLltO4/etWIQe/N4PANoqLh3L24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com; spf=pass smtp.mailfrom=arthurfabre.com; dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b=I2MnrdAO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bo0nl3QL; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arthurfabre.com
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3E76B1140252;
	Wed,  5 Mar 2025 09:33:52 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-13.internal (MEProxy); Wed, 05 Mar 2025 09:33:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arthurfabre.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1741185232; x=1741271632; bh=k1YGAnSYA9FoYxracqWXHS34OxsoexW0
	9UyZ0uIaTJ8=; b=I2MnrdAOZkZaNH/iUnOV4F55V1G2OXXm5GUBNHQ6mX4rk3Ye
	VynOd2PPBNDRnEQfE3vtWwwTuKaDj/qs4U56SZDnZ8ipZO4TM9ECDlIp1I2I5FB9
	2zOoXLIrtN4feG3VVcjOQJH9jFIzLuc2abLILsLcfmwN30atvHjFPTGyFgXGolWO
	+slZ9/vqu0ZxNMIBGsbPaU1okhfvVQGEkcwF6p6J/YpOdoVKwEP50XwI4IJHjtxp
	Ft26UZrUmkUqmZBlHwtZAV9LbakPKe/s92VaZRERHbeKVHntDTKB4ONflbq36Zh3
	doTJufMdV3qVWdmWdJcDnadQoiW87llH+T4nag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741185232; x=
	1741271632; bh=k1YGAnSYA9FoYxracqWXHS34OxsoexW09UyZ0uIaTJ8=; b=B
	o0nl3QLVpVkTz5M4HklP6ZI0WywbMyLM6mJP7T8DorZ0cUJP6YTOUwrf+wTfVPpV
	RyY6/Y44vmwk5yO4KPu+3W+AVVsxFjPyYDYN0Lss2iIwHj6vjiY+DIaCRxsgEoRH
	BqouuuvCOvDlQtXgWLQEYCNKgOUFTm77S3jTvf3NhfCAAM4iIxAnlt5n1eVVeP6/
	LIMRfDNigzGPiUAW1ve6jA8XizruXOH5myHjEZHT07BkMtvfUc65eZ0FuCVEqhwf
	QBrZkbSIo7zU9do/y1KYgrCaiMTIDzCvPjGfUnQ8wSRD9WCmZS8Qb/+0npKA23oE
	y4mLu6W4RjWzEQBgjOmCA==
X-ME-Sender: <xms:0GDIZ8IleFasAdU7bJETo2lkazQb1AnImwopgD3maMEYDBIcQ_nF3g>
    <xme:0GDIZ8J74hWrAAw1UUgHMn6Hw_0jRimIX1HCce4MTKr2C2j3mjGOnChEQnjCcpYil
    Ym_YPK7xAa_YwWQVWA>
X-ME-Received: <xmr:0GDIZ8tV1xaeGOsKJE5PAN3h-3fkWmUNcBo_vtrFq9smXkcOK_T1EO1x2exHgb7_vD0GaAUzJfc7saMUzuw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdehtdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpegrrhhthhhurhesrghrthhhuhhrfhgrsghrvgdrtghomhenucggtf
    frrghtthgvrhhnpeffueehtddtkeetgfelteejledvjeekgeduleffjeetfeekveeggffh
    fefhvdegffenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrrhhthhhurhesrghrthhhuhhrfhgrsghrvgdrtghomhdpnhgspghrtghpthhtohep
    ledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhhohhilhgrnhgusehrvgguhh
    grthdrtghomhdprhgtphhtthhopehlsghirghntghonhesrhgvughhrghtrdgtohhmpdhr
    tghpthhtohephhgrfihksehkvghrnhgvlhdrohhrghdprhgtphhtthhopegsphhfsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghfrggsrhgvsegtlhhouhgufhhl
    rghrvgdrtghomhdprhgtphhtthhopehjrghkuhgssegtlhhouhgufhhlrghrvgdrtghomh
    dprhgtphhtthhopeihrghnsegtlhhouhgufhhlrghrvgdrtghomhdprhgtphhtthhopehn
    vghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjsghrrghnug
    gvsghurhhgsegtlhhouhgufhhlrghrvgdrtghomh
X-ME-Proxy: <xmx:0GDIZ5ZVy5bhhtYC5WWIjN1m9SyGyMVwVyu0BGzd7RMDzCu4WyHt_A>
    <xmx:0GDIZzb5AxrZFEphmDTVAMcwxtVfTrY_vAoDi38K2QpwEmM0_2abWQ>
    <xmx:0GDIZ1A8Rrj4taycqaJpL1qj9wXFRJW83QL4Zb7_IDUptrz6Q49m2Q>
    <xmx:0GDIZ5YfdfyUW14e_ZUX0lvJKy6M5Mnf1uG302JUgp6axfXclDmqpw>
    <xmx:0GDIZ9kHWQXv2Nea2yeymym1OmJQkOEonxFqB-hxgn31ImpzAi7tsJ92>
Feedback-ID: i25f1493c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Mar 2025 09:33:50 -0500 (EST)
From: arthur@arthurfabre.com
Date: Wed, 05 Mar 2025 15:32:17 +0100
Subject: [PATCH RFC bpf-next 20/20] trait: register traits in benchmarks
 and tests
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-afabre-traits-010-rfc2-v1-20-d0ecfb869797@cloudflare.com>
References: <20250305-afabre-traits-010-rfc2-v1-0-d0ecfb869797@cloudflare.com>
In-Reply-To: <20250305-afabre-traits-010-rfc2-v1-0-d0ecfb869797@cloudflare.com>
To: netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: jakub@cloudflare.com, hawk@kernel.org, yan@cloudflare.com, 
 jbrandeburg@cloudflare.com, thoiland@redhat.com, lbiancon@redhat.com, 
 Arthur Fabre <afabre@cloudflare.com>
X-Mailer: b4 0.14.2

From: Arthur Fabre <afabre@cloudflare.com>

Otherwise the verifier rejects the programs now.

Signed-off-by: Arthur Fabre <afabre@cloudflare.com>
---
 tools/testing/selftests/bpf/bench.c                |  3 ++
 tools/testing/selftests/bpf/bench.h                |  1 +
 .../selftests/bpf/benchs/bench_xdp_traits.c        | 33 +++++++++++++++++++++-
 .../testing/selftests/bpf/prog_tests/xdp_traits.c  | 18 +++++++++++-
 4 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index 4678b928fc6ad2f0a870a25d9b10c75a1f6d77ba..0961cb71ddf1d682ca61e512e9f4b2df3606747c 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -752,5 +752,8 @@ int main(int argc, char **argv)
 		bench->report_final(state.results + env.warmup_sec,
 				    state.res_cnt - env.warmup_sec);
 
+	if (bench->cleanup)
+		bench->cleanup();
+
 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/bench.h b/tools/testing/selftests/bpf/bench.h
index 005c401b3e2275030d1d489cd77423cb1fb652ad..6a94af31df17e7cc35bb1432c4b205eb96b631f2 100644
--- a/tools/testing/selftests/bpf/bench.h
+++ b/tools/testing/selftests/bpf/bench.h
@@ -58,6 +58,7 @@ struct bench {
 	void (*measure)(struct bench_res* res);
 	void (*report_progress)(int iter, struct bench_res* res, long delta_ns);
 	void (*report_final)(struct bench_res res[], int res_cnt);
+	void (*cleanup)(void);
 };
 
 struct counter {
diff --git a/tools/testing/selftests/bpf/benchs/bench_xdp_traits.c b/tools/testing/selftests/bpf/benchs/bench_xdp_traits.c
index 0fbcd49edd825f53e6957319d3f05efc218dfb02..b6fa2d8f2504dd9c35f8fb9dc1f1099b55a55ac6 100644
--- a/tools/testing/selftests/bpf/benchs/bench_xdp_traits.c
+++ b/tools/testing/selftests/bpf/benchs/bench_xdp_traits.c
@@ -57,7 +57,18 @@ static void trait_validate(void)
 
 static void trait_setup(void)
 {
-	int err;
+	int err, i, key;
+	union bpf_attr attr;
+
+	/* Register all keys so we can use them all. */
+	bzero(&attr, sizeof(attr));
+	for (i = 0; i < 64; i++) {
+		key = syscall(__NR_bpf, BPF_REGISTER_TRAIT, &attr, sizeof(attr));
+		if (key < 0) {
+			fprintf(stderr, "couldn't register trait: %d\n", key);
+			exit(1);
+		}
+	}
 
 	setup_libbpf();
 
@@ -77,6 +88,23 @@ static void trait_setup(void)
 	}
 }
 
+static void trait_cleanup(void)
+{
+	int err, i;
+	union bpf_attr attr;
+
+	/* Unregister all keys so we can run again. */
+	bzero(&attr, sizeof(attr));
+	for (i = 0; i < 64; i++) {
+		attr.unregister_trait.trait = i;
+		err = syscall(__NR_bpf, BPF_UNREGISTER_TRAIT, &attr, sizeof(attr));
+		if (err < 0) {
+			fprintf(stderr, "couldn't unregister trait %d: %d\n", i, err);
+			exit(1);
+		}
+	}
+}
+
 static void trait_get_setup(void)
 {
 	trait_setup();
@@ -135,6 +163,7 @@ const struct bench bench_xdp_trait_get = {
 	.measure = trait_measure,
 	.report_progress = ops_report_progress,
 	.report_final = ops_report_final,
+	.cleanup = trait_cleanup,
 };
 
 const struct bench bench_xdp_trait_set = {
@@ -146,6 +175,7 @@ const struct bench bench_xdp_trait_set = {
 	.measure = trait_measure,
 	.report_progress = ops_report_progress,
 	.report_final = ops_report_final,
+	.cleanup = trait_cleanup,
 };
 
 const struct bench bench_xdp_trait_move = {
@@ -157,4 +187,5 @@ const struct bench bench_xdp_trait_move = {
 	.measure = trait_measure,
 	.report_progress = ops_report_progress,
 	.report_final = ops_report_final,
+	.cleanup = trait_cleanup,
 };
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_traits.c b/tools/testing/selftests/bpf/prog_tests/xdp_traits.c
index 4175b28d45e91e82435e646e5edd783980d5fe70..1c1eff235a6159d377a5e8b9e0a4d956c4540e8e 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_traits.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_traits.c
@@ -6,8 +6,16 @@ static void _test_xdp_traits(void)
 {
 	const char *file = "./test_xdp_traits.bpf.o";
 	struct bpf_object *obj;
-	int err, prog_fd;
+	int err, prog_fd, i, key;
 	char buf[128];
+	union bpf_attr attr;
+
+	/* Register all keys so we can use them all. */
+	bzero(&attr, sizeof(attr));
+	for (i = 0; i < 64; i++) {
+		key = syscall(__NR_bpf, BPF_REGISTER_TRAIT, &attr, sizeof(attr));
+		ASSERT_OK_FD(key, "test_xdp_traits");
+	}
 
 	LIBBPF_OPTS(bpf_test_run_opts, topts,
 		.data_in = &pkt_v4,
@@ -26,6 +34,14 @@ static void _test_xdp_traits(void)
 	ASSERT_EQ(topts.retval, XDP_PASS, "retval");
 
 	bpf_object__close(obj);
+
+	/* Unregister all keys so we can run again. */
+	bzero(&attr, sizeof(attr));
+	for (i = 0; i < 64; i++) {
+		attr.unregister_trait.trait = i;
+		err = syscall(__NR_bpf, BPF_UNREGISTER_TRAIT, &attr, sizeof(attr));
+		ASSERT_OK(err, "test_xdp_traits");
+	}
 }
 
 void test_xdp_traits(void)

-- 
2.43.0


