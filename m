Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F256D43A5B1
	for <lists+bpf@lfdr.de>; Mon, 25 Oct 2021 23:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235079AbhJYVUq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Oct 2021 17:20:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:46008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235086AbhJYVUp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Oct 2021 17:20:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B50A760FDC;
        Mon, 25 Oct 2021 21:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635196703;
        bh=ZkMbbqz10cwMBhjk6UVExasGDyFwBzZ4akzqlOcNlIc=;
        h=From:To:Cc:Subject:Date:From;
        b=aKXZyAv6HmTOuDOVZDCByrQ+0yV1TelQqxAy4qg5HD3DUpMcAjLbpH4yNd/+EfJCM
         JZ04xgzHgXnMwpy4lnCl0ScwctC2NaUBW+Wvi3TQMSPgNrXDtuaMT0eoG0SmpJBGpf
         dONc4rmKVDbR7RQ7UDR78P7zPq8+oJfJBErVa5YASJzJOABPuxMG4XsnjIBHQ0CZOM
         OZpJvGA2fsZH0DrD9Q4D1a2eVS0yuH7X5epZsSWqwu3ZO/O0OiVADEEvtuwGbFpxE0
         xqHovCAbZpwYW1tpN0+RTxkhg0XbpimKPY3RI2dxStnX7dVPL+0LJXy5+W/mlf6hAD
         2oyJzLc/3/MJA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, brouer@redhat.com,
        dsahern@kernel.org, toke@redhat.com, lorenzo.bianconi@redhat.com
Subject: [PATCH bpf-next] bpf: introduce bpf_map_get_xdp_prog utility routine
Date:   Mon, 25 Oct 2021 23:18:02 +0200
Message-Id: <269c70c6c529a09eb6d6b489eb9bf5e5513c943a.1635196496.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Introduce bpf_map_get_xdp_prog to load an eBPF program on
CPUMAP/DEVMAP entries since both of them share the same code.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 include/linux/bpf.h |  2 ++
 kernel/bpf/core.c   | 17 +++++++++++++++++
 kernel/bpf/cpumap.c | 12 ++++--------
 kernel/bpf/devmap.c | 16 ++++++----------
 4 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 26bf8c865103..891936b54b55 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1910,6 +1910,8 @@ static inline struct bpf_prog *bpf_prog_get_type(u32 ufd,
 	return bpf_prog_get_type_dev(ufd, type, false);
 }
 
+struct bpf_prog *bpf_map_get_xdp_prog(struct bpf_map *map, int fd,
+				      enum bpf_attach_type attach_type);
 void __bpf_free_used_maps(struct bpf_prog_aux *aux,
 			  struct bpf_map **used_maps, u32 len);
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index dee91a2eea7b..7e72c21b6589 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2228,6 +2228,23 @@ void __bpf_free_used_maps(struct bpf_prog_aux *aux,
 	}
 }
 
+struct bpf_prog *bpf_map_get_xdp_prog(struct bpf_map *map, int fd,
+				      enum bpf_attach_type attach_type)
+{
+	struct bpf_prog *prog;
+
+	prog = bpf_prog_get_type(fd, BPF_PROG_TYPE_XDP);
+	if (IS_ERR(prog))
+		return prog;
+
+	if (prog->expected_attach_type != attach_type) {
+		bpf_prog_put(prog);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return prog;
+}
+
 static void bpf_free_used_maps(struct bpf_prog_aux *aux)
 {
 	__bpf_free_used_maps(aux, aux->used_maps, aux->used_map_cnt);
diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 585b2b77ccc4..0b3e561e0c2a 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -397,19 +397,15 @@ static int cpu_map_kthread_run(void *data)
 	return 0;
 }
 
-static int __cpu_map_load_bpf_program(struct bpf_cpu_map_entry *rcpu, int fd)
+static int __cpu_map_load_bpf_program(struct bpf_cpu_map_entry *rcpu,
+				      struct bpf_map *map, int fd)
 {
 	struct bpf_prog *prog;
 
-	prog = bpf_prog_get_type(fd, BPF_PROG_TYPE_XDP);
+	prog = bpf_map_get_xdp_prog(map, fd, BPF_XDP_CPUMAP);
 	if (IS_ERR(prog))
 		return PTR_ERR(prog);
 
-	if (prog->expected_attach_type != BPF_XDP_CPUMAP) {
-		bpf_prog_put(prog);
-		return -EINVAL;
-	}
-
 	rcpu->value.bpf_prog.id = prog->aux->id;
 	rcpu->prog = prog;
 
@@ -457,7 +453,7 @@ __cpu_map_entry_alloc(struct bpf_map *map, struct bpf_cpumap_val *value,
 	rcpu->map_id = map->id;
 	rcpu->value.qsize  = value->qsize;
 
-	if (fd > 0 && __cpu_map_load_bpf_program(rcpu, fd))
+	if (fd > 0 && __cpu_map_load_bpf_program(rcpu, map, fd))
 		goto free_ptr_ring;
 
 	/* Setup kthread */
diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index f02d04540c0c..59df0745f72d 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -864,12 +864,12 @@ static struct bpf_dtab_netdev *__dev_map_alloc_node(struct net *net,
 		goto err_out;
 
 	if (val->bpf_prog.fd > 0) {
-		prog = bpf_prog_get_type_dev(val->bpf_prog.fd,
-					     BPF_PROG_TYPE_XDP, false);
-		if (IS_ERR(prog))
-			goto err_put_dev;
-		if (prog->expected_attach_type != BPF_XDP_DEVMAP)
-			goto err_put_prog;
+		prog = bpf_map_get_xdp_prog(&dtab->map, val->bpf_prog.fd,
+					    BPF_XDP_DEVMAP);
+		if (IS_ERR(prog)) {
+			dev_put(dev->dev);
+			goto err_out;
+		}
 	}
 
 	dev->idx = idx;
@@ -884,10 +884,6 @@ static struct bpf_dtab_netdev *__dev_map_alloc_node(struct net *net,
 	dev->val.ifindex = val->ifindex;
 
 	return dev;
-err_put_prog:
-	bpf_prog_put(prog);
-err_put_dev:
-	dev_put(dev->dev);
 err_out:
 	kfree(dev);
 	return ERR_PTR(-EINVAL);
-- 
2.31.1

