Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 202A73D129B
	for <lists+bpf@lfdr.de>; Wed, 21 Jul 2021 17:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240025AbhGUO5j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Jul 2021 10:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239983AbhGUO5h (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Jul 2021 10:57:37 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A13BC061575
        for <bpf@vger.kernel.org>; Wed, 21 Jul 2021 08:38:14 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id m11-20020a05600c3b0bb0290228f19cb433so3710783wms.0
        for <bpf@vger.kernel.org>; Wed, 21 Jul 2021 08:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P8e81FmVgHT1ooYp1RVWBwSzx74yKgj81vQ/604cq6c=;
        b=y7VDqgQYzvwGexz+B2URdDKWk+BMFm4tOAj784WhXN4dflBSTx/XmReCxJI+sVgpx8
         9ErmSN4/jH8xpz/uS6HZNYeSCS4wBbFX4KdQzo7hCOh+BuyB02P1ZZDxG+MPIwJTs1gT
         mxWyF1hfT7c3mDszeq84uREkzoAE2lKBoiNdWu0hofQYlZbGXNnFXhFwFrasQLChbNaE
         +56TQF/SPV/WXZkqaTLj1O1EOPcpVs3tg09uper+rEqlOvmGkI8UYmdLvA+VLfbF+EsW
         /T04+6SlFfNh9pkIgc6GM7NUZEtRdm85Mn0zak31VVr3LFVJZC3FPt68ARRqWi0+lcUL
         ks5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P8e81FmVgHT1ooYp1RVWBwSzx74yKgj81vQ/604cq6c=;
        b=cCmEI8jiPcnoVEI3rRO3iFWerggIVOaBFRYE+a8wIdiEYy/aGsWEDTv9c22+Y1n3Si
         LFnQTHtG2hHwUlyUxHiJa+zmZH8prBzQbd2vXbnrTPPGdAYIDhOLBm40Q9P6MbeP9VBl
         wIUNp4tyCyh0pTB7Nc+yBFYLyMP7sjnRLPoLZ/8jysvlMdbOIaMOD7BkKhHn6aQwpel2
         JbXaQiJQH90yTrOwBVQ2hAMic3KENhSaaJujfHkzM5c5o5yoRwuR07AsrZvksu5MzWcS
         9V+tcvD/eQskWsIKPPj4C3+1swekAX49p4LIHjrRvxav1iVCW+Yn6PkXYvqz1hzwIXm0
         lXyw==
X-Gm-Message-State: AOAM531+pQ1yvEsEei0Ul/PYAHbB7QOzymidL3htHxMhdKyfmB8HagMK
        pUAkfH9j5yHFuMK2atPDIn/AXQ==
X-Google-Smtp-Source: ABdhPJzR1j4kVFBfddGNf4girU0lRaR4WWpFTyTmSUL3GfaKPQjhg/61rGOYWwxAZBe0uYES+7+hYw==
X-Received: by 2002:a7b:c1cd:: with SMTP id a13mr4615406wmj.75.1626881892925;
        Wed, 21 Jul 2021 08:38:12 -0700 (PDT)
Received: from localhost.localdomain ([149.86.71.195])
        by smtp.gmail.com with ESMTPSA id n18sm26209714wrt.89.2021.07.21.08.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 08:38:12 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Quentin Monnet <quentin@isovalent.com>,
        John Fastabend <john.fastabend@gmail.com>
Subject: [PATCH bpf-next v2 1/5] libbpf: rename btf__load() as btf__load_into_kernel()
Date:   Wed, 21 Jul 2021 16:38:04 +0100
Message-Id: <20210721153808.6902-2-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210721153808.6902-1-quentin@isovalent.com>
References: <20210721153808.6902-1-quentin@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

As part of the effort to move towards a v1.0 for libbpf, rename
btf__load() function, used to "upload" BTF information into the kernel,
as btf__load_into_kernel(). This new name better reflects what the
function does.

References:

- https://github.com/libbpf/libbpf/issues/278
- https://github.com/libbpf/libbpf/wiki/Libbpf:-the-road-to-v1.0#btfh-apis

v2: Declare the new symbol in libbpf.map as v0.5.0 API (and not v0.6.0).

Signed-off-by: Quentin Monnet <quentin@isovalent.com>
Acked-by: John Fastabend <john.fastabend@gmail.com>
---
 tools/lib/bpf/btf.c      | 3 ++-
 tools/lib/bpf/btf.h      | 1 +
 tools/lib/bpf/libbpf.c   | 2 +-
 tools/lib/bpf/libbpf.map | 1 +
 4 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index b46760b93bb4..7e0de560490e 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -1180,7 +1180,7 @@ int btf__finalize_data(struct bpf_object *obj, struct btf *btf)
 
 static void *btf_get_raw_data(const struct btf *btf, __u32 *size, bool swap_endian);
 
-int btf__load(struct btf *btf)
+int btf__load_into_kernel(struct btf *btf)
 {
 	__u32 log_buf_size = 0, raw_size;
 	char *log_buf = NULL;
@@ -1228,6 +1228,7 @@ int btf__load(struct btf *btf)
 	free(log_buf);
 	return libbpf_err(err);
 }
+int btf__load(struct btf *) __attribute__((alias("btf__load_into_kernel")));
 
 int btf__fd(const struct btf *btf)
 {
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 374e9f15de2e..fd8a21d936ef 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -46,6 +46,7 @@ LIBBPF_API struct btf *btf__parse_raw_split(const char *path, struct btf *base_b
 
 LIBBPF_API int btf__finalize_data(struct bpf_object *obj, struct btf *btf);
 LIBBPF_API int btf__load(struct btf *btf);
+LIBBPF_API int btf__load_into_kernel(struct btf *btf);
 LIBBPF_API __s32 btf__find_by_name(const struct btf *btf,
 				   const char *type_name);
 LIBBPF_API __s32 btf__find_by_name_kind(const struct btf *btf,
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 4c153c379989..242e97892043 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2774,7 +2774,7 @@ static int bpf_object__sanitize_and_load_btf(struct bpf_object *obj)
 		 */
 		btf__set_fd(kern_btf, 0);
 	} else {
-		err = btf__load(kern_btf);
+		err = btf__load_into_kernel(kern_btf);
 	}
 	if (sanitize) {
 		if (!err) {
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 5bfc10722647..f7d52d76ca3a 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -373,6 +373,7 @@ LIBBPF_0.5.0 {
 		bpf_map__initial_value;
 		bpf_map_lookup_and_delete_elem_flags;
 		bpf_object__gen_loader;
+		btf__load_into_kernel;
 		btf_dump__dump_type_data;
 		libbpf_set_strict_mode;
 } LIBBPF_0.4.0;
-- 
2.30.2

