Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6C144AEAB4
	for <lists+bpf@lfdr.de>; Wed,  9 Feb 2022 08:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbiBIHDY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Feb 2022 02:03:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbiBIHDX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Feb 2022 02:03:23 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E66C0613CB
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 23:03:27 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id i6so801671pfc.9
        for <bpf@vger.kernel.org>; Tue, 08 Feb 2022 23:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q93gW/qcEN4l9K/ayHLJYW7hoUkys19rBhyfPChVlbY=;
        b=ZMcVcdjUY+tJu2iR+vS+YDqFC/OJ0scxmlQwGy+7LDQh+rqMAckHEXvX3UQd6boIUR
         6zwiBkKYWQOeG+vtjq2MRsqXb92xIZMPgBGHMN4Lgfm1hZF0PY5w79NettJOiLTJk2hT
         MahoxkIfRmUs+NO6vHpV3jVqeFmm2JyZ3dpWxb825IcTxCgfD0B79ZkMCwi4MFPEomfa
         Qb5e9j2Qp9Huc33hHO8jbi3t+u2W05GkHZP1Y1AVvH6RY69Wrwj35w8mG8zwUF/JAxio
         Dv9inKrIA0n4j8s/cslZe8FH7Qtu44ETN9Ccf4wLxp7EJToGR9xoizG+J1xYFofUHuaJ
         8QLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q93gW/qcEN4l9K/ayHLJYW7hoUkys19rBhyfPChVlbY=;
        b=Zq3VbMuX3Fq8WVq2Y0qq+y5sy1xhpia8EaVL00LpHuUf0rKOzey8e5IOdKzg+ge+Zk
         BXp/T5sqpVfYrRWrsONOPT/dlVbghYONqvvWJu/OV9OzYLH6eoC/mU+6bxKNYWRBgg6H
         yU+X08dEsN0kknzvFvrZne4N/PcxSIr7LvmBlS5Hq+DmyaiZ7q/WzNAfG5uDWLgHTqeW
         vXanOijyDiT3eOotN8kiwvpGxYwTUympEw4Des6Qvr6JynQnkyPp12UM+Ria+EhAYO5f
         IIduGto8N2+qjeorcxuYnWQ4YyCoPFRLjGT4yLTCHJDuiz8Wf/kkKeqRKsocpSG3GhmX
         hXsA==
X-Gm-Message-State: AOAM5322/FYcQVu7S5+SUcpALfacAs80P6H53xuvJNkvsw/RVuOt/4eF
        +KbeRYvUQuC2LAOo618fHf74Tfad2SQ=
X-Google-Smtp-Source: ABdhPJyRq2qADzw0qk5ju3CG99Dwh9Rb0u0yHIR98We2ShWJFgDAt08bTAT4eoQITdRQK1qil/j4Yg==
X-Received: by 2002:a65:48cc:: with SMTP id o12mr854461pgs.220.1644390207073;
        Tue, 08 Feb 2022 23:03:27 -0800 (PST)
Received: from localhost ([2405:201:6014:d064:3d4e:6265:800c:dc84])
        by smtp.gmail.com with ESMTPSA id f12sm13437228pgg.35.2022.02.08.23.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 23:03:26 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf v2 0/2] Fix for crash due to overwrite in copy_map_value
Date:   Wed,  9 Feb 2022 12:33:22 +0530
Message-Id: <20220209070324.1093182-1-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1125; h=from:subject; bh=EaZLhBaxVAxj8M8tzHFNFqLzUNbT3GXJinUDv3nKQSs=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiA2cPpdYJqz3znYk38KMzNlYBFuwEAXrkhobZ0awS +M7Vd/GJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYgNnDwAKCRBM4MiGSL8RylpGD/ 0RGsSho+ZZ7uoGdr52Ps8CR6NBnSuH7iz/1TItbS6PXhuXDeELycktJD/d4j8LJyeLZzeqCFD5t1ey hIkBFjMXvpBbBH9yHBxS6GQw/z19OmxA6+S4hwosgk1vMH28TNYSoL6MFhZsv8i4h5Niq8WSIu53L/ u6b/X76lB53UBUJ+qlHeq9YdC74zxvZrjfZRh/vblLAhl9eyprfX1trh4iZjLW9qqaXuT44mR3jjzx TWJdK03GPaFIb+udMSzdPzAmGYTuIPktnykYqyJtUlRNhK47hIeztbLJI75TkuwCLx8PanPvS3OX+g Bs1f/pMx5b89xKbyz3tCqodf2uktAq17YPWV7tTbNt6VJ8T04AvZ+EIM6Aw7CcKgcDqGe1d3U6rDks iwReujqU4yAT/JxNFMGAvTRt3LT1uzvw3CGrl3/VaTyuUKIg00Ky4pIfIWC1fFXQEuVldSM7ComFz0 kjvxUkReluwlex7hVV7rzwFfdaHFvUikh1WP1WlFiDV+eyGSunI4Vfb8c9/gBd9hrVEUwzhVr6oK+c uSzlo5r3ZWZqJcg2ZdYajRVmUz4RA3YRUT4DHgfDWfuOD4L44xhsT4n0ZvWiyc71Oa7d7B+/VUsIPy nIbJxIPRSmie2sIHCYBOzyslSU3ojRyK8ibMP4WjsoX3gFANMizS2/B7w1RQ==
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

A fix for an oversight in copy_map_value that leads to kernel crash.

Also, a question for BPF developers:
It seems in arraymap.c, we always do check_and_free_timer_in_array after we do
copy_map_value in map_update_elem callback, but the same is not done for
hashtab.c. Is there a specific reason for this difference in behavior, or did I
miss that it happens for hashtab.c as well?

Changlog:
---------
v1 -> v2:
v1: https://lore.kernel.org/bpf/20220209051113.870717-1-memxor@gmail.com

 * Fix build error for selftests patch due to missing SYS_PREFIX in bpf tree

Kumar Kartikeya Dwivedi (2):
  bpf: Fix crash due to incorrect copy_map_value
  selftests/bpf: Add test for bpf_timer overwriting crash

 include/linux/bpf.h                           |  3 +-
 .../selftests/bpf/prog_tests/timer_crash.c    | 32 +++++++++++
 .../testing/selftests/bpf/progs/timer_crash.c | 54 +++++++++++++++++++
 3 files changed, 88 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/timer_crash.c
 create mode 100644 tools/testing/selftests/bpf/progs/timer_crash.c

-- 
2.35.1

