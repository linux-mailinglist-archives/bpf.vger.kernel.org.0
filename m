Return-Path: <bpf+bounces-21133-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8694848464
	for <lists+bpf@lfdr.de>; Sat,  3 Feb 2024 08:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2636628C5C2
	for <lists+bpf@lfdr.de>; Sat,  3 Feb 2024 07:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3B54F5FF;
	Sat,  3 Feb 2024 07:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhgNtDru"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934BB4F5F2;
	Sat,  3 Feb 2024 07:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706946748; cv=none; b=p4T4MLdoaXOeJsZyRgOCMXnthCwBGEGUdP7uwKK7/Ucfa5oRwWEBaBCob13M8MSImRCC+3wv6hdYpvYSCkr5lD5Y9ELilr7i1pJXMa9VXDzXpRlNTd7WKPcMCLj75yAoqmWCNMmH4160d40HIzh18nStg/6aeef+mgnm+QZ1j4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706946748; c=relaxed/simple;
	bh=tubG1HyOYJGAazL3WH03ZP+gr9zYK5KpA1aInrqnFuI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RkBmMtWSaDuEM/zLqnsaz4cFwIychvL4710Pth0lyZNsiZKceyLma9NrOoQHUYyzMAlqF4kMdx4+aNKHsweYekA4MLj3wqTk8e05ThAVpi4KlrwLvndz3EuTgNMYyN0mOY4d1XguFFwogR1o18Fi8a5+/gdIwWFaUVTA/SWlsFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FhgNtDru; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82DD4C43394;
	Sat,  3 Feb 2024 07:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706946748;
	bh=tubG1HyOYJGAazL3WH03ZP+gr9zYK5KpA1aInrqnFuI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FhgNtDruvqN6TQ5sehgobhk95Tn1wfR3gexy0GxrSQXmsiYh9o2tQ+ankxOxso5UA
	 +sAuANSZIveZZUoYb/NV5nD5J1IAqFUsTmIGoBXNeAbX7vqMab75SJMXvuOQIdZhIL
	 aZ+E0NuXyf8RgvZnQJrDZkioaifn6WmPXnHE9D1x4kVjUtSYZQZZQeHyF5QY0Eh+Lc
	 1R42ZHx6qONAhptnzj5tcfQt6NPD54EzXuhEoZV6mQFMPaNgzQPIY9TUumYyGwFn7q
	 CgORLobaIHXXTS+6rF+uUD0kep/+T3DqlIYuj6f08s62Up+OGDO7Cz09ax/RZFfrOh
	 oBobLO7NsVOWA==
From: Geliang Tang <geliang@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Matthieu Baerts <matttbe@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org,
	mptcp@lists.linux.dev
Subject: [PATCH bpf-next v2 2/2] bpf, btf: Check btf for register_bpf_struct_ops
Date: Sat,  3 Feb 2024 15:51:05 +0800
Message-Id: <e86da7508219125aed45d869cc02161acee418aa.1706946547.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1706946547.git.tanggeliang@kylinos.cn>
References: <cover.1706946547.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Similar to the handling in the functions __register_btf_kfunc_id_set()
and register_btf_id_dtor_kfuncs(), this patch uses the newly added
helper register_check_missing_btf() and IS_ERR() to check the return
value of btf_get_module_btf().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 kernel/bpf/btf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 1ebe26a3a7a5..2d99f85adc82 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8889,7 +8889,9 @@ int __register_bpf_struct_ops(struct bpf_struct_ops *st_ops)
 
 	btf = btf_get_module_btf(st_ops->owner);
 	if (!btf)
-		return -EINVAL;
+		return register_check_missing_btf(st_ops->owner, "structs");
+	if (IS_ERR(btf))
+		return PTR_ERR(btf);
 
 	log = kzalloc(sizeof(*log), GFP_KERNEL | __GFP_NOWARN);
 	if (!log) {
-- 
2.40.1


