Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA1C94A3AC7
	for <lists+bpf@lfdr.de>; Sun, 30 Jan 2022 23:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241956AbiA3WvG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 30 Jan 2022 17:51:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27271 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233869AbiA3WvG (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 30 Jan 2022 17:51:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643583065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=CEJtYC/ux9V7Xcz3H8zZRGhZ6hJ78FKjbpvst1x3iao=;
        b=MkQPaSGghvmNf5ZQSQrZ2AvX58WjsnXBjr9FtqIdNTJz09tDUt4ArMbfvknHcIbzjAo9c7
        mEBllmScspmmroCC5CQrOLfwNlN9hazPGY5R6nN2AB0Z34YnDQlYzHWc9JxlckRFV2AaDK
        gjIB74bWLMU3fkq86MetLaUVD6N49j0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-492-c4P3OP6DPTyUQZKA3cPKKA-1; Sun, 30 Jan 2022 17:51:04 -0500
X-MC-Unique: c4P3OP6DPTyUQZKA3cPKKA-1
Received: by mail-wm1-f72.google.com with SMTP id l20-20020a05600c1d1400b0035153bf34c3so6704891wms.2
        for <bpf@vger.kernel.org>; Sun, 30 Jan 2022 14:51:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CEJtYC/ux9V7Xcz3H8zZRGhZ6hJ78FKjbpvst1x3iao=;
        b=4UmmDkuEh8bq2JvSow712t8PpWig5yu3cC429Z+nz1N5AXhPWdHWFS9neuEbdP8nQ0
         w50jamuiOZ4kdtSNXoS3IpezDQXsbbfjO0ypRQnP3kxfDrmVIUoqziTWE/IU+gCzZmFK
         XEcfU1XtbPX+aU0r8L8hokK9Emc2BLYraaiDXPlbZPm6xR/FFfxihkWAXdaGuevrX+3z
         RdLeGaeaFRy/orx4VUpea/Sf8Om/xOjICImRyqY7lqE2+ShKSksSVldUdEYR0EHOJ9A5
         jcga6H52lHz9qsr9yrrO4wc5UJIZ4uLOVKiSuFp34A3bYJ3nS1owoeyelPGlsRTJOn6X
         m+qw==
X-Gm-Message-State: AOAM533OModDUrjGUGh8EvzM8vGdXfmmg9KYiQyh8KkvN1DtZJjp9eYF
        Jsbj0NbHTUWrQxR8JK8CRRrlrghokJnzIf3MXxRpW7hlffLkspP6RRWAc8eV9L4vE3o/cgA3K1j
        Wxkza95YIqrkd
X-Received: by 2002:a05:6000:11cb:: with SMTP id i11mr15047139wrx.19.1643583062894;
        Sun, 30 Jan 2022 14:51:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxNMYOMGCWToKpdzI1/qcneuiwFkDNoNMorUn6kmTaBO2y0zoRoKbuOxTjvZrDqB2vj4CtDAA==
X-Received: by 2002:a05:6000:11cb:: with SMTP id i11mr15047118wrx.19.1643583062694;
        Sun, 30 Jan 2022 14:51:02 -0800 (PST)
Received: from krava.redhat.com ([83.240.63.12])
        by smtp.gmail.com with ESMTPSA id c11sm11851213wri.43.2022.01.30.14.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 14:51:02 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Jiri Pirko <jiri@mellanox.com>
Subject: [RFC] failing selftests/bpf/test_offload.py
Date:   Sun, 30 Jan 2022 23:51:01 +0100
Message-Id: <20220130225101.47514-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

hi,
I have failing test_offload.py with following output:

  # ./test_offload.py
  ...
  Test bpftool bound info reporting (own ns)...
  FAIL: 3 BPF maps loaded, expected 2
    File "/root/bpf-next/tools/testing/selftests/bpf/./test_offload.py", line 1177, in <module>
      check_dev_info(False, "")
    File "/root/bpf-next/tools/testing/selftests/bpf/./test_offload.py", line 645, in check_dev_info
      maps = bpftool_map_list(expected=2, ns=ns)
    File "/root/bpf-next/tools/testing/selftests/bpf/./test_offload.py", line 190, in bpftool_map_list
      fail(True, "%d BPF maps loaded, expected %d" %
    File "/root/bpf-next/tools/testing/selftests/bpf/./test_offload.py", line 86, in fail
      tb = "".join(traceback.extract_stack().format())

it fails to detect maps from bpftool's feature detection,
that did not make it yet through deferred removal

with the fix below I have this subtest passed, but it fails
further on:

  # ./test_offload.py
  ...
  Test bpftool bound info reporting (own ns)...
  Test bpftool bound info reporting (other ns)...
  Test bpftool bound info reporting (remote ns)...
  Test bpftool bound info reporting (back to own ns)...
  Test bpftool bound info reporting (removed dev)...
  Test map update (no flags)...
  Test map update (exists)...
  Test map update (noexist)...
  Test map dump...
  Test map dump...
  Traceback (most recent call last):
    File "/root/bpf-next/tools/testing/selftests/bpf/./test_offload.py", line 1251, in <module>
      _, entries = bpftool("map dump id %d" % (m["id"]))
    File "/root/bpf-next/tools/testing/selftests/bpf/./test_offload.py", line 169, in bpftool
      return tool("bpftool", args, {"json":"-p"}, JSON=JSON, ns=ns,
    File "/root/bpf-next/tools/testing/selftests/bpf/./test_offload.py", line 155, in tool
      ret, stdout = cmd(ns + name + " " + params + args,
    File "/root/bpf-next/tools/testing/selftests/bpf/./test_offload.py", line 109, in cmd
      return cmd_result(proc, include_stderr=include_stderr, fail=fail)
    File "/root/bpf-next/tools/testing/selftests/bpf/./test_offload.py", line 131, in cmd_result
      raise Exception("Command failed: %s\n%s" % (proc.args, stderr))
  Exception: Command failed: bpftool -p map dump id 4325

the test seems to expect maps having BTF loaded, which for some reason
did not happen, so the test fails with bpftool pretty dump fail

the test loads the object with 'ip link ...', which I never touched,
so I wanted ask first before I dive in, perhaps I miss some setup

thoughts? ;-)

thanks,
jirka
---
 tools/lib/bpf/libbpf.c                      | 6 +++---
 tools/testing/selftests/bpf/test_offload.py | 6 +++++-
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 4ce94f4ed34a..881c88eceed0 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4407,7 +4407,7 @@ static int probe_kern_global_data(void)
 	};
 	int ret, map, insn_cnt = ARRAY_SIZE(insns);
 
-	map = bpf_map_create(BPF_MAP_TYPE_ARRAY, NULL, sizeof(int), 32, 1, NULL);
+	map = bpf_map_create(BPF_MAP_TYPE_ARRAY, "global_data", sizeof(int), 32, 1, NULL);
 	if (map < 0) {
 		ret = -errno;
 		cp = libbpf_strerror_r(ret, errmsg, sizeof(errmsg));
@@ -4540,7 +4540,7 @@ static int probe_kern_array_mmap(void)
 	LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags = BPF_F_MMAPABLE);
 	int fd;
 
-	fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, NULL, sizeof(int), sizeof(int), 1, &opts);
+	fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, "array_mmap", sizeof(int), sizeof(int), 1, &opts);
 	return probe_fd(fd);
 }
 
@@ -4587,7 +4587,7 @@ static int probe_prog_bind_map(void)
 	};
 	int ret, map, prog, insn_cnt = ARRAY_SIZE(insns);
 
-	map = bpf_map_create(BPF_MAP_TYPE_ARRAY, NULL, sizeof(int), 32, 1, NULL);
+	map = bpf_map_create(BPF_MAP_TYPE_ARRAY, "bind_map_detect", sizeof(int), 32, 1, NULL);
 	if (map < 0) {
 		ret = -errno;
 		cp = libbpf_strerror_r(ret, errmsg, sizeof(errmsg));
diff --git a/tools/testing/selftests/bpf/test_offload.py b/tools/testing/selftests/bpf/test_offload.py
index edaffd43da83..0cf93d246804 100755
--- a/tools/testing/selftests/bpf/test_offload.py
+++ b/tools/testing/selftests/bpf/test_offload.py
@@ -769,7 +769,11 @@ skip(ret != 0, "bpftool not installed")
 base_progs = progs
 _, base_maps = bpftool("map")
 base_map_names = [
-    'pid_iter.rodata' # created on each bpftool invocation
+    # created on each bpftool invocation
+    'pid_iter.rodata',
+    'bind_map_detect',
+    'global_data',
+    'array_mmap',
 ]
 
 # Check netdevsim
-- 
2.31.1

