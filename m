Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F526F694F
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 12:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjEDKy2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 May 2023 06:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjEDKy1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 May 2023 06:54:27 -0400
X-Greylist: delayed 478 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 04 May 2023 03:54:24 PDT
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E326349F7
        for <bpf@vger.kernel.org>; Thu,  4 May 2023 03:54:24 -0700 (PDT)
Received: from 102.wangsu.com (unknown [59.61.78.234])
        by app2 (Coremail) with SMTP id SyJltAB3fibrjFNko5kBAA--.618S2;
        Thu, 04 May 2023 18:46:04 +0800 (CST)
From:   Pengcheng Yang <yangpc@wangsu.com>
To:     Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, Pengcheng Yang <yangpc@wangsu.com>
Subject: [PATCH bpf-next] bpftool: Support bpffs mountpoint as pin path for prog loadall
Date:   Thu,  4 May 2023 18:45:38 +0800
Message-Id: <1683197138-1894-1-git-send-email-yangpc@wangsu.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: SyJltAB3fibrjFNko5kBAA--.618S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJF4xJF4xurWUZF4DWrykZrb_yoW5AFykpw
        4DJryrKr18Xr15ua17CFs8GrW3Grn3WFy0kF4UZ345Zr48t3s0qa17KF4Fgw15Wr13tayx
        Zasa934vvF1fZaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvY1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
        84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
        8CrVACY4xI64kE6c02F40Ex7xfMcIj64x0Y40En7xvr7AKxVWUJVW8JwAv7VCjz48v1sIE
        Y20_Gr4lYx0Ec7CjxVAajcxG14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0x
        vY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r4DMxAIw28IcxkI
        7VAKI48JMxAIw28IcVCjz48v1sIEY20_Gr4l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
        6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
        xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0J
        jrBMNUUUUU=
X-CM-SenderInfo: p1dqw1nf6zt0xjvxhudrp/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, when using prog loadall, if the pin path is a bpffs
mountpoint, bpffs will be repeatedly mounted to the parent directory
of the bpffs mountpoint path.

For example,
    $ bpftool prog loadall test.o /sys/fs/bpf
currently bpffs will be repeatedly mounted to /sys/fs.

Signed-off-by: Pengcheng Yang <yangpc@wangsu.com>
---
 tools/bpf/bpftool/common.c | 9 ++++++---
 tools/bpf/bpftool/iter.c   | 2 +-
 tools/bpf/bpftool/main.h   | 2 +-
 tools/bpf/bpftool/prog.c   | 2 +-
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index 5a73ccf14332..880fcb45f89f 100644
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
index 0ef373cef4c7..665f23f68066 100644
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
index afbe3ec342c8..473ec01c00d6 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -1747,7 +1747,7 @@ static int load_with_options(int argc, char **argv, bool first_prog_only)
 		goto err_close_obj;
 	}
 
-	err = mount_bpffs_for_pin(pinfile);
+	err = mount_bpffs_for_pin(pinfile, !first_prog_only);
 	if (err)
 		goto err_close_obj;
 
-- 
2.38.1

