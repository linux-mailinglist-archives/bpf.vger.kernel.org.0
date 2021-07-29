Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5F323DA8D0
	for <lists+bpf@lfdr.de>; Thu, 29 Jul 2021 18:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbhG2QUs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Jul 2021 12:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbhG2QUq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Jul 2021 12:20:46 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE35C061796
        for <bpf@vger.kernel.org>; Thu, 29 Jul 2021 09:20:42 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id r2so7668305wrl.1
        for <bpf@vger.kernel.org>; Thu, 29 Jul 2021 09:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o/hBpf5viYMSq0AktZJVEsskRhUKYFmlrZVQvNFOpzo=;
        b=aPG03mWax//aD/qbmVyFxwq6o62C0oVHpmZQ8NuF1QD51r1GW1N9UJNTvCEj6SgpqP
         0fWt+9xP332zDVioHfUFDm/Th7gMUUDWLcuhQOIgdxKG2HE/mZjlnTgASFr8nfCxTkjd
         xtceWzdMaGBpMHwovj4TpxUZlhciVofJy8ylEQpHG0jPCpKK0M50PHngYBMMpalFcSCH
         njNmwjiXaseMtDeOKsX9MEUhab6diZhhL6yvId7vuAPrgNzDYmB+ZxcRPYJ225SUU78c
         IYrpF9beII/kcrFDMXyxiAQxiUiGRoGWBNRe6/Fhskl+A6yo9UwLAAFfTyKd4GoKF7rG
         msxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o/hBpf5viYMSq0AktZJVEsskRhUKYFmlrZVQvNFOpzo=;
        b=NBeXJs05cnb/fY+yzdS72+gt8erNJwOOPhSC9TrTWv1bz7xxlPDZnG/AcJeyMoe1Yj
         HEPI8bsf3xruCRgI38jkSX/6X8qBCxOHlz8HUovOqNq3mO8PWtL0NYXHcVxO5i4EmpI1
         epCUwOvZVvKSKYlNPLkr2cpe22Tq3QvTZhrfcTGzFRXfqmHPUkky9dA0Fy5rsj8Pw7Qh
         rQukojiTF0CZMAzOcTPHuN/S3RMzs5/MvwN1BkEf39zbs5n1YruMgLjzWn5Upepdotfv
         8hGR0fWQEitIO6bQ5QoiGpamz6Dzv0on2VXLKCJH+Hziwuxwf8U8272A9abGi7ezyU/8
         d6Gw==
X-Gm-Message-State: AOAM532G0DUCGXIfRazelqXF3yCLNt+agDGuiMw4yTRcP6WHq0hEdhDz
        0OGaaOzv2PPqSgZvULc3NdMTOw==
X-Google-Smtp-Source: ABdhPJyk16ft4kg/WHYcIwhutv0sVyhiF5DTjy4XrboD3DhZ/6XjRcq4MdmmY7LP3LRKNw5JHfMbkg==
X-Received: by 2002:a05:6000:10c3:: with SMTP id b3mr5806832wrx.271.1627575641341;
        Thu, 29 Jul 2021 09:20:41 -0700 (PDT)
Received: from localhost.localdomain ([149.86.66.250])
        by smtp.gmail.com with ESMTPSA id c10sm3854853wmb.40.2021.07.29.09.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 09:20:40 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next v3 4/8] tools: free BTF objects at various locations
Date:   Thu, 29 Jul 2021 17:20:24 +0100
Message-Id: <20210729162028.29512-5-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210729162028.29512-1-quentin@isovalent.com>
References: <20210729162028.29512-1-quentin@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Make sure to call btf__free() (and not simply free(), which does not
free all pointers stored in the struct) on pointers to struct btf
objects retrieved at various locations.

These were found while updating the calls to btf__get_from_id().

Fixes: 999d82cbc044 ("tools/bpf: enhance test_btf file testing to test func info")
Fixes: 254471e57a86 ("tools/bpf: bpftool: add support for func types")
Fixes: 7b612e291a5a ("perf tools: Synthesize PERF_RECORD_* for loaded BPF programs")
Fixes: d56354dc4909 ("perf tools: Save bpf_prog_info and BTF of new BPF programs")
Fixes: 47c09d6a9f67 ("bpftool: Introduce "prog profile" command")
Fixes: fa853c4b839e ("perf stat: Enable counting events for BPF programs")
Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 tools/bpf/bpftool/prog.c                     | 5 ++++-
 tools/perf/util/bpf-event.c                  | 4 ++--
 tools/perf/util/bpf_counter.c                | 3 ++-
 tools/testing/selftests/bpf/prog_tests/btf.c | 1 +
 4 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index cc48726740ad..9d709b427665 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -781,6 +781,8 @@ prog_dump(struct bpf_prog_info *info, enum dump_mode mode,
 		kernel_syms_destroy(&dd);
 	}
 
+	btf__free(btf);
+
 	return 0;
 }
 
@@ -2002,8 +2004,8 @@ static char *profile_target_name(int tgt_fd)
 	struct bpf_prog_info_linear *info_linear;
 	struct bpf_func_info *func_info;
 	const struct btf_type *t;
+	struct btf *btf = NULL;
 	char *name = NULL;
-	struct btf *btf;
 
 	info_linear = bpf_program__get_prog_info_linear(
 		tgt_fd, 1UL << BPF_PROG_INFO_FUNC_INFO);
@@ -2027,6 +2029,7 @@ static char *profile_target_name(int tgt_fd)
 	}
 	name = strdup(btf__name_by_offset(btf, t->name_off));
 out:
+	btf__free(btf);
 	free(info_linear);
 	return name;
 }
diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index cdecda1ddd36..17a9844e4fbf 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -296,7 +296,7 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_session *session,
 
 out:
 	free(info_linear);
-	free(btf);
+	btf__free(btf);
 	return err ? -1 : 0;
 }
 
@@ -486,7 +486,7 @@ static void perf_env__add_bpf_info(struct perf_env *env, u32 id)
 	perf_env__fetch_btf(env, btf_id, btf);
 
 out:
-	free(btf);
+	btf__free(btf);
 	close(fd);
 }
 
diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
index 8150e03367bb..beca55129b0b 100644
--- a/tools/perf/util/bpf_counter.c
+++ b/tools/perf/util/bpf_counter.c
@@ -64,8 +64,8 @@ static char *bpf_target_prog_name(int tgt_fd)
 	struct bpf_prog_info_linear *info_linear;
 	struct bpf_func_info *func_info;
 	const struct btf_type *t;
+	struct btf *btf = NULL;
 	char *name = NULL;
-	struct btf *btf;
 
 	info_linear = bpf_program__get_prog_info_linear(
 		tgt_fd, 1UL << BPF_PROG_INFO_FUNC_INFO);
@@ -89,6 +89,7 @@ static char *bpf_target_prog_name(int tgt_fd)
 	}
 	name = strdup(btf__name_by_offset(btf, t->name_off));
 out:
+	btf__free(btf);
 	free(info_linear);
 	return name;
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index 857e3f26086f..68e415f4d33c 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -4386,6 +4386,7 @@ static void do_test_file(unsigned int test_num)
 	fprintf(stderr, "OK");
 
 done:
+	btf__free(btf);
 	free(func_info);
 	bpf_object__close(obj);
 }
-- 
2.30.2

