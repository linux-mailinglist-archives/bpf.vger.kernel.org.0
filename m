Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAA974965CC
	for <lists+bpf@lfdr.de>; Fri, 21 Jan 2022 20:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiAUTkU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Jan 2022 14:40:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiAUTkU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Jan 2022 14:40:20 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A14C06173B
        for <bpf@vger.kernel.org>; Fri, 21 Jan 2022 11:40:19 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id e9-20020a05600c4e4900b0034d23cae3f0so23445310wmq.2
        for <bpf@vger.kernel.org>; Fri, 21 Jan 2022 11:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hqoz4jmFyFfzw5CsCwoF/S2fcGykUEFKhHw+Td37HFc=;
        b=DpogOUq/ggBER1UoHIzztDqhFrosPzsfHJl6OlWHo7jrfX/eavtfcEd49otJhPHnq/
         O2hSeSeVuc8qYaoM4xK4SdAZLCTZFpu+3y4Z+ktCtxNrHhrnLqit0bXAJ/rkkCoYB5F6
         77ApMXsig3OM546JkT1wf6P5aZxJO/pXbUdBSDoatRdQbfqmS+Pa4xSk3RKjtXPPJEkr
         DbBfEYFh53LDHRkXjzwzV18QOSt9mEfbJj8CToO+MzF0rErejmcfkr0oCw6GncZaySvV
         nujhnuamMPtsJ0LnZ7iTTYy4Q3/GVYln41LQCDVG8lK5I1h7MLqzYzX8v9MaXmJ5yCJ/
         /F8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hqoz4jmFyFfzw5CsCwoF/S2fcGykUEFKhHw+Td37HFc=;
        b=rropP89dcODFLhBGLSTgXD+ekpe9mpR0LTdK3UuUasrcflSZLuYo9X1mtZk4En4Bpe
         4eY3r87r7MmZEpCrSQZe6a/zPqaLdlGt65NaHOerMGc0ycEMQH9eC1zc8jE+5mN2QqHi
         Y+taxxm3wcvPl/ea/KVnuT/KwrnjfpApxex1F2fitK3msHHn1jq8w0waTpaESbcfiQAy
         C2YNh2YjT4uLBQqJ+xXybIfYZdDBmmh2UuLaDS0+9idpGRQs8s/hLQzHpnfPKOxCCYsn
         7KqUIpGgqSphWrLP5teNlaVfhbi4wLDoNjpAfpqHauNUzFDYNdMyQ5CGsa3oIlpAtzOf
         TXOg==
X-Gm-Message-State: AOAM531c2mLZ05Vw4BBKyMRKs8D3qweIUP9v/53LTC8ZW6nEmZ4wCYg5
        EY12WksE5+exIMqPy3ZShUBU1ek3bhQXvQ==
X-Google-Smtp-Source: ABdhPJy7uALdrhmKtkoOD1O7RJA3hfVsT9EF2k8VkJWKNgzjE0VLYLTBcwuCZayM9kFQPwn0Dj+XNg==
X-Received: by 2002:a7b:c5ce:: with SMTP id n14mr2059662wmk.11.1642794018220;
        Fri, 21 Jan 2022 11:40:18 -0800 (PST)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6d:f804:0:575f:679d:7c2f:fa19])
        by smtp.gmail.com with ESMTPSA id n14sm6988059wri.101.2022.01.21.11.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 11:40:17 -0800 (PST)
From:   Usama Arif <usama.arif@bytedance.com>
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii.nakryiko@gmail.com
Cc:     fam.zheng@bytedance.com, cong.wang@bytedance.com, song@kernel.org,
        Usama Arif <usama.arif@bytedance.com>
Subject: [RFC bpf-next 0/3] bpf: Introduce module helper functions
Date:   Fri, 21 Jan 2022 19:39:53 +0000
Message-Id: <20220121193956.198120-1-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patchset is a working prototype that adds support for calling helper
functions in eBPF applications that have been defined in a kernel module.

It would require further work including code refractoring (not included in
the patchset) to rename functions, data structures and variables that are
used for kfunc as well to be appropriately renamed for module helper usage.
If the idea of module helper functions and the approach used in this patchset
is acceptable to the bpf community, I can send a follow up patchset with the
code refractoring included to make it ready for review.

Module helpers are useful as:
- They support more argument and return types when compared to module
kfunc.
- This adds a way to have helper functions that would be too specialized
for a specific usecase to merge upstream, but are functions that can have
a constant API and can be maintained in-kernel modules.
- The number of in-kernel helpers have grown to a large number
(187 at the time of writing this commit). Having module helper functions
could possibly reduce the number of helper functions needing to be
in-kernel in the future and maintained upstream.

When the kernel module registers the helper, the module owner,
BTF id set of the function and function proto is stored as part of a
btf_mod_helper entry in a btf_mod_helper_list which is part of
struct btf. This entry can be removed in the unregister function
while exiting the module, and can be used by the bpf verifier to
check the helper call and get function proto.

This patchset also includes a very simple example selftest showing the
working of module helpers.

Usama Arif (3):
  bpf: btf: Introduce infrastructure for module helpers
  bpf: add support for module helpers in verifier
  selftests/bpf: add test for module helper

 include/linux/btf.h                           | 44 ++++++++++
 kernel/bpf/btf.c                              | 88 +++++++++++++++++++
 kernel/bpf/verifier.c                         | 50 ++++++++---
 tools/testing/selftests/bpf/Makefile          |  3 +-
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 21 +++++
 .../selftests/bpf/prog_tests/helper_module.c  | 59 +++++++++++++
 .../selftests/bpf/progs/test_helper_module.c  | 18 ++++
 7 files changed, 271 insertions(+), 12 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/helper_module.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_helper_module.c

-- 
2.25.1

