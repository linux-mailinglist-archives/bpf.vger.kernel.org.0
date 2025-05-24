Return-Path: <bpf+bounces-58884-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35AD1AC2CE0
	for <lists+bpf@lfdr.de>; Sat, 24 May 2025 03:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EFEB7AF833
	for <lists+bpf@lfdr.de>; Sat, 24 May 2025 01:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F241E2852;
	Sat, 24 May 2025 01:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTOt8yF4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23CF1E1E19
	for <bpf@vger.kernel.org>; Sat, 24 May 2025 01:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748049545; cv=none; b=LXuVaVaXfz9gkV816UVtX1n2+gJPg7cGZ+6uhs+lvdzJRrqYlon+kQ5bHjvWgC+VMl9s6tQh68aso+zwJJqpT9F9jfQK+xCcGSH+KhV+/ORBHGRDTt+bdkM2j+i7DgK+BibBkOqlE/zz89RiP1HfXAd0EbFaZsVeXRfR00ZS3/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748049545; c=relaxed/simple;
	bh=+agFHh9MLv2h5Iwm0m/LbaOr3NlJ73odIJZtjDH7IxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ecmQBOE0zxZ/csLHNUmDe8jH41Xr/f2vPZ29r3219XPZQfVNqQIpqPNssGxpVkYbPyEpCYbtVmEz9Gsl+CABkrjjJASL/x0IfPLnovTWAkyCY+aqBIBWy47DTAcltF+D/eloqSbS1OWyDwJ4iZA82WzpOIgcYQ0XlD2qKmo/14o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UTOt8yF4; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-3a367ec7840so305227f8f.2
        for <bpf@vger.kernel.org>; Fri, 23 May 2025 18:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748049542; x=1748654342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3iHAKenDHexbyPz9x87fuUqjnZsBU+Y2BQtgI5mpA9M=;
        b=UTOt8yF4bRpFsPNPHo6ZCMBL7cBn3IAWO61JkOQMuGnGOrlrnNWCi2cGS8fmLn01Wm
         wr4qwVlYBbZgtWn2er9j010JNaiT7xgc9ILbmMQhowO1SGtnoTt5sd6TFcMxATgnbmDt
         LgpSwHsInAQg/LG4S1aEICfgX9LM4hsNbV3Fu+c4P/jj6nagwqTmNjz4k1PB+LQ+W8rq
         Lk77yltjjAF/8XV4AHseGMoFWWsZegxlZg+AWUNyavwrMbhjCTYq0M2zkKvZIFYl+zi1
         CnKN9pO8+vbmDJO5PRhdibjdzoEfTLk+DCnqCYZwr0CTJ9NWQ/L22FGnsuQ3eeoFL8GY
         ULQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748049542; x=1748654342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3iHAKenDHexbyPz9x87fuUqjnZsBU+Y2BQtgI5mpA9M=;
        b=KbBDTuaLr8ItwoNgUhVrl5rRxvExBaoJK6fO8U8UgnjqSbsccb9Iy+3YuWuAzbiEc2
         Ax31GYu/5RPIIR6CaoDAIfpLtuJppNBA2z5g9llLOK93QfUQ7TuQNBcRS5zSWJKg8avY
         Qasv+fmHWCjJyXuQDJsPnSQmNL+66hzqlD1gd8+uM3GAVP3Yzt4caTzCWw+DEGkJXdRo
         X+/h6UDoSIFGEn2+XhBISu+hHs7PfNAatxe+uynFiRpVB5vXV87mekZqeiyK8etg9fJ4
         1g0/WR5euYdeNqs/FPAzwlgikGIMpWoZ8nASzkngetO49aJsFY1pp0qY7fNc6if7sFXq
         8NQg==
X-Gm-Message-State: AOJu0YyU3Ft+po7rhZrUjnEPQYONaKxk0JpX0BE13K0SG6QgomLgRwLT
	ZSM690JoQZO6oDjkH2x8uK2koe1xg9PfQxDSIFbHB9wYGvopC0CBjAcV28TBgfVIOU0=
X-Gm-Gg: ASbGncseuDu293slgLK0ykCSEQE3ak8KanO7JWzlTUmLSW29IXi6biH0rOF09piPHBQ
	c7aztOsDWL7zB+gy75js5rxTbURWc0rutkVZYmvYWSZBo+hkcEoWR3cnwKVR/MISmOexh08EI74
	wQWGV+yCDFYfi1T0z54eRoPgZ0EG4Cs2UfA5+Mrw1ND1J1kh0eMNzCD4Ytlbid33KvU4mGXdtwa
	Ofp9mu5pe06FysjsIf9FcaECH16nDbFvlB4NVgqfw8aBL2oKeaBUCh8li7UKwc+O3UQtcGQl9h4
	oSCK8IX2TtPf+tD5VvzYWnQgT9Lbc9OQONNYLY4Z0g==
X-Google-Smtp-Source: AGHT+IFzrLTp4gqhClj+D+Wt9S3hDNNWpgHRr5NdqHYtsg7cKasHsYam3Du1Y2IfWERfo5kmuheLDA==
X-Received: by 2002:a05:6000:2083:b0:3a0:9f24:7742 with SMTP id ffacd0b85a97d-3a4cb4b8b07mr859057f8f.41.1748049541846;
        Fri, 23 May 2025 18:19:01 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:51::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca4d1easm27672271f8f.5.2025.05.23.18.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 18:19:01 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Barret Rhoden <brho@google.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 09/11] libbpf: Introduce bpf_prog_stream_read() API
Date: Fri, 23 May 2025 18:18:47 -0700
Message-ID: <20250524011849.681425-10-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250524011849.681425-1-memxor@gmail.com>
References: <20250524011849.681425-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2750; h=from:subject; bh=+agFHh9MLv2h5Iwm0m/LbaOr3NlJ73odIJZtjDH7IxI=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBoMR3Qflk0ZgnIWWOrqHSkhCple1DSj3NDzcmhOJlg I6ydMwKJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaDEd0AAKCRBM4MiGSL8RymjeD/ sGqM/LnDaZ6uGqYNzhsQubLOqN8+B92ODZX/Dpz6gB2GWqzSaANj2ZpDKiQuub8nE4RTMpqEdlhZck TfQ+5LMjdUUrnER0i421RLiAv4gndNUQJKsLlegcg/nXLNeloYhMqkxZPvQ4ELuNC/GYw59SB5FyZo kkwoPUHrVmfUQHRnVLk9lwxEI0POUxY5sLH9yiHh4uwaTDHTZvqNa9c1ngAjo/ydwRn05WLQ+hSz1t ER3JCSsrQP5BDCVOoy1UH2TTW2bdtD1BvZn8yyKx1WvKSYwHbREO2TRU4OybWAJUafc7H16Ui7sV2b of5T27Y2ZZInwF3tx7SEI+gzV7blCWaPNhcNgQONk7l+mgDKEH8X3ebqjtDuMe911gHIppUPY1tib/ ZAGn/v8QNb0rbJsuBfeQO9Pn2WYtzGFG3l5QDmLzpO+NooGAk7FuKiPEzLd2ABmbCOwulaXG4F4OJw YHPN449oze34sdwdz/UOU/OzJsjG1miYnxCMwW/BbnQq6OEW4jdR1CvTmqoVWy3G+CUm745s+IpyoJ Ocq2Q4e45uw5CbJKuTUcR8T210CmjviogX2Hst2Sl4poEkTtfTEOVces3tVDIQxNswgN+gqTCK9f7l sCxu4vR/Xx5HUEKTXgShOqrcFS+aP9oV5G+kLOP3cpwsxsPQ50IRksYt7pkQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Introduce a libbpf API so that users can read data from a given BPF
stream for a BPF prog fd. For now, only the low-level syscall wrapper
is provided, we can add a bpf_program__* accessor as a follow up if
needed.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/lib/bpf/bpf.c      | 16 ++++++++++++++++
 tools/lib/bpf/bpf.h      | 15 +++++++++++++++
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 32 insertions(+)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index a9c3e33d0f8a..4b9f3a2096c8 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -1331,3 +1331,19 @@ int bpf_token_create(int bpffs_fd, struct bpf_token_create_opts *opts)
 	fd = sys_bpf_fd(BPF_TOKEN_CREATE, &attr, attr_sz);
 	return libbpf_err_errno(fd);
 }
+
+int bpf_prog_stream_read(int prog_fd, __u32 stream_id, void *stream_buf, __u32 stream_buf_len)
+{
+	const size_t attr_sz = offsetofend(union bpf_attr, prog_stream_read);
+	union bpf_attr attr;
+	int err;
+
+	memset(&attr, 0, attr_sz);
+	attr.prog_stream_read.stream_buf = ptr_to_u64(stream_buf);
+	attr.prog_stream_read.stream_buf_len = stream_buf_len;
+	attr.prog_stream_read.stream_id = stream_id;
+	attr.prog_stream_read.prog_fd = prog_fd;
+
+	err = sys_bpf(BPF_PROG_STREAM_READ_BY_FD, &attr, attr_sz);
+	return libbpf_err_errno(err);
+}
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 777627d33d25..9fa7be3d92d3 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -704,6 +704,21 @@ struct bpf_token_create_opts {
 LIBBPF_API int bpf_token_create(int bpffs_fd,
 				struct bpf_token_create_opts *opts);
 
+/**
+ * @brief **bpf_prog_stream_read** reads data from the BPF stream of a given BPF
+ * program.
+ *
+ * @param prog_fd FD for the BPF program whose BPF stream is to be read.
+ * @param stream_id ID of the BPF stream to be read.
+ * @param stream_buf Buffer to read data into from the BPF stream.
+ * @param stream_buf_len Maximum number of bytes to read from the BPF stream.
+ *
+ * @return The number of bytes read, on success; negative error code, otherwise
+ * (errno is also set to the error code)
+ */
+LIBBPF_API int bpf_prog_stream_read(int prog_fd, __u32 stream_id, void *stream_buf,
+				    __u32 stream_buf_len);
+
 #ifdef __cplusplus
 } /* extern "C" */
 #endif
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 1205f9a4fe04..4359527c8442 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -437,6 +437,7 @@ LIBBPF_1.6.0 {
 		bpf_linker__add_fd;
 		bpf_linker__new_fd;
 		bpf_object__prepare;
+		bpf_prog_stream_read;
 		bpf_program__func_info;
 		bpf_program__func_info_cnt;
 		bpf_program__line_info;
-- 
2.47.1


