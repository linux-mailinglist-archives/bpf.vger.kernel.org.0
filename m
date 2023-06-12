Return-Path: <bpf+bounces-2422-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB42272CB04
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 18:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75BE3281138
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 16:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0345920692;
	Mon, 12 Jun 2023 16:08:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E761DDF8
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 16:08:24 +0000 (UTC)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B278B170E
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 09:08:13 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f649db9b25so5303969e87.0
        for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 09:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686586091; x=1689178091;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WKBJpgAjxkTqVCYd92h8q98HsWwnllVXy8B4SSiuAkk=;
        b=RhMSx/vIEEej4dYDw7DKpnqFGi15GDnZhi8hhqK2xbREOra3f3GwpAXxbeFI4SaEml
         /jgOWgbjTiaPZ6OfmLIjhosf0/jx8PW1ZA+BN1dl+Idk0tg4XSPBKJXGT4NTZJwkWRFD
         WGBQGR87IKuhDi7r2ID3ZBl6yH9ZFSLHyzaAw5juBWtXUtv8uF3IpGjQ1mcu8yvMC9bd
         QGqjzPnEZ7DlCnfjsacDeLEkSQNcHA7p8mOiNum32ldMN0jbAreg/XQ1YmvLDIvwbsfF
         OM7kDBUdjVWuU3Q2kx6ynQkNeysP7PSjaSQMMHtAiNyWKQ4rzsHLc7JMklZRR2P7xb7h
         3Mpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686586091; x=1689178091;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WKBJpgAjxkTqVCYd92h8q98HsWwnllVXy8B4SSiuAkk=;
        b=ilyQidmqmYbPehqNtmOLpTlf44N47HhNbUrfITwEiPTnY1LUHKHXRnc1T//DbjbZpu
         dxBi2xbjF8k6Y7lko/0OxouNG4OFoX0OTYko65wfM1ghoGSBPJQQ868l8T4arat/25T7
         WsI0N6vX4Z7IQ4XJAz0gPCh3UOGDndXnfQos4KW+FppPLRoQf2i4YFc/0A/Q1hvKj2ID
         tqAKpd3hoO8DropBXz6JUBoOr/Ex+LKAWFDYVLuqGbM+XNYLV+62bPrwi2Ivyh0NuYR+
         mgS8OKp4SBH6EgX5Mv/GypSeSqdPxpoSWUh3diH1LFQX1hZXa8C68XR0pH69YaBwccwk
         7gmw==
X-Gm-Message-State: AC+VfDz6uvjl30leoYE47KJy4ixfe9L1tLqDqVZW0uU04f3pscG1ct9E
	OLsrWHuoWjgLTO1bDUlkbxyPDMsIAC8=
X-Google-Smtp-Source: ACHHUZ5srdPpmtRqTGLbamUCTf8w/aiRtDPhL4Wtwemqh5ad97Jap2Gdhr3S40KSuVTKgfT0X8xW1g==
X-Received: by 2002:a2e:86d9:0:b0:2aa:4550:916c with SMTP id n25-20020a2e86d9000000b002aa4550916cmr2964643ljj.53.1686586091162;
        Mon, 12 Jun 2023 09:08:11 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id y19-20020a2e9d53000000b002ad5f774579sm1810216ljj.96.2023.06.12.09.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 09:08:10 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yhs@fb.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v5 0/4]  verify scalar ids mapping in regsafe()
Date: Mon, 12 Jun 2023 19:07:57 +0300
Message-Id: <20230612160801.2804666-1-eddyz87@gmail.com>
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
[V2]  https://lore.kernel.org/bpf/20230530172739.447290-1-eddyz87@gmail.com/T/
[V3]  https://lore.kernel.org/bpf/20230606222411.1820404-1-eddyz87@gmail.com/T/
[V4]  https://lore.kernel.org/bpf/20230609210143.2625430-1-eddyz87@gmail.com/
[RFC] https://lore.kernel.org/bpf/20221128163442.280187-1-eddyz87@gmail.com/
[1]   https://gist.github.com/eddyz87/a32ea7e62a27d3c201117c9a39ab4286
[2]   https://lore.kernel.org/bpf/20230530172739.447290-1-eddyz87@gmail.com/T/#mc21009dcd8574b195c1860a98014bb037f16f450
[3]   https://lore.kernel.org/bpf/20230606222411.1820404-1-eddyz87@gmail.com/T/#m89da8eeb2fa8c9ca1202c5d0b6660e1f72e45e04

Eduard Zingerman (4):
  bpf: use scalar ids in mark_chain_precision()
  selftests/bpf: check if mark_chain_precision() follows scalar ids
  bpf: verify scalar ids mapping in regsafe() using check_ids()
  selftests/bpf: verify that check_ids() is used for scalars in
    regsafe()

 include/linux/bpf_verifier.h                  |  25 +-
 kernel/bpf/verifier.c                         | 223 +++++-
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_scalar_ids.c | 657 ++++++++++++++++++
 .../testing/selftests/bpf/verifier/precise.c  |   8 +-
 5 files changed, 883 insertions(+), 32 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_scalar_ids.c

-- 
2.40.1


