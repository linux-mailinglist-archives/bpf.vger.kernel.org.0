Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7F08299AB5
	for <lists+bpf@lfdr.de>; Tue, 27 Oct 2020 00:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407170AbgJZXgm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Oct 2020 19:36:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48550 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407157AbgJZXgm (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 26 Oct 2020 19:36:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603755400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Aw1C3SX8MwtokG3KPK8WvRy0mlIpK2ccLFmN/0ezULg=;
        b=LuPu/vWJoVRodXSP2LApmJA1HMsye1Ho26Z4ELMx7fmFpTkvhpRY2MgkZ5SDp0KCELkroh
        k0I6RRlCFPzf0oKYSFa4Ng6VpveQGTc7r2RDLP5s+3/uB9sP/RLfp8/J5Si0C36X0hWRpu
        W4BQ25pykD+iAKh3lFqFOHcq7V48yo0=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-549-Srn8kJOEOqywgHF0unrXHQ-1; Mon, 26 Oct 2020 19:36:38 -0400
X-MC-Unique: Srn8kJOEOqywgHF0unrXHQ-1
Received: by mail-io1-f70.google.com with SMTP id k13so6981192iok.12
        for <bpf@vger.kernel.org>; Mon, 26 Oct 2020 16:36:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Aw1C3SX8MwtokG3KPK8WvRy0mlIpK2ccLFmN/0ezULg=;
        b=aUzw8wHxTC+M44RHAOEUb8rlU2/dX0p/0UMaG5ck5gQLyK+tt8kNPzLZJGJyLrUzur
         3JBmb7lDO0Wb6Fa1JI248PX3oSCujJOtQRUvzd/jayzWLxFOrxKjDdNrkf1tRqw9Oc++
         ECzR03YDkyduWKSqWdGgi8bkZD9dOF8Wc8eBUjY97GcPIqqK1nihzrEpuy+JFfgaN9ZC
         U1lqCU3FqXA6y+Iu+eWckYK2Rzm4mQOt4D8dCC9XwN/MimnbUAVNNz13Gz2elLUzeQ1i
         PYhRUC6hNikmGeo7GsCn+pyZhm0noulgPDKHZ9S5TwlDYLzlidU9gNZlFvsz4pkMfOGz
         INmA==
X-Gm-Message-State: AOAM5312GJw0YIwnFZUmcuqA4pky9eMULNR3bKbJARsgLVVEnfaJ/g9X
        Wu9Mdwa4acOBy2rwx5QQm8qBMlXZ4j+IOCrNf6GUjFCX7hT5SuZZy4CEzfap94z2CfL+L5KJKHC
        jmzHucqzvB6V4
X-Received: by 2002:a92:8742:: with SMTP id d2mr12988629ilm.153.1603755397711;
        Mon, 26 Oct 2020 16:36:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHqQK3o+vUOW+FCj6F4hqe/Yu+gQQs5ZAQqnqHW1/7nCVMTu8A7UdbzysD2E6mDne9pR90vw==
X-Received: by 2002:a92:8742:: with SMTP id d2mr12988618ilm.153.1603755397381;
        Mon, 26 Oct 2020 16:36:37 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id g9sm3457470iob.1.2020.10.26.16.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 16:36:36 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id CEE31181CED; Tue, 27 Oct 2020 00:36:34 +0100 (CET)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     daniel@iogearbox.net, ast@fb.com
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        bpf@vger.kernel.org, netdev@vger.kernel.org, brouer@redhat.com
Subject: [PATCH bpf] samples/bpf: Set rlimit for memlock to infinity in all samples
Date:   Tue, 27 Oct 2020 00:36:23 +0100
Message-Id: <20201026233623.91728-1-toke@redhat.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The memlock rlimit is a notorious source of failure for BPF programs. Most
of the samples just set it to infinity, but a few used a lower limit. The
problem with unconditionally setting a lower limit is that this will also
override the limit if the system-wide setting is *higher* than the limit
being set, which can lead to failures on systems that lock a lot of memory,
but set 'ulimit -l' to unlimited before running a sample.

One fix for this is to only conditionally set the limit if the current
limit is lower, but it is simpler to just unify all the samples and have
them all set the limit to infinity.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 samples/bpf/task_fd_query_user.c    | 2 +-
 samples/bpf/tracex2_user.c          | 2 +-
 samples/bpf/tracex3_user.c          | 2 +-
 samples/bpf/xdp_redirect_cpu_user.c | 2 +-
 samples/bpf/xdp_rxq_info_user.c     | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/samples/bpf/task_fd_query_user.c b/samples/bpf/task_fd_query_user.c
index 4a74531dc403..b68bd2f8fdc9 100644
--- a/samples/bpf/task_fd_query_user.c
+++ b/samples/bpf/task_fd_query_user.c
@@ -290,7 +290,7 @@ static int test_debug_fs_uprobe(char *binary_path, long offset, bool is_return)
 
 int main(int argc, char **argv)
 {
-	struct rlimit r = {1024*1024, RLIM_INFINITY};
+	struct rlimit r = {RLIM_INFINITY, RLIM_INFINITY};
 	extern char __executable_start;
 	char filename[256], buf[256];
 	__u64 uprobe_file_offset;
diff --git a/samples/bpf/tracex2_user.c b/samples/bpf/tracex2_user.c
index 3e36b3e4e3ef..3d6eab711d23 100644
--- a/samples/bpf/tracex2_user.c
+++ b/samples/bpf/tracex2_user.c
@@ -116,7 +116,7 @@ static void int_exit(int sig)
 
 int main(int ac, char **argv)
 {
-	struct rlimit r = {1024*1024, RLIM_INFINITY};
+	struct rlimit r = {RLIM_INFINITY, RLIM_INFINITY};
 	long key, next_key, value;
 	struct bpf_link *links[2];
 	struct bpf_program *prog;
diff --git a/samples/bpf/tracex3_user.c b/samples/bpf/tracex3_user.c
index 70e987775c15..83e0fecbb01a 100644
--- a/samples/bpf/tracex3_user.c
+++ b/samples/bpf/tracex3_user.c
@@ -107,7 +107,7 @@ static void print_hist(int fd)
 
 int main(int ac, char **argv)
 {
-	struct rlimit r = {1024*1024, RLIM_INFINITY};
+	struct rlimit r = {RLIM_INFINITY, RLIM_INFINITY};
 	struct bpf_link *links[2];
 	struct bpf_program *prog;
 	struct bpf_object *obj;
diff --git a/samples/bpf/xdp_redirect_cpu_user.c b/samples/bpf/xdp_redirect_cpu_user.c
index 6fb8dbde62c5..f78cb18319aa 100644
--- a/samples/bpf/xdp_redirect_cpu_user.c
+++ b/samples/bpf/xdp_redirect_cpu_user.c
@@ -765,7 +765,7 @@ static int load_cpumap_prog(char *file_name, char *prog_name,
 
 int main(int argc, char **argv)
 {
-	struct rlimit r = {10 * 1024 * 1024, RLIM_INFINITY};
+	struct rlimit r = {RLIM_INFINITY, RLIM_INFINITY};
 	char *prog_name = "xdp_cpu_map5_lb_hash_ip_pairs";
 	char *mprog_filename = "xdp_redirect_kern.o";
 	char *redir_interface = NULL, *redir_map = NULL;
diff --git a/samples/bpf/xdp_rxq_info_user.c b/samples/bpf/xdp_rxq_info_user.c
index caa4e7ffcfc7..93fa1bc54f13 100644
--- a/samples/bpf/xdp_rxq_info_user.c
+++ b/samples/bpf/xdp_rxq_info_user.c
@@ -450,7 +450,7 @@ static void stats_poll(int interval, int action, __u32 cfg_opt)
 int main(int argc, char **argv)
 {
 	__u32 cfg_options= NO_TOUCH ; /* Default: Don't touch packet memory */
-	struct rlimit r = {10 * 1024 * 1024, RLIM_INFINITY};
+	struct rlimit r = {RLIM_INFINITY, RLIM_INFINITY};
 	struct bpf_prog_load_attr prog_load_attr = {
 		.prog_type	= BPF_PROG_TYPE_XDP,
 	};
-- 
2.29.0

