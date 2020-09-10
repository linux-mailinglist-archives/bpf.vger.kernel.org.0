Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35C922653B3
	for <lists+bpf@lfdr.de>; Thu, 10 Sep 2020 23:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbgIJVj0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Sep 2020 17:39:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27156 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730635AbgIJNKq (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 10 Sep 2020 09:10:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599743403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HpWLSZdrVk4EANVgntxWb4ENr3KvTzRCWWUjgaXP9V8=;
        b=BFohy9HtnYIA6i8M8T6tSvHukMf2YSCSjywp2wIvzkW4sDwrdqXbl3Wq9RUNhAPfo4jl6u
        7rBS7X5IUu+052m4rk9ENfjDN9DUqRUcWHiUGhHm47X+GOyA7Njh04UDyrEYAPnhi61/pI
        5DAqaI5KudraXwXF16GkHxsQVUQUeEM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-5xMeOfCNNnywOkwlfKxVUQ-1; Thu, 10 Sep 2020 09:10:01 -0400
X-MC-Unique: 5xMeOfCNNnywOkwlfKxVUQ-1
Received: by mail-wm1-f70.google.com with SMTP id g79so879500wmg.0
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2020 06:10:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=HpWLSZdrVk4EANVgntxWb4ENr3KvTzRCWWUjgaXP9V8=;
        b=cU8G+sGOsBnbr7XkZtnwwaotXdS4vLmYjWi50bpHvztKcei5gbOt3jg78quj7P3iCK
         dRdNvSAAheZQ0AgK7XSvmtStpoKRxCM3DsOhqQSIgdeDeje43lviTM88UbpvktDl/vWF
         oJXZEfqp/9uc0TV4XBOd23nK8JsoFL2NSDjXryO0Pe/dOr5o0flm19YMZu3ZRRMaN8ow
         GCVsuZbETEKZCa2Z/3JDOxwYECOtTZyXXvQ5RBFrBSkddQA5VcJaRwdI24DtJPg3N280
         hfZMuBJYYrH2O7RY9aWc8noz2Q2bcOWc3BA1Bf6Es5pSyMOoaVV6/uZh/8gRvGF5xcQe
         qVfQ==
X-Gm-Message-State: AOAM531/F6sL1HbWklRP8q9Mg1X4zn87/khlfpLEmn0oIQg6Djkb+Y0B
        XsKud9cy2KlK7f/iIJh76xxLu+wEuYoz0UhMDUH1TtFtS3gONXYfUs7O2r0kV5V+uet+WQXov91
        n/izxvo32Geau
X-Received: by 2002:adf:e7ca:: with SMTP id e10mr8823294wrn.236.1599743398865;
        Thu, 10 Sep 2020 06:09:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJys+qMTVTbazpXoQ/YUFFk44DvhdFRgqcDdn47ZLYK8HU90NOIoEIpWGieDdxyj48qLORhmVA==
X-Received: by 2002:adf:e7ca:: with SMTP id e10mr8823250wrn.236.1599743398425;
        Thu, 10 Sep 2020 06:09:58 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id v3sm3596338wmh.6.2020.09.10.06.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 06:09:57 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 39BA71829D4; Thu, 10 Sep 2020 15:09:57 +0200 (CEST)
Subject: [PATCH bpf-next v3 7/9] libbpf: add support for supplying target to
 bpf_raw_tracepoint_open()
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
Date:   Thu, 10 Sep 2020 15:09:57 +0200
Message-ID: <159974339713.129227.17759670478076731926.stgit@toke.dk>
In-Reply-To: <159974338947.129227.5610774877906475683.stgit@toke.dk>
References: <159974338947.129227.5610774877906475683.stgit@toke.dk>
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

