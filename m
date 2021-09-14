Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C93A40BC5E
	for <lists+bpf@lfdr.de>; Wed, 15 Sep 2021 01:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235966AbhINXzW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 19:55:22 -0400
Received: from mail-ej1-f54.google.com ([209.85.218.54]:37550 "EHLO
        mail-ej1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233774AbhINXzW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 19:55:22 -0400
Received: by mail-ej1-f54.google.com with SMTP id h9so2141409ejs.4;
        Tue, 14 Sep 2021 16:54:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/26lsQrbc0U4k499W9FOsHTtB4Tgf75dC9jkqNapQLw=;
        b=qa8b5x158gixpoiKO1lf9GPCw/knfqnLkw2M03FSdPIN4JgkqSh5zCB9v/YBn0SNTw
         jaYQQMBftN/3PptCVBeFKWnUNMBw1JG+fGrOVrxnKjUtSWu+up6hhU4yuvwDMIh7PpEq
         YgCVH5u7aY4KQOEzUZm7SW2SLKx9a/Hjm7p3ThbzhtB+ocAjJ5fFy+8IxJCGixi1ccgi
         CEQt7XjyJXEPj7IU3IoGVBLWVAhgTDQdbdEwBmeYcMD9CflSF5DjbhQAa6UkPEstNmPM
         kZqu9fQwNgS9/8bXfpgFSxqqItxNXi/BV0WLD7m8W3LVz87WHfZNu/ae8bk59inbUfrl
         gINw==
X-Gm-Message-State: AOAM531Vip6OMlGSrUEXqZWzjAZVj2wvzp9pL/uA19sGKwmdSwH9+jld
        lL/6Ian2rvbky0VVh+wFnFU2tAFQZRyUqA==
X-Google-Smtp-Source: ABdhPJzcml0lqk4KJMs+LcUFreWg9CcZluLNrUFwMvV+eB4eJG/dA3RqxQkxPhakWJoM4FfrDYSRLw==
X-Received: by 2002:a17:907:244a:: with SMTP id yw10mr21025939ejb.571.1631663643535;
        Tue, 14 Sep 2021 16:54:03 -0700 (PDT)
Received: from msft-t490s.teknoraver.net (net-2-34-36-22.cust.vodafonedsl.it. [2.34.36.22])
        by smtp.gmail.com with ESMTPSA id y4sm4084031ejr.101.2021.09.14.16.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 16:54:02 -0700 (PDT)
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     bpf@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Yonghong Song <yhs@fb.com>
Subject: [PATCH bpf-next v2] bpf: update bpf_get_smp_processor_id() documentation
Date:   Wed, 15 Sep 2021 01:54:00 +0200
Message-Id: <20210914235400.59427-1-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

BPF programs run with migration disabled regardless of preemption, as
they are protected by migrate_disable().
Update the documentation accordingly.

Signed-off-by: Matteo Croce <mcroce@microsoft.com>
---
 include/uapi/linux/bpf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index d21326558d42..3e9785f1064a 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1629,7 +1629,7 @@ union bpf_attr {
  * u32 bpf_get_smp_processor_id(void)
  * 	Description
  * 		Get the SMP (symmetric multiprocessing) processor id. Note that
- * 		all programs run with preemption disabled, which means that the
+ * 		all programs run with migration disabled, which means that the
  * 		SMP processor id is stable during all the execution of the
  * 		program.
  * 	Return
-- 
2.31.1

