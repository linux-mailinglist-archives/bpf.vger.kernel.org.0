Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 574B6451F9E
	for <lists+bpf@lfdr.de>; Tue, 16 Nov 2021 01:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347613AbhKPAop (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Nov 2021 19:44:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355647AbhKPAmC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Nov 2021 19:42:02 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21BBC073AE8
        for <bpf@vger.kernel.org>; Mon, 15 Nov 2021 14:59:02 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id a9so7511154wrr.8
        for <bpf@vger.kernel.org>; Mon, 15 Nov 2021 14:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DEu+/0Uo0bX5qI56OsGdrgFaUhYFsq5X60ae1Fzxs1w=;
        b=eImlGY3ElbYBvmcTxjkF57iHoXpUgMlKJbX/6zViCKARI12oEq+eIpqo5kbEdB+rGi
         a3/wKTtTI/Ltz0SNa54OEZdXAN51GZypZiucs/NzX4vIXWOtiNk8XahS8DQa8pk5AMCF
         7F9Cgl1ffeIH0ioSKnaz7BMhfIuZFFSCIkw61GT5PzTlfXU2qknqMdGuZHRsguVlpO4q
         S0QmPPxuy2i3Yb5HHdykc+LeBn8SZsmnM9nlO1dyNhldskXShGF43ohhbapt+ykvb2Fa
         DCLCAkJc3JJ8bOzgUXIo6ojC5JJYTHuyinj1C844V//HPupf5PpzBBHagZVNXhZiq0sA
         46sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DEu+/0Uo0bX5qI56OsGdrgFaUhYFsq5X60ae1Fzxs1w=;
        b=KJ+5kFtnH6EThNxtbX4YESkyezFdGVYHTuCo0XIc2UEbTO9oilIm0Pxsle+3Ln1e0o
         sd4YaUzVajyAkxHc+DZWDgXP54Ibuna5UAPYW35bmiAVHeycUldm3F97nqypnxaNDDWj
         hp/8WniLQ3ivYgsZ34WAdZM6v/GOersykyJcn1iYmyMLyrdlC+gqnVB8K8P8VcfdaLLo
         MIP/eCFoYF4PSxk/6plCwLucvE7CFB94WSM+xE9YLUXlvwFjHAaPrNxcXoP6Q7s4bIdq
         ab/7o1WUarscg5KW6E8EY/yVq81sgu6+0538DIx/rfB4bjvmeAymNExFtwGkH6Wgm7rw
         p9Og==
X-Gm-Message-State: AOAM533PvUG26feJpSbhz3bn9+SKqxQWh24Oc1BjnTHvqk7b54EYbc51
        Jpt+2HOpY4+Udzxj2BqQed/fNA==
X-Google-Smtp-Source: ABdhPJxtiLyislFBOupifs0fcAUTYosfDdRrXDbN+MP2BGpz41+kSCzHmOEl0d/2H+mC2RdG6aczdw==
X-Received: by 2002:a5d:648e:: with SMTP id o14mr3336147wri.141.1637017141440;
        Mon, 15 Nov 2021 14:59:01 -0800 (PST)
Received: from localhost.localdomain ([149.86.89.157])
        by smtp.gmail.com with ESMTPSA id y12sm15467619wrn.73.2021.11.15.14.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 14:59:00 -0800 (PST)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next 3/3] selftests/bpf: Configure dir paths via env in test_bpftool_synctypes.py
Date:   Mon, 15 Nov 2021 22:58:44 +0000
Message-Id: <20211115225844.33943-4-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211115225844.33943-1-quentin@isovalent.com>
References: <20211115225844.33943-1-quentin@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Script test_bpftool_synctypes.py parses a number of files in the bpftool
directory (or even elsewhere in the repo) to make sure that the list of
types or options in those different files are consistent. Instead of
having fixed paths, let's make the directories configurable through
environment variable. This should make easier in the future to run the
script in a different setup, for example on an out-of-tree bpftool
mirror with a different layout.

Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 .../selftests/bpf/test_bpftool_synctypes.py   | 26 ++++++++++++-------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_bpftool_synctypes.py b/tools/testing/selftests/bpf/test_bpftool_synctypes.py
index 3f6e562565ec..6bf21e47882a 100755
--- a/tools/testing/selftests/bpf/test_bpftool_synctypes.py
+++ b/tools/testing/selftests/bpf/test_bpftool_synctypes.py
@@ -9,7 +9,15 @@ import os, sys
 
 LINUX_ROOT = os.path.abspath(os.path.join(__file__,
     os.pardir, os.pardir, os.pardir, os.pardir, os.pardir))
-BPFTOOL_DIR = os.path.join(LINUX_ROOT, 'tools/bpf/bpftool')
+BPFTOOL_DIR = os.getenv('BPFTOOL_DIR',
+    os.path.join(LINUX_ROOT, 'tools/bpf/bpftool'))
+BPFTOOL_BASHCOMP_DIR = os.getenv('BPFTOOL_BASHCOMP_DIR',
+    os.path.join(BPFTOOL_DIR, 'bash-completion'))
+BPFTOOL_DOC_DIR = os.getenv('BPFTOOL_DOC_DIR',
+    os.path.join(BPFTOOL_DIR, 'Documentation'))
+INCLUDE_DIR = os.getenv('INCLUDE_DIR',
+    os.path.join(LINUX_ROOT, 'tools/include'))
+
 retval = 0
 
 class BlockParser(object):
@@ -300,7 +308,7 @@ class ManSubstitutionsExtractor(SourceFileExtractor):
     """
     An extractor for substitutions.rst
     """
-    filename = os.path.join(BPFTOOL_DIR, 'Documentation/substitutions.rst')
+    filename = os.path.join(BPFTOOL_DOC_DIR, 'substitutions.rst')
 
     def get_common_options(self):
         """
@@ -393,7 +401,7 @@ class BpfHeaderExtractor(FileExtractor):
     """
     An extractor for the UAPI BPF header.
     """
-    filename = os.path.join(LINUX_ROOT, 'tools/include/uapi/linux/bpf.h')
+    filename = os.path.join(INCLUDE_DIR, 'uapi/linux/bpf.h')
 
     def get_prog_types(self):
         return self.get_enum('bpf_prog_type')
@@ -417,7 +425,7 @@ class ManProgExtractor(ManPageExtractor):
     """
     An extractor for bpftool-prog.rst.
     """
-    filename = os.path.join(BPFTOOL_DIR, 'Documentation/bpftool-prog.rst')
+    filename = os.path.join(BPFTOOL_DOC_DIR, 'bpftool-prog.rst')
 
     def get_attach_types(self):
         return self.get_rst_list('ATTACH_TYPE')
@@ -426,7 +434,7 @@ class ManMapExtractor(ManPageExtractor):
     """
     An extractor for bpftool-map.rst.
     """
-    filename = os.path.join(BPFTOOL_DIR, 'Documentation/bpftool-map.rst')
+    filename = os.path.join(BPFTOOL_DOC_DIR, 'bpftool-map.rst')
 
     def get_map_types(self):
         return self.get_rst_list('TYPE')
@@ -435,7 +443,7 @@ class ManCgroupExtractor(ManPageExtractor):
     """
     An extractor for bpftool-cgroup.rst.
     """
-    filename = os.path.join(BPFTOOL_DIR, 'Documentation/bpftool-cgroup.rst')
+    filename = os.path.join(BPFTOOL_DOC_DIR, 'bpftool-cgroup.rst')
 
     def get_attach_types(self):
         return self.get_rst_list('ATTACH_TYPE')
@@ -454,7 +462,7 @@ class BashcompExtractor(FileExtractor):
     """
     An extractor for bpftool's bash completion file.
     """
-    filename = os.path.join(BPFTOOL_DIR, 'bash-completion/bpftool')
+    filename = os.path.join(BPFTOOL_BASHCOMP_DIR, 'bpftool')
 
     def get_prog_attach_types(self):
         return self.get_bashcomp_list('BPFTOOL_PROG_ATTACH_TYPES')
@@ -605,7 +613,7 @@ def main():
         help_cmd_options = source_info.get_options()
         source_info.close()
 
-        man_cmd_info = ManGenericExtractor(os.path.join('Documentation', 'bpftool-' + cmd + '.rst'))
+        man_cmd_info = ManGenericExtractor(os.path.join(BPFTOOL_DOC_DIR, 'bpftool-' + cmd + '.rst'))
         man_cmd_options = man_cmd_info.get_options()
         man_cmd_info.close()
 
@@ -616,7 +624,7 @@ def main():
     help_main_options = source_main_info.get_options()
     source_main_info.close()
 
-    man_main_info = ManGenericExtractor(os.path.join('Documentation', 'bpftool.rst'))
+    man_main_info = ManGenericExtractor(os.path.join(BPFTOOL_DOC_DIR, 'bpftool.rst'))
     man_main_options = man_main_info.get_options()
     man_main_info.close()
 
-- 
2.32.0

