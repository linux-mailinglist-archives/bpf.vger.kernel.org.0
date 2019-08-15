Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 457448EEEE
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2019 17:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731719AbfHOPAo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Aug 2019 11:00:44 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41545 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733298AbfHOPAg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Aug 2019 11:00:36 -0400
Received: by mail-wr1-f68.google.com with SMTP id j16so2479812wrr.8
        for <bpf@vger.kernel.org>; Thu, 15 Aug 2019 08:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zMkkZCc7A2SkaJGYw2ZUa/LWnENmyPIwRLlvJbRLQ28=;
        b=zENmOImNLUw07wZgcZYaXEpDwbRtqdLrLC+vfmR21VxDh3W7U9lfBvTNT/TRbchEkb
         4LXFb6x//KwtZC2FZJzyVGkrtzJEYjb+R2HLvjkXu9FrLslIIFQ8ZpyfLcGoadE/ZzJy
         O7O3EqjntXI/vNw9b59sPYRuWdo4YqPyTW2NyhIBqlpVabN/XIPp9h+VpG/CVe/rLkp3
         1dhDbQqk9afSFsRAo+kPS6Tl6M/UwFPmB04wnmasym+LSULvxb6QBWVfO/fSsXS4OKKk
         Iu8kHvC4zob1cwLokEEroWLIyyDyjOEF3G4VGMkuoAbiLAwKpDRghqc7k7bWCIHpjQ6C
         BSJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zMkkZCc7A2SkaJGYw2ZUa/LWnENmyPIwRLlvJbRLQ28=;
        b=irXDFOJ1LKbkrJrx8L5SuEdgFAUGvB0U16XErMaX0cbYEHERk8qj49doAjMcszjy5e
         V/C4ZUk+yZR7ECSsiCo/ZbWwQWp3hz7WWWpvXs/Roo7tWU61Seoz3VZhnH8XRlcyS0JY
         RYn+Mbe7bkGmZLdw93X46A7vHIdsx18D3kizUCYKD3MY+GtrEkGlFfSrty7rWmLwAhk7
         zgGb8jZYJahkfPf6+laB2wo+NbGgEEytusLIg7j8OIngTYH7oRtGLymv0fnNyB8hAept
         XqzUzJT2aaR1QfILUR7RHHxcv/jU6EPVvnsh+2NlGKDPhB99bPzdFw3xyDKaV6F9/42J
         QhOw==
X-Gm-Message-State: APjAAAXhux32E1Q0qCQz6YZkE7BlGIDCPujl8unj0JY7kWjH2gaA8vAY
        xg9/qXj7HfrqWLgXrJz+Ojxm9GYrul6tYA==
X-Google-Smtp-Source: APXvYqwm3duem7KqODE8INGIWxm9P/+JbdFX4+gcHW+viGD9pnm31kPLdAvUMqQ2hJfz6OQYpvg1CQ==
X-Received: by 2002:adf:f2c1:: with SMTP id d1mr6063075wrp.157.1565881235174;
        Thu, 15 Aug 2019 08:00:35 -0700 (PDT)
Received: from cbtest32.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id a23sm2794857wma.24.2019.08.15.08.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 08:00:34 -0700 (PDT)
From:   Quentin Monnet <quentin.monnet@netronome.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: [PATCH bpf-next 4/5] libbpf: add bpf_btf_get_next_id() to cycle through BTF objects
Date:   Thu, 15 Aug 2019 16:00:18 +0100
Message-Id: <20190815150019.8523-5-quentin.monnet@netronome.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190815150019.8523-1-quentin.monnet@netronome.com>
References: <20190815150019.8523-1-quentin.monnet@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add an API function taking a BTF object id and providing the id of the
next BTF object in the kernel. This can be used to list all BTF objects
loaded on the system.

Signed-off-by: Quentin Monnet <quentin.monnet@netronome.com>
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
---
 tools/lib/bpf/Makefile   | 2 +-
 tools/lib/bpf/bpf.c      | 5 +++++
 tools/lib/bpf/bpf.h      | 1 +
 tools/lib/bpf/libbpf.map | 5 +++++
 4 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index 9312066a1ae3..f6c0295c6a5e 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -3,7 +3,7 @@
 
 BPF_VERSION = 0
 BPF_PATCHLEVEL = 0
-BPF_EXTRAVERSION = 4
+BPF_EXTRAVERSION = 5
 
 MAKEFLAGS += --no-print-directory
 
diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 1439e99c9be5..cbb933532981 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -593,6 +593,11 @@ int bpf_map_get_next_id(__u32 start_id, __u32 *next_id)
 	return bpf_obj_get_next_id(start_id, next_id, BPF_MAP_GET_NEXT_ID);
 }
 
+int bpf_btf_get_next_id(__u32 start_id, __u32 *next_id)
+{
+	return bpf_obj_get_next_id(start_id, next_id, BPF_BTF_GET_NEXT_ID);
+}
+
 int bpf_prog_get_fd_by_id(__u32 id)
 {
 	union bpf_attr attr;
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index ff42ca043dc8..0db01334740f 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -156,6 +156,7 @@ LIBBPF_API int bpf_prog_test_run(int prog_fd, int repeat, void *data,
 				 __u32 *retval, __u32 *duration);
 LIBBPF_API int bpf_prog_get_next_id(__u32 start_id, __u32 *next_id);
 LIBBPF_API int bpf_map_get_next_id(__u32 start_id, __u32 *next_id);
+LIBBPF_API int bpf_btf_get_next_id(__u32 start_id, __u32 *next_id);
 LIBBPF_API int bpf_prog_get_fd_by_id(__u32 id);
 LIBBPF_API int bpf_map_get_fd_by_id(__u32 id);
 LIBBPF_API int bpf_btf_get_fd_by_id(__u32 id);
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index f9d316e873d8..664ce8e7a60e 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -184,3 +184,8 @@ LIBBPF_0.0.4 {
 		perf_buffer__new_raw;
 		perf_buffer__poll;
 } LIBBPF_0.0.3;
+
+LIBBPF_0.0.5 {
+	global:
+		bpf_btf_get_next_id;
+} LIBBPF_0.0.4;
-- 
2.17.1

