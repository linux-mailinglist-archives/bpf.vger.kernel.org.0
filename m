Return-Path: <bpf+bounces-1449-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B1B716AE9
	for <lists+bpf@lfdr.de>; Tue, 30 May 2023 19:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B482F1C20C0A
	for <lists+bpf@lfdr.de>; Tue, 30 May 2023 17:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEEC21069;
	Tue, 30 May 2023 17:28:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05932200C0
	for <bpf@vger.kernel.org>; Tue, 30 May 2023 17:28:23 +0000 (UTC)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30E3133
	for <bpf@vger.kernel.org>; Tue, 30 May 2023 10:27:54 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f4b384c09fso5566322e87.3
        for <bpf@vger.kernel.org>; Tue, 30 May 2023 10:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685467673; x=1688059673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d3wDcmeTHr7boio+yEZS2B/szuVLcImnniczAj2fuog=;
        b=WHgWoLw8IYiqZp6m1VyWtljRzr4EXFsMFJaZmT0ABMR6OTVN6xbJzis3pHibGWQYFV
         g58oTsC/2kLlglnOzQK/BagjoCJ4J0sMK98sFZsCrYu56+1unOX48u8TOTy6+8WMgjDX
         xO7ZHmzkNwozQttvkDHcAHslqWEVQ2it4wlS8Eprr8Yjekpj19K9KF1zkYyFUALzrSlJ
         WL7DthoeSkKgjOdsuICi4ZoSrOwaIFv0SjHHEWKHrmE80am0rq5YJTx1GBBw1NTqGpOV
         oHiMwNVwjzWGqPo6x8XmYKR35YF+dfp5EgFLz0z6Q02rU1LFM1+QCAJK24hKyfx7g4U4
         GWRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685467673; x=1688059673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d3wDcmeTHr7boio+yEZS2B/szuVLcImnniczAj2fuog=;
        b=iUsWf3JHuFXxEljDjZTa4Z0sIOMu8dvHVl2dT9sN9zC+94Tw8NmR7v5CX5dZEVKXY7
         ZeDd6Gv/iMYzC5fwVHJold4CsiqL+UiU9AMeVWTfzpT1TkTsJTnRd/2rMJhAaAu7M7+i
         2ZGHKKajybhA5h4wskBHILTx99LTtIOImMKaQkSQ4p+GcQuQSMF2g1nIbHnWkP8J65SO
         zizgJn5AWanBSFeh0NefPwOxJfgP2w8zQBEzo+NnbHCK26ZbBJcRfENz769Oc7EtqsJv
         3aSUp+b4R7eSvKwI9//Akk/BsJWL42XEMZZ7S5FYaMvxWq5uqvm0q0ao9U9YhlbXvkD7
         zUiQ==
X-Gm-Message-State: AC+VfDwXBzdZ6YYspe3igYAW5TLOGo9egcjLJb7QuFuJ6+vZzRIIaHxp
	yYyqlYBX5Ma1DYjdjj2nSyxRkfn15yheYQ==
X-Google-Smtp-Source: ACHHUZ4QgH2iGiBn2golRVssKMb/2PKW4Ny6k9fI/YWE5Iu8/B84J7OQHwEe2cRETCEYIwW5NydZcQ==
X-Received: by 2002:ac2:44ae:0:b0:4f3:8196:80cb with SMTP id c14-20020ac244ae000000b004f3819680cbmr1360289lfm.41.1685467672369;
        Tue, 30 May 2023 10:27:52 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id a1-20020a056512020100b004f262997496sm405985lfo.76.2023.05.30.10.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 10:27:51 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yhs@fb.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 0/4] verify scalar ids mapping in regsafe()
Date: Tue, 30 May 2023 20:27:35 +0300
Message-Id: <20230530172739.447290-1-eddyz87@gmail.com>
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
- patches #1,2:
  - correctness fix for regsafe();
  - test cases.
  Patch #1 has a big hit on verification performance.
- patches #3,4
  - modification for find_equal_scalars() to save ids of registers
    that gain range via this function;
  - modification for regsafe() to do check_ids() for scalar registers
    only for such ids;
  - test cases.
  Patch #3 restores most of the verification performance.
  
A note on design decisions for patch #3. The change in patch #1 is
simple but very heavy handed:

  @@ -15151,6 +15151,28 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 
 	switch (base_type(rold->type)) {
 	case SCALAR_VALUE:
  +		/* ... */
  +		if (!check_ids(rold->id, rcur->id, idmap))
  +			return false;

Ideally check_ids() should only be called for 'rold' that either:
(a) gained range via find_equal_scalars() in some child verification
    path and was then marked as precise;
(b) was a source of range information for some other register via
    find_equal_scalars() in some child verification path, and that
    register was then marked as precise.

While rold->precise flag could be a proxy for criteria (a) it is,
unfortunately, cannot be a proxy for criteria (b). E.g. for the
example above precision marks look as follows:

                           Precise registers
  5: r6 = r7              ; r7
  6: if (r6 > X) goto ... ; r7
  7: r9 += r7             ; r7

Jump at (6) cannot be predicted, thus there is no precision mark on r6.
If there is ever a jump to (6), cached state will not have precise
marks for r6.

This leaves two options:
- Modification of precision tracking to take find_equal_scalars() into
  account.
- Find a way to track which ids were used for range information
  transfer in find_equal_scalars().
  
The former is a bit complicated, because information about register id
assignments for instructions in the middle of a state is lost.
It is possible to extend bpf_verifier_state::jmp_history to track a
mask for registers / stack slots that gained range via
find_equal_scalars() and use this mask in backtrack_insn().
However, this is a significant complication for a very non-trivial code.

Thus, in patch #3 I opted for a latter approach, accumulate all ids
that gain range via find_equal_scalars() in a set stored in struct
bpf_verifier_env.

To represent this set I use a u32_hashset data structure derived from
tools/lib/bpf/hashmap.h. I tested it locally (see [1]), but I think
that ideally it should be tested using KUnit. However, AFAIK, this
would be the first use of KUnit in context of BPF verifier.
If people are ok with this, I will prepare the tests and necessary
CI integration.

Changelog:
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
[RFC] https://lore.kernel.org/bpf/20221128163442.280187-1-eddyz87@gmail.com/
[1]   https://gist.github.com/eddyz87/a32ea7e62a27d3c201117c9a39ab4286

Eduard Zingerman (4):
  bpf: verify scalar ids mapping in regsafe() using check_ids()
  selftests/bpf: verify that check_ids() is used for scalars in
    regsafe()
  bpf: filter out scalar ids not used for range transfer in regsafe()
  selftests/bpf: check env->that range_transfer_ids has effect

 include/linux/bpf_verifier.h                  |   4 +
 kernel/bpf/Makefile                           |   1 +
 kernel/bpf/u32_hashset.c                      | 137 +++++++++++
 kernel/bpf/u32_hashset.h                      |  30 +++
 kernel/bpf/verifier.c                         |  66 +++++-
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_scalar_ids.c | 214 ++++++++++++++++++
 7 files changed, 447 insertions(+), 7 deletions(-)
 create mode 100644 kernel/bpf/u32_hashset.c
 create mode 100644 kernel/bpf/u32_hashset.h
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_scalar_ids.c

-- 
2.40.1


