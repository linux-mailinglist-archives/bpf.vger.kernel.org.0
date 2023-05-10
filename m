Return-Path: <bpf+bounces-314-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7036FE73D
	for <lists+bpf@lfdr.de>; Thu, 11 May 2023 00:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56B571C20E44
	for <lists+bpf@lfdr.de>; Wed, 10 May 2023 22:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B523B12B74;
	Wed, 10 May 2023 22:33:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BEC2F23
	for <bpf@vger.kernel.org>; Wed, 10 May 2023 22:33:53 +0000 (UTC)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDCD2121
	for <bpf@vger.kernel.org>; Wed, 10 May 2023 15:33:51 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1aad6f2be8eso73322415ad.3
        for <bpf@vger.kernel.org>; Wed, 10 May 2023 15:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683758030; x=1686350030;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=97jPZ4YKHVIcaiTtug3fAq3EWsNoSIZpDo/mjt4+xLc=;
        b=rA2QL7WjAVBGT2J3+WPQmyZwJtq8P62OCPYAnLWc+Oaz/dEZzkO4vWV5F3/Dbf1W9q
         I0uBOyko7ljrYjq9GzWStYCLZFT9GAKcEzEgthfzZ6ExjBwWDHvCbugwvK5cUrC8YTRX
         nrtVm8LGqGFXrcc853XGVaBqxyGO0WYHBeYsG+uvQQ6knkgWXqz/fE2qlFlXFfc5obcE
         H20xwJNbuvQWx0HN36/EmQwDec5AECNthiZ6G7ulvvS8XCKWYZCzM02r7p/Ha9Q5HTII
         STNolnydUlURlPLz2u630wiT6oOOYqsFoGVY84fRdQ7R/0BRjPhW3aLcFMz3PsMefTY1
         TVbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683758030; x=1686350030;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=97jPZ4YKHVIcaiTtug3fAq3EWsNoSIZpDo/mjt4+xLc=;
        b=A9fMznilNYodr+A6Fo0KpINZ3pTS05pn3QaPk7p9J2ykf0uzT3SoU6+XpjFSJuy7WR
         GD99UtD5ssTEa5Af+9kb+Pn0bt1aepGcb5nVpBOuUBSgRh0R/fbgK+D5OynvXHJsmrf6
         t0+8ao2XcBxYDSf1LNCB6AKOUiwLqzL62ZVn5GAER1teUfiPG2FkpbjtPL6bBc//bDbc
         4v37L8EAA7bHMa6XE41flGbsmW+0l6kaL6m88Lpjy59SAugEgY5+EaBE8dca/gDWAxxx
         AbktB0gdB7i3COd0cnPmDV+li7fAHIm0A1mHWasc5K7wNEcWvY22HLz/WQ8VzTMAiGjK
         VV7Q==
X-Gm-Message-State: AC+VfDxWdfWrJ4Xi6LibRWiMPic8KOWQTryPOvoQS1BO7EU0/QB8pFmV
	Bmki0pdYaFchvCRD7HDRrrg0csVMMSQ=
X-Google-Smtp-Source: ACHHUZ6VKugn2KAEFp0OYhxNkK0rTy0vJkgpJ5oQQZpkcwYDBUg7jmmqHnvMkAYa6bPo1cYBlxrPKQ==
X-Received: by 2002:a17:902:db02:b0:1ac:815e:320b with SMTP id m2-20020a170902db0200b001ac815e320bmr13650498plx.17.1683758030532;
        Wed, 10 May 2023 15:33:50 -0700 (PDT)
Received: from toolbox.. ([98.42.16.172])
        by smtp.gmail.com with ESMTPSA id g10-20020a170902934a00b001ab12ccc2a7sm4308891plp.98.2023.05.10.15.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 15:33:49 -0700 (PDT)
From: JP Kobryn <inwardvessel@gmail.com>
To: bpf@vger.kernel.org,
	andrii@kernel.org
Cc: kernel-team@meta.com,
	inwardvessel@gmail.com
Subject: [PATCH v2 bpf-next 0/2] libbpf: capability for resizing datasec maps
Date: Wed, 10 May 2023 15:33:40 -0700
Message-Id: <20230510223342.12886-1-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.40.0
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

Due to the way the datasec maps like bss, data, rodata are memory
mapped, they cannot be resized with bpf_map__set_value_size() like
non-datasec maps can. This series offers a way to allow the resizing of
datasec maps, by having the mapped regions resized as needed and also
adjusting associated BTF info if possible.

The thought behind this is to allow for use cases where a given datasec
needs to scale to for example the number of CPU's present. A bpf program
can have a global array in a data section with an initial length and
before loading the bpf program, the array length could be extended to
match the CPU count. The selftests included in this series perform this
scaling to an arbitrary value to demonstrate how it can work.

JP Kobryn (2):
  add capability for resizing datasec maps
  selftests for resizing datasec maps

 tools/lib/bpf/libbpf.c                        | 158 +++++++++++-
 .../bpf/prog_tests/global_map_resize.c        | 236 ++++++++++++++++++
 .../bpf/progs/test_global_map_resize.c        |  58 +++++
 3 files changed, 451 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/global_map_resize.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_map_resize.c

-- 
2.40.0


