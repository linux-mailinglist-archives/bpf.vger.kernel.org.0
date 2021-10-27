Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 728E943D2FB
	for <lists+bpf@lfdr.de>; Wed, 27 Oct 2021 22:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243990AbhJ0UkI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Oct 2021 16:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243977AbhJ0UkI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Oct 2021 16:40:08 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F00C061745
        for <bpf@vger.kernel.org>; Wed, 27 Oct 2021 13:37:42 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id c28so3711148qtv.11
        for <bpf@vger.kernel.org>; Wed, 27 Oct 2021 13:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BiKXyR+2EwCLBOd+fRCHU3sU/4vHBkBDpQ5aLFrvLU4=;
        b=kACHc01Vt6TlRVG3UMWLtj/2lBF+N18CUNQLBwkDnbK36pRrIl3IUx9PIANKlTrDyQ
         CvHr2FfY3M9ERE6KmN4RnLp7JFtBO3OXyY1QYiNAvtJN0EYcMdviV0hslGbCBjBA+uV8
         VK+QJ3aA2R2AQ8HxyUNIzTB75YLSNK0/pUvJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BiKXyR+2EwCLBOd+fRCHU3sU/4vHBkBDpQ5aLFrvLU4=;
        b=IdT+hScsafrwf/ZP3dHz4eiwcQp7ByNkD0oPh+9lYpAL7nX8uaQZgdnoJQ3ALqG8lL
         s1BPw0ohM3M/hYlv8qkRlzNuKeLIQohR2LPNBtMlcz7pzv7N0wh5vfjb7K1yzMa6dXIj
         Ydo/f0ltRtOAu/ueInPwZQVilxcNI1X2di72udVsHM3uEN4if1VCC4ZcLGJNAmv5yRbp
         EZ+Tx+i4qcDCpSG2yaTNEduCZvZXo5AuZ14ULfb4AfUooPLujOR6ilzyCex+vzwBe0NN
         VeOQAn8m59y3YrhDhQY7D4ZzbO4lKSpznPrtzxeOyu9X4LIwhNdSW2IuKEerMF4utvvb
         KQ9A==
X-Gm-Message-State: AOAM532xsqX8G+RqBjQkVN/6UJkPjLMz9QpdvIcgYzExZJtff7b6GBir
        bKE94Wh7CWUq6Xwyv9C48qrCfg==
X-Google-Smtp-Source: ABdhPJyMrPa2OOaSwEm0XXr3PnVmWfcb40WrrRPkNM12GsLtI6rHJUikGpjPkt4JftuXzyX/PfW63A==
X-Received: by 2002:ac8:5747:: with SMTP id 7mr26577qtx.43.1635367060840;
        Wed, 27 Oct 2021 13:37:40 -0700 (PDT)
Received: from localhost.localdomain ([191.91.82.96])
        by smtp.gmail.com with ESMTPSA id 14sm696790qtp.97.2021.10.27.13.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 13:37:40 -0700 (PDT)
From:   =?UTF-8?q?Mauricio=20V=C3=A1squez?= <mauricio@kinvolk.io>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Rafael David Tinoco <rafaeldtinoco@gmail.com>,
        Rafael David Tinoco <rafael.tinoco@aquasec.com>,
        Lorenzo Fontana <lorenzo.fontana@elastic.co>
Subject: [PATCH bpf-next 1/2] libbpf: Implement btf__save_to_file()
Date:   Wed, 27 Oct 2021 15:37:26 -0500
Message-Id: <20211027203727.208847-2-mauricio@kinvolk.io>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211027203727.208847-1-mauricio@kinvolk.io>
References: <20211027203727.208847-1-mauricio@kinvolk.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Implement helper function to save the contents of a BTF object to a
file.

Signed-off-by: Mauricio Vásquez <mauricio@kinvolk.io>
Signed-off-by: Rafael David Tinoco <rafael.tinoco@aquasec.com>
Signed-off-by: Lorenzo Fontana <lorenzo.fontana@elastic.co>
---
 tools/lib/bpf/btf.c      | 22 ++++++++++++++++++++++
 tools/lib/bpf/btf.h      |  2 ++
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 25 insertions(+)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 0c628c33e23b..087035574dba 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -4773,3 +4773,25 @@ int btf_ext_visit_str_offs(struct btf_ext *btf_ext, str_off_visit_fn visit, void
 
 	return 0;
 }
+
+int btf__save_to_file(struct btf *btf, const char *path)
+{
+	const void *data;
+	__u32 data_sz;
+	FILE *file;
+
+	data = btf_get_raw_data(btf, &data_sz, btf->swapped_endian);
+	if (!data)
+		return -ENOMEM;
+
+	file = fopen(path, "wb");
+	if (!file)
+		return -errno;
+
+	if (fwrite(data, 1, data_sz, file) != data_sz) {
+		fclose(file);
+		return -EIO;
+	}
+
+	return fclose(file);
+}
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index bc005ba3ceec..300ad498c615 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -114,6 +114,8 @@ LIBBPF_API struct btf *btf__parse_elf_split(const char *path, struct btf *base_b
 LIBBPF_API struct btf *btf__parse_raw(const char *path);
 LIBBPF_API struct btf *btf__parse_raw_split(const char *path, struct btf *base_btf);
 
+LIBBPF_API int btf__save_to_file(struct btf *btf, const char *path);
+
 LIBBPF_API struct btf *btf__load_vmlinux_btf(void);
 LIBBPF_API struct btf *btf__load_module_btf(const char *module_name, struct btf *vmlinux_btf);
 LIBBPF_API struct btf *libbpf_find_kernel_btf(void);
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 15239c05659c..0e9bed7c9b9e 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -399,4 +399,5 @@ LIBBPF_0.6.0 {
 		btf__add_decl_tag;
 		btf__raw_data;
 		btf__type_cnt;
+		btf__save_to_file;
 } LIBBPF_0.5.0;
-- 
2.25.1

