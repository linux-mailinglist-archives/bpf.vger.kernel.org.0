Return-Path: <bpf+bounces-12246-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 920667C9D0A
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 03:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F31D7B20B9F
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 01:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C4017FC;
	Mon, 16 Oct 2023 01:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5kTRMBF"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EEA17EA
	for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 01:47:53 +0000 (UTC)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B51EE9;
	Sun, 15 Oct 2023 18:47:52 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-27d3ede72f6so2136314a91.1;
        Sun, 15 Oct 2023 18:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697420871; x=1698025671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mi5UmAT05d3969V2jLDH5OfDsDaXCi2SPvi05677hA4=;
        b=C5kTRMBFanemv7wO8grEXFn8sCR7wXzJ4Lv+wA9TIl+kJNxDaUi0T+cdqbrV4/WQcE
         e6F2HK2t3D9j4PF8akTTbHWfquiP2luxfy0FuXMpLYyKRNQw7htfyIDWETv2VzGZ/uM1
         zWGTWJmXMRZNapAWdlXoeQCz60YUOCRuikPSrsjjWJ1EuJHVBbF/VASOPKR9Mlvc3vYi
         L8Qdlc4i2+oDzudw6IMjnz875Kl+ovhi81Im8qBNz0Ig+JY89z9SpV5BKnpak2BjPn1a
         XSPTvWAOQetAjXosjUw/nl4hQ+oKNjUEBKGnrFO1wdCn3weZr20AzE+BqM5KB1Z86Ud/
         6JNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697420871; x=1698025671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mi5UmAT05d3969V2jLDH5OfDsDaXCi2SPvi05677hA4=;
        b=gNPspkZBG17h0ZNCiPpguqAPC/ugSzB9Z+cutjaOTnNDCAjYZ+BkI/KPCO1Cv+T+U7
         pV2nlqzwWhkbl2VtNqXezE+tEv0eNyOhfVGAjPR+zIwhyPH6A8zfUsrozpHbGYPEDWJo
         mV/I3a1VH81rLWRhYkJe+GViQ8tht+07elQKHBk6fD8nyX+7xI/mKjLhJbGHvDlHgJ5s
         UjR14/4yZ7/Hu3xNhqgQE4tJTE9RhOlgGq6aUu3jhwBYM1Q0UOjnw8Ublw36rF/5lEC7
         /P+qv7t/Uhdu+wzyECG3IElbpG0DbiHteyBNNkTKIWvUM/TZ5dqbF7mi6u2cqKwleWCz
         V70g==
X-Gm-Message-State: AOJu0YyKjJnBzdLJA08QAMOfCM94A2igroSbyfhFgEGZ/tMJf5XPEr3p
	iDlnpe8KJp33fFr0AJdCAw3llFP16FC4Vw==
X-Google-Smtp-Source: AGHT+IGH7TfUPliSmFctNHTFYoEc5e4R1mypniXEZZGepACzWiThk28fihmceiKF2saXXMrxHt+VWQ==
X-Received: by 2002:a17:90b:8e:b0:27c:fc2a:a178 with SMTP id bb14-20020a17090b008e00b0027cfc2aa178mr14832393pjb.9.1697420870865;
        Sun, 15 Oct 2023 18:47:50 -0700 (PDT)
Received: from ubuntu.. ([203.205.141.13])
        by smtp.googlemail.com with ESMTPSA id pd17-20020a17090b1dd100b0027cfb5f010dsm3574377pjb.4.2023.10.15.18.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 18:47:49 -0700 (PDT)
From: Hengqi Chen <hengqi.chen@gmail.com>
To: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: keescook@chromium.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	luto@amacapital.net,
	wad@chromium.org,
	alexyonghe@tencent.com,
	hengqi.chen@gmail.com
Subject: [PATCH v2 5/5] selftests/bpf: Skip BPF_PROG_TYPE_SECCOMP-related tests
Date: Sun, 15 Oct 2023 23:29:53 +0000
Message-Id: <20231015232953.84836-6-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231015232953.84836-1-hengqi.chen@gmail.com>
References: <20231015232953.84836-1-hengqi.chen@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

We only allow BPF_PROG_TYPE_SECCOMP progs to be loaded via
seccomp syscall. Skip related test on BPF side.

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/libbpf_probes.c | 3 ++-
 tools/testing/selftests/bpf/prog_tests/libbpf_str.c    | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c b/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c
index 9f766ddd946a..134ae042c4da 100644
--- a/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c
+++ b/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c
@@ -28,7 +28,8 @@ void test_libbpf_probe_prog_types(void)
 		enum bpf_prog_type prog_type = (enum bpf_prog_type)e->val;
 		int res;
 
-		if (prog_type == BPF_PROG_TYPE_UNSPEC)
+		if (prog_type == BPF_PROG_TYPE_UNSPEC ||
+		    prog_type == BPF_PROG_TYPE_SECCOMP)
 			continue;
 
 		if (!test__start_subtest(prog_type_name))
diff --git a/tools/testing/selftests/bpf/prog_tests/libbpf_str.c b/tools/testing/selftests/bpf/prog_tests/libbpf_str.c
index c440ea3311ed..35365500c326 100644
--- a/tools/testing/selftests/bpf/prog_tests/libbpf_str.c
+++ b/tools/testing/selftests/bpf/prog_tests/libbpf_str.c
@@ -186,6 +186,9 @@ static void test_libbpf_bpf_prog_type_str(void)
 		const char *prog_type_str;
 		char buf[256];
 
+		if (prog_type == BPF_PROG_TYPE_SECCOMP)
+			continue;
+
 		prog_type_name = btf__str_by_offset(btf, e->name_off);
 		prog_type_str = libbpf_bpf_prog_type_str(prog_type);
 		ASSERT_OK_PTR(prog_type_str, prog_type_name);
-- 
2.34.1


