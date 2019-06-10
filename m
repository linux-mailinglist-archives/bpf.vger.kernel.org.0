Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1DAE3BE15
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2019 23:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389919AbfFJVIo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Jun 2019 17:08:44 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:42767 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389884AbfFJVIn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Jun 2019 17:08:43 -0400
Received: by mail-vs1-f74.google.com with SMTP id a11so910947vso.9
        for <bpf@vger.kernel.org>; Mon, 10 Jun 2019 14:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=quMXsD7+H6eze+mngdiYKY5iS4VhqtL6opWx3N39kho=;
        b=nkzFro68TpzhhQRfqeybbSFqxrUBW89R1h0kxttrQetsjXCxJV1H7cukFa6vQiDYy9
         LagMcLs89W39Zm7B3+nk0mB3zLWEmNq/uC4imeSPBs+T50rPSt3omrqTI662H51ctzIh
         HYhqS9F7mrcSFbwXSiRyGar08zLcyPYqVCnwpF3ZObn2N2qfZJy7K1A7xuJKnO5c2D8G
         9arkBtEhmicutQQp/UJyFT6BsoqFYF5Ruyf8wFRf4lEuj96HTXvSeiijzREkpOft3nJB
         Lou7pHt8KZF15ruibfcCb+yzB2i7lAMjmeEQ11K5ci7MtMwisIbveCTd8gyyWO0jpGh1
         vedQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=quMXsD7+H6eze+mngdiYKY5iS4VhqtL6opWx3N39kho=;
        b=GBl6sLQ9KxJexI87tJmhVsmZZRvXOrnJrOQ43DdteULcCFT3jEShRt+utnBbVyh4OG
         6hpOGVdUqq6DsQ/42kgm8oZqSvC/a/X3G9HGIkBpDiKy/7Vqg/vryfte+NEXysBigm1b
         uu1cY/Zlyhxcr/w8XIJUZDEEeJ2TjXpSPN0fieSX97Y9nKCZl3vWBWLuFmh55wflU9s/
         x+QUjk6+08LbfAu0USc+zpL9kOHQ/bgzKnzlHDh1WIdhn428uNeANC9NLUmfb/mOEk6f
         mmaGowxKMu2Z1VlYeMn7e3onxV+cCmz4SEsieyx0lgXEJZE8tUb+xrEtSusM6kETC/Qe
         ftdw==
X-Gm-Message-State: APjAAAUJXzqmML1rfkyK0fUPGaQ76yqIeSQdoDFjpHF9mlfA3RC3B+mr
        x5KwKGFHqG1XZOBn9dZIfvUFlKM=
X-Google-Smtp-Source: APXvYqwgfmabI/aTrH4v2MfDcBFnysCIgV0W+w8bAO/yn5BT6boru0SmVV3wyqIksaMW49uJr4ovyC4=
X-Received: by 2002:ab0:36c:: with SMTP id 99mr4085373uat.105.1560200922842;
 Mon, 10 Jun 2019 14:08:42 -0700 (PDT)
Date:   Mon, 10 Jun 2019 14:08:26 -0700
In-Reply-To: <20190610210830.105694-1-sdf@google.com>
Message-Id: <20190610210830.105694-5-sdf@google.com>
Mime-Version: 1.0
References: <20190610210830.105694-1-sdf@google.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH bpf-next v5 4/8] selftests/bpf: test sockopt section name
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>, Martin Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add tests that make sure libbpf section detection works.

Cc: Martin Lau <kafai@fb.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/test_section_names.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_section_names.c b/tools/testing/selftests/bpf/test_section_names.c
index bebd4fbca1f4..5f84b3b8c90b 100644
--- a/tools/testing/selftests/bpf/test_section_names.c
+++ b/tools/testing/selftests/bpf/test_section_names.c
@@ -124,6 +124,16 @@ static struct sec_name_test tests[] = {
 		{0, BPF_PROG_TYPE_CGROUP_SYSCTL, BPF_CGROUP_SYSCTL},
 		{0, BPF_CGROUP_SYSCTL},
 	},
+	{
+		"cgroup/getsockopt",
+		{0, BPF_PROG_TYPE_CGROUP_SOCKOPT, BPF_CGROUP_GETSOCKOPT},
+		{0, BPF_CGROUP_GETSOCKOPT},
+	},
+	{
+		"cgroup/setsockopt",
+		{0, BPF_PROG_TYPE_CGROUP_SOCKOPT, BPF_CGROUP_SETSOCKOPT},
+		{0, BPF_CGROUP_SETSOCKOPT},
+	},
 };
 
 static int test_prog_type_by_name(const struct sec_name_test *test)
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

