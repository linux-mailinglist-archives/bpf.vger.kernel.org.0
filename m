Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2DB82082
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2019 17:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfHEPlG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Aug 2019 11:41:06 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:51771 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728918AbfHEPlF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Aug 2019 11:41:05 -0400
Received: by mail-pf1-f201.google.com with SMTP id 145so53758025pfv.18
        for <bpf@vger.kernel.org>; Mon, 05 Aug 2019 08:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=e4SLScTqtI1V1lopKxDYlItZzmDFwVySiqM/qjPmZNY=;
        b=SxLJfvbs4L+HKM63MBHG5w/Ri9hEbDoelJ8iElKiOrsryNufROyMX650rch1zANw1s
         nC3Vnt78wURwxS8IZqjehsBm9Of09Oo6SNrMtxOk28xAElB5GtMva1xotAS09k7GRyBY
         cwSTehadb7cNrdRVRg3vT/JojAdg+BWsceTA7G53d8CBxLU4E2VFjroT0NGlKcAtlp/a
         U4MddeERhVO8sreEytXeCSl6cjtlxByY6avUe+rpr9VXwdi5VVFzrKKOwO4+R5XFNGFG
         D6fnOOX7PWCaFMBe8+ycaItiXBpdsGLVTjtFNLggAGNHilz8fSEFAJNhyDlx2ucVb1j3
         uMNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=e4SLScTqtI1V1lopKxDYlItZzmDFwVySiqM/qjPmZNY=;
        b=YSMaWTeM/+8jeCBExo5K+jPgGzMf07XjjeJhPr0nHlVmCSp0rH9xFrqesa96IkRN5F
         S0EpHxTVoONeeFmUWqPkIp3mHhfgCW5CQF1f9joSJCKb3ebSeWCNXGeQyC+pwcWbihGw
         AkrwDKTVtKHbe4BsE4j9faiDFvnZy0EfooJqTlBkwQGUDFg4NvG3ro971geMpyTycCdY
         MRq9FnUD6JvGTLJ5vzmXbtzwYgg4OgQt8WUduBL3pti+jQQym5tsJD7StqwKe0kMmblQ
         ACRH3jqjDwav1JdiBycuWHRlETtJpRf2IJBBGtm1HPYVEoxtpLAgoo2+25XPy+WNrMkK
         laag==
X-Gm-Message-State: APjAAAW01ZTa54uWTaXNVlB9kkOpUw6ijC0HKO4e4J1RktmdxzFbEDdz
        0iwd05CcZ+l1Bjct6d2o9Byqvx8=
X-Google-Smtp-Source: APXvYqxQ76N7noym5vCpLSQ2og69/R8Rtj4mE8uAIU5ZvqUzJgcMxQavUTHeJ3qX2810py8AWhnTVRQ=
X-Received: by 2002:a63:3006:: with SMTP id w6mr15211808pgw.440.1565019664556;
 Mon, 05 Aug 2019 08:41:04 -0700 (PDT)
Date:   Mon,  5 Aug 2019 08:40:55 -0700
In-Reply-To: <20190805154055.197664-1-sdf@google.com>
Message-Id: <20190805154055.197664-4-sdf@google.com>
Mime-Version: 1.0
References: <20190805154055.197664-1-sdf@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH bpf-next v3 3/3] selftests/bpf: test_progs: drop extra
 trailing tab
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        Andrii Nakryiko <andriin@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Small (un)related cleanup.

Cc: Andrii Nakryiko <andriin@fb.com>
Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/test_progs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 963912008042..beed74043933 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -278,7 +278,7 @@ enum ARG_KEYS {
 	ARG_VERIFIER_STATS = 's',
 	ARG_VERBOSE = 'v',
 };
-	
+
 static const struct argp_option opts[] = {
 	{ "num", ARG_TEST_NUM, "NUM", 0,
 	  "Run test number NUM only " },
-- 
2.22.0.770.g0f2c4a37fd-goog

