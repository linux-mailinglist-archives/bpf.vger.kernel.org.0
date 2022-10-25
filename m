Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7DF60CFE0
	for <lists+bpf@lfdr.de>; Tue, 25 Oct 2022 17:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbiJYPDq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Oct 2022 11:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232388AbiJYPDp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Oct 2022 11:03:45 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9D81AFA9A
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 08:03:43 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id i5-20020a1c3b05000000b003cf47dcd316so467192wma.4
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 08:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ixQHMERYdgRb7FUM1/1Io76g7S2tfmEKG93IxR6PYMU=;
        b=ysyODqMpzYEB5xwLCraBYcLjXoKAXNE5QsQ/tjIJn6kZmsLNVxGAIRv3chsx4EdD7K
         qTVCbsunuskACDbBPj10YXeLBcFYteTC7FVFuyvfh4ZbF3h0Y/BJouyYp79xuwNgpGGC
         HTEP5kUOtZeNw1sW35hrV1q5YSGzWAvJvM8ONnY4C3XXQiLAEhCROAetx+Zw1i4q4Ku4
         zV+yOsTfTXfUmUy0lARWnapmSz09zh/K7H18Kk+zaqF1ncably4Ik6zvk7XDURRONN3a
         oHImqFndlEx9z9tV/aodPHSHueBl3vlhQwbV5gFLjsgOIhUoE6l+sQ26nOZD1ny7VPpy
         qrvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ixQHMERYdgRb7FUM1/1Io76g7S2tfmEKG93IxR6PYMU=;
        b=IEV41BDZ8zyAs0jEZEdfkWVguvQPhS+UM6OoONGO5iU9Q07yjkAa2n9pXILfx71kOk
         hzkzpQvOe+DJye8hlFUcG+p91maG4ozT3EYZzcIZbsyv6VMBv3UFDtICQtC96K2+Opdd
         BA2P3jlvxLpVuoiiMUB/qmzq2lyKFexprStiHsNoQJw9/8trvZaNPb2UHWyaliJApP1+
         K7HJNRtoAa0OErN1CpscjiGLeyUXfi1hesSLQyyrMe1qjPpa+ECjxNoJqEQe/6+7vmL0
         LaFaUe5JqJpWt24neoD+RMVpKQKs28CxZQG5Lnz83t+7fU4A6XLocOaX1TQT7lkOF8ix
         RTTQ==
X-Gm-Message-State: ACrzQf2KZHjnKILEwB64m/M6nJm7ygdJfyUPX5ZzTNzvZyJ+d3aX01rv
        4Ae8sZ3Ib7N4KuQpdeNvKmQrRd3NAzTjOw==
X-Google-Smtp-Source: AMsMyM7px89BPjzAwS8P2C6U3KErEMP7aWbVDABGvvdknm/nDI2FiWTSTt/aKUBUL0MSwnbLFfGlTA==
X-Received: by 2002:a05:600c:1990:b0:3c9:a5e8:addb with SMTP id t16-20020a05600c199000b003c9a5e8addbmr11564995wmq.140.1666710221798;
        Tue, 25 Oct 2022 08:03:41 -0700 (PDT)
Received: from harfang.fritz.box ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id i7-20020adff307000000b0023659925b2asm2724182wro.51.2022.10.25.08.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 08:03:41 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@corigine.com>,
        Simon Horman <simon.horman@corigine.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Andres Freund <andres@anarazel.de>, Song Liu <song@kernel.org>
Subject: [PATCH bpf-next v4 3/8] bpftool: Split FEATURE_TESTS/FEATURE_DISPLAY definitions in Makefile
Date:   Tue, 25 Oct 2022 16:03:24 +0100
Message-Id: <20221025150329.97371-4-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221025150329.97371-1-quentin@isovalent.com>
References: <20221025150329.97371-1-quentin@isovalent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Make FEATURE_TESTS and FEATURE_DISPLAY easier to read and less likely to
be subject to conflicts on updates by having one feature per line.

Suggested-by: Andres Freund <andres@anarazel.de>
Signed-off-by: Quentin Monnet <quentin@isovalent.com>
Tested-by: Niklas Söderlund <niklas.soderlund@corigine.com>
Acked-by: Song Liu <song@kernel.org>
---
 tools/bpf/bpftool/Makefile | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index 4a95c017ad4c..0218d6a1cae7 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -93,11 +93,20 @@ INSTALL ?= install
 RM ?= rm -f
 
 FEATURE_USER = .bpftool
-FEATURE_TESTS = libbfd libbfd-liberty libbfd-liberty-z \
-	disassembler-four-args disassembler-init-styled libcap \
-	clang-bpf-co-re
-FEATURE_DISPLAY = libbfd libbfd-liberty libbfd-liberty-z \
-	libcap clang-bpf-co-re
+
+FEATURE_TESTS := clang-bpf-co-re
+FEATURE_TESTS += libcap
+FEATURE_TESTS += libbfd
+FEATURE_TESTS += libbfd-liberty
+FEATURE_TESTS += libbfd-liberty-z
+FEATURE_TESTS += disassembler-four-args
+FEATURE_TESTS += disassembler-init-styled
+
+FEATURE_DISPLAY := clang-bpf-co-re
+FEATURE_DISPLAY += libcap
+FEATURE_DISPLAY += libbfd
+FEATURE_DISPLAY += libbfd-liberty
+FEATURE_DISPLAY += libbfd-liberty-z
 
 check_feat := 1
 NON_CHECK_FEAT_TARGETS := clean uninstall doc doc-clean doc-install doc-uninstall
-- 
2.34.1

