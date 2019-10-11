Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0479CD35E3
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2019 02:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbfJKA2n (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Oct 2019 20:28:43 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45467 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727811AbfJKA2n (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Oct 2019 20:28:43 -0400
Received: by mail-lf1-f68.google.com with SMTP id r134so5712355lff.12
        for <bpf@vger.kernel.org>; Thu, 10 Oct 2019 17:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZSbYJ+tLtfDuMSVqb7LwJbRD3u314/MfD3p1keHf2Mw=;
        b=YEWRAAeP4o9HHLefGfaSlerG740LF6GtTrZy66djivNZSPXT2LBKGX5D/yhlmqrqM+
         L34Z9JhgWajti0FN3n8kYiabDXezUUK4PqM1gd8sR+MKr0ChD9NupqJwZmQTj7twHTdF
         dHgGXTZ2cHg7b/c8pXz6c8Enr6iA/I+lnsC3C+lrCF+LHqDLQy7x2dRHtJsVOrbqDS3j
         daeTThbrpUYNT9YcwYABSYd1h1z/INp//Dh+VQW26ASB/eSFZvjaRl4W3m3yBL3cMnJp
         udb+u8gkI9g3tPg+Jv5fVOQHAUlMKfUTubwdRuExHcN3URxlHoKGRLzwD696KoEF6F1M
         4HBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZSbYJ+tLtfDuMSVqb7LwJbRD3u314/MfD3p1keHf2Mw=;
        b=b+AO5XfM4dYCrbK2VS3jH7PcsKoo6jgncpDFBf+frFfzIal6gk/pkTVAu/FDKnU9Hp
         r8HtkwgBcqG4vMFzWH9OQMG2N1Hj2KWLoDQ15tqTD3szZ7ZgZCDgj+kq8PIPZWscSOyt
         HiGUvwLDfBYsFbze9bTMosE9eusEkoLSaPe7tnaItNu9nC9tPkHw9gyBqHHLdm1fyx7R
         57mb3gJG+pl0JnISd+Mb/MLcnpu4JjARe3KdbdGVQkK1C9Ddvm+mqfaSKFg+nLFARcl7
         lo3qj6XzddVt4FVf/62GBRNrcR0LhSbEKktkuzd3SqkaUIUsYiFS7xLgH4QYuYL5U7iS
         gdQA==
X-Gm-Message-State: APjAAAVLCiD44PpkrnNbREOp3VTe6YL+1qExgyZjEwKreehus38l+Kep
        alsrN5NuVyu52orVKZ4drgrsAe09Pbw=
X-Google-Smtp-Source: APXvYqyhcISOx5eMOkg9jdNeGYeWkSYpsgitJe+y4Aafu4AVaZ4KPx/+QyNm04qefphEXSuPuAwzpg==
X-Received: by 2002:ac2:5468:: with SMTP id e8mr7357520lfn.12.1570753719752;
        Thu, 10 Oct 2019 17:28:39 -0700 (PDT)
Received: from localhost.localdomain (88-201-94-178.pool.ukrtel.net. [178.94.201.88])
        by smtp.gmail.com with ESMTPSA id 126sm2367010lfh.45.2019.10.10.17.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 17:28:39 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        ilias.apalodimas@linaro.org, sergei.shtylyov@cogentembedded.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v5 bpf-next 14/15] samples/bpf: add sysroot support
Date:   Fri, 11 Oct 2019 03:28:07 +0300
Message-Id: <20191011002808.28206-15-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011002808.28206-1-ivan.khoronzhuk@linaro.org>
References: <20191011002808.28206-1-ivan.khoronzhuk@linaro.org>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Basically it only enables that was added by previous couple fixes.
Sysroot contains correct libs installed and its headers. Useful when
working with NFC or virtual machine.

Usage example:

clean (on demand)
    make ARCH=arm -C samples/bpf clean
    make ARCH=arm -C tools clean
    make ARCH=arm clean

configure and install headers:

    make ARCH=arm defconfig
    make ARCH=arm headers_install

build samples/bpf:
    make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- samples/bpf/ \
    SYSROOT="path/to/sysroot"

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 samples/bpf/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 6b161326ac67..4df11ddb9c75 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -187,6 +187,11 @@ TPROGS_CFLAGS += -I$(srctree)/tools/lib/
 TPROGS_CFLAGS += -I$(srctree)/tools/include
 TPROGS_CFLAGS += -I$(srctree)/tools/perf
 
+ifdef SYSROOT
+TPROGS_CFLAGS += --sysroot=$(SYSROOT)
+TPROGS_LDFLAGS := -L$(SYSROOT)/usr/lib
+endif
+
 TPROGCFLAGS_bpf_load.o += -Wno-unused-variable
 
 TPROGS_LDLIBS			+= $(LIBBPF) -lelf
-- 
2.17.1

