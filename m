Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D3458DA0E
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 16:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbiHIOGW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 10:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbiHIOGV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 10:06:21 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8A212755
        for <bpf@vger.kernel.org>; Tue,  9 Aug 2022 07:06:20 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id f22so15228699edc.7
        for <bpf@vger.kernel.org>; Tue, 09 Aug 2022 07:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=uVZnh+8PElTigH/D9GaGAlj5KxKjP9QxqHJkG/Q/IEo=;
        b=dHYRKqASk5s9T5KgemoIDqT2Q0SvbhfLBwjd/zZB8MdudgbJbQ91qjBdM0s10O/2l4
         ZNpWMxZ+wtTcOq5G+pJ8NR5FjsSCK4Exf6KGDQO3OLxU16ov3W7z5zQVLwCPtj1J97uX
         RCKkZFD7qQKUuGr85s2I+Me4atYmzSVh+KaFGJBiEgecMcBD3mz5b88nHHk4SXJMmaNS
         0YCYfIyDGLKzFkZVsmIUSa6bMyj91/jxLhgIIOrh6KfUGqfwsTMO0StSfux7l/0Hbhfo
         veyLalmaiR6lCF7R2muORLA9lB/0eWxWkoMiPFUVGB+YZZJT+jfOA0jpWkpuxamTOB3m
         Ul3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=uVZnh+8PElTigH/D9GaGAlj5KxKjP9QxqHJkG/Q/IEo=;
        b=Tym1P708huvUQNEblaCo/2t7Gb0r5zQA8iZYoUNPAPfCvHOH4gZ2BwL8d5PM7tzI7I
         SxRHVGVz0DkjXYJkNCG9KKgcH9dOncMWC9ZddmKoSIO6mBre95l8BwafKdJxfqStjw74
         Pvwy/HC97dbUzPd94qcYNNTo86gKuuAGHfVo9bq1rq4QqKQ0eWP1zA8VfqtBn23I145S
         dbng5qMGtMx1O3f1JnziPwL6aSI77EZGzdcNd3/2gij/Z0B4mePXGDXJvrLQNXxH6i+S
         9AsUesYLjybKj5US3jVFLnu45g/1g86gLtINaqRCQedM7R4fuYFTLDXUTDvcBt0ulUi4
         5JRQ==
X-Gm-Message-State: ACgBeo0qXWofmJd7KL7NSZT6aTAVFudOoP+8HkcAebyNuJIl1nhTtXPm
        ey/t2Td5HwqvwTIyapIFZ+GM3TrYMLM=
X-Google-Smtp-Source: AA6agR6iILZp+fLTduEb5oKRULrrDnRzgiErI2KDJ+GV/h9Ize94UG0XYT//zEOLbvDo63HrlaexuQ==
X-Received: by 2002:a50:ed82:0:b0:43d:5334:9d19 with SMTP id h2-20020a50ed82000000b0043d53349d19mr21577839edr.232.1660053978592;
        Tue, 09 Aug 2022 07:06:18 -0700 (PDT)
Received: from localhost (icdhcp-1-189.epfl.ch. [128.178.116.189])
        by smtp.gmail.com with ESMTPSA id h7-20020aa7c607000000b0043d7ff1e3bcsm6126918edq.72.2022.08.09.07.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 07:06:18 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf v2 0/3] Don't reinit map value in prealloc_lru_pop
Date:   Tue,  9 Aug 2022 16:06:12 +0200
Message-Id: <20220809140615.21231-1-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1027; i=memxor@gmail.com; h=from:subject; bh=ee6mvB8t+LkarZTbcLYgAtUkgnrV4KGjsiFcYmYfmYk=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBi8mm8oBorjvMNwZc9F3fQAgJxVt8+YWNaclvLFJbu /bdDrrWJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYvJpvAAKCRBM4MiGSL8Ryr37D/ 92qk1FCACTV7M5O1aO3qJlgy6nocA0qmTCC4tXdyDEf6vXMpqNgqMnhFCorhojJsdiAbD1z5pMvq8g dx48R72/Cs/QP6NrczIm55Igo7r0HJmNl9wvsm3DSkObNj+4zOrBNk6WRpUjgh3EOK546VDECF/lkw HkFBnrqC+Ag63Pa8lQk+hnDFeeG/YH3zmvtwhDwxyoVkJrAX3UfJluv0kCsKvsts6GmkCmQwuGJ41V ja42tjHn7nmwK2+oguNzjhRV/StyyuHxlBFY9kNhDBLTls/fU8RWHpCMdL7uMHAoSf0eM81STDBS/9 P0yuymdfYsiX9vn4p1H9qg9CCOMEqICeslRMELALRN4B4pdB2qP1rPrKo8UeQYAD/vU5Nym7tF2+/N AEzcKWzBcr1tLOvRKYsDqtTyTTuG5+pqVhkfsbqeaMj/sIYeZHy1C/qKFLkCOCSi0B0/4qFG+YC2lc I/sINznG5r4Ps1VHaUY+2ZhFCxdiNcZQcWnWNLskiWfCcWKu0v5fpF/CRylegUeBZg93rWyiTd8ybW QWnUT/rYhAOBBWalP6STnLKAQHEdoLV8FKcFtKeaoPJmOLFJJTdqOabY1lZVSu4/QJObthKz+BAAvB xI6kFz/NVDBpE7Vaptlfk2ohdomt0hYYjvRYXFOWRmKMz5ts8Rskeug8rsfQ==
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

Fix for a bug in prelloc_lru_pop spotted while reading the code, then a test +
example that checks whether it is fixed.

Changelog:
----------
v1 -> v2:
v1: https://lore.kernel.org/bpf/20220806014603.1771-1-memxor@gmail.com

 * Expand commit log to include summary of the discussion with Yonghong
 * Make lru_bug selftest serial to not mess up refcount for map_kptr test

Kumar Kartikeya Dwivedi (3):
  bpf: Allow calling bpf_prog_test kfuncs in tracing programs
  bpf: Don't reinit map value in prealloc_lru_pop
  selftests/bpf: Add test for prealloc_lru_pop bug

 kernel/bpf/hashtab.c                          |  6 +-
 net/bpf/test_run.c                            |  1 +
 .../selftests/bpf/prog_tests/lru_bug.c        | 19 ++++++
 tools/testing/selftests/bpf/progs/lru_bug.c   | 67 +++++++++++++++++++
 4 files changed, 88 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/lru_bug.c
 create mode 100644 tools/testing/selftests/bpf/progs/lru_bug.c

-- 
2.34.1

