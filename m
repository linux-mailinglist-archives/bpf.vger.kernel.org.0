Return-Path: <bpf+bounces-15958-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6467B7FA8DF
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 19:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86E631C20B7D
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 18:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCCD3DB9F;
	Mon, 27 Nov 2023 18:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XSfEGoBz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3C4198
	for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 10:21:01 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5c203dd04a3so4771531a12.3
        for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 10:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701109260; x=1701714060; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8SXL1ZpHESJB86RDSKmtn6hmopDrol5p5k12MS2Dgak=;
        b=XSfEGoBzGxoghNBN3b8moa1wagtxu5r+rIPZqVlt6B2KrDNVzWAaUM7Czs0wDev6Uc
         jP3bEJQ9a7ZC2kCEAVU9iSy7jx+CroVoUTRuJhwz/85eO6yStb3sHEGnNE5UXcmQQjwN
         yC0RPvBgJfFpfi1k66oBcazcdrIdBarkgrc7v7OKxLlGijXPj6+uRCxbAutBW1e2zZ7l
         BQA4xqy2rOGwC9hyV8+EROyvviSNLS9U3wrgUcMY4Z/jK8MGgJIcZ7DzCIQe/tbaRm63
         /aw5V66KAnxfR/jErfwrkhzlOB+jmGTiB6eKEAuQXr0auSIYycoR5QvU1u/7xBbhP283
         pS+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701109260; x=1701714060;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8SXL1ZpHESJB86RDSKmtn6hmopDrol5p5k12MS2Dgak=;
        b=fbCb7+EY1QirumNLd+uvcqvIkv/BSj3HicQg2yKbgZ2jwVH7J9ubTLDYxi2JU5Vwnk
         pH0FB1AuqL3EQ9CiZq4aBS2iMSF43PJDLl+oFsOQaoTGf/QhIFrYnqLl5IMojeJHuUr8
         z+CujUaNtStzEUrnMjMzeImAEdf2wjFw0IaEge97BxqZ56qdn10ScXCGyl5mWLIa52TZ
         R7vH5nD5yYPg53QjN/hB+Yf344HWGiNqdV9rmuGFKTASTTpa8Fcq5OhX3MGD96alO2iY
         z1bbJNJcgtVGC8xbpsoHgDsjIC///fWCgOT5MD7F5eKuHEG8I+HHb0NqGPRgxofLL0k/
         epdg==
X-Gm-Message-State: AOJu0YxBaO/HOgxpViIwhXu1P9tuX/2Hc1Vu2z+G585rDx7oEYBs7A3B
	cU0UJ+LPgS04R78+hT/zriwb9jiAbbVLWClSfLsdDvp8Cl/PiOZkEkvJGgaogwveS2k2HPmUCOg
	j9yKP52GwtiN6nZl5F8hal3VWzs4ykeLcgnXGin0w8Jjx/4qAAA==
X-Google-Smtp-Source: AGHT+IFwEEsbWOBcEc19xvpAH7GHsAzGC7dD+huV9ljjOK/1ZcscyzIva8g42aN4YlApSbKxowJ9m3c=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:6909:0:b0:5bd:85b1:da18 with SMTP id
 e9-20020a636909000000b005bd85b1da18mr1900156pgc.11.1701109260470; Mon, 27 Nov
 2023 10:21:00 -0800 (PST)
Date: Mon, 27 Nov 2023 10:20:57 -0800
In-Reply-To: <20231127182057.1081138-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231127182057.1081138-1-sdf@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231127182057.1081138-2-sdf@google.com>
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: update test_offload to use new
 orphaned property
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

- filter orphaned programs by default
- when trying to query orphaned program, don't expect bpftool failure

Cc: netdev@vger.kernel.org
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/test_offload.py | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_offload.py b/tools/testing/selftests/bpf/test_offload.py
index 40cba8d368d9..6157f884d091 100755
--- a/tools/testing/selftests/bpf/test_offload.py
+++ b/tools/testing/selftests/bpf/test_offload.py
@@ -169,12 +169,14 @@ netns = [] # net namespaces to be removed
     return tool("bpftool", args, {"json":"-p"}, JSON=JSON, ns=ns,
                 fail=fail, include_stderr=include_stderr)
 
-def bpftool_prog_list(expected=None, ns=""):
+def bpftool_prog_list(expected=None, ns="", exclude_orphaned=True):
     _, progs = bpftool("prog show", JSON=True, ns=ns, fail=True)
     # Remove the base progs
     for p in base_progs:
         if p in progs:
             progs.remove(p)
+    if exclude_orphaned:
+        progs = [ p for p in progs if not p['orphaned'] ]
     if expected is not None:
         if len(progs) != expected:
             fail(True, "%d BPF programs loaded, expected %d" %
@@ -612,11 +614,9 @@ def bpftool_prog_load(sample, file_name, maps=[], prog_type="xdp", dev=None,
 
 def check_dev_info_removed(prog_file=None, map_file=None):
     bpftool_prog_list(expected=0)
+    bpftool_prog_list(expected=1, exclude_orphaned=False)
     ret, err = bpftool("prog show pin %s" % (prog_file), fail=False)
-    fail(ret == 0, "Showing prog with removed device did not fail")
-    fail(err["error"].find("No such device") == -1,
-         "Showing prog with removed device expected ENODEV, error is %s" %
-         (err["error"]))
+    fail(ret != 0, "failed to show prog with removed device")
 
     bpftool_map_list(expected=0)
     ret, err = bpftool("map show pin %s" % (map_file), fail=False)
@@ -1395,10 +1395,7 @@ netns = []
 
     start_test("Test multi-dev ASIC cross-dev destruction - orphaned...")
     ret, out = bpftool("prog show %s" % (progB), fail=False)
-    fail(ret == 0, "got information about orphaned program")
-    fail("error" not in out, "no error reported for get info on orphaned")
-    fail(out["error"] != "can't get prog info: No such device",
-         "wrong error for get info on orphaned")
+    fail(ret != 0, "couldn't get information about orphaned program")
 
     print("%s: OK" % (os.path.basename(__file__)))
 
-- 
2.43.0.rc1.413.gea7ed67945-goog


