Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7582B95B0C
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2019 11:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729472AbfHTJcS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Aug 2019 05:32:18 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35701 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728842AbfHTJcM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Aug 2019 05:32:12 -0400
Received: by mail-wm1-f66.google.com with SMTP id l2so2025316wmg.0
        for <bpf@vger.kernel.org>; Tue, 20 Aug 2019 02:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AMLCV3YzxdATq/4eGHOKLDLXG9C3cKBdYE1r3RyBJ+0=;
        b=rk+hTMGw8a9uURSgyDxDkMWhr18PePPZvmBfqaxX1ITQyAaZ6o5a89pjHr56pR9Cxl
         KA9C/fJeri19ouUChv39cqRaMowZ5+HxcbV4SH6RDqtRSYzUWevbEZwB2rpcinPtOn3k
         ojzv+frJYkii33v7XggCDgmBfiifLMgNs4+6M4hyC2jCZ7UpfBFt6RwB2OGK28j2aHjP
         QuMprko0g9jsnpvWi/5Nv7X8tE3cM5XyD0S9aOM5uTlHYKUslGkQFtTo8Fi8NLEbD1cO
         F3tvqiU434VW/o9Aww8HZUD67Pin3SteVXSPY8iWn95+pNK2ErwTk6An3UyZofubqsQa
         UHRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AMLCV3YzxdATq/4eGHOKLDLXG9C3cKBdYE1r3RyBJ+0=;
        b=kKvTl/W1oHAv67gF/C/j/lt59Lrzwa5CN8aaClwTLVQa6Z3efJHY5XkxH/vjzLv7Qt
         /0TMjRrrtkaYFVCgnEsXEziuQKJWTcrH4A6MNTsl25czd/75yZ944sflQKkNxVZ6Vimj
         WpimFrZBm2iuhH1F2q8PMEgRXl38X3YWemcpV7ZQsn9k89V9LqkEXXmzzT+Q8ptFNcBy
         8KOqpkL7CpW2BcO83Mc5QEYpXBBQ0J51XlYAUiTpRozsgjcLnKeFvhUrCGUUMg1+dQ/5
         /sfm7klQM8Xsd4E0UyMS2/iAgFNEKw6dO4TEb0hqNT6VNc1ugRxMAiwXL0K6/J7eqHa3
         Lnkg==
X-Gm-Message-State: APjAAAWr/Ehj5RFM0AiOtA+hxA5SbVUzsBMj7ClcHm4v24BKRmyn+9kI
        FpwUPL0f1vL5bJovcBwVwfMewA==
X-Google-Smtp-Source: APXvYqw0zXrkTjBalO13y9Z1hJ5xolNNsfEPwrKijfxX3qEHYi/DNuQ0BihPB2E5Zv/lMRB3gYDuTw==
X-Received: by 2002:a7b:c019:: with SMTP id c25mr16184409wmb.116.1566293530086;
        Tue, 20 Aug 2019 02:32:10 -0700 (PDT)
Received: from cbtest32.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id p9sm16128190wru.61.2019.08.20.02.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 02:32:08 -0700 (PDT)
From:   Quentin Monnet <quentin.monnet@netronome.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: [PATCH bpf-next v2 3/5] libbpf: refactor bpf_*_get_next_id() functions
Date:   Tue, 20 Aug 2019 10:31:52 +0100
Message-Id: <20190820093154.14042-4-quentin.monnet@netronome.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190820093154.14042-1-quentin.monnet@netronome.com>
References: <20190820093154.14042-1-quentin.monnet@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In preparation for the introduction of a similar function for retrieving
the id of the next BTF object, consolidate the code from
bpf_prog_get_next_id() and bpf_map_get_next_id() in libbpf.

Signed-off-by: Quentin Monnet <quentin.monnet@netronome.com>
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
---
 tools/lib/bpf/bpf.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index c7d7993c44bb..1439e99c9be5 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -568,7 +568,7 @@ int bpf_prog_test_run_xattr(struct bpf_prog_test_run_attr *test_attr)
 	return ret;
 }
 
-int bpf_prog_get_next_id(__u32 start_id, __u32 *next_id)
+static int bpf_obj_get_next_id(__u32 start_id, __u32 *next_id, int cmd)
 {
 	union bpf_attr attr;
 	int err;
@@ -576,26 +576,21 @@ int bpf_prog_get_next_id(__u32 start_id, __u32 *next_id)
 	memset(&attr, 0, sizeof(attr));
 	attr.start_id = start_id;
 
-	err = sys_bpf(BPF_PROG_GET_NEXT_ID, &attr, sizeof(attr));
+	err = sys_bpf(cmd, &attr, sizeof(attr));
 	if (!err)
 		*next_id = attr.next_id;
 
 	return err;
 }
 
-int bpf_map_get_next_id(__u32 start_id, __u32 *next_id)
+int bpf_prog_get_next_id(__u32 start_id, __u32 *next_id)
 {
-	union bpf_attr attr;
-	int err;
-
-	memset(&attr, 0, sizeof(attr));
-	attr.start_id = start_id;
-
-	err = sys_bpf(BPF_MAP_GET_NEXT_ID, &attr, sizeof(attr));
-	if (!err)
-		*next_id = attr.next_id;
+	return bpf_obj_get_next_id(start_id, next_id, BPF_PROG_GET_NEXT_ID);
+}
 
-	return err;
+int bpf_map_get_next_id(__u32 start_id, __u32 *next_id)
+{
+	return bpf_obj_get_next_id(start_id, next_id, BPF_MAP_GET_NEXT_ID);
 }
 
 int bpf_prog_get_fd_by_id(__u32 id)
-- 
2.17.1

