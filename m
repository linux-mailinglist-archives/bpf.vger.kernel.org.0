Return-Path: <bpf+bounces-21149-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DD5848B9B
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 07:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E40EE1C21F58
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 06:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C170B7493;
	Sun,  4 Feb 2024 06:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t76Ln2VA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E3079C2;
	Sun,  4 Feb 2024 06:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707029914; cv=none; b=jf8LuZ0nCfuXWGK28+5hyf9aQrps+oxSaZS0aJBGdfk2Hba0qMEHD/k8g+BjcS5/rHbhG3nGzreTxy5iR19kuMWP/naaYskkL/58As+IKiFzYs3dUqwf5bglpLyVarrkQD2pGjj5f51sMIHEIbtcEH5xlseIySkIgNw2sWXs/dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707029914; c=relaxed/simple;
	bh=OjXAoTGCiW2e0cWcTMfwDHj2YAPWCF2ECmSMeQkoff8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H3h7BBzdSudsSZmsSAbDAY4kft2tlFArWF9pe/mobYuUBhLkZSYYCBFP7VsGDLbHEIpAXwDAaWYLBvNWOlSw4p4SFjsqA4ZlL896J2AVqWvMTzsYHm8oYrq/Ek2vKjr4FZyfeNF76B5Nb2uDjLlZZR8x5wb5BMZa96SriYItOHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t76Ln2VA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09DD3C433F1;
	Sun,  4 Feb 2024 06:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707029913;
	bh=OjXAoTGCiW2e0cWcTMfwDHj2YAPWCF2ECmSMeQkoff8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t76Ln2VAjbScPqTgg6Vq9mc8BuxvFnYmGccSpFXyKdVHIDZd+QHAqhrXQq65yL+xd
	 CEsoEISALfwSqLFwfdX8TOUo0hKRBrcNNF463DClHlmbMwz1u18VrvUQVaQp5DjDWv
	 mWju0kYPGaWPlmPRiWEzYwOlVfx4gHzq8rN5Uh6pzaRqBxmdCeezvqNE9CA4nF9e9s
	 5twg9G9ddANgGdG11eLwNc3jLyQ9HwvoC8vFAmsFXLyubG8TpoRqA0poxtQrxkEHFt
	 r+EyhJAggBHGbejKjqT5wtsz3S73XUDhH4LTo2socBNeW+VCJX5o518YNmNYN+osP4
	 fyvYOG2rHAZHw==
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
Subject: [PATCH bpf-next v3 2/2] bpf, btf: Check btf for register_bpf_struct_ops
Date: Sun,  4 Feb 2024 14:58:13 +0800
Message-Id: <40b390e09ae6003d9dc3c571ae1c5185597e75e3.1707029682.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1707029682.git.tanggeliang@kylinos.cn>
References: <cover.1707029682.git.tanggeliang@kylinos.cn>
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
index d166c12206ea..714f13121f1c 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8890,7 +8890,9 @@ int __register_bpf_struct_ops(struct bpf_struct_ops *st_ops)
 
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


