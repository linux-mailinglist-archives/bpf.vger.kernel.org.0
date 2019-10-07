Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED2C6CEA79
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2019 19:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbfJGRUp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Oct 2019 13:20:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:25693 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728941AbfJGRUo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Oct 2019 13:20:44 -0400
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com [209.85.208.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 630928E3C5
        for <bpf@vger.kernel.org>; Mon,  7 Oct 2019 17:20:43 +0000 (UTC)
Received: by mail-lj1-f198.google.com with SMTP id j6so3726009ljb.19
        for <bpf@vger.kernel.org>; Mon, 07 Oct 2019 10:20:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=tTxe0YBCAHRDq7AE78oRk+k8RYg6kbZEgrUi0UlHpcg=;
        b=KbZtDMq8bLeOn7Brj02a94Z73BpJxyVabrzLUZ6RbzKPWYGbxlexdPPWULiOdx1uQH
         vWi35zdjndnJ17A61kPLKmyVWDSPMD9jKFvJ1g7DrRPn6Rh6ie3CZrkzAF3KY6/JmqjY
         czE05Vd8MgkqWv8WUuRs+mtkXqMq7iPrpxTw613/qyjivc9s0JZMyY+QUU0tkN7KE9me
         yII164xZl1ofkCE25GVbwfKUwIA4lDkxXN9H0hVn4Ccvq1eKTXRgItbvo/xbobZv3ylj
         6zPZBC5btrqwXPjvH1e1dRUsn6lvbyc2FTb31xz16EGqIJoRF4//eWvyMc8GkHyI4esL
         O1LQ==
X-Gm-Message-State: APjAAAVO71y7/tGDUMrdt3t5QbSruzmVu6lzR3sUa7LlPtKvdkFvXOM2
        dLuNi6NChLaeOHQ0I7mDB3HuSoxT6aqBUzztYRsSb34+U5ySDlP9+oMZvgmqdqKhHDcFhzALQLm
        BP61Ukzu64LGw
X-Received: by 2002:a2e:8789:: with SMTP id n9mr19282000lji.52.1570468841937;
        Mon, 07 Oct 2019 10:20:41 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw4yuFLqw3buhtiSBBMrP4Eyd5VAt0ZbYU30A4FGLEUEgBxjAQKO7QI9S6+wmyEdzGHQNySGQ==
X-Received: by 2002:a2e:8789:: with SMTP id n9mr19281987lji.52.1570468841795;
        Mon, 07 Oct 2019 10:20:41 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id 6sm2853116lfa.24.2019.10.07.10.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 10:20:40 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 7761D180641; Mon,  7 Oct 2019 19:20:39 +0200 (CEST)
Subject: [PATCH bpf-next v3 4/5] libbpf: Add syscall wrappers for
 BPF_PROG_CHAIN_* commands
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Marek Majkowski <marek@cloudflare.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Date:   Mon, 07 Oct 2019 19:20:39 +0200
Message-ID: <157046883940.2092443.14475136847242640757.stgit@alrua-x1>
In-Reply-To: <157046883502.2092443.146052429591277809.stgit@alrua-x1>
References: <157046883502.2092443.146052429591277809.stgit@alrua-x1>
User-Agent: StGit/0.19-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

This adds simple syscall wrappers for the new BPF_PROG_CHAIN_* commands to
libbpf.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/lib/bpf/bpf.c      |   34 ++++++++++++++++++++++++++++++++++
 tools/lib/bpf/bpf.h      |    4 ++++
 tools/lib/bpf/libbpf.map |    3 +++
 3 files changed, 41 insertions(+)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index cbb933532981..23246fa169e7 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -703,3 +703,37 @@ int bpf_task_fd_query(int pid, int fd, __u32 flags, char *buf, __u32 *buf_len,
 
 	return err;
 }
+
+int bpf_prog_chain_add(int prev_prog_fd, __u32 retcode, int next_prog_fd) {
+	union bpf_attr attr = {};
+
+	attr.prev_prog_fd = prev_prog_fd;
+	attr.next_prog_fd = next_prog_fd;
+	attr.retcode = retcode;
+
+	return sys_bpf(BPF_PROG_CHAIN_ADD, &attr, sizeof(attr));
+}
+
+int bpf_prog_chain_del(int prev_prog_fd, __u32 retcode) {
+	union bpf_attr attr = {};
+
+	attr.prev_prog_fd = prev_prog_fd;
+	attr.retcode = retcode;
+
+	return sys_bpf(BPF_PROG_CHAIN_DEL, &attr, sizeof(attr));
+}
+
+int bpf_prog_chain_get(int prev_prog_fd, __u32 retcode, __u32 *prog_id) {
+	union bpf_attr attr = {};
+	int err;
+
+	attr.prev_prog_fd = prev_prog_fd;
+	attr.retcode = retcode;
+
+	err = sys_bpf(BPF_PROG_CHAIN_GET, &attr, sizeof(attr));
+
+	if (!err)
+		*prog_id = attr.next_prog_id;
+
+	return err;
+}
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 0db01334740f..0300cb8c8bed 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -171,6 +171,10 @@ LIBBPF_API int bpf_task_fd_query(int pid, int fd, __u32 flags, char *buf,
 				 __u32 *buf_len, __u32 *prog_id, __u32 *fd_type,
 				 __u64 *probe_offset, __u64 *probe_addr);
 
+LIBBPF_API int bpf_prog_chain_add(int prev_prog_fd, __u32 retcode, int next_prog_fd);
+LIBBPF_API int bpf_prog_chain_del(int prev_prog_fd, __u32 retcode);
+LIBBPF_API int bpf_prog_chain_get(int prev_prog_fd, __u32 retcode, __u32 *prog_id);
+
 #ifdef __cplusplus
 } /* extern "C" */
 #endif
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 8d10ca03d78d..9c483c554054 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -192,4 +192,7 @@ LIBBPF_0.0.5 {
 } LIBBPF_0.0.4;
 
 LIBBPF_0.0.6 {
+		bpf_prog_chain_add;
+		bpf_prog_chain_del;
+		bpf_prog_chain_get;
 } LIBBPF_0.0.5;

