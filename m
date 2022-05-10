Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F32522630
	for <lists+bpf@lfdr.de>; Tue, 10 May 2022 23:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbiEJVQz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 May 2022 17:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbiEJVQx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 May 2022 17:16:53 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170D450B32
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 14:16:53 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id s16so51946pgs.3
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 14:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lwhrBDehwhwPFD6VTQ8rfg9g9/HXKG2cxogvWTtsbWA=;
        b=BFWYiWeg0CKIoXYWO5sbSr9dX4kKf9KRxz48NJClb5HP0YEp0Yy9dRqgnq5bYlLEOF
         wb9ZF/oI/DVmdKYtoTHgvFA1jB9oese1pn9haef7isS6tnKH3wc35NQQw7bOh1y9Lzpb
         14R0fdahf6Q0K318pbxvO2c3C2+KPYzVhozLb9LjAQ7EQWuYqxX2AzEdXTgWrOP+b0IX
         HM4+sVomMehc0V3rjfHqj2Piy/RxVfgpwxFy8aEADgqzA0mD9fg3nw1HAIcKWJEStRuS
         vWnmf4MUr3mHiGme8BuDuaKkejGjzB+Bm1rkZKYJTurKnFNLeUjwNaADXsP6ccIS7Nq1
         j04g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lwhrBDehwhwPFD6VTQ8rfg9g9/HXKG2cxogvWTtsbWA=;
        b=jTIvYGn9IQ66VmPkLOEj8cN2hqCog6yR8Izxb1tfAjZlvGu0M3F4PMrBlvK6dSL7O1
         kEsRceCP07OItY3QdsXh9IX7SHceJhPK3hAJZ1OnJB61fNS6lHVCzHixtsHZs1IasTIf
         gNkfcivuLtUoHeo3iDwNL4EBA1HkPNvFB/T9JIErqwYFaxRMvQeOE4NbMWr+IBbp7QSr
         cIwyjzUqEU23+S9q4SgG3MxXMQ1MZaJ6pCDh1aCS89/UDdoHp6GFg5KB3tebGl+ZZaDT
         UnbRh7CvoCyjSciIHPv0c+G9DOPC75iQrsbyMWPXLXL/LnXHfm5CCik4BhptVyD/orDj
         miNw==
X-Gm-Message-State: AOAM533BfVduPgRh5T0tz3PwT4/NMfwWdKQ/KdVbbJYSw0UPUeTN8N9w
        BVQCqskrrfwXgCJpGaJBWe3NOI702vM=
X-Google-Smtp-Source: ABdhPJyE29UQtpFuf1J/ePnbl/aSUh4hipBIOZjuIf3MQb0MgvN5BuT7ErOEkueB4almQgVsD18AIw==
X-Received: by 2002:a05:6a00:a8b:b0:4e1:52db:9e5c with SMTP id b11-20020a056a000a8b00b004e152db9e5cmr22297580pfl.38.1652217412359;
        Tue, 10 May 2022 14:16:52 -0700 (PDT)
Received: from localhost ([112.79.164.242])
        by smtp.gmail.com with ESMTPSA id g30-20020aa79f1e000000b0050dc76281b1sm4695pfr.139.2022.05.10.14.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 14:16:51 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v1 0/4] Follow ups for kptr series
Date:   Wed, 11 May 2022 02:47:23 +0530
Message-Id: <20220510211727.575686-1-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=916; h=from:subject; bh=NEwy0l0ILuFlwdkZkhKVeO8K7hYcmu0dva+rGWTWTdE=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBietZjix2A1i1Y4GMrx1WH6wEM0xncKdTOgpmQmiS6 MB0oEK+JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYnrWYwAKCRBM4MiGSL8Ryvt6EA CyfxuCrrwUaD11hJ5TdERZfyDnpQdgVznj2PPQv7GLjiXldKRkXff6BebqCdqogv7BdPZMDu0YqQW4 MqT/VNtPRxiB/ndu7AsHYUYIx6pCxH/m/l5OaPDYNGppsmG7vtPPqgayjS09NTdC3jAB3aG+0olpBX j8iCwJe8GjU86AbTfg3KR0InGt3n6toVvUgcupyRbgYfYH4NSfVFoNpn8GKe4SfPPqXCK06EXpbwMu bD3cLxtAU/QUSO0+cl40Qo2AkKCKH5VoMWIygb4D02FTo8JPO1H0HU1DJIzKyt8GBOo3TybM0xqcix 95+SZi1HdSXvK3YnwFIxAz/T60myClinEdiIhOUiDNQzERzAXZz3EiNUuwy1IBCbBIsZavmdAuR6sa evLkAwMNiL+8ripR2jAI0Ub5IjYZtPRIj1VpC3Khbv2vk1lw6/5EuB+LyRbdb0m0Qm3r8xx76VIdNv PWtLimInGDOjrlHQLeYgATgCrFIqNYNEbMiMsHGN+LRJghUaJTTJj6I476YbQz1CntxhpQr+nW5AJZ M4oQNAwPKmNQMrpUe2OLXXlqMVUnqi+TTJf5lWF9HqovucWI9XTGEoTATatYMNoIg6H5+KCpWLzACV 8iVKf5J3FKC4yDjYtXS2tOW/x+BJ0KQof4HcHOPffIKqLUHmBmrLXY6rKolg==
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

Fix a build time warning, and address comments from Alexei on the merged version
[0].

  [0]: https://lore.kernel.org/bpf/20220424214901.2743946-1-memxor@gmail.com

Kumar Kartikeya Dwivedi (4):
  bpf: Fix sparse warning for bpf_kptr_xchg_proto
  bpf: Prepare prog_test_struct kfuncs for runtime tests
  selftests/bpf: Add negative C tests for kptrs
  selftests/bpf: Add tests for kptr_ref refcounting

 include/linux/bpf.h                           |   1 +
 net/bpf/test_run.c                            |  32 +-
 .../selftests/bpf/prog_tests/map_kptr.c       | 109 ++++-
 tools/testing/selftests/bpf/progs/map_kptr.c  | 109 ++++-
 .../selftests/bpf/progs/map_kptr_fail.c       | 419 ++++++++++++++++++
 .../testing/selftests/bpf/verifier/map_kptr.c |   4 +-
 6 files changed, 660 insertions(+), 14 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/map_kptr_fail.c

-- 
2.35.1

