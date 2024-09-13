Return-Path: <bpf+bounces-39857-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D24CF9788C5
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 21:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 183021C229CC
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 19:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D00E1514F6;
	Fri, 13 Sep 2024 19:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="G9Z5Pwgf"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DCD14C5AF
	for <bpf@vger.kernel.org>; Fri, 13 Sep 2024 19:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726255090; cv=none; b=mXI/XM+zmgO5lMDFBoJ1DSccSyJVbL6E6bo6Xeb1QwXdS81L6ZeQc8Mej0yENQgcfOmbUe4a8uxxOW2IoOn9G+udsqcbiCsHNrhDNpSbRSZ+p1Q2Iv5R6zuXdWCrKprV4D0VZAQxKdgZtyi7Ed3v9r4RBpaGohPlO1GZW3TaVcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726255090; c=relaxed/simple;
	bh=WxRL19JZI9F0ZCAfQ8L5RBUDI7P81lxrF3bs0k3/kwM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KfggutzXxv3r24ykvZfy+ci/IMmFhuYGVilc2K22gwSUGjzNWI+Pm6CiPVxRPNqKRwrOIpQpGQLHJdtyeSOnrEKVI/AnSPnFDjrhBz7DdOCBCISEOFdX5Cd4ljJxDlHuxhTxIMDJ0bomz+qEAWr1Fza6EwhzZDy1ehKl1Hplnfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=G9Z5Pwgf; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=CL9X+CusLLm1y09dVkS+2ZSOgBhaEfDMH73AFP3jRlU=; b=G9Z5Pwgfa8NIT4R30TnLRG8kWq
	zOlLz4OBXfg6KzN5e8lkpMmtcU/NUxoHFgRmoE04/WcWIqZRDBRvYYGnJuQz8t49JtzUFw7MOSSTI
	dkUYkN73XHJEvUCPVouOSk/FU03yM/E3FKRWk3w2HaKzNOJ8PAjA9R/J+rjhr/Cqo1ShW081BnHNu
	a4PSDBm5h6tncLoweS4pC9psGXAYp8poxuJdboaihicjLZAVtG5OMbKCFfRlCH2IaRc70g+D52gdI
	QZcdREllSxE5iTwM7X3CK1Tj4n3QtEizT3oellbRAgzJlbwl9X+aQqEbcnPk8RS/ASFw6knm22g5G
	iS2RWMxw==;
Received: from 43.249.197.178.dynamic.cust.swisscom.net ([178.197.249.43] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1spBnt-000Ku6-1A; Fri, 13 Sep 2024 21:18:00 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: shung-hsi.yu@suse.com,
	andrii@kernel.org,
	ast@kernel.org,
	kongln9170@gmail.com,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v5 9/9] selftests/bpf: Add a test case to write mtu result into .rodata
Date: Fri, 13 Sep 2024 21:17:54 +0200
Message-Id: <20240913191754.13290-9-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20240913191754.13290-1-daniel@iogearbox.net>
References: <20240913191754.13290-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27397/Fri Sep 13 10:48:01 2024)

Add a test which attempts to call bpf_check_mtu() and writes the MTU
into .rodata section of the BPF program, and for comparison this adds
test cases also for .bss and .data section again. The bpf_check_mtu()
is a bit more special in that the passed mtu argument is read and
written by the helper (instead of just written to). Assert that writes
into .rodata remain rejected by the verifier.

  # ./vmtest.sh -- ./test_progs -t verifier_const
  [...]
  ./test_progs -t verifier_const
  [    1.657367] bpf_testmod: loading out-of-tree module taints kernel.
  [    1.657773] bpf_testmod: module verification failed: signature and/or required key missing - tainting kernel
  #473/1   verifier_const/rodata/strtol: write rejected:OK
  #473/2   verifier_const/bss/strtol: write accepted:OK
  #473/3   verifier_const/data/strtol: write accepted:OK
  #473/4   verifier_const/rodata/mtu: write rejected:OK
  #473/5   verifier_const/bss/mtu: write accepted:OK
  #473/6   verifier_const/data/mtu: write accepted:OK
  #473     verifier_const:OK
  [...]
  Summary: 2/10 PASSED, 0 SKIPPED, 0 FAILED

For comparison, without the MEM_UNINIT on bpf_check_mtu's proto:

  # ./vmtest.sh -- ./test_progs -t verifier_const
  [...]
  #473/3   verifier_const/data/strtol: write accepted:OK
  run_subtest:PASS:obj_open_mem 0 nsec
  run_subtest:FAIL:unexpected_load_success unexpected success: 0
  #473/4   verifier_const/rodata/mtu: write rejected:FAIL
  #473/5   verifier_const/bss/mtu: write accepted:OK
  #473/6   verifier_const/data/mtu: write accepted:OK
  #473     verifier_const:FAIL
  [...]

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 v4 -> v5:
 - new patch

 .../selftests/bpf/progs/verifier_const.c      | 33 +++++++++++++++++--
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_const.c b/tools/testing/selftests/bpf/progs/verifier_const.c
index 5158dbea8c43..2e533d7eec2f 100644
--- a/tools/testing/selftests/bpf/progs/verifier_const.c
+++ b/tools/testing/selftests/bpf/progs/verifier_const.c
@@ -10,7 +10,7 @@ long bar;
 long bart = 96;
 
 SEC("tc/ingress")
-__description("rodata: write rejected")
+__description("rodata/strtol: write rejected")
 __failure __msg("write into map forbidden")
 int tcx1(struct __sk_buff *skb)
 {
@@ -20,7 +20,7 @@ int tcx1(struct __sk_buff *skb)
 }
 
 SEC("tc/ingress")
-__description("bss: write accepted")
+__description("bss/strtol: write accepted")
 __success
 int tcx2(struct __sk_buff *skb)
 {
@@ -30,7 +30,7 @@ int tcx2(struct __sk_buff *skb)
 }
 
 SEC("tc/ingress")
-__description("data: write accepted")
+__description("data/strtol: write accepted")
 __success
 int tcx3(struct __sk_buff *skb)
 {
@@ -39,4 +39,31 @@ int tcx3(struct __sk_buff *skb)
 	return TCX_PASS;
 }
 
+SEC("tc/ingress")
+__description("rodata/mtu: write rejected")
+__failure __msg("write into map forbidden")
+int tcx4(struct __sk_buff *skb)
+{
+	bpf_check_mtu(skb, skb->ifindex, (__u32 *)&foo, 0, 0);
+	return TCX_PASS;
+}
+
+SEC("tc/ingress")
+__description("bss/mtu: write accepted")
+__success
+int tcx5(struct __sk_buff *skb)
+{
+	bpf_check_mtu(skb, skb->ifindex, (__u32 *)&bar, 0, 0);
+	return TCX_PASS;
+}
+
+SEC("tc/ingress")
+__description("data/mtu: write accepted")
+__success
+int tcx6(struct __sk_buff *skb)
+{
+	bpf_check_mtu(skb, skb->ifindex, (__u32 *)&bart, 0, 0);
+	return TCX_PASS;
+}
+
 char LICENSE[] SEC("license") = "GPL";
-- 
2.43.0


