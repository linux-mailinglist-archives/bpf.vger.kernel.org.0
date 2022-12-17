Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0397364F6FA
	for <lists+bpf@lfdr.de>; Sat, 17 Dec 2022 03:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiLQCRj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Dec 2022 21:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiLQCRi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Dec 2022 21:17:38 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8DC1D30E
        for <bpf@vger.kernel.org>; Fri, 16 Dec 2022 18:17:36 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id bp15so6115192lfb.13
        for <bpf@vger.kernel.org>; Fri, 16 Dec 2022 18:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W/ObBTM8+S9DBBCWDCdnF01Ld6D6DWTWnfDRwKkJhNI=;
        b=BF/sWFGaM01+Nh0mvAcmqbSyVUEYwOer0qHA+TX5QHhOt4RJWF9IqRp03LRZwtfLRK
         bPAB5GbI43A3WSMNcC9JIBhI2yMeIZzWEYj9hXMTqJ8huFFfKxJ4Iu/Lh0eNihwXoAxP
         43xOkYQ4Mu/TzMhYswEYdCNxaNeH2F8EntmIWY6zVlrkEw4IMZoPb79Z7sf7fKj8CyCM
         C1yB22VKEbUMRjT544UqRSFjOgAbmvS2SfIEilxGo5r+aC+y2LQ9e32x+POQIXX+CBV7
         REvfPkOJoXS0U3BocGBAyex4j8WXiUGNE9Prl1+GktOJrWSQGbUctTGV2kgCz/kCGOew
         fZow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W/ObBTM8+S9DBBCWDCdnF01Ld6D6DWTWnfDRwKkJhNI=;
        b=u8F3ZOypdGRtDotYU1FzU0WoFOD7Ym1MWx6xtWNtgZ+LvT3cKMm+QOHed5g0LljnCa
         0P6Pmto0ocEceo41aeeIcaI9nnZpUvTbsAATTlgI1wwK8FkFyK9E3enHNB+353HhxeZ5
         JHlsTog57MIiZ46Rp6s4uEoPFWUXjtqunLroNIzAyu554fOxXs2bF2tLbRajHk9ksXV2
         Q0qNCxBbWEvZDYrRA3GkRhJbYTAKe0sgm9apMAfFIla4rmoRwTDM09r7Lvm5mDdzUPeY
         5cssZglT7uzongpi+lLB4FH6gXmje/71E/fAavELIxRa4TENxRjs3UmlcF6WDt8TDJPL
         JZwA==
X-Gm-Message-State: ANoB5pmP2xICG3hXuGz+tSgFYK5awTKbl6lVg7aWSd2dpTCtQmvM9KuS
        UcaOYXhonS7ZagdMykgclwBsqq78DmM=
X-Google-Smtp-Source: AA0mqf603viG57PAhjRDLMxDSIFrfYfC29K3JJZ+O4e/NDdvVeJF/oZwdArGK65hFaT+kQM5BJvQKA==
X-Received: by 2002:a05:6512:1385:b0:4ab:b2c:75b1 with SMTP id p5-20020a056512138500b004ab0b2c75b1mr12184050lfa.2.1671243454737;
        Fri, 16 Dec 2022 18:17:34 -0800 (PST)
Received: from pluto.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id x17-20020ac259d1000000b0049e9122bd0esm370850lfn.114.2022.12.16.18.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 18:17:33 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 0/4] reduce BPF_ID_MAP_SIZE to fit only valid programs
Date:   Sat, 17 Dec 2022 04:17:07 +0200
Message-Id: <20221217021711.172247-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.38.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is a follow-up for threads [1] and [2]:
 - The size of the bpf_verifier_state->idmap_scratch array is reduced but
   remains sufficient for any valid BPF program.
 - selftests/bpf test_loader is updated to allow specifying that program
   requires BPF_F_TEST_STATE_FREQ flag.
 - Test case for the verifier.c:check_ids() update uses test_loader and is
   meant as an example of using it for test_verifier-kind tests.

The combination of test_loader and naked functions (see [3]) with inline
assembly allows to write verifier tests easier than it is done currently
with BPF_RAW_INSN-series macros.

One can follow the steps below to add new tests of such kind:
 - add a topic file under bpf/progs/ directory;
 - define test programs using naked functions and inline assembly:

	#include <linux/bpf.h>
	#include "bpf_misc.h"
	
	SEC(...)
	__naked int foo_test(void)
	{
		asm volatile(
			"r0 = 0;"
			"exit;"
			::: __clobber_all);
	}
	
 - add skeleton and runner functions in prog_tests/verifier.c:
 
	#include "topic.skel.h"
	TEST_SET(topic)

After these steps the test_progs binary would include the topic tests.
Topic tests could be selectively executed using the following command:

$ ./test_progs -vvv -a topic

These changes are suggested by Andrii Nakryiko.

[1] https://lore.kernel.org/bpf/CAEf4BzYN1JmY9t03pnCHc4actob80wkBz2vk90ihJCBzi8CT9w@mail.gmail.com/
[2] https://lore.kernel.org/bpf/CAEf4BzYPsDWdRgx+ND1wiKAB62P=WwoLhr2uWkbVpQfbHqi1oA@mail.gmail.com/
[3] https://gcc.gnu.org/onlinedocs/gcc/Basic-Asm.html#Basic-Asm

Eduard Zingerman (4):
  selftests/bpf: support for BPF_F_TEST_STATE_FREQ in test_loader
  selftests/bpf: convenience macro for use with 'asm volatile' blocks
  bpf: reduce BPF_ID_MAP_SIZE to fit only valid programs
  selftests/bpf: check if verifier.c:check_ids() handles 64+5 ids

 include/linux/bpf_verifier.h                  |  4 +-
 kernel/bpf/verifier.c                         |  6 +-
 .../selftests/bpf/prog_tests/verifier.c       | 12 +++
 tools/testing/selftests/bpf/progs/bpf_misc.h  |  7 ++
 .../selftests/bpf/progs/check_ids_limits.c    | 77 +++++++++++++++++++
 tools/testing/selftests/bpf/test_loader.c     | 10 +++
 6 files changed, 112 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/verifier.c
 create mode 100644 tools/testing/selftests/bpf/progs/check_ids_limits.c

-- 
2.38.2

