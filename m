Return-Path: <bpf+bounces-51263-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1582BA329FE
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 16:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46E3B16253B
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 15:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4937121C19A;
	Wed, 12 Feb 2025 15:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HU7d0V3g"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6176C21480C;
	Wed, 12 Feb 2025 15:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739374110; cv=none; b=Un8HxbPWuY5HybfLYHXDzXO/iHfg1Dan/T7CpBnVS+8MYgWZxTbZwXggMzOKRP+uVbxiRjFfaCh0hXGi6z2Nd7nmLvTDGpceJ6tmpVaIKg461oJ3ORogu19uk6pAhMiCkONwzek3jTeh7aJBID1Hk/PfNtoLrflThgf1s4b6Tm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739374110; c=relaxed/simple;
	bh=GXHrpcBGYYSxfi1bUkNZ3mqnK2UL/YlYnu1roKqXTXE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=tbagEe/gLiXCxSF0CdEOhS+qFIwUNSAfX7M2dDFFr2OT9oxkd7w/8w7uaxYPYSRl6C1xxIK0L5ICSrNAhFHxOMlo92ho2GNN2sEf/+xnP3k3F2LgUSozXS8uJwH8eFXawuZkMcSVhnM4ErGGyflTrj8dDUOvP5gZ6E4YwTdFhIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HU7d0V3g; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2fa8ac56891so5047673a91.2;
        Wed, 12 Feb 2025 07:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739374108; x=1739978908; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oZRBusg5nwul/y+QfaedcB8PtE5Z6y1mNX2a6kofVKs=;
        b=HU7d0V3g1NNNPtWSS51/6jVvvhAbVPNk3YbgqWiYxGBmPUd+Zl6KeWOI2DcOzRplMP
         A6yQLk+ZFl4zG4eL5TqtPX4UT5xeCcjpy/bViMPSFEMC5/7CT3qnYMPR2B9YCBg4B1Zc
         8Wwcg4G3klzv++4bWbdIpKEZ14w4ypxbPNEFowlassrzbc8455lTIpEcDBl+5PGf+LRf
         q7EGQBdojgFtldEyJv3J2zfXfKUCTne9NPENjDgB/Q5wbZHOgU8rYYcHrYhIMAg1v9Nh
         vzLcI4kuO+WsE8ZAtFXao9+5BhwUef7WDgpxGYfyGc4V1XkwcL17HTjz6Csen1WagzfW
         e3Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739374108; x=1739978908;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oZRBusg5nwul/y+QfaedcB8PtE5Z6y1mNX2a6kofVKs=;
        b=O1a5nRI2C+F3TPzAu6bqE3aEY0R50eHpWX19GBaAna9Pa0ErINczaWtBcQ3soFwCH6
         1Ur7Cu8Lao4FRZ6sH8EfKz5J+5BJQv6uuFrQeKoYurx1wvHOhDkoYmEqg/kEJOBTfYK6
         k+9lAMQaPeuicvQaJkwqsbEI7OwzIgN/hCzcCw2SnN0C1O4HpwQS15KSojoMrAJ/cBB/
         gm5fGWx2j2hyFfGpIBK947A4ERxC8aq4i2pVcA0qP7/497hy+BTyhmKdTAkBtWl0/rUZ
         l12envWdgMuUpvtb7W1plpYqI+Iiq13SiyobqcNBwVvsQ3XqQAx96FIGiqAXSj+Y11fA
         UIgA==
X-Forwarded-Encrypted: i=1; AJvYcCVnpDvoKF0jvYduBmTSqk1LnP/SNuqWCsfKMFn9pUH3ZXWlDiAqVl85kNVSTEvA65WL6Td96Ny2rOGzyyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwUgChHKMtXzqYV4kgl635fspcux2sM54nvsc1JLO5gmcgCrJL
	t4HxW1m2NSqlOIEA7XDAVbhski12korCPov44FI6vG4+/Y3CFHIB
X-Gm-Gg: ASbGnct+6moRAaIwOXrekYqP83w9Gl71et0A8/2BWjakYyL9v2mYFY6FcjfvnoOsUPH
	+A62kfElVLsxj8VdehDWHU2ixo8a3rmFRNeKlYIf4mRi4JVBmXrfTbArxd6Ii5ib22WK8PAB7/O
	demZzVSLik79U1iN9mL5N/vCTGT8le4XfvUNHSx3mu+VUWeDKOLIgZClHothdgXN4aKG6C5ibSD
	UMxqjNR0Mc3+Ul6BmC+LsWkfQcdObULaHl9KgEpznhZ20Msa2OorbQn1gAVHEPLHDAMcuEF0RI5
	5N6K2hdB3LMSI/Pa
X-Google-Smtp-Source: AGHT+IHV2VCsmSW2Vya40DeA/6X3s5Jh2PwDfpve7vkbYj+GlAzNknA9Z1XM8L1fdpQdJG7j1fflEA==
X-Received: by 2002:a17:90b:5203:b0:2ee:f22a:61dd with SMTP id 98e67ed59e1d1-2fbf5c6ac86mr5031836a91.32.1739374108479;
        Wed, 12 Feb 2025 07:28:28 -0800 (PST)
Received: from localhost ([111.229.209.227])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf98b7b20sm1766627a91.17.2025.02.12.07.28.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Feb 2025 07:28:28 -0800 (PST)
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
Subject: [PATCH bpf-next v7 2/4] libbpf: Init fd_array when prog probe load
Date: Wed, 12 Feb 2025 23:28:14 +0800
Message-Id: <20250212152816.18836-3-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250212152816.18836-1-chen.dylane@gmail.com>
References: <20250212152816.18836-1-chen.dylane@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

fd_array used to store module btf fd, which will
be used for kfunc probe in module btf.

Cc: Tao Chen <dylane.chen@didiglobal.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Tao Chen <chen.dylane@gmail.com>
---
 tools/lib/bpf/libbpf_probes.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index a48a557314f6..de2b1205b436 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -102,12 +102,13 @@ __u32 get_kernel_version(void)
 
 static int probe_prog_load(enum bpf_prog_type prog_type,
 			   const struct bpf_insn *insns, size_t insns_cnt,
-			   char *log_buf, size_t log_buf_sz)
+			   int *fd_array, char *log_buf, size_t log_buf_sz)
 {
 	LIBBPF_OPTS(bpf_prog_load_opts, opts,
 		.log_buf = log_buf,
 		.log_size = log_buf_sz,
 		.log_level = log_buf ? 1 : 0,
+		.fd_array = fd_array,
 	);
 	int fd, err, exp_err = 0;
 	const char *exp_msg = NULL;
@@ -214,7 +215,7 @@ int libbpf_probe_bpf_prog_type(enum bpf_prog_type prog_type, const void *opts)
 	if (opts)
 		return libbpf_err(-EINVAL);
 
-	ret = probe_prog_load(prog_type, insns, insn_cnt, NULL, 0);
+	ret = probe_prog_load(prog_type, insns, insn_cnt, NULL, NULL, 0);
 	return libbpf_err(ret);
 }
 
@@ -448,7 +449,7 @@ int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type, enum bpf_func_id helpe
 		return libbpf_err(-EOPNOTSUPP);
 
 	buf[0] = '\0';
-	ret = probe_prog_load(prog_type, insns, insn_cnt, buf, sizeof(buf));
+	ret = probe_prog_load(prog_type, insns, insn_cnt, NULL, buf, sizeof(buf));
 	if (ret < 0)
 		return libbpf_err(ret);
 
-- 
2.43.0


