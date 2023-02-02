Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53CEA68846D
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 17:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjBBQbJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Feb 2023 11:31:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjBBQbJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 11:31:09 -0500
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43B261D7F;
        Thu,  2 Feb 2023 08:31:04 -0800 (PST)
Received: by mail-qt1-f179.google.com with SMTP id w3so2439681qts.7;
        Thu, 02 Feb 2023 08:31:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m+MUUS/4z4ueE6F3pvqkDWo76t810rF7C4WYLJ9AavQ=;
        b=eJFrJFL5yaSevbbd5mxK92ceN84dvXtb6nBPuI2LwoqHLsnMPh0j/guIHeQ1bFo/YB
         FMa46jTIyZqXjtDqr2vdj8xTLB9HrVQO9cE7N3XAxPQx1zNR0vL2Vf3761yIFAsOT3vM
         EEg2Vvh9/UfZ1IqYVnimJ8oUEzYRK5+Wz31ELtBHQzfHtEQtVuJToJQ5X9FzgLTsflmN
         8kdU5qRcfjJYwOOX+jLeXn+Zuqc4L1+VrEPD/4QiCIhQ1rnz8o7X+jo+a4rXa8FMtA72
         0P5LK2fQjhC7HXU0SarlGv1h29farwwrlrPGphz7NPc09d6rUPU2AZ4ltQMHHkMzv+ZC
         hznw==
X-Gm-Message-State: AO0yUKXCg9Mgiz0kw0mg0Rmfjd3v2G4YNfaOh2IoV2CFw24Hmi4pgeaV
        Z40q3fw1ej9uhEZ0/MHRQsxVzrO7OkzdsyUN
X-Google-Smtp-Source: AK7set8pPfzhuGzONBg5A/x7sj1wMDH8Ug5RSliF4jnj0uliOG1ubg0t2xBRgbkWYsy2IRfjN4GzHA==
X-Received: by 2002:ac8:7d88:0:b0:3b9:a3e3:4d33 with SMTP id c8-20020ac87d88000000b003b9a3e34d33mr13289367qtd.12.1675355463426;
        Thu, 02 Feb 2023 08:31:03 -0800 (PST)
Received: from localhost ([24.1.27.177])
        by smtp.gmail.com with ESMTPSA id b25-20020ac844d9000000b003b82cb8748dsm11539311qto.96.2023.02.02.08.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 08:31:02 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, toke@redhat.com, brouer@redhat.com,
        corbet@lwn.net, linux-doc@vger.kernel.org
Subject: [PATCH bpf-next 0/3] Document kfunc lifecycle / stability expectations
Date:   Thu,  2 Feb 2023 10:30:53 -0600
Message-Id: <20230202163056.658641-1-void@manifault.com>
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

BPF kernel <-> kernel API stability has been discussed at length over
the last several weeks and months. Now that we've largely aligned over
kfuncs being the way forward, and BPF helpers being considered frozen,
it's time to document the expectations for kfunc lifecycles and
stability so that everyone (BPF users, kfunc developers, and
maintainers) are all aligned, and have a crystal-clear understanding of
the expectations surrounding kfuncs.

This patch set adds that documentation to the main kfuncs documentation
page via a new 'kfunc lifecycle expectations' section. The documentation
describes how decisions are made in the kernel regarding whether to
include, keep, deprecate, or change / remove a kfunc. As described very
overtly in the patch set itself, but likely worth highlighting here:

"kfunc stability" does not mean, nor ever will mean, "BPF APIs may block
development elsewhere in the kernel".

Rather, the intention and expectation is for kfuncs to be treated like
EXPORT_SYMBOL_GPL symbols in the kernel. The goal is for kfuncs to be a
safe and valuable option for maintainers and kfunc developers to extend
the kernel, without tying anyone's hands, or imposing any kind of
restrictions on maintainers in the same way that UAPI changes do.

Note that other proposals for this documentation have been made as well.
Toke has proposed several iterations to this doc, with the latest being
[0].

[0]: https://lore.kernel.org/all/20230201174449.94650-1-toke@redhat.com/

David Vernet (3):
  bpf/docs: Document kfunc lifecycle / stability expectations
  bpf: Add KF_DEPRECATED kfunc flag
  selftests/bpf: Add a selftest for the KF_DEPRECATED kfunc flag

 Documentation/bpf/kfuncs.rst                  | 125 +++++++++++++++++-
 include/linux/btf.h                           |   1 +
 kernel/bpf/verifier.c                         |   8 ++
 net/bpf/test_run.c                            |   5 +
 .../selftests/bpf/prog_tests/kfunc_call.c     |   2 +
 .../selftests/bpf/progs/kfunc_call_test.c     |  10 ++
 6 files changed, 146 insertions(+), 5 deletions(-)

-- 
2.39.0

