Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88B272A60DA
	for <lists+bpf@lfdr.de>; Wed,  4 Nov 2020 10:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbgKDJqi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Nov 2020 04:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgKDJqf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Nov 2020 04:46:35 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C738CC0613D3;
        Wed,  4 Nov 2020 01:46:34 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id l2so26333644lfk.0;
        Wed, 04 Nov 2020 01:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YSOL2BPcG5OaEO/RGSF7Sr1oAx6ujG4LTa5tHG1Uyaw=;
        b=fHGDbRvY2Rgwf7qHY1ocj5eKoo05g2F4zB53+1kblEYVI8yu3ZPZQ8hYyszh1EKDFV
         PrcdcZFtatLCSz5n0tqcvQxXo291PcVkXsDWZWTg08lBCZ1iaHUP2zp1ieSuKTCT5EJN
         4xbFezISiQ1lnSupHQj7Jssh35qUiWr3cxtl1bGcQ4sBePQIfV8Or4dntxMkb3T/kbIf
         qb3GWKLoncPlNqnGwBce8Hyy0W2OCh6vTR25xtXzAasSaHHL49c5cr2ud0OHVHOQlYrL
         h64p0hr5jx9JZgh94lgYSir9CFJZdgc+Gx6ceMLVva0HKTZHcHGLPeApz6HwOl5iwedI
         TR7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YSOL2BPcG5OaEO/RGSF7Sr1oAx6ujG4LTa5tHG1Uyaw=;
        b=sgVwI18kXXtd0hmuy+HvRGT4/qWpepAhyrTWgyXOpEkLrRO15croBaTlL+6+w3YgwR
         dvVtzYKQUWhFab0xDtBiJkL0YSTOsxjywxQF//9n9pZNJFuo3fd6kU8jXHySCMXJ5iIa
         LP622BR1URMhZl3LqfcT5xspe7kAdKtuV38UUV0Gx9HuioBWAQv5fsk9uExWgcoJereR
         Ck5dRr5DBzVs9zPb2NoIpV9eeQHkT3yfFRN7GerIfPIj/Q6pwj1Cj9d1JmpFQxtWeocZ
         Hoy8mjuOQ173upbHOjGgjkI5Jd89AqKdaxZ8ud58NOBv1g6XOJuSvOsi/5cU8a12I6v2
         rX5w==
X-Gm-Message-State: AOAM530IOWnnDys65pq461iutyT0yNnBSdCFmP86xfev1mMqMuniyxSU
        S69ear9F4m8rJjLu9lTDJgo=
X-Google-Smtp-Source: ABdhPJzF+5ie86ITZEA+qk1EJZStI9qzQ7+JYNr1x+mODDFTVf40Jn8Fl6uFMEtLyUxKB5dj5vPKGA==
X-Received: by 2002:ac2:443c:: with SMTP id w28mr8838538lfl.405.1604483193270;
        Wed, 04 Nov 2020 01:46:33 -0800 (PST)
Received: from localhost.localdomain (host-89-229-233-64.dynamic.mm.pl. [89.229.233.64])
        by smtp.gmail.com with ESMTPSA id x18sm355624lfc.73.2020.11.04.01.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 01:46:32 -0800 (PST)
From:   mariusz.dudek@gmail.com
X-Google-Original-From: mariuszx.dudek@intel.com
To:     magnus.karlsson@intel.com, bjorn.topel@intel.com, ast@kernel.org,
        daniel@iogearbox.net, netdev@vger.kernel.org,
        jonathan.lemon@gmail.com
Cc:     bpf@vger.kernel.org, Mariusz Dudek <mariuszx.dudek@intel.com>
Subject: [PATCH bpf-next 1/2] libbpf: separate XDP program load with xsk socket creation
Date:   Wed,  4 Nov 2020 10:46:25 +0100
Message-Id: <20201104094626.3406-2-mariuszx.dudek@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201104094626.3406-1-mariuszx.dudek@intel.com>
References: <20201104094626.3406-1-mariuszx.dudek@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Mariusz Dudek <mariuszx.dudek@intel.com>

        Add support for separation of eBPF program load and xsk socket
        creation.

        This is needed for use-case when you want to privide as little
        privileges as possible to the data plane application that will
        handle xsk socket creation and incoming traffic.

        With this patch the data entity container can be run with only
        CAP_NET_RAW capability to fulfill its purpose of creating xsk
        socket and handling packages. In case your umem is larger or
        equal process limit for MEMLOCK you need either increase the
        limit or CAP_IPC_LOCK capability.

        To resolve privileges issue two APIs are introduced:

        - xsk_setup_xdp_prog - prepares bpf program if given and
        loads it on a selected network interface or loads the built in
        XDP program, if no XDP program is supplied. It can also return
        xsks_map_fd which is needed by unprivileged process to update
        xsks_map with AF_XDP socket "fd"

        - xsk_update_xskmap - inserts an AF_XDP socket into an xskmap
	for a particular xsk_socket

Signed-off-by: Mariusz Dudek <mariuszx.dudek@intel.com>
---
 tools/lib/bpf/libbpf.map |   2 +
 tools/lib/bpf/xsk.c      | 157 ++++++++++++++++++++++++++++++++-------
 tools/lib/bpf/xsk.h      |  13 ++++
 3 files changed, 146 insertions(+), 26 deletions(-)

diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 4ebfadf45b47..4b938de1ca39 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -336,4 +336,6 @@ LIBBPF_0.2.0 {
 		perf_buffer__epoll_fd;
 		perf_buffer__consume_buffer;
 		xsk_socket__create_shared;
+		xsk_setup_xdp_prog;
+		xsk_update_xskmap;
 } LIBBPF_0.1.0;
diff --git a/tools/lib/bpf/xsk.c b/tools/lib/bpf/xsk.c
index e3c98c007825..8c5219ceca45 100644
--- a/tools/lib/bpf/xsk.c
+++ b/tools/lib/bpf/xsk.c
@@ -351,13 +351,8 @@ int xsk_umem__create_v0_0_2(struct xsk_umem **umem_ptr, void *umem_area,
 COMPAT_VERSION(xsk_umem__create_v0_0_2, xsk_umem__create, LIBBPF_0.0.2)
 DEFAULT_VERSION(xsk_umem__create_v0_0_4, xsk_umem__create, LIBBPF_0.0.4)
 
-static int xsk_load_xdp_prog(struct xsk_socket *xsk)
+static int get_bpf_prog(struct bpf_prog_cfg *cfg_ptr, int xsks_map_fd)
 {
-	static const int log_buf_size = 16 * 1024;
-	struct xsk_ctx *ctx = xsk->ctx;
-	char log_buf[log_buf_size];
-	int err, prog_fd;
-
 	/* This is the C-program:
 	 * SEC("xdp_sock") int xdp_sock_prog(struct xdp_md *ctx)
 	 * {
@@ -382,7 +377,7 @@ static int xsk_load_xdp_prog(struct xsk_socket *xsk)
 		/* *(u32 *)(r10 - 4) = r2 */
 		BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_2, -4),
 		/* r1 = xskmap[] */
-		BPF_LD_MAP_FD(BPF_REG_1, ctx->xsks_map_fd),
+		BPF_LD_MAP_FD(BPF_REG_1, xsks_map_fd),
 		/* r3 = XDP_PASS */
 		BPF_MOV64_IMM(BPF_REG_3, 2),
 		/* call bpf_redirect_map */
@@ -394,7 +389,7 @@ static int xsk_load_xdp_prog(struct xsk_socket *xsk)
 		/* r2 += -4 */
 		BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
 		/* r1 = xskmap[] */
-		BPF_LD_MAP_FD(BPF_REG_1, ctx->xsks_map_fd),
+		BPF_LD_MAP_FD(BPF_REG_1, xsks_map_fd),
 		/* call bpf_map_lookup_elem */
 		BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
 		/* r1 = r0 */
@@ -406,7 +401,7 @@ static int xsk_load_xdp_prog(struct xsk_socket *xsk)
 		/* r2 = *(u32 *)(r10 - 4) */
 		BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_10, -4),
 		/* r1 = xskmap[] */
-		BPF_LD_MAP_FD(BPF_REG_1, ctx->xsks_map_fd),
+		BPF_LD_MAP_FD(BPF_REG_1, xsks_map_fd),
 		/* r3 = 0 */
 		BPF_MOV64_IMM(BPF_REG_3, 0),
 		/* call bpf_redirect_map */
@@ -414,17 +409,42 @@ static int xsk_load_xdp_prog(struct xsk_socket *xsk)
 		/* The jumps are to this instruction */
 		BPF_EXIT_INSN(),
 	};
-	size_t insns_cnt = sizeof(prog) / sizeof(struct bpf_insn);
 
-	prog_fd = bpf_load_program(BPF_PROG_TYPE_XDP, prog, insns_cnt,
-				   "LGPL-2.1 or BSD-2-Clause", 0, log_buf,
+	cfg_ptr->prog = malloc(sizeof(prog));
+	if (!cfg_ptr->prog)
+		return -ENOMEM;
+	memcpy(cfg_ptr->prog, prog, sizeof(prog));
+	cfg_ptr->license = "LGPL-2.1 or BSD-2-Clause";
+	cfg_ptr->insns_cnt = sizeof(prog) / sizeof(struct bpf_insn);
+
+	return 0;
+}
+
+static int xsk_load_xdp_prog(struct xsk_socket *xsk, struct bpf_prog_cfg *user_cfg)
+{
+	static const int log_buf_size = 16 * 1024;
+	struct xsk_ctx *ctx = xsk->ctx;
+	char log_buf[log_buf_size];
+	struct bpf_prog_cfg cfg;
+	int err, prog_fd;
+
+	if (user_cfg && user_cfg->insns_cnt) {
+		cfg = *user_cfg;
+	} else {
+		err = get_bpf_prog(&cfg, ctx->xsks_map_fd);
+		if (err)
+			return err;
+	}
+
+	prog_fd = bpf_load_program(BPF_PROG_TYPE_XDP, cfg.prog, cfg.insns_cnt,
+				   cfg.license, 0, log_buf,
 				   log_buf_size);
 	if (prog_fd < 0) {
 		pr_warn("BPF log buffer:\n%s", log_buf);
 		return prog_fd;
 	}
 
-	err = bpf_set_link_xdp_fd(xsk->ctx->ifindex, prog_fd,
+	err = bpf_set_link_xdp_fd(ctx->ifindex, prog_fd,
 				  xsk->config.xdp_flags);
 	if (err) {
 		close(prog_fd);
@@ -566,8 +586,43 @@ static int xsk_set_bpf_maps(struct xsk_socket *xsk)
 				   &xsk->fd, 0);
 }
 
-static int xsk_setup_xdp_prog(struct xsk_socket *xsk)
+static int xsk_create_xsk_struct(int ifindex, struct xsk_socket *xsk)
+{
+	char ifname[IFNAMSIZ];
+	struct xsk_ctx *ctx;
+	char *interface;
+	int res = -1;
+
+	ctx = calloc(1, sizeof(*ctx));
+	if (!ctx)
+		goto error_ctx;
+
+	interface = if_indextoname(ifindex, &ifname[0]);
+	if (!interface) {
+		res = -errno;
+		goto error_ifindex;
+	}
+
+	ctx->ifindex = ifindex;
+	strncpy(ctx->ifname, ifname, IFNAMSIZ - 1);
+	ctx->ifname[IFNAMSIZ - 1] = 0;
+
+	xsk->ctx = ctx;
+
+	return 0;
+
+error_ifindex:
+	free(ctx);
+error_ctx:
+	return res;
+}
+
+static int __xsk_setup_xdp_prog(struct xsk_socket *_xdp,
+				struct bpf_prog_cfg *cfg,
+				bool force_set_map,
+				int *xsks_map_fd)
 {
+	struct xsk_socket *xsk = _xdp;
 	struct xsk_ctx *ctx = xsk->ctx;
 	__u32 prog_id = 0;
 	int err;
@@ -578,14 +633,17 @@ static int xsk_setup_xdp_prog(struct xsk_socket *xsk)
 		return err;
 
 	if (!prog_id) {
-		err = xsk_create_bpf_maps(xsk);
-		if (err)
-			return err;
+		if (!cfg || !cfg->insns_cnt) {
+			err = xsk_create_bpf_maps(xsk);
+			if (err)
+				return err;
+		} else {
+			ctx->xsks_map_fd = cfg->xsks_map_fd;
+		}
 
-		err = xsk_load_xdp_prog(xsk);
+		err = xsk_load_xdp_prog(xsk, cfg);
 		if (err) {
-			xsk_delete_bpf_maps(xsk);
-			return err;
+			goto err_load_xdp_prog;
 		}
 	} else {
 		ctx->prog_fd = bpf_prog_get_fd_by_id(prog_id);
@@ -598,15 +656,29 @@ static int xsk_setup_xdp_prog(struct xsk_socket *xsk)
 		}
 	}
 
-	if (xsk->rx)
+	if (xsk->rx || force_set_map) {
 		err = xsk_set_bpf_maps(xsk);
-	if (err) {
-		xsk_delete_bpf_maps(xsk);
-		close(ctx->prog_fd);
-		return err;
+		if (err) {
+			if (!prog_id) {
+				goto err_set_bpf_maps;
+			} else {
+				close(ctx->prog_fd);
+				return err;
+			}
+		}
 	}
+	if (xsks_map_fd)
+		*xsks_map_fd = ctx->xsks_map_fd;
 
 	return 0;
+
+err_set_bpf_maps:
+	close(ctx->prog_fd);
+	bpf_set_link_xdp_fd(ctx->ifindex, -1, 0);
+err_load_xdp_prog:
+	xsk_delete_bpf_maps(xsk);
+
+	return err;
 }
 
 static struct xsk_ctx *xsk_get_ctx(struct xsk_umem *umem, int ifindex,
@@ -689,6 +761,39 @@ static struct xsk_ctx *xsk_create_ctx(struct xsk_socket *xsk,
 	return ctx;
 }
 
+static void xsk_destroy_xsk_struct(struct xsk_socket *xsk)
+{
+	free(xsk->ctx);
+	free(xsk);
+}
+
+int xsk_update_xskmap(struct xsk_socket *xsk, int fd)
+{
+	xsk->ctx->xsks_map_fd = fd;
+	return xsk_set_bpf_maps(xsk);
+}
+
+int xsk_setup_xdp_prog(int ifindex, struct bpf_prog_cfg *cfg,
+		       int *xsks_map_fd)
+{
+	struct xsk_socket *xsk;
+	int res = -1;
+
+	xsk = calloc(1, sizeof(*xsk));
+	if (!xsk)
+		return res;
+
+	res = xsk_create_xsk_struct(ifindex, xsk);
+	if (res)
+		return -EINVAL;
+
+	res = __xsk_setup_xdp_prog(xsk, cfg, false, xsks_map_fd);
+
+	xsk_destroy_xsk_struct(xsk);
+
+	return res;
+}
+
 int xsk_socket__create_shared(struct xsk_socket **xsk_ptr,
 			      const char *ifname,
 			      __u32 queue_id, struct xsk_umem *umem,
@@ -838,7 +943,7 @@ int xsk_socket__create_shared(struct xsk_socket **xsk_ptr,
 	ctx->prog_fd = -1;
 
 	if (!(xsk->config.libbpf_flags & XSK_LIBBPF_FLAGS__INHIBIT_PROG_LOAD)) {
-		err = xsk_setup_xdp_prog(xsk);
+		err = __xsk_setup_xdp_prog(xsk, NULL, false, NULL);
 		if (err)
 			goto out_mmap_tx;
 	}
diff --git a/tools/lib/bpf/xsk.h b/tools/lib/bpf/xsk.h
index 1069c46364ff..c42b91935d3c 100644
--- a/tools/lib/bpf/xsk.h
+++ b/tools/lib/bpf/xsk.h
@@ -201,6 +201,19 @@ struct xsk_umem_config {
 	__u32 flags;
 };
 
+struct bpf_prog_cfg {
+	struct bpf_insn *prog;
+	const char *license;
+	size_t insns_cnt;
+	int xsks_map_fd;
+};
+
+LIBBPF_API int xsk_setup_xdp_prog(int ifindex,
+				  struct bpf_prog_cfg *cfg,
+				  int *xsks_map_fd);
+LIBBPF_API int xsk_update_xskmap(struct xsk_socket *xsk,
+				 int xsks_map_fd);
+
 /* Flags for the libbpf_flags field. */
 #define XSK_LIBBPF_FLAGS__INHIBIT_PROG_LOAD (1 << 0)
 
-- 
2.20.1

