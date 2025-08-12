Return-Path: <bpf+bounces-65466-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC54B23BAD
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 00:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29F271AA8064
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 22:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9DE2DEA99;
	Tue, 12 Aug 2025 22:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sLueRq7M"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CB41F9A89;
	Tue, 12 Aug 2025 22:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755036755; cv=none; b=nd6jBAqykvWRP5inhCFAOqlV0BI1TELS0RiPvK+pcpbm8jaGDb+usgU0n+zQtiMmGaszBtLvMNBAuvWrxHfSJ59GralvZVldPCMZuVR3p8rYZ0F6j2F770KpYImFNDw5uKeofQQgQiibOVyonlVTd9Sa55k3FVBUH95ihsjp+Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755036755; c=relaxed/simple;
	bh=INSAUmyfMNmpHOAYNt1O0K2kCVD5UJVG2qd1v8Pzt0s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=stn4aJwCyxfsKIfJdmsvlOhiGcdMIGyvQ3GjNtNDIJ7U1rNpGilbDJ9zVtywQ/+8zdECaWGQr7XfQxKPZ2pNmy50JuazthgFC/J4qgka/6tIDwtmzPg9b8S34ZriWE3pAtcnIVu3qkZ3XPEu3waKiWWrUtKQTYQikyvAZakxj5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sLueRq7M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E20AC4CEF0;
	Tue, 12 Aug 2025 22:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755036753;
	bh=INSAUmyfMNmpHOAYNt1O0K2kCVD5UJVG2qd1v8Pzt0s=;
	h=From:To:Cc:Subject:Date:From;
	b=sLueRq7MKL5nLFQgpAHbemJlAADEiThpXF8m3BdO9Px6rkDhJfR/8LWXm9PsH1geh
	 XWAks/p1QArJURN6lzBt+fkmcZVHIi9gUu5MpICWFEJZk/bVS5J6ol2T+/vl/SESI8
	 ug/+Na09a2YohrON8Kz8rbp5LpCmGl0KVIzSgxSZMuU/Td82sncQnpuZG/KCcuihcq
	 ZAF9WDi9nWTJTdvnJ8SVm7aTTecxuJoirJQSir0WDPF/7VXYARBowTWBu9H4DkNCw8
	 BN4uRwyCIfqAocKXbfXAGUCXcInbbC/TxmZXyclyM55/b6QFAh5MOAtmLGd6KC+Vsd
	 zSqQGse+rpROQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: syzbot+a9ed3d9132939852d0df@syzkaller.appspotmail.com,
	bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>
Subject: [PATCH bpf] bpf: Check the helper function is valid in get_helper_proto
Date: Wed, 13 Aug 2025 00:12:20 +0200
Message-ID: <20250812221220.581452-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Olsa <olsajiri@gmail.com>

syzbot reported an verifier bug [1] where the helper func pointer
could be NULL due to disabled config option.

As Alexei suggested we could check on that in get_helper_proto
directly. Excluding tail_call helper from the check, because it
is NULL by design and valid in all configs.

[1] https://lore.kernel.org/bpf/68904050.050a0220.7f033.0001.GAE@google.com/
Reported-by: syzbot+a9ed3d9132939852d0df@syzkaller.appspotmail.com
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/verifier.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c4f69a9e9af6..5e38489656e2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11344,6 +11344,13 @@ static bool can_elide_value_nullness(enum bpf_map_type type)
 	}
 }
 
+static bool is_valid_proto(const struct bpf_func_proto *fn)
+{
+	if (fn == &bpf_tail_call_proto)
+		return true;
+	return fn && fn->func;
+}
+
 static int get_helper_proto(struct bpf_verifier_env *env, int func_id,
 			    const struct bpf_func_proto **ptr)
 {
@@ -11354,7 +11361,7 @@ static int get_helper_proto(struct bpf_verifier_env *env, int func_id,
 		return -EINVAL;
 
 	*ptr = env->ops->get_func_proto(func_id, env->prog);
-	return *ptr ? 0 : -EINVAL;
+	return is_valid_proto(*ptr) ? 0 : -EINVAL;
 }
 
 static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
-- 
2.50.1


