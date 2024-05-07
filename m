Return-Path: <bpf+bounces-28764-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E70B8BDAEB
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 07:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCC7A1C21B7D
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 05:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AA36F060;
	Tue,  7 May 2024 05:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zk43ki1F"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CD46EB64
	for <bpf@vger.kernel.org>; Tue,  7 May 2024 05:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715061381; cv=none; b=D1jrHJNvthy1WBUc0JuYT1WpUdZLrC3NYNRDVF4rJtqtr+LoS5N8r+KZPRln9XgmIpvrKvir0GJq/mCVk8x5nT+fuL58N7TaTS90VUvlY+MLAumvIEtj+MM6fnHaVY4onMTZZOY/Qcsia42Bzx+Q9a1p8k9ahND14g09GT6jEnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715061381; c=relaxed/simple;
	bh=WfXwWy1Qzg/be4xT68IA/an8B7CbXHK2t5RTqaBtWOU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kCb5PO2PPFnJ6vjyY4AZ8VquSffPWj6eO/1hyoXdxcPVWb+Ae00/sARMkuMRZYjbnC/E5SdVpRrHfxZCj9kmNPQbSBtNUczoksQglXvnNQPhG6s4M+bTJGzOslkLJovPGmNLO67pIjE7WlL3FGa/9xAcZ7DSLaeF5TbkK34u2Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zk43ki1F; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5ac90ad396dso1658652eaf.3
        for <bpf@vger.kernel.org>; Mon, 06 May 2024 22:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715061379; x=1715666179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QkS70W5e30KvFUPoJEEVO+XU2mME9AFDkQqS2+2/LKE=;
        b=Zk43ki1FjMeL76XsvkM09pRC13U8ILpvRkhQLY06ICZle6CmCNYCuMVKdbRb5yzUBF
         Qpcv2CF69aXtxevK78rSFEB8JGKZsdaAtNVdTrF/yfdoa0MUKEd+V9Tb8g6qRG9wj8G7
         nDyfE1DvlFqi0P4lhPQv+yHk23LKG8LF1bJZ1wpXl0QuXWE/5+kPZVNH/ul44VkdeEbk
         S5YbzPIsZ4eqrSJiNDhEocWKy6VRzXvKhFmBgvzNJSRKom9fq5T8q63gEL7X1IE72FqD
         IrxF72ckylDntbXx+II7YMYT5mVp5o+znYUCGwbAjNuOlfK+E9VlduppBBFmJm692PfT
         xvYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715061379; x=1715666179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QkS70W5e30KvFUPoJEEVO+XU2mME9AFDkQqS2+2/LKE=;
        b=u/D6+GQx5q0YLIyN9OhaRlFMo4imw5bzjJQDPQIAyoQ/mQ5762HP8JLrll5fB/EQrb
         iy5cLlveKkX+ELvgCE9IeQzZovQ5BlfJOvyQGlIh+xTdPb4VLbVB2ZXVBIEizbJsr+O8
         Wxj9yIeSSGmFrFKeyLnRpgHQaF5jOQPXDx0t2vZu/crdMgIv+4BhwQkYIhQ+GAQzKrSO
         5FWri1mSbtxLVIhW+YAb4fwYVR+tSrOL1tjYTg78mGmJJTHNHB3WGDIx/ethlbuySDP8
         uqd6a77xpUmTbRZk/+XXa2ukLb9x50bE57ZiZO/simKPD8Sc8czU3+SC4HGhV0fNEoE3
         iIhg==
X-Gm-Message-State: AOJu0YyZe8Ku2nlBqBYZZTi7YLtKNP34GDkfYh320luzWWRDtyb6KvIc
	gZ2G8FIuXT9cT9F0sH8UW2780XLxUkBNALDHkU0V9Utfp74QoKY6BAp/CA==
X-Google-Smtp-Source: AGHT+IF4Zug0XeLJYtkRRmm3QyJBNe2+YD2526xEKLbSXeFQqJrx/W+iQ/pq+OVPTT19JRFKiP1dpg==
X-Received: by 2002:a4a:944:0:b0:5aa:17bf:8e3d with SMTP id 65-20020a4a0944000000b005aa17bf8e3dmr12023463ooa.9.1715061378676;
        Mon, 06 May 2024 22:56:18 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:2e7d:922e:d30d:e503])
        by smtp.gmail.com with ESMTPSA id eo8-20020a0568200f0800b005a586b0906esm2317011oob.26.2024.05.06.22.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 22:56:18 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v2 6/6] selftests/bpf: make sure bpf_testmod handling racing link destroying well.
Date: Mon,  6 May 2024 22:56:00 -0700
Message-Id: <20240507055600.2382627-7-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240507055600.2382627-1-thinker.li@gmail.com>
References: <20240507055600.2382627-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Subsystems that manage struct_ops objects may attempt to detach a link when
the link has been released or is about to be released. The test in
this patch demonstrate to developers the correct way to handle this
situation using a locking mechanism and atomic64_inc_not_zero().

A subsystem must ensure that a link is valid when detaching the link. In
order to achieve that, the subsystem may need to obtain a lock to safeguard
a table that holds the pointer to the link being detached. However, the
subsystem cannot invoke link->ops->detach() while holding the lock because
other tasks may be in the process of unregistering, which could lead to a
deadlock. This is why atomic64_inc_not_zero() is used to maintain the
link's validity. (Refer to bpf_dummy_do_link_detach() in the previous patch
for more details.)

This test make sure the pattern mentioned above work correctly.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 .../bpf/prog_tests/test_struct_ops_module.c   | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
index 9f6657b53a93..1e37037cfd8a 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
@@ -292,6 +292,48 @@ static void test_subsystem_detach(void)
 	struct_ops_detach__destroy(skel);
 }
 
+/* A subsystem detachs a link while the link is going to be free. */
+static void test_subsystem_detach_free(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		    .data_in = &pkt_v4,
+		    .data_size_in = sizeof(pkt_v4));
+	struct struct_ops_detach *skel;
+	struct bpf_link *link = NULL;
+	int prog_fd;
+	int err;
+
+	skel = struct_ops_detach__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_detach_open_and_load"))
+		return;
+
+	link = bpf_map__attach_struct_ops(skel->maps.testmod_do_detach);
+	if (!ASSERT_OK_PTR(link, "attach_struct_ops"))
+		goto cleanup;
+
+	bpf_link__destroy(link);
+
+	prog_fd = bpf_program__fd(skel->progs.start_detach);
+	if (!ASSERT_GE(prog_fd, 0, "start_detach_fd"))
+		goto cleanup;
+
+	/* Do detachment from the registered subsystem */
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	if (!ASSERT_OK(err, "start_detach_run"))
+		goto cleanup;
+
+	/* The link may have zero refcount value and may have been
+	 * unregistered, so the detachment from the subsystem should fail.
+	 */
+	ASSERT_EQ(topts.retval, (u32)-ENOENT, "start_detach_run retval");
+
+	/* Sync RCU to make sure the link is freed without any crash */
+	ASSERT_OK(kern_sync_rcu(), "sync rcu");
+
+cleanup:
+	struct_ops_detach__destroy(skel);
+}
+
 void serial_test_struct_ops_module(void)
 {
 	if (test__start_subtest("test_struct_ops_load"))
@@ -304,5 +346,7 @@ void serial_test_struct_ops_module(void)
 		test_detach_link();
 	if (test__start_subtest("test_subsystem_detach"))
 		test_subsystem_detach();
+	if (test__start_subtest("test_subsystem_detach_free"))
+		test_subsystem_detach_free();
 }
 
-- 
2.34.1


