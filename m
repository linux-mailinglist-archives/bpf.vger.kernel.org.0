Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A814A9EB8
	for <lists+bpf@lfdr.de>; Fri,  4 Feb 2022 19:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377410AbiBDSMV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Feb 2022 13:12:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349855AbiBDSMU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Feb 2022 13:12:20 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A852C06173D
        for <bpf@vger.kernel.org>; Fri,  4 Feb 2022 10:12:20 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id h7so21785169ejf.1
        for <bpf@vger.kernel.org>; Fri, 04 Feb 2022 10:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2bFLBvCTLo6AxFGjYZpL4gtf6dLLHBEULhx5YrMA4Bc=;
        b=itKbzeQTt9l3gNzpediJbLsupXXIny6vlRLBlx0ln/wTte32c/YTBv9sFNkJJ+6dDX
         CGXZXdwhhdZxfIPHmsBGuz72ICCN1mRSJoOhWimkTwc/xN1lRxdZ1etgc8VIw2pYpL9p
         vsZhxIxCaQZFnivI0oa/G1HKq21fcnbddSUf1iY8plzxG47uTy5+MFw7uCmedBFBJuUc
         lBsqcoePsyVKtHZfURxgAO2bgPOK5lA5stX/andDj7BjUWr7LN08465FojsnfDZg12pB
         B8c8EZpVen+yZquzpxKITuha201x9G9XvuBjpB0SCsK2qN+/A4/4OdSF1SpWkKqwcJVA
         KpCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2bFLBvCTLo6AxFGjYZpL4gtf6dLLHBEULhx5YrMA4Bc=;
        b=TT5j2Kiih0qUIRdXLe3Txs2Ftutv4ZEdLCjVzXIBIu8ceh3nGOD0PV3GaZ5qlcTENI
         VwCmBy0J4v8zgmhdX/t3kzbSAv/DV8lNISDwWQrEFaQ1ovGWBNCT77H8bELfZTAsC4TF
         YlWYieaT5Q/+qNtUyH/cZcvwqM0oLopBnuwPcp/EG+A4DgMU1PV7tgP99Pqb4ttf/cSD
         V6uYLbAKXzj6jHwZ8RztcJcsWSG+41Q2zTygm7Vu9DKQH47qKYib1gbfE3LKpbmQuTQT
         7o5cm1A5VABRf5LwUS8tv/5w6FjMg3QiGHeTpK8nlq1dIq8smlRV3UthZldsilrtbU3Q
         r3MA==
X-Gm-Message-State: AOAM532QJhPFP6OxktaBz4FawG9KqiRPfpgTahQeNEWYcLX/iLzkr9Zm
        mhafOUDnLxIznMwIJjWu7B7VVbTMD+E=
X-Google-Smtp-Source: ABdhPJz6b5k3A5oeqOfC1cEZDVgyNAhdvbkCR/nzMDPi+k2DuFt7/ZwRPjual/XO+EQMevvQWS0eqw==
X-Received: by 2002:a17:906:d283:: with SMTP id ay3mr76655ejb.249.1643998338819;
        Fri, 04 Feb 2022 10:12:18 -0800 (PST)
Received: from erthalion.local (dslb-178-012-046-224.178.012.pools.vodafone-ip.de. [178.12.46.224])
        by smtp.gmail.com with ESMTPSA id lo15sm888646ejb.28.2022.02.04.10.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 10:12:18 -0800 (PST)
From:   Dmitrii Dolgov <9erthalion6@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, quentin@isovalent.com
Cc:     Dmitrii Dolgov <9erthalion6@gmail.com>
Subject: [RFC PATCH v2] bpftool: Add bpf_cookie to link output
Date:   Fri,  4 Feb 2022 19:11:46 +0100
Message-Id: <20220204181146.8429-1-9erthalion6@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit 82e6b1eee6a8 ("bpf: Allow to specify user-provided bpf_cookie for
BPF perf links") introduced the concept of user specified bpf_cookie,
which could be accessed by BPF programs using bpf_get_attach_cookie().
For troubleshooting purposes it is convenient to expose bpf_cookie via
bpftool as well, so there is no need to meddle with the target BPF
program itself.

    $ bpftool link
    1: type 7  prog 5  bpf_cookie 123
        pids bootstrap(87)

Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
---
Changes in v2:
    - Display bpf_cookie in bpftool link command instead perf

    Previous discussion: https://lore.kernel.org/bpf/20220127082649.12134-1-9erthalion6@gmail.com

 include/uapi/linux/bpf.h       |  3 +++
 kernel/bpf/syscall.c           | 13 +++++++++++++
 tools/bpf/bpftool/link.c       |  2 ++
 tools/include/uapi/linux/bpf.h |  3 +++
 4 files changed, 21 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index a7f0ddedac1f..600da4496404 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5850,6 +5850,9 @@ struct bpf_link_info {
 			__u32 target_obj_id; /* prog_id for PROG_EXT, otherwise btf object id */
 			__u32 target_btf_id; /* BTF type id inside the object */
 		} tracing;
+		struct {
+			__u64 bpf_cookie;
+		} perf;
 		struct {
 			__u64 cgroup_id;
 			__u32 attach_type;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 72ce1edde950..94b7fa777fc7 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2948,6 +2948,7 @@ static const struct bpf_link_ops bpf_raw_tp_link_lops = {
 struct bpf_perf_link {
 	struct bpf_link link;
 	struct file *perf_file;
+	u64 bpf_cookie;
 };
 
 static void bpf_perf_link_release(struct bpf_link *link)
@@ -2966,9 +2967,20 @@ static void bpf_perf_link_dealloc(struct bpf_link *link)
 	kfree(perf_link);
 }
 
+static int bpf_perf_link_fill_link_info(const struct bpf_link *link,
+					  struct bpf_link_info *info)
+{
+	struct bpf_perf_link *perf_link =
+		container_of(link, struct bpf_perf_link, link);
+
+	info->perf.bpf_cookie = perf_link->bpf_cookie;
+	return 0;
+}
+
 static const struct bpf_link_ops bpf_perf_link_lops = {
 	.release = bpf_perf_link_release,
 	.dealloc = bpf_perf_link_dealloc,
+	.fill_link_info = bpf_perf_link_fill_link_info,
 };
 
 static int bpf_perf_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
@@ -2993,6 +3005,7 @@ static int bpf_perf_link_attach(const union bpf_attr *attr, struct bpf_prog *pro
 	}
 	bpf_link_init(&link->link, BPF_LINK_TYPE_PERF_EVENT, &bpf_perf_link_lops, prog);
 	link->perf_file = perf_file;
+	link->bpf_cookie = attr->link_create.perf_event.bpf_cookie;
 
 	err = bpf_link_prime(&link->link, &link_primer);
 	if (err) {
diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index 97dec81950e5..3ddeacb3593f 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -243,6 +243,8 @@ static int show_link_close_plain(int fd, struct bpf_link_info *info)
 		printf("\n\tnetns_ino %u  ", info->netns.netns_ino);
 		show_link_attach_type_plain(info->netns.attach_type);
 		break;
+	case BPF_LINK_TYPE_PERF_EVENT:
+		printf("\n\tbpf_cookie %llu  ", info->perf.bpf_cookie);
 	default:
 		break;
 	}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index a7f0ddedac1f..600da4496404 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5850,6 +5850,9 @@ struct bpf_link_info {
 			__u32 target_obj_id; /* prog_id for PROG_EXT, otherwise btf object id */
 			__u32 target_btf_id; /* BTF type id inside the object */
 		} tracing;
+		struct {
+			__u64 bpf_cookie;
+		} perf;
 		struct {
 			__u64 cgroup_id;
 			__u32 attach_type;
-- 
2.32.0

