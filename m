Return-Path: <bpf+bounces-8336-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4945E784E85
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 04:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F0A21C20BF5
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 02:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F04E15B2;
	Wed, 23 Aug 2023 02:07:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E3810E9
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 02:07:09 +0000 (UTC)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267BACF
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 19:07:07 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-570c856e946so1942331eaf.2
        for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 19:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692756426; x=1693361226;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RKlaV8/fN3YsOFIfjsypbpFc3pCqgqSG0MIbaJp9p9c=;
        b=XFQu+UbTpn4Tl43qcPQdCUe97juL7fiZq27U4pSD2Yo1wm9AeL+acNjetvS54lbvZd
         s96KTkrntab8EGGKYrZZu2wMLRv4TzaVEJFGErCRiAE35f2t8BhG1RprE3m8znoFqqJe
         cklPcu8Lz/Y5Yo+KlON1bEF5YtvljcwlCiNYyH4G9puIX7T6rtUfg+LSgkm5aWZQI6wr
         5+wjJ7dsMElog4LASxUM7nnFjs0N+lrsPoGO29YSG/5xanvjycVenP6YgcQiYNuCkfMR
         HqmN/Xu13WPrC8bZXBzGiEqtFERUEVQMwKuXB2L8Sj8R81FY56Q88RchW88Ma+NzfmFk
         gVMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692756426; x=1693361226;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RKlaV8/fN3YsOFIfjsypbpFc3pCqgqSG0MIbaJp9p9c=;
        b=QMy8umvo9KJnxCBRbIl++sd/g228A/GUwXEYNNP6fSgQnJzDbH4OAxvPRfs/iZAxA8
         LwGCtyQ2sFgPSadpkkYDeW7iE96QSTBBffNVRElDDK8jcVgbqagqpim8Vh0LlIeeeUo9
         s3wZU+nUrz3WHC2dXH3Mz2l1K+oIa4eYrIbc4Eys5pWtRAWLfveS6mI7FYDe3TiuNF6F
         KFvF74PxOwPtz11gyC3ZSwy8I8veAdLczFySDhTjGNS8q/1FHnuGBzJMFrOrBIwF4+5j
         h3DgEtzYcrUO/+LDf01lzcKr99K81X4t3NAYU8k7kU7WuC+8mGOq/5Qs2jgL0pJNlPE5
         JmHA==
X-Gm-Message-State: AOJu0Yx/AoO/2C8gplXOjUzCCPItNaHosS1QY7Uuesjs+EgxG6dc82Hv
	Ck8uRLlkSXPtTGXBYhozTtg=
X-Google-Smtp-Source: AGHT+IFrAkrkmHvbAmnOTJUScEBY5ngI+kmRVWtTWruq6FEIY2mYl8DVu7JJCFwpMjqxy8qebTrmEw==
X-Received: by 2002:a05:6358:8826:b0:139:d5d5:7a8f with SMTP id hv38-20020a056358882600b00139d5d57a8fmr8892038rwb.30.1692756426344;
        Tue, 22 Aug 2023 19:07:06 -0700 (PDT)
Received: from vultr.guest ([149.28.193.116])
        by smtp.gmail.com with ESMTPSA id y15-20020aa7804f000000b0064f7c56d8b7sm8313627pfm.219.2023.08.22.19.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 19:07:05 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	eddyz87@gmail.com
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v2 bpf-next 0/2] bpf: Fix an issue in verifing allow_ptr_leaks
Date: Wed, 23 Aug 2023 02:07:01 +0000
Message-Id: <20230823020703.3790-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Patch #1: An issue found in our local 6.1 kernel.
          This issue also exists in bpf-next.
Patch #2: Selftess for #1

v1->v2:
  - Add acked-by from Eduard
  - Fix build error reported by Alexei

Yafang Shao (2):
  bpf: Fix issue in verifying allow_ptr_leaks
  selftests/bpf: Add selftest for allow_ptr_leaks

 kernel/bpf/verifier.c                           | 17 ++++++------
 tools/testing/selftests/bpf/prog_tests/tc_bpf.c | 36 ++++++++++++++++++++++++-
 tools/testing/selftests/bpf/progs/test_tc_bpf.c | 13 +++++++++
 3 files changed, 57 insertions(+), 9 deletions(-)

-- 
1.8.3.1


