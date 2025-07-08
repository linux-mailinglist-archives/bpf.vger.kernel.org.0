Return-Path: <bpf+bounces-62644-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB53AFC3DA
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 09:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E60513A84AF
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 07:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B54029898B;
	Tue,  8 Jul 2025 07:19:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8E02951BA
	for <bpf@vger.kernel.org>; Tue,  8 Jul 2025 07:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751959150; cv=none; b=Xgk0PV8yneGGAP+s/Qxz7LUwsDcEfV6ypaDZ8w+Kt0kZ8JJV4VZRj+OhV5cN/khwlmx2AxucZMKlmSNlwwE1iwwx1mG361EWo/ZBC5Dy5Rwf2Y/7K7krQoNSazMSh668/6D7W4IHOFRgEK8gs1fPME15mTWvhlyAz+AHmm7qCYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751959150; c=relaxed/simple;
	bh=syPhFezLm1T4ChGPvnxWtcVy+icHq8Z++aIUoTsfcRs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Bdkel3z5twIyg4GoTfL9lPO+8faPGa4a7DpygkRBWMSlrrwAaQ1I8iTk//gkcffmcAgqvkDyR3/3NzdDUsup0iy/IErVWzRfzz5+RRpMVTGnsIRanql/J056PagSW1A3IITSw6jxuTEgPU0tr9aC/Bqa9dP2t0ylkUBS9n1XvOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d0dd66365bcb11f0b29709d653e92f7d-20250708
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:a9740e31-d811-4bd8-b3c8-07158bd08b50,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-INFO: VERSION:1.1.45,REQID:a9740e31-d811-4bd8-b3c8-07158bd08b50,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:9323fc299a1e913a4b5c8c7a4bf71ad4,BulkI
	D:250708151902BI3MNZAO,BulkQuantity:0,Recheck:0,SF:17|19|24|44|66|78|102,T
	C:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:
	nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,1,J
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: d0dd66365bcb11f0b29709d653e92f7d-20250708
X-User: jianghaoran@kylinos.cn
Received: from localhost.localdomain [(39.156.73.13)] by mailgw.kylinos.cn
	(envelope-from <jianghaoran@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 961650076; Tue, 08 Jul 2025 15:18:58 +0800
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
Subject: [PATCH v2 0/2] Fix two tailcall-related issues
Date: Tue,  8 Jul 2025 15:18:38 +0800
Message-Id: <20250708071840.556686-1-jianghaoran@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
----------------------------------------------------------------------

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
  LoongArch: BPF: Optimize the calculation method of jmp_offset in the
    emit_bpf_tail_call function
  LoongArch: BPF: Fix tailcall hierarchy

 arch/loongarch/net/bpf_jit.c | 133 +++++++++++++++++++----------------
 1 file changed, 74 insertions(+), 59 deletions(-)

-- 
2.43.0


