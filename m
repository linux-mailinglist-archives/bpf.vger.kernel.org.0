Return-Path: <bpf+bounces-15710-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 648A87F5356
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 23:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2FC4B20F20
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 22:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F876208B9;
	Wed, 22 Nov 2023 22:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1jNYwU+4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2323919E
	for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 14:23:40 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-6bdd2f09939so324235b3a.1
        for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 14:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700691819; x=1701296619; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qbZkilK+2GPPK5gRSFy0+hBTdndgvFzZuH6276NZUa4=;
        b=1jNYwU+4jKe9QikMsEnY5ia+/sk2+pZx+neFhiWRUz1u8ndecgcFFHUNxrBxefMLaE
         pLk0Eq7u9uhaUqh9s1wwWLhGeJCR7pOR6qJFxB/XRmDFk6J/nWYtYIDsGTO+9GL/JVbX
         jeH5XA5tg207kY6PPg4vXRkH7cH501hAZ9Mq4SbKH1OulavTME49fBM2dSbBBUeIRkwP
         EBnp75Sg3a5NUyV4POmAM7H8t9iGqlMx7xL71RlEX1ueJfhA3CPq6ZsikuhGMcKxZQZL
         5cUCmwXdGGICVM3zDM1jj4fpLWcNU9qSc+NmCi9GrN0qxcm/O7QMXVPNU4r8XdJdRL3c
         i7CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700691819; x=1701296619;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qbZkilK+2GPPK5gRSFy0+hBTdndgvFzZuH6276NZUa4=;
        b=l5D5gQBWc+4cyfqa4p8xtfBAip06O9pSJm9VAnMbP4XIVjUCESsSl3NRiVwLnO0sPc
         +hsFeHwwL3kDCNBOPkkZgr1IMwu0OBoDH5hLmZAOsRmU2vpyYj7bfsK8IRIlIDztMMK0
         AeDw5zaSSoEP9NSREzIHeqTT/EjKOOVCHpjWWKArc4lvKsOl7BLGHMehNPhVDzplg8Y0
         aFhcBNN7LNbF/7RNrsyAfX3JCPipTDLdFTmxFLhp6+T3YymshfQZnfwlPrKj1B60lG91
         vi0TdvNuu4x3IcBMgQPt99RNhxMatrrSItelwuQ4YRvihHxX1tFwitdS/t2olafWus6K
         LF1w==
X-Gm-Message-State: AOJu0YxebzEyqL0ADqpg5LB1hB7thq/3jb6I2IEG6omjmRYcj5xjsnpv
	zAJxgmtUdETiTgzzxKYYnp+8Kiutb4OuyX418R7sbLM29LhitYWN1U3PaGxRwL7sVTwiFNwfzFc
	9kMB+kovCxrkHXMP92ZlC5/SaxXfJh49AhkGcomgu3Dqv+XMInQ==
X-Google-Smtp-Source: AGHT+IHHWy8S+OOJ92hYw+7xOPYUZPBATTib4bR/2G3jJw/NiTXovkgpWXc+ISNUqwoMfpWsXMBpyyU=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:1c8f:b0:6cb:95ab:cf8d with SMTP id
 y15-20020a056a001c8f00b006cb95abcf8dmr870773pfw.6.1700691819171; Wed, 22 Nov
 2023 14:23:39 -0800 (PST)
Date: Wed, 22 Nov 2023 14:23:35 -0800
In-Reply-To: <20231122222335.1799186-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231122222335.1799186-1-sdf@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231122222335.1799186-2-sdf@google.com>
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: update test_offload to use new
 orphaned property
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"

- filter orphaned programs by default
- when trying to query orphaned program, don't expect bpftool failure

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


