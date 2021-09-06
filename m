Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2F53401EC0
	for <lists+bpf@lfdr.de>; Mon,  6 Sep 2021 18:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237374AbhIFQ40 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Sep 2021 12:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbhIFQ4Z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Sep 2021 12:56:25 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3EAC061575
        for <bpf@vger.kernel.org>; Mon,  6 Sep 2021 09:55:20 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id m26so6032148pff.3
        for <bpf@vger.kernel.org>; Mon, 06 Sep 2021 09:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OQtojEzi86PrcQS/2JsvMLjtdNeBqpS7cKAUKFmfV3k=;
        b=juI4tpgAJdJKgq7MH+VRKO4K4LJ9nmOavJgCqGMBT/Tt0jwEZ4wEhoNfl7g0J/cRfQ
         VJB2FhOx5VUdzKP9Y1cATJmRcoEZ5QzGJ2RhHvwMAHBLzJ4YZHU+3PAB756nAJTVry6k
         aaqMggSrcSpferSL0Ns6TP1YiuM8+aiaXGArfE9bhicM4pnz3hzEr+R4L0FnKMhWIe0c
         6JZr7QbRx09OvCKHANDkkQwbqqyAa5P7NmZguxgi8zIO9CuCcEnrj7yGtFFLhjDTX2Vx
         Vj4bH/L6dBqHnuGfPJ8D1Ss2dk1twgQJgSxR4Re9VHwtte20gA9u+ucVKmTr8RMp2zhW
         v9KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OQtojEzi86PrcQS/2JsvMLjtdNeBqpS7cKAUKFmfV3k=;
        b=Sr+zuDp7xiQHkls/Xyv0gpapF+ue9K/1NXvUsA7V3yU1gFTEPaJyjopVZwZTFrbFIe
         5O5ecVyU3aYUHDdfuKms6zKtzbhhGwQwoBBeCm0e7W3JQdYcpG4Jx7abw8QOGCoejiEp
         r0kxHU6P91roet6KTh+Hito/9mghYu/un0AOB5xt1v83I9PyxBfc88HH8bSq4rYYVaZP
         lujT9UCvtVRYf0JsyhpM/M2KjDONzfBkHm3Y0jjmsiCB8SHBehevmAyaV2O/Arm2dBGK
         ueh2HsGFhrhlbShJU/GGZtW8M2kBAEQ+ft/nhIyB49hgq3keghPoVqN9orJdb2Z418/O
         nV3Q==
X-Gm-Message-State: AOAM532LrUmPRLgXW81nvuSRUieiO763ZMy7QCJo9SBq6OtcKmIf96C/
        +8yMV1xLDcWStX+GAWyLOiiV7/e51jiNHA==
X-Google-Smtp-Source: ABdhPJwImFDjQVEbtrabsXLEqCwa8SzhDyZjfw8+5ZCEsAJ3qAv0pCQy2RIPmH5bZ71YHsCIlSX3Hw==
X-Received: by 2002:a63:4e65:: with SMTP id o37mr13298874pgl.202.1630947320193;
        Mon, 06 Sep 2021 09:55:20 -0700 (PDT)
Received: from localhost.localdomain ([119.28.83.143])
        by smtp.gmail.com with ESMTPSA id d8sm38189pjr.17.2021.09.06.09.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 09:55:20 -0700 (PDT)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, hengqi.chen@gmail.com
Subject: [PATCH bpf-next 2/2] selftests/bpf: Replace bpf_{map,program}__next with bpf_object__next_{map,program}
Date:   Tue,  7 Sep 2021 00:54:56 +0800
Message-Id: <20210906165456.325999-2-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210906165456.325999-1-hengqi.chen@gmail.com>
References: <20210906165456.325999-1-hengqi.chen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Replace deprecated bpf_{map,program}__next APIs with newly added
bpf_object__next_{map,program} APIs, so that no compilation warnings
emit.

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/btf.c              | 2 +-
 tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c    | 2 +-
 tools/testing/selftests/bpf/prog_tests/select_reuseport.c | 2 +-
 tools/testing/selftests/bpf/prog_tests/tcp_rtt.c          | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index 649f87382c8d..77b297f6c003 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -4268,7 +4268,7 @@ static void do_test_file(unsigned int test_num)
 	if (CHECK(err, "obj: %d", err))
 		return;

-	prog = bpf_program__next(NULL, obj);
+	prog = bpf_object__next_program(NULL, obj);
 	if (CHECK(!prog, "Cannot find bpf_prog")) {
 		err = -1;
 		goto done;
diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
index 73b4c76e6b86..68205b172a7d 100644
--- a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
+++ b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
@@ -288,7 +288,7 @@ static void test_fmod_ret_freplace(void)
 	if (CHECK(err, "freplace_obj_load", "err %d\n", err))
 		goto out;

-	prog = bpf_program__next(NULL, freplace_obj);
+	prog = bpf_object__next_program(NULL, freplace_obj);
 	freplace_link = bpf_program__attach_trace(prog);
 	if (!ASSERT_OK_PTR(freplace_link, "freplace_attach_trace"))
 		goto out;
diff --git a/tools/testing/selftests/bpf/prog_tests/select_reuseport.c b/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
index 4efd337d6a3c..55957b42bc23 100644
--- a/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
+++ b/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
@@ -114,7 +114,7 @@ static int prepare_bpf_obj(void)
 	err = bpf_object__load(obj);
 	RET_ERR(err, "load bpf_object", "err:%d\n", err);

-	prog = bpf_program__next(NULL, obj);
+	prog = bpf_object__next_program(NULL, obj);
 	RET_ERR(!prog, "get first bpf_program", "!prog\n");
 	select_by_skb_data_prog = bpf_program__fd(prog);
 	RET_ERR(select_by_skb_data_prog < 0, "get prog fd",
diff --git a/tools/testing/selftests/bpf/prog_tests/tcp_rtt.c b/tools/testing/selftests/bpf/prog_tests/tcp_rtt.c
index d207e968e6b1..4957e391e111 100644
--- a/tools/testing/selftests/bpf/prog_tests/tcp_rtt.c
+++ b/tools/testing/selftests/bpf/prog_tests/tcp_rtt.c
@@ -109,7 +109,7 @@ static int run_test(int cgroup_fd, int server_fd)
 		return -1;
 	}

-	map = bpf_map__next(NULL, obj);
+	map = bpf_object__next_map(NULL, obj);
 	map_fd = bpf_map__fd(map);

 	err = bpf_prog_attach(prog_fd, cgroup_fd, BPF_CGROUP_SOCK_OPS, 0);
--
2.30.2
