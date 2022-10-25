Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30EC60D6C7
	for <lists+bpf@lfdr.de>; Wed, 26 Oct 2022 00:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbiJYWIH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Oct 2022 18:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbiJYWIG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Oct 2022 18:08:06 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D6341D29;
        Tue, 25 Oct 2022 15:08:05 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id y16so12937659wrt.12;
        Tue, 25 Oct 2022 15:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dcRnBeVMfWhbLB2yLT2Qxa0N4H+xVodTxEacHRGhbA4=;
        b=frwZxaZoR1grpWe3fagqp1YapkBtQETX66QrlzZw6YKiO5rkgS6bZx9mSSh+Tqe02X
         mi9sj5Lp7Ao9iqMl4MCD4Wsjou1c1wtX8NjN9zwVhtJE9IA0Y5dtt55iHzTT5SddQSsP
         DLa4RoBTtI9DUgg0fZ7o1ymbNEAcKBCfsW6FMOA7E5ROETyFWdIPNZFEiAsH0C5+yMWl
         vINUsOpH/tRP3ZCJylpKZMbCaNCJ66fewhH5i2M7kNR1CQPJChwjRFT88MIiRg0SEyfH
         5XC5OOQc9E0yUFquJU0OgUDGuUNeudFB9EyDlb/eE96wghPIaCEZtfILZoRYFmYB6TtU
         Hi/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dcRnBeVMfWhbLB2yLT2Qxa0N4H+xVodTxEacHRGhbA4=;
        b=bepvhRyN24xwUrKi574dPvhfEWPuuM4ZnwoHbzCuztNXjeHVUSkT4Upmg2nE5+irSX
         c3rGW8AJyj/PmN1jrXetYcAEHDvQKzpYn1+0dzlTR9k3pTGFE4TvZ8ofK/d9VQanpcLm
         1tqbm3kCUKSVYNXYisymvNz3eVaifW9wCM8uYHmIJUfpo3eY0pROpnH6e6n/WjsII/JD
         tJ4+QX3zwQunU6RSoS8DaiSN6ZiHzJLhakmxZnw7QFCUq/4DLVyFHy3ecMPHwUu9lRzG
         LKifsts2+0/fpox8LLutxkhEYdySuKDL9lxASp6ZfRYANr7sUGr8pumXz2Vt/ohvgZ92
         o+Bg==
X-Gm-Message-State: ACrzQf1Vcg80FwvKmodGFCdbVXDlGfo3bPQnZ15IvbWicB3QbniNcNTv
        wBP2CoUyOip1WcFARUrDUxJ6gUgzPQn+tTNz
X-Google-Smtp-Source: AMsMyM5dwXDqrMEMaqDkM7SUgqf2WUYCERAYWK2+UHh9b3M1a21o3OgnLb4ppVQJKcUe516Pbxm4eg==
X-Received: by 2002:adf:d1e5:0:b0:234:2aaf:3b97 with SMTP id g5-20020adfd1e5000000b002342aaf3b97mr23226508wrd.536.1666735683684;
        Tue, 25 Oct 2022 15:08:03 -0700 (PDT)
Received: from pluto.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id x2-20020adff642000000b0022a3a887ceasm3657046wrp.49.2022.10.25.15.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 15:08:03 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     dwarves@vger.kernel.org, arnaldo.melo@gmail.com
Cc:     bpf@vger.kernel.org, kernel-team@fb.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [RFC dwarves 0/1] pahole: Save header guard names when --header_guards_db is passed
Date:   Wed, 26 Oct 2022 01:07:28 +0300
Message-Id: <20221025220729.2293891-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.34.1
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

This is a supporting change for a kernel RFC that should allow using
uapi headers with vmlinux.h. For this it is necessary to add
`#ifndef GUARD ... #ifdef` brackets around some types if those types
originate from uapi kernel headers.

For example:

include/uapi/linux/tcp.h:

  #ifndef _UAPI_LINUX_TCP_H
  #define _UAPI_LINUX_TCP_H
  ...
  union tcp_word_hdr {
	struct tcphdr hdr;
	__be32        words[5];
  };
  ...
  #endif /* _UAPI_LINUX_TCP_H */

vmlinux.h:

  ...
  #ifndef _UAPI_LINUX_TCP_H

  union tcp_word_hdr {
	struct tcphdr hdr;
	__be32 words[5];
  };

  #endif
  ...

The information about the GUARD names has to be encoded in BTF to
allow `bpftool` to generate it for a specific kernel binary.

This is achieved by adding a parameter `--header_guards_db` to pahole.
This parameter should point to a file that associates header file
names with names of a C pre-processor variables used as a double
include guards (dubbed as "header guard"s).

For each emitted type the DWARF attribute DW_AT_decl_file is checked,
when the file name is present in the header guards DB a fake
BTF_KIND_DECL_TAG record of the following form is emitted:
- type: the id of the emitted type;
- name_off: a string "header_guard:<guard>".

I'd like to cover this thing with a few unit tests but I don't see any
tests in the dwarves repository ([1]), could you please suggest the
right location?

I'm going to use a lore link to this thread in the kernel RFC email.
I will post a link to the kernel RFC as a reply in this thread as soon
as I have one. The change is not useful on it's own, so if kernel RFC
will not be accepted this one should not be accepted either.

Thanks,
Eduard

[1] https://github.com/acmel/dwarves

Eduard Zingerman (1):
  pahole: Save header guard names when --header_guards_db is passed

 btf_encoder.c | 103 ++++++++++++++++++++++++++++++++++++++++++++++----
 btf_encoder.h |   3 +-
 dutil.c       |  20 +++++++---
 dutil.h       |   1 +
 dwarves.h     |   1 +
 pahole.c      |  99 +++++++++++++++++++++++++++++++++++++++++++++++-
 6 files changed, 210 insertions(+), 17 deletions(-)

-- 
2.34.1

