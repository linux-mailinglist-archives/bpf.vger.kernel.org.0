Return-Path: <bpf+bounces-7676-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DE377A6D8
	for <lists+bpf@lfdr.de>; Sun, 13 Aug 2023 16:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4056D280FA4
	for <lists+bpf@lfdr.de>; Sun, 13 Aug 2023 14:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D020779CD;
	Sun, 13 Aug 2023 14:19:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE865235
	for <bpf@vger.kernel.org>; Sun, 13 Aug 2023 14:19:07 +0000 (UTC)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A3E171A
	for <bpf@vger.kernel.org>; Sun, 13 Aug 2023 07:19:05 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bb7b8390e8so23301885ad.2
        for <bpf@vger.kernel.org>; Sun, 13 Aug 2023 07:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691936344; x=1692541144;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=75I43A3FplgFCwPfM3h3vsgX0FYWE6epW2zAU38f/SA=;
        b=m+aLIA7irlJxT7JYBGausIhcCSVwuJjp6MXf9tsI8UJghXSHGOFYajXjegbiRnEJ4k
         hjzKjmgyXNhIF8igW2AYJCp6rwMpGalpqyfjvIpEzvShYuWp3/kxIWIKc4oQnBmgfQeF
         g6k/maV4HOs283HbWxvncEIEsYA/H1Kf7gpefvAxb8IUN+o/7Z2djmnUQLoLgOC1pyYK
         IqsgBj0b3sofbaE865MceEhb/8P/Kh2EfGsDTNjf/8kU25cUZUkHbVZ8nm7MkT0x9z+J
         oQ+beCZsUmh65/xagjUuvcKGKNEzlTmHirktOzmWWCcVNu2NcAegUPVbB1fgZpn/uxyA
         tQ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691936344; x=1692541144;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=75I43A3FplgFCwPfM3h3vsgX0FYWE6epW2zAU38f/SA=;
        b=bbLmN0ehTiDPgO3MIsoJXKcLp3hBX0luBD9Y4CFg5Sh52IK+c1nQhIpOtr6hvvgoQn
         mlgpNWB1qPJ4CA8rjSuIP5w5xtywUmt4PcT0oJNV1QyD9+CBRjwU0v7kQ7VIwjHAOnb4
         5IS/s93WTFCcrwtc+EwocN9g98lnpKM5SBqnCBi+Qlk8sk21rg/xShLtE5OEVbDjNQzV
         /ultQm8QSEpz/B1SsV13j4EXXvJCJzkeLMW4vxNvUOUS9JODnr9gyXkiWE4ONBFE759h
         MwgYCeHxeHwvR6lOuL+fiqaOtPDSDAWRO0ZPClX9rsr3RmqVmQPIYK+1kRDLJlhlxfU0
         c2bQ==
X-Gm-Message-State: AOJu0Yxi0pfavJHXv6+8aRMM5CAi6+9wqP+/pDmeDgbVvbuO7nJh59Yj
	bsDX7THkQKyjBWNTvHbrvbc=
X-Google-Smtp-Source: AGHT+IF7ls0EWs0Kq5a/xVH9CZTaMg2KgeM7Bc6V2r64U9b+TN6lCe8FJm7R+/o3EgoqnSnxY/pN7A==
X-Received: by 2002:a17:902:db06:b0:1bb:c87d:756d with SMTP id m6-20020a170902db0600b001bbc87d756dmr7630904plx.42.1691936344483;
        Sun, 13 Aug 2023 07:19:04 -0700 (PDT)
Received: from vultr.guest ([149.28.193.116])
        by smtp.gmail.com with ESMTPSA id je22-20020a170903265600b001bba7aab822sm7506461plb.5.2023.08.13.07.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 07:19:03 -0700 (PDT)
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
Subject: [PATCH v6 bpf-next 0/2] bpf: Fix fill_link_info and add selftest
Date: Sun, 13 Aug 2023 14:18:58 +0000
Message-Id: <20230813141900.1268-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.2
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

v5->v6:
  - Fix BPF CI failure on aarch64

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


