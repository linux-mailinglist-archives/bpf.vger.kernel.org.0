Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75AC621E13C
	for <lists+bpf@lfdr.de>; Mon, 13 Jul 2020 22:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgGMUMg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Jul 2020 16:12:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34796 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726798AbgGMUMd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Jul 2020 16:12:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594671152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6N16UjTiiaCaM01HWZd1AxR2a9Xuk8yHd46b6qpU0y4=;
        b=iBLH1zMTOk5tBpeWR+IKPaVHUEslWMajYEIlAZGFPg9NAX7WCDQgHM29XsU6URbshnpFa9
        racTc1AR7bV/O+SowgbZMv9jEz3N7gvEJaHXLBUJmalUk8QfSMQl82IRasBIyxwgB9VvAf
        ZMyzfM3wp6lFGZ5LLMtnqL+pPUsxLKc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-QeSPPNLsPDq4fGSf36pSPQ-1; Mon, 13 Jul 2020 16:12:28 -0400
X-MC-Unique: QeSPPNLsPDq4fGSf36pSPQ-1
Received: by mail-wr1-f71.google.com with SMTP id j5so18679473wro.6
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2020 13:12:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=6N16UjTiiaCaM01HWZd1AxR2a9Xuk8yHd46b6qpU0y4=;
        b=LOZAQEeISGvILWl0Qt0wlzUj8Tug59oiaUjmMQsecsihxjpDZx/nqcmo1eGezf5XsG
         PnOF1Lz6YIRG8ONy3IhWXbu31CgRIWotJ71RfO/DKCtTCoOb8/i5zkmo6T5sY+CyHmpp
         VHK7rzkKAz/KB0O0NPklpqs2OUYD6ldKrgwlCSNFOGHr9IWj+vcAMk6RZg39tTAd0AlY
         k0bCfVG8SApdNf2eQJqZ4HbKSqvFGy6jGKz2mOH0TKYppkgjB1b6H/rybdmwedbZL5ss
         Qu6q8r02khs9cEdXanWZ3mipd18PJAhNS7ZjRTl/kwbakLeVrdvxjegbOzZh63YrZIto
         Eyyg==
X-Gm-Message-State: AOAM532uBI2jdZkU/MdTxMDrNbvF5V1Np8rMNJhI8Ss++PaKTvYcvLq9
        hr8CDMrimZDqeIxyCylogdveBkdH86JwaayrxibPgWz+O03aqmgtWLr+fAo8UbbwV1sCSYKchKK
        40VxXYVg0VbRb
X-Received: by 2002:a05:600c:2295:: with SMTP id 21mr1027685wmf.29.1594671146692;
        Mon, 13 Jul 2020 13:12:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzOF2WiI4mZcNH8co/W0tjmT9+k0r0bee7CNBUk0s7d2wwstq02aXfL0cGMIefQT9gYCnW4QQ==
X-Received: by 2002:a05:600c:2295:: with SMTP id 21mr1027675wmf.29.1594671146416;
        Mon, 13 Jul 2020 13:12:26 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id n125sm914502wme.30.2020.07.13.13.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 13:12:25 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 3B777181C9D; Mon, 13 Jul 2020 22:12:25 +0200 (CEST)
Subject: [PATCH bpf-next 5/6] libbpf: add support for supplying target to
 bpf_raw_tracepoint_open()
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Date:   Mon, 13 Jul 2020 22:12:25 +0200
Message-ID: <159467114516.370286.16673271076079979202.stgit@toke.dk>
In-Reply-To: <159467113970.370286.17656404860101110795.stgit@toke.dk>
References: <159467113970.370286.17656404860101110795.stgit@toke.dk>
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
 tools/lib/bpf/bpf.c      |   33 ++++++++++++++++++++++++++++++++-
 tools/lib/bpf/bpf.h      |   12 ++++++++++++
 tools/lib/bpf/libbpf.map |    1 +
 3 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index a7329b671c41..6e7690d8ddfb 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -793,17 +793,48 @@ int bpf_obj_get_info_by_fd(int bpf_fd, void *info, __u32 *info_len)
 	return err;
 }
 
-int bpf_raw_tracepoint_open(const char *name, int prog_fd)
+int bpf_raw_tracepoint_open_opts(const char *name, int prog_fd,
+				 struct bpf_raw_tracepoint_opts *opts)
 {
 	union bpf_attr attr;
+	size_t log_buf_sz;
+	__u32 log_level;
+	char *log_buf;
+
+	if (!OPTS_VALID(opts, bpf_raw_tracepoint_opts))
+		return -EINVAL;
+
+	log_buf = OPTS_GET(opts, log_buf, NULL);
+	log_buf_sz = OPTS_GET(opts, log_buf_sz, 0);
+	log_level = OPTS_GET(opts, log_level, 0);
+
+	if (!log_buf != !log_buf_sz || log_level > (4 | 2 | 1) ||
+	    (log_level && !log_buf))
+		return -EINVAL;
 
 	memset(&attr, 0, sizeof(attr));
 	attr.raw_tracepoint.name = ptr_to_u64(name);
 	attr.raw_tracepoint.prog_fd = prog_fd;
+	attr.raw_tracepoint.tgt_prog_fd = OPTS_GET(opts, tgt_prog_fd, 0);
+	attr.raw_tracepoint.tgt_btf_id = OPTS_GET(opts, tgt_btf_id, 0);
+
+	attr.raw_tracepoint.log_level = log_level;
+	if (log_level) {
+		attr.raw_tracepoint.log_buf = ptr_to_u64(log_buf);
+		attr.raw_tracepoint.log_size = log_buf_sz;
+	} else {
+		attr.raw_tracepoint.log_buf = ptr_to_u64(NULL);
+		attr.raw_tracepoint.log_size = 0;
+	}
 
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
index 1b6015b21ba8..b6b8ebb6ce65 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -227,7 +227,19 @@ LIBBPF_API int bpf_obj_get_info_by_fd(int bpf_fd, void *info, __u32 *info_len);
 LIBBPF_API int bpf_prog_query(int target_fd, enum bpf_attach_type type,
 			      __u32 query_flags, __u32 *attach_flags,
 			      __u32 *prog_ids, __u32 *prog_cnt);
+struct bpf_raw_tracepoint_opts {
+	size_t sz; /* size of this struct for forward/backward compatibility */
+	__u32 log_level;
+	char *log_buf;
+	size_t log_buf_sz;
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
index 6544d2cd1ed6..f726805f5ec8 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -288,4 +288,5 @@ LIBBPF_0.1.0 {
 		bpf_map__value_size;
 		bpf_program__autoload;
 		bpf_program__set_autoload;
+		bpf_raw_tracepoint_open_opts;
 } LIBBPF_0.0.9;

