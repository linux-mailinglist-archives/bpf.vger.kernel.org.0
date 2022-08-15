Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F186A592908
	for <lists+bpf@lfdr.de>; Mon, 15 Aug 2022 07:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbiHOFQG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Aug 2022 01:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240520AbiHOFPq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Aug 2022 01:15:46 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB1010FC
        for <bpf@vger.kernel.org>; Sun, 14 Aug 2022 22:15:43 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id b96so8340908edf.0
        for <bpf@vger.kernel.org>; Sun, 14 Aug 2022 22:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=9CCoLvYyFi/AhbGlKLO2jMiAkaDuTB4X1U6P5Ug9Dd8=;
        b=Uf4U/5B+0Xsmd++CStip+fsMBryiNCA4u798j8U2bJelmbOwwOlkr7Fp6xmsXEDuFa
         U7UIL+zzzKWH4UKBPI5l4pqtRhjC9vKsJsIlCYbrMzclX3XPykQ1631e504U0zjFPE99
         8SNZCdDdqY6Nkirk5NAtZ5tYnOfAVzg2XtVnBylThksmGnJS2IPupQLlt6iYFc/J9lx3
         wcXoDFRQJ62KBDovf/wzTSGp+FyZ7UHgzXjncatphNupkdhZu+uOI55S2Kt12goNlJo1
         ISmUy045frXb+Pv9RnrbxNI4nYn5upkqZG9ppo0KCxI6xIZFxmPHnRPWznwp8Jo9z5wk
         zLBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=9CCoLvYyFi/AhbGlKLO2jMiAkaDuTB4X1U6P5Ug9Dd8=;
        b=QFG/I1a7YD19vJBAp3xRnek+z74xYQWJNYFk4lUtKTR/jI42IvuVXaxwjyDIMMR+6V
         p3x+vCDYxETuhBuTy6tmj3N9xyyiwpVZD1vjpvFMvNsmAhdeZVJpfSyEuLIUGqaeJqrM
         C1ajDWUC9DA0P5+paqkpYWJEkvSOeExL2cnccQcEqLPg1Z3C2bD4qWvIqKLzWUC/tN+E
         S1UOVJkskU3pER8RdQtdDhZgY4oERMLc0/F68gDD0/5SOhDJ/HwdwwmCnsnfjiEbN8+9
         xy63A5LCUhAa7fbQdvYhwDc8s/oKKD95jUoKMLlZMY/11Jy5Mt+p9aDffXK0F8pzF0aj
         iPhw==
X-Gm-Message-State: ACgBeo1TwUbEL36WcL0bCOOszvCCK1kyXeFoQC9q/xcGvURAEFFqZeh0
        oB+Lp8Tbzi2LhvC4EhU5RS4Yq8G5MFQ=
X-Google-Smtp-Source: AA6agR5e25x9lFNVU3xwWriL8AY+Ns/n+w3tpmVgGdvhhnTwnQFnhpZD4CGS4ItENpmQU7dDsC25EA==
X-Received: by 2002:a05:6402:3210:b0:43d:20bc:5e4 with SMTP id g16-20020a056402321000b0043d20bc05e4mr12915375eda.276.1660540542059;
        Sun, 14 Aug 2022 22:15:42 -0700 (PDT)
Received: from localhost (vpn-253-028.epfl.ch. [128.179.253.28])
        by smtp.gmail.com with ESMTPSA id l13-20020a170906078d00b0072af0b036f3sm3618769ejc.41.2022.08.14.22.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 22:15:41 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH RFC bpf v1 0/3] Verifier callback handling
Date:   Mon, 15 Aug 2022 07:15:37 +0200
Message-Id: <20220815051540.18791-1-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4937; i=memxor@gmail.com; h=from:subject; bh=t7mRsQeEykX9XMOkbSEXvhDuGd+pW9+aUud2RvAOK44=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBi+dZHI+atbCjMYzwpkmoBDCSjxQ3k459ZsBgba+8p dhW2NQ6JAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYvnWRwAKCRBM4MiGSL8Ryi+FD/ 0aYmxpiQsQM+IgsgDg5fbvM3bwUYRd1U3b32C0RhyGj5Zh2xYe5Rla015H76P1xvYOW0qumUjV3X60 xMbQBoloxjPOPJFNIl6rPgy9DibdIBy/RZ2W8qmlx/B4WGzqCyZl+N+Q1G5LK1LAqkwO4UHiweT1h6 tKbEg25v5zzNhBoalHUpTw2QHX0gd+9lnDN3rmz6y9JvZUNnOzBPDAts2ievnh8Wkl3UMgH7NWCQuG RSwwRM29Vh9iMBIfjJeqRT/ePkdh/IZ0uhfy3kBXi6GFdc+ktDWJNXNtnFYcL7uTFiIZsdf0XVegUx j2/UM/tcUXpUOIN1lQCZUf1FzWjr+tDFkzq65Pyi032lQez0j6aoYCEUlrAKbXBMGsay6apRelxm4D AIbRSK11UEif8AEuQSRhgKGOQtLtlV239wDqAtsdWc4LoOM0B/l0g89WBePzZ+LwTADaaNy14J3lPI 29ciVm9JQ26UTkb9gdED3rzEAuMltbnPnV0j1+DstpD4EPbJyxeBMtLdk0InZQGtz4UReF21RNzhOP ZKKXs2YIKgFiU/T4oZGis2BxV22NbApshiX8CjcCSdv/OYAb+jDzloH7QvpNIeCbTUG0rS8dsWO+qQ IMg4WGTjO7DNVv46lW3KscfrspcwCqdWM8Fv1aAlftgVJGav7zbkmfsjpSLg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi, these are fixes for issues I noticed while working on the callback code.
It is an RFC because I would like to discuss how to fix one other problem,
I have a rough idea but would like to discuss before working on it, since
it isn't trivial. The conservative fix doesn't pass existing selftests.

It seems like the problem anticipated in [0] actually exists with all the
current callback based loop helpers, in a different form. The main reason is
that callback function is only explored as if it was executing once.

There are some example cases included in selftests to show the problem, and make
sure we keep catching and rejecting them. Since callback which is loop body is
only verified once, once the for_each helper returns the execution state from
verifier's perspective is as if callback executed once, but ofcourse it may
execute multiple times, unknowable statically.

Patch 1 fixes the case of acquiring and releasing references, unless I missed
some corner case it seems to mostly work fine.

In the future when we have a case where a sycnhronous callback will only be
executed once by a helper, we can improve this case by relaxing these
restrictions, so transfer of references and verifying callback as if it executes
only once can be done. For now, all in_callback_fn function get executed
multiple times, hence that change is left for when it will be needed.

Now, the important part:
------------------------

The included selftest will fail/crash, as one fix is missing from the series.
Whatever I tried so far wasn't backwards compatible with existing selftests
(e.g. conservatively marking all reads as UNKNOWN, and all writes scrubbing
stack slots). Some tests e.g. read skb pointer from ptr_to_stack passed to
callback.

It is not clear to me what the correct fix would be to handle reads and writes
from the stack inside callback function. If a stack slot is never touched inside
the callback in any of the states, it should be safe to allow it to load spilled
registers from caller's stack frame, even allowing precise scalars would be safe
if they are read from untouched slots.

The idea I have is roughly:

In the first pass, verify as if callback is executing once. This is the same
case as of now, this may e.g. load a spilled precise scalar, then overwrite it,
so insns before the store doing overwrite verification consider register as
precise. In reality, in later loop iterations though this assumption may be
wrong.

For e.g.
int i = 1;
int arr[2] = {0};

bpf_loop(100, cb, &i, 0);

cb:
	int i = *ctx;		 // seen as 1
	func(*((int *)ctx - i)); // stack read ok, arr[1]
	*ctx = i + 1;		 // i is now 2

verification ends here, but this would start reading uninit stack in later
iterations.

To fix this, we keep a bitmap of scratched slots for the stack in caller frame.
Once we see BPF_EXIT, we do reverification of the callback, but this time mark
_any_ register reading from slots that were scratched the first time around as
mark_reg_unknown (i.e. not precise). Moreover, in the caller stack it will be
marked STACK_MISC. It might not be able to track <8 byte writes but I guess
that is fine (since that would require 512 bits instead of 64).

The big problem I can see in this is that the precise register guards another
write in another branch that was not taken the first time around. In that case
push_stack is not done to explore the other branch, and is_branch_taken is used
to predict the outcome.

But: if this has to cause a problem, the precise reg guarding the branch must
change its value (and that we can see if it is being from a scratched slot
read), so by doing another pass we would get rid of this problem. I.e. one more
pass would be needed after downgrading precise registers to unknown.

If I can get some hints for new ideas or feedback on whether this would be the
correct approach, I can work on a proper fix for this case.

It seems like roughly the same approach will be required for open coded
iteration mentioned in [0], so we might be able to kill two birds with one shot.

Thanks!

  [0]: https://lore.kernel.org/bpf/33123904-5719-9e93-4af2-c7d549221520@fb.com

Kumar Kartikeya Dwivedi (3):
  bpf: Move bpf_loop and bpf_for_each_map_elem under CAP_BPF
  bpf: Fix reference state management for synchronous callbacks
  selftests/bpf: Add tests for callbacks fixes

 include/linux/bpf_verifier.h                  |  11 ++
 kernel/bpf/helpers.c                          |   8 +-
 kernel/bpf/verifier.c                         |  42 +++--
 .../selftests/bpf/prog_tests/cb_refs.c        |  49 ++++++
 tools/testing/selftests/bpf/progs/cb_refs.c   | 152 ++++++++++++++++++
 5 files changed, 249 insertions(+), 13 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cb_refs.c
 create mode 100644 tools/testing/selftests/bpf/progs/cb_refs.c

-- 
2.34.1

