Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2636A7263
	for <lists+bpf@lfdr.de>; Wed,  1 Mar 2023 18:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbjCARyi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Mar 2023 12:54:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjCARyg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Mar 2023 12:54:36 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC702D76
        for <bpf@vger.kernel.org>; Wed,  1 Mar 2023 09:54:35 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id da10so57323923edb.3
        for <bpf@vger.kernel.org>; Wed, 01 Mar 2023 09:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677693274;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a4SvNmMeU/zioV4mXgPgV13eRfGUxdh558WsBrcXg+Y=;
        b=AdScOLL7FijG+cT2/333SMNyY6LDCONBCn2Xbu08FcxQdIOodIfsqVT0FEwvzptG8n
         DfhZ3I8H0TS0hv47cegV07N/D/5vkkIpYUI9kifl0DCYvWy69qFHUzxdivXFYevckyov
         T7Kc5kgeoEz1RNgL6dUCVmBGolGU8E2Rj8ls/pw5j0iuC//BPanyghVTm/iwlrtkXblX
         ugDtdHx2WV4WBg+uAjxmLqjfrCXWp+7MaWEsiO/328cPsU1b+jrwMa/aJ7dYl9xzkda9
         +tAGmLpbF6a2rdUCF79nPYY5nRKGieZ+Hy7JCv0kL+Cc8KVMPNUQsUbexPa/wKS4yeM0
         F2uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677693274;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a4SvNmMeU/zioV4mXgPgV13eRfGUxdh558WsBrcXg+Y=;
        b=Xa6frtsrSWX1sb2lrSTtt9M8pRwg8VznfKlO7PtSDWLQnqhbm1xQ/eIsgzLxx1nCHO
         6uuq8Fh8/PkOrVqetoczGF+WXFzy/+K7/ljfbZ33HqYtnmb4T5HTaqf8hGdLQeysi8k2
         j6IYDA7cEly1lNGnJmY7w6dAJdcjBqSgDS2vB1XMKCKAgIi2MPvunaTvZFKC6qvfCzcG
         o7d9fQo54nnZ3rp6zzEJefnSSqQNdJGR5CY5JXf0zk7uIkmLq95lQdVKu+CAAFJ68Ma1
         F0TofeQgMRi/pBrIjNzn6dnw7OdzbjkCeHG5hX7XXIWnWTKEG/HKphJfIYJMbQ9qPFRj
         iBsQ==
X-Gm-Message-State: AO0yUKXCrVL4pk6wthHhSuI089wzEvTH+tCn66uBOYEjjYfZE1KsWD8K
        T6Z4Qo5A5t2/AiKI+Evp5xgVR3chJpAq6A==
X-Google-Smtp-Source: AK7set+vLqFGC8tic2actq78co+gDPK1eVxvGeQbI2RWKYbpMAajDgHHjW7jpkXd8+v4unGyF0G19Q==
X-Received: by 2002:aa7:d991:0:b0:4ad:8fc5:3d2a with SMTP id u17-20020aa7d991000000b004ad8fc53d2amr7440636eds.11.1677693274117;
        Wed, 01 Mar 2023 09:54:34 -0800 (PST)
Received: from bigfoot.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id 26-20020a50875a000000b004a21c9facd5sm5909812edv.67.2023.03.01.09.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 09:54:33 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 0/1] selftests/bpf: support custom per-test flags and multiple expected messages
Date:   Wed,  1 Mar 2023 19:54:16 +0200
Message-Id: <20230301175417.3146070-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch allows to specify program flags and multiple verifier log
messages for the test_loader kind of tests. For example:

  tools/testing/selftets/bpf/progs/foobar.c:
  
    SEC("tc")
    __success __log_level(7)
    __msg("first message")
    __msg("next message")
    __flag(BPF_F_ANY_ALIGNMENT)
    int buz(struct __sk_buff *skb)
    { ... }

It was developed by Andrii Nakryiko ([1]), I reused it in a
"test_verifier tests migration to inline assembly" patch series ([2]),
but the series is currently stuck on my side.
Andrii asked to spin this particular patch separately ([3]).

[1] https://lore.kernel.org/bpf/CAEf4BzZH0ZxorCi7nPDbRqSK9f+410RooNwNJGwfw8=0a5i1nw@mail.gmail.com/
[2] https://lore.kernel.org/bpf/20230123145148.2791939-1-eddyz87@gmail.com/
[3] https://lore.kernel.org/bpf/20230123145148.2791939-1-eddyz87@gmail.com/T/#m52e806c5a679a2aa8f484d011be7ec105939127a


Andrii Nakryiko (1):
  selftests/bpf: support custom per-test flags and multiple expected
    messages

 tools/testing/selftests/bpf/progs/bpf_misc.h | 23 +++++++
 tools/testing/selftests/bpf/test_loader.c    | 69 +++++++++++++++++---
 tools/testing/selftests/bpf/test_progs.h     |  1 +
 3 files changed, 84 insertions(+), 9 deletions(-)

-- 
2.39.1

