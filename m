Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2CA6262E3
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 21:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233768AbiKKU1z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 15:27:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233172AbiKKU1y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 15:27:54 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB477BE77
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 12:27:54 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so8681491pjc.3
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 12:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kRb/y28SjFJr7YFJF5InSwNrIh8gP6FQQbm8sZA08yw=;
        b=f3CJ2O7SSEGoHLXG5cgC5DIDAbLPrw+YuYpMUMw3KQ58XHO28w3RoSKHxiWKn2VQDn
         wka3q9UrM6VKoKmyUqoHizzNBV6PJPY5JTNbL4RzdU5yHI+KCj/vPEkkC7eRY0rsxIMf
         HG+bFOALXWv4XZ2SbcSNJGg4LBy0QTiLMPT6nghFls+9H4DqCh1nw4urlU0UQRcFx4pf
         Q3bJk0+Ao2eQTdyJIZ+M1tZ1uXYy43MP5OFpa1qOVijk+TO/cnB/9vTm85wuZ/5A/omL
         JW/2HKaCqMYY1kz9WWS6N1XNNSlgNqN436BiJ6d2urrU73w8siso0FDTcqjWjQcjy4JT
         TzEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kRb/y28SjFJr7YFJF5InSwNrIh8gP6FQQbm8sZA08yw=;
        b=gQwISWkMeLag6sjThBq+kSwAzPuEOwo1g6qTLvqrFXsB9A2lA0mUUoMVp38OM5U7wW
         aUP+8gt2E1K3DxD/A7niBl6o89n6shoPkZ1FlvC29vN5XVNe7XcMFBBHQMtgyBupicKX
         RwaePxOqf4coe9QQBBv57v21sC7MwVeFzODjgTqDXJXkfzpaeEN/4qtLDm/G8jtmnVmX
         eMEw/PHie6BLAvtMOFoHgiJB74gU5o/SN4Ba1lP01DgSHCAj+Sh1phvUCDn+NwsNf1wB
         e6EZah8hRqsy7UTU2rW5ihjq246R4l8J2T5nrsMkbSeBz3u+UVLHptd5xNx2xTx8V1EG
         NGEQ==
X-Gm-Message-State: ANoB5pnwGQpxRTMaWb837JGCd/ZEahA4jkHtZ2VwewjKqYIwipZrot0t
        c6Qtpoynf9LmHqodxuZ2F+LkpFzApKIuoA==
X-Google-Smtp-Source: AA0mqf6kKpgoAQt/NXjEzpuODdEhTB21Jaed+phkBJURFw5u/zlIU4DPQiWUj2H1Xsln9kCR2X+e3g==
X-Received: by 2002:a17:90a:1b4b:b0:213:bbb1:32d6 with SMTP id q69-20020a17090a1b4b00b00213bbb132d6mr3672183pjq.41.1668198473245;
        Fri, 11 Nov 2022 12:27:53 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id n9-20020a17090a394900b0021282014066sm5295402pjf.9.2022.11.11.12.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 12:27:52 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Edward Cree <ecree.xilinx@gmail.com>
Subject: [PATCH bpf v1 0/2] Fix map value pruning check
Date:   Sat, 12 Nov 2022 01:57:17 +0530
Message-Id: <20221111202719.982118-1-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2227; i=memxor@gmail.com; h=from:subject; bh=7Yxbaw2+eSo9lnxOlyyO47+x6VRiQSBWjpZB3FN5fpM=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjbq/8Kl+aMuVq+KpaAwZNA90f4VPc5jR5lHfSCL4k ghj3vOmJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY26v/AAKCRBM4MiGSL8Ryr06D/ 9qR+HixfQEsqA71zcNcF01cp6WUOLyFH3VX+MWNFOTyDuGJS6FKDNyuw8uU6D4VgPL6a3RWP5nYLOf 0a7kU+IjBRchGpyl2KXCWkaKj/1ZQoYG3WVGM1anOcwIjXa7zX+weIJ7DFZIXCJAjNu5EptCnYRrMM L7z3hKhC2lXD31D3UF3dChLLd/CHCh7i5+F/yiglATreqPIRwyhdzZ6qSV6fhb7VJk5jqE/0Nj7RX5 +fjsCUoelci8lftEKN/4t4787YZo8IRu8gBY9iFUEJ40OM6dAeV59etmFxIBjevquSSCwTLiLRJ1lV pj8slIXQdsEDOddld1ouQdz8zFeWLrw7GQ0iBkvO+w9lDaayX0uqUFbFwXSHHq921/XdGtLo03TmkS cEbQK4QW4F1tmaEko9J/P0He4Q48+l2J/yTpB+++aVsBjf5hBCQ/5S5qoqpieE1yyxKyd8c0dBBq9h duKkfG5tvm4JMs2aK+euLJKNwaR5efgVFxbvk3txoVuBcm7h7KxHNWU4ttjSXeZNC3IzpekX44XcHm jnZeqI28V8yxpsuI7D1zDhsj9mZzRnKrri7KKjigLCBDVSJ3tEz4rXnufqUwm4yccJmXnxL/Jn4iJ9 e8Yz+XB0LG13OI/77BosYOHMMpHcqqCCAa8tNHs/XtweBlchkx6i/GAR2uwA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

While digging into related code for spin lock correctness, the pruning
related checks for PTR_TO_MAP_VALUE in regsafe looked suspect. The
reg->id is never compared (which is preserved only in case the map value
has a bpf_spin_lock) between rold and rcur.

Turns out this allows unlocking a bpf_spin_unlock for a reg with a
different reg->id, i.e. not pairing spin lock calls correctly. A
regression test is included in patch 2.

However, looking more closely, it seems to me that the logic of
check_ids is broken as well.

Edward, given you introduced the idmap, can you provide a little more
historical context on what the idea behind check_ids was, since it seems
to be doing the wrong thing as far as I understood things. I think we
need to compare the ids directly everywhere.

For instance, when we have a case like below:

 	r0 = bpf_map_lookup_elem(&map, ...); // id=1
 	r6 = r0;
 	r0 = bpf_map_lookup_elem(&map, ...); // id=2
 	r7 = r0;

 	bpf_spin_lock(r1=r6);
 	if (cond)
 		r6 = r7;
  p:
 	bpf_spin_unlock(r1=r6);

Only r6 differs between old and cur at pruning point p. If we did the
check in patch 1 using check_ids, it would end up seeing that no mapping
exists for old id so it will set up mapping of 1 to 2, and then return
true.

I think similar problems exist elsewhere where after establishing the
first mapping, if there are no more lookups into idmap, it will just
pass the states_equal check.

We are already inconsistent in other places, since if it made sense
states_equal should have been using check_ids logic for active_spin_lock
checks (but it's not a bug in that case, just more conservative).

If we agree it needs fixing, I will send a separate fix removing its use
from regsafe. For now this patch should address the bpf_spin_lock issue.

Kumar Kartikeya Dwivedi (2):
  bpf: Fix state pruning check for PTR_TO_MAP_VALUE
  selftests/bpf: Add pruning test case for bpf_spin_lock

 kernel/bpf/verifier.c                         | 33 +++++++++++++---
 .../selftests/bpf/verifier/spin_lock.c        | 39 +++++++++++++++++++
 2 files changed, 66 insertions(+), 6 deletions(-)


base-commit: 5704bc7e8991164b14efb748b5afa0715c25fac3
-- 
2.38.1

