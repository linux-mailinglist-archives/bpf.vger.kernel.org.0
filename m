Return-Path: <bpf+bounces-8759-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C68B17899B9
	for <lists+bpf@lfdr.de>; Sun, 27 Aug 2023 00:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E94122810F9
	for <lists+bpf@lfdr.de>; Sat, 26 Aug 2023 22:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8902410956;
	Sat, 26 Aug 2023 22:29:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F45EA53
	for <bpf@vger.kernel.org>; Sat, 26 Aug 2023 22:29:39 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B591BC
	for <bpf@vger.kernel.org>; Sat, 26 Aug 2023 15:29:37 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99cdb0fd093so254631166b.1
        for <bpf@vger.kernel.org>; Sat, 26 Aug 2023 15:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693088975; x=1693693775;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vu/DLHVBaiikpEH+gRbpZX9POqELzI2W0AsmNENdDSw=;
        b=ARfdAaWlosD/b4Ju5zHzHpf7CYd46hg1gHT+YuEMMDMov97ZtRF6dvV0XEUZLHrb/E
         +U1Idu6hPqnaORM1KjEHebb2rK168tdxDSphzmbyxOKrEimc5Bv4f02B3uheOWbdJz//
         Inh+U56qYqgS0DPvPRlp4FejlDmJDbF+JOs/RAFi20fe6rxUBRyi3KvHFX4Rr33a1LRj
         da9phr+8UtgjhN55bdkp322GA5UOmXksOCJTHTIdt1kiXVdYei382pa28PS9mmrowEt5
         Id4Qrv9zwAWc4mbkGyByG7tNblYk/vzgHnmpGDXJEdCfjXtvXj5gPeqQeIPiQ0mviTnj
         DXPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693088975; x=1693693775;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vu/DLHVBaiikpEH+gRbpZX9POqELzI2W0AsmNENdDSw=;
        b=fT4NG9WY0OVEU3y/p7t9MmBBaa8QTh2hMutyyQukGv8Enx7qJRuX4V9eOtZjBSSDU9
         yyMyR/OV49vxwZlh6E0F0Rq0uNcmHNZkP7D5QtLj6KdPk5x+FW/wQUPxU5Uk3AqNSR16
         3mRyhg2chKMniiiTsxujREgaIGIchU/yTWTkHUzszRJtkwfCFaLC12V7HPnfKo8Vq6x+
         /gpvojKZUyxz5CY+LzNyf+0cIQ5QNXzV3UaG90H8g4LpvvijzkY+wWJiP5g6A1Wq8km/
         w0wfMhzChFWjymJr+WubTzoD2ySiZQ1hVIgBycze0rAC+nejOjPvcK34rG+OfQJy0Glt
         7ikw==
X-Gm-Message-State: AOJu0Yyd6k7eoaX9s6bPjl2EJSHCnJIupyK48ysZNnaIe587oxnt93Z4
	lGIoIYQBDEXzZYb4G+v0M8cMXdS0jx0=
X-Google-Smtp-Source: AGHT+IFWtjCC2F0eudjI3uGVUura7ebjnpVVF94ZwS1bthZ0UC9asVtd8ooheE+eRDUfTrdu0nPX7w==
X-Received: by 2002:a17:906:32c3:b0:991:fef4:bb7 with SMTP id k3-20020a17090632c300b00991fef40bb7mr14857693ejk.73.1693088975389;
        Sat, 26 Aug 2023 15:29:35 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id kb12-20020a1709070f8c00b0099297782aa9sm2679716ejc.49.2023.08.26.15.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 15:29:34 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 0/1] docs/bpf: Add description for CO-RE relocations
Date: Sun, 27 Aug 2023 01:29:11 +0300
Message-ID: <20230826222912.2560865-1-eddyz87@gmail.com>
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
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a section on CO-RE relocations to llvm_relo.rst.
Based on doc-strings from include/uapi/linux/bpf.h and
tools/lib/bpf/relo_core.c

Changelog:
V2 -> V3:
 - Small fixes suggested by Yonghong;
 - Added ack from Yonghong;
V1 -> V2:
 - Small fixes suggested by Yonghong and Andrii;
 - C example extended to include all 13 relocation kinds (Yonghong);
 - Description of which fields are patched for which instruction
   classes (Andrii);
 - Details for BPF_CORE_TYPE_MATCHES relocation kind;
 - Details for BPF_CORE_FIELD_{LR}SHIFT_U64 relocation kinds.

[V1] https://lore.kernel.org/bpf/20230824230102.2117902-1-eddyz87@gmail.com/
[V2] https://lore.kernel.org/bpf/20230825224527.2465062-1-eddyz87@gmail.com/

*** BLURB HERE ***

Eduard Zingerman (1):
  docs/bpf: Add description for CO-RE relocations

 Documentation/bpf/btf.rst        |  31 +++-
 Documentation/bpf/llvm_reloc.rst | 304 +++++++++++++++++++++++++++++++
 2 files changed, 329 insertions(+), 6 deletions(-)

-- 
2.41.0


