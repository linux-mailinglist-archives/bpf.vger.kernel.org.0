Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26B883B98C
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2019 18:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbfFJQeg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Jun 2019 12:34:36 -0400
Received: from mail-oi1-f202.google.com ([209.85.167.202]:38133 "EHLO
        mail-oi1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728200AbfFJQef (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Jun 2019 12:34:35 -0400
Received: by mail-oi1-f202.google.com with SMTP id u8so2950889oie.5
        for <bpf@vger.kernel.org>; Mon, 10 Jun 2019 09:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=quMXsD7+H6eze+mngdiYKY5iS4VhqtL6opWx3N39kho=;
        b=EdTZmklW67mGUKPynedxhk8aJTyHaaeIXUu33FZKAFE0HGz6GYtrH9gCLuMausnkQ1
         EKrptl3VozyOCm2M4qZ+1ZdTM5zsuiF0JVd71ONSuIO9qbjuoZTWa5KcgIDl1uCeQxed
         OLtwy2NVJPPOYayldqRlSjknSnj2aHQ+8wZT5HnfT62X5ZUnj/U0pjEaZJn3X0sEhnjg
         10vHMSx8o4P9XldMhdXjzD7dd52a1FVkBI7wxi3OLMFGhQIKFT/L2Ldv6YiiJ+uHX5YM
         Ye2c9jvSjjMqOlKKU/XkYxsV7dbO9rWqw/kFWeaNyA+VuPwlsyvKa+1rzf8pEwtdjh/C
         IhfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=quMXsD7+H6eze+mngdiYKY5iS4VhqtL6opWx3N39kho=;
        b=tWW6nSYup//N7YHaFI/TRpeRbOJG7NDPkh7XYLcJv8XEaD0PMfFjVC4bfbDldFMK8c
         005XJ5E0sjOotQTrFefp8MeTkIxqoE6/ol3gk46sSfzbj8XASlFvRFq7jr/7/6cKNtTp
         39LKcIJ7Y0LQaotyX34cDq7e2twVYne2tMc3dG8xCbKFE/t2ka4YdFm62Djvi7FNJkXP
         L3hs5CXxY5gSuYR9h/lccGxjwdzGjVmtpWAh0A6HE14UzXJoBczDN8VB4R9uWwdOG5X5
         JWvOx1HADib5VE8mM2e/faZkIs6UEyk3LqdXWOuOuwG5d9xrNIr+kdeImXU7xLb68Gt6
         NZgA==
X-Gm-Message-State: APjAAAUMcfs3f1CQvZTMX93dUhUSx0wTSWdthdvEb8/z+v0rhPAXCSCB
        F0gIwQroz4QUuSnpSOlhs1JvZW0=
X-Google-Smtp-Source: APXvYqy+KzNr95jaPqPNrfmfGiD86xdCtGpHrBjGbDuNCFD2iLRny6nerEKuuyftg9T5RVDMJiyHVws=
X-Received: by 2002:aca:55d8:: with SMTP id j207mr12210817oib.78.1560184474103;
 Mon, 10 Jun 2019 09:34:34 -0700 (PDT)
Date:   Mon, 10 Jun 2019 09:34:17 -0700
In-Reply-To: <20190610163421.208126-1-sdf@google.com>
Message-Id: <20190610163421.208126-5-sdf@google.com>
Mime-Version: 1.0
References: <20190610163421.208126-1-sdf@google.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH bpf-next v4 4/8] selftests/bpf: test sockopt section name
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

