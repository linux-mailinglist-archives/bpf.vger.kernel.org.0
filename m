Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5672A137
	for <lists+bpf@lfdr.de>; Sat, 25 May 2019 00:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404454AbfEXW1e (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 May 2019 18:27:34 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44785 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404438AbfEXW1c (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 May 2019 18:27:32 -0400
Received: by mail-wr1-f67.google.com with SMTP id w13so3024004wru.11
        for <bpf@vger.kernel.org>; Fri, 24 May 2019 15:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1ltC0XV47uD9Ss4Mv4UBpU2RzQzY2ir2n8PLOTN4Pg4=;
        b=Lzd2Pi562CN5dUPPpciDAH7Ndu7CqLbaN3ZhbzT2jcL+flBYFOIVEgxTVyKyTWNPoD
         IFC1hkyi2pEq6O+saAZIkjHBSsikkOdhT4Ixkc66eQTPSoGfMKH1ayOwSodVBxErnLT5
         bxUPu36+5WTmYrhho+fF811I5Mvau6i3QQiUNsRs9d+pWIr/B3m7Am+vvwhwMju3l19Z
         B0yMeEmBRlGaiEAj6GQmAnXC7NuVPDlf8mjtFCQIzD9Md4ZN7vnxF7ETjT73oOLaIYjt
         qSV5QyyYpUdYgJkcTVQH/WRkOFq2QfJM74j7bQxsHNiAePoe4jgpgbiT2OgKxayKt2Q2
         CxVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1ltC0XV47uD9Ss4Mv4UBpU2RzQzY2ir2n8PLOTN4Pg4=;
        b=eRjmRP4AefAzy9/z39KpUoq3EyoIlpNo0GoP2VE9SpdwYmoScNpTvT/BSFNFX3mnzz
         pQ6Txo0jVzQE+z0Fknuxd1LZawxOdfbzN2x7Sk7iIhtLvRbPgGK3q8oxm7ymbson16nK
         XyeKEZfya6cD652Ms5Xcg9wdPgqc6/ae3kxoT6nJCcRHGTJLcPTm6o67mnvnxQCcCPCj
         /UfSPaphIhd+7hNXeEsXsMluoD9OIU8SbNG3d/9dUM/TjCVXIO50YEW+sBrcZR1U6cCo
         Z6+94wQ5BN2/u6t9qko3iTzLHluOAnODw7CFrYq2bNSGE/8utvYlmQMy74FOe5IjuTh0
         rgFA==
X-Gm-Message-State: APjAAAVeMaClkv7/K7wlDeECvuv59fVqZmHSLL3eNcVDgKwkgpQRaea8
        3+DaROXdxbew1+NhxYUG/DpaRw==
X-Google-Smtp-Source: APXvYqzPN9I+pqNMS9VK98SEhJNohxyOgbEi5LTD9CBNp0wpBlA0eKf191+hJpBef0Tdl2A04zAxzA==
X-Received: by 2002:a05:6000:43:: with SMTP id k3mr64309793wrx.234.1558736850827;
        Fri, 24 May 2019 15:27:30 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id y10sm7194961wmg.8.2019.05.24.15.27.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 May 2019 15:27:30 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, davem@davemloft.net,
        paul.burton@mips.com, udknight@gmail.com, zlim.lnx@gmail.com,
        illusionist.neo@gmail.com, naveen.n.rao@linux.ibm.com,
        sandipan@linux.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, jakub.kicinski@netronome.com,
        Jiong Wang <jiong.wang@netronome.com>
Subject: [PATCH v9 bpf-next 08/17] libbpf: add "prog_flags" to bpf_program/bpf_prog_load_attr/bpf_load_program_attr
Date:   Fri, 24 May 2019 23:25:19 +0100
Message-Id: <1558736728-7229-9-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558736728-7229-1-git-send-email-jiong.wang@netronome.com>
References: <1558736728-7229-1-git-send-email-jiong.wang@netronome.com>
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
index c4a4808..0d4b4fe 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -256,6 +256,7 @@ int bpf_load_program_xattr(const struct bpf_load_program_attr *load_attr,
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
index 197b574..ff14937 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -188,6 +188,7 @@ struct bpf_program {
 	void *line_info;
 	__u32 line_info_rec_size;
 	__u32 line_info_cnt;
+	__u32 prog_flags;
 };
 
 enum libbpf_map_type {
@@ -2076,6 +2077,7 @@ load_program(struct bpf_program *prog, struct bpf_insn *insns, int insns_cnt,
 	load_attr.line_info_rec_size = prog->line_info_rec_size;
 	load_attr.line_info_cnt = prog->line_info_cnt;
 	load_attr.log_level = prog->log_level;
+	load_attr.prog_flags = prog->prog_flags;
 	if (!load_attr.insns || !load_attr.insns_cnt)
 		return -EINVAL;
 
@@ -3521,6 +3523,7 @@ int bpf_prog_load_xattr(const struct bpf_prog_load_attr *attr,
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

