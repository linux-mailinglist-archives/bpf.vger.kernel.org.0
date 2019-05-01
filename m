Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9C8C10960
	for <lists+bpf@lfdr.de>; Wed,  1 May 2019 16:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfEAOoo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 May 2019 10:44:44 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39322 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726972AbfEAOoT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 May 2019 10:44:19 -0400
Received: by mail-wr1-f66.google.com with SMTP id a9so24832089wrp.6
        for <bpf@vger.kernel.org>; Wed, 01 May 2019 07:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NA7Zmed3nLQuw1MNsM252lDKOYqIIWGI4OywzuFN9TQ=;
        b=efaTK3QOYJTzeN234cT8/TW+cOGl6aevy736HU3ec11UIOhF2oN/WjF84UDY/3WFVi
         WxWSwnPHK0OYG0iRVCtoZPV5hNbMncL0mxvxZv4iCP4/qPaYM+2UVRx2jjyFxVpj1Hc/
         D3EJo/tjIy48j4xwnGjuRzGqRj2WLwS8Ro/AOyTxP0qrDrRoDKreP9SPKsWnHuR9LwUh
         qZvSbMqKVdSL/ruFIHBwe77OrN19zCN2JjJuULIs7QLARjfVGcn2EjjFXabNuzxCrnXR
         pIE0GoQyHvMDumFHz1AxDW6GdUHf5JioUYRG6wFBh27UBCWGhs2WNZ7T3uKWx6jpAqDe
         w5ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NA7Zmed3nLQuw1MNsM252lDKOYqIIWGI4OywzuFN9TQ=;
        b=Pqvu6WT8pO+sYU7Bt0y76j1as+QEX6jrV15GJx23051oE+iTqclHnmDTvmXU4J2fRo
         j0Da6TuZEvfPOHJMg4WT1q5ggSrizmUF9HbieDEr8zS/ErofSbnvmiteIEYaJ/pYPn68
         ZUHW0QU4+4R7Jt21Ab1N5T+40rP5bqqvPUVo6Og04vDfL2xTcfC5S7SjjzfglpX3YQTT
         ubsR57D9+nOybTM5ZJK/kHpMF1IwzClsmRTR9kv1FR7FhixUUBIW8N+6g2yf+XBBfi/P
         B4dyzMcmkynAMZWrLg0lYUIIbBq/Pg/+bsyIYSYVQlRa8ceBLKHsCoDnfn9xhA+7K3Qf
         N4vA==
X-Gm-Message-State: APjAAAX25I+luq52wQYtSOoS/cWnh1RT7Hk/IkMB6SCTRlEwLXgmWifG
        2zwf/BEtNZmMpqSF1GBGbWG9Nw==
X-Google-Smtp-Source: APXvYqybOBicEamt+IW8nAF7Zw4ZcWxtA/sP1yasljQQUyabYYDRiluBHswNRBFdDD6V+xhtHkyyww==
X-Received: by 2002:adf:b611:: with SMTP id f17mr2836936wre.162.1556721858049;
        Wed, 01 May 2019 07:44:18 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id g10sm36164976wrq.2.2019.05.01.07.44.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 May 2019 07:44:17 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, Jiong Wang <jiong.wang@netronome.com>
Subject: [PATCH v5 bpf-next 08/17] libbpf: add "prog_flags" to bpf_program/bpf_prog_load_attr/bpf_load_program_attr
Date:   Wed,  1 May 2019 15:43:53 +0100
Message-Id: <1556721842-29836-9-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556721842-29836-1-git-send-email-jiong.wang@netronome.com>
References: <1556721842-29836-1-git-send-email-jiong.wang@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

libbpf doesn't allow passing "prog_flags" during bpf program load in a
couple of load related APIs, "bpf_load_program_xattr", "load_program" and
"bpf_prog_load_xattr".

It makes sense to allow passing "prog_flags" which is useful for
customizing program loading.

Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
---
 tools/lib/bpf/bpf.c    | 1 +
 tools/lib/bpf/bpf.h    | 1 +
 tools/lib/bpf/libbpf.c | 3 +++
 tools/lib/bpf/libbpf.h | 1 +
 4 files changed, 6 insertions(+)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 955191c..f79ec49 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -254,6 +254,7 @@ int bpf_load_program_xattr(const struct bpf_load_program_attr *load_attr,
 	if (load_attr->name)
 		memcpy(attr.prog_name, load_attr->name,
 		       min(strlen(load_attr->name), BPF_OBJ_NAME_LEN - 1));
+	attr.prog_flags = load_attr->prog_flags;
 
 	fd = sys_bpf_prog_load(&attr, sizeof(attr));
 	if (fd >= 0)
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 9593fec..ff42ca0 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -87,6 +87,7 @@ struct bpf_load_program_attr {
 	const void *line_info;
 	__u32 line_info_cnt;
 	__u32 log_level;
+	__u32 prog_flags;
 };
 
 /* Flags to direct loading requirements */
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 11a65db..debca21 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -184,6 +184,7 @@ struct bpf_program {
 	void *line_info;
 	__u32 line_info_rec_size;
 	__u32 line_info_cnt;
+	__u32 prog_flags;
 };
 
 enum libbpf_map_type {
@@ -1949,6 +1950,7 @@ load_program(struct bpf_program *prog, struct bpf_insn *insns, int insns_cnt,
 	load_attr.line_info_rec_size = prog->line_info_rec_size;
 	load_attr.line_info_cnt = prog->line_info_cnt;
 	load_attr.log_level = prog->log_level;
+	load_attr.prog_flags = prog->prog_flags;
 	if (!load_attr.insns || !load_attr.insns_cnt)
 		return -EINVAL;
 
@@ -3394,6 +3396,7 @@ int bpf_prog_load_xattr(const struct bpf_prog_load_attr *attr,
 						      expected_attach_type);
 
 		prog->log_level = attr->log_level;
+		prog->prog_flags = attr->prog_flags;
 		if (!first_prog)
 			first_prog = prog;
 	}
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index c5ff005..5abc237 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -320,6 +320,7 @@ struct bpf_prog_load_attr {
 	enum bpf_attach_type expected_attach_type;
 	int ifindex;
 	int log_level;
+	int prog_flags;
 };
 
 LIBBPF_API int bpf_prog_load_xattr(const struct bpf_prog_load_attr *attr,
-- 
2.7.4

