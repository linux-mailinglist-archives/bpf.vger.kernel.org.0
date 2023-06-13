Return-Path: <bpf+bounces-2520-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A40D72E76E
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 17:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 060281C203A7
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 15:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6753C089;
	Tue, 13 Jun 2023 15:39:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C10623DB
	for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 15:39:01 +0000 (UTC)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546F0C6
	for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 08:38:38 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so6986229e87.2
        for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 08:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686670716; x=1689262716;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bE65NoreqDDzW/h4kXNoROg3nP9OkfVyoe4TM7a36ng=;
        b=pjxpH018gIFfbzFY7tS8araXBnb9KC+ydauOuvrmyaY3jzuqOdDX6CU96q+rYiVttj
         /5XTX7xuTCSVgV9HzucDnsUpmFhBWTX437o4CqDGKzIk3yhzyrIKxtjVOteOy5pU2BTT
         w31b+E+gpkCwIFA41ajWnVy3P0MFgocEoiXIFmXle6ELvDPzmVMx8N4383D+1twW2k9o
         Aj6CO2aNmm9coO5tua6g1Uq3M0t27XE21161adWRTMODdc8pthvF0Jm3UOBfpvBCfcVU
         kTYn5FnjWGymxKAmJ11WkjOo6CSmlDdmxbJWyQbUUqOk2/BcpmhC+/Lf2EtUQwSaq3lh
         l7IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686670716; x=1689262716;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bE65NoreqDDzW/h4kXNoROg3nP9OkfVyoe4TM7a36ng=;
        b=XuZYwAJW2Dyfe6a0+xzkVJDDm/YL0TyvWM/DY4twcILeBwKqaqz8iNePDuKIuCQ/lk
         B+oYN6P3JmCxiaT7Cv5/zlGiUJDcqrOI8K0fUPHyf/BOGLVhCuGH/Z02csd0Esso4B+X
         /EpOqEZ6vFxNnlxq/M3Aw2Vk3nqYGTaCWqdGAjuijnqXS0Mf48IPJvDHKreCIeXDTf1e
         6BzgO7Fg+OnB/E6tw1FeH2M3jud3tIitEjBa1+z0NFnpRYC2YbC3EAqgdjyWN3CJyQ3X
         6/uxV5c0cF9JPGksWDWx21NZG73JZbcWLAM+WQswgFY3hzPOqSPvjWmXcTZgntOdA7Cg
         3lYg==
X-Gm-Message-State: AC+VfDyZWB+Ln8mR1dWuRx7iSUkqPLJl9buhbC8nF+iv5Ea22Stx6tUf
	rfXY922280xco6SrUXfkbvR/R2mFVREMxw==
X-Google-Smtp-Source: ACHHUZ7mk2xVZh8rpQZdSsPEhJqzazG5CbbMnTzkvOlsPROLFMlCDSYewx2Ff64I3CXXS4Aue8K3Tw==
X-Received: by 2002:ac2:5f99:0:b0:4f3:a0f0:7c4a with SMTP id r25-20020ac25f99000000b004f3a0f07c4amr7575380lfe.40.1686670715825;
        Tue, 13 Jun 2023 08:38:35 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id c23-20020a197617000000b004f24db9248dsm1818576lff.141.2023.06.13.08.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 08:38:35 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yhs@fb.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v6 0/4] verify scalar ids mapping in regsafe()
Date: Tue, 13 Jun 2023 18:38:20 +0300
Message-Id: <20230613153824.3324830-1-eddyz87@gmail.com>
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
- patches #3,4: update for regsafe() to use a special version of
  check_ids() for precise scalar values.

Changelog:
- V5 -> V6:
  - check_ids() is modified to disallow mapping different 'old_id' to
    the same 'cur_id', check_scalar_ids() simplified (Andrii);
  - idset_push() updated to return -EFAULT instead of -1 (Andrii);
  - comments fixed in check_ids_in_regsafe() test case 
    (Maxim Mikityanskiy);
  - fixed memset warning in states_equal() reported in [4].
- V4 -> V5 (all changes are based on feedback for V4 from Andrii):
  - mark_precise_scalar_ids() error code is updated to EFAULT;
  - bpf_verifier_env::idmap_scratch field type is changed to struct
    bpf_idmap to encapsulate temporary ID generation counter;
  - regsafe() is updated to call scalar_regs_exact() only for
    env->explore_alu_limits case (this had no measurable impact on
    verification duration when tested using veristat).
- V3 -> V4:
  - check_ids() in regsafe() is replaced by check_scalar_ids(),
    as discussed with Andrii in [3],
    Note: I did not transfer Andrii's ack for patch #3 from V3 because
          of the changes to the algorithm.
  - reg_id_scratch is renamed to idset_scratch;
  - mark_precise_scalar_ids() is modified to propagate error from
    idset_push();
  - test cases adjusted according to feedback from Andrii for V3.
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
[V2]  https://lore.kernel.org/bpf/20230530172739.447290-1-eddyz87@gmail.com/
[V3]  https://lore.kernel.org/bpf/20230606222411.1820404-1-eddyz87@gmail.com/
[V4]  https://lore.kernel.org/bpf/20230609210143.2625430-1-eddyz87@gmail.com/
[V5]  https://lore.kernel.org/bpf/20230612160801.2804666-1-eddyz87@gmail.com/
[RFC] https://lore.kernel.org/bpf/20221128163442.280187-1-eddyz87@gmail.com/
[1]   https://gist.github.com/eddyz87/a32ea7e62a27d3c201117c9a39ab4286
[2]   https://lore.kernel.org/bpf/20230530172739.447290-1-eddyz87@gmail.com/T/#mc21009dcd8574b195c1860a98014bb037f16f450
[3]   https://lore.kernel.org/bpf/20230606222411.1820404-1-eddyz87@gmail.com/T/#m89da8eeb2fa8c9ca1202c5d0b6660e1f72e45e04
[4]   https://lore.kernel.org/oe-kbuild-all/202306131550.U3M9AJGm-lkp@intel.com/

Eduard Zingerman (4):
  bpf: use scalar ids in mark_chain_precision()
  selftests/bpf: check if mark_chain_precision() follows scalar ids
  bpf: verify scalar ids mapping in regsafe() using check_ids()
  selftests/bpf: verify that check_ids() is used for scalars in
    regsafe()

 include/linux/bpf_verifier.h                  |  25 +-
 kernel/bpf/verifier.c                         | 206 +++++-
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_scalar_ids.c | 659 ++++++++++++++++++
 .../testing/selftests/bpf/verifier/precise.c  |   8 +-
 5 files changed, 867 insertions(+), 33 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_scalar_ids.c

-- 
2.40.1


