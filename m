Return-Path: <bpf+bounces-47958-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD66AA02899
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 15:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A01207A1177
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 14:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C2913B58E;
	Mon,  6 Jan 2025 14:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KoDsvIFM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0CB433CB
	for <bpf@vger.kernel.org>; Mon,  6 Jan 2025 14:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736175251; cv=none; b=Ndot5fDp4fstBgIVdwaDYVhIHM9tGJLYXH2meLEzrNfygCvPJ4yuFCT12K2iU0GM4cSK+ZRoEyRPyseIBuGJLd2YVbZJu8MirCe4MhylzCeYCH4K4gxoX3yD5I0DSmPLomVsTGkzh8Ux1e0D3b770fTuN5XKneuysy8m9Wkt/CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736175251; c=relaxed/simple;
	bh=vD7OoCYZuWUrIQLKYDenhdTT+7LqLcv3pmLsJjxvzE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UniWnpPDVrDCKbJl5F/Yg827xIOJQ8YbbPRH0XBoKsstHT1adIKsQLwhez9R2u0oYRQGTlntOEZXUqrI1ldQnmE0ycDWo/MEZu7zi9jFtJi8hgxwHvLXvrrhmnrLzYnRpCo4mtFNCrd9oTX8J2rzbgUDnWGXgaY4p3VmM3Dlm+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KoDsvIFM; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-385ef8b64b3so11328068f8f.0
        for <bpf@vger.kernel.org>; Mon, 06 Jan 2025 06:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736175246; x=1736780046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qLp9LvPNwq2kCY8NmpKp7heM93uAueEYhhM+Oqp3y0M=;
        b=KoDsvIFM4gbqiRleegWuBFPTMtjxWvJaXTRN89vrNSDF4PuusIhEX/XUBeDT5TPhva
         tqdEj0GRF1LycqQDE2WjtjRejAC0ltTh9Q/lzpWUAzf2p0jRbCMpZxndjT3jpyjRyaaR
         rdkfK8/SZE3/C4s0aAWed2nKfJMwecDsk0lh5ckAAEBC8JQnpTPHOncSTZGGI4qgf8te
         VqJkD84a+x85APalHpb2AOkqu9czVnbrPLKhls3eFvNhbLDIh4h2f2ZMz4V7s5W4blHj
         RHIvJy51YD8YFxO6GngbVFDfHSoHIL+lKKjq+at1IRzuQfjMxAtjU7VwinPKzI191vkc
         Lg6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736175246; x=1736780046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qLp9LvPNwq2kCY8NmpKp7heM93uAueEYhhM+Oqp3y0M=;
        b=WGM3kVkYliBpwGL0qoMBneYF8Hw5LHFdwNifIG2hW6dB57ltbCR5gMx09Ddfj0f+FA
         BeAEfkpgvM6FT1r43zb2Fe7GcWAT4r7ibqU0yOuUnijBkscDQpPXOJ+q47lw84vDqVUF
         yBwz3sfnXuvnR0pIydw1jP/tW9IAz9O6Q7/p29FqyW2zFrSiD5GCTUDAlzXZXgpb+PPN
         somyr59n6JJtmSSm9sq6pdwjWcWSi++aqKReUH9IZg809+cXj5ZOY9eEc8z5GzNeMSyC
         9dZ/M+p6/OHLgrwFMVhkVLTpEfYq6BKh5Xzs2zstm726FK9prhXRFYbmFlsequMW0RiM
         CPIQ==
X-Gm-Message-State: AOJu0Yz3ux8JrzotBgQW9PSiJLDgUuTONRt57ykW1CxgvPKmQcuVPwVu
	3OXz0SASzLsoUyMuavu8B844BZ1h2Wjs2ruTH1R5fjVb7qP3fkqwnKatpLl+BFezbA==
X-Gm-Gg: ASbGnctuEeH7eCQKNmpqQCkNg/LRMXAK/Hum9371xo2a8NCMDDGuAp5oKi4ch2RVtSa
	dO/scDNp3sdqN5LoAkI+nKxHNPHRD2RtB0RhvBreib0KD35Cg3RAIgDZJ8KagbUSUrShZMBlG7t
	vIg6SMZTm2oZRFm8XDcE3AAjLACTwSMBjd3TJW1YZwFebdiXb4tntQ8SU2KtCxOOVodG+peho9K
	qlgAwpTJ35TdUFVeZ0B5BGvnok/Vkr2XNObJxyCRpqapAiojc9y8OlhNTZqHx45ixNaLvjhMus=
X-Google-Smtp-Source: AGHT+IHsOOu+CCVWgz/n42h2Ko995f4jGOVQjt9NKSe1T9RcvY42dKw9FJCE353NCbxHI7BWZMgyfw==
X-Received: by 2002:a05:6000:2ae:b0:385:ed16:c97 with SMTP id ffacd0b85a97d-38a224088aemr44648623f8f.49.1736175246287;
        Mon, 06 Jan 2025 06:54:06 -0800 (PST)
Received: from babis.. ([2a02:3033:700:3ba2:3837:7343:334:7680])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c832e74sm47389982f8f.30.2025.01.06.06.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 06:54:05 -0800 (PST)
From: Charalampos Stylianopoulos <charalampos.stylianopoulos@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Nick Zavaritsky <mejedi@gmail.com>,
	Charalampos Stylianopoulos <charalampos.stylianopoulos@gmail.com>
Subject: [PATCH bpf-next 3/4] libbpf: Add support for MAP_GET_NUM_ENTRIES command
Date: Mon,  6 Jan 2025 15:53:27 +0100
Message-ID: <20250106145328.399610-4-charalampos.stylianopoulos@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250106145328.399610-1-charalampos.stylianopoulos@gmail.com>
References: <20250106145328.399610-1-charalampos.stylianopoulos@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the libbpf API to provide support for getting the number of
entries in a map.

Co-developed-by: Nick Zavaritsky <mejedi@gmail.com>
Signed-off-by: Nick Zavaritsky <mejedi@gmail.com>
Signed-off-by: Charalampos Stylianopoulos <charalampos.stylianopoulos@gmail.com>
---
 tools/include/uapi/linux/bpf.h | 17 +++++++++++++++++
 tools/lib/bpf/bpf.c            | 16 ++++++++++++++++
 tools/lib/bpf/bpf.h            |  2 ++
 tools/lib/bpf/libbpf.map       |  1 +
 4 files changed, 36 insertions(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 2acf9b336371..f5c7adea1387 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -903,6 +903,17 @@ union bpf_iter_link_info {
  *		A new file descriptor (a nonnegative integer), or -1 if an
  *		error occurred (in which case, *errno* is set appropriately).
  *
+ * BPF_MAP_GET_NUM_ENTRIES
+ *	Description
+ *		Get the number of entries currently present in the map.
+ *
+ *		This operation is supported only for a subset of maps. If the
+ *		map is not supported, the operation returns **EOPNOTSUPP**.
+ *
+ *	Return
+ *		Returns zero on success. On error, -1 is returned and *errno*
+ *		is set appropriately.
+ *
  * NOTES
  *	eBPF objects (maps and programs) can be shared between processes.
  *
@@ -958,6 +969,7 @@ enum bpf_cmd {
 	BPF_LINK_DETACH,
 	BPF_PROG_BIND_MAP,
 	BPF_TOKEN_CREATE,
+	BPF_MAP_GET_NUM_ENTRIES,
 	__MAX_BPF_CMD,
 };
 
@@ -1837,6 +1849,11 @@ union bpf_attr {
 		__u32		bpffs_fd;
 	} token_create;
 
+	struct { /* struct used by BPF_MAP_GET_NUM_ENTRIES command*/
+		__u32 map_fd;
+		__u32 num_entries;
+	} map_get_num_entries;
+
 } __attribute__((aligned(8)));
 
 /* The description below is an attempt at providing documentation to eBPF
diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 359f73ead613..c91f43690624 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -1330,3 +1330,19 @@ int bpf_token_create(int bpffs_fd, struct bpf_token_create_opts *opts)
 	fd = sys_bpf_fd(BPF_TOKEN_CREATE, &attr, attr_sz);
 	return libbpf_err_errno(fd);
 }
+
+int bpf_map_get_num_entries(int fd, unsigned int *num_entries)
+{
+	const size_t attr_sz = offsetofend(union bpf_attr, map_get_num_entries);
+	union bpf_attr attr;
+	int ret;
+
+	memset(&attr, 0, attr_sz);
+	attr.map_get_num_entries.map_fd = fd;
+
+	ret = sys_bpf(BPF_MAP_GET_NUM_ENTRIES, &attr, attr_sz);
+	if (!ret)
+		*num_entries = attr.map_get_num_entries.num_entries;
+
+	return libbpf_err_errno(ret);
+}
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 435da95d2058..efa5a092acc9 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -653,6 +653,8 @@ struct bpf_prog_bind_opts {
 LIBBPF_API int bpf_prog_bind_map(int prog_fd, int map_fd,
 				 const struct bpf_prog_bind_opts *opts);
 
+LIBBPF_API int bpf_map_get_num_entries(int fd, unsigned int *num_entries);
+
 struct bpf_test_run_opts {
 	size_t sz; /* size of this struct for forward/backward compatibility */
 	const void *data_in; /* optional */
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index a8b2936a1646..63dbad55cc2d 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -436,4 +436,5 @@ LIBBPF_1.6.0 {
 		bpf_linker__add_buf;
 		bpf_linker__add_fd;
 		bpf_linker__new_fd;
+		bpf_map_get_num_entries;
 } LIBBPF_1.5.0;
-- 
2.43.0


