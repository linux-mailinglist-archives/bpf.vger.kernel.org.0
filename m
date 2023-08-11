Return-Path: <bpf+bounces-7511-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C5C778585
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 04:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14C1C1C21078
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 02:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5FCA47;
	Fri, 11 Aug 2023 02:36:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F45A36F
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 02:36:52 +0000 (UTC)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F4A171D
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 19:36:51 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bdb08e9057so6542055ad.0
        for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 19:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691721411; x=1692326211;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b//DUQVQQ/TUxkU7O9Rw/NbHIqB3JrohqHh/38SrWVM=;
        b=qnCr7XGJDmHQNYZvELg2guFEgVDEDxvRtDYuRBhQCphwfZforf25ByIDPSu8Zrt96h
         v1AVstcePFjtFKd2BUtSPOYhNZVKspC1BXSA2cvDgyEksCDxZQ+eskE8tOmDSGRf/+ke
         TuXdtaVbr5gK+hCJfr6ClivHOKLt63BTm7q08I7o6XQJnbwgka2SPBcgfLM3OzWS6vOt
         ecgCEBIU7ZB6UScsDh2Aqo7jsOrPjO1K9EJxBk1GGevnkRf9A7Ig9Zr+mWXYICJKVhyN
         gxWBTAtby9oHhfYS/hi85l2S3ug3q4Lwf5cAbFEYRGq7t+WsoC5ji8gdtUNV0w0ok0Vl
         8QlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691721411; x=1692326211;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b//DUQVQQ/TUxkU7O9Rw/NbHIqB3JrohqHh/38SrWVM=;
        b=fEtumsnhlRDVqavf8C+/Xu6HFgPxk2y3JU2ekkzNtrod5p2q7DYTXwr16M3HWPaX8g
         CUkA3CwoSVx6TY+s/xBlw3HyGN+6O9nDJIZ1UH07IeDHbz0J/vmcOlGtIjazlJdYgSTf
         MVmBraXviIrnguk/CsMWQ7IiEDmufjWOvnVY6DiVI2u0aYNMW6aAGVh6PyAonmVCCFCX
         0jgCT+bzzY7ckx1CjPJZnmA4Tx05hHZpmxJ3ecprsxRXfHZe2pfv5uR2LFxL46eK8Zo6
         osnugLjpCNvNLuflFfC9GY3gbwmztwgAIpgPHQaaNUp2WWtPht1rk9WVp9eU06Krhz6e
         41Qw==
X-Gm-Message-State: AOJu0Yyr32uSfCzSlbK233lpFn0TtAxb/HEa9nRZP3xO/nAXVoSf8KDI
	9Vj4x6mV4jUfCSnuIgDDOM8=
X-Google-Smtp-Source: AGHT+IG/MnBFAVhBMUr8/59o8IRx4cgli6WZcD+kLJR4BfpE5D4CaHP7Crnp3/Ud+Zr53dMcaxFwVQ==
X-Received: by 2002:a17:903:2452:b0:1b2:fa8:d9c9 with SMTP id l18-20020a170903245200b001b20fa8d9c9mr775901pls.49.1691721410901;
        Thu, 10 Aug 2023 19:36:50 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac02:925:5400:4ff:fe89:58d6])
        by smtp.gmail.com with ESMTPSA id ju17-20020a170903429100b001bdb0483e65sm1038304plb.265.2023.08.10.19.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 19:36:50 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v5 bpf-next 0/2] bpf: Fix fill_link_info and add selftest
Date: Fri, 11 Aug 2023 02:36:45 +0000
Message-Id: <20230811023647.3711-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
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

Patch #1: Fix an error in fill_link_info reported by Dan
Patch #2: Add selftest for #1

v4->v5:
  - Comments from Yonghong
    - Replace 'offset' with '0'
    - Set err=-1 for default case
    - Only check return value of verify_kmulti_link_info
  - Comments from Jiri
    - Avoid retprobe argument
    - Use bpf_fentry_test* instead
    - Rename verify_kmulti_user_buffer
  - Define some variables as global value to simplify the code

v3->v4:
  - Comments from Yonghong
    - re-word the kptr comment
    - Avoid unnecessary switch statement
    - No need to check the return value of bpf_link__fd()
    - offset is always 0
    - Return directly when test_fill_link_info__open_and_load() fails
    - Cleanup skel when load_kallsyms_refresh() fails

v2->v3:
  - Comments from Jiri
    - Verify wrong arguments as soon as possible
    - Use CONFIG_X86_KERNEL_IBT
    - No need to make the test serial
    - Add test case for kprobe_multi

v1->v2:
  - Fix BPF CI failure due to the enabled ENDBDR

Yafang Shao (2):
  bpf: Fix uninitialized symbol in bpf_perf_link_fill_kprobe()
  selftests/bpf: Add selftest for fill_link_info

 kernel/bpf/syscall.c                               |   4 +-
 tools/testing/selftests/bpf/DENYLIST.aarch64       |   3 +
 .../selftests/bpf/prog_tests/fill_link_info.c      | 342 +++++++++++++++++++++
 .../selftests/bpf/progs/test_fill_link_info.c      |  42 +++
 4 files changed, 389 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fill_link_info.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_fill_link_info.c

-- 
1.8.3.1


