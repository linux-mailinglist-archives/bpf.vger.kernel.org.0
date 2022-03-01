Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166A04C8468
	for <lists+bpf@lfdr.de>; Tue,  1 Mar 2022 07:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbiCAG63 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Mar 2022 01:58:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiCAG62 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Mar 2022 01:58:28 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B2A49F1D
        for <bpf@vger.kernel.org>; Mon, 28 Feb 2022 22:57:48 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id g7-20020a17090a708700b001bb78857ccdso1290253pjk.1
        for <bpf@vger.kernel.org>; Mon, 28 Feb 2022 22:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ctxl2yb8hg0sfA+hglhvWUm8oGUAYJjY7RQkRAOYL3s=;
        b=DnnCzPTY/8N7D/vXvjXNHMnrdLURHeHTgNzDZcALV/YJynKuHVijWUku49g3nH7z2O
         +118yheNL0KHPaDuzv6V9QzNbM1QAeai0kq/UTZsuR8PaY7WOtM0ug7ydvK3ot6BqTpx
         CIYloOSO5wEvjc/BPq2NToRSxBSVGOpbGHemCQM8dljZ1+VuQOBHbpWMuWVQo71OTp3m
         5kbf6EpBJrLbZMDVo62OfCAeTbPSuEFKa9HLW+oSYYvGnqiwTmywb98nK3KWFN8mNExA
         7SvuVdFjLWAQDP8UNd/GrZxwOLFV2oNsgPcbDySSpjnGemcmNckSrw/7dswi/RtDNGD7
         Hy6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ctxl2yb8hg0sfA+hglhvWUm8oGUAYJjY7RQkRAOYL3s=;
        b=puyoOPFvfzeEfDju9njBmokpwwbuZhB0ak+LZu5Pg7c3yZYu4XkUm+PSOcDYNHirqF
         lbVuYb94kN5qgK0plk4Tps4nMZuMezTrrFW0ueNkEMI7m4i+FiKOaWiMKuRQG7d9xZ67
         PDPDT0j9KO3FvM8rvos1PQHH46iNHtVc8hqbjbP/49c61GTH3TpUc5raT7DrSbCEnGif
         2e/uhVU+iLAdorekIOmpv5jG7eYkv7ukClH5SGJBG4LLiFhbKWVJRPMhylpOUx8gDuZc
         gMss26wgGUDlmzeyhl2XuNrHHb87MSs/P2LKwhszWzKwP3e2//Qk78RdxPbOUrLw3pDU
         +Gbw==
X-Gm-Message-State: AOAM533mzX0MGPDtLETRJuQ2C/Hfxrm/7B8VTnAoSLsiGt0pwjDmUGwg
        oq5oeJ2nfLxKDcqY5cL5RKx9LygVoic=
X-Google-Smtp-Source: ABdhPJxg8rYdBuadR5S6WWL7LFKewLwhCXUEzMsiP9CKX9401Eli5YNXff6u+GY8ZlThXjTj2zZzFw==
X-Received: by 2002:a17:90b:1249:b0:1bc:30a4:8344 with SMTP id gx9-20020a17090b124900b001bc30a48344mr20233014pjb.186.1646117867950;
        Mon, 28 Feb 2022 22:57:47 -0800 (PST)
Received: from localhost ([2405:201:6014:d0c0:6243:316e:a9e1:adda])
        by smtp.gmail.com with ESMTPSA id d14-20020a056a0024ce00b004f3c87df62bsm16329498pfv.81.2022.02.28.22.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 22:57:47 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next v1 0/6] Fixes for bad PTR_TO_BTF_ID offset
Date:   Tue,  1 Mar 2022 12:27:39 +0530
Message-Id: <20220301065745.1634848-1-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1276; h=from:subject; bh=HCmeENLSmP9ulAELTv4A/Kt0DNS9Lo6s7ektL51AFHU=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiHcO1L28/7b5tROnKYB7jSwwC62iFmbswUO3e1hew nz8y2hGJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYh3DtQAKCRBM4MiGSL8RyuKSD/ 4shOZbWpELOU5vcYZgXeuU7FmTTUebMNf+QQsa4als+WuIOh3o/rgSBrGDR+YsOCsf0SCwTKzah0Y2 pTXOXTH/TVvls15mq/gLqa2OlX+WzSUwPulGzyCpbINtKj6GDQrKD3YaPELNNHvkmQAcmE3wXJNQfE S9xSV9oLd09FT3PzA+DnIRkqhhqXGlu9KBYjQEqWm8uH3fg+JEND5Gv41KJ8kdi2njlJKDhHx1tVgt BCnxQOi80KDaTtOac9DKw7uepx9rYLu4zBWHZ4uuEaSzJMXthFLKlZ0JYO/Zy9MFsWbzAKjj83PTm6 tsLKWBjjlqi4ydSVRDEDAPWnmEFeBWNtNt/j4EYndNt6I+rz1Rdf0gxtHtYBp2w1Kr/znUJFw+QI02 ObrHv2msGbFWpl47ESBf8BZuLQSunnMPVaWOgiILkX+JdCN5czrv4uEJWTt18ZtlU2fJ5QlCpHwWnH 6Xuj2Ek1wCHahZzYzsTsdxg/3oxpdJ8csKfktubdWQRwF7BeeK/khgX42U+Cw6IOTFzBj/j7cIIAhC uxpZqjDyn1HRWXOxh/DoFYlSc4Z+G/zB+9ZYr1pHVKtv/99OKn/3YzI4iGD3SrG16MZZ7H94GkOTk0 Bb/fdalJc4d52LW3b0Q58QEzA7Tqnj78I4d3ibWKmtJ8K9sPPfJuvsPjUrrg==
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

This set fixes a bug related to bad var_off being permitted for kfunc call in
case of PTR_TO_BTF_ID, consolidates offset checks for all register types allowed
as helper or kfunc arguments into a common shared helper, and introduces a
couple of other checks to harden the kfunc release logic and prevent future
bugs. Some selftests are also included that fail in absence of these fixes,
serving as demonstration of the issues being fixed.

Kumar Kartikeya Dwivedi (6):
  bpf: Add check_func_arg_reg_off function
  bpf: Fix PTR_TO_BTF_ID var_off check
  bpf: Disallow negative offset in check_ptr_off_reg
  bpf: Harden register offset checks for release kfunc
  selftests/bpf: Update tests for new errstr
  selftests/bpf: Add tests for kfunc register offset checks

 include/linux/bpf_verifier.h                  |  3 +
 kernel/bpf/btf.c                              | 24 ++++--
 kernel/bpf/verifier.c                         | 75 ++++++++++-------
 net/bpf/test_run.c                            | 11 +++
 .../selftests/bpf/verifier/bounds_deduction.c |  2 +-
 tools/testing/selftests/bpf/verifier/calls.c  | 82 +++++++++++++++++++
 tools/testing/selftests/bpf/verifier/ctx.c    |  8 +-
 7 files changed, 167 insertions(+), 38 deletions(-)

-- 
2.35.1

