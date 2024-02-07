Return-Path: <bpf+bounces-21409-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF1184CC58
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 15:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E376A1C23EF9
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 14:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178557C6C3;
	Wed,  7 Feb 2024 14:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFA6YVq3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7857C09D;
	Wed,  7 Feb 2024 14:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707314896; cv=none; b=tTowaZYU+WlZusDY5xh43SHTJo2I5pqIhsycNtZnczI1w3/TjFQAIDnoNh2etAyd8WZrAmRH9WJkuhN+fVbXcWmpz65xnM6R9ahY3Td+WrIvBcH6zKeZyqi2f4R8sKmw+X4yA6T7KOrJz+cCmk5C14g2GDht+kytqAZbTvn/Sf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707314896; c=relaxed/simple;
	bh=xBKjgPQS/Jpq9Sq/sAc3h8Qc9T8zShFzRqNCb+1mBNc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CLEQDak0DTRPbmtHJbohzdA8TpEXo/l1tDXBaZyyh27uzUQmG1r3GFEIZlhQl7/cG0d+hINVwTW5qS/oDFGjugA5ByWgfqniWUUodctQILy1kfXg7OEbb532GW6GAVhYP/euqL9TL/tPic6hxIv/TIP60F5QXW8xfPbn1SkzY8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFA6YVq3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1A8EC433C7;
	Wed,  7 Feb 2024 14:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707314896;
	bh=xBKjgPQS/Jpq9Sq/sAc3h8Qc9T8zShFzRqNCb+1mBNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cFA6YVq3AUgsVn/VayYMg4PNvmlD2XVzAZWFwfFmg+Gu707jLaBL10vLVFAi+BKdR
	 /yg0oxKBldV2aZop2MqgfS6+qyKu2RkbKl53dLE+wrjioa3wtmZeDnjo8xW7NYzfbO
	 C9qU6ixSgIbYcSpDrSkUYGsizAHUIr3cakGqZahq+EuzubnqW5Ygh62bGSsxnHC9S9
	 kSykVcLSZsaL2Jwxxdf42yuZ2T56/qaTWjdEvIYQskrjc/uYfLYCrI5oICwUbiU1I0
	 ClXboQQWPJtBORv5u+439jZETVb1GuncgSev+KZIBrSVYoyX62tosAgQmxMyGvmvQI
	 3eAXbW6qdLHsQ==
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
Subject: [PATCH bpf-next v4 1/3] bpf, btf: Fix error checks for btf_get_module_btf
Date: Wed,  7 Feb 2024 22:07:54 +0800
Message-Id: <d79e5dd6b4a189252af696a10df8ce585e9cb46d.1707314646.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1707314646.git.tanggeliang@kylinos.cn>
References: <cover.1707314646.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

To let the modules loaded, commit 3de4d22cc9ac ("bpf, btf: Warn but
return no error for NULL btf from __register_btf_kfunc_id_set()")
changes the return value of __register_btf_kfunc_id_set() from -ENOENT
to 0 when btf is NULL.

A better way to do this is to enable CONFIG_MODULE_ALLOW_BTF_MISMATCH.

An error code -ENOENT should indeed be returned when kernel module BTF
mismatch detected except CONFIG_MODULE_ALLOW_BTF_MISMATCH is enabled in
__register_btf_kfunc_id_set().

The same in register_btf_id_dtor_kfuncs(), give the modules a chance
to be loaded when CONFIG_MODULE_ALLOW_BTF_MISMATCH is enabled.

Fixes: 3de4d22cc9ac ("bpf, btf: Warn but return no error for NULL btf from __register_btf_kfunc_id_set()")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 kernel/bpf/btf.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index f7725cb6e564..203391e61d93 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8103,8 +8103,11 @@ static int __register_btf_kfunc_id_set(enum btf_kfunc_hook hook,
 			pr_err("missing vmlinux BTF, cannot register kfuncs\n");
 			return -ENOENT;
 		}
-		if (kset->owner && IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES))
+		if (kset->owner && IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES) &&
+		    !IS_ENABLED(CONFIG_MODULE_ALLOW_BTF_MISMATCH)) {
 			pr_warn("missing module BTF, cannot register kfuncs\n");
+			return -ENOENT;
+		}
 		return 0;
 	}
 	if (IS_ERR(btf))
@@ -8219,7 +8222,8 @@ int register_btf_id_dtor_kfuncs(const struct btf_id_dtor_kfunc *dtors, u32 add_c
 			pr_err("missing vmlinux BTF, cannot register dtor kfuncs\n");
 			return -ENOENT;
 		}
-		if (owner && IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES)) {
+		if (owner && IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES) &&
+		    !IS_ENABLED(CONFIG_MODULE_ALLOW_BTF_MISMATCH)) {
 			pr_err("missing module BTF, cannot register dtor kfuncs\n");
 			return -ENOENT;
 		}
-- 
2.40.1


