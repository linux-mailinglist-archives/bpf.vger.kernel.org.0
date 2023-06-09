Return-Path: <bpf+bounces-2263-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4F472A50F
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 23:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE6AF1C21132
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 21:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7181E51A;
	Fri,  9 Jun 2023 21:01:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAB21DDDC
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 21:01:57 +0000 (UTC)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC17211C
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 14:01:55 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b1b3836392so25023341fa.0
        for <bpf@vger.kernel.org>; Fri, 09 Jun 2023 14:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686344513; x=1688936513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+kTWDB11Xhwdtupcfaoj/2xsxK0Pqljws5x5mWL1Pg4=;
        b=FmQskKdmPfgxH5dXVHFQO37ALxKC89tRTBjKDQo/FOehMyvBG+94HADFSFIdGT8EJB
         O5h1Colhwaq/e+WaIPdN0UOAx7/PVNxkm2qatVSWhiAxlG/0jnPA4Ei9SDZO3eTnI3sD
         t22lW3h+IQZ4UKZOHRT1792EmbHa47m2/U589/HIQBALrCehyNa1yaruG9LTjdOj+n6h
         QyQDQ6eq0u1WrSawNv6PLNaf0ojqxYwxS3rrNIQN6a+PTlmf7BqQr9DugrPBd7G4xuS7
         HGe2YzF0THkbT4NvH/AgE45bEDGv4p6a7Qp1GlWg99Jw+V5oZkdQ+cCSWtrjULNzyNWc
         oHBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686344513; x=1688936513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+kTWDB11Xhwdtupcfaoj/2xsxK0Pqljws5x5mWL1Pg4=;
        b=J+IuKGE4JTnfAn5oOtTCO4TYMBjNUIKbFjXrmwwEYV/CikjJ0tVUW8ovPz566whoa1
         YnXUJqCxxTH86U8CZKAwZXVG7m6qlDybwEQNzLRiEf37NxdUp2LPQ4vgPNfdWM/VVt1Y
         jNnsBHdw6Fxv3YZTt6a4rypRU/SmgYVQDbVYp/5t0F+VKg1SYDGp9UHrL2S4D5oh3WZY
         7jMfgnjxOjHM88YTdvDnvbE/hd8kBkl5vU/SspRtU7YUJ9nN/t+AA1sh7uTIi2eLZDkT
         XDWjRpfALT2s9m3uSzUscU1Vg0SeSPQv2RWwn2TqCMd42ugdVJCosK3qAqTfnh6cG5Wg
         Wf2g==
X-Gm-Message-State: AC+VfDyw13qOvOwG+nYq40Tu95X+g+yGnNSRxJwsK59isZpVtsEK0lS9
	j/9SuSLN2jF6IApreWLPf/lHMVYipK4=
X-Google-Smtp-Source: ACHHUZ5WT2pgIbVe1jIXXR1WMm9ix/ZlzkFccNjmgZGqGJ8OBdNpfPtSddTsVd/WFkhhoqWI/NNHmQ==
X-Received: by 2002:a2e:b0c3:0:b0:2b1:d34d:4e08 with SMTP id g3-20020a2eb0c3000000b002b1d34d4e08mr1815ljl.6.1686344513356;
        Fri, 09 Jun 2023 14:01:53 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id x1-20020a2e9dc1000000b002a8bc2fb3cesm521732ljj.115.2023.06.09.14.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 14:01:52 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yhs@fb.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v4 0/4] verify scalar ids mapping in regsafe()
Date: Sat, 10 Jun 2023 00:01:39 +0300
Message-Id: <20230609210143.2625430-1-eddyz87@gmail.com>
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

 include/linux/bpf_verifier.h                  |  11 +-
 kernel/bpf/verifier.c                         | 192 ++++-
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_scalar_ids.c | 657 ++++++++++++++++++
 .../testing/selftests/bpf/verifier/precise.c  |   8 +-
 5 files changed, 860 insertions(+), 10 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_scalar_ids.c

-- 
2.40.1


