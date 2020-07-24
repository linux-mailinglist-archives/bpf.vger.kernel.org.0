Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 002E122D069
	for <lists+bpf@lfdr.de>; Fri, 24 Jul 2020 23:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbgGXVSG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jul 2020 17:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbgGXVSF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Jul 2020 17:18:05 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61BBC0619D3
        for <bpf@vger.kernel.org>; Fri, 24 Jul 2020 14:18:05 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id l17so11200225iok.7
        for <bpf@vger.kernel.org>; Fri, 24 Jul 2020 14:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7uHAi4Y4Ugapbp/Lc/wjoDdrsUuAsz9f8dAX4ljcQBw=;
        b=XJT1dXrI2knm0D0XIhoL2gJeqxAlYOT1DV3Hcb9zS9eB+7EziatvslInebiCpyPBAN
         Yvnz2fwrnq/KSzRYCZmP+AFAZTOknawIZDOBv4a5sp8v8j7HQ+F+bqo+D8add12OFh3Y
         0wkuhEFAlm/U+V9jUv2tmMX2kl3nnpA1EReCsRN/JK4CQpDTOstJ9kOz6kYXsXwZJJaK
         qArkufoWPXDpz0gPx7tB5jxjVOtAlFfYgqI0k51opfjqp6h6407YHSKzDCPxM/FOJldn
         AGcCW3a+Uz9V6Y7D9Vt9VI5wRz+GcjKRO53+cBGW6sfqa3N4v3g4A5EjRJaIICOxQhlL
         QcGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7uHAi4Y4Ugapbp/Lc/wjoDdrsUuAsz9f8dAX4ljcQBw=;
        b=CNAY5LQCARH9fNcAqwD7cY0UX+Mmgx1xQD+jG7gLDoLgUiwCgAUfnzBpio5RFATnWU
         okLMbpE5x9avsVvFauax3rghNWV+kaJJyluRxM93MBBWWEwstRRsqxR4Yr/YGNbeu4TL
         4ag7e5kKGw5ax9rqAqG3BRDji4J4ohmA01od4kzrcUXtTuVsAEJZm4sip+X4sHy1Q6wj
         XgcubuaTbXGSPo9IQk/6L8BiGAU1PVNURLGjSYDwdavHRn/1lLT1JF7fDXDkthe9dz3t
         dAUT2bUofEI/mkvTqFbZGGWn9d8lEAtPnN4fRgHDfJRwHHBEJAHadMLBAAugZooBQryj
         Ng3w==
X-Gm-Message-State: AOAM533L+OrrXK278kAxQyo4FgOLyr58YGDRfDTAGBgSeUgYihnaAu4/
        8EPDxsgbbRVeqOWzWhtAfy0U4xhwPoEwIQ==
X-Google-Smtp-Source: ABdhPJw3uEaZhQaFMc7Y/2CPaGN0qclyuN5PL4sVOw2gIPizpD6eeOLEFiXbWe+pGclFgMkB4E+6jw==
X-Received: by 2002:a6b:591a:: with SMTP id n26mr5871984iob.122.1595625484943;
        Fri, 24 Jul 2020 14:18:04 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-219.tnkngak.clients.pavlovmedia.com. [173.230.99.219])
        by smtp.gmail.com with ESMTPSA id q14sm4123904iow.25.2020.07.24.14.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 14:18:04 -0700 (PDT)
From:   YiFei Zhu <zhuyifei1999@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Martin KaFai Lau <kafai@fb.com>,
        YiFei Zhu <zhuyifei@google.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH bpf-next] bpf/local_storage: Fix build without CONFIG_CGROUP
Date:   Fri, 24 Jul 2020 16:17:53 -0500
Message-Id: <20200724211753.902969-1-zhuyifei1999@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: YiFei Zhu <zhuyifei@google.com>

local_storage.o has its compile guard as CONFIG_BPF_SYSCALL, which
does not imply that CONFIG_CGROUP is on. Including cgroup-internal.h
when CONFIG_CGROUP is off cause a compilation failure.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: f67cfc233706 ("bpf: Make cgroup storages shared between programs on the same cgroup")
Signed-off-by: YiFei Zhu <zhuyifei@google.com>
---
 kernel/bpf/local_storage.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index 3b2c70197d78..571bb351ed3b 100644
--- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -9,12 +9,12 @@
 #include <linux/slab.h>
 #include <uapi/linux/btf.h>
 
-#include "../cgroup/cgroup-internal.h"
-
 DEFINE_PER_CPU(struct bpf_cgroup_storage*, bpf_cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE]);
 
 #ifdef CONFIG_CGROUP_BPF
 
+#include "../cgroup/cgroup-internal.h"
+
 #define LOCAL_STORAGE_CREATE_FLAG_MASK					\
 	(BPF_F_NUMA_NODE | BPF_F_ACCESS_MASK)
 
-- 
2.27.0

