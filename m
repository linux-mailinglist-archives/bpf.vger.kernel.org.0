Return-Path: <bpf+bounces-70021-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4CEBAC8F8
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 12:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25F147A76EE
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 10:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13B02FB963;
	Tue, 30 Sep 2025 10:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmSOplD6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8603D2FB615
	for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 10:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759229399; cv=none; b=FXRtpUaq1YSlYmFApSFjfU605CoPk/ZICGVwB0kJbidQdePScu6fZu68pjqZMqXOFI52zlNQRtWQIz5540UEsJgfxUkUzEnwdTI4zH1pNFyLwT61Mzs96GAtehrhIRdFMIefryzhKbqhAKdGsDt2nuaNngJ2eG+HjHMdwYKTbho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759229399; c=relaxed/simple;
	bh=9y8ay7aPvpX7IHx37ibWB6zc4DI6Acm1hYbXZF+XnbM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ssmFkhCikmkiud066X3dG8FAZ6QrdX46G4wCHzKOC1tv1yqAH+DADN/RVR+rZWYZ+2DEhytvUdylM+euIgA5aPkUFNZUj+pYAVC2FulRXH9y5+dpVPKr4O1HwCuk1gRtIynNm2fd1QYHaEvA8x7PukP2OX+FaXEb/Srg5vGLvno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mmSOplD6; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3ee13baf2e1so4536966f8f.3
        for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 03:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759229395; x=1759834195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISQW2niROwPZchBUy3SSFYxA1KEuSyltIgi0gNxETmA=;
        b=mmSOplD6Lzwd4LtKWwIBZ2qJLT79yzuKjzXcCrWXlzcJTpVF/FBe5ClKaJlKVKh6eb
         VLBXzHhdqc9UAHtAUuNvO1mwA75pUEVyrq5apJk21MW8/Hw9N+jEDDcyZDhFBY199lAZ
         b9mL4Xuuf41FTeUKNmRtkEeYJibdXgnQ/mO+zUek+z6mfYF6/FMa1BEX7Rb/HOj79MU+
         ooRmAf6N3JKSWVn5EOgBjoUnHbNmarLAiqHdUAhVM8ZKyhfAp7vGe4bk8VJzFmrp26JO
         JzesX1MobMN8ct++n7Vu6udI+BhWaavXk5wDTcIeHmHYFHnW3n8Htmw1iqQVLFD2RyX/
         pKlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759229395; x=1759834195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ISQW2niROwPZchBUy3SSFYxA1KEuSyltIgi0gNxETmA=;
        b=pZYgHjaVnehtGEUqKhiXe7wekKC9IhrURho1DsDY/Axw7WHWTcNuQINcqdD1TOcggx
         M07b9G0TcKKz+xcHo28B1REIB0bJDAwpoB5J3tlpfqpQ/zfSxhBVXwRtlgs3ii3mdbnA
         RZ9fDjX+ntfN5r7IM3ju9b3Eye+UReE03+sltIiyNwJQcWlbjp8tfiq/hUMuuHFP5IM9
         rSXgFM7AT1w/NjQBlSi80CTVg2zA9G4aCjehWf5rianaHR5oa+hpBVx3K1xGZchw8gX2
         k+UptY6QepoiWraLcfTNnsCBldtAB6BJDW1oxeetJMS/lwfKCxJd9vpGVmYApIJyVL3M
         KQJw==
X-Gm-Message-State: AOJu0Yxdg8zfc/JrKA/V+uZBaiH88UGsyIfiXZZX3E4MFBfj7vCT6xTm
	nUZ+KFR7Yw5+AtJVuZJiMbdbImjDhac8jsOMpaeuWbnfl0L4E/ePGU9G0B5bgQ==
X-Gm-Gg: ASbGncvv2AdVHWmiOoqLuW3YrfEiJztAqgpkz1ZkOhb/jwtAMTYA0vXwvVcKlLHSIjM
	1aSphi+WD/Df+gU6Cl5XNUHYDU7BC+1eFN1SYY8WQDAU7MYhvBlXmUh8OhRRTdYd+H7Ep2ZUmN0
	4i1Xz4DUJVGiY95P55iw90ro1iBqaP0A6PbKmpaYrH3JqUWThPa1vKw/uAjCIrXuZWUnj0lxjkf
	vqF782gz2uCNO663kmqD6QDtJb3s+YuGiZmKONMfl17fy6/aej2sCRbuk0IentFyk7dFOmwPY2a
	FdMzIb68GowiO9bY2+Ngr0Ql5lnBdgHgss803XfqCfnkTXcQ2Lu7krCblCVWWh0IW1WsW5wxJR6
	pxrIacSssl72t/kUn4uXgVfKTWKChiDOJIDBiMFV6wxmpqfSHr88rRTW1VEHn04rxFqRuO4fV6/
	p8
X-Google-Smtp-Source: AGHT+IF6tNeVyQrygr3xENWeddNsA44g2Ksi+TmZK1u7OGI2t8QVQIohV9EWUSy33jpTNL13zXm4UQ==
X-Received: by 2002:a5d:5888:0:b0:3fd:2dee:4e3d with SMTP id ffacd0b85a97d-40e4be0ca19mr17272953f8f.46.1759229395413;
        Tue, 30 Sep 2025 03:49:55 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc5602dfdsm21982161f8f.33.2025.09.30.03.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 03:49:55 -0700 (PDT)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH v4 bpf-next 12/15] libbpf: fix formatting of bpf_object__append_subprog_code
Date: Tue, 30 Sep 2025 10:55:20 +0000
Message-Id: <20250930105523.1014140-13-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250930105523.1014140-1-a.s.protopopov@gmail.com>
References: <20250930105523.1014140-1-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit 6c918709bd30 ("libbpf: Refactor bpf_object__reloc_code")
added the bpf_object__append_subprog_code() with incorrect indentations.
Use tabs instead. (This also makes a consequent commit better readable.)

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 52 +++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 5161c2b39875..1bb390a5c76e 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -6444,32 +6444,32 @@ static int
 bpf_object__append_subprog_code(struct bpf_object *obj, struct bpf_program *main_prog,
 				struct bpf_program *subprog)
 {
-       struct bpf_insn *insns;
-       size_t new_cnt;
-       int err;
-
-       subprog->sub_insn_off = main_prog->insns_cnt;
-
-       new_cnt = main_prog->insns_cnt + subprog->insns_cnt;
-       insns = libbpf_reallocarray(main_prog->insns, new_cnt, sizeof(*insns));
-       if (!insns) {
-               pr_warn("prog '%s': failed to realloc prog code\n", main_prog->name);
-               return -ENOMEM;
-       }
-       main_prog->insns = insns;
-       main_prog->insns_cnt = new_cnt;
-
-       memcpy(main_prog->insns + subprog->sub_insn_off, subprog->insns,
-              subprog->insns_cnt * sizeof(*insns));
-
-       pr_debug("prog '%s': added %zu insns from sub-prog '%s'\n",
-                main_prog->name, subprog->insns_cnt, subprog->name);
-
-       /* The subprog insns are now appended. Append its relos too. */
-       err = append_subprog_relos(main_prog, subprog);
-       if (err)
-               return err;
-       return 0;
+	struct bpf_insn *insns;
+	size_t new_cnt;
+	int err;
+
+	subprog->sub_insn_off = main_prog->insns_cnt;
+
+	new_cnt = main_prog->insns_cnt + subprog->insns_cnt;
+	insns = libbpf_reallocarray(main_prog->insns, new_cnt, sizeof(*insns));
+	if (!insns) {
+		pr_warn("prog '%s': failed to realloc prog code\n", main_prog->name);
+		return -ENOMEM;
+	}
+	main_prog->insns = insns;
+	main_prog->insns_cnt = new_cnt;
+
+	memcpy(main_prog->insns + subprog->sub_insn_off, subprog->insns,
+	       subprog->insns_cnt * sizeof(*insns));
+
+	pr_debug("prog '%s': added %zu insns from sub-prog '%s'\n",
+		 main_prog->name, subprog->insns_cnt, subprog->name);
+
+	/* The subprog insns are now appended. Append its relos too. */
+	err = append_subprog_relos(main_prog, subprog);
+	if (err)
+		return err;
+	return 0;
 }
 
 static int
-- 
2.34.1


