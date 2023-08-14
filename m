Return-Path: <bpf+bounces-7766-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE24977C02C
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 20:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E04111C20B1F
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 18:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86719CA61;
	Mon, 14 Aug 2023 18:59:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621DDC12F;
	Mon, 14 Aug 2023 18:59:22 +0000 (UTC)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2246C10F7;
	Mon, 14 Aug 2023 11:59:21 -0700 (PDT)
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-76d535567afso87556985a.1;
        Mon, 14 Aug 2023 11:59:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692039560; x=1692644360;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jTub9WclxOHEsi9/NJWWi275qZt7CmU6ZzBgj/2xmWs=;
        b=EIYz++F+PsgqsNXmqtZ58mLLilZd/b+BIU4ABGyxpXzHGTsd/Z20cSXSiag6XMy9ti
         SBryGbiVfAdrFn/pvQVXcaTazJtPZWsLU2yA96Kc8kajQCKcZRv1519ROm0pF5x/ORwd
         2vEG7DVwTj7lbfP1QYzQGhVxEY9LjlWDCa3C+pGVJgfmW52OSTfwdC6T5mqvi9ARcitn
         rh24vH43z5wdEvLIuolRUICDpInXiFBcskcenhBbxRpNo5acmRu5iTpcs4LFlJSLchKJ
         fYw8scV2cI3SP5xdcsdAEw8tglbwunNfLG8Z9wCTR4dD5HJs+RG4xZShdhbVcYMM4zcN
         7EKg==
X-Gm-Message-State: AOJu0YwdTKQazgHUYBfjjzOYAAzQedKnjkMgDOacq2WJa4BVj8iGdAEs
	ypClTqPq+GfgSIo0QvztceuNFf4wq3CF3gwx
X-Google-Smtp-Source: AGHT+IEpHbjrvnEmGVSYnnSNUKns5dxPjG36Pr1OSN4IwCjitx6awkcKChE6PNq7E0ONFBZEROdFxQ==
X-Received: by 2002:a05:6214:5d12:b0:636:14d4:4461 with SMTP id me18-20020a0562145d1200b0063614d44461mr11090391qvb.62.1692039559869;
        Mon, 14 Aug 2023 11:59:19 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:93a1])
        by smtp.gmail.com with ESMTPSA id w3-20020a05620a148300b0076c9cc1e107sm3199516qkj.54.2023.08.14.11.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 11:59:19 -0700 (PDT)
From: David Vernet <void@manifault.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	tj@kernel.org,
	clm@meta.com,
	thinker.li@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v3 0/2] Update and document struct_ops
Date: Mon, 14 Aug 2023 13:59:06 -0500
Message-ID: <20230814185908.700553-1-void@manifault.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The struct bpf_struct_ops structure in BPF is a framework that allows
subsystems to extend themselves using BPF. In commit 68b04864ca425
("bpf: Create links for BPF struct_ops maps") and commit aef56f2e918bf
("bpf: Update the struct_ops of a bpf_link"), the structure was updated
to include new ->validate() and ->update() callbacks respectively in
support of allowing struct_ops maps to be created with BPF_F_LINK.

The intention was that struct bpf_struct_ops implementations could
support map updates through the link. Because map validation and
registration would take place in two separate steps for struct_ops
maps managed by the link (the first in map update elem, and the latter
in link create), the ->validate() callback was added, and any struct_ops
implementation that wished to use BPF_F_LINK, even just for lifetime
management, would then be required to define both it and ->update().

Not all struct_ops implementations can or will support update, however.
For example, the sched_ext struct_ops implementation proposed in [0]
will not be able to support atomic map updates because it can race with
sysrq, has to cycle tasks through various states in order to safely
transition, etc. It can, however, benefit from letting the BPF link
automatically evict the struc_ops map when the application exits (e.g.
if it crashes).

This patch set therefore:

1. Updates the struct_ops implementation to support default values for
   ->validate() and ->update() so that struct_ops implementations can
   benefit from BPF_F_LINK management even if they can't support
   updates.
2. Documents struct bpf_struct_ops so that the semantics are clear and
   well defined.

---
v2: https://lore.kernel.org/bpf/0f5ea3de-c6e7-490f-b5ec-b5c7cd288687@gmail.com/T/
Changes from v2 -> v3:
- Add patch 2/2 that documents the struct bpf_struct_ops structure.
- Add Kui-Feng's Acked-by tag to patch 1/2.

v1: https://lore.kernel.org/lkml/20230811150934.GA542801@maniforge/
Changes from v1 -> v2:
- Move the if (!st_map->st_ops->update) check outside of the critical
  section before we acquire the update_mutex.

David Vernet (2):
  bpf: Support default .validate() and .update() behavior for struct_ops
    links
  bpf: Document struct bpf_struct_ops fields

 include/linux/bpf.h         | 43 +++++++++++++++++++++++++++++++++++++
 kernel/bpf/bpf_struct_ops.c | 15 +++++++------
 2 files changed, 52 insertions(+), 6 deletions(-)

-- 
2.41.0


