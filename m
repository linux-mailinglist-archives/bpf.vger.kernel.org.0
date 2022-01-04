Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED23483DD2
	for <lists+bpf@lfdr.de>; Tue,  4 Jan 2022 09:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233896AbiADILA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Jan 2022 03:11:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29952 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234006AbiADIKs (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 4 Jan 2022 03:10:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641283847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z04l+1thMGEo6+2wn8HMi5HKrAqA7BNf+MRnLwscczA=;
        b=DAlsh2/KYfEB9KJyPCWOxVDXO/zTrHNpuCMGpH4IudaBHQHtNKG4Oib3uKKywg6rD+WPeg
        TSly21o34J2JZkR6Cy22z9RgdJ7yaZPH4AOR+bl3Vwx/XHN3NY+bSb6FVvI/FNXhQARt5J
        NZxHR0ECeT5d0WxRTSKiS8bVOR/pr+0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-436--NvNdSVKMJOvT3Fqh0VNfg-1; Tue, 04 Jan 2022 03:10:46 -0500
X-MC-Unique: -NvNdSVKMJOvT3Fqh0VNfg-1
Received: by mail-ed1-f70.google.com with SMTP id l14-20020aa7cace000000b003f7f8e1cbbdso24623897edt.20
        for <bpf@vger.kernel.org>; Tue, 04 Jan 2022 00:10:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z04l+1thMGEo6+2wn8HMi5HKrAqA7BNf+MRnLwscczA=;
        b=TqLLZXIoJS3gA15tJ17DirdeWppRYRMrhonep8VLAVqqtZfQSua3KRNlxHpmYjLl+i
         GwF2A6iysrXsCYheAheHK9GnAPoB7b6TI2PPO+/OKzKqwbNQg1oV5GRRPM/wy7NLbWKZ
         yOwI4Wsf+fqnOosXfxuQOcADgMFv78diyRLDaxEJZs181rn+/6uWE+Ii/brTsAyEZ2h3
         v//HlVWIGeyVAPDCY+JhlWezKb/9reqanHHvZwXWWCL6ze/8VDDFSVCsI/dbNoJYKLlQ
         f7mtsKAuNtweKJku8EWywszuVeqRlUkH6iV+grP2iIs6V3QT1b+kbzZMLX7VfMOrH0q0
         LE9Q==
X-Gm-Message-State: AOAM532yaxF6dWo+wNmePG8UkuUq/xyZRCfoUVm+uc5d2+RNOIjlgcBm
        VA+0rbC20M9pJFbQssO/CI1B6h2ekYENoJw5ASlMnxYHjO1U3f6L3zLoYWD32vR12XP1IQ4/El5
        dWj5pwn8YkRI8
X-Received: by 2002:aa7:cada:: with SMTP id l26mr48146079edt.376.1641283845534;
        Tue, 04 Jan 2022 00:10:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzFkiq5V/GxTl7wd6cp9nRQDMK16ZHw3L6bqox/Q7gvurc8JFtIApm+yKLHFcDKbqDu4mUuiw==
X-Received: by 2002:aa7:cada:: with SMTP id l26mr48146070edt.376.1641283845430;
        Tue, 04 Jan 2022 00:10:45 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id 21sm11279609ejx.83.2022.01.04.00.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 00:10:45 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 10/13] libbpf: Add bpf_link_create support for multi kprobes
Date:   Tue,  4 Jan 2022 09:09:40 +0100
Message-Id: <20220104080943.113249-11-jolsa@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220104080943.113249-1-jolsa@kernel.org>
References: <20220104080943.113249-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding new kprobe struct in bpf_link_create_opts object
to pass multi kprobe data to link_create attr API.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/bpf.c | 5 +++++
 tools/lib/bpf/bpf.h | 7 ++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 9b64eed2b003..40cad575ad62 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -848,6 +848,11 @@ int bpf_link_create(int prog_fd, int target_fd,
 		if (!OPTS_ZEROED(opts, perf_event))
 			return libbpf_err(-EINVAL);
 		break;
+	case BPF_TRACE_RAW_KPROBE:
+		attr.link_create.kprobe.addrs = OPTS_GET(opts, kprobe.addrs, 0);
+		attr.link_create.kprobe.cnt = OPTS_GET(opts, kprobe.cnt, 0);
+		attr.link_create.kprobe.bpf_cookie = OPTS_GET(opts, kprobe.bpf_cookie, 0);
+		break;
 	default:
 		if (!OPTS_ZEROED(opts, flags))
 			return libbpf_err(-EINVAL);
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 00619f64a040..9611023138b1 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -298,10 +298,15 @@ struct bpf_link_create_opts {
 		struct {
 			__u64 bpf_cookie;
 		} perf_event;
+		struct {
+			__u64 addrs;
+			__u32 cnt;
+			__u64 bpf_cookie;
+		} kprobe;
 	};
 	size_t :0;
 };
-#define bpf_link_create_opts__last_field perf_event
+#define bpf_link_create_opts__last_field kprobe.bpf_cookie
 
 LIBBPF_API int bpf_link_create(int prog_fd, int target_fd,
 			       enum bpf_attach_type attach_type,
-- 
2.33.1

