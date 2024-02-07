Return-Path: <bpf+bounces-21411-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A71DE84CC5A
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 15:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44FBE282813
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 14:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495CF7C088;
	Wed,  7 Feb 2024 14:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRbbWV0A"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A883B7A726;
	Wed,  7 Feb 2024 14:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707314908; cv=none; b=dGTNJhlUoL7jFOih5m/1tLxbJD3JKbtRj+4IsVEYlHUj5aWOgZ4ed7trklEt+dVOCg1QtSYe6M3bJDcUtCVI5Y7khdM9Ei8m1RYMMNDpDkbnHMhquxkOb+vVCL6Ew3bZrBVU7pDn3e5BFX+Ni8k0OWGfcg5HFoyDExnjxgGpIRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707314908; c=relaxed/simple;
	bh=J1Il0ufBa31zXemEA+7pfMIoFvnKy7gs4oH7qu5WSe0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SWhBj6sOoPFP5S2tdMiebK6eIdLosHNJydtCJh81819z9XeF4UHTmvTSlfYb1C77/x1i8z1ZX8JVaJzWFSpCo5+r1HpNzcxcAn7daE1dF0YPUH3YNKsDaR2nAo101Es/+nKAg/xfkoBzuqiP/TyZG47Gv3RT5sXVKx6ctVpBOtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRbbWV0A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4768C43390;
	Wed,  7 Feb 2024 14:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707314908;
	bh=J1Il0ufBa31zXemEA+7pfMIoFvnKy7gs4oH7qu5WSe0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QRbbWV0AihK5q5+PMymDQHeZqrPHjbEYVxcpn9vDsHQWePLC8vpU2v+SLG8nKlc03
	 3y24BjM7EbGQT/lXgITe6p6uTGjSK6131fZwAYlLmI4SdIcJ1A5sxdRC1njH0gxFsC
	 y7qFb8Z/VI1JHV0oLtV0EOfd+3sPUYe4mIUKTVJOHfXGvlD/3sARhXuXLgTXglmFVO
	 tjGtJhAsaMeq1Wf6X1L8qcBeDnXdoavdi3rxzSWQveg2lP0ixmmkT5WUwYXxf4H+yU
	 k1AVNS4zWIzTlP/lBenRkU6N9s7bNMM6rEsfh34Jwct4bcRzwWw1zCnZ0YQu1kzbwi
	 nW0f9Nqzbh9Qg==
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
Subject: [PATCH bpf-next v4 3/3] bpf, btf: Check btf for register_bpf_struct_ops
Date: Wed,  7 Feb 2024 22:07:56 +0800
Message-Id: <836391d2a7f44fffaba4ddf664354ecb8eba66cf.1707314646.git.tanggeliang@kylinos.cn>
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

Similar to the handling in the functions __register_btf_kfunc_id_set()
and register_btf_id_dtor_kfuncs(), this patch uses the newly added
helper check_btf_kconfigs() and IS_ERR() to check the return value of
btf_get_module_btf().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 kernel/bpf/btf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index eedbee04de89..9aae5a4bba24 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8885,7 +8885,9 @@ int __register_bpf_struct_ops(struct bpf_struct_ops *st_ops)
 
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


