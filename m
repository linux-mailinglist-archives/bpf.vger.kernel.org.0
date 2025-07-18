Return-Path: <bpf+bounces-63771-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 168D3B0AC20
	for <lists+bpf@lfdr.de>; Sat, 19 Jul 2025 00:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E88F1896A97
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 22:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3583221FB1;
	Fri, 18 Jul 2025 22:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmYrqANc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7A717CA17
	for <bpf@vger.kernel.org>; Fri, 18 Jul 2025 22:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752877278; cv=none; b=acI1p++RibqEIa+AZHtNY1bXkSCd1Kt6E3l4AOGjIXQETb/wxXqltQX3DULaGSMQns/8q+0F/AUuKNmU9QdChCq3c8Xkh1vglzm8Km0vo2iXGevCpc/4YMKmJZDY7RNAWCAroAdqLBczr5lj05dHWXMcmPtLL+ntfTqdVfhjD7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752877278; c=relaxed/simple;
	bh=VPdJqbO1AYSE07LzNIDhUZJdA1Qn70/hdDdvou59YIE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rC9MgYvkR5TQIXMGqlRbCr9jr/2cy31pmYJZJxJ1C/WVsxPba7uALO/kVevdRI9O1kpv/oVjcvgxNG4lX/609A39tc+/krZqKzaoE/4esGV6LLDDbDs8Ebk2DqSLCEccrAV0coeK8+XLf/NZ7aKq+T26CRUWo6u40cuXl0lYw1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kmYrqANc; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-31c4a546cc2so2245139a91.2
        for <bpf@vger.kernel.org>; Fri, 18 Jul 2025 15:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752877275; x=1753482075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dbyQjnYLJ0vAdNwCnBzhMbv8HG1Kaesu8QuQ/jKmMz8=;
        b=kmYrqANcEcvjX7IgdhslJ2tuNzLHN7GpEDl5D0nk7rCtduCL5aHJb5SMEA16mXqAxE
         nHLE02oOCb4OqYr09RaIm6s3OvpaPc0XONhpp9j5GnhFe3KpC3p1RSWTEAPcIbR+QCrG
         fMOROEeRkRs1tNc3Xan88Q8GeboXh3RBgALaPe/BxLTXQENF6ATwbfUCDSLQ1/ZbFm9A
         t869C3NmINnLxf74NZ9gYBbNaeEhYqJIwdgakeywXM+roBrHXjhXjz+ky88Drb3yGSBZ
         PUR7ZhKKg6QGqSBqiMvjj3h1d8DcpLgvTgYG6I85zYc5RA2qX4DXG8LUK2FYXoJ8LEbt
         XIBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752877275; x=1753482075;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dbyQjnYLJ0vAdNwCnBzhMbv8HG1Kaesu8QuQ/jKmMz8=;
        b=mmW7WGRjHfKk53iFwvDpgbmxAXqqVs4JcTXSrrorrXLEm51o9eQpVhIRQf1H/BAq23
         +QtLMIfiR/jAcZJewRPMqimmSm9MuL5yZsgCr3jjFL10Fqr2cKPzxu/iiNoF2Qg5b46e
         VC9DAsLxI+jCnvpuRVU/KFfm08yqXiFFy+zEfOEnZHldndKJmNlnikoiVhlzwIiugKXm
         DKDAgw97l4JhbYq4dhQyt26eEQ7tWlGgynRgKNFBCJlYeYHRUovp0KhxmPgjEvg9XA+0
         CZQ22MzWRcNkeoAnMLg+bC8Mu28DE1KmrYa3kAajN0RGxGwJlIEzanPr9+BwjtMSmNWq
         2JtA==
X-Gm-Message-State: AOJu0Yx6r+y4i94KWx/xucQ6XiF1J2MtdGfdPBiAgrMIzpByHIukNzuH
	X7hvCmYrUUjxI9+bs4o3os0DcIz7nSPi/Mgx72iA9uY7y2YhCJgntXZ8qzbSwA==
X-Gm-Gg: ASbGnctNXm3fWdy8kfyZ35DTNMe5vUz97dXFGRm0IrMWIbzUuNS2Uk037jVKgQ+00wX
	fVpNaGG6wbeGviB/i9gSjlApej+KjonDuX7R8irwpuxcpmdW2y7wZWOWpJwoVtsu921XFzuwjYk
	7qqbrfftfRqGU5pR9NYd3+9KtjgvCSwqAy7oL0cQIrNcafeyTZxi0fNkc6VQYA/pW87jBcHAC0n
	Pg2BYa09QZPludVmbiYp7GSq2nHf7eAc/D+cRzUiEq3WsQX3zIbQmhx87PfnFQv1MYjmmHrkkdZ
	QOOSLe51cEa1gTuQJqZb1k868Rnw6IT5+RMsxfLcvmGG8h4DNDqneg+W0mURGDYDjhWNBltCvEQ
	G5a+kmmuam+U/6csQnAnfzUonO34K
X-Google-Smtp-Source: AGHT+IEy8tvQVW5jYluHbZ34pCVFS9IO7JZPWkfa9eSIQygAGPAuUR4nWOpE14yxhDOfjDBGqhYUMQ==
X-Received: by 2002:a17:90b:3c10:b0:311:ff02:3fcc with SMTP id 98e67ed59e1d1-31c9f44bcd8mr18784699a91.14.1752877275084;
        Fri, 18 Jul 2025 15:21:15 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6ef82esm18327405ad.209.2025.07.18.15.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 15:21:14 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1] libbpf: verify that arena map exists when adding arena relocations
Date: Fri, 18 Jul 2025 15:20:59 -0700
Message-ID: <20250718222059.281526-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fuzzer reported a memory access error in bpf_program__record_reloc()
that happens when:
- ".addr_space.1" section exists
- there is a relocation referencing this section
- there are no arena maps defined in BTF.

Sanity checks for maps existence are already present in
bpf_program__record_reloc(), hence this commit adds another one.

[1] https://github.com/libbpf/libbpf/actions/runs/16375110681/job/46272998064

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/lib/bpf/libbpf.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 162ebd16a59f..e067cb5776bd 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4582,6 +4582,11 @@ static int bpf_program__record_reloc(struct bpf_program *prog,
 
 	/* arena data relocation */
 	if (shdr_idx == obj->efile.arena_data_shndx) {
+		if (obj->arena_map_idx < 0) {
+			pr_warn("prog '%s': bad arena data relocation at insn %u, no arena maps defined\n",
+				prog->name, insn_idx);
+			return -LIBBPF_ERRNO__RELOC;
+		}
 		reloc_desc->type = RELO_DATA;
 		reloc_desc->insn_idx = insn_idx;
 		reloc_desc->map_idx = obj->arena_map_idx;
-- 
2.49.0


