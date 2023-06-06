Return-Path: <bpf+bounces-1963-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2411724F86
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 00:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 527202810CC
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 22:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2483446B;
	Tue,  6 Jun 2023 22:24:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192262DBA3
	for <bpf@vger.kernel.org>; Tue,  6 Jun 2023 22:24:39 +0000 (UTC)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7BB10F1
	for <bpf@vger.kernel.org>; Tue,  6 Jun 2023 15:24:38 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4effb818c37so8168806e87.3
        for <bpf@vger.kernel.org>; Tue, 06 Jun 2023 15:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686090276; x=1688682276;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bgp+xQUPXxWBRAuHtLKXMJ4znZDBCEmyjTqxLYLkJu0=;
        b=MzHF8nCOwx+VKd+devBVvmB9/lWhS6z8pKfpUGM4l8pOJwQJsUD/qjrrDhWb5rL/ro
         NiKhYoIl8WyOfeGN7BwpaArCtJ8kMOFle9VlWRJ+tREwUd7HnTdvB7KeMYvW0/eLfEEi
         auN2yevf+xBmwpRAUWUeftQXr9kSppOqVcCSXZmnWq5U64DnUKZCRvbP5ndJ9n3ywEOF
         Vv4Ox4itOvAmnooKtXK2UoyYPyGIDgmbgPzj/lLzojlkAFfvOHL69GWL1jUWP1b3o3iM
         c9exY2pjc9zoAzPNSVNIcp1Owej2w4qID+TMZZKiuRV6FZvahPo8VylqkExnin1eR2cz
         8gvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686090276; x=1688682276;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bgp+xQUPXxWBRAuHtLKXMJ4znZDBCEmyjTqxLYLkJu0=;
        b=ODw8hYySHYmBB05muWdDAlbabr79aFBoqqE/RHozYqgz1erleXzVYrERXcBV3gsZ9g
         s8oZdOSIX6dLXrSj0BD8UNK1xj3qL5QH5b9ya8HMY1nPGJG4FRtE2ODfYQYNftsUzkWa
         7oZStIT6jTEkxFd3uQ24EgnIQbPUG+7rjeBrZ9M6jXRDA2f19C9D3aQDgZBlyL0qifF3
         dr6paVR8kcVDSk/0B01dyMJVnG8RCxTJlnwXNi6tiaaOV57GshrtFS4r1FCB0iwrkCSl
         EmSXiSx3nLYl/0cXMnPggSS+m2DTHiwQ2wdfwkd7rfMNSDTt83pmwhNwWPs80HGiDzX/
         p8dQ==
X-Gm-Message-State: AC+VfDy8Ze0bL6Wq4e9dawd3IfcLmaFMJ8HHMKzYglBmT9qiU3y1KSjl
	z8RJaDvykbSNO411TUxfEOjQW6CJFfg=
X-Google-Smtp-Source: ACHHUZ4KIlBDKF26VxcOkqYUQlXNOfJhesfT3EN4RJukFrfBrfWeM+L4op/FtcPfSHAbfR5mWnFUYA==
X-Received: by 2002:ac2:53a1:0:b0:4ed:bfcf:3109 with SMTP id j1-20020ac253a1000000b004edbfcf3109mr1416959lfh.56.1686090275953;
        Tue, 06 Jun 2023 15:24:35 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id r15-20020ac252af000000b004f3a79c9e0fsm1577487lfm.57.2023.06.06.15.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 15:24:35 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yhs@fb.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 0/4] verify scalar ids mapping in regsafe()
Date: Wed,  7 Jun 2023 01:24:07 +0300
Message-Id: <20230606222411.1820404-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Update regsafe() to use check_ids() for scalar values.
Otherwise the following unsafe pattern is accepted by verifier:

  1: r9 = ... some pointer with range X ...
  2: r6 = ... unbound scalar ID=a ...
  3: r7 = ... unbound scalar ID=b ...
  4: if (r6 > r7) goto +1
  5: r6 = r7
  6: if (r6 > X) goto ...
  --- checkpoint ---
  7: r9 += r7
  8: *(u64 *)r9 = Y

This example is unsafe because not all execution paths verify r7 range.
Because of the jump at (4) the verifier would arrive at (6) in two states:
I.  r6{.id=b}, r7{.id=b} via path 1-6;
II. r6{.id=a}, r7{.id=b} via path 1-4, 6.

Currently regsafe() does not call check_ids() for scalar registers,
thus from POV of regsafe() states (I) and (II) are identical.

The change is split in two parts:
- patches #1,2: update for mark_chain_precision() to propagate
  precision marks through scalar IDs.
- patches #3,4: update for regsafe() to use check_ids() for precise
  scalar values.

Changelog:
- V2 -> V3:
  - u32_hashset for IDs used for range transfer is removed;
  - mark_chain_precision() is updated as discussed with Andrii in [2].
- V1 -> v2:
  - 'rold->precise' and 'rold->id' checks are dropped as unsafe
    (thanks to discussion with Yonghong);
  - patches #3,4 adding tracking of ids used for range transfer in
    order to mitigate performance impact.
- RFC -> V1:
  - Function verifier.c:mark_equal_scalars_as_read() is dropped,
    as it was an incorrect fix for problem solved by commit [3].
  - check_ids() is called only for precise scalar values.
  - Test case updated to use inline assembly.

[V1]  https://lore.kernel.org/bpf/20230526184126.3104040-1-eddyz87@gmail.com/
[V2]  https://lore.kernel.org/bpf/20230530172739.447290-1-eddyz87@gmail.com/T/
[RFC] https://lore.kernel.org/bpf/20221128163442.280187-1-eddyz87@gmail.com/
[1]   https://gist.github.com/eddyz87/a32ea7e62a27d3c201117c9a39ab4286
[2]   https://lore.kernel.org/bpf/20230530172739.447290-1-eddyz87@gmail.com/T/#mc21009dcd8574b195c1860a98014bb037f16f450

Eduard Zingerman (4):
  bpf: use scalar ids in mark_chain_precision()
  selftests/bpf: check if mark_chain_precision() follows scalar ids
  bpf: verify scalar ids mapping in regsafe() using check_ids()
  selftests/bpf: verify that check_ids() is used for scalars in
    regsafe()

 include/linux/bpf_verifier.h                  |  10 +-
 kernel/bpf/verifier.c                         | 148 ++++-
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_scalar_ids.c | 508 ++++++++++++++++++
 .../bpf/progs/verifier_search_pruning.c       |   3 +-
 .../testing/selftests/bpf/verifier/precise.c  |   8 +-
 6 files changed, 669 insertions(+), 10 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_scalar_ids.c

-- 
2.40.1


