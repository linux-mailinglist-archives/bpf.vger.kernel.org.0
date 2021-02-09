Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 361B6315836
	for <lists+bpf@lfdr.de>; Tue,  9 Feb 2021 22:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234263AbhBIU7S (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Feb 2021 15:59:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234080AbhBIUwC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Feb 2021 15:52:02 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD41DC061A30
        for <bpf@vger.kernel.org>; Tue,  9 Feb 2021 11:49:07 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id z7so457413plk.7
        for <bpf@vger.kernel.org>; Tue, 09 Feb 2021 11:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=01Exh/2ObMelGUhb994VG5lHlejeefEcqeiEWbL0Xvk=;
        b=UxhvylfgPnufXTlD7GqANuUGS0I4Qg2pzLWiVIO2pNWMxMaRVjWLtoM8I7MLiVQjHK
         YNAXxvMmMY7UmnNena8fCv5qphEk2wtA4Vg42kpbJs9iQfHalrkMTvnLtleJfnlhYnaz
         ZD4gNe3O0YH0/IrZc9zY6M/e0XVO4HYR3DWH1autenmGM3YEbuNcJkbx7/LLxf1Y+hJs
         1a9JNWwUBoIsnnUXgXHcLMS6mnQtBaQ0SlO3So/d0rh9k3UJ9MQw4kXC4t5JQOpvW2An
         50hMPmQJyVUnlatm313emfQ8jLSPEgGfGXbkHicZ6f6ZJNraUnbRvmHN3yrb88QzFevX
         FEUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=01Exh/2ObMelGUhb994VG5lHlejeefEcqeiEWbL0Xvk=;
        b=sqBll/bJOeGoj3tfXh9XozZiQzmDhAvHJ7acwyKrFenWH6x9kwHadYvEhDi4/rIOZa
         HS69jD3uLXo2aJCiaZn9ujFASa6xWXcwid5Lqu9m6h869PhqKXkmXsN3NuWWYDjgldek
         G9NmLDTitFLAeRSiglMsnAV8WbT/2iQLFPZ23Zp0rgLZLMH+YMVxp5Kjj7HkQjh0o83u
         ZHkKyFctutxPPW+tQxnJKcsJS0dR4nYtgMv8Wo66scWN1amk1BWrg8b0VhdIAf6VHE2l
         xckCvPLft2cekNCCNgni7sgMEB4CWLoAvUugaBfDoL0twtsG5VybkV8noZ+qsGAMVCHx
         UoXA==
X-Gm-Message-State: AOAM530PgEoBxs0Gt7r9GdJIljaJWSuWnYmNMNm4JI5mIAAi4N/Qsa/r
        kPcykUYi+aQ0ep90eV7tys0=
X-Google-Smtp-Source: ABdhPJzZvL3eXYtwG1Zv/yaV8Wa4HEFlz1iGwdyzw610HCZNB1k6P6LxXPgB/r34EnUmo88aVla7IQ==
X-Received: by 2002:a17:902:b94b:b029:e0:1e:da58 with SMTP id h11-20020a170902b94bb02900e0001eda58mr22665440pls.55.1612900147335;
        Tue, 09 Feb 2021 11:49:07 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([163.114.132.7])
        by smtp.gmail.com with ESMTPSA id j22sm139123pff.57.2021.02.09.11.49.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Feb 2021 11:49:06 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 bpf-next 6/8] selftests/bpf: Improve recursion selftest
Date:   Tue,  9 Feb 2021 11:48:54 -0800
Message-Id: <20210209194856.24269-7-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210209194856.24269-1-alexei.starovoitov@gmail.com>
References: <20210209194856.24269-1-alexei.starovoitov@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Since recursion_misses counter is available in bpf_prog_info
improve the selftest to make sure it's counting correctly.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/recursion.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/recursion.c b/tools/testing/selftests/bpf/prog_tests/recursion.c
index 863757461e3f..0e378d63fe18 100644
--- a/tools/testing/selftests/bpf/prog_tests/recursion.c
+++ b/tools/testing/selftests/bpf/prog_tests/recursion.c
@@ -5,6 +5,8 @@
 
 void test_recursion(void)
 {
+	struct bpf_prog_info prog_info = {};
+	__u32 prog_info_len = sizeof(prog_info);
 	struct recursion *skel;
 	int key = 0;
 	int err;
@@ -28,6 +30,12 @@ void test_recursion(void)
 	ASSERT_EQ(skel->bss->pass2, 1, "pass2 == 1");
 	bpf_map_lookup_elem(bpf_map__fd(skel->maps.hash2), &key, 0);
 	ASSERT_EQ(skel->bss->pass2, 2, "pass2 == 2");
+
+	err = bpf_obj_get_info_by_fd(bpf_program__fd(skel->progs.on_lookup),
+				     &prog_info, &prog_info_len);
+	if (!ASSERT_OK(err, "get_prog_info"))
+		goto out;
+	ASSERT_EQ(prog_info.recursion_misses, 2, "recursion_misses");
 out:
 	recursion__destroy(skel);
 }
-- 
2.24.1

