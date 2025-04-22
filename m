Return-Path: <bpf+bounces-56453-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C96D6A97856
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 23:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 844F03AD53D
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 21:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AA92561A8;
	Tue, 22 Apr 2025 21:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZkjpSijL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C7D1E376C;
	Tue, 22 Apr 2025 21:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745356524; cv=none; b=YlCclCNunddUX7EDcPeotWsfhNjPILLvDvo1Z/nYrJ9zbuayKJChj15VB1pEOspoC90weGNTXefcZw1sefRoXdEtdvknFCJ7t8xEzD/3PLmaBseoI6gA69pi+sbogDYe156QEvOqA5x6Nj1LJnYECNbk4WZcIw6+aLq1JPJNN3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745356524; c=relaxed/simple;
	bh=QdTQyr37SfxusAZldiv5gHbHmQlIKPCRsCyk7lP3UWI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tH2LUUj07xS4IvtTFaqfc5MM8YKcvBORShHWAc5OiVzP60Kd8Ott+28Dnsn5NLlWKrD+yy3q+7WQiiDKR9fEScR8BoDTseFu1rksn82JiGufnf265cBMmwOzaRfJxTuBFj1Hl7g3fj4CjMwROv7L8ZKlhTvuhq5ubSZ8zcmPRYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZkjpSijL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D03DC4CEE9;
	Tue, 22 Apr 2025 21:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745356524;
	bh=QdTQyr37SfxusAZldiv5gHbHmQlIKPCRsCyk7lP3UWI=;
	h=From:Date:Subject:To:Cc:From;
	b=ZkjpSijLr+5OqbD7Fp7C4WWxFb43VVFxYDZrWor1VQk+KY05Qe56RFD/rOfzYVo83
	 vloBhgbJaoGAbQEvssRhAr0l9Ls9v0gqN5Zj2ZAmHlAfE7MpZj8kaXeTdTYnJag1nd
	 RFZFFsvE4p3ym1XgMjgGHZPSukkgbwwvW1FJKABgxaxM800orH40/GjiFloKZQq63n
	 bSkVQPZiWPw0ecYyWcCLjBF0rbwqiBiCUblX9QTjMDq07TwXBIZywqpX1m1KNR7xxc
	 DKzc4b/3qJxrrO98/giZaCBAaCfUoBPRplyS08zjnksNjra26rODUbs1Y16OPHCy7x
	 bb1jrPHybu4LQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 22 Apr 2025 23:14:52 +0200
Subject: [PATCH bpf-next] bpf: Allow XDP dev bounded program to perform
 XDP_REDIRECT into maps
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250422-xdp-prog-bound-fix-v1-1-0b581fa186fe@kernel.org>
X-B4-Tracking: v=1; b=H4sIAMsGCGgC/x2MQQqAIBAAvxJ7bsHUDvWV6GC51l5UlCKQ/t7Sc
 QZmGlQqTBXmrkGhmyunKDD0Heyniwche2HQSo/Kao2Pz5hLOnBLV/QY+MEpGBUMDcY6BxLmQqL
 /6bK+7wfJs591ZAAAAA==
X-Change-ID: 20250422-xdp-prog-bound-fix-9f30f3e134aa
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

In the current implementation if the program is bounded to a specific
device, it will not be possible to perform XDP_REDIRECT into a DEVMAP
or CPUMAP even if the program is not attached to the map entry. This
seems in contrast with the explanation available in
bpf_prog_map_compatible routine. Fix the issue taking into account
even the attach program type and allow XDP dev bounded program to
perform XDP_REDIRECT into maps if the attach type is not BPF_XDP_DEVMAP
or BPF_XDP_CPUMAP.

Fixes: 3d76a4d3d4e59 ("bpf: XDP metadata RX kfuncs")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 kernel/bpf/core.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index ba6b6118cf504041278d05417c4212d57be6fca0..a33175efffc377edbfe281397017eb467bfbcce9 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2358,6 +2358,26 @@ static unsigned int __bpf_prog_ret0_warn(const void *ctx,
 	return 0;
 }
 
+static bool bpf_prog_dev_bound_map_compatible(struct bpf_map *map,
+					      const struct bpf_prog *prog)
+{
+	if (!bpf_prog_is_dev_bound(prog->aux))
+		return true;
+
+	if (map->map_type == BPF_MAP_TYPE_PROG_ARRAY)
+		return false;
+
+	if (map->map_type == BPF_MAP_TYPE_DEVMAP &&
+	    prog->expected_attach_type != BPF_XDP_DEVMAP)
+		return true;
+
+	if (map->map_type == BPF_MAP_TYPE_CPUMAP &&
+	    prog->expected_attach_type != BPF_XDP_CPUMAP)
+		return true;
+
+	return false;
+}
+
 bool bpf_prog_map_compatible(struct bpf_map *map,
 			     const struct bpf_prog *fp)
 {
@@ -2373,7 +2393,7 @@ bool bpf_prog_map_compatible(struct bpf_map *map,
 	 * in the case of devmap and cpumap). Until device checks
 	 * are implemented, prohibit adding dev-bound programs to program maps.
 	 */
-	if (bpf_prog_is_dev_bound(aux))
+	if (!bpf_prog_dev_bound_map_compatible(map, fp))
 		return false;
 
 	spin_lock(&map->owner.lock);

---
base-commit: 5709be4c35ba760b001733939e20069de033a697
change-id: 20250422-xdp-prog-bound-fix-9f30f3e134aa

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


