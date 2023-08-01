Return-Path: <bpf+bounces-6557-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E5876B75D
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 16:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C80CB1C20ED1
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 14:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B176125149;
	Tue,  1 Aug 2023 14:26:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DE62151C;
	Tue,  1 Aug 2023 14:26:39 +0000 (UTC)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BE010FA;
	Tue,  1 Aug 2023 07:26:38 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b9c5e07c1bso48567045ad.2;
        Tue, 01 Aug 2023 07:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690899997; x=1691504797;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/p1iV8LRIobQrwk48Wu7X//d2jaCoMI2Cn450sEjblk=;
        b=Dt1fTNWNFgET8qgImIooUfsHT0/C2kQgOHAES6nYzrPZ9Vd5663YprCHBAwOA36aNx
         K8eNQtgIrAP5bwG93cLks8zYGDpNDpqRHXvSSCGm9GKQHqvqkHAl6XgvG6GLxjrmWrlV
         RygQX6CN0NrDKLtfjqUk8LAsNhrIi6lBHrGFgPFySIBLthvT3uBhEIxVfyO99YknFYAK
         qtJavW5oaRGrZDHjggZx+l3XjojQbCo5VxU4Z2wySllMKnIyoCSaVtwMaQNLx7m1eEjG
         V1yj8Uc0uv1gwMoCTgH6H2DwTcvjGw2S9v6aASSJR+dGq0orsRtXkoselJW06lF8A3sc
         wG5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690899997; x=1691504797;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/p1iV8LRIobQrwk48Wu7X//d2jaCoMI2Cn450sEjblk=;
        b=G7pq5at2RFL97Rn3d9kPsX8lp6fTtzFXFt2BFrbdvDR1vLjvYjh32URKikXv+D7LtN
         wlGfdL+jub/WH8Oh+6p2Lc9M0hidcz573BFpB/RhybYs0/X6BrRlZW3UzYkrvOKqTJRQ
         cMAXgGF1eiB0nl3oG0jxFDy+qi3lLiYs/5ZdPptxCHgTyjZbiAi4LZkvHLptgSjBqcZN
         u2g2+DLsnOdpwUUsVXg4PSACynO0EJup1SMJ6kFTtwMSYS4/36xk2as7Ev150RHj4Fsi
         Rsn8nGUNNNJEGbztowA4N51UlLKpYrQRJ/D3iqww5V4epeH3f2Tduco11otDqkZ7yh7y
         SeFg==
X-Gm-Message-State: ABy/qLbOAvVj0ynY9aZGijYbzAoedtAofD2q8wMdkZxEiDJBhacftWSr
	m0zyYj3s6I9C/rLghoT13GvcXqDhDHIMrrTn
X-Google-Smtp-Source: APBJJlFs6bTG0tOfzdrqqhxX1PPnAorUhSKFUH9Au3k7b7zUcZEPN0+zY5JsjrFax3hh4Am/xZN4aA==
X-Received: by 2002:a17:902:d50a:b0:1b8:2c2a:962e with SMTP id b10-20020a170902d50a00b001b82c2a962emr15514951plg.33.1690899997283;
        Tue, 01 Aug 2023 07:26:37 -0700 (PDT)
Received: from localhost.localdomain (bb219-74-209-211.singnet.com.sg. [219.74.209.211])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902c10600b001b8a00d4f7asm10565100pli.9.2023.08.01.07.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 07:26:36 -0700 (PDT)
From: Leon Hwang <hffilwlqm@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
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
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	hawk@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	hffilwlqm@gmail.com,
	tangyeechou@gmail.com,
	kernel-patches-bot@fb.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v5 0/2] bpf, xdp: Add tracepoint to xdp attaching failure
Date: Tue,  1 Aug 2023 22:26:19 +0800
Message-ID: <20230801142621.7925-1-hffilwlqm@gmail.com>
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

This series introduces a new tracepoint in bpf_xdp_link_attach(). By
this tracepoint, error message will be captured when error happens in
dev_xdp_attach(), e.g. invalid attaching flags.

v4 -> v5:
* Initialise the extack variable.
* Fix code style issue of variable declaration lines.

v3 -> v4:
* Fix selftest-crashed issue.

Leon Hwang (2):
  bpf, xdp: add tracepoint to xdp attaching failure
  selftests/bpf: Add testcase for xdp attaching failure tracepoint

 include/trace/events/xdp.h                    | 17 +++++
 net/core/dev.c                                |  5 +-
 .../selftests/bpf/prog_tests/xdp_attach.c     | 65 +++++++++++++++++++
 .../bpf/progs/test_xdp_attach_fail.c          | 54 +++++++++++++++
 4 files changed, 140 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_attach_fail.c


base-commit: a33d978500acd8fb67efac9773ba0a8502c1ff06
-- 
2.41.0


