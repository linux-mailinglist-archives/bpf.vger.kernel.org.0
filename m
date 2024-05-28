Return-Path: <bpf+bounces-30794-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 222578D280C
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 00:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D7BAB22889
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 22:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DE613DDC5;
	Tue, 28 May 2024 22:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mcW1IpBG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5AC8F49
	for <bpf@vger.kernel.org>; Tue, 28 May 2024 22:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716935540; cv=none; b=f01U3HjbIuD3TNkPp+/Pa5JwVdZB1U6EhPfOWDUud01XnLhhIlSEaO32X7Op7el4fQZslQaio2l+PL43GFKnPDaxZzqccO2sT0cXE7cVpLcO/BgN4o00gjS1YuQXlldVSvSbE9RJJBzIfkSkKoREUSg26IcjQDu6aDrctYUdv9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716935540; c=relaxed/simple;
	bh=BislDSFYubJKLuK3oPH6NsXnGGFP9SBwq/DuWnWP8Sc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WKz3FWx+SL6T7DL9b/B9fTh6zzthwaFh9XTWjPAXtEFcfo6FhUFvkSg6ebSws73exkpGq4GvAuWiTtne1Guno5NQ2wniq+otZ9u1ll4+jc9L24NzN4GzfHSIBhQbhCYTtlX6VEnGgugo7lIt3YEx2KMJCeT91/te3kmcdK21EsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mcW1IpBG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 292ABC3277B;
	Tue, 28 May 2024 22:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716935540;
	bh=BislDSFYubJKLuK3oPH6NsXnGGFP9SBwq/DuWnWP8Sc=;
	h=From:To:Cc:Subject:Date:From;
	b=mcW1IpBGVBb0dByWdlHpfnF3Tv0mBSnbqAzhm/tMfmKtUXOgM5vptd5o7ub3uA0pq
	 4tp6m5Dt19VlqM7hZJX6PwSrEuF+qC3iDOhNvLXCx7dHC+pwGzEL6IQykiCJajOJ6/
	 UwyFUKLR6yvrnfPtbElVoNjWupynv0X+TK9R0f+F++nZmV7/FCvbO6WcOfHAfmDJm0
	 FhfjRdyoAcLYQeMNwaRnULANvnyV29VsDmV9h2V2rjPCdLtQwm+lbV8KWT78IRMt2/
	 2mevV8eXKE0QN+/zlQFVxPghIJxPkr6qX3Bh5hWsfCtde2T4jqQwIg5z6M3+jid1UJ
	 +RsPKLrEzfLYg==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next] selftests/bpf: fix inet_csk_accept prototype in test_sk_storage_tracing.c
Date: Tue, 28 May 2024 15:32:18 -0700
Message-ID: <20240528223218.3445297-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recent kernel change ([0]) changed inet_csk_accept() prototype. Adapt
progs/test_sk_storage_tracing.c to take that into account.

  [0] 92ef0fd55ac8 ("net: change proto and proto_ops accept type")

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/progs/test_sk_storage_tracing.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/test_sk_storage_tracing.c b/tools/testing/selftests/bpf/progs/test_sk_storage_tracing.c
index 02e718f06e0f..40531e56776e 100644
--- a/tools/testing/selftests/bpf/progs/test_sk_storage_tracing.c
+++ b/tools/testing/selftests/bpf/progs/test_sk_storage_tracing.c
@@ -84,7 +84,7 @@ int BPF_PROG(trace_tcp_connect, struct sock *sk)
 }
 
 SEC("fexit/inet_csk_accept")
-int BPF_PROG(inet_csk_accept, struct sock *sk, int flags, int *err, bool kern,
+int BPF_PROG(inet_csk_accept, struct sock *sk, struct proto_accept_arg *arg,
 	     struct sock *accepted_sk)
 {
 	set_task_info(accepted_sk);
-- 
2.43.0


