Return-Path: <bpf+bounces-9074-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BA378F069
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 17:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F37101C20AFA
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 15:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6988D1429F;
	Thu, 31 Aug 2023 15:35:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBFE1400B;
	Thu, 31 Aug 2023 15:35:17 +0000 (UTC)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B116E4F;
	Thu, 31 Aug 2023 08:35:16 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2bcfd3220d3so16670051fa.2;
        Thu, 31 Aug 2023 08:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693496114; x=1694100914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y14cfr9X7ZfqN6REntNnZLiNj9fIlAHdGv7Az327RZ4=;
        b=KxL7dkK2E5sH7BQvpa2hndMNhaO1Z2b0Qh5tALxgLinYculPZudYF+ojhJ54RE2agQ
         Spsuz+E9dys5Gqk2thVjgs9Z74GuN4hULY7tKwJ9Qvy5SNpCMqYsHeSxeBmg2x78MfIo
         c+iywyqm23id6V4g67NzgAr+ORmpXk9tWlqPHqwyvMNB9XKdkq66XwJU4KGgwNUYjynT
         yEQrNLkIlobJPZRrHOvEMrcGjaojszPYu5J0qg3pmahx629bWeXcRzO3FhwLZwlf4/Je
         qm6IwOKu6ABdXEWYN1Xt0gsGuz0q7TFmqizZdMgRQR3JazH/j0CzJGhDXtMBo7if1XL9
         kpfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693496114; x=1694100914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y14cfr9X7ZfqN6REntNnZLiNj9fIlAHdGv7Az327RZ4=;
        b=T+nQOP8K72Tdcb71osoxG6sOUa9Imos+aFDvbHNIKB9Qf+zLDB+RZQOMW4nhliZ9sy
         1i8GCj9TlTtV/ttqKKaBuSuqq+U/qtJ4lBNxyGdo/pCq5Tbnv+uQ7P9h9iTIb2V7+S2N
         ECmxeBBH17mVD2Pj7N6qiJs6KTQI/uvPhze5khzjoD02VHGBUB8cHg26AasOYsFviArs
         uMbuwG8EQ6vjtAmp/AHwgyCB7Iog/AX/iU7xl0yT8wdOlOoAU1GD06OYn9y4R9Lzf2fx
         FRySaWTbpTNa7DpntcY3YEmBXUHmV99bg8MTyP1ShTyVZSacq52UleIOl0Z538M7nKi3
         1Z/g==
X-Gm-Message-State: AOJu0YxUyPe6/8YhUQq5uNQw0VUrUkdNO0NnPIgXMdjv80eEDzSsGyO4
	3yukyUOjDMSXOaJb1HuVtytwvshjx2zrRNyZS6I=
X-Google-Smtp-Source: AGHT+IFIdXjryre3ya8pGJC8M4bgIyFwxpEv0VvboRHNFm297Fdg7EBeRG7WqiVNTwrO2yApxh0p2A==
X-Received: by 2002:a2e:9ed3:0:b0:2bc:f41a:d9bc with SMTP id h19-20020a2e9ed3000000b002bcf41ad9bcmr4299574ljk.25.1693496113728;
        Thu, 31 Aug 2023 08:35:13 -0700 (PDT)
Received: from daandemeyer-fedora-PC1EV17T.thefacebook.com ([2620:10d:c092:400::5:a62f])
        by smtp.googlemail.com with ESMTPSA id ds11-20020a170907724b00b0099bcf9c2ec6sm868583ejc.75.2023.08.31.08.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 08:35:13 -0700 (PDT)
From: Daan De Meyer <daan.j.demeyer@gmail.com>
To: bpf@vger.kernel.org
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v3 1/9] selftests/bpf: Add missing section name tests for getpeername/getsockname
Date: Thu, 31 Aug 2023 17:34:45 +0200
Message-ID: <20230831153455.1867110-2-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230831153455.1867110-1-daan.j.demeyer@gmail.com>
References: <20230831153455.1867110-1-daan.j.demeyer@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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


