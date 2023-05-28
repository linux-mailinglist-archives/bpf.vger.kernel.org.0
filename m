Return-Path: <bpf+bounces-1359-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 517A47139FD
	for <lists+bpf@lfdr.de>; Sun, 28 May 2023 16:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09076280E65
	for <lists+bpf@lfdr.de>; Sun, 28 May 2023 14:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45033D70;
	Sun, 28 May 2023 14:20:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE4F211A
	for <bpf@vger.kernel.org>; Sun, 28 May 2023 14:20:37 +0000 (UTC)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B43B8
	for <bpf@vger.kernel.org>; Sun, 28 May 2023 07:20:35 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-62621035d15so1476076d6.2
        for <bpf@vger.kernel.org>; Sun, 28 May 2023 07:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685283635; x=1687875635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QYH6SaKI31o/TThgabNBnvtMc6+xP1AGFlQTqwj5pzU=;
        b=CKrPhKgVxnOvtXh5gW3BBkYynaMR2fEgPHk99yb0a1aTGgfqUApwavrz69zHvY5jbq
         cVBRU2F1GwPrCEu1qw5ula17lW6kBhUa6ykrIaA1CsuMZs/gLKlkX9BnRU4vhKmgaW+O
         Rn7JLAp6o56Qt2AP8i3RxdKNyIIAkBuJXbHsThpkWhdNzfpwEhdnlRCuwnQhunD2Mzdg
         tNiGb/WtOYwH+NlSHrlmwgiI1Iv/K8SyJXzk/eOp9TqRehglROeJmfIDEYMyD8bUNcAi
         o67y1ETAnnxC8KRomVCS0MC49drFCWLpsrJjfR0fXsMNaFA6aNnUMFISyGg/vptfbp1U
         fo9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685283635; x=1687875635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QYH6SaKI31o/TThgabNBnvtMc6+xP1AGFlQTqwj5pzU=;
        b=UB9B5ETHIZtQ+L7FinMGdsnVTf2Blm85FpyA0FOEVN5jgMIT8C+wgQQXFeJOQA2jiW
         Bu5ReEGPfQrpYWyUGH/Kw+GAce9YxiTHAF1CYmEhzQcjJRSCfkSvl+HlkHu0oc2Qwcbr
         kq3kKHawX3O6p/FoORmsr4jPNZcfzcZRYDWE52G9hnNFWb/2R3kKNnZI3v7CfOOOcKDf
         aFQ9rXILWiGTkgD9FZZCQ6wRmQjSThMukR+pxjGUc/6SqBwb6FanMJb4zkOxvwH+grNh
         hcvNDpkzkxUlxEGLgwhXvsgM7Qe4af3bGjq6RdNLzBMWeCDmgaX5UqTchgsIyiMYQBdf
         iPbg==
X-Gm-Message-State: AC+VfDwDnaGU/g3f0M4I+q7Zx4sg47ZNzevEDQESGvwCuZ85LvmQjY53
	lMCOm7W8v3HQPe1ydDgupdM=
X-Google-Smtp-Source: ACHHUZ76EWy08VhQsfkJQzxh/u4fL/Og8Cfd65Yd1TURfl6X4ET1ydrVvHFN/wPIgjFyTO3q0xbP+w==
X-Received: by 2002:a05:6214:29ea:b0:625:aa49:c342 with SMTP id jv10-20020a05621429ea00b00625aa49c342mr8024357qvb.54.1685283634708;
        Sun, 28 May 2023 07:20:34 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:5:38f3:5400:4ff:fe74:5668])
        by smtp.gmail.com with ESMTPSA id l11-20020a0cc20b000000b006238dc71f5csm10qvh.144.2023.05.28.07.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 07:20:34 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	quentin@isovalent.com
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 0/8] bpf: Support ->show_fdinfo and ->fill_link_info for kprobe prog
Date: Sun, 28 May 2023 14:20:19 +0000
Message-Id: <20230528142027.5585-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Currently, it is not easy to determine which functions are probed by a
kprobe_multi program. This patchset supports ->show_fdinfo and
->fill_link_info for it, allowing the user to easily obtain the probed
functions.

Although the user can retrieve the functions probed by a perf_event
program using `bpftool perf show`, it would be beneficial to also support
->show_fdinfo and ->fill_link_info. This way, the user can obtain it in the
same manner as other bpf links.

It would be preferable to expose the address directly rather than the symbol
name, as multiple functions may share the same name.

Yafang Shao (8):
  bpf: Support ->show_fdinfo for kprobe_multi
  bpf: Support ->fill_link_info for kprobe_multi
  bpftool: Show probed function in kprobe_multi link info
  bpf: Always expose the probed address
  bpf: Support ->show_fdinfo for perf_event
  bpf: Add a common helper bpf_copy_to_user()
  bpf: Support ->fill_link_info for perf_event
  bpftool: Show probed function in perf_event link info

 include/uapi/linux/bpf.h       |  10 ++++
 kernel/bpf/syscall.c           | 107 +++++++++++++++++++++++++++++++++++------
 kernel/trace/bpf_trace.c       |  48 ++++++++++++++++++
 kernel/trace/trace_kprobe.c    |   2 +-
 tools/bpf/bpftool/link.c       |  71 ++++++++++++++++++++++++++-
 tools/include/uapi/linux/bpf.h |  10 ++++
 6 files changed, 232 insertions(+), 16 deletions(-)

-- 
1.8.3.1


