Return-Path: <bpf+bounces-21475-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B0784DA06
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 07:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA3FD1F22EEF
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 06:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C658D67C6D;
	Thu,  8 Feb 2024 06:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uHmnP63N"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCC9679FB;
	Thu,  8 Feb 2024 06:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707373483; cv=none; b=ZCmNYaAE/0NveQ+Zm+5diav9BeH2F1gIl+cvaenbVsOAvmLJtITtP9llaLgc8Y+DvTYHTSQvw5Aas/9v4hd9dSv63uwZhoeeURo09uicffpDIMbdeQpqHfERB5PmtofHOHEZTYVvBMuVTLab/Ihdo1sqHoLmgZ0tOFJJKbxf4/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707373483; c=relaxed/simple;
	bh=RFeny4ZUl0eS17R5u69ID8qapypZPhOnIb2FcT6MSWc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eLDULueqWDDriywD895VGaab0FhqyqdNJqTDl9SduqtNOLZK5UuWecCtlLRC4DYsIBMWess2EKS2NHnlGni236V/yFHXBZeni8sa7iMHvRQbFDBFbK3gT5En+h5Dle8+gmqe3JnYeZ6fDPBhI52K91G8lCdkj5mFyt7kMEQrMYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uHmnP63N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 296F9C43394;
	Thu,  8 Feb 2024 06:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707373482;
	bh=RFeny4ZUl0eS17R5u69ID8qapypZPhOnIb2FcT6MSWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uHmnP63NsRW0HWhSX9sLhtT7Xv0BiOk1sRoOmscQUcT83kD2Iivw8gwKKTMlzcVDy
	 XsZ9YusT0BoLAsOuhCkdVk7tyUWMEQwABlERokivHVyNadCCjd9uAKM8CgiGAxliCR
	 RibKQrqgCbfS4wHtYromysDZk3dTIr7Scw8OPR79dH6eKvRkxCO8XT61B6cDMSSW2z
	 YZXh4SiyAfKFAv75PnOqCONF0saAzrdYE4dwEVXTSQkfcl3eb6Xmy+PBDJNZfX6LOg
	 y4BBs5rrWmGd7RBEGd/8BzlMqkZYQUx+OICIX9G3q7KBwZLGZ8EpIdobK9NG5j82pU
	 XokYzUsl0ALDg==
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
Subject: [PATCH bpf-next v5 1/3] bpf, btf: Fix return value of register_btf_id_dtor_kfuncs
Date: Thu,  8 Feb 2024 14:24:21 +0800
Message-Id: <eab65586d7fb0e72f2707d3747c7d4a5d60c823f.1707373307.git.tanggeliang@kylinos.cn>
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

The same as __register_btf_kfunc_id_set(), to let the modules with
stripped btf section loaded, this patch changes the return value of
register_btf_id_dtor_kfuncs() too from -ENOENT to 0 when btf is NULL.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 kernel/bpf/btf.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index f7725cb6e564..16eb937eca46 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8219,10 +8219,8 @@ int register_btf_id_dtor_kfuncs(const struct btf_id_dtor_kfunc *dtors, u32 add_c
 			pr_err("missing vmlinux BTF, cannot register dtor kfuncs\n");
 			return -ENOENT;
 		}
-		if (owner && IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES)) {
-			pr_err("missing module BTF, cannot register dtor kfuncs\n");
-			return -ENOENT;
-		}
+		if (owner && IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES))
+			pr_warn("missing module BTF, cannot register dtor kfuncs\n");
 		return 0;
 	}
 	if (IS_ERR(btf))
-- 
2.40.1


