Return-Path: <bpf+bounces-51032-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A83A2F636
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 18:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2218816258D
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 17:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8344B231A37;
	Mon, 10 Feb 2025 17:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+EHStNW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A9B25B661;
	Mon, 10 Feb 2025 17:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739210360; cv=none; b=aKI97G3AJ95SxMLI9pkPnr275HFKVAZwhFlQaLEY2Cujx5de1llO/6Oz0plzUsEbR8DEugrXfvkheaOaBBzwY7sJAwEpuFSqWF0Jk5hD0gmKoim5zK88AA985RV4SfqVwLAeao96daUbNiR2KXvV1IQwlQpy7iQQSjhOW58DL14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739210360; c=relaxed/simple;
	bh=u5MWiglvMYpVPnnl2XtTYQSrlAvvwRm1PAIItwlkrR8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aI5P8nDZ/vhJWqT0G0cLbeLfbFcwDUu+FqbnyPPNWVfYPyURerlb3RGkZFaNgqfv4eHOIXwhI5lcYOMj3/NOod7NSCctxXCEOpoE16BSI5Qvx2V8PSMn25gBEaFlWtn3U0VG8m2qPt2vrWZd7TCC2OIoTBh56QXxziiAQzmxkII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+EHStNW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1426FC4CEE5;
	Mon, 10 Feb 2025 17:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739210359;
	bh=u5MWiglvMYpVPnnl2XtTYQSrlAvvwRm1PAIItwlkrR8=;
	h=From:To:Cc:Subject:Date:From;
	b=D+EHStNWvbNMb1Cq0Rn0LtpHIBp0y6BL3Q/rVG9OcfExg2TR8DRwheUW7aOrIQN7o
	 0mAUMelGc+G2JeJ7g4Us/O73mSDAg9KWEtx7GCx7C+7588L0mXZkElmmz2XqBDIQZn
	 jwmDO8lIW5c8Uxg7HqyHH+bWFeFRQnCMQ+XJJiLCIldf9yWuvQkt1QsvZPwLpotLqT
	 Ucdl7N4KGh4J/ZQ/Pz94697Lotiv9mHQfWx6xHXkET7k7W6G26eYSVsLZYrDZadTfT
	 abjETxRW+dcs6+mZjp8Q8eyLjBsBocPCY9mB7jqaAKvN73KytwEmMhpSV46w8iNBj0
	 t1qrQsKgyaCFw==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH bpf-next] bpf: Add tracepoints with null-able arguments
Date: Mon, 10 Feb 2025 18:59:13 +0100
Message-ID: <20250210175913.2893549-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some of the tracepoints slipped when we did the first scan, adding them now.

Fixes: 838a10bd2ebf ("bpf: Augment raw_tp arguments with PTR_MAYBE_NULL")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/btf.c | 99 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 9433b6467bbe..f8335bdc8bf8 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6505,6 +6505,8 @@ static const struct bpf_raw_tp_null_args raw_tp_null_args[] = {
 	/* rxrpc */
 	{ "rxrpc_recvdata", 0x1 },
 	{ "rxrpc_resend", 0x10 },
+	{ "rxrpc_tq", 0x10 },
+	{ "rxrpc_client", 0x1 },
 	/* sunrpc */
 	{ "xs_stream_read_data", 0x1 },
 	/* ... from xprt_cong_event event class */
@@ -6525,6 +6527,103 @@ static const struct bpf_raw_tp_null_args raw_tp_null_args[] = {
 	{ "mr_integ_alloc", 0x2000 },
 	/* bpf_testmod */
 	{ "bpf_testmod_test_read", 0x0 },
+	/* amdgpu */
+	{ "amdgpu_vm_bo_map", 0x1 },
+	{ "amdgpu_vm_bo_unmap", 0x1 },
+	/* netfs */
+	{ "netfs_folioq", 0x1 },
+	/* xfs from xfs_defer_pending_class */
+	{ "xfs_defer_create_intent", 0x1 },
+	{ "xfs_defer_cancel_list", 0x1 },
+	{ "xfs_defer_pending_finish", 0x1 },
+	{ "xfs_defer_pending_abort", 0x1 },
+	{ "xfs_defer_relog_intent", 0x1 },
+	{ "xfs_defer_isolate_paused", 0x1 },
+	{ "xfs_defer_item_pause", 0x1 },
+	{ "xfs_defer_item_unpause", 0x1 },
+	/* xfs from xfs_defer_pending_item_class */
+	{ "xfs_defer_add_item", 0x1 },
+	{ "xfs_defer_cancel_item", 0x1 },
+	{ "xfs_defer_finish_item", 0x1 },
+	/* xfs from xfs_icwalk_class */
+	{ "xfs_ioc_free_eofblocks", 0x10 },
+	{ "xfs_blockgc_free_space", 0x10 },
+	/* xfs from xfs_btree_cur_class */
+	{ "xfs_btree_updkeys", 0x100 },
+	{ "xfs_btree_overlapped_query_range", 0x100 },
+	/* xfs from xfs_imap_class*/
+	{ "xfs_map_blocks_found", 0x10000 },
+	{ "xfs_map_blocks_alloc", 0x10000 },
+	{ "xfs_iomap_alloc", 0x1000 },
+	{ "xfs_iomap_found", 0x1000 },
+	/* xfs from xfs_fs_class */
+	{ "xfs_inodegc_flush", 0x1 },
+	{ "xfs_inodegc_push", 0x1 },
+	{ "xfs_inodegc_start", 0x1 },
+	{ "xfs_inodegc_stop", 0x1 },
+	{ "xfs_inodegc_queue", 0x1 },
+	{ "xfs_inodegc_throttle", 0x1 },
+	{ "xfs_fs_sync_fs", 0x1 },
+	{ "xfs_blockgc_start", 0x1 },
+	{ "xfs_blockgc_stop", 0x1 },
+	{ "xfs_blockgc_worker", 0x1 },
+	{ "xfs_blockgc_flush_all", 0x1 },
+	/* xfs_scrub */
+	{ "xchk_nlinks_live_update", 0x10 },
+	/* xfs_scrub from xchk_metapath_class */
+	{ "xchk_metapath_lookup", 0x100 },
+	/* nfsd */
+	{ "nfsd_dirent", 0x1 },
+	{ "nfsd_file_acquire", 0x1001 },
+	{ "nfsd_file_insert_err", 0x1 },
+	{ "nfsd_file_cons_err", 0x1 },
+	/* nfs4 */
+	{ "nfs4_setup_sequence", 0x1 },
+	{ "pnfs_update_layout", 0x10000 },
+	{ "nfs4_inode_callback_event", 0x200 },
+	{ "nfs4_inode_stateid_callback_event", 0x200 },
+	/* nfs from pnfs_layout_event */
+	{ "pnfs_mds_fallback_pg_init_read", 0x10000 },
+	{ "pnfs_mds_fallback_pg_init_write", 0x10000 },
+	{ "pnfs_mds_fallback_pg_get_mirror_count", 0x10000 },
+	{ "pnfs_mds_fallback_read_done", 0x10000 },
+	{ "pnfs_mds_fallback_write_done", 0x10000 },
+	{ "pnfs_mds_fallback_read_pagelist", 0x10000 },
+	{ "pnfs_mds_fallback_write_pagelist", 0x10000 },
+	/* coda */
+	{ "coda_dec_pic_run", 0x10 },
+	{ "coda_dec_pic_done", 0x10 },
+	/* cfg80211 */
+	{ "cfg80211_scan_done", 0x11 },
+	{ "rdev_set_coalesce", 0x10 },
+	{ "cfg80211_report_wowlan_wakeup", 0x100 },
+	{ "cfg80211_inform_bss_frame", 0x100 },
+	{ "cfg80211_michael_mic_failure", 0x10000 },
+	/* cfg80211 from wiphy_work_event */
+	{ "wiphy_work_queue", 0x10 },
+	{ "wiphy_work_run", 0x10 },
+	{ "wiphy_work_cancel", 0x10 },
+	{ "wiphy_work_flush", 0x10 },
+	/* hugetlbfs */
+	{ "hugetlbfs_alloc_inode", 0x10 },
+	/* spufs */
+	{ "spufs_context", 0x10 },
+	/* kvm_hv */
+	{ "kvm_page_fault_enter", 0x100 },
+	/* dpu */
+	{ "dpu_crtc_setup_mixer", 0x100 },
+	/* binder */
+	{ "binder_transaction", 0x100 },
+	/* bcachefs */
+	{ "btree_path_free", 0x100 },
+	/* hfi1_tx */
+	{ "hfi1_sdma_progress", 0x1000 },
+	/* iptfs */
+	{ "iptfs_ingress_postq_event", 0x1000 },
+	/* neigh */
+	{ "neigh_update", 0x10 },
+	/* snd_firewire_lib */
+	{ "amdtp_packet", 0x100 },
 };
 
 bool btf_ctx_access(int off, int size, enum bpf_access_type type,
-- 
2.48.1


