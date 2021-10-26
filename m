Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B22D43B441
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 16:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235635AbhJZOgi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Oct 2021 10:36:38 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:38248
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234528AbhJZOgi (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 26 Oct 2021 10:36:38 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 57C8E40277
        for <bpf@vger.kernel.org>; Tue, 26 Oct 2021 14:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1635258853;
        bh=eDxSkDWuV2Brl7cNvyAavjHeovH27qcvC2ratC3kbv8=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=P1L7QojtR3MKwvXvPP2OAz83YqtC3rS09Rs1W3MJjFr7LbxjzGY69bmkcCtmiRrcN
         XozqnLsoakyM7Qs5B31Uhi+A6iUnJ2DYLV89fPhT39DNiUf6fbfXgpKj8ntVUOfJW6
         fmJ6zw/gyzpGTAO/FGaHKBxsQKdz7xmb1iM5IhbN+BzryCcHzXnx9ETpS1qmreHC9p
         8JYyNZHRpCjuI6L6R8dXZkAwYWw78ItzXzYkxemW+jpTkpOxV86t+/dmlArvW/lmzU
         KK4TkTeGj8mf0VmubSaHt7unxAOOjPAmRp9CPga58+qhb++0Byy62ySYviZ6sfv7Hz
         Ri9GFDEda8b8A==
Received: by mail-wm1-f71.google.com with SMTP id z17-20020a7bc7d1000000b0032cafafaf79so1012176wmk.5
        for <bpf@vger.kernel.org>; Tue, 26 Oct 2021 07:34:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eDxSkDWuV2Brl7cNvyAavjHeovH27qcvC2ratC3kbv8=;
        b=Rhs2pR1fV20aPwb6KgUiKm8yq9A+tb1rjSK4amTxnATe9ghpmcqz8S93neAJYNWJmL
         4egWExWA8GP2V1f+Giq8fpj0NjpsRmvxnQ8WAGXYh2b6DW+uxnZ6B46kjT4q/K0Eb71b
         8yYexF9570c/WwqDtTmddbgEz7dAkLi9Wvh/muasWvHqxQQ1OoYQtInahLlYnNUlnld8
         cbaosQh95Gk31CfB3QmhMEKfQ3QllvJqpYcu1JVOdvTvWRLtMw/UxtudTlaImQta1TC+
         PJZXKfL0TUJfluE1QFyIp9YEo80aoOlBVnLel//n310Dtc2HWVqkIWKg8jnmo1pDPLpJ
         /OOA==
X-Gm-Message-State: AOAM531B1LsSkLYo6rvynsIIu9FNgrJDFbXn5S7nh67P76NeRFcuGsDN
        0kwFsKy5yjCEitqxWMoy67r3DZdzqxukuD6rWFLPv4lX/4/PKlUQ01VQKI9DXMPOZgoSNyADX5Q
        UiInNc6RC5Em6q4y/FfwMT1freZDzbw==
X-Received: by 2002:a5d:58ec:: with SMTP id f12mr32833782wrd.24.1635258852983;
        Tue, 26 Oct 2021 07:34:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwEiliuRm8Od3p070aft+0SzvwyEHzdS3NpXZbNSe6M5MRDCzikoxxtwZ2bnpDR86tzT0wrFA==
X-Received: by 2002:a5d:58ec:: with SMTP id f12mr32833741wrd.24.1635258852720;
        Tue, 26 Oct 2021 07:34:12 -0700 (PDT)
Received: from arighi-desktop.homenet.telecomitalia.it ([151.57.120.224])
        by smtp.gmail.com with ESMTPSA id p1sm800266wmq.23.2021.10.26.07.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 07:34:12 -0700 (PDT)
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/bpf: fix fclose/pclose mismatch
Date:   Tue, 26 Oct 2021 16:34:09 +0200
Message-Id: <20211026143409.42666-1-andrea.righi@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Make sure to use pclose() to properly close the pipe opened by popen().

Fixes: 81f77fd0deeb ("bpf: add selftest for stackmap with BPF_F_STACK_BUILD_ID")
Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 tools/testing/selftests/bpf/test_progs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index cc1cd240445d..e3fea6f281e4 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -370,7 +370,7 @@ int extract_build_id(char *build_id, size_t size)
 
 	if (getline(&line, &len, fp) == -1)
 		goto err;
-	fclose(fp);
+	pclose(fp);
 
 	if (len > size)
 		len = size;
@@ -379,7 +379,7 @@ int extract_build_id(char *build_id, size_t size)
 	free(line);
 	return 0;
 err:
-	fclose(fp);
+	pclose(fp);
 	return -1;
 }
 
-- 
2.32.0

