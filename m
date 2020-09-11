Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAF8265D31
	for <lists+bpf@lfdr.de>; Fri, 11 Sep 2020 12:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbgIKKAN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Sep 2020 06:00:13 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33266 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725860AbgIKJ72 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 11 Sep 2020 05:59:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599818366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HpWLSZdrVk4EANVgntxWb4ENr3KvTzRCWWUjgaXP9V8=;
        b=LifmuvW6Mu9CxBFtYjukpxzQ57tLKCHJ77UMl6yrkrxU6/seRFsci63H6tnuOQ+judxAjg
        hyd3j63hBTkqhw9bjXnJx/xfhduPVcoKCu3cz/ApcV5fZ4s/iv7CfKjek0LCPpvocP1R8c
        oFTUSfYpuwjj3NJFRoEOc/F/QWOfxNY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-gjIWB3J2N7CrSHBKyyNHPA-1; Fri, 11 Sep 2020 05:59:25 -0400
X-MC-Unique: gjIWB3J2N7CrSHBKyyNHPA-1
Received: by mail-wr1-f70.google.com with SMTP id l9so3303411wrq.20
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2020 02:59:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=HpWLSZdrVk4EANVgntxWb4ENr3KvTzRCWWUjgaXP9V8=;
        b=YmAgmmRairQnPZd8u7jhZVfyY/DCIAFOsoESu16eJWMLxBmT7HKodgALlbaxM+Bgow
         vqby92vvA/MqebxrawTh0A1HSps2ap8meEZ1kfHp0/mbbZJKE3gEiERZElKtSV4cs2JH
         0OUlMHj2PEjlbPBNzUoAiKM/xod0jZefvNxLKgpNeI2C5+zAgCvddatYigUHF/SNVAqO
         tH5CE4Sc1XUKBlrhCz6DzUI3Qpnb2rR3/kBSmpSWPQzZN7zmF0dphLcQIQ/OaORJddjU
         jTanSH0vQCQHvY9BxQ6gK0URULjPuUPPnIOryAM2jbA+Zmek5nqu+BC5Ojw4LLsjT1Sp
         k0bg==
X-Gm-Message-State: AOAM533rXmZ9JooRpR/zl0327nY8g4ZQqUZbgnmhUFpBAvGBJDMrqHmt
        fn/X0nKkifaJN3F6YRLQBoEEzzIQiJeV8mnGSe/oJFfZARBsl2Lzq552/FhVbFQgfAroFu7APSK
        Rlr72l8G1+ua7
X-Received: by 2002:a7b:c404:: with SMTP id k4mr1386812wmi.168.1599818363572;
        Fri, 11 Sep 2020 02:59:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy0vjojHQmvGWnk5MbMrbh6POKTHFJVdk+Fj5CA958KqC2YrS3o3G5X9Cll0ZqTAU9+fAw1xA==
X-Received: by 2002:a7b:c404:: with SMTP id k4mr1386792wmi.168.1599818363190;
        Fri, 11 Sep 2020 02:59:23 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id o2sm3164627wmo.37.2020.09.11.02.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 02:59:22 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 75D4E1829D4; Fri, 11 Sep 2020 11:59:22 +0200 (CEST)
Subject: [PATCH RESEND bpf-next v3 7/9] libbpf: add support for supplying
 target to bpf_raw_tracepoint_open()
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>,
        KP Singh <kpsingh@chromium.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Date:   Fri, 11 Sep 2020 11:59:22 +0200
Message-ID: <159981836238.134722.1932000789183895507.stgit@toke.dk>
In-Reply-To: <159981835466.134722.8652987144251743467.stgit@toke.dk>
References: <159981835466.134722.8652987144251743467.stgit@toke.dk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

This adds support for supplying a target fd and btf ID for the
raw_tracepoint_open() BPF operation, using a new bpf_raw_tracepoint_opts
structure. This can be used for attaching freplace programs to multiple
destinations.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/lib/bpf/bpf.c      |   13 ++++++++++++-
 tools/lib/bpf/bpf.h      |    9 +++++++++
 tools/lib/bpf/libbpf.map |    1 +
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 82b983ff6569..25c62993c406 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -804,17 +804,28 @@ int bpf_obj_get_info_by_fd(int bpf_fd, void *info, __u32 *info_len)
 	return err;
 }
 
-int bpf_raw_tracepoint_open(const char *name, int prog_fd)
+int bpf_raw_tracepoint_open_opts(const char *name, int prog_fd,
+				 struct bpf_raw_tracepoint_opts *opts)
 {
 	union bpf_attr attr;
 
+	if (!OPTS_VALID(opts, bpf_raw_tracepoint_opts))
+		return -EINVAL;
+
 	memset(&attr, 0, sizeof(attr));
 	attr.raw_tracepoint.name = ptr_to_u64(name);
 	attr.raw_tracepoint.prog_fd = prog_fd;
+	attr.raw_tracepoint.tgt_prog_fd = OPTS_GET(opts, tgt_prog_fd, 0);
+	attr.raw_tracepoint.tgt_btf_id = OPTS_GET(opts, tgt_btf_id, 0);
 
 	return sys_bpf(BPF_RAW_TRACEPOINT_OPEN, &attr, sizeof(attr));
 }
 
+int bpf_raw_tracepoint_open(const char *name, int prog_fd)
+{
+	return bpf_raw_tracepoint_open_opts(name, prog_fd, NULL);
+}
+
 int bpf_load_btf(void *btf, __u32 btf_size, char *log_buf, __u32 log_buf_size,
 		 bool do_log)
 {
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 015d13f25fcc..30e8854374c0 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -233,7 +233,16 @@ LIBBPF_API int bpf_obj_get_info_by_fd(int bpf_fd, void *info, __u32 *info_len);
 LIBBPF_API int bpf_prog_query(int target_fd, enum bpf_attach_type type,
 			      __u32 query_flags, __u32 *attach_flags,
 			      __u32 *prog_ids, __u32 *prog_cnt);
+struct bpf_raw_tracepoint_opts {
+	size_t sz; /* size of this struct for forward/backward compatibility */
+	int tgt_prog_fd; /* target program to attach to */
+	__u32 tgt_btf_id; /* BTF ID of target function */
+};
+#define bpf_raw_tracepoint_opts__last_field tgt_btf_id
+
 LIBBPF_API int bpf_raw_tracepoint_open(const char *name, int prog_fd);
+LIBBPF_API int bpf_raw_tracepoint_open_opts(const char *name, int prog_fd,
+					    struct bpf_raw_tracepoint_opts *opts);
 LIBBPF_API int bpf_load_btf(void *btf, __u32 btf_size, char *log_buf,
 			    __u32 log_buf_size, bool do_log);
 LIBBPF_API int bpf_task_fd_query(int pid, int fd, __u32 flags, char *buf,
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 92ceb48a5ca2..a23d9f3f940c 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -303,6 +303,7 @@ LIBBPF_0.1.0 {
 LIBBPF_0.2.0 {
 	global:
 		bpf_program__section_name;
+		bpf_raw_tracepoint_open_opts;
 		perf_buffer__buffer_cnt;
 		perf_buffer__buffer_fd;
 		perf_buffer__epoll_fd;

