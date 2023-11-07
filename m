Return-Path: <bpf+bounces-14400-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 454777E3FF6
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 14:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74B571C209F3
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 13:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8FB2FE3E;
	Tue,  7 Nov 2023 13:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="W8Cgqbmm"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A792DF91
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 13:22:19 +0000 (UTC)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0955493
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 05:22:18 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6b497c8575aso5935289b3a.1
        for <bpf@vger.kernel.org>; Tue, 07 Nov 2023 05:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1699363337; x=1699968137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vVwJtVHR2RG8GCxjA22zzP6jF1NHDuk3HPY2SQXIbhQ=;
        b=W8CgqbmmhB2wo0pcfGaKMEdl5FodsH/IsoUCnIVB3YHVCyOG6crqTemgLq0yLP81kc
         NSdBMIxbMzOyY+F0Flkrvzk3/ye7U8baj0SWSY6KzYnoamJdceRiHoBxi1fM9TidfB9d
         s6kwBIhIDiQUg7ux/l9PxDDOwkGBkywHuwEBBMvCztNrTMk/999HkGQNSrODbG/4fZPu
         RV2T9bbNK+S6Z8aKMHw0jUVarMjcBr4FmlhnZwlm/UkJTkGx2whlp5Obv/nFgkmG73XY
         U73r2+LLDlzxGlGFNEocGAl/iEKyp0dAMWqCW0k2zGn1P1HqXNxmZ2U5doI5SDAQI5UG
         EOYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699363337; x=1699968137;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vVwJtVHR2RG8GCxjA22zzP6jF1NHDuk3HPY2SQXIbhQ=;
        b=IMGeZpmc+XhgFjguOWFpWRtkirIGNxa76Z/ny2EQNKJYgBIbPDXmnSzUOXhHTk5rIa
         awPvdDI3LcN2Q6xJwhXfypm9NtS2CsC3MviHXOiuvEs8PPdKiCB+jAcVp4k2Lm6DAY33
         +e1HVi21CXj10BEQzlL98L4Jr2nTBbRLUxz0I4JGyBRpedJRjhS3auII8+eAxkdOP4X/
         C6lQJR4i1/xkTZtcn3jMu7xIfFt+7E0ncZhieIeV0bQVISZLbHuYXnr7aXmvl8HVdLHu
         ATNYQAyj/IxpPpkeUHCAxf3zOgK+EJgkpzbtac6Bi2jcOEkUEkU/eDQP+DR0eYWq468j
         Guuw==
X-Gm-Message-State: AOJu0YymoZ4Gvk3dE9nrig04PajeL4M/JD/rFuLcSR5XlIQvglVAPB5Q
	54C9wM9gSzQD/nj1mNFjGVfN4AnJbpVudbhcubM=
X-Google-Smtp-Source: AGHT+IFAOy/jnc2TbrEwFUbg4b7wh2txd/KwVSPXoP8seCQpjicTmsxbf1fbuvFwkmGKn7AzzBzBsQ==
X-Received: by 2002:a05:6a20:144f:b0:13c:ca8b:7e29 with SMTP id a15-20020a056a20144f00b0013cca8b7e29mr39382566pzi.12.1699363337028;
        Tue, 07 Nov 2023 05:22:17 -0800 (PST)
Received: from n37-019-243.byted.org ([180.184.51.70])
        by smtp.gmail.com with ESMTPSA id y36-20020a056a00182400b0068790c41ca2sm7218881pfa.27.2023.11.07.05.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 05:22:16 -0800 (PST)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [PATCH bpf v2 0/2] Let BPF verifier consider {task,cgroup} is trusted in bpf_iter_reg
Date: Tue,  7 Nov 2023 21:22:02 +0800
Message-Id: <20231107132204.912120-1-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,
The patchset aims to let the BPF verivier consider
bpf_iter__cgroup->cgroup and bpf_iter__task->task is trused suggested by
Alexei[1].

Please see individual patches for more details. And comments are always
welcome.

Link[1]:https://lore.kernel.org/bpf/20231022154527.229117-1-zhouchuyi@bytedance.com/T/#mb57725edc8ccdd50a1b165765c7619b4d65ed1b0

v2->v1:
 * Patch #1: Add Yonghong's ack and add description of similar case in
   log.
 * Patch #2: Add Yonghong's ack

Chuyi Zhou (2):
  bpf: Let verifier consider {task,cgroup} is trusted in bpf_iter_reg
  selftests/bpf: get trusted cgrp from bpf_iter__cgroup directly

 kernel/bpf/cgroup_iter.c                         |  2 +-
 kernel/bpf/task_iter.c                           |  2 +-
 .../testing/selftests/bpf/progs/iters_css_task.c | 16 ++++------------
 3 files changed, 6 insertions(+), 14 deletions(-)

-- 
2.20.1


