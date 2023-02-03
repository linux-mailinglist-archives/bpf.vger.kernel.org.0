Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36092689E93
	for <lists+bpf@lfdr.de>; Fri,  3 Feb 2023 16:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbjBCP5g (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Feb 2023 10:57:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBCP5g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Feb 2023 10:57:36 -0500
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EE19DEED;
        Fri,  3 Feb 2023 07:57:34 -0800 (PST)
Received: by mail-qt1-f177.google.com with SMTP id g18so3595065qtb.6;
        Fri, 03 Feb 2023 07:57:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ptAq1Nz+qavbiH1yZ2NlfSExwEZy3ORIXjKmQZoo71A=;
        b=R97blrCOdQWygAAIXRc9r4M4yw4EXn8fz+XDR0dpkSLUzDb4ZNBZwQB3NLtnaTH5NF
         88WGSS38EZAWcmYu54ez25FQTaOLd0bwpwdZfjX4s9htKoPKVjy2IK349gDmMQ+6uFFj
         H4LUTPE/ylrwGtPq0IkSd+e/gr4qHBFVJm1iP9Or2b9ojpQqAnecjRK5UO/4DXniVwKV
         XqrglL3IO66BXOhhysls2JSgd+vU3nZZ1flBcIJKZgf1C7L/hJa0Ul3/3ybn9l6e02QN
         Qy98SnuIYjhMRztdi9JqWRHciKz/DOFGEfniaor5Kdf6XlgMGnxVdWWCcWo6vi+A5Bkz
         VMiw==
X-Gm-Message-State: AO0yUKUrkgsvAp1Lq28CGlhhELXVSsPxoaf+pbloZcXYDDyzH5hqlk5Z
        BIwaPLc89MEsG76a+uHvodpALPYl1HzmZQgk
X-Google-Smtp-Source: AK7set+yR2VUL1ITjOqRNAZuqB00NOzZN9SoMActG7q3/L6xcP2KCKIZJUqj7o2ek4icRCCDh57KpA==
X-Received: by 2002:a05:622a:1653:b0:3b9:b436:4c6f with SMTP id y19-20020a05622a165300b003b9b4364c6fmr21465951qtj.39.1675439852817;
        Fri, 03 Feb 2023 07:57:32 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:dd5a])
        by smtp.gmail.com with ESMTPSA id h17-20020ac85e11000000b003a5c6ad428asm1774252qtx.92.2023.02.03.07.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 07:57:32 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, toke@redhat.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, brouer@redhat.com, bagasdotme@gmail.com,
        linux-api@vger.kernel.org
Subject: [PATCH bpf-next v3 0/1] Document kfunc lifecycle / stability expectations
Date:   Fri,  3 Feb 2023 09:57:26 -0600
Message-Id: <20230203155727.793518-1-void@manifault.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is v3 of the proposal for documenting BPF kfunc lifecycle and
stability.

v1: https://lore.kernel.org/all/20230202163056.658641-1-void@manifault.com/
v2: https://lore.kernel.org/bpf/20230202223557.744110-1-void@manifault.com/T/

Much of this proposal is based on Toke's writing, and group discussions
at BPF office hours.

Changelog
---------
v2 -> v3:
- Add Co-developed-by tag for Toke, and Reviewed-by tag for Bagas.
- s/period period/period (Donald).
- s/other kfuncs may/usually kfuncs will (Donald).
- Remove verbiage encouraging users to upstream BPF programs (Donald and
  Toke).
- Collapse two paragraphs in KF_DEPRECATED section, and apply Toke's
  suggested wording (Toke).
- s/highly encouraged/encouraged (Toke).
- Use phrasing that is less bad than "more similarly" (Toke).
- s/Said in a different way/In other words (Toke).
- Reword section about out-of-tree BPF program kfunc users being
  relevant to discussions, per Toke's suggested wording (Toke).
- Drop unnecessary extra verbiage in paragraph explicitly stating
  that kfuncs have no hard stability guarantees (Toke).
- Reword second paragraph of 3.1 kfunc deprecation to have cleaner
  language (Toke).
- Drop extraneous qualifier regarding a deprecated kfunc being dropped
  early (Toke).

v1 -> v2:
- Move some of the main points of the arguments around. v1 underscored
  quite strongly that kfuncs don't have _any_ stability guarantees.
  While true, it may scare away users who misinterpret the implications
  of that to mean that things will change wildly and at any time.
  Reframe the general flow of the section to be clear that no stability
  is guaranteed, but front-load the content that clarifies why this
  isn't necessarily something to be afraid of for users (Toke, Daniel,
  and others).
- Add a paragraph explaining that out-of-tree BPF programs that use
  kfuncs are relevant to discussions surrounding whether kfuncs should
  be modified or removed. While the onus is on kfunc users to explicitly
  engage with the upstream community to let them know which kfuncs
  they're using and why they're useful, the added paragraph also makes
  it clear that the BPF community will in turn participate in upstream
  discussions to ensure that such users aren't equated with out-of-tree
  module users, and outright ignored. Also make it clear that our hope
  is that BPF programs will be upstreamed on a more regular basis (Toke,
  Daniel, and others).
- Remove patches that add KF_DEPRECATED flag to <linux/btf.h>. They'll
  remain in the documentation for now, and will be merged at a later
  time when it's actually a useful signal for developers (Alexei and
  Daniel).

David Vernet (1):
  bpf/docs: Document kfunc lifecycle / stability expectations

 Documentation/bpf/kfuncs.rst | 126 +++++++++++++++++++++++++++++++++--
 1 file changed, 121 insertions(+), 5 deletions(-)

-- 
2.39.0

