Return-Path: <bpf+bounces-51267-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E1FA32A3D
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 16:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63D51167141
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 15:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13ABD214A86;
	Wed, 12 Feb 2025 15:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W1nSDy9k"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337FB212FB2;
	Wed, 12 Feb 2025 15:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739374761; cv=none; b=j7bVzXlN0Dv12J50afqncFOzmzvq7Wn7WycLVGCu0J1ywjqIMYk5Jvic0YlGKwF8y3p0AZ1w2k+TCa4IpZXNbKUhhmzsDBJ3hWQpLw9BnM9ychDTZkzAwHPPJRCf42q0k5vVo/gEHLzm2zdXTjTG2OAfYz7sEi1c65A636o7eRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739374761; c=relaxed/simple;
	bh=gLL6cpzIFJVIxqPRHnNpi8sbyg8IQoOBomtsQRhVUVU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Nvhui5jcr8+j4oqgRkXERA0raWDkw6alLoHsmaVV5SJL3hca7/43uuPaafSvkyGitS7bcaPlHk5PSlC6FD6k+LVZvBIvs4N860NSIHjMwoR/IjbLESkt9m3lKjMCQsVbAPUES7MyRkhoOCBRt+/plaVp3HHbumLgiqGar6wc/B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W1nSDy9k; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21f5660c2fdso105376845ad.2;
        Wed, 12 Feb 2025 07:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739374759; x=1739979559; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Jomb4wbCL0aIqDd/8vp4O87PbPEncfEiumc5w8RJl5s=;
        b=W1nSDy9kx8Q/klgW1I5xvHm8EluXnufBO7bxeHV9QHxiTqAIxzchxFr1Gl9Dt4iOtK
         9IlxBje7o5PfOhVaYBO/ZP2s66DsbyXuuM8Mc7w48ABMa3aGTr61bd+R+naDmW9eVfg9
         vV0QwQAl7ZV+nzKtuZ+LVk8js6j6jA2j8+xSLroHGe8Ot0ewjMpmfn/ALbaAcA21Mx8N
         K5bWm1UEkOa/yYYyZRvdAL/e6xE92pNX3ZlhbEcrLkZLdLeHQ6DPsDe4fzXrcIURu2u1
         Zw2md3J3KJJVOx/jK/uyiSmMd8LiWsRhI/Yl36mLB/b81KohO/wQ36N1yNrgp5g9cBJt
         uaMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739374759; x=1739979559;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jomb4wbCL0aIqDd/8vp4O87PbPEncfEiumc5w8RJl5s=;
        b=kSVljdnvyr4ASn8deSkURmLHeelVcmlR69v68o9+bf/2lDlttO9RXzN6XyVSRp7JOt
         QwSF2J0mRAZMMOD+dp2Bgbv7EdchHK5Ptg5sN0BPftZ/D34V5O0iS1/OCqjaAk9kjaQe
         od2jnwnLFpvD5A3y0C+ydVdYFe90CXnhcV8EFNEMlKNCtUZg1/zuVrnYEx5/dulf8E/X
         GkYl6gFzeEqRDaJag0MuJqQtHtefCf1kvAqoHnUNbvjnoKQkZ1IaHFG8VHhaBLUpFOml
         y7IAtfIaCnlQCK5dApQRiEDTtq3XXJrl/g1D8SZDwbWir7B/lMDFUFpsw/VTPvOW5CLw
         QpEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCXyN1EBb4rS6eM68co3Zk4qIX5obpg3JmkA30+/BJO04eCebbhfStG8bPJxdAnHZJowpOEwepu7w5gI8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8XXJOsolfgjvkY2APdnjpErnnbPwC6iByoZrJyUFIuoGYEuVr
	uxauj7BoyWWHBeE/1u57k15Sun35Nu+J2sdC2mzM2hGWzxye5vqfTGGcdw==
X-Gm-Gg: ASbGncvasaUWvqVLb+LzNqt7AM0MAR/NOlSQ3ozunapAygYK61LtJNcpHHduOnk3u3N
	M1Kd5/Owb5NmxJHZ9m79U8jEvhagLj7EXJu+sPl4CbLmswYHzpkn0Wb/RZnGXLkBJlgLfS9+TSL
	0Q5cT8A96MFU7hj4Z5LDJMI/W9eyLJC/EFau4G+9CfRofoZIE9+PvjgvMp7YdhkEM8/l6j20fni
	adQjC8zl6QnJ+vxb83gggaP1lOqn9kc74aAra+SGcny/4t73JOIweo3oaivlZbXdV7JDIq7V+6Q
	pjXDWGFzg1CXQ+pX
X-Google-Smtp-Source: AGHT+IGllOU4Vl3axyv39hSFAJPVrdBeecrkKfB243Ro1X5bBRglUBSJJug0ldI+VvscGpwVwMBFww==
X-Received: by 2002:a05:6a21:78a9:b0:1db:c20f:2c4d with SMTP id adf61e73a8af0-1ee5c72e4e9mr6168010637.2.1739374759368;
        Wed, 12 Feb 2025 07:39:19 -0800 (PST)
Received: from localhost ([111.229.209.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048e20c32sm11599295b3a.170.2025.02.12.07.39.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Feb 2025 07:39:19 -0800 (PST)
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
	chen.dylane@gmail.com,
	Tao Chen <dylane.chen@didiglobal.com>
Subject: [PATCH bpf-next v7 1/4] libbpf: Extract prog load type check from libbpf_probe_bpf_helper
Date: Wed, 12 Feb 2025 23:39:09 +0800
Message-Id: <20250212153912.24116-2-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250212153912.24116-1-chen.dylane@gmail.com>
References: <20250212153912.24116-1-chen.dylane@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Extract prog load type check part from libbpf_probe_bpf_helper
suggested by Andrii, which will be used in both
libbpf_probe_bpf_{helper, kfunc}.

Cc: Tao Chen <dylane.chen@didiglobal.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Tao Chen <chen.dylane@gmail.com>
---
 tools/lib/bpf/libbpf_probes.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index 9dfbe7750f56..a48a557314f6 100644
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
-		return -EOPNOTSUPP;
-	default:
-		break;
-	}
+	if (!can_probe_prog_type(prog_type))
+		return libbpf_err(-EOPNOTSUPP);
 
 	buf[0] = '\0';
 	ret = probe_prog_load(prog_type, insns, insn_cnt, buf, sizeof(buf));
-- 
2.43.0


