Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 676B045B6C7
	for <lists+bpf@lfdr.de>; Wed, 24 Nov 2021 09:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241441AbhKXIqY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Nov 2021 03:46:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27128 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241444AbhKXIo6 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 24 Nov 2021 03:44:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637743308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mSbLxSzQQlSj2l2ivmebco5pJQPSDB4IoLoCnSyzCyI=;
        b=hLVoGQIB5w3VUlfaejALPn+wH/si+iB1nWfZ1GeHvt9WCGVjsHZUFgn/BGRORDh2lkmpeE
        7GBZcnz0379PYy3QoRPwsqy/FTQWZ7wnrO3L8dazcupwcz9jG2X0vIkKBiiDZ13RjtzuYy
        3yR5Rb4Jd9OFM4UY67JQe4N/qyG97aE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-504-j8lISBVHMsyItXOcGxy35A-1; Wed, 24 Nov 2021 03:41:47 -0500
X-MC-Unique: j8lISBVHMsyItXOcGxy35A-1
Received: by mail-wm1-f70.google.com with SMTP id 138-20020a1c0090000000b00338bb803204so974289wma.1
        for <bpf@vger.kernel.org>; Wed, 24 Nov 2021 00:41:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mSbLxSzQQlSj2l2ivmebco5pJQPSDB4IoLoCnSyzCyI=;
        b=1AcFjWq/CwPnWjAx3G+02icx7Xjuld2yinI4f58LCLl5bchnAnmpxE/2HY6ez1VRhG
         9bsDCwC3c4+nH4dHbFUDA1LppCSxIChx0JrF3Sq1kiEOtTjRK9Rqk2lEz+ju2mLKHPNR
         ASJDT0OBVwpJf9q7k+SSXdlJNo45VlyNjydG1CjZG1YBxx+CJBx5c5foO7xqo5cmAo8X
         mnmMO/Zx3oGT+he9YS7MtfUQhgakt8n8Dzjo0qRdRTMszHv4kHM/jNYworuqI9uggTg8
         Yf0K/9Hb1r3dlfInKpsRZnuiFNS3IoQdEDE6bYT30ukCSuEuAuwzP9LIr+t2EaadyEQI
         hrRg==
X-Gm-Message-State: AOAM532gw4cv/ltqAVJjSvtRg5aMhHPHYNKFKBCaK3zDp9lxVuHPYMqv
        jz3xbBjtExylWRtHLW2tbGqhR1XFbVMK7Lb69ExdyhTmo/ayR6Z+wC4zCKTTfvExBcwWytLfx8x
        mh8c/Mg/xzfPX
X-Received: by 2002:a05:600c:a0b:: with SMTP id z11mr12965520wmp.147.1637743305721;
        Wed, 24 Nov 2021 00:41:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJymrcuFByLsguSft6KExGLu1wEeNTSixB9Q5EfKs0oZ76e3br1ZPdJy/9cjaU2K/51mela6sg==
X-Received: by 2002:a05:600c:a0b:: with SMTP id z11mr12965499wmp.147.1637743305551;
        Wed, 24 Nov 2021 00:41:45 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id d1sm13789041wrz.92.2021.11.24.00.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 00:41:45 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>
Subject: [PATCH 4/8] libbpf: Add struct perf_event_open_args
Date:   Wed, 24 Nov 2021 09:41:15 +0100
Message-Id: <20211124084119.260239-5-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211124084119.260239-1-jolsa@kernel.org>
References: <20211124084119.260239-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding struct perf_event_open_args to hold arguments for
perf_event_open_probe, because there's already 6 arguments
and more will come in following changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/libbpf.c | 42 ++++++++++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index b55c0fbfcc03..34219a0c39a7 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9625,11 +9625,20 @@ static int determine_uprobe_retprobe_bit(void)
 #define PERF_UPROBE_REF_CTR_OFFSET_BITS 32
 #define PERF_UPROBE_REF_CTR_OFFSET_SHIFT 32
 
-static int perf_event_open_probe(bool uprobe, bool retprobe, const char *name,
-				 uint64_t offset, int pid, size_t ref_ctr_off)
+struct perf_event_open_args {
+	bool retprobe;
+	const char *name;
+	uint64_t offset;
+	int pid;
+	size_t ref_ctr_off;
+};
+
+static int perf_event_open_probe(bool uprobe, struct perf_event_open_args *args)
 {
+	size_t ref_ctr_off = args->ref_ctr_off;
 	struct perf_event_attr attr = {};
 	char errmsg[STRERR_BUFSIZE];
+	int pid = args->pid;
 	int type, pfd, err;
 
 	if (ref_ctr_off >= (1ULL << PERF_UPROBE_REF_CTR_OFFSET_BITS))
@@ -9643,7 +9652,7 @@ static int perf_event_open_probe(bool uprobe, bool retprobe, const char *name,
 			libbpf_strerror_r(type, errmsg, sizeof(errmsg)));
 		return type;
 	}
-	if (retprobe) {
+	if (args->retprobe) {
 		int bit = uprobe ? determine_uprobe_retprobe_bit()
 				 : determine_kprobe_retprobe_bit();
 
@@ -9658,8 +9667,8 @@ static int perf_event_open_probe(bool uprobe, bool retprobe, const char *name,
 	attr.size = sizeof(attr);
 	attr.type = type;
 	attr.config |= (__u64)ref_ctr_off << PERF_UPROBE_REF_CTR_OFFSET_SHIFT;
-	attr.config1 = ptr_to_u64(name); /* kprobe_func or uprobe_path */
-	attr.config2 = offset;		 /* kprobe_addr or probe_offset */
+	attr.config1 = ptr_to_u64(args->name); /* kprobe_func or uprobe_path */
+	attr.config2 = args->offset;		 /* kprobe_addr or probe_offset */
 
 	/* pid filter is meaningful only for uprobes */
 	pfd = syscall(__NR_perf_event_open, &attr,
@@ -9791,9 +9800,15 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
 
 	legacy = determine_kprobe_perf_type() < 0;
 	if (!legacy) {
-		pfd = perf_event_open_probe(false /* uprobe */, retprobe,
-					    func_name, offset,
-					    -1 /* pid */, 0 /* ref_ctr_off */);
+		struct perf_event_open_args args = {
+			.retprobe = retprobe,
+			.name = func_name,
+			.offset = offset,
+			.pid = -1,
+			.ref_ctr_off = 0,
+		};
+
+		pfd = perf_event_open_probe(false /* uprobe */, &args);
 	} else {
 		char probe_name[256];
 
@@ -9984,8 +9999,15 @@ bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
 
 	legacy = determine_uprobe_perf_type() < 0;
 	if (!legacy) {
-		pfd = perf_event_open_probe(true /* uprobe */, retprobe, binary_path,
-					    func_offset, pid, ref_ctr_off);
+		struct perf_event_open_args args = {
+			.retprobe = retprobe,
+			.name = binary_path,
+			.offset = func_offset,
+			.pid = pid,
+			.ref_ctr_off = ref_ctr_off,
+		};
+
+		pfd = perf_event_open_probe(true /* uprobe */, &args);
 	} else {
 		char probe_name[512];
 
-- 
2.33.1

