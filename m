Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD423633F84
	for <lists+bpf@lfdr.de>; Tue, 22 Nov 2022 15:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbiKVOyh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Nov 2022 09:54:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233833AbiKVOxd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Nov 2022 09:53:33 -0500
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7B917A91;
        Tue, 22 Nov 2022 06:53:05 -0800 (PST)
Received: by mail-qt1-f172.google.com with SMTP id w4so9432877qts.0;
        Tue, 22 Nov 2022 06:53:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A3hb6DfOCI3nB34nDd97tw95U/oUgwjCRt/XOk9zLe8=;
        b=XNNEg8qlB1GRGQiqDd0kbnBg3zREWCd5+0HE0iyxoU58mseHmO6m4K+M8WjUbOGK12
         D1RYL9GXXum7UT1Py5+EyybehfNaHfhcXOxyWme3N/y7uJY1sq16lGF3PyIFV9M4Iofm
         RvhQrHuZdw7W5Yhk5YMjL0kO74eJ8Wcg3Jlkt+aOuHpj37A4EReXaCjQ69rJm65bYVJL
         UPaNIU9ewGowO3x4u1V+9be4oKOIFNyrOm407O+HYz6OXmmVDSdzYVWrQl0qc4P48/9x
         7ZXRmXuwVdaBH0ha7yiZVRwvH/DEmYdydtAow8g5/bOj0aWH461KWTfXPuyv89cQg79Y
         Vpmg==
X-Gm-Message-State: ANoB5pl7obaps0xIcmoIJM4ovLgltCnoh7auuTFaniKEhq4K8x2EZrs6
        0gdskd3+zMYXk3iCidYuAQaftippPqSCNjsw
X-Google-Smtp-Source: AA0mqf7xNsaxqBNCXeiEH35nArDEooT5ZksZ4pLGb8SCwUaD9n598NJV3W0VhVQzBwKpajn3ZwBWBg==
X-Received: by 2002:a05:622a:514a:b0:3a5:2029:df77 with SMTP id ew10-20020a05622a514a00b003a52029df77mr5219566qtb.225.1669128784125;
        Tue, 22 Nov 2022 06:53:04 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:3170])
        by smtp.gmail.com with ESMTPSA id bl3-20020a05620a1a8300b006fae7e6204bsm10482804qkb.108.2022.11.22.06.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 06:53:03 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, yhs@fb.com, song@kernel.org, sdf@google.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, jolsa@kernel.org,
        haoluo@google.com, tj@kernel.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 0/2] Add kfunc for doing pid -> task lookup
Date:   Tue, 22 Nov 2022 08:52:58 -0600
Message-Id: <20221122145300.251210-1-void@manifault.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A series of prior patches added support for storing struct task_struct *
objects as kptrs. This patch set proposes extending this with another
kfunc called bpf_task_from_pid() which performs a lookup of a task from
its pid, from the root pid namespace idr.

This allows BPF programs that don't have a kptr to a task, to instead
perform a lookup by pid. This will be useful for programs that are
tracking pids and want, e.g., to do a lookup to find task->comm.

David Vernet (2):
  bpf: Add bpf_task_from_pid() kfunc
  selftests/bpf: Add selftests for bpf_task_from_pid()

 kernel/bpf/helpers.c                          | 20 +++++
 .../selftests/bpf/prog_tests/task_kfunc.c     |  3 +
 .../selftests/bpf/progs/task_kfunc_common.h   |  1 +
 .../selftests/bpf/progs/task_kfunc_success.c  | 73 +++++++++++++++++++
 4 files changed, 97 insertions(+)

-- 
2.38.1

