Return-Path: <bpf+bounces-41138-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7628799329D
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 18:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 221F01F23CDE
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 16:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1871DA622;
	Mon,  7 Oct 2024 16:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3o5uw1g"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C961DA30F
	for <bpf@vger.kernel.org>; Mon,  7 Oct 2024 16:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728317403; cv=none; b=uXB8Koq/oCUyTIIxfQDUVo0vdxNS/niCqQMciMoRUMJM2azusT7r98p+blMFcsJWVZsSrpPhueJfM4E6wGQylui3sbMsuByN/cvVWydEV5F4MriyXAfqEF2bQSKmHz8h9xKqj6HSDYabHNIU6MhTyyiah6Rmc4xIuwkO/X4kDP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728317403; c=relaxed/simple;
	bh=/WpLl5BbElXpGEcoP0gQhwXNsO9hIODoejkS0F8SHlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DISrjI/dlIcqmBSpcdgLycSA6zB9rjjc+IS0hBnhKE6x1aAnopFlPD+4mNigH747maakFhFQgKt8Bq9/p7uLjPd+Izl1XkZ0EUUeqbiYYVDyAPC8TbH82qGIlzdcxHmjjn5OfiAipdjvvASkvBmy20wF5v46VPvx/Bt0doJGooc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3o5uw1g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 281D4C4CEC6;
	Mon,  7 Oct 2024 16:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728317402;
	bh=/WpLl5BbElXpGEcoP0gQhwXNsO9hIODoejkS0F8SHlQ=;
	h=From:To:Cc:Subject:Date:From;
	b=k3o5uw1gkHxsQ/axzKA4q0PPIibMJ9Tee35pBwcDAyLYu3NrMnKcFxd0EtbY4k8ow
	 rzCochZQSCEGKAkIVDihnXzj/IDPZcU+FSZz7phj5K+LfeiXbmkr7ehhy5GNrX/VEd
	 eR8Brd2LAPD97OGkOT6439kQWbzb0BHqhz34y4lU7g7meYsXkBu7MD22J21guDZvSk
	 q0x2Ufb5nh7APwNDDDVg7Op4KuZubm2lJTUxYUzC6g+L+ZO0mThbHhadKLvT/F+gvw
	 eFsRkvua8Ue+QuIot315ugnFznUKLHpBfcmfqfj3HcMRdRqRhtH4C1PzoKU+xhImOE
	 6gbuga9yUOLpQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>
Subject: [PATCH bpf] bpf: Fix memory leak in bpf_core_apply
Date: Mon,  7 Oct 2024 18:09:58 +0200
Message-ID: <20241007160958.607434-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We need to free specs properly.

Cc: Eduard Zingerman <eddyz87@gmail.com>
Fixes: 3d2786d65aaa ("bpf: correctly handle malformed BPF_CORE_TYPE_ID_LOCAL relos")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/btf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 75e4fe83c509..a05da5f43547 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8961,6 +8961,7 @@ int bpf_core_apply(struct bpf_core_ctx *ctx, const struct bpf_core_relo *relo,
 	if (!type) {
 		bpf_log(ctx->log, "relo #%u: bad type id %u\n",
 			relo_idx, relo->type_id);
+		kfree(specs);
 		return -EINVAL;
 	}
 
-- 
2.46.2


