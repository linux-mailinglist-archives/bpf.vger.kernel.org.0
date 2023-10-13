Return-Path: <bpf+bounces-12160-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 716167C8D5D
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 20:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F6901C21194
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 18:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663CA2135B;
	Fri, 13 Oct 2023 18:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mgK4tDSX"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B6918E16
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 18:57:16 +0000 (UTC)
Received: from out-205.mta0.migadu.com (out-205.mta0.migadu.com [IPv6:2001:41d0:1004:224b::cd])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C8995
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 11:57:15 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1697223433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pfF4V3MRLxDmHY2jucV8sHY1pkfvsl+7IG10CgK6hTc=;
	b=mgK4tDSXROxDNsOknhQW6cc0k6jQyacHBLhn5ApA3ZUyfckbV0QBxsu97uvvgFz6eidqAi
	wCNG4HDEKVtjJRVjfdwF+tEEYlMr7FmkKj+Yc2sIWAdGFPmADXte+KEWe3O0NQuAkaySGS
	NUf48LcxLrjkv3GjUtU42Xi+BtUZaGU=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: 'Alexei Starovoitov ' <ast@kernel.org>,
	'Andrii Nakryiko ' <andrii@kernel.org>,
	'Daniel Borkmann ' <daniel@iogearbox.net>,
	netdev@vger.kernel.org,
	kernel-team@meta.com,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Daan De Meyer <daan.j.demeyer@gmail.com>
Subject: [PATCH bpf-next] net/bpf: Avoid unused "sin_addr_len" warning when CONFIG_CGROUP_BPF is not set
Date: Fri, 13 Oct 2023 11:57:02 -0700
Message-Id: <20231013185702.3993710-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Martin KaFai Lau <martin.lau@kernel.org>

It was reported that there is a compiler warning on the unused variable
"sin_addr_len" in af_inet.c when CONFIG_CGROUP_BPF is not set.
This patch is to address it similar to the ipv6 counterpart
in inet6_getname(). It is to "return sin_addr_len;"
instead of "return sizeof(*sin);".

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/bpf/20231013114007.2fb09691@canb.auug.org.au/
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>
Fixes: fefba7d1ae19 ("bpf: Propagate modified uaddrlen from cgroup sockaddr programs")
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 net/ipv4/af_inet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 7e27ad37b939..5ce275b2d7ef 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -814,7 +814,7 @@ int inet_getname(struct socket *sock, struct sockaddr *uaddr,
 	}
 	release_sock(sk);
 	memset(sin->sin_zero, 0, sizeof(sin->sin_zero));
-	return sizeof(*sin);
+	return sin_addr_len;
 }
 EXPORT_SYMBOL(inet_getname);
 
-- 
2.34.1


