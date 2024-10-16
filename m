Return-Path: <bpf+bounces-42254-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 229D19A1640
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 01:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB651281845
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 23:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3EDC1D54C7;
	Wed, 16 Oct 2024 23:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="HL6QFwxx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59591D435E
	for <bpf@vger.kernel.org>; Wed, 16 Oct 2024 23:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729122550; cv=none; b=ncNodW5EnztdpmJbE2ZZAEXU0nnQAFGv3yhMkId5loBZECvAxrpSlEs44NeUV38GJ/f4SxoktFULb+FLTOM23XMlq53U+PxytfJStc6pfgrOIk4xbtfI/3gIrI4BwfvNAc6bkr42jyKukEtVQ4sRYO0aj594bvs5urN/bxP6DZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729122550; c=relaxed/simple;
	bh=PR+aKUdK2MTINgk6+opf8IZbJz5a8pQyoFLmvPJY3bk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XUjdQ4DUKk/RWASu2Zj8JTY5K6kYzNQci2LQEIg4ImC5e4GK/4PJs0dduCdkcvegM+et9aE9wRgsXkJDK0D8aYvnzCbjLMzbng5UPInO3GoySayGz/Q94vB6wKAcKKSrt2XQOwjqot88hy0ZuTOaNUSznP2HIUyviO4dWd7Bw2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=HL6QFwxx; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6c5ab2de184so2202116d6.0
        for <bpf@vger.kernel.org>; Wed, 16 Oct 2024 16:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729122547; x=1729727347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NCRtQR1+123wT2ARm1mNeuuw+UdlxVgapvwfoWgQoVI=;
        b=HL6QFwxxwAULDVcbaYryCFjKQzwTbUq1InjENdBAJhERTfBruOcmbu6E599JijKc1K
         Yb8C/hOb5rLT64HzdX0cG3TOtDn1Q78kkZ71olaqh4s5+7YnIjNmSU4SGuaSL8yQXs+Q
         fV0Fl4Zaf9YnTbVq8Wb+bo0fV/SQx8aeEeQRT6Qli36EQNmf1H96L1uYIDWz9d6LYICd
         KgeZ6rFyxWikb22g4RS/lwJ967uV7zVWznS6yzTm9FiMfkdUijnZD4M6OQQ3mC/oqxzV
         SW34pFxbAf+von/YV+rs8YV1yLWuH0gN/P61mvMcGvWFVylQ8VAxo0UQEwar3AWeoPye
         HSiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729122547; x=1729727347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NCRtQR1+123wT2ARm1mNeuuw+UdlxVgapvwfoWgQoVI=;
        b=r2ZgDUdWzvTV6PRd0QFPygPnh1TLxz1esXi5InGtfkla6VJqLACPLJpdLWbMfD2r+p
         VXDBEoVtaqotyrxnXuM2hb/IFoqb+23Ro7dn410lhSQ7OWmD/hI3R49lN7WzNChNbiBG
         P08UDYginhqlYd+LQX4T7bNsvVq18xKfIR3wy9MmSt6DbnYUPl6VSD3GSgCE/uK8G3+1
         lpppaMbKDyenJQA0wZzOJSwQCp5e2Uem+KT+wk+n9xQfP/IAhL6tbFDFp4cx+HqH360W
         VYHDOACtRvtS9CftZBYkVJ5AlCWIJ7vwKCyl5qvByUHgiJQuVViMskO/9vuYlM3qAmkq
         brDA==
X-Gm-Message-State: AOJu0YzkPj84qLOLBl52TJCvjrF8ylPgkzpQXcDiSSyalhPluAFPnof+
	1Co3QzW2cLcAwj8ij7QVcbkVpC0ufn4mCSyCmu3Om10G0+XYSzgkBYqb14tNj90A4XFMdNw9asJ
	d
X-Google-Smtp-Source: AGHT+IEpF+bGs1Bs9eaT6NMAg2QOgGgLk66eV7amC7qadAlZjb4fFtlGvfKiHO8InkAMNZh22CQdvQ==
X-Received: by 2002:a05:6214:5b87:b0:6cb:ce17:e80d with SMTP id 6a1803df08f44-6cbf00746ecmr291311616d6.18.1729122547459;
        Wed, 16 Oct 2024 16:49:07 -0700 (PDT)
Received: from n191-036-066.byted.org ([139.177.233.237])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cc22959ae2sm22909296d6.93.2024.10.16.16.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 16:49:06 -0700 (PDT)
From: zijianzhang@bytedance.com
To: bpf@vger.kernel.org
Cc: edumazet@google.com,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	wangyufen@huawei.com,
	xiyou.wangcong@gmail.com,
	zijianzhang@bytedance.com
Subject: [PATCH bpf 1/2] selftests/bpf: Add apply_bytes test to test_txmsg_redir_wait_sndmem in test_sockmap
Date: Wed, 16 Oct 2024 23:48:37 +0000
Message-Id: <20241016234838.3167769-2-zijianzhang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241016234838.3167769-1-zijianzhang@bytedance.com>
References: <20241016234838.3167769-1-zijianzhang@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zijian Zhang <zijianzhang@bytedance.com>

Add this to more comprehensively test the socket memory accounting logic
in the __SK_REDIRECT and __SK_DROP cases of tcp_bpf_sendmsg. We don't have
test when apply_bytes are not zero in test_txmsg_redir_wait_sndmem.
test_send_large has opt->rate=2, it will invoke sendmsg two times.
Specifically, the first sendmsg will trigger the case where the ret value
of tcp_bpf_sendmsg_redir is less than 0; while the second sendmsg happens
after the 3 seconds timeout, and it will trigger __SK_DROP because socket
c2 has been removed from the sockmap/hash.

Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
---
 tools/testing/selftests/bpf/test_sockmap.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index 3e02d7267de8..446f7cca56dc 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -1485,8 +1485,12 @@ static void test_txmsg_redir(int cgrp, struct sockmap_options *opt)
 
 static void test_txmsg_redir_wait_sndmem(int cgrp, struct sockmap_options *opt)
 {
-	txmsg_redir = 1;
 	opt->tx_wait_mem = true;
+	txmsg_redir = 1;
+	test_send_large(opt, cgrp);
+
+	txmsg_redir = 1;
+	txmsg_apply = 4097;
 	test_send_large(opt, cgrp);
 	opt->tx_wait_mem = false;
 }
-- 
2.20.1


