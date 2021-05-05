Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1B393737BB
	for <lists+bpf@lfdr.de>; Wed,  5 May 2021 11:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbhEEJmm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 May 2021 05:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbhEEJml (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 May 2021 05:42:41 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F99C06174A
        for <bpf@vger.kernel.org>; Wed,  5 May 2021 02:41:44 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id j28so1197199edy.9
        for <bpf@vger.kernel.org>; Wed, 05 May 2021 02:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7hnffGHJsR/6yllxz/8B9dTQLMMrIyyx25DZ2be5bsc=;
        b=fPEtWDVCH3nmZCpcE5Ss7lRiQBVzdZWLv29+y1ThfibbCghbgriuQ0Jaj67aCFokGE
         m8Ly3x/8DeFOfrks7sEgYw2+tEDXv2qFx79CAR/2a68Tk8V0NiZkCz44RfE627NYIEvf
         QKFUko9ld81tpO0J+ZGoGvhcnCZQcYXmeAaXV15TIBJUwEXwg1Ok6sB9cXtoDvW0fXzs
         6mxrcz/PeLOWhmhPD7B0WNI3Uf3AFW8wdso4hbsvGqCjQMd5yLbP+2tpTGAv/AlPKAFE
         oDNb9NW+CtQofRafYni9qu3GHDgNnwnOqNMXZf7CmoTXadx7mgPRAgr7x+blATKDBbFP
         OBrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7hnffGHJsR/6yllxz/8B9dTQLMMrIyyx25DZ2be5bsc=;
        b=FVBGAILawx0WSVKjI8VMnWQEcPlqF/PImMgMc70OS94LuKFQuA8JritA1xYfbCHwis
         xRbwxIBWZ9tyLcRh9HC96lqHg5QQJdkC7kevfQFIgPVxnUGRZaTWEAWvCJY/dCXaoAJL
         +kcwcGihKKZncHC76BSkYy0UISQ6w55+BhR1ZR81jO6VtxlS+yYZ/7v8shOgvDXqwE72
         sOP+dRIa2ALQORUnGw8opwgul8RWXEY2MEC7U9gVC4RWQoO6XbTejSj9Td64P8VzNBUr
         64V81ouZQa1kbNb19l8QY7a4GmBX1gQX5E40q0aALDH/9hpg23ThVbEaX5+5tIhV5shr
         rYBw==
X-Gm-Message-State: AOAM531JxRDKtyG5TRPzDGuO5lbbdWYOhC3O2Car1/d5zzhlG84SPMbN
        UfWsZf3FkkCE5aly4S4aClwwr2tJIDgl4Gt195GPp4NRE36/4JDhZ6a5KOB1OoinXl6v9hjVl4m
        jtJIPIF/ZuFy9/+7jzd/rRsQs4zR7SbJAlZHFJgQkRxwgC9QEBkIuzSNjrNV+w2nEKfxawIWB
X-Google-Smtp-Source: ABdhPJzs0HwsSDqY4iRCRm2/AxAq8YVYB43qZAp14fuyBDtvvXiceBT0mRitKTsYDsr6nOiwMPUsGA==
X-Received: by 2002:a50:a404:: with SMTP id u4mr2808500edb.112.1620207703070;
        Wed, 05 May 2021 02:41:43 -0700 (PDT)
Received: from localhost.localdomain (93-136-23-177.adsl.net.t-com.hr. [93.136.23.177])
        by smtp.gmail.com with ESMTPSA id e12sm2599975ejk.99.2021.05.05.02.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 02:41:42 -0700 (PDT)
From:   Denis Salopek <denis.salopek@sartura.hr>
To:     bpf@vger.kernel.org
Cc:     Denis Salopek <denis.salopek@sartura.hr>,
        Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>,
        Luka Oreskovic <luka.oreskovic@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v6 bpf-next 2/3] bpf: extend libbpf with bpf_map_lookup_and_delete_elem_flags
Date:   Wed,  5 May 2021 11:40:27 +0200
Message-Id: <20210505094028.22079-2-denis.salopek@sartura.hr>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210505094028.22079-1-denis.salopek@sartura.hr>
References: <20210505094028.22079-1-denis.salopek@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add bpf_map_lookup_and_delete_elem_flags() libbpf API in order to use
the BPF_F_LOCK flag with the map_lookup_and_delete_elem() function.

Cc: Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>
Cc: Luka Oreskovic <luka.oreskovic@sartura.hr>
Cc: Luka Perkov <luka.perkov@sartura.hr>
Cc: Yonghong Song <yhs@fb.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Denis Salopek <denis.salopek@sartura.hr>
Acked-by: Yonghong Song <yhs@fb.com>
---
v5: Move to the newest libbpf version (0.4.0).
v6: Add Acked-by.
---
 tools/lib/bpf/bpf.c      | 13 +++++++++++++
 tools/lib/bpf/bpf.h      |  2 ++
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 16 insertions(+)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index bba48ff4c5c0..b7c2cc12034c 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -458,6 +458,19 @@ int bpf_map_lookup_and_delete_elem(int fd, const void *key, void *value)
 	return sys_bpf(BPF_MAP_LOOKUP_AND_DELETE_ELEM, &attr, sizeof(attr));
 }
 
+int bpf_map_lookup_and_delete_elem_flags(int fd, const void *key, void *value, __u64 flags)
+{
+	union bpf_attr attr;
+
+	memset(&attr, 0, sizeof(attr));
+	attr.map_fd = fd;
+	attr.key = ptr_to_u64(key);
+	attr.value = ptr_to_u64(value);
+	attr.flags = flags;
+
+	return sys_bpf(BPF_MAP_LOOKUP_AND_DELETE_ELEM, &attr, sizeof(attr));
+}
+
 int bpf_map_delete_elem(int fd, const void *key)
 {
 	union bpf_attr attr;
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 875dde20d56e..4f758f8f50cd 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -124,6 +124,8 @@ LIBBPF_API int bpf_map_lookup_elem_flags(int fd, const void *key, void *value,
 					 __u64 flags);
 LIBBPF_API int bpf_map_lookup_and_delete_elem(int fd, const void *key,
 					      void *value);
+LIBBPF_API int bpf_map_lookup_and_delete_elem_flags(int fd, const void *key,
+						    void *value, __u64 flags);
 LIBBPF_API int bpf_map_delete_elem(int fd, const void *key);
 LIBBPF_API int bpf_map_get_next_key(int fd, const void *key, void *next_key);
 LIBBPF_API int bpf_map_freeze(int fd);
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index b9b29baf1df8..6c06267c020e 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -360,5 +360,6 @@ LIBBPF_0.4.0 {
 		bpf_linker__free;
 		bpf_linker__new;
 		bpf_map__inner_map;
+		bpf_map_lookup_and_delete_elem_flags;
 		bpf_object__set_kversion;
 } LIBBPF_0.3.0;
-- 
2.26.2

