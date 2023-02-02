Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A096889DF
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 23:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbjBBWgC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Feb 2023 17:36:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjBBWgC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 17:36:02 -0500
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A3169B2B;
        Thu,  2 Feb 2023 14:36:00 -0800 (PST)
Received: by mail-qt1-f170.google.com with SMTP id h24so3779409qtr.0;
        Thu, 02 Feb 2023 14:36:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H1RWtgYPbEvmI/EJRqa0d+Xhxai9DiYB+ycehXpxkH0=;
        b=t+FlqvpE602P1yRXG3UQjv8lwKREfnnbinBAe/SvlOLVo1jFMIEbuTPvB6LvbgrL75
         J+rKEEzrAYb/IK3Nwb8VJaAMAt0BpbYMcj7DaEvni5s5y2PVMvor5TAzHFVPbt49/r5u
         v/1QCMixRpXkbUqkvUJZWkwovRfKg/JjZFu5xofXl13fle+zdvn9dykfS8G1qgEnkkEI
         xyNLgjIcc0HdpH+6JqedQd7Qi/q7Cv2Z0HNa3vNqpDvQ7E1IE07enNvQFwZ+oU1fuWxI
         T5JKuYqHOcuw2eMUzggqyoiLzdszn/GFdl2PfGmm6P+14fptaBGY4MFE9C6eUUYKWMns
         M5yA==
X-Gm-Message-State: AO0yUKWdNT6QeS8ku7vJv73DshahmNUaCuLwgdXqn01j0kx0KlGz+goo
        MxAfJTL54Z/i0veXPMIdjHgbYMBPGbB6slcf
X-Google-Smtp-Source: AK7set9ObD4PUAAhc/hm82X4nvhTIe1K9k7Y8grUQ4drlluCf0MCvUAa9S5FmR5UyIFgxjUsGKyUcQ==
X-Received: by 2002:a05:622a:44c:b0:3b8:26a7:d608 with SMTP id o12-20020a05622a044c00b003b826a7d608mr15700878qtx.19.1675377359511;
        Thu, 02 Feb 2023 14:35:59 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:9cc7])
        by smtp.gmail.com with ESMTPSA id cx4-20020a05620a51c400b0071d2cd07560sm546276qkb.124.2023.02.02.14.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 14:35:59 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, toke@redhat.com, brouer@redhat.com,
        corbet@lwn.net, linux-doc@vger.kernel.org
Subject: [PATCH bpf-next v2 0/1] Document kfunc lifecycle / stability expectations
Date:   Thu,  2 Feb 2023 16:35:56 -0600
Message-Id: <20230202223557.744110-1-void@manifault.com>
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

This is the v2 of the proposal for documenting BPF kfunc lifecycle and
stability. v1 of this proposal can be found in [0]. As [0] indicates,
Toke has also provided several RFC proposals, the most recent of which
is can be found in [1].

Much of this proposal is based on Toke's prior patches on this topic,
and group discussions at BPF office hours. Anyone who participated
in either prior proposals for kfunc lifecycle / stability documentation,
or in BPF office-hour discussions, may feel free to submit
Co-developed-by tags in place of Acked-by, Reviewed-by, etc.

Changelog
---------
v1 -> v2:
- Move some of the main points of the arguments around. v1 underscored
  quite strongly that kfuncs don't have _any_ stability guarantees.
  While true, it may scare away users who misinterpret the implications
  of that to mean that things will change wildly and at any time.
  Reframe the general flow of the section to still be clear that no
  stability is guaranteed, but front-load the content that clarifies why
  this isn't necessarily something to be afraid of (Toke, Daniel, and
  others).
- Add a paragraph explaining that out-of-tree BPF programs that use
  kfuncs are relevant to discussions surrounding whether kfuncs should
  be modified or removed. While the onus is on kfunc users to explicitly
  engage with the upstream community to let them know which kfuncs
  they're using and why they're useful, the added paragraph also makes
  it clear that the BPF community will in turn participate in upstream
  discussions to ensure that such users aren't equated with out-of-tree
  module users and outright ignored. Also make it clear that our hope is
  that BPF programs will be upstreamed on a more regular basis (Toke,
  Daniel, and others).
- Remove patches that add KF_DEPRECATED flag to <linux/btf.h>. They'll
  remain in the documentation for now, and will be merged at a later
  time when it's actually a useful signal for developers (Alexei).

[0]: https://lore.kernel.org/all/20230202163056.658641-1-void@manifault.com/
[1]: https://lore.kernel.org/all/20230201174449.94650-1-toke@redhat.com/

David Vernet (1):
  bpf/docs: Document kfunc lifecycle / stability expectations

 Documentation/bpf/kfuncs.rst | 139 +++++++++++++++++++++++++++++++++--
 1 file changed, 134 insertions(+), 5 deletions(-)

-- 
2.39.0

