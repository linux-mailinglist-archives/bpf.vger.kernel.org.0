Return-Path: <bpf+bounces-69842-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71066BA3F23
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 15:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3105D322AED
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 13:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC88719CC0C;
	Fri, 26 Sep 2025 13:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="L4Ljqtl5"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5CD199E94
	for <bpf@vger.kernel.org>; Fri, 26 Sep 2025 13:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758894625; cv=none; b=kQi9aIvMoWKIezqGn6w4pWtOnkCfM1vxDVaBawm3RasHoo+piwrimmcpFAg6GXcLtSuX3NDkA9utx89dIcZrZ8i+OA3aaQebpr4sQ1IL8+88jo04pmNph5Y9Q+W03HeGUS7HFH7WbyiGW58xEaZdR7VR7QkJEpTHg2gaHmA1TN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758894625; c=relaxed/simple;
	bh=PNh7+z+88D5Jyre9aDTzgsB0PaxDTOG5JZBOBPdxXdc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oQxk0YT0WwqBRuzSgtC7lX5VYQ/69GIp61QDEQXhDqR3S48HTtOQxhmx59GrgGXyEK+hsba+YYPPBIcDygbHpoM4Wm0O2PPRlJga2PuP0afI64XoTOIBvt55M3Ii67MPF2Qsq8dMQpf9wuNk/MisYpZj6OKROC5dsXfZb5BHGFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=L4Ljqtl5; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=WETv7bok4VZaUq+uPAi7A3jsLYGXMquEgKNh0dtL0lo=; b=L4Ljqtl5OKmF18kWdKrNrR6rr9
	NxGeiUdtLMbvyMLQp5WcAof3SqvYx5rRVWhYwQm0chHIBqy8Km+J7FiDiRWBpp3agtLjR4+hB9KAi
	t5mMfNBuXvbcZTtgoIrnjKv5ALEG81dZpaemZfS3X2e2V8Sjw6gwKqcBNWK75JKEToUhg/g9QvkbC
	W8ap747g2AC6LY3lJ2wNj+BO14enz7N4iuGIihrFDZ5K1y+K8lMjAn8v3dwdhvqtRAAnnM1QUYzfy
	kw3yqi50xEUPFuD2ZpfLAUwAE5IehSDlbtfSR6Q8LOKS5iZBev92Q6FeZzhKl8TiY9EXDDyZGyzj/
	xWCklp8Q==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1v28pu-000HMz-2u;
	Fri, 26 Sep 2025 15:50:11 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii.nakryiko@gmail.com,
	Yinhao Hu <dddddd@hust.edu.cn>,
	Kaiyan Mei <M202472210@hust.edu.cn>,
	Dongliang Mu <dzm91@hust.edu.cn>
Subject: [PATCH bpf-next 1/2] bpf: Enforce expected_attach_type for tailcall compatibility
Date: Fri, 26 Sep 2025 15:50:09 +0200
Message-ID: <20250926135010.185569-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.0.9/27774/Fri Sep 26 10:27:36 2025)

Yinhao et al. recently reported:

  Our fuzzer tool discovered an uninitialized pointer issue in the
  bpf_prog_test_run_xdp() function within the Linux kernel's BPF subsystem.
  This leads to a NULL pointer dereference when a BPF program attempts to
  deference the txq member of struct xdp_buff object.

The test initializes two programs of BPF_PROG_TYPE_XDP: progA acts as the
entry point for bpf_prog_test_run_xdp() and its expected_attach_type can
neither be of be BPF_XDP_DEVMAP nor BPF_XDP_CPUMAP. progA calls into a slot
of a tailcall map it owns. progB's expected_attach_type must be BPF_XDP_DEVMAP
to pass xdp_is_valid_access() validation. The program returns struct xdp_md's
egress_ifindex, and the latter is only allowed to be accessed under mentioned
expected_attach_type. progB is then inserted into the tailcall which progA
calls.

The underlying issue goes beyond XDP though. Another example are programs
of type BPF_PROG_TYPE_CGROUP_SOCK_ADDR. sock_addr_is_valid_access() as well
as sock_addr_func_proto() have different logic depending on the programs'
expected_attach_type. Similarly, a program attached to BPF_CGROUP_INET4_GETPEERNAME
should not be allowed doing a tailcall into a program which calls bpf_bind()
out of BPF which is only enabled for BPF_CGROUP_INET4_CONNECT.

In short, specifying expected_attach_type allows to open up additional
functionality or restrictions beyond what the basic bpf_prog_type enables.
The use of tailcalls must not violate these constraints. Fix it by enforcing
expected_attach_type in __bpf_prog_map_compatible().

Fixes: 5e43f899b03a ("bpf: Check attach type at prog load time")
Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 include/linux/bpf.h | 1 +
 kernel/bpf/core.c   | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index ea2ed6771cc6..5c2343e41aa2 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -290,6 +290,7 @@ struct bpf_map_owner {
 	bool xdp_has_frags;
 	u64 storage_cookie[MAX_BPF_CGROUP_STORAGE_TYPE];
 	const struct btf_type *attach_func_proto;
+	enum bpf_attach_type expected_attach_type;
 };
 
 struct bpf_map {
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 9b64674df16b..7ace4dfecd93 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2361,6 +2361,7 @@ static bool __bpf_prog_map_compatible(struct bpf_map *map,
 		map->owner->type  = prog_type;
 		map->owner->jited = fp->jited;
 		map->owner->xdp_has_frags = aux->xdp_has_frags;
+		map->owner->expected_attach_type = fp->expected_attach_type;
 		map->owner->attach_func_proto = aux->attach_func_proto;
 		for_each_cgroup_storage_type(i) {
 			map->owner->storage_cookie[i] =
@@ -2371,7 +2372,8 @@ static bool __bpf_prog_map_compatible(struct bpf_map *map,
 	} else {
 		ret = map->owner->type  == prog_type &&
 		      map->owner->jited == fp->jited &&
-		      map->owner->xdp_has_frags == aux->xdp_has_frags;
+		      map->owner->xdp_has_frags == aux->xdp_has_frags &&
+		      map->owner->expected_attach_type == fp->expected_attach_type;
 		for_each_cgroup_storage_type(i) {
 			if (!ret)
 				break;
-- 
2.43.0


