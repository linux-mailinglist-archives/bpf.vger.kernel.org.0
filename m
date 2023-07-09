Return-Path: <bpf+bounces-4522-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8BB74C084
	for <lists+bpf@lfdr.de>; Sun,  9 Jul 2023 04:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A83BD1C2091E
	for <lists+bpf@lfdr.de>; Sun,  9 Jul 2023 02:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A5D17E1;
	Sun,  9 Jul 2023 02:59:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70159ECA
	for <bpf@vger.kernel.org>; Sun,  9 Jul 2023 02:59:26 +0000 (UTC)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C6CE46
	for <bpf@vger.kernel.org>; Sat,  8 Jul 2023 19:59:25 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-26304be177fso1583556a91.1
        for <bpf@vger.kernel.org>; Sat, 08 Jul 2023 19:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688871565; x=1691463565;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DTb9dHmrx5NrOA9uQvLk8anIvWxiBshYXfjClqfqohY=;
        b=ap4wf9Vkr1lGHegaAnGmqc38dr9JcV6t2rAuXSPVlzIumnglQvZ8TFRhx5UUdkHXrX
         jPdrR3IzDeIOhv16xoPsiGG8PVRZTZY4UBEs/OuQE3nt4AzniNmD/FqdeooJcpn9glZN
         +vwiDmXa58iWxc1qP3KZzlHKIjc3hqsS0CE5URwPrippw45DI7THuOX45neTdZ4LALC9
         07wJCojmom12aT7s5qpV8Ch/g4f6FTxohvVT5tjFr8BtNQsEMDCORDkThaNKs2cUR3Ie
         rv5l8LpMskDzf8dX7psrETBkzw6VvDbv0IhV5hV4KFmKjD8DXFmq4/EbEbN0lmVnx237
         a6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688871565; x=1691463565;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DTb9dHmrx5NrOA9uQvLk8anIvWxiBshYXfjClqfqohY=;
        b=LdW/OZu/CARXqwUSVfSSLO1aQCpY6wVmYgEFvuz9C0ENvyUyt/OpiSqHyOzxXFJoS/
         Z0US2Vn1R+fQm0I/52ip7ZGZzaZzpOLbSmsfFHNca1oVfhhp9pvVz/7EoDtgbmUA5pZZ
         PTzAS6/OHk7lqSLNlF5nfa1TgwEBNRHGh39dr0icq58cnX6gxi/0MJ28n61PM/W2dNNB
         kDsv7RFOlozVLr9N1xutRqBelprzZtnbbtJvxgRGt6fZohiRDav4de5c6JWAcNlEizw+
         C7nOzCidB3PQoWhb9lvHp1Yoe7HvEenCFJfLI0xUMcNyTHbIag7deXTLIws/ipPpL7Bw
         h48Q==
X-Gm-Message-State: ABy/qLbkDkqU1rHvohaDk9k6LSC9W/7R1GOSUaABmm2m9N5nM2vsxbbz
	6tWEyF/85fjtRWRtsy2P5O4=
X-Google-Smtp-Source: APBJJlHD+/VFLABnPvgx5WBTk5Gk4bt0gtQaqI1FKxbZW0dhonA2t3XDEF4WELFIWqa1g+GdlEI2ww==
X-Received: by 2002:a17:90a:2f06:b0:25e:7fdd:f39c with SMTP id s6-20020a17090a2f0600b0025e7fddf39cmr7023825pjd.16.1688871564824;
        Sat, 08 Jul 2023 19:59:24 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:14bb:5400:4ff:fe80:41df])
        by smtp.gmail.com with ESMTPSA id q9-20020a17090a68c900b0024e4f169931sm3670659pjj.2.2023.07.08.19.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jul 2023 19:59:24 -0700 (PDT)
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
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next 0/3] bpf: Introduce union trusted
Date: Sun,  9 Jul 2023 02:59:09 +0000
Message-Id: <20230709025912.3837-1-laoar.shao@gmail.com>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When we are verifying a field in a union, we may verify another field
which has the same offset. So we should annotate that field as
untrusted. In some cases we have already known that some fields
are safe and then we can add them into the union trusted allow list.

Patch #3 fixes an issue found in our dev server.

Changes:
- bpf: Fix errors in verifying a union
  https://lore.kernel.org/bpf/20230628115205.248395-1-laoar.shao@gmail.com/    

Yafang Shao (3):
  bpf: Introduce BTF_TYPE_SAFE_TRUSTED_UNION
  selftests/bpf: Add selftests for BTF_TYPE_SAFE_TRUSTED_UNION
  bpf: Fix an error in verifying a field in a union

 kernel/bpf/btf.c                              | 22 +++++++++----------
 kernel/bpf/verifier.c                         | 21 ++++++++++++++++++
 .../bpf/progs/nested_trust_failure.c          | 16 ++++++++++++++
 .../bpf/progs/nested_trust_success.c          | 15 +++++++++++++
 4 files changed, 62 insertions(+), 12 deletions(-)

-- 
2.30.1 (Apple Git-130)


