Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42AF1628DDC
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 01:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbiKOABg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 19:01:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiKOABf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 19:01:35 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32645F3F
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 16:01:34 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id b21so11594285plc.9
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 16:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5qEPzzBcoZUx6b+pJw5RAcPzjwqbVTOTWL1iVV3UMOY=;
        b=fMla+qwGBN09pOq7QSGLye5TGcePW4T74MCId+lY+qoPTvGbUzoCYYiTpRR/321K9c
         lQ2B5Wqbp+5LSNiH3RF73xO67j9iRVUTogynVWS7g8IcMTBlcz8rO4kY5B/PrR3GjSEZ
         6n3Vga1a0ZcQexTuUPrV4hHfYgfb+zaIMtFUB0hEwg16lWopn5gUBtcIohgV6dtS6mx8
         r0Z5cHL0ETppJRvK5nHg2IICSNBxEAHn5MknOhogEo/S73K8tQQtufybHnzBakGhqmn4
         ePdqbhgavMz16hg/zmayJTieaM2SL1N/H0BDuzlZsRI3wBQyLehh6PjUTnC2hLO0CrQ+
         MzhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5qEPzzBcoZUx6b+pJw5RAcPzjwqbVTOTWL1iVV3UMOY=;
        b=lgiU1gEsRx5PGTKvcdChshsIof14cmhVy98pEGLB1xdnrJmO0au3GToa7PGwK+jlFw
         ZRGdlI7p70TQOtyRg6viwckmmGztEC8LXzd9fcZMPBVyYDLgMMfpjJ7Ii+7e2oV3/UJz
         LK1cwyLOWm4m6UD9fAqb9Tp2vsz/Mlcq1ecROof7lp4vLKpQywei9VkN4cZ2x6qtfS/z
         sCLOhmNp0qDjOMnSzdB9hQ5u8TfTZgeCDyZGS/c3wfmFGvumYzmaj6PwG0ATbakFjTIq
         D0UKze87COKIFm3KgL7dBkzRXE5UfyAmTb1Kdt78ez54jxsYqLwHxbE9vhbu2+H/BQBB
         qmBA==
X-Gm-Message-State: ANoB5plb9eiERx1AFUWhW4ozNf4nNsl0GnAFFhvurvI1w1qKSBuYen7c
        tuGR6fhDP704UKJs/D+4SOE5WXpiX+0jFA==
X-Google-Smtp-Source: AA0mqf798P1un3ZlccJ/ZW9c7Ccen0s5eOxieRgEb4YZGiD71u5q0OK2CiOgpMhEUQHmNREv7H+ySQ==
X-Received: by 2002:a17:902:d38c:b0:186:aed3:3ab7 with SMTP id e12-20020a170902d38c00b00186aed33ab7mr1512173pld.88.1668470493277;
        Mon, 14 Nov 2022 16:01:33 -0800 (PST)
Received: from localhost ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id b6-20020a170902650600b00185480a85f1sm8091551plk.285.2022.11.14.16.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 16:01:32 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v1 0/7] Dynptr refactorings
Date:   Tue, 15 Nov 2022 05:31:23 +0530
Message-Id: <20221115000130.1967465-1-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2139; i=memxor@gmail.com; h=from:subject; bh=LAlEw6WC/DYOwmsJypbyd67XVPIPDzKS08rdL3I+6+o=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjctaCALxlgpGdzSrUNxTI/HAjbxDpVMKojXtsHaBT vQEZq4mJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3LWggAKCRBM4MiGSL8RytM2D/ wPCdkgxUWJMVFtPDfUToik5YyZtqZ25QjgKd8nANUMraC8wo48OVUKQlhE1W52zHqkbnZ2KCyXg2SV 2I41QN+uarvO9YQt85zN8V4VklpeJsUk1wCwqlywpv0m3oANp9PvGfv/bUhXYbKeUpcTpRWC6/eT8P 2Ezwq5Owpq1g9yqRaZyVuE5ZMMZs08UVmdQdA+MEKIxV5avsZTcp7/v+4hQ5N8Azyp0Pde7zws1qW7 cJ/V/LFg8B9IGReh7SI/uSSbvLCfkTDcGlEjkvm3C6RLyAaxoTeBMeVFZkqE7q/qC3MzPyQDUcDg/J pHy3Jqrf9tL+wsXG7ufvOAA7hUvofsEOlob9X9Yp/ME/dby+ov5lrifTOV1Gp4c4mv3hbx/lj7Malv 1jXUky0P7hjpZyH8DDMLj47i58ZiuSZov8u7kkxJU9lL04cNUK8E5GI0GC5+GSODwog/i3P7wQtPlI kd8Gq+JGxietR2GuAXgkriMjz+Wxa+jzdkCdDNZ18G1rXfRJXMj6r01W4+BlIZNlCd35HZ8gIkgZWj EzWPl2AaqrPN4P6Fc8kKGjTLuPERaA8+yGK5QhzHYhquTmLxGgT4ob5ezReUhLRhBuV+PXqPM0ZOUU ddUp1sCh2MGHsf+yrglgrNs9JN2S2q+6bCqhlCcDw0tJ1Ey2bxtWB5gxjFiA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is part 1 of https://lore.kernel.org/bpf/20221018135920.726360-1-memxor@gmail.com.
This thread also gives some background on why the refactor is being done:
https://lore.kernel.org/bpf/CAEf4Bzb4beTHgVo+G+jehSj8oCeAjRbRcm6MRe=Gr+cajRBwEw@mail.gmail.com

As requested in patch 6 by Alexei, it only includes patches which
refactors the code, on top of which further fixes will be made in part
2. The refactor itself fixes another issue as a side effect. No
functional change is intended (except a few modified log messages).

Changelog:
----------
Fixes v1 -> v1:
Fixes v1: https://lore.kernel.org/bpf/20221018135920.726360-1-memxor@gmail.com

 * Collect acks from Joanne and David
 * Fix misc nits pointed out by Joanne, David
 * Split move of reg->off alignment check for dynptr into separate
   change (Alexei)

Kumar Kartikeya Dwivedi (7):
  bpf: Refactor ARG_PTR_TO_DYNPTR checks into process_dynptr_func
  bpf: Propagate errors from process_* checks in check_func_arg
  bpf: Rework process_dynptr_func
  bpf: Rework check_func_arg_reg_off
  bpf: Move PTR_TO_STACK alignment check to process_dynptr_func
  bpf: Use memmove for bpf_dynptr_{read,write}
  selftests/bpf: Add test for dynptr reinit in user_ringbuf callback

 include/linux/bpf.h                           |   4 +-
 include/linux/bpf_verifier.h                  |   8 +-
 include/uapi/linux/bpf.h                      |   8 +-
 kernel/bpf/btf.c                              |  22 +-
 kernel/bpf/helpers.c                          |  22 +-
 kernel/bpf/verifier.c                         | 416 ++++++++++++------
 scripts/bpf_doc.py                            |   1 +
 tools/include/uapi/linux/bpf.h                |   8 +-
 .../bpf/prog_tests/kfunc_dynptr_param.c       |   5 +-
 .../selftests/bpf/prog_tests/user_ringbuf.c   |  12 +-
 .../bpf/progs/test_kfunc_dynptr_param.c       |  12 -
 .../selftests/bpf/progs/user_ringbuf_fail.c   |  35 ++
 .../testing/selftests/bpf/verifier/ringbuf.c  |   2 +-
 13 files changed, 355 insertions(+), 200 deletions(-)


base-commit: de763fbb2c5bfad1ab7c4232e6a804726f0b0744
-- 
2.38.1

