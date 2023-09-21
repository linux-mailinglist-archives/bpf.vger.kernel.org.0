Return-Path: <bpf+bounces-10552-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFB77A9C5D
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 21:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3919B224DA
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 19:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9B847C98;
	Thu, 21 Sep 2023 17:49:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBEB44483;
	Thu, 21 Sep 2023 17:49:31 +0000 (UTC)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02BB88084;
	Thu, 21 Sep 2023 10:38:34 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9a648f9d8e3so161718566b.1;
        Thu, 21 Sep 2023 10:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695317913; x=1695922713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y14cfr9X7ZfqN6REntNnZLiNj9fIlAHdGv7Az327RZ4=;
        b=E3PROPb1bzLJOMm/FSeIgO0wBRldSKRkyxAHYKbwwAcchLjjax7S5R+/f7NtN19XGi
         iXl510YcNO4xwDB8z+SDkdlf//hgSanw6H22nxi4LscyJ7xd+L2gvG/CxkhinqI6SX+o
         rravndbz7tZVLexWGNtSYJnDp893enAp1v4e3WR+FxSB+F+rH0nLSLJtBxipj0uTnhXJ
         T1glSxvKjBeZt5yK/+J3f9vaf3I+QQ86hAuG0IqtfjdQfAksHgB8IT56SK8m0DwaW5s5
         uGZRhCxsLOUcrz7Q0ZmRVA848qs60eFWEzwUWE1g7nm5RkvZtB8DswRupX35bQvpYaOE
         K1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317913; x=1695922713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y14cfr9X7ZfqN6REntNnZLiNj9fIlAHdGv7Az327RZ4=;
        b=JN4Iz1Wk47FD4gqXTwu3cHNuK2vbCwen6hxaNJCiWejIX240O7xB63I97saESrzeto
         Vyr8XP/qpJjpkc1Z58qgxY5DncCr9pGdcfA9KTJyqIFN+k9BYs6GigOAJYh76aciYqva
         AzuykzqN1/7olIaZPKypasCV+5tUtY6pLAYKIvu+wILMGPbTm9tXkoMQcyfxkzY5kvTv
         rZ4tw5FLUJGxmTGbbvSRx/e91dHxeGNnSL2KkoULYhFFOjWhAtjLp5fvr0wkFIu03gTa
         gNl0BKtLd58u+OTLfKaK+/pR/lzIY5fs1R38Jww57Wvay6cgkfJcTJr5V6PlR/WE+5W3
         3wEw==
X-Gm-Message-State: AOJu0YyJ6lEFeBxaqLYRIF8xhDu+NyfgsgkPV31UVKAzqPb5cye7L4V0
	kWHTEcGErih0Ph3y/ibDWQgrkd5EoobpJBTDn7I=
X-Google-Smtp-Source: AGHT+IHucW0QapyF6rf3iOtsRReWvbk8lH8jczNbwidhOigjSKdB/LYWI9iZJpoPXaeKh2pdO1CXag==
X-Received: by 2002:a2e:b616:0:b0:2b9:36d5:729c with SMTP id r22-20020a2eb616000000b002b936d5729cmr4439296ljn.47.1695298169438;
        Thu, 21 Sep 2023 05:09:29 -0700 (PDT)
Received: from daandemeyer-fedora-PC1EV17T.thefacebook.com ([2620:10d:c092:400::4:2a59])
        by smtp.googlemail.com with ESMTPSA id gx10-20020a170906f1ca00b0099cb349d570sm952258ejb.185.2023.09.21.05.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 05:09:28 -0700 (PDT)
From: Daan De Meyer <daan.j.demeyer@gmail.com>
To: bpf@vger.kernel.org
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v5 1/9] selftests/bpf: Add missing section name tests for getpeername/getsockname
Date: Thu, 21 Sep 2023 14:09:03 +0200
Message-ID: <20230921120913.566702-2-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230921120913.566702-1-daan.j.demeyer@gmail.com>
References: <20230921120913.566702-1-daan.j.demeyer@gmail.com>
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


