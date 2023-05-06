Return-Path: <bpf+bounces-174-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3F86F8E31
	for <lists+bpf@lfdr.de>; Sat,  6 May 2023 05:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A06A028112A
	for <lists+bpf@lfdr.de>; Sat,  6 May 2023 03:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7434F15B6;
	Sat,  6 May 2023 03:07:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD747E
	for <bpf@vger.kernel.org>; Sat,  6 May 2023 03:07:43 +0000 (UTC)
X-Greylist: delayed 145275 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 05 May 2023 20:07:40 PDT
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 53C5EE7D
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 20:07:39 -0700 (PDT)
Received: from 102.wangsu.com (unknown [59.61.78.234])
	by app2 (Coremail) with SMTP id SyJltABney50xFVkQlMCAA--.1079S2;
	Sat, 06 May 2023 11:07:32 +0800 (CST)
From: Pengcheng Yang <yangpc@wangsu.com>
To: Quentin Monnet <quentin@isovalent.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@google.com>
Cc: bpf@vger.kernel.org,
	Pengcheng Yang <yangpc@wangsu.com>
Subject: [PATCH v2 bpf-next] bpftool: Support bpffs mountpoint as pin path for prog loadall
Date: Sat,  6 May 2023 11:07:19 +0800
Message-Id: <1683342439-3677-1-git-send-email-yangpc@wangsu.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID:SyJltABney50xFVkQlMCAA--.1079S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJF4xJF4fZr1fuF43uryUZFb_yoW5Kw1Upw
	4DXryrKry8Xr15ua17GFs8GrW3Krn3WFy0kF4UZ345Zr48t3s0qa17KF4Fgw15XF13tFW3
	Zasa934v9F4fZaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvF1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0EF7xvrVAajcxG14v26r4j6F4UMcIj6x8ErcxFaVAv
	8VW8GwAv7VCY1x0262k0Y48FwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2
	IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8GwCF04k20xvY
	0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r48MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
	tVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvj
	fUYzuAUUUUU
X-CM-SenderInfo: p1dqw1nf6zt0xjvxhudrp/
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,
	T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Currently, when using prog loadall, if the pin path is a bpffs
mountpoint, bpffs will be repeatedly mounted to the parent directory
of the bpffs mountpoint path.

For example,
    $ bpftool prog loadall test.o /sys/fs/bpf
currently bpffs will be repeatedly mounted to /sys/fs.

Signed-off-by: Pengcheng Yang <yangpc@wangsu.com>
---
v2: compatible with commit 0232b7889786 ("bpftool: Register struct_ops with a link.")

 tools/bpf/bpftool/common.c     | 9 ++++++---
 tools/bpf/bpftool/iter.c       | 2 +-
 tools/bpf/bpftool/main.h       | 2 +-
 tools/bpf/bpftool/prog.c       | 2 +-
 tools/bpf/bpftool/struct_ops.c | 2 +-
 5 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index 1360c82ae732..cc6e6aae2447 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -68,7 +68,7 @@ void p_info(const char *fmt, ...)
 	va_end(ap);
 }
 
-static bool is_bpffs(char *path)
+static bool is_bpffs(const char *path)
 {
 	struct statfs st_fs;
 
@@ -244,13 +244,16 @@ int open_obj_pinned_any(const char *path, enum bpf_obj_type exp_type)
 	return fd;
 }
 
-int mount_bpffs_for_pin(const char *name)
+int mount_bpffs_for_pin(const char *name, bool is_dir)
 {
 	char err_str[ERR_MAX_LEN];
 	char *file;
 	char *dir;
 	int err = 0;
 
+	if (is_dir && is_bpffs(name))
+		return err;
+
 	file = malloc(strlen(name) + 1);
 	if (!file) {
 		p_err("mem alloc failed");
@@ -286,7 +289,7 @@ int do_pin_fd(int fd, const char *name)
 {
 	int err;
 
-	err = mount_bpffs_for_pin(name);
+	err = mount_bpffs_for_pin(name, false);
 	if (err)
 		return err;
 
diff --git a/tools/bpf/bpftool/iter.c b/tools/bpf/bpftool/iter.c
index 9a1d2365a297..6b0e5202ca7a 100644
--- a/tools/bpf/bpftool/iter.c
+++ b/tools/bpf/bpftool/iter.c
@@ -76,7 +76,7 @@ static int do_pin(int argc, char **argv)
 		goto close_obj;
 	}
 
-	err = mount_bpffs_for_pin(path);
+	err = mount_bpffs_for_pin(path, false);
 	if (err)
 		goto close_link;
 
diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index a49534d7eafa..b8bb08d10dec 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -142,7 +142,7 @@ const char *get_fd_type_name(enum bpf_obj_type type);
 char *get_fdinfo(int fd, const char *key);
 int open_obj_pinned(const char *path, bool quiet);
 int open_obj_pinned_any(const char *path, enum bpf_obj_type exp_type);
-int mount_bpffs_for_pin(const char *name);
+int mount_bpffs_for_pin(const char *name, bool is_dir);
 int do_pin_any(int argc, char **argv, int (*get_fd_by_id)(int *, char ***));
 int do_pin_fd(int fd, const char *name);
 
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 91b6075b2db3..1f736dc29824 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -1739,7 +1739,7 @@ static int load_with_options(int argc, char **argv, bool first_prog_only)
 		goto err_close_obj;
 	}
 
-	err = mount_bpffs_for_pin(pinfile);
+	err = mount_bpffs_for_pin(pinfile, !first_prog_only);
 	if (err)
 		goto err_close_obj;
 
diff --git a/tools/bpf/bpftool/struct_ops.c b/tools/bpf/bpftool/struct_ops.c
index 57c3da70aa31..3ebc9fe91e0e 100644
--- a/tools/bpf/bpftool/struct_ops.c
+++ b/tools/bpf/bpftool/struct_ops.c
@@ -509,7 +509,7 @@ static int do_register(int argc, char **argv)
 	if (argc == 1)
 		linkdir = GET_ARG();
 
-	if (linkdir && mount_bpffs_for_pin(linkdir)) {
+	if (linkdir && mount_bpffs_for_pin(linkdir, true)) {
 		p_err("can't mount bpffs for pinning");
 		return -1;
 	}
-- 
2.38.1


