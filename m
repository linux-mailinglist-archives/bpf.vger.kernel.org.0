Return-Path: <bpf+bounces-11189-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BD57B5312
	for <lists+bpf@lfdr.de>; Mon,  2 Oct 2023 14:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id DAA442837CD
	for <lists+bpf@lfdr.de>; Mon,  2 Oct 2023 12:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4F017998;
	Mon,  2 Oct 2023 12:28:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2071775C;
	Mon,  2 Oct 2023 12:28:11 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6705FCE;
	Mon,  2 Oct 2023 05:28:10 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5230a22cfd1so22167391a12.1;
        Mon, 02 Oct 2023 05:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696249688; x=1696854488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y14cfr9X7ZfqN6REntNnZLiNj9fIlAHdGv7Az327RZ4=;
        b=bFDZBkfVgR5lyLDXaBgMxFNWrkdrAXgzNeuvyPWZoKNDQvk+WqfDDvDTTT+Ys0Q2UO
         bQNflt5+NqfD1teXjsHVcygwLcu8NcMz4sq1TxHquziv/rEWn8Pd7ijNZyC+z73I98Ih
         kYkteHJJwYDHo7iFjhvkOoX7PciFDQKWJ16Q1Ts/3JrAHEKRyifGGRtILxV3q9o6892b
         fs61un3kG7+yDqWVSxcCWsd+nK0e20zpwbzRJi4D1TpnZlhNv9qMlyOSgY8i57tHGOXI
         nL1BQiTN08zyAv0I2iagFhjPgmlM6m5ayy3f48vOfdkl9tWaZODcmNnMXEzEoLiLt3Kd
         INiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696249688; x=1696854488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y14cfr9X7ZfqN6REntNnZLiNj9fIlAHdGv7Az327RZ4=;
        b=oDE/4y2AslngtyUeilBfR8oLHRHnYF6LcD6bvOznn7P6tkHZWalwaOmhM82j1qHWZg
         IK+61SwY2/sPPqagfxoRb75SuIiIX1v8BjiprC/g1nziD7UoxWAKdFChXNrs0re3E2mN
         GsIoUVhvtQOYIbCrFED0IS4PORNjk9Bda+w6oaTkFQzMYfPhG6kLTf/ktqo4kKSMLYNl
         Q7TJKH6KQcf7o4Hx5WzVaFCh8nWDRgWNK9EoEhfgqbQ1HGtqCKOLLTM+EyHyomZQ2MaU
         fjASX8yUpuXm6s+s24PsfBrJrZ9yl0dgDVNg3rj/LxYKk+tx5LdWq1xd/PzgArs0G1TE
         BW6g==
X-Gm-Message-State: AOJu0YwrEDUUtwBbrBankfLCrOFwv5Nd2NHD7glmhH/FqgA/5xVHyyy8
	U/H9nRXO1cPaIbbQesw5rqBDouAs81YIfBpm
X-Google-Smtp-Source: AGHT+IE47xjupsHijknyq1B1UNvsuxzC/a09y1ERunHDQljFIGs8eQhsShjJib+WRaJQ3C9zG8fVEQ==
X-Received: by 2002:a50:ef17:0:b0:532:ac24:3081 with SMTP id m23-20020a50ef17000000b00532ac243081mr9195318eds.30.1696249688524;
        Mon, 02 Oct 2023 05:28:08 -0700 (PDT)
Received: from daandemeyer-fedora-PC1EV17T.thefacebook.com (2001-1c05-3310-3500-aa0d-0bb2-d029-8797.cable.dynamic.v6.ziggo.nl. [2001:1c05:3310:3500:aa0d:bb2:d029:8797])
        by smtp.googlemail.com with ESMTPSA id v10-20020aa7dbca000000b005330b2d1904sm15263099edt.71.2023.10.02.05.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 05:28:08 -0700 (PDT)
From: Daan De Meyer <daan.j.demeyer@gmail.com>
To: bpf@vger.kernel.org
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v7 1/9] selftests/bpf: Add missing section name tests for getpeername/getsockname
Date: Mon,  2 Oct 2023 14:27:47 +0200
Message-ID: <20231002122756.323591-2-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231002122756.323591-1-daan.j.demeyer@gmail.com>
References: <20231002122756.323591-1-daan.j.demeyer@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

These were missed when these hooks were first added so add them now
instead to make sure every sockaddr hook has a matching section name
test.

Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
---
 .../selftests/bpf/prog_tests/section_names.c  | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/section_names.c b/tools/testing/selftests/bpf/prog_tests/section_names.c
index 8b571890c57e..fc5248e94a01 100644
--- a/tools/testing/selftests/bpf/prog_tests/section_names.c
+++ b/tools/testing/selftests/bpf/prog_tests/section_names.c
@@ -158,6 +158,26 @@ static struct sec_name_test tests[] = {
 		{0, BPF_PROG_TYPE_CGROUP_SOCKOPT, BPF_CGROUP_SETSOCKOPT},
 		{0, BPF_CGROUP_SETSOCKOPT},
 	},
+	{
+		"cgroup/getpeername4",
+		{0, BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_INET4_GETPEERNAME},
+		{0, BPF_CGROUP_INET4_GETPEERNAME},
+	},
+	{
+		"cgroup/getpeername6",
+		{0, BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_INET6_GETPEERNAME},
+		{0, BPF_CGROUP_INET6_GETPEERNAME},
+	},
+	{
+		"cgroup/getsockname4",
+		{0, BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_INET4_GETSOCKNAME},
+		{0, BPF_CGROUP_INET4_GETSOCKNAME},
+	},
+	{
+		"cgroup/getsockname6",
+		{0, BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_INET6_GETSOCKNAME},
+		{0, BPF_CGROUP_INET6_GETSOCKNAME},
+	},
 };
 
 static void test_prog_type_by_name(const struct sec_name_test *test)
-- 
2.41.0


