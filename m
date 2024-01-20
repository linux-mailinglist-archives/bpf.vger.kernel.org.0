Return-Path: <bpf+bounces-19962-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A508332E1
	for <lists+bpf@lfdr.de>; Sat, 20 Jan 2024 07:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EBA61F22F57
	for <lists+bpf@lfdr.de>; Sat, 20 Jan 2024 06:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56F31858;
	Sat, 20 Jan 2024 06:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r1QWOdgL"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9666810E1
	for <bpf@vger.kernel.org>; Sat, 20 Jan 2024 06:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705730741; cv=none; b=EuTiLC7Zo/9vbnPBYhgN/RDf38DRvRDh5veD8oqLb61eStoHx74v8NK3Z7NfW3YOdGGCIwTzGvp3dCvY6Js9gbiVSElqz5sDxuKEYaSTJ2YiNklZyGki0kfT8MtlOxBU7oohNRt0mm+xiedSBwim9MElsnkY/Bs4cnLM2dyJWKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705730741; c=relaxed/simple;
	bh=UfS/0VXJsSkYOfKjH2bpyDNyGVTgJUHvDtbK1E2VvD8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z5O/MuaI4zKIz5iIw7+N1ZxMQea9tJAuHWwRDDjbE/SRYz3xWXKMxCtY/rbyIfzQsuEBpTLv51sfh6LboLTTQmzK72HMGzZv9yE1c7IQPmLBW1DvnpVN8iDzV4ftSnsJOg4xpPI5oBWazIcd3f0LOYCGzEJRMFYDSZTLVWpqz6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r1QWOdgL; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705730737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TQ8xZsSJSODhnMgyiRDISjav5Ai2v8hg/uNsEeNtq/s=;
	b=r1QWOdgLNcbFhPPc7gIpJ8Q4ohJjBf6w8/8//Mr+uKdAMeGJkHFx9ma0CkjSGofdZ/gxWY
	0aZb3Srg1jwUVjpXitKBePLStSnW2Se5o1S5CFmCM/8FAc1AFXkLQUyVopk7sOgys2pO4a
	CqDZWZMbzal8yii/u1V7ANirN8Ux0z8=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 1/2] selftests/bpf: Fix the flaky tc_redirect_dtime test
Date: Fri, 19 Jan 2024 22:05:17 -0800
Message-Id: <20240120060518.3604920-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Martin KaFai Lau <martin.lau@kernel.org>

BPF CI has been reporting the tc_redirect_dtime test failing
from time to time:

test_inet_dtime:PASS:setns src 0 nsec
(network_helpers.c:253: errno: No route to host) Failed to connect to server
close_netns:PASS:setns 0 nsec
test_inet_dtime:FAIL:connect_to_fd unexpected connect_to_fd: actual -1 < expected 0
test_tcp_clear_dtime:PASS:tcp ip6 clear dtime ingress_fwdns_p100 0 nsec

The connect_to_fd failure (EHOSTUNREACH) is from the
test_tcp_clear_dtime() test and it is the very first IPv6 traffic
after setting up all the links, addresses, and routes.

The symptom is this first connect() is always slow. In my setup, it
could take ~3s.

After some tracing and tcpdump, the slowness is mostly spent in
the neighbor solicitation in the "ns_fwd" namespace while
the "ns_src" and "ns_dst" are fine.

I forced the kernel to drop the neighbor solicitation messages.
I can then reproduce EHOSTUNREACH. What actually happen could be:
- the neighbor advertisement came back a little slow.
- the "ns_fwd" namespace concluded a neighbor discovery failure
  and triggered the ndisc_error_report() => ip6_link_failure() =>
  icmpv6_send(skb, ICMPV6_DEST_UNREACH, ICMPV6_ADDR_UNREACH, 0)
- the client's connect() reports EHOSTUNREACH after receiving
  the ICMPV6_DEST_UNREACH message.

The neigh table of both "ns_src" and "ns_dst" namespace has already
been manually populated but not the "ns_fwd" namespace. This patch
fixes it by manually populating the neigh table also in the "ns_fwd"
namespace.

Although the namespace configuration part had been existed before
the tc_redirect_dtime test, still Fixes-tagging the patch when
the tc_redirect_dtime test was added since it is the only test
hitting it so far.

Fixes: c803475fd8dd ("bpf: selftests: test skb->tstamp in redirect_neigh")
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/tc_redirect.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
index 518f143c5b0f..610887157fd8 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
@@ -188,6 +188,7 @@ static int netns_setup_links_and_routes(struct netns_setup_result *result)
 {
 	struct nstoken *nstoken = NULL;
 	char src_fwd_addr[IFADDR_STR_LEN+1] = {};
+	char src_addr[IFADDR_STR_LEN + 1] = {};
 	int err;
 
 	if (result->dev_mode == MODE_VETH) {
@@ -208,6 +209,9 @@ static int netns_setup_links_and_routes(struct netns_setup_result *result)
 	if (get_ifaddr("src_fwd", src_fwd_addr))
 		goto fail;
 
+	if (get_ifaddr("src", src_addr))
+		goto fail;
+
 	result->ifindex_src = if_nametoindex("src");
 	if (!ASSERT_GT(result->ifindex_src, 0, "ifindex_src"))
 		goto fail;
@@ -270,6 +274,13 @@ static int netns_setup_links_and_routes(struct netns_setup_result *result)
 	SYS(fail, "ip route add " IP4_DST "/32 dev dst_fwd scope global");
 	SYS(fail, "ip route add " IP6_DST "/128 dev dst_fwd scope global");
 
+	if (result->dev_mode == MODE_VETH) {
+		SYS(fail, "ip neigh add " IP4_SRC " dev src_fwd lladdr %s", src_addr);
+		SYS(fail, "ip neigh add " IP6_SRC " dev src_fwd lladdr %s", src_addr);
+		SYS(fail, "ip neigh add " IP4_DST " dev dst_fwd lladdr %s", MAC_DST);
+		SYS(fail, "ip neigh add " IP6_DST " dev dst_fwd lladdr %s", MAC_DST);
+	}
+
 	close_netns(nstoken);
 
 	/** setup in 'dst' namespace */
-- 
2.34.1


