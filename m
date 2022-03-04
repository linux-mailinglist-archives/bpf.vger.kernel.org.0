Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091AD4CDD41
	for <lists+bpf@lfdr.de>; Fri,  4 Mar 2022 20:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiCDTR6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Mar 2022 14:17:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiCDTR6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Mar 2022 14:17:58 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE76230642
        for <bpf@vger.kernel.org>; Fri,  4 Mar 2022 11:17:02 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2dc7bdd666fso8981037b3.7
        for <bpf@vger.kernel.org>; Fri, 04 Mar 2022 11:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=IxNp8MQ4HCRFIvP11emQ2z25NS71pXoGSK9qPcyp44M=;
        b=Rq3pK/J9PYjHj7EZTQFlriXWQVxhw2jTAFZngeW9YybBbNGjsxaGgtrE/LDefs7cJW
         X1IACm9063uBiU45YeEvRK+HRaMeyYaojTMychd114JBwSRXSfs+bovhwso0yuSrp5dy
         G54qGSewfjKYE6z2xM72JDsJZJ0ydSD9pwMt4FNLGJZNFznJTlpR49CVWEqpKEx9Bdzi
         0QADkt2Prye9CQMOb31fYBPXxgfZVadydBFcVF8J6AcDzboHUmwiks/j8O53DvWJ/8mc
         QAoTxfMVMskxfoTSd1ifNU63zNo1IGT0McUwQWV3PogKaJJ8xrE9zNHokWkY9ZPsYPL+
         WPxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=IxNp8MQ4HCRFIvP11emQ2z25NS71pXoGSK9qPcyp44M=;
        b=Xw/w+5kpr2hWHjs54isOmt8jsCSP3sRWhMIESzRdF9KPAcmP37N6n0bqDgnsV1x9tj
         YObPTHgN6BFFGtd7asZCInJVB5zn23mVv0+OKvfBHG4UioUCnnQrbTADv6U4avgSbtRG
         1yjEeGWedg4Awv9Dm4s2eRZhjV/lUfvPtW8xY1cuURR8jKQv7iBhRv+HqS8YuXKH/qi3
         /s/y4KwhZ5IkgEU+TCb9AQNSKckq3zCXquX0tlqSNMbebKqSfo2UY9Ua3hHLG10QQP0l
         UoB1kdB4vLpD97GtP4vNge/sJaKgoRAeCzLVsN+ya2N+ERcdqr07IqYXhyj/btr1qt52
         C4iQ==
X-Gm-Message-State: AOAM5319+uzjb6f8WYmzWlieW8rM1BpQRF5xO7XKr08L+zmqY5nbXrSn
        0KvrPkJBsfos7LByBDVU0s3Ij3Sq190=
X-Google-Smtp-Source: ABdhPJymC0imeUboMa0us5If78b0rfW4ONBm4r/jST2seN5TYB9KwOfds8x3uflLhCK1xkJTPI8l+XnmeDg=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:d204:6f81:5498:9251])
 (user=haoluo job=sendgmr) by 2002:a5b:b90:0:b0:628:e398:c602 with SMTP id
 l16-20020a5b0b90000000b00628e398c602mr4449747ybq.272.1646421421268; Fri, 04
 Mar 2022 11:17:01 -0800 (PST)
Date:   Fri,  4 Mar 2022 11:16:53 -0800
Message-Id: <20220304191657.981240-1-haoluo@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH bpf-next v1 0/4] bpf: add __percpu tagging in vmlinux BTF
From:   Hao Luo <haoluo@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, yhs@fb.com
Cc:     acme@kernel.org, KP Singh <kpsingh@kernel.org>,
        bpf@vger.kernel.org, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patchset is very much similar to Yonghong's patchset on adding
__user tagging [1], where a "user" btf_type_tag was introduced to
describe __user memory pointers. Similar approach can be applied on
__percpu pointers. The __percpu attribute in kernel is used to identify
pointers that point to memory allocated in percpu region. Normally,
accessing __percpu memory requires using special functions like
per_cpu_ptr() etc. Directly accessing __percpu pointer is meaningless.

Currently vmlinux BTF does not have a way to differentiate a __percpu
pointer from a regular pointer. So BPF programs are allowed to load
__percpu memory directly, which is an incorrect behavior.

With the previous work that encodes __user information in BTF, a nice
framework has been set up to allow us to encode __percpu information in
BTF and let the verifier to reject programs that try to directly access
percpu pointer. Previously, there is a PTR_TO_PERCPU_BTF_ID reg type which
is used to represent those percpu static variables in the kernel. Pahole
is able to collect variables that are stored in ".data..percpu" section
in the kernel image and emit BTF information for those variables. The
bpf_per_cpu_ptr() and bpf_this_cpu_ptr() helper functions were added to
access these variables. Now with __percpu information, we can tag those
__percpu fields in a struct (such as cgroup->rstat_cpu) and allow the
pair of bpf percpu helpers to access them as well.

In addition to adding __percpu tagging, this patchset also fixes a
harmless bug in the previous patch that introduced __user. Patch 01/04
is for that. Patch 02/04 adds the new attribute "percpu". Patch 03/04
adds MEM_PERCPU tag for PTR_TO_BTF_ID and replaces PTR_TO_PERCPU_BTF_ID
with (BTF_ID | MEM_PERCPU). Patch 04/04 refactors the btf_tag test a bit
and adds tests for percpu tag.

Like [1], the minimal requirements for btf_type_tag is clang (>=
clang14) and pahole (>= 1.23).

[1] https://lore.kernel.org/bpf/20211220015110.3rqxk5qwub3pa2gh@ast-mbp.dhcp.thefacebook.com/t/

Hao Luo (4):
  bpf: Fix checking PTR_TO_BTF_ID in check_mem_access
  compiler_types: define __percpu as __attribute__((btf_type_tag("percpu")))
  bpf: Reject programs that try to load __percpu memory.
  selftests/bpf: Add a test for btf_type_tag "percpu"

 include/linux/bpf.h                           |  11 +-
 include/linux/compiler_types.h                |   7 +-
 kernel/bpf/btf.c                              |   8 +-
 kernel/bpf/verifier.c                         |  27 +--
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  17 ++
 .../selftests/bpf/prog_tests/btf_tag.c        | 164 ++++++++++++++----
 .../selftests/bpf/progs/btf_type_tag_percpu.c |  66 +++++++
 7 files changed, 256 insertions(+), 44 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/btf_type_tag_percpu.c

-- 
2.35.1.616.g0bdcbb4464-goog

