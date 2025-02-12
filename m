Return-Path: <bpf+bounces-51268-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C684EA32A48
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 16:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08A2118892AA
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 15:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484882309AD;
	Wed, 12 Feb 2025 15:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2taCkdN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C9921D5B8;
	Wed, 12 Feb 2025 15:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739374764; cv=none; b=CGdaDlX8k4ihkgNI7mBv4nw4nOtGXXiVA2Kuwb9FuwSiI4yG1Hg1e5Pt8RgEJmC1DVAU+AurqndDvx1JPNi2J+eQFW8RZkjlVAIma0Ny9I5dmLYY6r5bAj9lUdyLHgIqrEmXUUGIe9ctWDhI0DPCcZkq1PARA4BOOm0qLWMMq28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739374764; c=relaxed/simple;
	bh=GXHrpcBGYYSxfi1bUkNZ3mqnK2UL/YlYnu1roKqXTXE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=WY79DGKioSBU0K1ADJwabQIkgNbWHqAKbXUMAeu1APCoGEMvDiEvK9zNxyTPt/7kymp1T4NBydMHahRw3ldc81kr/u3BowyfeiuAKfFyi9rjwqzyHLuJnOH1N6/I6IGY6KA3HxsFTjtZtPgp7UNOMC3Xi82BV2a6/okR+7OnDVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2taCkdN; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21f710c17baso80619885ad.1;
        Wed, 12 Feb 2025 07:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739374763; x=1739979563; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oZRBusg5nwul/y+QfaedcB8PtE5Z6y1mNX2a6kofVKs=;
        b=B2taCkdNv4aRofBb9IHSaeCZ7V+bcNLyFa+SjtrdGSJGJKza2wVIIsF2fCELTAnQoK
         x4T2dXD27uWFSolPnKVqmWDgx8X0LmKszDnJWyes3/f+zjW3G2awJr77m5srhkLsiIAc
         TnGsLt+MpAy5dWP7MiqguY5xnASeMG4DL9GVAw4B3VGfxzP/iRm+2iOGs0O4jXVJVNj0
         JLSPI4HsxRB/rT5w81LG6SPS1FiLnIc+6b87+zoZG3aOktK1v0aRYwtCbjA7RSBDZk2Y
         nLjAPGZI36Dsg4ZCnsjc8fY7AIwDbjycKP4kfZ/WYARWUePOE1/FLUpTUh1Ds7YVBCaQ
         rJXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739374763; x=1739979563;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oZRBusg5nwul/y+QfaedcB8PtE5Z6y1mNX2a6kofVKs=;
        b=WMclJSRiIUYO7+RalIQAugplRQIMIyu1vdXW5Scyaqomn6u0P7R/LaRqQznSdPfc1y
         5fT0HsccuAli+QrWQ+auwcGGA36C2qOJG9JOcGoImcb1GTU5gGgIPJlKEZHYkBfF4Zid
         NnCnQgO5XS0OILpdzTkeJ/oWQq5Pf31Yk7yMSRrlMOtqIy9u//yGDGuMfWuS2adGjU5n
         KZusXfAO31bsG9jqDhc4+FQsh02utkCNqLvGyteAmWYhs+g5tUR2pUHTpRwbUkq3O3R/
         0HIpxd+6EKqov1IJQfAH89ziV0jVAbkr5sAmeLSP4a1dXIq+xkV9GDj05lUrBaxkgfv+
         gw5g==
X-Forwarded-Encrypted: i=1; AJvYcCWhDjKbZdvLAT3mNBXOQNY0ed9CYGkrK+mK1TZs+a4eC60Y4IXfSKzXRoKpspF0F6jK3dwN/8J8z12ogGs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy78VV/weRQ+nOQuLLphX3VaK1P5anNZzoIbpuPrd2JwUBt0NBF
	19n0TCCaxBIUpiK3zR4bYKAREapz6IIIgztIBxazzcNT+syW8tDv
X-Gm-Gg: ASbGnctJva5kdanvtwTxLhqwpRQ1XheGDJ2rVqkoCQsbe+kw5lSnaa6TWs5DoSYFmLz
	eOdxdwB28dTbVTOtYyAA4H+NxFSUcPjR/nX7rx5E9C45bt3piYi63pWXFLhRuB5cDeET21KPwY6
	rkQSiqLgRsyjlbL/Koje1qWj9S+SNEOd77JdGTinaBYAwGRkH8Q91LvxcliFjYy/SY3ZfFqItg+
	GJ1yVgmdYzDwhAt+vXXuuEnzSCe209exO8KXf15t0ZPJCHe42Rb16/yKnZ1xFnkXdwfmf+EqCg5
	UYkOf3ss/5VgySBZ
X-Google-Smtp-Source: AGHT+IGQQygn0sLV7qUUdfQxa0rYU6E4QUz0AHC7+S8ReH/EIl2xHTpDARhV/t0j95W601woZhIhyQ==
X-Received: by 2002:a17:903:298c:b0:215:7dbf:f3de with SMTP id d9443c01a7336-220bbb11bc1mr67607785ad.28.1739374762517;
        Wed, 12 Feb 2025 07:39:22 -0800 (PST)
Received: from localhost ([111.229.209.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f368da60bsm114756125ad.258.2025.02.12.07.39.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Feb 2025 07:39:22 -0800 (PST)
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
Date: Wed, 12 Feb 2025 23:39:10 +0800
Message-Id: <20250212153912.24116-3-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250212153912.24116-1-chen.dylane@gmail.com>
References: <20250212153912.24116-1-chen.dylane@gmail.com>
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


