Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC72B646280
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 21:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiLGUlq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 15:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiLGUlp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 15:41:45 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B293AC11
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 12:41:44 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id 3-20020a17090a098300b00219041dcbe9so2864143pjo.3
        for <bpf@vger.kernel.org>; Wed, 07 Dec 2022 12:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/QRsrGNR0u61CS0OYf1SpBcRIiqlq0WEghReUjrHRg=;
        b=Ejm42721JvlGwUoDweJKILYV/qgeKL3g1owAhNsVdq6NCBUeR4x2+yaI51n7uaAoB+
         FZsaQ0rSJcYuz1jj2VLHpSCa1tujdM/K5EttzJmvioQj1mX39rIhpiseAQ7DfMp1A08X
         lBTooB9Lpxj5WtSrWJhEnjq8dhoAGmIROE3plYdElDlBL8IIb4gu670YSniffDwMxYQx
         tOS9MCLjq8GD4LqWRjo3wf0M3ud/ALFLwGNwQSFohfajCCjtP0EJk8egSThxPPix8B+S
         7MSItmgpyIpWtQOes8h3r+7fg6AVWFFh09wJu7xDIj/EqmVVyTme1LrExpNwcNTGBoCr
         ULVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y/QRsrGNR0u61CS0OYf1SpBcRIiqlq0WEghReUjrHRg=;
        b=l0VE1qs08mLNWx0ApNq3t8Asr+jnjG6tiYESJrFtPaknwLRT+lVzcHyAEkonQQAaCP
         dm1a9jZqeqNLdR9uGESVGFSuF4D8Sr6b1xxjtScFx0f4RmwjyY22jM8ORyqASnx+nhS2
         WoGCNK5U7zsOZ5/xssK+CMJnZO8vbBB4DfXPH0+q5/I3qNewH1/y1WRU3Ur6cAsUBkAX
         ORZPeX2/0drMNsursWCxfmBhiLcyikrHNkQFxQ0OHL6IcoiSiwOu9ee2wrbqLUrg30WQ
         otiJCLX4tE+icryI66ynhzqmnaFCCKgJVJ9xnP2NvgAMXBzt7+zeM6HuHa3FS8GPW1GA
         o4+g==
X-Gm-Message-State: ANoB5pnfncqldb6zHKSfrpoiSky6yNEDCIe7N0PaXYnNlRuVBeiUMZNF
        zImxkNfn1Anfj1mb1SKoar8wx8yerr4Bhf03
X-Google-Smtp-Source: AA0mqf7OHFOpjDtxy7soUnXVx5qvV6rUx7DZ7KVlwlxvyXVKbTgSAKXG51snHQ2oL2t6LZ3+3Y9rsw==
X-Received: by 2002:a17:902:ec8d:b0:188:59d2:33e with SMTP id x13-20020a170902ec8d00b0018859d2033emr73829786plg.142.1670445704128;
        Wed, 07 Dec 2022 12:41:44 -0800 (PST)
Received: from localhost ([2405:201:6014:d8bc:6259:1a87:ebdd:30a7])
        by smtp.gmail.com with ESMTPSA id a20-20020a631a54000000b0046ec7beb53esm5175573pgm.8.2022.12.07.12.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 12:41:43 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v2 0/7] Dynptr refactorings
Date:   Thu,  8 Dec 2022 02:11:34 +0530
Message-Id: <20221207204141.308952-1-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2280; i=memxor@gmail.com; h=from:subject; bh=JjgwGgkEyS84X4UfQSTQHIuwEviQSc7eNfFGT8ES7ng=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjkPOodNGGvT7lHdaNW3y1DmMpun4qGH5nZUedeP+O Wgc3d7qJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY5DzqAAKCRBM4MiGSL8RyptGEA CZqprMS+9AouYHHGxSdPlI8llpFE0xR3dKffU8pz3c6k41/UnYgap5rHJ9Pnd+BcC3YjEBw3eDMC6N cT0GbYf+4+JAlBE+djxUai0BoruINJtQFxH/lLZG5fqs0h7BontVE4pBbPkWgqhueTIGLUV3C+MbBf MrrfNk/zLEqDjWUSOJpqL/ydceMDNiseEIeeUxo1R74r4w99FowfNaKQ6Zf382Apx6yTzV5Gzsfdm3 gxO8V20PoaJXnvvxYxgi9bS2F3mooS0qqB4C9w0IGGPI7FEIMuoKhGdFprxfG0uYpqna3/QDsS5i7A rG02w/Qah6JnWyyQUqeMVtiChHg97OEfjrXZxM+JD+vIr5AaSNYScJapxnT+zTd+ZQH49w/vBbS8Gl 6BaQHCiQY/eZ6pHyRiwBCuG7lfVRAxXPyRDdgXgXZT4dkhHCyFyZa8utmryRezePsYS2dZBmCaMkKV RXIGVFQI9w8SWHt8VHtqKLL+Afe3eeWm4crWLvgeHpr7CvhtlAaszIiXW9+pvxYUr5LXS07/KP/68b H8+cFWYNmJXF1qCJc0OlD/9HAnchGEK/Lr851iFxEWLEh60LugkDJ53xtEXE74rVCtJ0LRlGFq993v TCaOL5TVkHoRHuBz3oewNcLhrfnovmxyN2+rY00ensc4VIfgfQaz4lfgtvCg==
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
v1 -> v2
v1: https://lore.kernel.org/bpf/20221115000130.1967465-1-memxor@gmail.com

 * Address feedback from Joanne and David, add acks

Fixes v1 -> v1
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
 kernel/bpf/helpers.c                          |  30 +-
 kernel/bpf/verifier.c                         | 435 ++++++++++++------
 scripts/bpf_doc.py                            |   1 +
 tools/include/uapi/linux/bpf.h                |   8 +-
 .../bpf/prog_tests/kfunc_dynptr_param.c       |   7 +-
 .../selftests/bpf/prog_tests/user_ringbuf.c   |   6 +-
 .../bpf/progs/test_kfunc_dynptr_param.c       |  12 -
 .../selftests/bpf/progs/user_ringbuf_fail.c   |  51 +-
 tools/testing/selftests/bpf/verifier/calls.c  |   2 +-
 .../testing/selftests/bpf/verifier/ringbuf.c  |   2 +-
 13 files changed, 371 insertions(+), 203 deletions(-)


base-commit: e9b4aeed56699b469206d05e706ddf2db95700a9
-- 
2.38.1

