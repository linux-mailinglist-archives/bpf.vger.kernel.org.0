Return-Path: <bpf+bounces-21477-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C993D84DA0B
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 07:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6550C1F22CFA
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 06:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6BC67E96;
	Thu,  8 Feb 2024 06:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FRvbgY6z"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333AE679FB;
	Thu,  8 Feb 2024 06:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707373495; cv=none; b=pxMDEA7gPsQY6xiefxyWVixk7ttNjkaqrVPVH75xcV3h1L5QlNRAaNsQqvfwzk2n2mon9fT6P3vHosdfFdI5cTxKyTH+ysZhNtxb0S3Vfv3TowdESiZnBGgJ4ByZEcLE4HoqorOF/cAMciQ6MSYlZmRqvRi+0t4laChs4qvrhEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707373495; c=relaxed/simple;
	bh=uiDA2nuOrPwyYuDShNZ10B8oLeFQNQ7Cu4/PyTufBB4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hh76WY/O/U85eaq+YqjabgM2MKZpyQN25BL5pWezN26Js4CP4MNM2ZoDep6KhgfqliCSSGLbXDMhKI8ZBPYbNiRJL5ODUBgS95E8fH04Gr90ankjmlYbBXfbHeApmvNTyK0at99mo6vS/GOAoRZL2YLmJ2VhfqeB6RCsgyxmWvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FRvbgY6z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87982C43399;
	Thu,  8 Feb 2024 06:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707373495;
	bh=uiDA2nuOrPwyYuDShNZ10B8oLeFQNQ7Cu4/PyTufBB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FRvbgY6zGzqb6MTKH4BjFLAJ3oxdAJJvk68dndAs7ZcWbpfpMMHmyTrgJK+wd2fjd
	 JwXKBn7PddlBA8qNhskeTXZ/+F4syws6QAi1wHVywkUhtOlQ+UOmzRhNtFHMnHVmpx
	 8wm+vWmMTmMInBkPLKRzi4DJlu65xnC7eaWIxCnl/aJuWeucLUVoU/HYvN3YwamKjA
	 g+UHBRN0zQy8d+qo8tUeXf15YdvgpwnNf+4Di11x5QjP+g22bAszTH6DZUH739dqfn
	 svfcrtT17zeFrIUtBKFbrMtPHT41d+XuVxXB945RczAoqOB4bnUmbnfl7UdZPvVNR/
	 jhT3ojz7+F85w==
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
Subject: [PATCH bpf-next v5 3/3] bpf, btf: Check btf for register_bpf_struct_ops
Date: Thu,  8 Feb 2024 14:24:23 +0800
Message-Id: <69082b9835463fe36f9e354bddf2d0a97df39c2b.1707373307.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1707373307.git.tanggeliang@kylinos.cn>
References: <cover.1707373307.git.tanggeliang@kylinos.cn>
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
helper check_btf_kconfigs() and IS_ERR() to check the return value of
btf_get_module_btf().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 kernel/bpf/btf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index e318df7f0071..c18b0f47f1f9 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8882,7 +8882,9 @@ int __register_bpf_struct_ops(struct bpf_struct_ops *st_ops)
 
 	btf = btf_get_module_btf(st_ops->owner);
 	if (!btf)
-		return -EINVAL;
+		return check_btf_kconfigs(st_ops->owner);
+	if (IS_ERR(btf))
+		return PTR_ERR(btf);
 
 	log = kzalloc(sizeof(*log), GFP_KERNEL | __GFP_NOWARN);
 	if (!log) {
-- 
2.40.1


