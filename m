Return-Path: <bpf+bounces-30545-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A78B38CEC6F
	for <lists+bpf@lfdr.de>; Sat, 25 May 2024 00:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1C621C209F4
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 22:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493E712837C;
	Fri, 24 May 2024 22:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWZ9aQuK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDAE128808
	for <bpf@vger.kernel.org>; Fri, 24 May 2024 22:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716589851; cv=none; b=rlJPQFqcbX2sv5tM9uJVjg+37x6u871fjxH3DMvJFG2aAOf8R4DjmGbqXMl/KsEYl/ga4FLmnzw5vzogg+M3SMBn4BqhuTldN9nJEHzxUOKfAHCny9z4GPPNfDna53T7KnXPNHQpnLJzgPgEeLaZ+n28vwFqPc8sNcoEFA1M4jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716589851; c=relaxed/simple;
	bh=EG5Ebj9lpmdl+7pnmhFq0IBANIQ2FH4ulS7Se5ZXRTE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b5XGbWVmA/q+IJFENwo8WZ2TsDMaGFCPWy4BtJiJStVIPaTDBhtU/pnJym5H4BKsmvn54ovCn2tE3bbtEvVAA89HUR1KPLIYfUd9aV662gSP9x3cMGMd+EwKfg/QmbTtaH/Zz1V8aMKR0BYAYBr82N+cmDzR6d4HemS7rqCoTa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BWZ9aQuK; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-627f46fbe14so32666387b3.2
        for <bpf@vger.kernel.org>; Fri, 24 May 2024 15:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716589849; x=1717194649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j/z09TdUY2NxiMoECTkZ6AWPRP0HpyoEfvAwYbCuC2o=;
        b=BWZ9aQuKvfjgPxpAE39GqLQpMRTdv5QE4zwuVm8pJEtDpFSnX3krgiYFax7eap3Om6
         bZazZCJGnmBx1ZbjEW/PJTM3uw2q8Kva8qmgtlCl8AGhir7drnsTejNkRk49ZayXYuqo
         d4qvr4/pQ0Uyy72Wx8iP0+m8tvdTVttBK8CJaIntdhY667ZRURycevw3kKs/O6exGyFR
         jfjmRZ2OsK8F1Du0bwqFB4PNwyB6jqa77lzv69Lk5jkODiPaV/QcF65zEwHvusgVR8L4
         s+2GqYoiLCWwC8IhKKZYkQzoWSeOQUurbkVbLQuEILBfec0ZLpA11RLAqrFgztNJpox7
         Uurw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716589849; x=1717194649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j/z09TdUY2NxiMoECTkZ6AWPRP0HpyoEfvAwYbCuC2o=;
        b=wfs1D/zS78f9T+DIiBwYItg/v5N88RnrYnaY7A8sDeUizXvjQZge5qjAZn3MeyOL9e
         SPn1dtMf00cKxzUEJ5aRuwERDz0LYc8DB4m1Y7j4/O92CmyW0mpLaIhbqZS5epV1wiHS
         MruonkU6K1YzwfEx4MFGYofDbbhbTI+y5u4YCMjb+j97lU+vYxXLfchIGHCtgMfT1Iga
         5RJAVN9fSwB3XwXZCnG+maw1XV072sepuAq0isXVj9cIuOsoOEA7nCACRgsxLvhZ//x0
         TEVV7hQADbsdViW7v8Bn3nXVmWRKHUJ5nSwcXBox9qTqKHVKG/v+lEpwDzHdKQ9NIgdj
         x1JA==
X-Gm-Message-State: AOJu0Yys8YS2zwNiA99aQyLdZngFVZH0rPMNa/9QBBoxlvQw7so8aoWv
	3s/hfnVIpfn7xxFqLIMbJ8Gh4JD21OSnsPWuHNFlY3bhpHC836lQZ+ij1Q==
X-Google-Smtp-Source: AGHT+IF4gN1hAcJOcRU2C8cxPaIARkAWws1CTF8cgfHSKRBv27814IIHe9u/lXAQuDDGPBiuzMMdbA==
X-Received: by 2002:a0d:e20e:0:b0:61b:3304:b702 with SMTP id 00721157ae682-62a08d744c7mr34319217b3.5.1716589849217;
        Fri, 24 May 2024 15:30:49 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:6aeb:e91b:f49d:e77d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-62a0a3bfa19sm4169987b3.44.2024.05.24.15.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 15:30:48 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>,
	Quentin Monnet <qmo@kernel.org>
Subject: [PATCH bpf-next v6 8/8] bpftool: Change pid_iter.bpf.c to comply with the change of bpf_link_fops.
Date: Fri, 24 May 2024 15:30:36 -0700
Message-Id: <20240524223036.318800-9-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240524223036.318800-1-thinker.li@gmail.com>
References: <20240524223036.318800-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To support epoll, a new instance of file_operations, bpf_link_fops_poll,
has been added for links that support epoll. The pid_iter.bpf.c checks
f_ops for links and other BPF objects. The check should fail for struct_ops
links without this patch.

Acked-by: Quentin Monnet <qmo@kernel.org>
Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 tools/bpf/bpftool/skeleton/pid_iter.bpf.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/skeleton/pid_iter.bpf.c b/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
index 7bdbcac3cf62..948dde25034e 100644
--- a/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
+++ b/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
@@ -29,6 +29,7 @@ enum bpf_link_type___local {
 };
 
 extern const void bpf_link_fops __ksym;
+extern const void bpf_link_fops_poll __ksym __weak;
 extern const void bpf_map_fops __ksym;
 extern const void bpf_prog_fops __ksym;
 extern const void btf_fops __ksym;
@@ -84,7 +85,11 @@ int iter(struct bpf_iter__task_file *ctx)
 		fops = &btf_fops;
 		break;
 	case BPF_OBJ_LINK:
-		fops = &bpf_link_fops;
+		if (&bpf_link_fops_poll &&
+		    file->f_op == &bpf_link_fops_poll)
+			fops = &bpf_link_fops_poll;
+		else
+			fops = &bpf_link_fops;
 		break;
 	default:
 		return 0;
-- 
2.34.1


