Return-Path: <bpf+bounces-7723-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC8277BBBC
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 16:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E139228119C
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 14:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C92BE6C;
	Mon, 14 Aug 2023 14:33:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A553BA34
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 14:33:56 +0000 (UTC)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270BEE4
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 07:33:55 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-26b399c6a4aso776383a91.3
        for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 07:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692023634; x=1692628434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lx+2P2cc8H9kYT2GcxeO2S3NN8rDm2ipSNtvGuSjt50=;
        b=ZQD5i3RA1i4p0UZYiI+T1KXhPZa1AJoLRkwwwofdNsZ9XR+VdViFkZ9PJQCmBnvgLG
         lKFBA/IUmVu0shvGFMALFz4EdC3U0MKVYBh8MEMmKfcqN0HTqzFdDTNcaSWjCfcSnblm
         m5nVQuBejJFyn8eiA4vyKwNh/Z4id9Yx4pfQAI0FlSe2rUuYFwmpX9P+4sp6LJY8raTm
         aSv/pxVJgeBJuU/6qM8/g8e9e/oZVw983UZrO2OqNwwgqmHP18s3wJI1Xbk0FvlbBmUK
         oVBGKDmQousyQpNkjm/xX5OQXq+ufrmYX+lviqCp/g2dwBhf/FojU12vjUutTxV40qPV
         bwog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692023634; x=1692628434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lx+2P2cc8H9kYT2GcxeO2S3NN8rDm2ipSNtvGuSjt50=;
        b=hAZ1qdAXV1fYUrCnJsOMZjwacyBucVtnyW/83gYbMfHRL7yshHU4KS50lhg2ulH+Y4
         0pLAcLNGVfyEIvfQrjYGStYPGsFx81ioZMtpvQg5L7MicBgyTBxJZg2376TQyaLv+pmt
         g99D3Rt1dAFHawanzhOmo1+QFTpEc+WXuGg5SeSUB9sCSNoGJDyp8d5zlbyjO8tasuqL
         AndkflpxixW7n8fnKvY69tU+8Kvu0dlV5Sks+yyZoLjB5cuQgAbcqCrVIgi/vM9aK03O
         xg7BuG1mcsAw/7igMTJulLI2oNOv79Mpe50AM1B7kKtV7qftQ5/tLWYzwd6ykipd+jDX
         j4+Q==
X-Gm-Message-State: AOJu0YxteM9tnJ0sJ6VZr5mgD4v1ZuYiUEgsJXkZosvsOC8ip3nROp+r
	nWHJ9gPSdXkeSSFSPefuAyM=
X-Google-Smtp-Source: AGHT+IG8MK6AbamgaD7ICvtrM4XHrEst3v5Zj7OCbPkUAQpR7DXKzBtnVQmzRdsj0FmZnt66ffpGUA==
X-Received: by 2002:a17:90a:6a8a:b0:263:68b0:8ca5 with SMTP id u10-20020a17090a6a8a00b0026368b08ca5mr5900730pjj.43.1692023634242;
        Mon, 14 Aug 2023 07:33:54 -0700 (PDT)
Received: from vultr.guest ([149.28.193.116])
        by smtp.gmail.com with ESMTPSA id 19-20020a17090a031300b002677739860fsm8640390pje.34.2023.08.14.07.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 07:33:53 -0700 (PDT)
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
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 0/2] bpf: Add a new kfunc bpf_current_capable 
Date: Mon, 14 Aug 2023 14:33:39 +0000
Message-Id: <20230814143341.3767-1-laoar.shao@gmail.com>
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

Add a new kfunc bpf_current_capable to check whether the current task
has a specific capability. In our use case, we will use it in a lsm bpf
program to verify if the user operation is permitted based on our
security policy.

Yafang Shao (2):
  bpf: Add bpf_current_capable kfunc
  selftests/bpf: Add selftest for bpf_current_capable

 kernel/bpf/helpers.c                               |  6 ++
 .../selftests/bpf/prog_tests/bpf_current_cap.c     | 80 ++++++++++++++++++++++
 .../selftests/bpf/progs/test_bpf_current_cap.c     | 37 ++++++++++
 3 files changed, 123 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_current_cap.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_bpf_current_cap.c

-- 
1.8.3.1


