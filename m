Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C942C5A45D3
	for <lists+bpf@lfdr.de>; Mon, 29 Aug 2022 11:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiH2JPO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Aug 2022 05:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiH2JPN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Aug 2022 05:15:13 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E059F17045;
        Mon, 29 Aug 2022 02:15:11 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id t5so9263123edc.11;
        Mon, 29 Aug 2022 02:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=N1vSqfghJH5ObRhEBdQq9M6XCfx+BUexsV5Mms366Ew=;
        b=E2VHEmLtxCh0DdzHKE9o07w2CZic2ispX33xEY/QXekN1bchXWz2+LN1LMj3noX1e9
         zDQ1RZPvTh9fbnBRGf/yVALUpg3EfamOwdsXuvtCPo+u1JHhsYfp3DubHnGK84tKxyr0
         Jj6hw6PtxrmIR/CTCQmcrOvMBNWqHLZ45jrqb5y/qmcn0gDAWKZgR6DaznWOsjgkWuTQ
         Yz1ZAezssi6FODGyLWSBrfSwupSv8fS1cbdk8UW6Y6n6mkMJpTrZLkMiovsfQTn+Xv8e
         gz8G/fW3AtXbbZ32L6d7IlrFF+/iIV05d6KEtlLAc8FJHK0HOONbe3UXqEBIyaBlhUlr
         i1iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=N1vSqfghJH5ObRhEBdQq9M6XCfx+BUexsV5Mms366Ew=;
        b=xjKAFd/lMlzSn1xinMPoHSThRBDTyKpBHCcOZmnIjF76to2SsJZywRjmm7cm1CGesh
         PlT9Solwt3VnssT+UvoFcNRZC/OKjJu3X/AZfT6D7b9fYJ1yZ7ILTb2KNQDV7bAtPLIP
         ez3LY0dsjgv0WDeRDF+lXZqC2U82ybhKn27cB7q9cCzSz0kK96uS6jq3FFhVQ2JJLJtV
         twi9KFp5WJBPy4Fvx1jNFJKhGQ/8cesrqIlmfJRKKM01DlniEPmJU6TgoYmYu6Stq0vs
         gBuLkNEKxu3f7nx5cXqXaCmQoXTlxewuAnf8TAf/tTKQjaOIVKdk1ETMFXJLJ8fbQ+/s
         CSQg==
X-Gm-Message-State: ACgBeo213sy1GWQ0LljuylhbA7bEbusXKyBE5SLCRpQoL5yWOT8Tc7id
        Y3tZFNBlMi76ZD05DeosMr+NDX90zZg=
X-Google-Smtp-Source: AA6agR7Tv2iQyjh6CuTSG4okih6g/ZKRtz6zrLwS1tVVs4F+gD5b6/WwYFA7FQtpmLAvoQOyfIAGjw==
X-Received: by 2002:a05:6402:d05:b0:435:b2a6:94eb with SMTP id eb5-20020a0564020d0500b00435b2a694ebmr15648089edb.87.1661764509873;
        Mon, 29 Aug 2022 02:15:09 -0700 (PDT)
Received: from imac.fritz.box ([2a02:8010:60a0:0:612e:4c5:1fc2:7d5d])
        by smtp.gmail.com with ESMTPSA id r1-20020a17090609c100b0073cb0801104sm4287382eje.147.2022.08.29.02.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 02:15:09 -0700 (PDT)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH bpf-next v3 0/2] Add table of BPF program types to docs
Date:   Mon, 29 Aug 2022 10:14:58 +0100
Message-Id: <20220829091500.24115-1-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Extend the libbpf documentation with a table of program types, attach
points and ELF section names. The table uses data from program_types.csv
which is generated from tools/lib/bpf/libbpf.c during the documentation
build.

Patch 1 adds subdir support to Documentation/Makefile and changes
userspace-api/media to use this instead of being a special case.

Patch 2 adds the program_types documentation with a new makefile in
the libbpf doc directory to generate program_types.csv

I plan to look at adding info about the format of section "extras" for
each program type as a follow-on.

v2 -> v3:
Put program_types after API docs in TOC as suggested by Andrii Nakryiko
Fix formatting as reported by Andrii Nakryiko
Include USDT extras example as suggested by Andrii Nakryiko
Include sample of program_types.csv as suggested by Andrii Nakryiko

v1 -> v2:
Automate the generation of program_types.csv as suggested by
Andrii Nakryiko.

Donald Hunter (2):
  Add subdir support to Documentation makefile
  Add table of BPF program types to libbpf docs

 Documentation/Makefile                     | 16 ++++++-
 Documentation/bpf/libbpf/Makefile          | 49 ++++++++++++++++++++++
 Documentation/bpf/libbpf/index.rst         |  3 ++
 Documentation/bpf/libbpf/program_types.rst | 32 ++++++++++++++
 Documentation/bpf/programs.rst             |  3 ++
 Documentation/userspace-api/media/Makefile |  2 +
 6 files changed, 103 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/bpf/libbpf/Makefile
 create mode 100644 Documentation/bpf/libbpf/program_types.rst

-- 
2.35.1

