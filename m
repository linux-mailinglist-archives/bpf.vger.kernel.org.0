Return-Path: <bpf+bounces-8714-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 515ED7891E5
	for <lists+bpf@lfdr.de>; Sat, 26 Aug 2023 00:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09360281978
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 22:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847AF168B1;
	Fri, 25 Aug 2023 22:45:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B03F1C02
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 22:45:46 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6595271B
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 15:45:40 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99bc9e3cbf1so303212066b.0
        for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 15:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693003539; x=1693608339;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UZjBIomQJi3KMrTfM3OGL3tos0qUPYQgh8LW4d5MSHU=;
        b=bxrIuxm/qtIR5qtFQJyVmUhbDLpujP8X4ZNfz/OvIakBT7N5O32bNwldpor2Mf2ox9
         D87nwTG5tkS4iH4EQtm6pC8GpvSNjKg1fPqFLZNPjKgOaBlmJfPZNkbFJQugbru0ui0z
         4D/UUo4IQyUyJYKcsY0cTbFyJ6lhk+fo8SNC5z/2jKMaB+zn+3bc84HW9UkXJkEHX+2u
         jUH1PedrNeVEXE6DS6si7WDdnaonysvVrjmty4jpSjmH8ae3ImVfrzRMAUD5uKSraHBM
         /iZe81QoD+rpXr0wODe+vIJlym3I36udglMoMTWPBjPy/vtwJai46hUwrGqit6enDCtk
         aC7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693003539; x=1693608339;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UZjBIomQJi3KMrTfM3OGL3tos0qUPYQgh8LW4d5MSHU=;
        b=lRakWGjlP9qTWlReqi8daG6hg9qCfXympuSatOd0tRhO45d3/r3A6WPaW+HZofidic
         Ipb4caUpiEKzUEYW+cKTPT5gMHLgoIhIEmUfh+qwoqOBpwRUMuF+Xepd8TDOX09UFCF9
         a0UHMMeoSnyfM93jMWMrGRX+igtJf+vNPMxh94v5vIPd5AyKz8JGUZHm1SHTPpiWPiY/
         4Q0ODFEMF7BfNaHezlo6S5TZc5/k3QtjIyq8JKao8SMaZ1QoPlQnzsp2V0Mr8/lUTWwJ
         TYI6kusmuWk+hUgjspRpknnBy1da0Wz1ld0omvGY3dy+zvnpph/Mvzef+tpb9TxBIUE6
         AhnQ==
X-Gm-Message-State: AOJu0Yxa667ucfZacsFWfRpqReMwS1VY30kzFVDpLQ5LorSt7N7v2C8C
	f5GE9t7Mq2NrwPRV4wtOo+dHcqawBAG/Sg==
X-Google-Smtp-Source: AGHT+IFFwempzzQzQ2KBZVBrEVo/ujZq6sMFf8FuDbYbHDHr4EVtxyzyP+SBlTU3xwrQLnfgvk65TA==
X-Received: by 2002:a17:907:7ea8:b0:9a5:83f0:9bc5 with SMTP id qb40-20020a1709077ea800b009a583f09bc5mr1842528ejc.18.1693003538561;
        Fri, 25 Aug 2023 15:45:38 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id sd26-20020a170906ce3a00b00997d76981e0sm1401095ejb.208.2023.08.25.15.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 15:45:38 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 0/1] docs/bpf: Add description for CO-RE relocations
Date: Sat, 26 Aug 2023 01:45:26 +0300
Message-ID: <20230825224527.2465062-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a section on CO-RE relocations to llvm_relo.rst.
Based on doc-strings from include/uapi/linux/bpf.h and
tools/lib/bpf/relo_core.c

Changelog:
V1 -> V2:
 - Small fixes suggested by Yonghong and Andrii;
 - C example extended to include all 13 relocation kinds (Yonghong);
 - Description of which fields are patched for which instruction
   classes (Andrii);
 - Details for BPF_CORE_TYPE_MATCHES relocation kind;
 - Details for BPF_CORE_FIELD_{LR}SHIFT_U64 relocation kinds.

[V1] https://lore.kernel.org/bpf/20230824230102.2117902-1-eddyz87@gmail.com/

Eduard Zingerman (1):
  docs/bpf: Add description for CO-RE relocations

 Documentation/bpf/btf.rst        |  31 +++-
 Documentation/bpf/llvm_reloc.rst | 304 +++++++++++++++++++++++++++++++
 2 files changed, 329 insertions(+), 6 deletions(-)

-- 
2.41.0


