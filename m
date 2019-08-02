Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 024DD8021F
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2019 23:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731893AbfHBVLU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Aug 2019 17:11:20 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:44866 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404773AbfHBVLT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Aug 2019 17:11:19 -0400
Received: by mail-pf1-f201.google.com with SMTP id j22so48996546pfe.11
        for <bpf@vger.kernel.org>; Fri, 02 Aug 2019 14:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ybfW8YpfyAtMEdw5x5rwRE8bojxZfJkloQ1iCTv9B/0=;
        b=mafz/adl/w6/0lfjqmkB8golOtD4H5CzuG/RA2H3VXUwlv+r4PjlLn7d1JnwsF27kd
         beFHnA4CpiFs53oxT71IlXd7QZTbAkGuDHeOvZiNIWcPNP74UIQ1jzJNIxHm6mUTbPn5
         ejI3Nc7v9X/iUArX04RkJD4duYN3mx0NVnerHiez5N9j5YhiNauNlIPdFUpywMmxJIck
         8L5NMh9y89wdBCPOv+PX7wXlpSZ/dL84W5UpxJtP/KwnovqZ7fLhg8hF3IvCG0IK7qao
         ro49kodb0WsQKpahBwfP5rMDLwNNKFOWMzLNnZstR48qfKYyrx6g19rKQ4Bg2rdG1s5R
         MWBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ybfW8YpfyAtMEdw5x5rwRE8bojxZfJkloQ1iCTv9B/0=;
        b=ky135kKkqVPZDHiig2FB4q++Sb1pMO5z3EvW27XU0zndirTh1J/G+QghiogwcodDFg
         tGvxj4BNEqo4dbYN8mA4UIwZXSzAAZG2anO7M+Ahj+q0JoF6vLpn0XlcWq1bZsJLNw/X
         52dga+ARQkeBkDRlDCj50vwADs2GAs6KnidBRI+68Y0jY6cAfdFNzIBpEFnPOmCq3yAu
         sZH/jV13Ow/b4H79zq2HIU0nVhkP9DQ13Cn02RVwkOtBIV/FHikr2VKDeQoOUKO8DURS
         RUldvtEctMiLmY3uPgJG8eTLochPsoUr1MBB+yCx9UYjE/+I+PqgrG0mqCLN1elFMNJQ
         chPg==
X-Gm-Message-State: APjAAAXTl/wo/zjITZwPFAWQ0j+K9bHoh4IC5ZpV+05AVrGhN7acywiz
        o3V6d+dqcgpDaiovDMOQxw0+les=
X-Google-Smtp-Source: APXvYqxLBhlf1suALewYVtCw1pKL3HpiJfjNmvNtuJIwpGfWihbL66+EtoSp9TX7J4wqiFxPaVN41pA=
X-Received: by 2002:a65:5c4b:: with SMTP id v11mr83542414pgr.62.1564780278569;
 Fri, 02 Aug 2019 14:11:18 -0700 (PDT)
Date:   Fri,  2 Aug 2019 14:11:08 -0700
In-Reply-To: <20190802211108.90739-1-sdf@google.com>
Message-Id: <20190802211108.90739-4-sdf@google.com>
Mime-Version: 1.0
References: <20190802211108.90739-1-sdf@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH bpf-next v2 3/3] selftests/bpf: test_progs: drop extra
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
index 1827ce5114f4..ccc77782ca7e 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -281,7 +281,7 @@ enum ARG_KEYS {
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

