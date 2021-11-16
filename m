Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9063C4537EE
	for <lists+bpf@lfdr.de>; Tue, 16 Nov 2021 17:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235391AbhKPQpX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Nov 2021 11:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234638AbhKPQpX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Nov 2021 11:45:23 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B747C061570
        for <bpf@vger.kernel.org>; Tue, 16 Nov 2021 08:42:26 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id p4so12786931qkm.7
        for <bpf@vger.kernel.org>; Tue, 16 Nov 2021 08:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sxz4D6uLOmqsmbyo2QO6wq5cXgoWWcc31npQo/Aiwtg=;
        b=jAq2hNFk8MaTn0aZHXzRrlb5ocwWptvh72PyzwxQqZZWMX+eqaGYZJouQSROdnUKWb
         yOHAJquGCUM3FX+hZDuMp2adj2tuW+jM75i7TeSYxFrUkbBFte9wfINyyQCuppRVfDeT
         JqkkGe63hepnhLlC0nKqzmCAqbv/jsYPevv0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sxz4D6uLOmqsmbyo2QO6wq5cXgoWWcc31npQo/Aiwtg=;
        b=p7/ms6m20MXFYH7R52/5hlQdMC4mMJntmwm0p5JfdlplJ9iBZViR4dbzngi6ALwV54
         PdzoIB6Me+DORL8oZUk7sf/08xMSg7N+Lb1AvuPwO0fDTzGAzQzAO8TfZRc8cty6HuPo
         9i6mhfYxYEjpP8VHQhUNERvYiEpzoyU5dxD6MvhLlcz6JwUaYvgyno2W5UzegtTtzbN2
         DTJA6yDIyB+EZ7o6s/sjzAK7ioEC33OnNKuD/9gCqJMyHfdNR2npwgMQxHViUa2m0U73
         CuEUs5bEDLkNXYeue0YH/vDeNbQsO0UdXo1wg1EUnvI5ixTOxREmtNdICNbV8fuwAHJt
         dF5w==
X-Gm-Message-State: AOAM530BlgdPJZVRxOS+HcPZ+Y4XfZ0XVQ94a1F2q9UR2Y5Zg6Om+BTh
        ogNhFWf+mOvMQv/RrvIcUTcMIQ==
X-Google-Smtp-Source: ABdhPJxQdlx5k20QPqy421Fx3yQW6Vxvr/3v+SmCGcLsjvKUmXKqbYIygSIn15UJkuVfQl7khR8o1A==
X-Received: by 2002:ae9:e30b:: with SMTP id v11mr7513837qkf.329.1637080945413;
        Tue, 16 Nov 2021 08:42:25 -0800 (PST)
Received: from localhost.localdomain ([191.91.82.96])
        by smtp.gmail.com with ESMTPSA id bk18sm7309121qkb.35.2021.11.16.08.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 08:42:25 -0800 (PST)
From:   =?UTF-8?q?Mauricio=20V=C3=A1squez?= <mauricio@kinvolk.io>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Rafael David Tinoco <rafaeldtinoco@gmail.com>,
        Lorenzo Fontana <lorenzo.fontana@elastic.co>,
        Leonardo Di Donato <leonardo.didonato@elastic.co>
Subject: [PATCH bpf-next v2 1/4] libbpf: Implement btf__save_raw()
Date:   Tue, 16 Nov 2021 11:42:05 -0500
Message-Id: <20211116164208.164245-2-mauricio@kinvolk.io>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211116164208.164245-1-mauricio@kinvolk.io>
References: <20211116164208.164245-1-mauricio@kinvolk.io>
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
Signed-off-by: Leonardo Di Donato <leonardo.didonato@elastic.co>
---
 tools/lib/bpf/btf.c      | 30 ++++++++++++++++++++++++++++++
 tools/lib/bpf/btf.h      |  2 ++
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 33 insertions(+)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index fadf089ae8fe..96a242f91832 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -1121,6 +1121,36 @@ struct btf *btf__parse_split(const char *path, struct btf *base_btf)
 	return libbpf_ptr(btf_parse(path, base_btf, NULL));
 }
 
+int btf__save_raw(const struct btf *btf, const char *path)
+{
+	const void *data;
+	FILE *f = NULL;
+	__u32 data_sz;
+	int err = 0;
+
+	data = btf__raw_data(btf, &data_sz);
+	if (!data) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	f = fopen(path, "wb");
+	if (!f) {
+		err = -errno;
+		goto out;
+	}
+
+	if (fwrite(data, 1, data_sz, f) != data_sz) {
+		err = -errno;
+		goto out;
+	}
+
+out:
+	if (f)
+		fclose(f);
+	return libbpf_err(err);
+}
+
 static void *btf_get_raw_data(const struct btf *btf, __u32 *size, bool swap_endian);
 
 int btf__load_into_kernel(struct btf *btf)
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 5c73a5b0a044..4f8d3f303aa6 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -114,6 +114,8 @@ LIBBPF_API struct btf *btf__parse_elf_split(const char *path, struct btf *base_b
 LIBBPF_API struct btf *btf__parse_raw(const char *path);
 LIBBPF_API struct btf *btf__parse_raw_split(const char *path, struct btf *base_btf);
 
+LIBBPF_API int btf__save_raw(const struct btf *btf, const char *path);
+
 LIBBPF_API struct btf *btf__load_vmlinux_btf(void);
 LIBBPF_API struct btf *btf__load_module_btf(const char *module_name, struct btf *vmlinux_btf);
 LIBBPF_API struct btf *libbpf_find_kernel_btf(void);
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 6a59514a48cf..c9555f8655af 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -414,4 +414,5 @@ LIBBPF_0.6.0 {
 		perf_buffer__new_deprecated;
 		perf_buffer__new_raw;
 		perf_buffer__new_raw_deprecated;
+		btf__save_raw;
 } LIBBPF_0.5.0;
-- 
2.25.1

