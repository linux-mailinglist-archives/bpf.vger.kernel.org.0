Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F894A91C4
	for <lists+bpf@lfdr.de>; Fri,  4 Feb 2022 01:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356310AbiBDAzm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Feb 2022 19:55:42 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:46950 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbiBDAzl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Feb 2022 19:55:41 -0500
Received: by mail-wr1-f48.google.com with SMTP id l25so8247242wrb.13;
        Thu, 03 Feb 2022 16:55:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5aqBFr0LokcPCX2JMr2RbKn4lhTxpGWYtRKhHIEIRvI=;
        b=DmP0vDvh246xQ/WW7FPmSDxgZWHq9l4AZGmbefGI3KAqaA5TVLv8NoZpG8ssbEQU1g
         cbIs7Gtj21j0L8X2ge6QYUmad6l0ITwNpiL+965wf3TChm2TMlOcC7fv0ryhldSgNofm
         Ro/x2L4ePveuXgpRkEo0PZx2oOL3yNBTj11EvwXXu/YhHMVTe5t48V1izhFyz11nHbBX
         c7s9XjSOiie9YN8NE8QHzBMK3Dmhe3Vgy0T5hdIMe+GGw4axCV0q1CB0Md9wW0+nFcO8
         n/oot3iKU4kx6jbs9BgPxQL2M6j1ciEa23aPo+/4Aiz0IbbMA5JFveQzw5aE0Ddlqs3T
         z+2Q==
X-Gm-Message-State: AOAM531XYQAntRpk+toafU3GHDOuZQlxHOhpHABAkLYGV0dZo5HwZjDL
        2H/6Q3xE1bAF5FWMPY4/3KiD6XfzlqPCeQ==
X-Google-Smtp-Source: ABdhPJwvbcHTg+A0p7hWA3LedvyLrkl/kxfbrB42sB3nWR0maunIOLxIlfLhnvwkhvsazBFpu/vG6g==
X-Received: by 2002:a5d:43c2:: with SMTP id v2mr378218wrr.455.1643936140494;
        Thu, 03 Feb 2022 16:55:40 -0800 (PST)
Received: from t490s.teknoraver.net (net-2-35-22-35.cust.vodafonedsl.it. [2.35.22.35])
        by smtp.gmail.com with ESMTPSA id c8sm240391wmq.34.2022.02.03.16.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 16:55:39 -0800 (PST)
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf@vger.kernel.org
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 0/2] limit bpf_core_types_are_compat recursion
Date:   Fri,  4 Feb 2022 01:55:17 +0100
Message-Id: <20220204005519.60361-1-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

As formerly discussed on the BPF mailing list:
https://lore.kernel.org/bpf/CAADnVQJDax2j0-7uyqdqFEnpB57om_z+Cqmi1O2QyLpHqkVKwA@mail.gmail.com/

changes from v2:
test the bpf_core_type_exists() return value, and check that the recursion
limit is enforced.

Matteo Croce (2):
  bpf: limit bpf_core_types_are_compat() recursion
  selftests/bpf: test maximum recursion depth for
    bpf_core_types_are_compat()

 include/linux/btf.h                           |   5 +
 kernel/bpf/btf.c                              | 105 +++++++++++++++++-
 tools/testing/selftests/bpf/Makefile          |   2 +-
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |   5 +
 .../selftests/bpf/prog_tests/core_kern.c      |  15 ++-
 .../bpf/prog_tests/core_kern_overflow.c       |  13 +++
 tools/testing/selftests/bpf/progs/core_kern.c |  14 +++
 .../selftests/bpf/progs/core_kern_overflow.c  |  21 ++++
 8 files changed, 177 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/core_kern_overflow.c
 create mode 100644 tools/testing/selftests/bpf/progs/core_kern_overflow.c

-- 
2.34.1

