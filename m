Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD4CCC19E
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2019 19:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388468AbfJDRWu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Oct 2019 13:22:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60516 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388332AbfJDRWt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Oct 2019 13:22:49 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E902F50F4D
        for <bpf@vger.kernel.org>; Fri,  4 Oct 2019 17:22:47 +0000 (UTC)
Received: by mail-ed1-f72.google.com with SMTP id 38so4490379edr.4
        for <bpf@vger.kernel.org>; Fri, 04 Oct 2019 10:22:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=tTxe0YBCAHRDq7AE78oRk+k8RYg6kbZEgrUi0UlHpcg=;
        b=ZuHbglfb+6MP7TbJgw7TOFJsJ9WT4d550wOlAj6xaJHYyPFsaC0SlVWYpNMxSVpRce
         E1Q5IifaHXq8BMCeEAF2FBF/mDXBPD8Myv8wroL65Q21AQLPLBQ7UzawfOgRbmQZv7j+
         UXub62w5RTU40VRf/13T2w54k8yvp34IbbHGZ+Lu6CB0KOpZFXTETDxlK4PmHJWv6xbe
         aB7/FEnVWs7drQBmW/aGjinKapayoGsm7nrN1RseXqrWuUj/jgiJdqYbo9ncTusW78fS
         2dD9DJ9jcHU5LIJ7ZzjpsDoAu/WwPi1Ibf/pNRgifOBLZhttH4gyNGYqceKtJaiGz21k
         G8GQ==
X-Gm-Message-State: APjAAAXjKKQeG3y/o8I620M47Potp5ZgfhxLCWhgdDoAGzJeGdrUQtAw
        GsNEibjVOLHf1qIXacs175lAAZu3C3Y89+GbqSeKy2vxfQ0bHM496SfnKcqcD9Uymx+7W7qtDq4
        lKPXOiL/kuQI7
X-Received: by 2002:a50:ab49:: with SMTP id t9mr16318389edc.301.1570209766709;
        Fri, 04 Oct 2019 10:22:46 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxTG4xScnLuFvaWNICxY54vUw9ElSy9/9Dni61Yni9KpZNA51yexs52Jee0AefO5rIiQz707g==
X-Received: by 2002:a50:ab49:: with SMTP id t9mr16318371edc.301.1570209766539;
        Fri, 04 Oct 2019 10:22:46 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id 30sm1246974edr.78.2019.10.04.10.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 10:22:45 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id DB61918063D; Fri,  4 Oct 2019 19:22:44 +0200 (CEST)
Subject: [PATCH bpf-next v2 4/5] libbpf: Add syscall wrappers for
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
Date:   Fri, 04 Oct 2019 19:22:44 +0200
Message-ID: <157020976478.1824887.2460017336894785970.stgit@alrua-x1>
In-Reply-To: <157020976030.1824887.7191033447861395957.stgit@alrua-x1>
References: <157020976030.1824887.7191033447861395957.stgit@alrua-x1>
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

