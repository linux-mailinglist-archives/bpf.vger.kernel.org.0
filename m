Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98A3E2CA5EA
	for <lists+bpf@lfdr.de>; Tue,  1 Dec 2020 15:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389478AbgLAOkS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Dec 2020 09:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389462AbgLAOkR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Dec 2020 09:40:17 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F9DC0613D4
        for <bpf@vger.kernel.org>; Tue,  1 Dec 2020 06:39:37 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id v14so3336876wml.1
        for <bpf@vger.kernel.org>; Tue, 01 Dec 2020 06:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gil/YkV/qEojPCDRG+9N2VK29191DcVOXW+Q/DLuqGs=;
        b=d8sGd9/QHyX9OItvcKoZ8vDuw0MJDRFNvdvYkfsjk4U4cfAHtOWgwuJSuphCHnuOaN
         vCK9Hvf4iMZXfUpRjzAHXO7lJ+tkLRMIMlxzlyAlB1XREYzPej/IO907KmM0Tinz/Lb2
         aGsFAKhDDeGsdtJrnMljya2+kcOS+Iuq+BrFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gil/YkV/qEojPCDRG+9N2VK29191DcVOXW+Q/DLuqGs=;
        b=XsQDkVm1J3OGXObGyI7pGTBvw4CciGMGatKfNA5a/wPhlJJJ3lXgnqIPbF6ZFOjX1x
         jEVdgrfUYVxBEsEoidiMKd3pF6hoZCnHxge4L57yMf77GBV/HtY7QxIkKhri32csRX9Z
         PBeE6gmwCJTp/AJHwHzFXHaP6iLWpvXk0oyUeivN61HINJghvedZ+h0c73vGWHo/nb83
         byTHcSzdukf2lYXpldw8aD6nmkPAh+YikHMWqyg0LD+ARSOirp5n+zZM75j502nkGiyL
         rrx83Rw+EQM3C66rBPfZq04u55lkH3D15uD8Sw/lJ3AU5e+0dGkyJ4GxVWRx/Qe+Watn
         EuFw==
X-Gm-Message-State: AOAM532nk/CgUcj4ALPaLWMLFGq6VB+PKY0YJj5e+BV5/TWeEZnZqxqZ
        DjJSxU1fA1tIwOjE5yxH3UcdjCWBR9DXwyFn
X-Google-Smtp-Source: ABdhPJyiu5JpvttgROO+HOisz1TOAbEhfOyT9DkLkLzjkgaV9ZqRjbD/75twaWv03Utwykfwq6GGCw==
X-Received: by 2002:a1c:2c4:: with SMTP id 187mr1505666wmc.187.1606833575464;
        Tue, 01 Dec 2020 06:39:35 -0800 (PST)
Received: from kpsingh.c.googlers.com.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id i8sm61199wma.32.2020.12.01.06.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 06:39:34 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     bpf@vger.kernel.org
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next 1/2] selftests/bpf: Update ima test helper's losetup commands
Date:   Tue,  1 Dec 2020 14:39:23 +0000
Message-Id: <20201201143924.2908241-1-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

Update the commands to use the bare minimum options so that it works
in busybox environments.

Fixes: 34b82d3ac105 ("bpf: Add a selftest for bpf_ima_inode_hash")
Reported-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: KP Singh <kpsingh@google.com>
---
 tools/testing/selftests/bpf/ima_setup.sh | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/ima_setup.sh b/tools/testing/selftests/bpf/ima_setup.sh
index 15490ccc5e55..ed29bde26a12 100755
--- a/tools/testing/selftests/bpf/ima_setup.sh
+++ b/tools/testing/selftests/bpf/ima_setup.sh
@@ -3,6 +3,7 @@
 
 set -e
 set -u
+set -o pipefail
 
 IMA_POLICY_FILE="/sys/kernel/security/ima/policy"
 TEST_BINARY="/bin/true"
@@ -23,9 +24,10 @@ setup()
 
         dd if=/dev/zero of="${mount_img}" bs=1M count=10
 
-        local loop_device="$(losetup --find --show ${mount_img})"
+        losetup -f "${mount_img}"
+        local loop_device=$(losetup -a | grep ${mount_img:?} | cut -d ":" -f1)
 
-        mkfs.ext4 "${loop_device}"
+        mkfs.ext4 "${loop_device:?}"
         mount "${loop_device}" "${mount_dir}"
 
         cp "${TEST_BINARY}" "${mount_dir}"
@@ -38,7 +40,8 @@ cleanup() {
         local mount_img="${tmp_dir}/test.img"
         local mount_dir="${tmp_dir}/mnt"
 
-        local loop_devices=$(losetup -j ${mount_img} -O NAME --noheadings)
+        local loop_devices=$(losetup -a | grep ${mount_img:?} | cut -d ":" -f1)
+
         for loop_dev in "${loop_devices}"; do
                 losetup -d $loop_dev
         done
-- 
2.29.2.454.gaff20da3a2-goog

