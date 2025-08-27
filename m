Return-Path: <bpf+bounces-66625-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A60B37915
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 06:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F5051B627DD
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 04:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41211299920;
	Wed, 27 Aug 2025 04:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="jRRzBJ1h"
X-Original-To: bpf@vger.kernel.org
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9066426C3BF;
	Wed, 27 Aug 2025 04:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756268877; cv=none; b=RSDgB1yyAuWENVSl+dtyd3b4MJ6TpbebXcsw99fl5Iyoefoa7kyA/oNVCHSat7cGPIpY1egzF9QkdWMnii80stWeajlnAWHiR32IrKNpfe4K5e2tlrTd+oOwARfzEuSnCm5QsGQv4BHa1DZT5rht8qATu8VNkvsRwO7/h53wIbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756268877; c=relaxed/simple;
	bh=Z71WFKVO7SlDTEC9TDJuBtsGGrweWui/xzsG8xAVB2A=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=kZTIIAMJenC06P1VySIrS214vi1cBCyG34Yr9nvF25rkGu6qqkTQ19dXwJP9sLqNpWmREVOYNSYFc/rko/3J/Pqsu54eKPhK9NDWhIuYrA0TAaZCXeBci/Q28kXotSTIwctY9XcQbqFFQzuaDd7iydH+X/f0TJ4WWj9jnLDd0Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=jRRzBJ1h; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1756268862;
	bh=6ogh+exqBE1dWvizNk+dPpfKvf5vAN0Rftnfo40Lrrc=;
	h=From:To:Cc:Subject:Date;
	b=jRRzBJ1hMyk7P8N2ZUTNImAsjb7HHPYawyAcQnURUm/vYvf76TSu9QMEvLHcNONQy
	 o1pxsImMSq+ZnzaNz+BbHcWHMVpjdx4GFQ6/8X0nIKoiB65o9IuyI4PQlZhvqb4pnz
	 TNh9neck0xEUYuttz7/IWO7QCq/DrBhyNVIkPukk=
Received: from NUC10 ([39.156.73.10])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id 6E314084; Wed, 27 Aug 2025 12:27:35 +0800
X-QQ-mid: xmsmtpt1756268855thq1wp4la
Message-ID: <tencent_65E5988AD52BEC280D22964189505CD6ED06@qq.com>
X-QQ-XMAILINFO: M1rD3f8svNznXTxcTx1nzMi06tATwsSCYLDPOaHU8+exmotWsZcJCmaroQ6mOi
	 22O5jpBFU/9cEHTiKtDcs6VVXG4bfTZK3yXKxCDwJS3zpkEYPk9rLRYnZXptWb45ImlTLlnT7TVR
	 /I9+n3NvEpgkYVQc1u6DpNjSqtm7RRDAtMSjP1xaEYfTgGgHLrHPvuKsyVVScg2KstoWtjQ/TL3v
	 pZwpPBTq2jP9X4G1qP3zrv4UXrr5y5tlNzNRlUqABPm6QtOaMPxlOwJjwQuwP+/Xren9uBhPTdB2
	 C7Ky0HvrrZNNtEUnaDJz1LKQpoQSUpMoSFgu7H/wmszAnDwZ60l3fHu+sV7DboDPgz9uP/3imsOT
	 02EbVYDxSX5cmR2v247YntiRkl6lo0o19c3jWjOIQtbSeyr1qjnvzDFEZ4U6+VFgNjH8UcBTyF6a
	 Xf2aXg3zRwKLEn2MzRQRK9tcNLMSjUDlQQjQc0MWj3AtXTpOamVluOEG5DNLksHHgEogmrBDOz1K
	 FC9VRxrayguWJ3stql4US7iQRbhgTMSqPNi5LXFyFfex0/jL8rWxidaeZpL/xPFnFgc9PQiwFEg1
	 bWtE6Yw/jfcG0BC2F5+Gk7K3qwgqm/VmrRKhtL4IFejWLqokUcm/nyV3Uz8l94nyiwslph3LHwnz
	 MUB/78pLVgq+C1SYaK+NImpQ8mUuvvRVc+zdgKHteEThyjQBDfDLT2IJan3sZrCnW8NaNcRB16zB
	 mP8MoswXmk5UduPu/bCZsxQuQWYouFTv/xKSxBnRByYv5L0uKR2qNqswQQLhMwRdPhfxw9iSCBYc
	 7SGG5e6sNK3YiIdVT5G+NDGbj2xpC7hFAtmS+sgcMXkeZ8iEUEpNEra8EYCM0HzdbGYudjvFE5XQ
	 jxx2fCu5ph2i144uLVUfqPrKzpzFurfBgLgJqfOhPhOpDPo7VQ80NNJOXJRLx07Ol/2PkbA/scsu
	 GR00HMMxgStiMduugWHwvjMFcVDZwWnotWfm7ec10sNSiykOH0qMMBwTSfMco8HBlLEO2X8XdqPn
	 0b1PBV3DZZcHNoXx32CuLt+BVALNzJ+XU1v8RGRdJtIV0IsCK0
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Rong Tao <rtoax@foxmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net
Cc: rongtao@cestc.cn,
	rtoax@foxmail.com,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH bpf-next] bpf/helpers: bpf_strnstr: Exact match length
Date: Wed, 27 Aug 2025 12:27:23 +0800
X-OQ-MSGID: <20250827042724.269460-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rong Tao <rongtao@cestc.cn>

strnstr should not treat the ending '\0' of s2 as a matching character,
otherwise the parameter 'len' will be meaningless, for example:

    1. bpf_strnstr("openat", "open", 4) = -ENOENT
    2. bpf_strnstr("openat", "open", 5) = 0

This patch makes (1) return 0, indicating a successful match.

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 kernel/bpf/helpers.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 401b4932cc49..65bd0050c560 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3681,6 +3681,8 @@ __bpf_kfunc int bpf_strnstr(const char *s1__ign, const char *s2__ign, size_t len
 				return -ENOENT;
 			if (c1 != c2)
 				break;
+			if (j == len - 1)
+				return i;
 		}
 		if (j == XATTR_SIZE_MAX)
 			return -E2BIG;
-- 
2.51.0


