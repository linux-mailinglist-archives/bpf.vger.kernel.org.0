Return-Path: <bpf+bounces-72952-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 730E9C1DEEC
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 01:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 334A33BE8ED
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 00:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F2D1F03D7;
	Thu, 30 Oct 2025 00:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UX9Vf/mt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vs1-f68.google.com (mail-vs1-f68.google.com [209.85.217.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D7117C77
	for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 00:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761784800; cv=none; b=UTz+bcVt+1RmBHoo/9r/RGv2Rh0bcoqJVOjhVnAEeFS+ZWR5Z9I3qoa2Qtxg7j4YcgITFs/7n0/hRYT+UdQEuw6Y93LXjX4DCzkuFNbaXpy7M781AfzAN92wdC+ySvnJx0vA/ySE2HWuJO+5YJ5yYBxZKgBtRtonzNuT/gi/Njg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761784800; c=relaxed/simple;
	bh=F+1dmMPKU1EhsOPIiAUwiJ0ziaxA3hjqAkVzPYv5gKs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Rm84wiEVVdssoCf9CHa/j9EA47yCbWPKgH16BUPAkc15XLqHrD+A7z27YMifIEvH/vCzijdyE31Uv2RdRt44NjrrEVA6MhSd39aSiiFqeMlby2s8i3hWLTj3b9fUWvMRPr79Oa49eUzmEOUB0nb/bsoEkBXLkLdG2HGYl7Qnblc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UX9Vf/mt; arc=none smtp.client-ip=209.85.217.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f68.google.com with SMTP id ada2fe7eead31-5d967b67003so580578137.2
        for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 17:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761784797; x=1762389597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1C+kpg11Lr3Fa6qP5rxUJKauqkyrQ3fXbk25+xhKPiA=;
        b=UX9Vf/mtcyxa33z9qTFl8KzC4O3ICOkSVgUFjMD1Yy/mJoSAU5S940NpniBCCBy/qM
         4q+wo56bhoZOFI74nkFKB9o6qOK7JSalUdhQf44pgyRbim0OEsYj2Zm96xFlgwoN1qn1
         ypdsz4+fDhVEKwffYVYs1b771DCpj0N7uXrQEIa91+5tx5hEz6WoW7yG/Gqyn8zQ8FCa
         IGZ5jdIylgvMbYg1OJICgaTUuY7q8o/rWBoD8LL0FLoUASEKdSFG5WvP3/X6Tjw2wmn9
         6WX38zWmQc/frKwhOMX+vqBk+J71b4LYjUd5XWytkv3H3zC6fDs2KDKha8/5PSOZ24QB
         Jh7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761784797; x=1762389597;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1C+kpg11Lr3Fa6qP5rxUJKauqkyrQ3fXbk25+xhKPiA=;
        b=cuAvEh8Uxba8BsM0DigFMlBQ7tU9k04FQBmPH2Z3yxfsWeUo9SQ8aTrKxL8KQRmkXY
         cn3pE9q7a7rCTsY9R2LQWRgQA+FwlTtM4U1piwYnkrzznMZr5y8dAhaCf+dQIGApD+Bt
         CT3vRj2IGJBHAYqQpcE12mk1u7WIfrsqJ7sJA2HhY6TWPj1G5BiB2rL5yRz/fL5f2wgt
         dfp5Dz+TjG2MNAdc+ZDoQ7BHc7+aPUSjg/Rsh5qb0uHbrhWcznh+8X6WB2mn2pyUvr9m
         n+I4N/5cIC5H0OcgjAIc/8eCy6rVKUKVVAalFmSTz1t/HaQG8JVvKXvBk6dBFna3XoCq
         hqFw==
X-Forwarded-Encrypted: i=1; AJvYcCU8tMe0br23grsvt7C6ctyEyD0JECjwLkBN++v4nBNpdwTY+1N5vFljvcIGbu4YEAjR8p8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFXkDu16FrEcUsi1ZfqPhVoGTx6hzrzF3ZIeEFInT8d1blOr0F
	BUG/5msGoQmv8fOZCp0efM3gXOV5sNw+GEzq/H6kikqAjlLfG8gk7ZIZ5qyp1+R1
X-Gm-Gg: ASbGnctXLoKgYnhz9t4j83bnly5UDR3htyIxk78S8yRE6NPNsuGF55llVll4wU9Bv4n
	hN8uWnGIAkUskl6HVFZfVY83eZD2yme19tBHF39LfpqVvVXd2shZ5TwoI7Um5voD1iFvnZfqmRO
	pho7K1CMkkMCLRCFwViCFCooBXORt0S/HNrX1P49SbMIu4Ef5aWJr9AiuIH60ZTl60XJbBtLpK+
	9IZywZy2QkZ7rY8grNz/UW1vy+sRw9p04XAqrNsEy9R1AfEDWCvkY16K92qQez2GaQ7X+BZakPx
	sGry2LZLGN6ZrLNx1yPPKnAofv/6SNMe0irLxmQ2KO9p3tj/5Qvd1vq7kbaZtNSn0uFjGCktiNM
	UpfrWSyQ4sIoC4WYyBXZOqwnecq44z0MXzNAr26AN9T6cxl+x6bmf6PZk7nu1BVQTIFIiULn9fF
	7elTQbQlY+IMkhn7BBbfdzl8ORwpsI
X-Google-Smtp-Source: AGHT+IEhCsgLDZ33oU7eKu5WmrCrdlI4CH0spBUGDjecXX03bKx9ED6BN00mwBebude5G/b3JmN9RQ==
X-Received: by 2002:a05:6a20:2586:b0:341:6844:bd9d with SMTP id adf61e73a8af0-34785230af3mr1789958637.13.1761784390679;
        Wed, 29 Oct 2025 17:33:10 -0700 (PDT)
Received: from E07P150077.ecarx.com.cn ([103.52.189.23])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b712d3fc7b0sm15419683a12.29.2025.10.29.17.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 17:33:10 -0700 (PDT)
From: Jianyun Gao <jianyungao89@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Jianyun Gao <jianyungao89@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org (open list:BPF [LIBRARY] (libbpf))
Subject: [PATCH] libbpf: Update the comment to remove the reference to the deprecated interface bpf_program__load().
Date: Thu, 30 Oct 2025 08:32:35 +0800
Message-Id: <20251030003235.1131213-1-jianyungao89@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit be2f2d1680df(Deprecate bpf_program__load() API) marked
bpf_program__load() as deprecated starting with libbpf v0.6. And later
in commit 146bf811f5ac(remove most other deprecated high-level APIs)
actually removed the bpf_program__load() implementation and related old
high-level APIs.

This patch update the comment in bpf_program__set_attach_target() to
remove the reference to the deprecated interface bpf_program__load().

Signed-off-by: Jianyun Gao <jianyungao89@gmail.com>
---
 tools/lib/bpf/libbpf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index fbe74686c97d..27a07782bd72 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -13858,8 +13858,8 @@ int bpf_program__set_attach_target(struct bpf_program *prog,
 		return libbpf_err(-EINVAL);
 
 	if (attach_prog_fd && !attach_func_name) {
-		/* remember attach_prog_fd and let bpf_program__load() find
-		 * BTF ID during the program load
+		/* Store attach_prog_fd. The BTF ID will be resolved later during
+		 * the normal object/program load phase.
 		 */
 		prog->attach_prog_fd = attach_prog_fd;
 		return 0;
-- 
2.34.1


