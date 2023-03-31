Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97FC06D28E5
	for <lists+bpf@lfdr.de>; Fri, 31 Mar 2023 21:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbjCaT5k (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 31 Mar 2023 15:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjCaT5j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 31 Mar 2023 15:57:39 -0400
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A23B1D2F4;
        Fri, 31 Mar 2023 12:57:38 -0700 (PDT)
Received: by mail-qv1-f51.google.com with SMTP id on15so3931550qvb.7;
        Fri, 31 Mar 2023 12:57:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680292657; x=1682884657;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U4RbD3jnLZPMl8W2CLKdWG4LWWRrWKpTSgrfaHYDsDU=;
        b=eKTa/6Jm0vEY3jenjsZ/MFA/pPZ3yp9D6nBoqxbN+U+aVxlPmoeTxEfHrpbptImkSy
         /G+ZgM6+eFrsli1kWBQ8RlOifm2Br5uP4JWEctbidzr6BORf5o2knNeoi8OBJRDj12Rv
         z93L21Sjp5keeSSn8LarYj1XWnfJ4VG8LLV8iLb73yW2NsgZM/nPYOzqcXOiSm1pf0xZ
         XncdFaLlAxMRY3edS6+1O+T7Cy6ogvv2FSvqmot/3zE2vo5RwpE2REarxME6zJtTCCOR
         vFW/UvXX1MBLzOWJUBKNZX768ApXSRVe5DXKozrFWdB2pdKqtEhqdumntTBRmZr+iost
         v+lA==
X-Gm-Message-State: AAQBX9d3rXmlb5oHxhJNEG3k5pjkKOuUTvKA/qwYZ3GR2j17ow3eZY90
        2NFpqI7WsDY+Gqm95hn3AzmExsWCN2/6yaYt
X-Google-Smtp-Source: AKy350YJNbMFvuajdG2a9OeZ0RtD4R4ezU+20qNxQ0f82PrAavFmd+iiiJhtjOhuWLkPpcB/qSa87A==
X-Received: by 2002:a05:6214:224a:b0:571:698:eac9 with SMTP id c10-20020a056214224a00b005710698eac9mr21183471qvc.18.1680292656956;
        Fri, 31 Mar 2023 12:57:36 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:2101])
        by smtp.gmail.com with ESMTPSA id 18-20020a370a12000000b007488171e090sm909302qkk.15.2023.03.31.12.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 12:57:36 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Subject: [PATCH bpf-next v2 0/3] Enable RCU semantics for task kptrs
Date:   Fri, 31 Mar 2023 14:57:30 -0500
Message-Id: <20230331195733.699708-1-void@manifault.com>
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

In commit 22df776a9a86 ("tasks: Extract rcu_users out of union"), the
'refcount_t rcu_users' field was extracted out of a union with the
'struct rcu_head rcu' field. This allows us to use the field for
refcounting struct task_struct with RCU protection, as the RCU callback
no longer flips rcu_users to be nonzero after the callback is scheduled.

This patch set leverages this to do a few things:

1. Marks struct task_struct as RCU safe in the verifier, allowing
   referenced kptr tasks stored in maps to be accessed in an RCU
   read region without acquiring a reference (with just a NULL check).
2. Makes bpf_task_acquire() a KF_ACQUIRE | KF_RCU | KF_RET_NULL kfunc.
3. Removes bpf_task_kptr_get() and bpf_task_acquire_not_zero(), as
   they're now redundant with the above two changes.
4. Updates selftests and documentation accordingly.

---
Changelog:
v1: https://lore.kernel.org/all/20230331005733.406202-1-void@manifault.com/
v1 -> v2:
- Remove testcases validating nested trust inheritance. The first
  version used 'struct task_struct __rcu *parent', but because that
  field has the __rcu tag it functions differently on gcc and llvm and
  causes gcc selftests to fail. Alexei is reworking nested trust,
  anyways so let's leave it off for now (Alexei).

David Vernet (3):
  bpf: Make struct task_struct an RCU-safe type
  bpf: Remove now-defunct task kfuncs
  bpf,docs: Update documentation to reflect new task kfuncs

 Documentation/bpf/kfuncs.rst                  |  49 ++++++-
 kernel/bpf/helpers.c                          |  78 +---------
 kernel/bpf/verifier.c                         |   1 +
 .../selftests/bpf/prog_tests/task_kfunc.c     |   3 +-
 .../selftests/bpf/progs/rcu_read_lock.c       |   9 +-
 .../selftests/bpf/progs/task_kfunc_common.h   |   6 +-
 .../selftests/bpf/progs/task_kfunc_failure.c  | 135 ++++++++----------
 .../selftests/bpf/progs/task_kfunc_success.c  |  48 +++++--
 8 files changed, 155 insertions(+), 174 deletions(-)

-- 
2.39.0

