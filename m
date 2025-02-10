Return-Path: <bpf+bounces-50911-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7935CA2E3EC
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 07:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60F3F168D7F
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 06:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838C01A76D0;
	Mon, 10 Feb 2025 06:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1FjVUyA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4381A23A0;
	Mon, 10 Feb 2025 06:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739167209; cv=none; b=Icsfnm2XOW7c/Dgl+4hpneteH7jmcsv5hQCF+sNCkGNnB+cjPPrySCrsZbUGmmkJvOgvjbP8rUgd37uvPurtpWfxNQB1ABVf0mFFPw+1fyDiOta+A7oVaiWBFGM2t70jglzwFmKxtIg9IecTkh7z9GyunZViBg0gNSZTrpcfBIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739167209; c=relaxed/simple;
	bh=gCSkhghV4FSQv8s+RD3+Va+foCnFjyb66eHvLgkiuWw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=HE0cNu2OYX5k0VQh9sqvlu+RKHCAW3lbMkZ1Nx/7RY2ZFhc2Kovz5ZxYjJFZlrmGlH3JuGyfRkGk3Ssg8uK1uS6VBZjA79J7nM2rnuGipDiI+LkROe0OIFz6XHmNqmT5q2gVgjQD481mJwK2lDn9OKdKOFQ5cghKLvYkTU4LXg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l1FjVUyA; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2f44353649aso5714663a91.0;
        Sun, 09 Feb 2025 22:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739167207; x=1739772007; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3SRCkrYu/UmXO72yLMKra7PMrlLBZ+7UhvcccuRgDqg=;
        b=l1FjVUyAC+wpx/vh4VDQL6y6ttKMuKRJX7PUFb74f+I8Yd58s38uacgkipq9rp+V5d
         TY1pBApEJlwDuu+n9VtNSfj+SPrRoyZtfAmvbZ9aEXh/2TuKFStwC/Xt8f0SYstM/KiB
         DlvXgNjRaINX5Wvg1EIIdwMezPdioApW3iOeK4H/CnlaEhFu0Duf2u8U7Aln+tCoMxKw
         +wg3fEBPUilOfMWF0mEHJtSZQFjA95HoOMpOFc2C2AhySVYzk/GQHK07o7heHPCDm5aY
         qGG2+fN+XtIl89a2+mlJYqyAyIkgIWnUA2n7V0Jqz3kDhBM5jrV5W3J4nSYm5EcSeclP
         pKeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739167207; x=1739772007;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3SRCkrYu/UmXO72yLMKra7PMrlLBZ+7UhvcccuRgDqg=;
        b=tn2GngSi6pxwZqHbkpKOOJ0Jlj9YmP7jbEbeGuXQlMteeGbU7GZHAbFmNmxKg8iN7P
         7eKyh7mZy4txM0kYhTrgHifalcIQOKkFqRxt8vLUUSYg/wvj9nEePXdrtKUEtJxCkIsT
         sd1I81Q9HNNi7FRcjTrzK6m7dOZi+vA3RGILenjkrQWeOucrTT+5LVMekLlbrTrL2iC7
         LVuuQZgn4VcxCe6hxkUPZW/GUjVsfpDLAlyFe/JByPSRr4OqhsSGxhvYsVxPFOGrM8ND
         Ub5ciDfpKP2VrA5pcUPAAK5fcayR1ZMThjVbbF9bJYikEKJUiFpbAmSe3UQ6X0kUlAi4
         RkLA==
X-Forwarded-Encrypted: i=1; AJvYcCU+ly4rAcJGjGEaFAoPhm6OOl3LkL7lySF2sDFQaYYFJiE0P/ZybxpxUoOjF36CO8a+pHo0DxmK+XV/CtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/sTx0OEzdWZEo+uaAQBBhJ0oT0VNLGZOqHVr/XX1KhTm4hcHZ
	ewjkHEIr5xQnGR1UJqcONWywypgVwdmfYx4BbnnYw1aiXZp1kcYxiU72NA==
X-Gm-Gg: ASbGncvxvrWepnTKU3i/zxxP3Yw5o7NyUR5L/cDpLjFuvhlruB0LvgdD5J1nXO/8TSr
	9ig2GvM5RszERaPlERo50RxBHgnL7iLTmYZWqOMRKVB7pduv2iVv6IousO/zHpnChJ9mSXM/SYw
	4721Fm3Bx/TymwIU2+giywWMGF8z3Alzf6hpHyNIInr6TBKGA45XwcIK7sPXu3SM0FBuP3kN+0o
	aE65a1NqI0WDNCYjfaP8WjgosiOTbyYH91fRSahOE9eGPvkVaN8OJEPb/eF/H46oT5XzIuNIW1K
	6TLaC+4FmNQ2TLY8
X-Google-Smtp-Source: AGHT+IGm1C+LWoEbHmeZBzYgASIkwGtwMCLbrkfIOLTl5LkXZuG+yKirlW/CwmcbJx5KeZwueyOO0Q==
X-Received: by 2002:a17:90b:4a8c:b0:2ee:6d08:7936 with SMTP id 98e67ed59e1d1-2fa2427538dmr19798095a91.20.1739167206702;
        Sun, 09 Feb 2025 22:00:06 -0800 (PST)
Received: from localhost ([111.229.209.227])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa22ae7b70sm6053044a91.31.2025.02.09.22.00.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Feb 2025 22:00:06 -0800 (PST)
From: Tao Chen <chen.dylane@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	haoluo@google.com,
	jolsa@kernel.org,
	qmo@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chen.dylane@gmail.com
Subject: [PATCH bpf-next v5 1/4] libbpf: Extract prog load type check from libbpf_probe_bpf_helper
Date: Mon, 10 Feb 2025 13:59:42 +0800
Message-Id: <20250210055945.27192-2-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250210055945.27192-1-chen.dylane@gmail.com>
References: <20250210055945.27192-1-chen.dylane@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Extract prog load type check part from libbpf_probe_bpf_helper
suggested by Andrii, which will be used in both
libbpf_probe_bpf_{helper, kfunc}.

Signed-off-by: Tao Chen <chen.dylane@gmail.com>
---
 tools/lib/bpf/libbpf_probes.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index 9dfbe7750f56..aeb4fd97d801 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -413,6 +413,23 @@ int libbpf_probe_bpf_map_type(enum bpf_map_type map_type, const void *opts)
 	return libbpf_err(ret);
 }
 
+static bool can_probe_prog_type(enum bpf_prog_type prog_type)
+{
+	/* we can't successfully load all prog types to check for BPF helper
+	 * and kfunc support.
+	 */
+	switch (prog_type) {
+	case BPF_PROG_TYPE_TRACING:
+	case BPF_PROG_TYPE_EXT:
+	case BPF_PROG_TYPE_LSM:
+	case BPF_PROG_TYPE_STRUCT_OPS:
+		return false;
+	default:
+		break;
+	}
+	return true;
+}
+
 int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type, enum bpf_func_id helper_id,
 			    const void *opts)
 {
@@ -427,18 +444,8 @@ int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type, enum bpf_func_id helpe
 	if (opts)
 		return libbpf_err(-EINVAL);
 
-	/* we can't successfully load all prog types to check for BPF helper
-	 * support, so bail out with -EOPNOTSUPP error
-	 */
-	switch (prog_type) {
-	case BPF_PROG_TYPE_TRACING:
-	case BPF_PROG_TYPE_EXT:
-	case BPF_PROG_TYPE_LSM:
-	case BPF_PROG_TYPE_STRUCT_OPS:
+	if (!can_probe_prog_type(prog_type))
 		return -EOPNOTSUPP;
-	default:
-		break;
-	}
 
 	buf[0] = '\0';
 	ret = probe_prog_load(prog_type, insns, insn_cnt, buf, sizeof(buf));
-- 
2.43.0


