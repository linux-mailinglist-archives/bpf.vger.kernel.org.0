Return-Path: <bpf+bounces-22750-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDF286857F
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 02:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C6001F23915
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 01:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8884A29;
	Tue, 27 Feb 2024 01:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+IhnM50"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2985468E
	for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 01:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708995882; cv=none; b=Kd9jS9Qeh3kWtkwv8e9fng15hBCCpS0k24/NwOH6+rMoZWKBdH8yrC7VIHLj+Gb3LnRHnWNmU0XtHeI2x/SLxcoU9EJ9B4gY0DP9MvTTELKRu0ic2jBOCcCdspS5E7T+kUVYRCWcNaiYlK3iKBjAWTSZuSCSReRLEhwxJ3PuWaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708995882; c=relaxed/simple;
	bh=+6l0lQnY8omCUzf5OMwxqoI00375s+66fvfjQbAR6LE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l2t2C5pRZaPkvGtjzV05bXhiege1zznpGwd/KIPfHfmu1XuFJaU1TuRc02xUMWHYb2+R5NcAgRCzKT7nxObjDOGvehoBaF+wiSLgR6+LcU9f9/x9pIOdr90zivNXgqjiA3rEN927IrvBCpU4zDw7JCSD2cHDrttEKrbev9G96/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+IhnM50; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-608e3530941so21838347b3.1
        for <bpf@vger.kernel.org>; Mon, 26 Feb 2024 17:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708995879; x=1709600679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IXlFc5ZBorhTOulkewfZwF8BMlwYQd7ekIX0pYnvaM8=;
        b=G+IhnM50MFRxhMavYAE60QSdf8HNpIToydxf4EMs47bmBiksn4iDxc3x50SzKj9i0P
         YcAI7C7m/4Be1Yo6UHG0mudblj0Oh8FHvKRvqn3zq1x18VFpkvwSftSCFqMzEPuo0WpK
         YdAVwwH+pWaE2mdvhXm1seTX31vA83Y4KPZ5viC/287LEc1Y4pS1l+D2NdXO1QCFd6gp
         xhBkW/XQNaN/POwE0PsLn8J9uWrnmEBhKIMXX8WQvuGhQalvTIZE56tgbsjb+1mIyed+
         H20WoCNve1TnBQFjBtvS5cEhr+P1YDvamy+5Ey4BzwUHyIyrCPl52KcQewxnG9PWVV91
         yMcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708995879; x=1709600679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IXlFc5ZBorhTOulkewfZwF8BMlwYQd7ekIX0pYnvaM8=;
        b=CEXtyL8JkeGIBYh154Js2WvNXxsXYPXnCfMjrPoKyAFuhKAwaoz1FY1Liz/AxCKxuE
         FzeF8wxVFeptK9NBmbKsmQfOSATcVs5rnFPd91BXl4sCyf8NT6+SCqxu+RJjkQ7aYwea
         OPPlXojKfAUjjOrTSZedsOFLFByMhidVW14k9LTaMXW8pYrtUl5zWWp7LXy+eSqCTxub
         cp1QVL2b/0uru6A5F+VU1EnYM62uinG4niWYnTBiBK77J5uv5gil9gLxuzRZcz8GpKin
         KSL54dfoSqJsDSuMb7V7EEVIo+DIW0pv2rxVWGe8gYF2ClB/TUVR9Qm/cQTlku9PwMIy
         57qA==
X-Gm-Message-State: AOJu0YxWPDSCreO1NbhtXNpO7or2JYG94TBsSArJ90kdvdqCS4lsbSnE
	S3GejhspaXEABNh+14Wj+gwKoVLzpuaqcX00p7Quxf1It1Gt0IXH6TbWtgmi
X-Google-Smtp-Source: AGHT+IFpaXha7NmQhaRYgZIyHXcTtSdayEG61fafa/9VG6VksTSTID+cXIHDSoxv6KksFsKbb0CMpg==
X-Received: by 2002:a81:52cc:0:b0:607:74b2:578a with SMTP id g195-20020a8152cc000000b0060774b2578amr846266ywb.6.1708995879273;
        Mon, 26 Feb 2024 17:04:39 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:5f7:55e:ea3a:9865])
        by smtp.gmail.com with ESMTPSA id l141-20020a0de293000000b00607f8df2097sm1458818ywe.104.2024.02.26.17.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 17:04:38 -0800 (PST)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	quentin@isovalent.com
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v5 1/6] libbpf: expose resolve_func_ptr() through libbpf_internal.h.
Date: Mon, 26 Feb 2024 17:04:27 -0800
Message-Id: <20240227010432.714127-2-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227010432.714127-1-thinker.li@gmail.com>
References: <20240227010432.714127-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpftool is going to reuse this helper function to support shadow types of
struct_ops maps.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 tools/lib/bpf/libbpf.c          | 2 +-
 tools/lib/bpf/libbpf_internal.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 01f407591a92..ef8fd20f33ca 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2145,7 +2145,7 @@ skip_mods_and_typedefs(const struct btf *btf, __u32 id, __u32 *res_id)
 	return t;
 }
 
-static const struct btf_type *
+const struct btf_type *
 resolve_func_ptr(const struct btf *btf, __u32 id, __u32 *res_id)
 {
 	const struct btf_type *t;
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index ad936ac5e639..17e6d381da6a 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -234,6 +234,8 @@ struct btf_type;
 struct btf_type *btf_type_by_id(const struct btf *btf, __u32 type_id);
 const char *btf_kind_str(const struct btf_type *t);
 const struct btf_type *skip_mods_and_typedefs(const struct btf *btf, __u32 id, __u32 *res_id);
+/* This function is exposed to bpftool */
+const struct btf_type *resolve_func_ptr(const struct btf *btf, __u32 id, __u32 *res_id);
 
 static inline enum btf_func_linkage btf_func_linkage(const struct btf_type *t)
 {
-- 
2.34.1


