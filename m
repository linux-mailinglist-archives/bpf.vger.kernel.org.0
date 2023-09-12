Return-Path: <bpf+bounces-9709-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C10379C672
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 08:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C13991C208E4
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 06:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05644171AC;
	Tue, 12 Sep 2023 06:08:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE55828E6
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 06:08:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9C0E77;
	Mon, 11 Sep 2023 23:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=sFuiyOstyY2vXIAcLnV3dqg2ACy5vJ9mQ7xD1vWkyWU=; b=S+ghahK5zgWOWbOTGcZSByqN4k
	zlUfkuCICe0Zo95hD5owu+bcaqeo2x7YtelwLOYT+BvXaavKIrSo9avGUI9fGd2n1BG7I3uF9TiXV
	XqpqeG+RQXkOsYDYUoj1bdd6cnfD+CcR4Pnbnl6aW+8KiG6Yz6qvlMuvGxaalRwPE1p1sM9K/i1FO
	akZ3V3QRBtD7H9lndzkSNoROC6jRSDAWl/I3JIATZxLkcWKfwsnYqc657U2TfY2K52NzLPlfiAqvS
	Rnmfu1KDyWkf5xv4Di1a5V4TAUN1JKE7BTscWhIB1Pe9ZY/cp97GWrMc5cuxveOxvlYvopZmMryo5
	ogbMDsVw==;
Received: from [2601:1c2:980:9ec0::9fed] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qfwZJ-002FfO-15;
	Tue, 12 Sep 2023 06:08:13 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf] bpf, cgroup: fix multiple kernel-doc warnings
Date: Mon, 11 Sep 2023 23:08:12 -0700
Message-ID: <20230912060812.1715-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix missing or extra function parameter kernel-doc warnings
in cgroup.c:

kernel/bpf/cgroup.c:1359: warning: Excess function parameter 'type' description in '__cgroup_bpf_run_filter_skb'
kernel/bpf/cgroup.c:1359: warning: Function parameter or member 'atype' not described in '__cgroup_bpf_run_filter_skb'
kernel/bpf/cgroup.c:1439: warning: Excess function parameter 'type' description in '__cgroup_bpf_run_filter_sk'
kernel/bpf/cgroup.c:1439: warning: Function parameter or member 'atype' not described in '__cgroup_bpf_run_filter_sk'
kernel/bpf/cgroup.c:1467: warning: Excess function parameter 'type' description in '__cgroup_bpf_run_filter_sock_addr'
kernel/bpf/cgroup.c:1467: warning: Function parameter or member 'atype' not described in '__cgroup_bpf_run_filter_sock_addr'
kernel/bpf/cgroup.c:1512: warning: Excess function parameter 'type' description in '__cgroup_bpf_run_filter_sock_ops'
kernel/bpf/cgroup.c:1512: warning: Function parameter or member 'atype' not described in '__cgroup_bpf_run_filter_sock_ops'
kernel/bpf/cgroup.c:1685: warning: Excess function parameter 'type' description in '__cgroup_bpf_run_filter_sysctl'
kernel/bpf/cgroup.c:1685: warning: Function parameter or member 'atype' not described in '__cgroup_bpf_run_filter_sysctl'
kernel/bpf/cgroup.c:795: warning: Excess function parameter 'type' description in '__cgroup_bpf_replace'
kernel/bpf/cgroup.c:795: warning: Function parameter or member 'new_prog' not described in '__cgroup_bpf_replace'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/cgroup.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff -- a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -785,7 +785,8 @@ found:
  *                          to descendants
  * @cgrp: The cgroup which descendants to traverse
  * @link: A link for which to replace BPF program
- * @type: Type of attach operation
+ * @new_prog: &struct bpf_prog for the target BPF program with its refcnt
+ *            incremented
  *
  * Must be called with cgroup_mutex held.
  */
@@ -1334,7 +1335,7 @@ int cgroup_bpf_prog_query(const union bp
  * __cgroup_bpf_run_filter_skb() - Run a program for packet filtering
  * @sk: The socket sending or receiving traffic
  * @skb: The skb that is being sent or received
- * @type: The type of program to be executed
+ * @atype: The type of program to be executed
  *
  * If no socket is passed, or the socket is not of type INET or INET6,
  * this function does nothing and returns 0.
@@ -1424,7 +1425,7 @@ EXPORT_SYMBOL(__cgroup_bpf_run_filter_sk
 /**
  * __cgroup_bpf_run_filter_sk() - Run a program on a sock
  * @sk: sock structure to manipulate
- * @type: The type of program to be executed
+ * @atype: The type of program to be executed
  *
  * socket is passed is expected to be of type INET or INET6.
  *
@@ -1449,7 +1450,7 @@ EXPORT_SYMBOL(__cgroup_bpf_run_filter_sk
  *                                       provided by user sockaddr
  * @sk: sock struct that will use sockaddr
  * @uaddr: sockaddr struct provided by user
- * @type: The type of program to be executed
+ * @atype: The type of program to be executed
  * @t_ctx: Pointer to attach type specific context
  * @flags: Pointer to u32 which contains higher bits of BPF program
  *         return value (OR'ed together).
@@ -1496,7 +1497,7 @@ EXPORT_SYMBOL(__cgroup_bpf_run_filter_so
  * @sock_ops: bpf_sock_ops_kern struct to pass to program. Contains
  * sk with connection information (IP addresses, etc.) May not contain
  * cgroup info if it is a req sock.
- * @type: The type of program to be executed
+ * @atype: The type of program to be executed
  *
  * socket passed is expected to be of type INET or INET6.
  *
@@ -1670,7 +1671,7 @@ const struct bpf_verifier_ops cg_dev_ver
  * @ppos: value-result argument: value is position at which read from or write
  *	to sysctl is happening, result is new position if program overrode it,
  *	initial value otherwise
- * @type: type of program to be executed
+ * @atype: type of program to be executed
  *
  * Program is run when sysctl is being accessed, either read or written, and
  * can allow or deny such access.

