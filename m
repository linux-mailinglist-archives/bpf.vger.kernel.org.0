Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28AE6DBE67
	for <lists+bpf@lfdr.de>; Sun,  9 Apr 2023 05:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjDIDel (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 8 Apr 2023 23:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjDIDek (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 8 Apr 2023 23:34:40 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0FA64EDC
        for <bpf@vger.kernel.org>; Sat,  8 Apr 2023 20:34:39 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id nh20-20020a17090b365400b0024496d637e1so7197084pjb.5
        for <bpf@vger.kernel.org>; Sat, 08 Apr 2023 20:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681011279; x=1683603279;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PoWiT0BrMtqOdVmk/sp57XFUcGah5ddNHNnKT2Q3CCY=;
        b=LSxl68hJvWzflYWDAEvnGHwDKbh2Q/mk+WsQSf/JpEf0epE11J8R0ZQ5gzVaHXjbQR
         b1IUUsTKyEu03PMJakrFgcPJ6+Urc3OFdoPZT7TKJeV7hROnW3b9WBZvXV7vnrax1ME3
         Wen6ggca0LBC1GwTqp8F/2osstlanLyEzdAcMIZpgXaxT3q7lSsWv9iPR4hITsboV0K5
         7SCBgIWlJkx366pLwUpBty+T8k1mCC4UQqyMWKLk4q1RmBhBl8BiHALUhwGUA/SmsHw3
         YEInsjFj87x7HSCGVw45mV5Lkc1JgzUPzX0J49Qzo0GBw7dq73EEVnNCSr+j9RGL3mkt
         qQzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681011279; x=1683603279;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PoWiT0BrMtqOdVmk/sp57XFUcGah5ddNHNnKT2Q3CCY=;
        b=SstoR64Sk/lut1RKySfiDBFMP1AENeqOB6Dp9dF8/gY7rUDyGqGdPe93EjM+MXJrhV
         wJHY0SQOAaYUlwSX/C9FophxVMJfVBE3dsvr0vLCXD27pI+B88CiYUCTL6yWYDZ+Chdw
         fxGdvjDJqez2nRAd1ArOmrIr9nikz3j/SLUF237PQPdIgHzVAlAEMyiqDnoPlEHbPedG
         iQ36bIXEwk5qe3czbijWKFBqmlg4G6Fq0K8rzkFZeTONji9FZOPQU7R+Vap41yapyt4K
         35ymLijTK2BkJrxtm7kETYDztZeiLvD0+kyOUc2XTr9glX1V1gsBJf69nFosCz9XCao2
         FaHA==
X-Gm-Message-State: AAQBX9cXGUX9s/D3Uo6f+0SZUFWYj/iBUOTwYME5ZMygGepBMxLjZU+d
        QAy86eBct0oYARpXNVMxA41ZPcPtSM3atQ==
X-Google-Smtp-Source: AKy350bzTHOY/oDYVgWkIB7AGPyowYK3nt5uSTosSxklzvyzotF/+WAYu0JgR0eCc2upz/GJSaqDYg==
X-Received: by 2002:a17:90b:1c04:b0:23f:b369:c159 with SMTP id oc4-20020a17090b1c0400b0023fb369c159mr4333411pjb.49.1681011278883;
        Sat, 08 Apr 2023 20:34:38 -0700 (PDT)
Received: from gatsby.corp.tfbnw.net (75-172-126-232.tukw.qwest.net. [75.172.126.232])
        by smtp.gmail.com with ESMTPSA id x2-20020a170902fe8200b001a212a93295sm5185877plm.189.2023.04.08.20.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 20:34:38 -0700 (PDT)
From:   Joanne Koong <joannelkoong@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH v1 bpf-next 0/5] Dynptr convenience helpers
Date:   Sat,  8 Apr 2023 20:34:26 -0700
Message-Id: <20230409033431.3992432-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patchset is the 3rd in the dynptr series. The 1st (dynptr
fundamentals) can be found here [0] and the second (skb + xdp dynptrs)
can be found here [1].

This patchset adds the following convenience helpers for interacting
with dynptrs:

int bpf_dynptr_trim(struct bpf_dynptr *ptr, __u32 len) __ksym;
int bpf_dynptr_advance(struct bpf_dynptr *ptr, __u32 len) __ksym;
int bpf_dynptr_is_null(const struct bpf_dynptr *ptr) __ksym;
int bpf_dynptr_is_rdonly(const struct bpf_dynptr *ptr) __ksym;
__u32 bpf_dynptr_get_size(const struct bpf_dynptr *ptr) __ksym;
__u32 bpf_dynptr_get_offset(const struct bpf_dynptr *ptr) __ksym;
int bpf_dynptr_clone(const struct bpf_dynptr *ptr, struct bpf_dynptr *clone__init) __ksym;

[0] https://lore.kernel.org/bpf/20220523210712.3641569-1-joannelkoong@gmail.com/
[1] https://lore.kernel.org/bpf/20230301154953.641654-1-joannelkoong@gmail.com/

Joanne Koong (5):
  bpf: Add bpf_dynptr_trim and bpf_dynptr_advance
  bpf: Add bpf_dynptr_is_null and bpf_dynptr_is_rdonly
  bpf: Add bpf_dynptr_get_size and bpf_dynptr_get_offset
  bpf: Add bpf_dynptr_clone
  selftests/bpf: add tests for dynptr convenience helpers

 include/linux/bpf.h                           |   2 +-
 kernel/bpf/helpers.c                          | 108 +++++-
 kernel/bpf/verifier.c                         | 125 ++++++-
 kernel/trace/bpf_trace.c                      |   4 +-
 tools/testing/selftests/bpf/bpf_kfuncs.h      |   8 +
 .../testing/selftests/bpf/prog_tests/dynptr.c |   6 +
 .../testing/selftests/bpf/progs/dynptr_fail.c | 313 +++++++++++++++++
 .../selftests/bpf/progs/dynptr_success.c      | 320 ++++++++++++++++++
 8 files changed, 864 insertions(+), 22 deletions(-)

-- 
2.34.1

