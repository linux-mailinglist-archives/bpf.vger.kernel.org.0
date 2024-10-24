Return-Path: <bpf+bounces-43097-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D616B9AF3A8
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 22:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 658D41F21F2F
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 20:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C816D2170BA;
	Thu, 24 Oct 2024 20:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="LHVDrxn2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7643B1AF0BF
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 20:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729801785; cv=none; b=KOOZ8pZIVLQ3em6fd7Y6LoUH/piHT47e619Kds+ydZhb209iXtARsRf1L1xdOkzi4IhKrS2NFGLP5DW96QM9PcS9awJuKVUurj5kg/CcVUdAksi89tztRWMANwzvPPH4v1o6zZvexkjIAZvsprIE2hwVNjdxSFtaCB2ONRkG5uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729801785; c=relaxed/simple;
	bh=DWOwti3vm2u8IiCa72HOjYzsSxbb+cx9lsbchIICfoE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kwzRmL2uOwNuQnrrxIPVzHJgiAe5Uh2mf49xbXHI1LPxRAE6Y/wBWQjt3W59/ESThjL8mloMwUH4oojahGCSyPCkLRA/KUc7m4bzQlrqK2EMvHa+W7eeVJNe4Ed9btFfGd4S/kft2FqxPVuwMUEoCV6AkvuKmC802x4hJI/yq6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=LHVDrxn2; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4609d75e2f8so21150821cf.1
        for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 13:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729801782; x=1730406582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TCg7gaVwcg2dVZWa8iWS8H1cWuO7lQC9V7PJRVhPL+k=;
        b=LHVDrxn2/vtkbDEALu6OBbkDu8eq7/KSbBoeBS/7x18PbfVPrtibcmzd9F5IWEtBZJ
         aKAcCg+OTRkinB5uljM3t5ZaDVVFneLhDzKty1lAPZavzujfai+t5wITYqcT3wcnz4Nj
         t2uQK8ByJe4Ck7fc1+7ZtdgyPbG1hCL6hVBEchgYe5gFLnUUlAXCdWzK1+3tvpNb82t0
         f/qUnuGML1IOK9w9Z2gOA/NKXORANcG5i4T+iZHwNd0VAqZ4YIsvNhvzy7YuqABR/lIL
         Y2MixCikUtC9fiO8eaHgA1oQk4xO9i6vBTcGdHc/85rZP0aYp9+wFvE2z901M4Qf28jf
         VGXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729801782; x=1730406582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TCg7gaVwcg2dVZWa8iWS8H1cWuO7lQC9V7PJRVhPL+k=;
        b=T81dPWTXBhMPBJRg6JDvDU2ATCEXx6T3fDnxg4DVcQXwuqCMRODAlVXD5q0zUuzH/n
         qbeoqYJ+Wp7r/QrjRoafL3KygSSpmZVqt8lWdclnYN57xLJEYZMNCyHSkq05WLYvrQVl
         HhXqdNLYK6tear0KQ8Jzxw6f+O5aZoO05YQDih/yxABDBTLQhMXgJOEG1dHbzoafeP3f
         uxisMt07FAVMLD+raqhqd/zIesN6jHNvTuEo0Z4JyYEPEO0wInn+/yjRHUvtX54VyApA
         iTyiP03G+1uZnJE9sxuHbWa59M7KjtIhdjaQ8JVMQlUoKsm9LxsGRcYFKuj6pt/IKpcC
         d+uw==
X-Gm-Message-State: AOJu0YwoCSo7IXkLd+NjuPa3OaxAwaiztCdp8r5/JHW92NawAcjqiqg7
	dgO14Hk9FthH+GuLqkdFUdkB7VPJh5Tv2o3pTzX3K/c+P/nAX2vpnd55S8iM8oSgzBXRrlo7G3c
	9
X-Google-Smtp-Source: AGHT+IHm7q96jprVuce6iQHEO/Ikwa2YD01YgvCBtq/vg9Vl9St+zVIsTguouLzWY1OClbC5ABwwnA==
X-Received: by 2002:ac8:5907:0:b0:451:b77e:a8c1 with SMTP id d75a77b69052e-4612525b39emr54201131cf.3.1729801781984;
        Thu, 24 Oct 2024 13:29:41 -0700 (PDT)
Received: from n191-036-066.byted.org ([130.44.215.80])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460d3cbb3c3sm55486081cf.52.2024.10.24.13.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 13:29:41 -0700 (PDT)
From: zijianzhang@bytedance.com
To: bpf@vger.kernel.org
Cc: martin.lau@linux.dev,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mykolal@fb.com,
	shuah@kernel.org,
	jakub@cloudflare.com,
	liujian56@huawei.com,
	zijianzhang@bytedance.com,
	cong.wang@bytedance.com
Subject: [PATCH v2 bpf-next 5/8] selftests/bpf: Add more tests for test_txmsg_push_pop in test_sockmap
Date: Thu, 24 Oct 2024 20:29:14 +0000
Message-Id: <20241024202917.3443231-6-zijianzhang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241024202917.3443231-1-zijianzhang@bytedance.com>
References: <20241024202917.3443231-1-zijianzhang@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zijian Zhang <zijianzhang@bytedance.com>

Add more tests for test_txmsg_push_pop in test_sockmap for better coverage

Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
---
 tools/testing/selftests/bpf/test_sockmap.c | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index 61a747afcd05..e5c7ecbe57e3 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -1795,12 +1795,49 @@ static void test_txmsg_push(int cgrp, struct sockmap_options *opt)
 
 static void test_txmsg_push_pop(int cgrp, struct sockmap_options *opt)
 {
+	/* Test push/pop range overlapping */
 	txmsg_pass = 1;
 	txmsg_start_push = 1;
 	txmsg_end_push = 10;
 	txmsg_start_pop = 5;
 	txmsg_pop = 4;
 	test_send_large(opt, cgrp);
+
+	txmsg_pass = 1;
+	txmsg_start_push = 1;
+	txmsg_end_push = 10;
+	txmsg_start_pop = 5;
+	txmsg_pop = 16;
+	test_send_large(opt, cgrp);
+
+	txmsg_pass = 1;
+	txmsg_start_push = 5;
+	txmsg_end_push = 4;
+	txmsg_start_pop = 1;
+	txmsg_pop = 10;
+	test_send_large(opt, cgrp);
+
+	txmsg_pass = 1;
+	txmsg_start_push = 5;
+	txmsg_end_push = 16;
+	txmsg_start_pop = 1;
+	txmsg_pop = 10;
+	test_send_large(opt, cgrp);
+
+	/* Test push/pop range non-overlapping */
+	txmsg_pass = 1;
+	txmsg_start_push = 1;
+	txmsg_end_push = 10;
+	txmsg_start_pop = 16;
+	txmsg_pop = 4;
+	test_send_large(opt, cgrp);
+
+	txmsg_pass = 1;
+	txmsg_start_push = 16;
+	txmsg_end_push = 10;
+	txmsg_start_pop = 5;
+	txmsg_pop = 4;
+	test_send_large(opt, cgrp);
 }
 
 static void test_txmsg_apply(int cgrp, struct sockmap_options *opt)
-- 
2.20.1


