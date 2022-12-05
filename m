Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4134D643794
	for <lists+bpf@lfdr.de>; Mon,  5 Dec 2022 23:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbiLEWBz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Dec 2022 17:01:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbiLEWBy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Dec 2022 17:01:54 -0500
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718F5388;
        Mon,  5 Dec 2022 14:01:53 -0800 (PST)
Received: by mail-qt1-f175.google.com with SMTP id a27so12461095qtw.10;
        Mon, 05 Dec 2022 14:01:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dDrOUXbcNmNb9f6MrPCaj3zYBAMT6gVyifiYeiwpKMI=;
        b=eiQbaoGKOIqkcbSazvguNmFkxMMUKpvgcDnvsThgktCOJH6e2Z7FNeEdfK4KiU6/gN
         BRq6d4a/ETg1wI/CIWdyh2v0vLydOOjCCE2H0cHb4IdDkO9Uev8/4507O7dUL5S88zcg
         mdIhYlEzM5yw5FBgcs67ipJmYjSZQ5In15DGql4jEgypccAIHZmkuKzXgB/Ls6GXADdv
         JB5kvtDj8aShpCdg+NbvAIE5IKtr8BaePllVHZtR1wKmRFRGZcQRQjX2iY1UIx7rofvQ
         0u+zaOTnBAKo1Rmhdq3i/xuBFKmMYIC4eTl0on4rS1rMWLmIkaxXIwVKyHYFEMAQaqk7
         wDTA==
X-Gm-Message-State: ANoB5pkuP+hScz3YE0tT5SaMMVupjoQdo8SZItIRrYWDP1gEMUb8Yp5g
        G3ESGLOlJFJ2iX2cdXqHktkrztwu1MO/I/wN
X-Google-Smtp-Source: AA0mqf6D2XrIYMRZspkan7PQpFIyUCnalwCyOprdIJdJ8E/LIIdhw6Yt4TMSlQqUIkcSeZPMnASOng==
X-Received: by 2002:a05:622a:4a06:b0:3a5:410c:bb77 with SMTP id fv6-20020a05622a4a0600b003a5410cbb77mr77960530qtb.266.1670277712131;
        Mon, 05 Dec 2022 14:01:52 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:cc23])
        by smtp.gmail.com with ESMTPSA id ck15-20020a05622a230f00b0039953dcc480sm10674786qtb.88.2022.12.05.14.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 14:01:51 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Subject: [PATCH bpf-next v2 0/2] Document some recent core kfunc additions
Date:   Mon,  5 Dec 2022 16:01:42 -0600
Message-Id: <20221205220144.63885-1-void@manifault.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A series of recent patch sets introduced kfuncs that allowed struct
task_struct and struct cgroup objects to be used as kptrs. These were
introduced in [0], [1], and [2].

[0]: https://lore.kernel.org/lkml/20221120051004.3605026-1-void@manifault.com/
[1]: https://lore.kernel.org/lkml/20221122145300.251210-2-void@manifault.com/T/
[2]: https://lore.kernel.org/lkml/20221122055458.173143-1-void@manifault.com/

These are "core" kfuncs, in that they may be used by a wide variety of
possible BPF tracepoint or struct_ops programs, and are defined in
kernel/bpf/helpers.c. Even though as kfuncs they have no ABI stability
guarantees, they should still be properly documented. This patch set
adds that documentation.

Some other kfuncs were added recently as well, such as
bpf_rcu_read_lock() and bpf_rcu_read_unlock(). Those could and should be
added to this "Core kfuncs" section as well in other patch sets.

--
Changelog:
v1 -> v2:
- Expand comment to specify that a map holds a reference to a task kptr
  if we don't end up releasing it (Alexei)
- Just read task->pid instead of using a probed read (Alexei)

David Vernet (2):
  bpf/docs: Document struct task_struct * kfuncs
  bpf/docs: Document struct cgroup * kfuncs

 Documentation/bpf/kfuncs.rst | 197 +++++++++++++++++++++++++++++++++++
 kernel/bpf/helpers.c         |  10 +-
 2 files changed, 202 insertions(+), 5 deletions(-)

-- 
2.38.1

