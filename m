Return-Path: <bpf+bounces-64320-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C237EB1153B
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 02:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 470D11CC3BE1
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 00:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1905676026;
	Fri, 25 Jul 2025 00:28:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF4D7260B
	for <bpf@vger.kernel.org>; Fri, 25 Jul 2025 00:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753403335; cv=none; b=E7t64T81mh6x5RK93pCtxd97WZk6OYhmEbGD7n2ikCgBvo/ZxczHgy5WPedeGnzAMGZ1y9FTeo7aEULVs0mVcBpqCcmfE9NTQqyBbpqbDzXpMWFqfeZgIxAKXi2uc04W5MoJeqXcnxMG3Sbb5gQtZd4hC4s8EIyF67Dr7F65BiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753403335; c=relaxed/simple;
	bh=FzwZKj6D2kXvqQX4k81CHMQO+h2+EOfd9gnQPKkLeQM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=u3RCmDhP8W1RoiLXMVkzAIuYuTHi17b9pfpbR03mQoIwnUQ+TXnPDGXYNJQnbKhvl70KjHdZjTssQPKhluI5H9toyXNr6+MNqEejkxwEYsKIkrPIXq9HZgS7Tz7gbHfAr5/smrEpdqez+y2Du3hXW6degjTvSlarJbDy6upx2ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 526cfed068ee11f0b29709d653e92f7d-20250725
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:97c8a2cf-3102-486f-b571-b55d7cd1cee2,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-40,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-25
X-CID-INFO: VERSION:1.1.45,REQID:97c8a2cf-3102-486f-b571-b55d7cd1cee2,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-40,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:6493067,CLOUDID:a2f2aa4939be0fd7fd1220bf8caf4a42,BulkI
	D:250725082847SMVIEQ0J,BulkQuantity:0,Recheck:0,SF:10|24|44|66|78|102,TC:n
	il,Content:0|50,EDM:-3,IP:-2,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil
	,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSI,TF_CID_SPAM_ULS
X-UUID: 526cfed068ee11f0b29709d653e92f7d-20250725
X-User: jianghaoran@kylinos.cn
Received: from localhost.localdomain [(39.156.73.13)] by mailgw.kylinos.cn
	(envelope-from <jianghaoran@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1345983305; Fri, 25 Jul 2025 08:28:44 +0800
From: Haoran Jiang <jianghaoran@kylinos.cn>
To: loongarch@lists.linux.dev
Cc: bpf@vger.kernel.org,
	kernel@xen0n.name,
	chenhuacai@kernel.org,
	hengqi.chen@gmail.com,
	yangtiezhu@loongson.cn,
	jolsa@kernel.org,
	haoluo@google.com,
	sdf@fomichev.me,
	kpsingh@kernel.org,
	john.fastabend@gmail.com,
	yonghong.song@linux.dev,
	song@kernel.org,
	eddyz87@gmail.com,
	martin.lau@linux.dev,
	andrii@kernel.org,
	daniel@iogearbox.net,
	ast@kernel.org
Subject: [PATCH v3 0/2] Fix two tailcall-related issues
Date: Fri, 25 Jul 2025 08:28:33 +0800
Message-Id: <20250725002835.64211-1-jianghaoran@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

v3:
1,In the prepare_bpf_tail_call_cnt function, emit_tailcall_jmp is replaced with emit_cond_jmp.
2,Fix the issue where test cases using fentry/fexit fail.

Test after merging these two patches and the following trampoline series patches.
https://lore.kernel.org/loongarch/CAK3+h2zirm6cV2tAbd38RSYSF3=B1qZ+9jm_GZPsAPrMtaozmg@mail.gmail.com/T/#mf1f1c9f965d5229c6d2dce3b1ca8bc9a5d70520d

./test_progs -a tailcalls
#413/1   tailcalls/tailcall_1:OK
#413/2   tailcalls/tailcall_2:OK
#413/3   tailcalls/tailcall_3:OK
#413/4   tailcalls/tailcall_4:OK
#413/5   tailcalls/tailcall_5:OK
#413/6   tailcalls/tailcall_6:OK
#413/7   tailcalls/tailcall_bpf2bpf_1:OK
#413/8   tailcalls/tailcall_bpf2bpf_2:OK
#413/9   tailcalls/tailcall_bpf2bpf_3:OK
#413/10  tailcalls/tailcall_bpf2bpf_4:OK
#413/11  tailcalls/tailcall_bpf2bpf_5:OK
#413/12  tailcalls/tailcall_bpf2bpf_6:OK
#413/13  tailcalls/tailcall_bpf2bpf_fentry:OK
#413/14  tailcalls/tailcall_bpf2bpf_fexit:OK
#413/15  tailcalls/tailcall_bpf2bpf_fentry_fexit:OK
#413/16  tailcalls/tailcall_bpf2bpf_fentry_entry:OK
#413/17  tailcalls/tailcall_poke:OK
#413/18  tailcalls/tailcall_bpf2bpf_hierarchy_1:OK
#413/19  tailcalls/tailcall_bpf2bpf_hierarchy_fentry:OK
#413/20  tailcalls/tailcall_bpf2bpf_hierarchy_fexit:OK
#413/21  tailcalls/tailcall_bpf2bpf_hierarchy_fentry_fexit:OK
#413/22  tailcalls/tailcall_bpf2bpf_hierarchy_fentry_entry:OK
#413/23  tailcalls/tailcall_bpf2bpf_hierarchy_2:OK
#413/24  tailcalls/tailcall_bpf2bpf_hierarchy_3:OK
#413/25  tailcalls/tailcall_freplace:OK
#413/26  tailcalls/tailcall_bpf2bpf_freplace:OK
#413/27  tailcalls/tailcall_failure:OK
#413/28  tailcalls/reject_tail_call_spin_lock:OK
#413/29  tailcalls/reject_tail_call_rcu_lock:OK
#413/30  tailcalls/reject_tail_call_preempt_lock:OK
#413/31  tailcalls/reject_tail_call_ref:OK
#413     tailcalls:OK
Summary: 1/31 PASSED, 0 SKIPPED, 0 FAILED


v2:
1,Add a Fixes tag.
2,Ctx as the first parameter of emit_bpf_tail_call.
3,Define jmp_offset as a macro in emit_bpf_tail_call.

After merging these two patches, the test results are as follows:

./test_progs --allow=tailcalls
tester_init:PASS:tester_log_buf 0 nsec
process_subtest:PASS:obj_open_mem 0 nsec
process_subtest:PASS:specs_alloc 0 nsec
#413/1   tailcalls/tailcall_1:OK
#413/2   tailcalls/tailcall_2:OK
#413/3   tailcalls/tailcall_3:OK
#413/4   tailcalls/tailcall_4:OK
#413/5   tailcalls/tailcall_5:OK
#413/6   tailcalls/tailcall_6:OK
#413/7   tailcalls/tailcall_bpf2bpf_1:OK
#413/8   tailcalls/tailcall_bpf2bpf_2:OK
#413/9   tailcalls/tailcall_bpf2bpf_3:OK
#413/10  tailcalls/tailcall_bpf2bpf_4:OK
#413/11  tailcalls/tailcall_bpf2bpf_5:OK
#413/12  tailcalls/tailcall_bpf2bpf_6:OK
test_tailcall_count:PASS:open fentry_obj file 0 nsec
test_tailcall_count:PASS:find fentry prog 0 nsec
test_tailcall_count:PASS:set_attach_target subprog_tail 0 nsec
test_tailcall_count:PASS:load fentry_obj 0 nsec
libbpf: prog 'fentry': failed to attach: -ENOTSUPP
test_tailcall_count:FAIL:attach_trace unexpected error: -524
#413/13  tailcalls/tailcall_bpf2bpf_fentry:FAIL
test_tailcall_count:PASS:open fexit_obj file 0 nsec
test_tailcall_count:PASS:find fexit prog 0 nsec
test_tailcall_count:PASS:set_attach_target subprog_tail 0 nsec
test_tailcall_count:PASS:load fexit_obj 0 nsec
libbpf: prog 'fexit': failed to attach: -ENOTSUPP
test_tailcall_count:FAIL:attach_trace unexpected error: -524
#413/14  tailcalls/tailcall_bpf2bpf_fexit:FAIL
test_tailcall_count:PASS:open fentry_obj file 0 nsec
test_tailcall_count:PASS:find fentry prog 0 nsec
test_tailcall_count:PASS:set_attach_target subprog_tail 0 nsec
test_tailcall_count:PASS:load fentry_obj 0 nsec
libbpf: prog 'fentry': failed to attach: -ENOTSUPP
test_tailcall_count:FAIL:attach_trace unexpected error: -524
#413/15  tailcalls/tailcall_bpf2bpf_fentry_fexit:FAIL
test_tailcall_bpf2bpf_fentry_entry:PASS:load tgt_obj 0 nsec
test_tailcall_bpf2bpf_fentry_entry:PASS:find jmp_table map 0 nsec
test_tailcall_bpf2bpf_fentry_entry:PASS:find jmp_table map fd 0 nsec
test_tailcall_bpf2bpf_fentry_entry:PASS:find classifier_0 prog 0 nsec
test_tailcall_bpf2bpf_fentry_entry:PASS:find classifier_0 prog fd 0 nsec
test_tailcall_bpf2bpf_fentry_entry:PASS:update jmp_table 0 nsec
test_tailcall_bpf2bpf_fentry_entry:PASS:open fentry_obj file 0 nsec
test_tailcall_bpf2bpf_fentry_entry:PASS:find fentry prog 0 nsec
test_tailcall_bpf2bpf_fentry_entry:PASS:set_attach_target classifier_0 0 nsec
test_tailcall_bpf2bpf_fentry_entry:PASS:load fentry_obj 0 nsec
libbpf: prog 'fentry': failed to attach: -ENOTSUPP
test_tailcall_bpf2bpf_fentry_entry:FAIL:attach_trace unexpected error: -524
#413/16  tailcalls/tailcall_bpf2bpf_fentry_entry:FAIL
#413/17  tailcalls/tailcall_poke:OK
#413/18  tailcalls/tailcall_bpf2bpf_hierarchy_1:OK
test_tailcall_hierarchy_count:PASS:load obj 0 nsec
test_tailcall_hierarchy_count:PASS:find entry prog 0 nsec
test_tailcall_hierarchy_count:PASS:prog_fd 0 nsec
test_tailcall_hierarchy_count:PASS:find jmp_table 0 nsec
test_tailcall_hierarchy_count:PASS:map_fd 0 nsec
test_tailcall_hierarchy_count:PASS:update jmp_table 0 nsec
test_tailcall_hierarchy_count:PASS:find data_map 0 nsec
test_tailcall_hierarchy_count:PASS:open fentry_obj file 0 nsec
test_tailcall_hierarchy_count:PASS:find fentry prog 0 nsec
test_tailcall_hierarchy_count:PASS:set_attach_target subprog_tail 0 nsec
test_tailcall_hierarchy_count:PASS:load fentry_obj 0 nsec
libbpf: prog 'fentry': failed to attach: -ENOTSUPP
test_tailcall_hierarchy_count:FAIL:attach_trace unexpected error: -524
#413/19  tailcalls/tailcall_bpf2bpf_hierarchy_fentry:FAIL
test_tailcall_hierarchy_count:PASS:load obj 0 nsec
test_tailcall_hierarchy_count:PASS:find entry prog 0 nsec
test_tailcall_hierarchy_count:PASS:prog_fd 0 nsec
test_tailcall_hierarchy_count:PASS:find jmp_table 0 nsec
test_tailcall_hierarchy_count:PASS:map_fd 0 nsec
test_tailcall_hierarchy_count:PASS:update jmp_table 0 nsec
test_tailcall_hierarchy_count:PASS:find data_map 0 nsec
test_tailcall_hierarchy_count:PASS:open fexit_obj file 0 nsec
test_tailcall_hierarchy_count:PASS:find fexit prog 0 nsec
test_tailcall_hierarchy_count:PASS:set_attach_target subprog_tail 0 nsec
test_tailcall_hierarchy_count:PASS:load fexit_obj 0 nsec
libbpf: prog 'fexit': failed to attach: -ENOTSUPP
test_tailcall_hierarchy_count:FAIL:attach_trace unexpected error: -524
#413/20  tailcalls/tailcall_bpf2bpf_hierarchy_fexit:FAIL
test_tailcall_hierarchy_count:PASS:load obj 0 nsec
test_tailcall_hierarchy_count:PASS:find entry prog 0 nsec
test_tailcall_hierarchy_count:PASS:prog_fd 0 nsec
test_tailcall_hierarchy_count:PASS:find jmp_table 0 nsec
test_tailcall_hierarchy_count:PASS:map_fd 0 nsec
test_tailcall_hierarchy_count:PASS:update jmp_table 0 nsec
test_tailcall_hierarchy_count:PASS:find data_map 0 nsec
test_tailcall_hierarchy_count:PASS:open fentry_obj file 0 nsec
test_tailcall_hierarchy_count:PASS:find fentry prog 0 nsec
test_tailcall_hierarchy_count:PASS:set_attach_target subprog_tail 0 nsec
test_tailcall_hierarchy_count:PASS:load fentry_obj 0 nsec
libbpf: prog 'fentry': failed to attach: -ENOTSUPP
test_tailcall_hierarchy_count:FAIL:attach_trace unexpected error: -524
#413/21  tailcalls/tailcall_bpf2bpf_hierarchy_fentry_fexit:FAIL
test_tailcall_hierarchy_count:PASS:load obj 0 nsec
test_tailcall_hierarchy_count:PASS:find entry prog 0 nsec
test_tailcall_hierarchy_count:PASS:prog_fd 0 nsec
test_tailcall_hierarchy_count:PASS:open fentry_obj file 0 nsec
test_tailcall_hierarchy_count:PASS:find fentry prog 0 nsec
test_tailcall_hierarchy_count:PASS:set_attach_target entry 0 nsec
test_tailcall_hierarchy_count:PASS:load fentry_obj 0 nsec
libbpf: prog 'fentry': failed to attach: -ENOTSUPP
test_tailcall_hierarchy_count:FAIL:attach_trace unexpected error: -524
tester_init:PASS:tester_log_buf 0 nsec
process_subtest:PASS:obj_open_mem 0 nsec
process_subtest:PASS:specs_alloc 0 nsec
#413/22  tailcalls/tailcall_bpf2bpf_hierarchy_fentry_entry:FAIL
#413/23  tailcalls/tailcall_bpf2bpf_hierarchy_2:OK
#413/24  tailcalls/tailcall_bpf2bpf_hierarchy_3:OK
test_tailcall_freplace:PASS:tailcall_freplace__open 0 nsec
test_tailcall_freplace:PASS:tc_bpf2bpf__open_and_load 0 nsec
test_tailcall_freplace:PASS:set_attach_target 0 nsec
test_tailcall_freplace:PASS:tailcall_freplace__load 0 nsec
test_tailcall_freplace:PASS:update jmp_table failure 0 nsec
libbpf: prog 'entry_freplace': failed to attach to freplace: -ENOTSUPP
test_tailcall_freplace:FAIL:attach_freplace unexpected error: -524
#413/25  tailcalls/tailcall_freplace:FAIL
test_tailcall_bpf2bpf_freplace:PASS:tc_bpf2bpf__open_and_load 0 nsec
test_tailcall_bpf2bpf_freplace:PASS:tailcall_freplace__open 0 nsec
test_tailcall_bpf2bpf_freplace:PASS:set_attach_target 0 nsec
test_tailcall_bpf2bpf_freplace:PASS:tailcall_freplace__load 0 nsec
libbpf: prog 'entry_freplace': failed to attach to freplace: -ENOTSUPP
test_tailcall_bpf2bpf_freplace:FAIL:attach_freplace unexpected error: -524
#413/26  tailcalls/tailcall_bpf2bpf_freplace:FAIL
#413/27  tailcalls/tailcall_failure:OK
#413/28  tailcalls/reject_tail_call_spin_lock:OK
#413/29  tailcalls/reject_tail_call_rcu_lock:OK
#413/30  tailcalls/reject_tail_call_preempt_lock:OK
#413/31  tailcalls/reject_tail_call_ref:OK
#413     tailcalls:FAIL

All error logs:
tester_init:PASS:tester_log_buf 0 nsec
process_subtest:PASS:obj_open_mem 0 nsec
process_subtest:PASS:specs_alloc 0 nsec
test_tailcall_count:PASS:open fentry_obj file 0 nsec
test_tailcall_count:PASS:find fentry prog 0 nsec
test_tailcall_count:PASS:set_attach_target subprog_tail 0 nsec
test_tailcall_count:PASS:load fentry_obj 0 nsec
libbpf: prog 'fentry': failed to attach: -ENOTSUPP
test_tailcall_count:FAIL:attach_trace unexpected error: -524
#413/13  tailcalls/tailcall_bpf2bpf_fentry:FAIL
test_tailcall_count:PASS:open fexit_obj file 0 nsec
test_tailcall_count:PASS:find fexit prog 0 nsec
test_tailcall_count:PASS:set_attach_target subprog_tail 0 nsec
test_tailcall_count:PASS:load fexit_obj 0 nsec
libbpf: prog 'fexit': failed to attach: -ENOTSUPP
test_tailcall_count:FAIL:attach_trace unexpected error: -524
#413/14  tailcalls/tailcall_bpf2bpf_fexit:FAIL
test_tailcall_count:PASS:open fentry_obj file 0 nsec
test_tailcall_count:PASS:find fentry prog 0 nsec
test_tailcall_count:PASS:set_attach_target subprog_tail 0 nsec
test_tailcall_count:PASS:load fentry_obj 0 nsec
libbpf: prog 'fentry': failed to attach: -ENOTSUPP
test_tailcall_count:FAIL:attach_trace unexpected error: -524
#413/15  tailcalls/tailcall_bpf2bpf_fentry_fexit:FAIL
test_tailcall_bpf2bpf_fentry_entry:PASS:load tgt_obj 0 nsec
test_tailcall_bpf2bpf_fentry_entry:PASS:find jmp_table map 0 nsec
test_tailcall_bpf2bpf_fentry_entry:PASS:find jmp_table map fd 0 nsec
test_tailcall_bpf2bpf_fentry_entry:PASS:find classifier_0 prog 0 nsec
test_tailcall_bpf2bpf_fentry_entry:PASS:find classifier_0 prog fd 0 nsec
test_tailcall_bpf2bpf_fentry_entry:PASS:update jmp_table 0 nsec
test_tailcall_bpf2bpf_fentry_entry:PASS:open fentry_obj file 0 nsec
test_tailcall_bpf2bpf_fentry_entry:PASS:find fentry prog 0 nsec
test_tailcall_bpf2bpf_fentry_entry:PASS:set_attach_target classifier_0 0 nsec
test_tailcall_bpf2bpf_fentry_entry:PASS:load fentry_obj 0 nsec
libbpf: prog 'fentry': failed to attach: -ENOTSUPP
test_tailcall_bpf2bpf_fentry_entry:FAIL:attach_trace unexpected error: -524
#413/16  tailcalls/tailcall_bpf2bpf_fentry_entry:FAIL
test_tailcall_hierarchy_count:PASS:load obj 0 nsec
test_tailcall_hierarchy_count:PASS:find entry prog 0 nsec
test_tailcall_hierarchy_count:PASS:prog_fd 0 nsec
test_tailcall_hierarchy_count:PASS:find jmp_table 0 nsec
test_tailcall_hierarchy_count:PASS:map_fd 0 nsec
test_tailcall_hierarchy_count:PASS:update jmp_table 0 nsec
test_tailcall_hierarchy_count:PASS:find data_map 0 nsec
test_tailcall_hierarchy_count:PASS:open fentry_obj file 0 nsec
test_tailcall_hierarchy_count:PASS:find fentry prog 0 nsec
test_tailcall_hierarchy_count:PASS:set_attach_target subprog_tail 0 nsec
test_tailcall_hierarchy_count:PASS:load fentry_obj 0 nsec
libbpf: prog 'fentry': failed to attach: -ENOTSUPP
test_tailcall_hierarchy_count:FAIL:attach_trace unexpected error: -524
#413/19  tailcalls/tailcall_bpf2bpf_hierarchy_fentry:FAIL
test_tailcall_hierarchy_count:PASS:load obj 0 nsec
test_tailcall_hierarchy_count:PASS:find entry prog 0 nsec
test_tailcall_hierarchy_count:PASS:prog_fd 0 nsec
test_tailcall_hierarchy_count:PASS:find jmp_table 0 nsec
test_tailcall_hierarchy_count:PASS:map_fd 0 nsec
test_tailcall_hierarchy_count:PASS:update jmp_table 0 nsec
test_tailcall_hierarchy_count:PASS:find data_map 0 nsec
test_tailcall_hierarchy_count:PASS:open fexit_obj file 0 nsec
test_tailcall_hierarchy_count:PASS:find fexit prog 0 nsec
test_tailcall_hierarchy_count:PASS:set_attach_target subprog_tail 0 nsec
test_tailcall_hierarchy_count:PASS:load fexit_obj 0 nsec
libbpf: prog 'fexit': failed to attach: -ENOTSUPP
test_tailcall_hierarchy_count:FAIL:attach_trace unexpected error: -524
#413/20  tailcalls/tailcall_bpf2bpf_hierarchy_fexit:FAIL
test_tailcall_hierarchy_count:PASS:load obj 0 nsec
test_tailcall_hierarchy_count:PASS:find entry prog 0 nsec
test_tailcall_hierarchy_count:PASS:prog_fd 0 nsec
test_tailcall_hierarchy_count:PASS:find jmp_table 0 nsec
test_tailcall_hierarchy_count:PASS:map_fd 0 nsec
test_tailcall_hierarchy_count:PASS:update jmp_table 0 nsec
test_tailcall_hierarchy_count:PASS:find data_map 0 nsec
test_tailcall_hierarchy_count:PASS:open fentry_obj file 0 nsec
test_tailcall_hierarchy_count:PASS:find fentry prog 0 nsec
test_tailcall_hierarchy_count:PASS:set_attach_target subprog_tail 0 nsec
test_tailcall_hierarchy_count:PASS:load fentry_obj 0 nsec
libbpf: prog 'fentry': failed to attach: -ENOTSUPP
test_tailcall_hierarchy_count:FAIL:attach_trace unexpected error: -524
#413/21  tailcalls/tailcall_bpf2bpf_hierarchy_fentry_fexit:FAIL
test_tailcall_hierarchy_count:PASS:load obj 0 nsec
test_tailcall_hierarchy_count:PASS:find entry prog 0 nsec
test_tailcall_hierarchy_count:PASS:prog_fd 0 nsec
test_tailcall_hierarchy_count:PASS:open fentry_obj file 0 nsec
test_tailcall_hierarchy_count:PASS:find fentry prog 0 nsec
test_tailcall_hierarchy_count:PASS:set_attach_target entry 0 nsec
test_tailcall_hierarchy_count:PASS:load fentry_obj 0 nsec
libbpf: prog 'fentry': failed to attach: -ENOTSUPP
test_tailcall_hierarchy_count:FAIL:attach_trace unexpected error: -524
tester_init:PASS:tester_log_buf 0 nsec
process_subtest:PASS:obj_open_mem 0 nsec
process_subtest:PASS:specs_alloc 0 nsec
#413/22  tailcalls/tailcall_bpf2bpf_hierarchy_fentry_entry:FAIL
test_tailcall_freplace:PASS:tailcall_freplace__open 0 nsec
test_tailcall_freplace:PASS:tc_bpf2bpf__open_and_load 0 nsec
test_tailcall_freplace:PASS:set_attach_target 0 nsec
test_tailcall_freplace:PASS:tailcall_freplace__load 0 nsec
test_tailcall_freplace:PASS:update jmp_table failure 0 nsec
libbpf: prog 'entry_freplace': failed to attach to freplace: -ENOTSUPP
test_tailcall_freplace:FAIL:attach_freplace unexpected error: -524
#413/25  tailcalls/tailcall_freplace:FAIL
test_tailcall_bpf2bpf_freplace:PASS:tc_bpf2bpf__open_and_load 0 nsec
test_tailcall_bpf2bpf_freplace:PASS:tailcall_freplace__open 0 nsec
test_tailcall_bpf2bpf_freplace:PASS:set_attach_target 0 nsec
test_tailcall_bpf2bpf_freplace:PASS:tailcall_freplace__load 0 nsec
libbpf: prog 'entry_freplace': failed to attach to freplace: -ENOTSUPP
test_tailcall_bpf2bpf_freplace:FAIL:attach_freplace unexpected error: -524
#413/26  tailcalls/tailcall_bpf2bpf_freplace:FAIL
#413     tailcalls:FAIL
Summary: 0/21 PASSED, 0 SKIPPED, 1 FAILED

v1:
1,Fix the jmp_offset calculation error in the emit_bpf_tail_call function.
2,Fix the issue that MAX_TAIL_CALL_CNT limit bypass in hybrid tailcall and BPF-to-BPF call

After applying this patch, testing results are as follows:

./test_progs --allow=tailcalls/tailcall_bpf2bpf_hierarchy_1
413/18  tailcalls/tailcall_bpf2bpf_hierarchy_1:OK
413     tailcalls:OK
Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED

./test_progs --allow=tailcalls/tailcall_bpf2bpf_hierarchy_2
413/23  tailcalls/tailcall_bpf2bpf_hierarchy_2:OK
413     tailcalls:OK
Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED

./test_progs --allow=tailcalls/tailcall_bpf2bpf_hierarchy_3
413/24  tailcalls/tailcall_bpf2bpf_hierarchy_3:OK
413     tailcalls:OK
Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED

Haoran Jiang (2):
  LoongArch: BPF: Fix jump offset calculation in tailcall
  LoongArch: BPF: Fix tailcall hierarchy

 arch/loongarch/net/bpf_jit.c | 180 +++++++++++++++++++++++------------
 1 file changed, 118 insertions(+), 62 deletions(-)

-- 
2.43.0


