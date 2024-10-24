Return-Path: <bpf+bounces-43093-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 073DC9AF3A4
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 22:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1585282DD2
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 20:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E71200BB6;
	Thu, 24 Oct 2024 20:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="I8PMurbf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6761C16E89B
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 20:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729801777; cv=none; b=oa5UqNsmixtv7XXF0CdiqkPhQsDNfVujFXO0Ww42KT5J8kGLzPv5rg3VHKPEYGFCkkUlrzGwluUcrem+Pk/1ZlqCRgVHhOemheROJvfIXi7qlDakmx7FlUTKiqLJyDDOe1whrNpJjE18eKksg0Es4IFo763iI7QVwX15M6ADzhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729801777; c=relaxed/simple;
	bh=XTpMv+VF8cOdRbUAlZ5ZznC9z7BQObqwvKwaZgZ+cbs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QzJkVXBjQkxJH82XWo1i9s8+r4nJVwz6EXII/HhD8JIBfyVdPHrRDly/zVr7HSgrJnxiN67oTXskV9Q0BZHualL4fSJNVcxP+rba/CCUM8f4zOY3kH+Po4c7GZThWwzdBshG0tctWODwx+fejBs4HGsPRxc6grRMcckGsmk8vKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=I8PMurbf; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-460963d6233so7999681cf.2
        for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 13:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729801774; x=1730406574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sem2IxJaLw9T/IpmjkFV4In0NxMLK+X+ObaA09ucrMY=;
        b=I8PMurbf8dP5882uQOihlAa1thhOdjNWldbGSNSkz55A2wYjalQ6Kmjt/MkPkeXps2
         mMnR74GQFAwm2twRlEhLWcwf3vBAqZUQvowXc0L/WKsyEZ/BDNrnFhxRgFsFCm5R2w5J
         Zd4alYiIo+RGZzeKpDBmP6B/HJpQxLkARlmzBhdVQ1VJ1BLN6AAR9SYnHlgxkMNGSMIg
         E6bxTsXuu9VOeoIgZguKfFiTXMO7FpQbPdGe3jSaDcqpIRsrlc7wimvdgLnuxLn5i5B8
         nE4J8fZVIBGC3RemxjfU7QXKwNz5ce09PAI3uOZ9btvzsxe+WjwLsaaTtPr5qyvVwmMk
         aScQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729801774; x=1730406574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sem2IxJaLw9T/IpmjkFV4In0NxMLK+X+ObaA09ucrMY=;
        b=eiW19xH9SiEa0T9mcwYumRRQtglt92rtIu4uyQon1wD2dtKHhWcjaTTOgSows9zu8N
         YTc/jxpo/vBMoKOy480TlDeOybJLzt3pv0Skk8Q0oHtxTGuq2Ohm6dSExFodLZody+7M
         0YMyhwhXdst77M5K3gCpXCkR2Vd5lWFiCxhim3x/TokYRVg4GvukcXShP2kqyV6cBMD+
         iOWCy6THlJrer16rqU8foOlTQU5WiXP/Aewslut6dhCf+NMHHhE38zd1DmawaZ0b/QMx
         msZajaG4iQeV8CfpEPkWQ8sYzdla3KIcOrdkmbrI7RxC8bhnagqpy+cDMT4NscY1uOf1
         fcVQ==
X-Gm-Message-State: AOJu0YzgvfbpaDSA7/hSSl16JsTx8Vew8pIsU7VVHvaa+b1BBj91ONUa
	2geY4nNPQuv2AyYOkZKa5sfPKDo1gPE3gpVZNPvVVfubkhhVK11+zlIsBnzKGS3knx1OHyGjNPd
	S
X-Google-Smtp-Source: AGHT+IG7sM2s5H4PjfXvlDnpGlW208tF1NvXrbumTC37Dur6ax+0S9fvBoZek74AHshgHtscJ+e5gQ==
X-Received: by 2002:a05:622a:2c3:b0:461:1df4:6b16 with SMTP id d75a77b69052e-4611df471d2mr74646711cf.0.1729801774028;
        Thu, 24 Oct 2024 13:29:34 -0700 (PDT)
Received: from n191-036-066.byted.org ([130.44.215.80])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460d3cbb3c3sm55486081cf.52.2024.10.24.13.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 13:29:32 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next 1/8] selftests/bpf: Add txmsg_pass to pull/push/pop in test_sockmap
Date: Thu, 24 Oct 2024 20:29:10 +0000
Message-Id: <20241024202917.3443231-2-zijianzhang@bytedance.com>
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

Add txmsg_pass to test_txmsg_pull/push/pop. If txmsg_pass is missing,
tx_prog will be NULL, and no program will be attached to the sockmap.
As a result, pull/push/pop are never invoked.

Fixes: 328aa08a081b ("bpf: Selftests, break down test_sockmap into subtests")
Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
---
 tools/testing/selftests/bpf/test_sockmap.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index 075c93ed143e..0f065273fde3 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -1596,11 +1596,13 @@ static void test_txmsg_cork_hangs(int cgrp, struct sockmap_options *opt)
 static void test_txmsg_pull(int cgrp, struct sockmap_options *opt)
 {
 	/* Test basic start/end */
+	txmsg_pass = 1;
 	txmsg_start = 1;
 	txmsg_end = 2;
 	test_send(opt, cgrp);
 
 	/* Test >4k pull */
+	txmsg_pass = 1;
 	txmsg_start = 4096;
 	txmsg_end = 9182;
 	test_send_large(opt, cgrp);
@@ -1629,11 +1631,13 @@ static void test_txmsg_pull(int cgrp, struct sockmap_options *opt)
 static void test_txmsg_pop(int cgrp, struct sockmap_options *opt)
 {
 	/* Test basic pop */
+	txmsg_pass = 1;
 	txmsg_start_pop = 1;
 	txmsg_pop = 2;
 	test_send_many(opt, cgrp);
 
 	/* Test pop with >4k */
+	txmsg_pass = 1;
 	txmsg_start_pop = 4096;
 	txmsg_pop = 4096;
 	test_send_large(opt, cgrp);
@@ -1662,11 +1666,13 @@ static void test_txmsg_pop(int cgrp, struct sockmap_options *opt)
 static void test_txmsg_push(int cgrp, struct sockmap_options *opt)
 {
 	/* Test basic push */
+	txmsg_pass = 1;
 	txmsg_start_push = 1;
 	txmsg_end_push = 1;
 	test_send(opt, cgrp);
 
 	/* Test push 4kB >4k */
+	txmsg_pass = 1;
 	txmsg_start_push = 4096;
 	txmsg_end_push = 4096;
 	test_send_large(opt, cgrp);
@@ -1687,6 +1693,7 @@ static void test_txmsg_push(int cgrp, struct sockmap_options *opt)
 
 static void test_txmsg_push_pop(int cgrp, struct sockmap_options *opt)
 {
+	txmsg_pass = 1;
 	txmsg_start_push = 1;
 	txmsg_end_push = 10;
 	txmsg_start_pop = 5;
-- 
2.20.1


