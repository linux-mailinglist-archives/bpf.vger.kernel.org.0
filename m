Return-Path: <bpf+bounces-4503-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A58E74BBAE
	for <lists+bpf@lfdr.de>; Sat,  8 Jul 2023 06:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBC401C210A6
	for <lists+bpf@lfdr.de>; Sat,  8 Jul 2023 04:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14A317CA;
	Sat,  8 Jul 2023 04:08:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9347315B2;
	Sat,  8 Jul 2023 04:08:06 +0000 (UTC)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB941FEA;
	Fri,  7 Jul 2023 21:08:03 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-666ed230c81so2067584b3a.0;
        Fri, 07 Jul 2023 21:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688789283; x=1691381283;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Yy1JRt4lb2N3jcvs0LbXzQbfHhvx8PThG5Z3vH/Cno=;
        b=LF5EumU+6t7+ldfB+bh9erO4HumB1Hqzm/l8XhSaGipSfCnzFc9jB4KCzjGJX+6sbR
         frsrThSyBJxm8dKiIdtESQ2qLaxdnIaaJJaD7WyEagg0LwX/lg0nqwAOYmGaVP7AxUmN
         K5fHRBPBqbxwVp9b7FPL65SqVn/BBmxf58t2x9EGuEa4MrheVB2xmaF1GjVVkiUYYBH2
         4+CBkwE4IGrx/wfFywjcNyH0bBRHtRsiOr3ZqjgXaYRqu5IHjrLlD+aVxAkyOcvTltJB
         fn2gMcKukY/HyPdEBHDCLlRUqSUhcyl+zyg0ZsrgekGkyMvjyD/KlFVFeJFeyU0q3+hQ
         QfwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688789283; x=1691381283;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Yy1JRt4lb2N3jcvs0LbXzQbfHhvx8PThG5Z3vH/Cno=;
        b=DOaPcplz6uH74FkF0pCacVoVxxw8MCqu+QDD86emGVlUsiyorJlQs/tnWvBigH0auh
         6bSnlkpUsNNUvVYOsqVTLzh/9WseimLxKqFIHnacXEz4wqBDvVZwAKAgix24vGhYdloh
         7amp3VQmu69nz0Ss8FENdT2DzWUyzwNIHurjdaWCwfGK9l5zos43GcNHHiN+NXfJfsMB
         r7+YTi2wG+WGvwkiEJyAMgtnBJ/6oppZjZw+8X9RBCb4lAfKJASzTyePjjpHNe768sTu
         xU1dHwfM2cUOCfOhCFLlLM/cNioqcLw40ZdFY8QQDSgSvTutqEm1ngoQ+tfZCEtYRpDl
         VNcw==
X-Gm-Message-State: ABy/qLYc7wgA3H7/Q9WDmTMt//VVrWc28RIfoo6SuwGkMYXg2W5fCO00
	5BUnjFBkyc4uBwPQD3cxTR8=
X-Google-Smtp-Source: APBJJlEXvxpqetJRRU0d7H6q2LfafOX2fM7Ctm5Y04yJrvisoNQPKQ7vV7fWg7HDN5cCvCljlWx3eA==
X-Received: by 2002:a05:6a00:1803:b0:666:ae6b:c484 with SMTP id y3-20020a056a00180300b00666ae6bc484mr9067406pfa.13.1688789283143;
        Fri, 07 Jul 2023 21:08:03 -0700 (PDT)
Received: from localhost.localdomain (bb219-74-209-211.singnet.com.sg. [219.74.209.211])
        by smtp.gmail.com with ESMTPSA id v12-20020a62a50c000000b00640f51801e6sm3507814pfm.159.2023.07.07.21.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 21:08:02 -0700 (PDT)
From: Leon Hwang <hffilwlqm@gmail.com>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	hawk@kernel.org,
	hffilwlqm@gmail.com,
	tangyeechou@gmail.com,
	kernel-patches-bot@fb.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v2 0/2] bpf: Introduce user log
Date: Sat,  8 Jul 2023 12:07:48 +0800
Message-ID: <20230708040750.72570-1-hffilwlqm@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
	HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This series introduces bpf user log to transfer error message from
kernel space to user space when users provide buffer to receive the
error message.

Especially, when to attach XDP to device, it can transfer the error
message along with errno from dev_xdp_attach() to user space, if error
happens in dev_xdp_attach().

Leon Hwang (2):
  bpf: Introduce bpf generic log
  bpf: Introduce bpf user log

 include/linux/bpf.h            |  3 ++
 include/uapi/linux/bpf.h       |  8 ++++++
 kernel/bpf/log.c               | 52 ++++++++++++++++++++++++++++++++++
 net/core/dev.c                 |  4 ++-
 tools/include/uapi/linux/bpf.h |  8 ++++++
 5 files changed, 74 insertions(+), 1 deletion(-)


base-commit: 622f876ab3ced325fe3c2363c6e9c128b7e6c73a
-- 
2.41.0


