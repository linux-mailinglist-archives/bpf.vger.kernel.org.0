Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 220CF341B75
	for <lists+bpf@lfdr.de>; Fri, 19 Mar 2021 12:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbhCSL2K (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Mar 2021 07:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbhCSL16 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Mar 2021 07:27:58 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7D2C06174A
        for <bpf@vger.kernel.org>; Fri, 19 Mar 2021 04:27:58 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id k8so8731412wrc.3
        for <bpf@vger.kernel.org>; Fri, 19 Mar 2021 04:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fVEtoBjUKWgyagwIZBW4zKQyHixrgqvat+jrds6fQhg=;
        b=SCAKR+nSIGMTx2zhqY+p+lLgdmIuWNTDLuIcqbzjbxnxEmeLyglC3umGxsNRTNGkoD
         K/xUK0FxGRonT/9OCtAEHLYAjhO3ayqQwaef5L4HepFJGeeBTIpiVKRqu63ww0Zei6z1
         UKVyJjqaDYNekyu2gmIc+RC8f4Ee6YrYIBW6tGrPS/GCpodIO0NDbWi3bLWJeaV0yhRm
         +/0UxWdUk8Kw4tQqcDiTeC33yfIxvvbwury7Jpqa08ze0gUcCcQf10dU+IDzD/yrEBmM
         T/cfudvio6dKMEgf4APSrN3zT3LuDrsu5B3jrdTUjMqRpwZ1+Vmf3Ba4KXyhmL1j6uaZ
         zkeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fVEtoBjUKWgyagwIZBW4zKQyHixrgqvat+jrds6fQhg=;
        b=CMnsezZIw8Kc6s0OTHE0fWb+Nyv8AVzt14fIx+GEQo5SFt92sc5eiV7ekJIIE1ZDX7
         KAkCSixwlzChQd38cEgv75fGIdnWPV7Vhocyrh9lDkMshJ+TVfpHgD9BTHtQY5EwB7sA
         x9HuqqjcTC6FpCds5yrCQ3SpQw8VhiAEDlIj39mimRj5R2//pXG6kA0Q7niN0qSU8+gO
         7IoES03HgVWyAurM1TDEkVKULuOlutqfT+8dLgP/wYJxsx9SjGHXxqeauN25sUYBkqPS
         u9MvMCb4O4XRtSxB21uD/eB+pCbiWlmuU3QsveitgY3mDzY1XS0PXQK2LXm1Kjlz+Q+6
         55KQ==
X-Gm-Message-State: AOAM532PMjx5RRzO2tBUHFiwaMk1sH52k6HKcytn54zwbpRWgOwPVip1
        fi+NBUug0dgr5N5mLl4XenlCNg==
X-Google-Smtp-Source: ABdhPJwTCMRxB7597LoBGEliAQ/Fez2WJCK/faW6nH54X5cYJbry9yN0f895KKR1aa+C2wVwV8gkTA==
X-Received: by 2002:a5d:570b:: with SMTP id a11mr3977583wrv.281.1616153277117;
        Fri, 19 Mar 2021 04:27:57 -0700 (PDT)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id c2sm5969706wmr.22.2021.03.19.04.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 04:27:56 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, bpf@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH bpf v2 2/2] selftests/bpf: Add selftest for pointer-to-array-of-struct BTF dump
Date:   Fri, 19 Mar 2021 12:25:55 +0100
Message-Id: <20210319112554.794552-3-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210319112554.794552-1-jean-philippe@linaro.org>
References: <20210319112554.794552-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Bpftool used to issue forward declarations for a struct used as part of
a pointer to array, which is invalid. Add a test to check that the
struct is fully defined in this case:

	@@ -134,9 +134,9 @@
	 	};
	 };

	-struct struct_in_array {};
	+struct struct_in_array;

	-struct struct_in_array_typed {};
	+struct struct_in_array_typed;

	 typedef struct struct_in_array_typed struct_in_array_t[2];

	@@ -189,3 +189,7 @@
	 	struct struct_with_embedded_stuff _14;
	 };

	+struct struct_in_array {};
	+
	+struct struct_in_array_typed {};
	+
	...
	#13/1 btf_dump: syntax:FAIL

Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 .../selftests/bpf/progs/btf_dump_test_case_syntax.c       | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c b/tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c
index 31975c96e2c9..3ac0c9afc35a 100644
--- a/tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c
+++ b/tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c
@@ -174,6 +174,12 @@ struct struct_in_struct {
 	};
 };
 
+struct struct_in_array {};
+
+struct struct_in_array_typed {};
+
+typedef struct struct_in_array_typed struct_in_array_t[2];
+
 struct struct_with_embedded_stuff {
 	int a;
 	struct {
@@ -203,6 +209,8 @@ struct struct_with_embedded_stuff {
 	} r[5];
 	struct struct_in_struct s[10];
 	int t[11];
+	struct struct_in_array (*u)[2];
+	struct_in_array_t *v;
 };
 
 struct root_struct {
-- 
2.30.2

