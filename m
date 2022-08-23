Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2F859ECD7
	for <lists+bpf@lfdr.de>; Tue, 23 Aug 2022 21:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbiHWTuR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Aug 2022 15:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232266AbiHWTtk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Aug 2022 15:49:40 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AC9D9A
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 11:53:07 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id h22so18977006ejk.4
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 11:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=tzQkFAEhZVmJDgbpqZgYcHYtdZ+glsMmFdoHhE5TnL4=;
        b=CRTbT3aY/5+Mcfo4vDAIsi4HqwVMHkpRonbN3MDgBMWmcP5Hiy0gMv7xDN2CnAScX3
         w31yGvRWLkOjtFz7Dw5rSTW78he0ULxZf/t107u4u+Ha3ChxFd4aTt5CzkTC7t20HGiy
         XbVLbYwiy7jVCPyxhJ1UXUVH+vE2e7yfbotksyBz2knZ0rD/LHvX6LuuHvIqCp+vjt5/
         01ld8FfpL1p5pq1w//KzQd1MxEMhj0xMaxfrsSRARaB066sFwk/AFWPx0N8e+SnhmFEk
         f7k2iCp9TXCi5GbNU5H+DGUwCb+KVknkdDjHx7s9c56HxdtGRxELOgHpuTBMrC+k0gLj
         fBtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=tzQkFAEhZVmJDgbpqZgYcHYtdZ+glsMmFdoHhE5TnL4=;
        b=zmOGzFchAaDl4EpJFifHRYtsTHJTjCq7ozQnFPUBozGmQ8pzXRnPDTKaerPV/66X4h
         KTyfmYw8e+ilIxBVJl4/RAf/4GUCM1vxL3yXcDpkLy/aQjbmnS1pqw2jI0V8NmxXOtV0
         qxdT+Mz0XT9BsD2S6DFehKsjcECvj5/xHFvugr3b99IlpO4lLk7qYLhj5nTV6pm76HwE
         9Yk2B0yg6C/UsKl8jthaXK06lnFbj5gip9fIvsUqoh2ld8u2+ZB7YT/WVr5LAlKTpjoX
         mahC+lI89W0if3zPzbjNiKeqvDNTNU/arStNZOZd+f58vFHtckZn1oIck6LZvuUDuz7s
         8CNw==
X-Gm-Message-State: ACgBeo1emETLHd62hzwFtBBqogMYKJbVBnOOQ79Wk1i7eW2nFMvlDq0d
        mwLHPcN3KI/1NMoSIxsxMpGVOAamghA=
X-Google-Smtp-Source: AA6agR5j7CdK+s0Gw7qXZO0otyLwycRanyR+2Ls8nbbyQ1ApRE4UGKLKscRlItshsz5qEof4D3b2AA==
X-Received: by 2002:a17:907:3ea5:b0:73d:85ec:453 with SMTP id hs37-20020a1709073ea500b0073d85ec0453mr601396ejc.311.1661280785644;
        Tue, 23 Aug 2022 11:53:05 -0700 (PDT)
Received: from localhost (vpn-254-130.epfl.ch. [128.179.254.130])
        by smtp.gmail.com with ESMTPSA id ky5-20020a170907778500b00734b3194ecesm178268ejc.163.2022.08.23.11.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 11:53:05 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf v1 0/2] Fix incorrect pruning for ARG_CONST_ALLOC_SIZE_OR_ZERO
Date:   Tue, 23 Aug 2022 20:52:58 +0200
Message-Id: <20220823185300.406-1-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=579; i=memxor@gmail.com; h=from:subject; bh=KNr39pj77GVulQAHv4/9GK5ZavOC529nIMtJWFEQPVk=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBjBSIEhUzOcBhyz6ndv7ixRGfQm8goeuIyox6Pptzb NJtu9WyJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYwUiBAAKCRBM4MiGSL8RyqbvD/ oDLiQKDf1hdvGHD/q+WxlW61GaCAQ3BaXnHhP3V1cXf0yxdAqRSZFCZnMXtpUFHFsyrXOVB+kbTLZr Nm5LaR0/tt4dtMEGIyOeJcwBFZkvv5roxOjEsrwriEV3yEI1o45TasoQueZqFKCLP/vzZch3vhL3MO koMPBAKHyXsFwEeG2FN+hKljr41+Nn6lRvEO9RVmeLpZXD/l60tTrU6fPNS+xwbqMgOFy3spzZbjdU KTmXgtLfys0gT5cpcYyVybq0NY1kJ5aOGYQeXdRxHvcBHVXoHVE9txHQsBSOu8VFNZODHHVET7b0dJ iCnsjEafFlafmGCO6aFwbuidBXI9RgV03r2gaTWt4b7YX6rFpn8oR/KarqbzamRO7Y/+zD7tB4DLHj JhGB2iM9ddlj+a69SFqoFrSOw7T0+vWnetREgY8Wvgspnz4IYfCExrJPELSKRvfzHHfV1Qb1RTEf5q J8/z+YJFJUODdYBy/LdLl81cQ8Ldp8cODiVdUPiJlqb2SXYTLX1L9UCgaqJuKyQhxH6IuqZC39VrRP aesVxRYVSWJcHOSbpN3HBjj5p5D/DCkmHsGXHFicbzNa2p6nky2YlhnxT/wt8sjKxmAVtd9RaNSPMP 8AxSC+Tdm+IEzeX6YV+kZgPAzAp6iGFXQpAht1REk/AxEF17S5dJ/lL9DSgA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
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

A fix for a missing mark_chain_precision call that leads to eager pruning and
loading of invalid programs when the more permissive case is in the straight
line exploration. Please see the commit log for details, and selftest for an
example.

Kumar Kartikeya Dwivedi (2):
  bpf: Do mark_chain_precision for ARG_CONST_ALLOC_SIZE_OR_ZERO
  selftests/bpf: Add regression test for pruning fix

 kernel/bpf/verifier.c                         |  3 +++
 .../testing/selftests/bpf/verifier/precise.c  | 25 +++++++++++++++++++
 2 files changed, 28 insertions(+)

-- 
2.34.1

