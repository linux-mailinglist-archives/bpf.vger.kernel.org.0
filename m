Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA08A6C90F9
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 22:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjCYVcA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 25 Mar 2023 17:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjCYVb7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 25 Mar 2023 17:31:59 -0400
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752EECA36;
        Sat, 25 Mar 2023 14:31:58 -0700 (PDT)
Received: by mail-qv1-f41.google.com with SMTP id q88so4267114qvq.13;
        Sat, 25 Mar 2023 14:31:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679779917;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vRFrO9F3wTk5qVcAfLh7TGZaJB83Lq1s27Ng3v/fD6M=;
        b=CR3uxLyvOzP7bD+UGH/YPh89pQf/kFXa6Bj+cC3C72jFiNaNkVi1F0niC93e5NJyxf
         Yrmlljx5OmBwk415G2ZnHGJcs2b2a9WdolkypL0shYGQsd5hHEgz0DMoFnQYPF3yj7sn
         2fwtj2iRyAYdXMLMFMzrVTrLJtN9S5T/x3BA6xMQKwCDeeTBqT/EvhPpXT/gB0GHUunr
         13tQyK+e3ggCaZXkyIKI5pCr7YwCN4l/j3Ta7nA23zyYyO61qdIWtvv/10IehRzZuYhx
         PW3LY8esrVr0DJg4gK/es/eCEIeuzpquax+Z6Oz+1zJZhjus4IbcUVyLiwJPu1rDPURk
         In/g==
X-Gm-Message-State: AAQBX9cq8MRdlREamckdIlXUA+jzuhc4yOB7vwzngbbW04T4BQ8UgHu4
        feSN6nkgXZFAZuWvamEXdpJq3gzRZARxgdnNiz4=
X-Google-Smtp-Source: AKy350Z4rsbspqdtHn6mMZvZl2fWM1a6/dKRst37eiUxDNR1azSetvpPStNXsUrQHrimYlPCPY/ctw==
X-Received: by 2002:ad4:5745:0:b0:5ca:83ed:12be with SMTP id q5-20020ad45745000000b005ca83ed12bemr14218917qvx.21.1679779917048;
        Sat, 25 Mar 2023 14:31:57 -0700 (PDT)
Received: from localhost ([24.1.27.177])
        by smtp.gmail.com with ESMTPSA id r6-20020a0cf806000000b005dd8b93457asm1747932qvn.18.2023.03.25.14.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 14:31:56 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Subject: [PATCH bpf-next 0/3] Don't invoke KPTR_REF destructor on NULL xchg
Date:   Sat, 25 Mar 2023 16:31:41 -0500
Message-Id: <20230325213144.486885-1-void@manifault.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When a map value is being freed, we loop over all of the fields of the
corresponding BPF object and issue the appropriate cleanup calls
corresponding to the field's type. If the field is a referenced kptr, we
atomically xchg the value out of the map, and invoke the kptr's
destructor on whatever was there before.

Currently, we always invoke the destructor (or bpf_obj_drop() for a
local kptr) on any kptr, including if no value was xchg'd out of the
map. This means that any function serving as the kptr's KF_RELEASE
destructor must always treat the argument as possibly NULL, and we
invoke unnecessary (and seemingly unsafe) cleanup logic for the local
kptr path as well.

This is an odd requirement -- KF_RELEASE kfuncs that are invoked by BPF
programs do not have this restriction, and the verifier will fail to
load the program if the register containing the to-be-released type has
any untrusted modifiers (e.g. PTR_UNTRUSTED or PTR_MAYBE_NULL). So as to
simplify the expectations required for a KF_RELEASE kfunc, this patch
set updates the KPTR_REF destructor logic to only be invoked when a
non-NULL value is xchg'd out of the map.

Additionally, the patch removes now-unnecessary KF_RELEASE calls from
several kfuncs, and finally, updates the verifier to have KF_RELEASE
automatically imply KF_TRUSTED_ARGS. This restriction was already
implicitly happening because of the aforementioned logic in the verifier
to reject any regs with untrusted modifiers, and to enforce that
KF_RELEASE args are passed with a 0 offset. This change just updates the
behavior to match that of other trusted args. This patch is left to the
end of the series in case it happens to be controversial, as it arguably
is slightly orthogonal to the purpose of the rest of the series.

David Vernet (3):
  bpf: Only invoke kptr dtor following non-NULL xchg
  bpf: Remove now-unnecessary NULL checks for KF_RELEASE kfuncs
  bpf: Treat KF_RELEASE kfuncs as KF_TRUSTED_ARGS

 Documentation/bpf/kfuncs.rst                           | 7 ++++---
 kernel/bpf/cpumask.c                                   | 5 +----
 kernel/bpf/helpers.c                                   | 6 ------
 kernel/bpf/syscall.c                                   | 2 +-
 kernel/bpf/verifier.c                                  | 2 +-
 net/bpf/test_run.c                                     | 3 ---
 net/netfilter/nf_conntrack_bpf.c                       | 2 --
 tools/testing/selftests/bpf/progs/cgrp_kfunc_failure.c | 4 ++--
 tools/testing/selftests/bpf/progs/task_kfunc_failure.c | 6 +++---
 9 files changed, 12 insertions(+), 25 deletions(-)

-- 
2.39.0

