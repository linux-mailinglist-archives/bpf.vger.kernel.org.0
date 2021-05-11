Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC7637B06D
	for <lists+bpf@lfdr.de>; Tue, 11 May 2021 23:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbhEKVC7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 May 2021 17:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhEKVC7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 May 2021 17:02:59 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BB2C061574
        for <bpf@vger.kernel.org>; Tue, 11 May 2021 14:01:51 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id m12so31826380eja.2
        for <bpf@vger.kernel.org>; Tue, 11 May 2021 14:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kFy4GO3CCsoiCvE3i986raUtZDEctjFBpnUvGA3gMQE=;
        b=gnMp0R3/y8uokFr6EcS0cyziYuvrzjKHPXmJy/ohvur0FmmvkNwEvqLw2SJyVQKqD1
         EeGtH6kgRs77kfuFmYbkVWqCHso3O2Brefw2pOytd3UtPfybOlTCevatvLHJhY5GBEMD
         YYdcaTmLRQ/Db4YjVsJcSaFs1zBJaUOKs2sguGewFA/ouEwIQdomRGrqOqexGOMVleQM
         l4XieRqfx1tAQem/kGVf+6CaWrGYYRQ50dQJMuznm1pha0I5EPpMHCb2Cm1wY7Eueldy
         Ac7KvW2xHGqpkhINSB+m8WRquq9MiajmIFNztLmTqBgsNcmCFaP4EESbmNsKI1x+GmEJ
         IX7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kFy4GO3CCsoiCvE3i986raUtZDEctjFBpnUvGA3gMQE=;
        b=K7P/XMXyqx7E4rnlhGOf82NkLJmpxGz8qFrrZ+J4xLo1aoammAjJ4BEZDhqpqogj7G
         Ho+vis22OGes44miuHtUly9tAD8w2WMjTVLmW/CEYtLJLbcqKQ2KJS01DdKV4SbaqNHt
         lomFbkzvVevYq0vy6UCotDBC/yhA2VJ2//TIehtr/P+uPsnk68OqO68TULAoTIRvRRSN
         0p5w59Pzv7skSdhfAma70/4/khhtx06U6dOW/gntKCYZ5uv6/6/mKQiL6fUvluJCjSYH
         JE89hWqlhtorRFkvjVs8mveat5jew+iVAtdFa2vxkJg0TKXUD/smis/fhMhsLU8Gf6xQ
         VVYw==
X-Gm-Message-State: AOAM531mH0PMmv36kaNyc5z+haFBq+p+AlMF8ctB/lLFsKPapct9JaMW
        2n4PGM0g/Q+BRzJWr3ITTWUzjIxVjympV1yb7MRgW3IZN/WmSBO0/Ksm5YuOybzLlttfgWNxFGz
        4bLDKR1cZqgkoKaXaASB0MgG3/EVTWUisFM3OPH81K466xf8WhDZghtfNgfyJSCnK8rSBK+hO
X-Google-Smtp-Source: ABdhPJx+BI4LIlDjTXYO0C46ZRc17BkyQQPBZ6FbMJXlBMA5SevtaV7pLDZT0pLAYfAZqKagHJF5gw==
X-Received: by 2002:a17:906:d8d4:: with SMTP id re20mr33269774ejb.505.1620766910175;
        Tue, 11 May 2021 14:01:50 -0700 (PDT)
Received: from localhost.localdomain ([93.140.9.82])
        by smtp.gmail.com with ESMTPSA id k9sm13206569eje.102.2021.05.11.14.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 14:01:49 -0700 (PDT)
From:   Denis Salopek <denis.salopek@sartura.hr>
To:     bpf@vger.kernel.org
Cc:     Denis Salopek <denis.salopek@sartura.hr>,
        Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>,
        Luka Oreskovic <luka.oreskovic@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v7 bpf-next 2/3] bpf: extend libbpf with bpf_map_lookup_and_delete_elem_flags
Date:   Tue, 11 May 2021 23:00:05 +0200
Message-Id: <15b05dafe46c7e0750d110f233977372029d1f62.1620763117.git.denis.salopek@sartura.hr>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1620763117.git.denis.salopek@sartura.hr>
References: <cover.1620763117.git.denis.salopek@sartura.hr>
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

