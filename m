Return-Path: <bpf+bounces-28763-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 744748BDAEA
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 07:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A07951C21BCB
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 05:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50496EB70;
	Tue,  7 May 2024 05:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTfp6x/8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC65E6BFC7
	for <bpf@vger.kernel.org>; Tue,  7 May 2024 05:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715061380; cv=none; b=OpFZJjz6tIqZQpkpqVqBiJlslBiNedLeIMrFp6yLqZW69cczLmB5PByy47GGcsABXe3y2xowPVZcw3eEBvzw2fGaxaAoJfDhY0qER8LJ34MoqawMBtukI6SUbOARQQcAXjsOIZbKvNcE8yeeVnE1ovomHG8ir0Cm3tMqH+8bblo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715061380; c=relaxed/simple;
	bh=q9Swa1+K8h4SGfXzsShvJjtTA7qzi1225dIDLnWciog=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mNbpSC1j+6VErIl0Wjxvgw8Hkb4vjF7jpaKXUmxo6KGmsbWy5GsfPX8eubF0hONoyTvWkN+99LywXPYFsKwadjD1SqiGeeEHrhVJvcA0sMYi6F2zzn182keF1JOfgnP41isDrJGJDOJDrsBxuNGbnft2TQ3Mt8ihu3RwAD1MVuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cTfp6x/8; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6f08ce51e02so373172a34.3
        for <bpf@vger.kernel.org>; Mon, 06 May 2024 22:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715061377; x=1715666177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jAykHutB81ybakCfShPFVvAxaH5qZF5mTZ4X1NwUf+0=;
        b=cTfp6x/8S+VnXypG7Hb/r0F8+XzP50vREt9SMvpOuj6p+gNmy5EObA7MyKKweIzpl9
         pfWy8acO9+CztGIaFL/JSDB/alR+8x7QrlJJQFZgcxBIuAFIAStjeTLuuH1r2qZC906u
         83qrvnekh0jcfYwKs+vtP8IDDQn5GlPH94k/HA2fM0hOTRSpfvMGEmaz5smljJxKGwyj
         2eb+7Q6oeOokgunC3aNgSJBgvGrQSzWvHyj2aLqiY/MZA6TQWchCuvN1oZddkamtMZCp
         gNn5JDL9b/GIFx2Os0LZbM04ciowbPrrLe+5bn6EpiYFtmYFbdGC803BjTwXd5wIUd2Y
         5Tow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715061377; x=1715666177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jAykHutB81ybakCfShPFVvAxaH5qZF5mTZ4X1NwUf+0=;
        b=F+86McOi7XoGl6BpiWvyN1kafTtJAYyTkSztg/0gKrCuJ149WPWw7uh1FltDahQmbK
         iUdKkG5M3fMFA/4t3dS++oZEBLpCcGku5WZKPwhj2qQRDaraHc8f03T39RWs2FUmhTrM
         UdYKItfYgMBX6ZJmKF+FnUeQ0sX6jW93p7bvvcOX8ApytHDBOUf7k2K3j0y9UC3pD1Yo
         qk2jMHRd6HsTx7kMRI9WRO6Ky0uhsnsJeV4WRMf3qQbxul/0LIwR5Cco5nLLolW84S0N
         Ech0FgARE2msFviAgFLkqcXKBK9P9jCoBVv/BSG0uYr4GSGzLrRwb/tSjctkLCR8Bef5
         mGng==
X-Gm-Message-State: AOJu0Yyq/3yAUT2qFqL+cDigDWDqbPKw9tqqt/Iq3ZXxhhRzf4jaW9qQ
	sYN0lPCLVBPPEjtoQCwOeipfg7YztvohGGztXm7eFzG87lN1VxWLHt0Idw==
X-Google-Smtp-Source: AGHT+IGNyy5Mk9qW0ZZ6sQyIpNcRPAD47hsGtGhd18ipc7vtbw8C8Z3ls32Kv7JcmlrID8fJLwOazw==
X-Received: by 2002:a9d:6554:0:b0:6f0:4bfc:4c49 with SMTP id q20-20020a9d6554000000b006f04bfc4c49mr5705634otl.15.1715061377652;
        Mon, 06 May 2024 22:56:17 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:2e7d:922e:d30d:e503])
        by smtp.gmail.com with ESMTPSA id eo8-20020a0568200f0800b005a586b0906esm2317011oob.26.2024.05.06.22.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 22:56:17 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 5/6] selftests/bpf: detach a struct_ops link from the subsystem managing it.
Date: Mon,  6 May 2024 22:55:59 -0700
Message-Id: <20240507055600.2382627-6-thinker.li@gmail.com>
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

Not only a user space program can detach a struct_ops link, the subsystem
managing a link can also detach the link. This patch add a kfunc to
simulate detaching a link by the subsystem managing it.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 21 ++++++
 .../bpf/prog_tests/test_struct_ops_module.c   | 65 +++++++++++++++++++
 .../selftests/bpf/progs/struct_ops_detach.c   |  6 ++
 3 files changed, 92 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index c89a6414c69f..0bf1acc1767a 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -502,6 +502,26 @@ __bpf_kfunc void bpf_kfunc_call_test_sleepable(void)
 static DEFINE_MUTEX(detach_mutex);
 static struct bpf_link *link_to_detach;
 
+__bpf_kfunc int bpf_dummy_do_link_detach(void)
+{
+	struct bpf_link *link;
+	int ret = -ENOENT;
+
+	mutex_lock(&detach_mutex);
+	link = link_to_detach;
+	/* Make sure the link is still valid by increasing its refcnt */
+	if (link && !atomic64_inc_not_zero(&link->refcnt))
+		link = NULL;
+	mutex_unlock(&detach_mutex);
+
+	if (link) {
+		ret = link->ops->detach(link);
+		bpf_link_put(link);
+	}
+
+	return ret;
+}
+
 BTF_KFUNCS_START(bpf_testmod_check_kfunc_ids)
 BTF_ID_FLAGS(func, bpf_testmod_test_mod_kfunc)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test1)
@@ -529,6 +549,7 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_test_destructive, KF_DESTRUCTIVE)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_static_unused_arg)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_offset)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_sleepable, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_dummy_do_link_detach)
 BTF_KFUNCS_END(bpf_testmod_check_kfunc_ids)
 
 static int bpf_testmod_ops_init(struct btf *btf)
diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
index f39455b81664..9f6657b53a93 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
@@ -229,6 +229,69 @@ static void test_detach_link(void)
 	struct_ops_detach__destroy(skel);
 }
 
+/* Detach a link from the subsystem that the link was registered to */
+static void test_subsystem_detach(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		    .data_in = &pkt_v4,
+		    .data_size_in = sizeof(pkt_v4));
+	struct epoll_event ev, events[2];
+	struct struct_ops_detach *skel;
+	struct bpf_link *link = NULL;
+	int fd, epollfd = -1, nfds;
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
+	fd = bpf_link__fd(link);
+	if (!ASSERT_GE(fd, 0, "link_fd"))
+		goto cleanup;
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
+	if (!ASSERT_EQ(topts.retval, 0, "start_detach_run retval"))
+		goto cleanup;
+
+	epollfd = epoll_create1(0);
+	if (!ASSERT_GE(epollfd, 0, "epoll_create1"))
+		goto cleanup;
+
+	ev.events = EPOLLHUP;
+	ev.data.fd = fd;
+	err = epoll_ctl(epollfd, EPOLL_CTL_ADD, fd, &ev);
+	if (!ASSERT_OK(err, "epoll_ctl"))
+		goto cleanup;
+
+	/* Wait for EPOLLHUP */
+	nfds = epoll_wait(epollfd, events, 2, 5000);
+	if (!ASSERT_EQ(nfds, 1, "epoll_wait"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(events[0].data.fd, fd, "epoll_wait_fd"))
+		goto cleanup;
+	if (!ASSERT_TRUE(events[0].events & EPOLLHUP, "events[0].events"))
+		goto cleanup;
+
+cleanup:
+	close(epollfd);
+	bpf_link__destroy(link);
+	struct_ops_detach__destroy(skel);
+}
+
 void serial_test_struct_ops_module(void)
 {
 	if (test__start_subtest("test_struct_ops_load"))
@@ -239,5 +302,7 @@ void serial_test_struct_ops_module(void)
 		test_struct_ops_incompatible();
 	if (test__start_subtest("test_detach_link"))
 		test_detach_link();
+	if (test__start_subtest("test_subsystem_detach"))
+		test_subsystem_detach();
 }
 
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_detach.c b/tools/testing/selftests/bpf/progs/struct_ops_detach.c
index aeb355b3bea3..139f9a5c5601 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_detach.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_detach.c
@@ -29,3 +29,9 @@ struct bpf_testmod_ops testmod_do_detach = {
 	.test_1 = (void *)test_1,
 	.test_2 = (void *)test_2,
 };
+
+SEC("tc")
+int start_detach(void *skb)
+{
+	return bpf_dummy_do_link_detach();
+}
-- 
2.34.1


