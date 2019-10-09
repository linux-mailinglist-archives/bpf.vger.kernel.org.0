Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADF5D19DC
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2019 22:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732089AbfJIUly (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Oct 2019 16:41:54 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35913 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732050AbfJIUly (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Oct 2019 16:41:54 -0400
Received: by mail-lj1-f196.google.com with SMTP id v24so3899434ljj.3
        for <bpf@vger.kernel.org>; Wed, 09 Oct 2019 13:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OsXgBugq9yBTYp2TWj7gghCrTtBB47X9YeLV9E3YhNo=;
        b=XKt173H8wj8IKIt4DSevJv+kXD2QtQYilXS8zfwcM9SF+6OorOJJ3SmvoU7IACx3N5
         ZD4/UL/3p86LvvBJV/yGSkWEyRdtqTpfMBJxpHO+ck6akQ2JdmFtBmoy7w3Ci0j5MNfD
         7iatnjl5O8In1S22aDEa0gNv47xnsUTG4FhY67C5Wp4Yde6cgVue2NsEVNcETOtarJDt
         PE5ipS2g0wOPpz4f84UV0CtrbwKOFXWdySlA/CO/sr6CDtBjDHIjVYO8596kQW+ndpi1
         XOrbcWeIxekD8aI7aComYtS7I2L5V6w7+5MYsOTBISOvFA2UYk/Xr5Y4IpEQMDDqn4ym
         q65w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OsXgBugq9yBTYp2TWj7gghCrTtBB47X9YeLV9E3YhNo=;
        b=aH4+b23HTzWFwzsS6Uu1HESlMRCjdIVTI2HdrtXpQIdhS5fWvMZcdvfEdwFVOk+i39
         8oPZk7Rly/ci3CvvEhZwF84bYtEkjblwbUEY3DsG3leP8K1Yc0Zk1rUg6KVeXSfZUaY0
         PEHmqEkEAV3C3ELSlvhxr9CTeGu1M9jcaszEgDMafLqV5IDzpiEwzocYXph+41PD5JV/
         tGCPgGsXEd2IBwXQb74w7XKjLEAiW+JiExH9/gMXPd34/aN3h+AkSYjTOLV79Y2ZCJRM
         lQwZare5JZE4/euSHAw+0dBTIT8u4AX8vVb9VI2iyLeLLTsBDyUm1QKF9TY8LPcYLKsp
         7WOg==
X-Gm-Message-State: APjAAAWCdcPl1yRO/pt7pIOJrWPaeJX52YpmIJ/a8sfx9uvafl2fyj+r
        S4QBZdBAQ2RucGr9S49Rqk1lww==
X-Google-Smtp-Source: APXvYqyKSVYA9IYS07/s7Tz9nGuH4Qj6X8tIMaQkbg3VmhvMOSJ5DehlnN9a0rFAYF6qMZNs9/iBSA==
X-Received: by 2002:a2e:9958:: with SMTP id r24mr3544709ljj.61.1570653712166;
        Wed, 09 Oct 2019 13:41:52 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id h3sm730871ljf.12.2019.10.09.13.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 13:41:51 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        ilias.apalodimas@linaro.org, sergei.shtylyov@cogentembedded.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v4 bpf-next 09/15] samples/bpf: use own flags but not HOSTCFLAGS
Date:   Wed,  9 Oct 2019 23:41:28 +0300
Message-Id: <20191009204134.26960-10-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191009204134.26960-1-ivan.khoronzhuk@linaro.org>
References: <20191009204134.26960-1-ivan.khoronzhuk@linaro.org>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

While compiling natively, the host's cflags and ldflags are equal to
ones used from HOSTCFLAGS and HOSTLDFLAGS. When cross compiling it
should have own, used for target arch. While verification, for arm,
arm64 and x86_64 the following flags were used always:

-Wall -O2
-fomit-frame-pointer
-Wmissing-prototypes
-Wstrict-prototypes

So, add them as they were verified and used before adding
Makefile.target and lets omit "-fomit-frame-pointer" as were
proposed while review, as no sense in such optimization for samples.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 samples/bpf/Makefile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 91bfb421c278..57a15ff938a6 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -176,8 +176,10 @@ BPF_EXTRA_CFLAGS := $(ARM_ARCH_SELECTOR)
 TPROGS_CFLAGS += $(ARM_ARCH_SELECTOR)
 endif
 
-TPROGS_LDLIBS := $(KBUILD_HOSTLDLIBS)
-TPROGS_CFLAGS += $(KBUILD_HOSTCFLAGS) $(HOST_EXTRACFLAGS)
+TPROGS_CFLAGS += -Wall -O2
+TPROGS_CFLAGS += -Wmissing-prototypes
+TPROGS_CFLAGS += -Wstrict-prototypes
+
 TPROGS_CFLAGS += -I$(objtree)/usr/include
 TPROGS_CFLAGS += -I$(srctree)/tools/lib/bpf/
 TPROGS_CFLAGS += -I$(srctree)/tools/testing/selftests/bpf/
-- 
2.17.1

