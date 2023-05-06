Return-Path: <bpf+bounces-167-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B796F8D98
	for <lists+bpf@lfdr.de>; Sat,  6 May 2023 03:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 287591C21AC4
	for <lists+bpf@lfdr.de>; Sat,  6 May 2023 01:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A677015BA;
	Sat,  6 May 2023 01:31:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D33215B2
	for <bpf@vger.kernel.org>; Sat,  6 May 2023 01:31:49 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94EEF40C7
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 18:31:47 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b9a77926afbso4531900276.3
        for <bpf@vger.kernel.org>; Fri, 05 May 2023 18:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683336707; x=1685928707;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R3tTNtfHOhWvElfdge4+T7awt+4BFTOV0To4APlP4VI=;
        b=L+3tGIfUtG33QZaej3ISSNAYNsm8fPKrSLDAYKcA3ceQTGQCg3cRs+o95z3Q/MyJxJ
         NQ/zEhtyMc76uAK6F7TKhnTWMi9dwhG945m/0ldiygPjD8u5gmV8Z14YMoSxUsX4WBIw
         scz5zEZWdZCRXQLauxvoAZ1CRibC++t4AE1OZhJhKelqjWQgMSOmjB33LF3QCsU287vX
         djAFsLLcbpHyHq/E6gLG9HzkHJyBt0kB3vh/nh2lkcCZyQzqhyz+GRWyEe6DZhg5p19T
         9yqvvb9/0c43abA/f4uFL+p5gdMuc8EyckIpo+P6RzLEZgNMvszGIKCZpa7a1UngyU3y
         wEow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683336707; x=1685928707;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R3tTNtfHOhWvElfdge4+T7awt+4BFTOV0To4APlP4VI=;
        b=kAWe3M0K49S9sREimgizJKTB6B/pt6yohsPPN4R3l7zr5iUMVY5pFoCdTafzdfkeDx
         G81WnznAQBRWhCa/s0O8UfQA2D0RjVcEgt3gKHX70GN9k1SLUyCce+f6NQQ/eyV77Yie
         5uWrM3bkVzhA5H6h8x+VMn7YW7O7WoDYlLkGdeYg6i9FgWl2Mcxqc8eh9px3pDiC2QYf
         6W7gdxhdPOrft0lNltLPNEkCWdLrsmfZ2fefIXMqf1zNEx9Q7fWN8DkrAUlioBSq8qh5
         OnUm9la3msmef25ZD+OLnBKkVwL3UbxamNcZzUfjluNRevVyRiH06E5ctxw8m2CJMAAr
         fDNA==
X-Gm-Message-State: AC+VfDyYqdy74Z8+AQoyZfamtYj6IeIIc+mMLDJmhjQLIu49WW2p81jG
	kJ5PFxQv1mlWi6kbKnHc5X+RvlcC8BmRaEbO9p5uayrSgDE3Z5//E9YV4/Qg66AyoyfwmNu4Bea
	2HPHlzs0Exn//VKBkpyr9bV/ZzxICd9AhsysskFRd9DYdOdINL8l63pn65g==
X-Google-Smtp-Source: ACHHUZ5sEHQEXSZOMI2fZpHGP8PwNi2cmHJ4+0FJdfCW76FEKiitkn7SABL6ne8pqSXss8RDFZ9X+dcg3eM=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:6826:a1a:a426:bb4a])
 (user=drosen job=sendgmr) by 2002:a25:500f:0:b0:b9e:930b:1b62 with SMTP id
 e15-20020a25500f000000b00b9e930b1b62mr2104563ybb.12.1683336706774; Fri, 05
 May 2023 18:31:46 -0700 (PDT)
Date: Fri,  5 May 2023 18:31:31 -0700
In-Reply-To: <20230506013134.2492210-1-drosen@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230506013134.2492210-1-drosen@google.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230506013134.2492210-3-drosen@google.com>
Subject: [PATCH bpf-next v3 2/5] selftests/bpf: Test allowing NULL buffer in
 dynptr slice
From: Daniel Rosenberg <drosen@google.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Joanne Koong <joannelkoong@gmail.com>, Mykola Lysenko <mykolal@fb.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kernel-team@android.com, 
	Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

bpf_dynptr_slice(_rw) no longer requires a buffer for verification. If the
buffer is needed, but not present, the function will return NULL.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 tools/testing/selftests/bpf/prog_tests/dynptr.c |  1 +
 .../selftests/bpf/progs/dynptr_success.c        | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c b/tools/testing/selftests/bpf/prog_tests/dynptr.c
index 0478916aff37..13d4b9ab16e7 100644
--- a/tools/testing/selftests/bpf/prog_tests/dynptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
@@ -26,6 +26,7 @@ static struct {
 	{"test_dynptr_is_null", SETUP_SYSCALL_SLEEP},
 	{"test_dynptr_is_rdonly", SETUP_SKB_PROG},
 	{"test_dynptr_clone", SETUP_SKB_PROG},
+	{"test_dynptr_skb_no_buff", SETUP_SKB_PROG},
 };
 
 static void verify_success(const char *prog_name, enum test_setup_type setup_type)
diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c b/tools/testing/selftests/bpf/progs/dynptr_success.c
index be7de62de045..d299ef3b4d1f 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_success.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
@@ -505,3 +505,20 @@ int test_dynptr_clone(struct __sk_buff *skb)
 
 	return 0;
 }
+
+SEC("?cgroup_skb/egress")
+int test_dynptr_skb_no_buff(struct __sk_buff *skb)
+{
+	struct bpf_dynptr ptr;
+	__u64 *data;
+
+	if (bpf_dynptr_from_skb(skb, 0, &ptr)) {
+		err = 1;
+		return 1;
+	}
+
+	/* This may return NULL. SKB may require a buffer */
+	data = bpf_dynptr_slice(&ptr, 0, NULL, 1);
+
+	return !!data;
+}
-- 
2.40.1.521.gf1e218fcd8-goog


