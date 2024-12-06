Return-Path: <bpf+bounces-46236-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAB99E6512
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 04:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C15C18849D9
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 03:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620F3189919;
	Fri,  6 Dec 2024 03:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="isSBGffy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3AC339AB
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 03:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733456030; cv=none; b=GkxJxkGCIoeKSkhcnT4qJ/vFE2LDlNGNpPyjm82gkwH0ScaI2JiKU7AXRfKBrX8RLeJYhRzpoUpUTlm3A6BWVdR+mtWFdxKkHtkMzp9wkvbUukIC49uKh3LMWEGHUxO56cPt3TMLaNPQwqpD5Yjy/Zfa2PvcjHK9U2C3nwRwFL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733456030; c=relaxed/simple;
	bh=IU2yodWYtAfcgpxuzysUrebrM69F5TE5Kj412xIo4Fs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rNKqt/9iLl+3Jgdj/4QsfAtlaAlzchkGHIzw03n8a6o2SzY29J2yKIVw/3aBc0YTKIhK/Cro82PjeEdoHA+xUZmE494M/dr5dimKpmLerzTxtCYHZ5wfPfsNhi3Wet3xAP3UEfoLbOhBP55Cl+EIMh31k99QJKu138VYo/lA814=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=isSBGffy; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-215e194b65aso14773705ad.1
        for <bpf@vger.kernel.org>; Thu, 05 Dec 2024 19:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733456028; x=1734060828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5Ey6fuQISikoBVgREmZ15dSiYdaC4ZFVROUeIsp04Gk=;
        b=isSBGffyiSynHVFWUfXEUSTItd7w/uZVZzDWla6E/FcbpkzJCigWQvnoiNkDALekTQ
         e9NTCNnUvZtynbSF6uHw0Y62n/gxQRWG9fPVj3UXvw2fBvi8mch774OlxElBQ8LmKpuA
         j8Tri42N1f1SuhvDKwhEA+eL61fl1aNv6f2woLCsG3R0HCsIQvlcQ4yBpLaxf4RuA9VF
         /GsqGow5I8C3Bo88ZMHlm5bfbbAQ1FnIP9nBs0JXYJBUz1MlX4b3B7RixWDBhIuiS3a1
         ZZsRBhGolNYarAY0k5jRk5wFf0q6w7kM+vSNqZZOyUF1jcUX4wu1kJm3Juf3svckE6dc
         twWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733456028; x=1734060828;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Ey6fuQISikoBVgREmZ15dSiYdaC4ZFVROUeIsp04Gk=;
        b=u/QkMABwyYBPD4oa56VI6Q9uETX8LmfXEQi6S4I03l3s/D4x4htR69blvyKL9aBSGD
         bU6/AX5X82MJ+shQoZ1OPsIPKEkoLT+epOqMsD5kVXRRb1zQaFT7z6HL9tznbddH4qtu
         o3HSZ4hVQa6Ke8jZp/6NUJyDC6V6Jrmv/tx997ra3IRGlejUTcOA8t6joNPhoNkg+zPW
         yrgI6CD+h/T3h9F79+uaDIrPiOtdFZUL+sBm5J046/+c1/ekPRS/tn0TdsfJ/Uxo3GwY
         6wo7CKKEzRb52SiEiU+0BCAJlUkWd+yxf/ZPBKpBR7MB+Dzs22T1Fr48QjhN0qvjyD0u
         zpNw==
X-Gm-Message-State: AOJu0YzhdYCa6Lhy/7GcAJuOWII/AU45dZLfUgqt3akbWj1UZxRbfXlX
	TNXkPrYQBSRcCKAsNbbT/RkQ3BTYVeqJrfhx5i/OHChJ6kgCEeYjXcKWwQ==
X-Gm-Gg: ASbGncvbVc7jtQ++zxj5HBANBiKjQEXUJpKkVNSCfJHUvDKVaezX2V+RbYGEdLQSUVv
	uWMl0G5oJnwZQ02m6FZF8b4TlKFfTj+v/teqC96cx2QdL3t3Dw248Oj5fvmrJEOckM12GMsJqel
	ktijK7UyZxMPtJwd3Pw/pSWqaUSbBEBz2j19hZIPHmRxT28Il6QUH3w7oaIMgl8x5vy/z0UVFWJ
	wNc+tXNiK4gRc+QUCGT9maepIOr7uSNGSCC8S68CtPhsY8dP7iDkt+BqcaMUGbySnPuey6N0pmS
	tA==
X-Google-Smtp-Source: AGHT+IGApWlKHlbsbfrYOdb0ulC7WWQTQGLr/4DhH3fMO6ptpW2Yj2GH9oQGDcEqY7/rCBg7Kwl1yA==
X-Received: by 2002:a17:902:ce91:b0:20b:70b4:69d8 with SMTP id d9443c01a7336-21614df10fcmr19318435ad.37.1733456027794;
        Thu, 05 Dec 2024 19:33:47 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:83b0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8e5f031sm19664595ad.82.2024.12.05.19.33.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 Dec 2024 19:33:47 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	kernel-team@fb.com
Subject: [PATCH RFC bpf-next] bpf: Fork state at bpf_map_lookup_elem
Date: Thu,  5 Dec 2024 19:33:42 -0800
Message-Id: <20241206033342.82058-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Here is a work-in-progress diff that passes tests (except error message mismatch).

Instead of returning map_value_or_null from bpf_map_lookup_elem()
the patch forks the state and returns map_value in the fallthrough
and const zero on the second pass.

Below are the verifier performance results.
The bigger the negative % the better.
In some cases the wins are big.

The only substantial loss is 'tw_twfw_*'.
In that tests the bounded loop logic kicks in, so extra fork of states
inside the loop makes the verifier do more work.
Similar situation is with checkpoint_states_deletion() test in progs/iters.c.
Hence the patch uses old map_value_or_null approach
when get_loop_entry(env->cur_state) == true.
It addresses the problem with checkpoint_states_deletion(),
but not with tw_twfw_*.

I'm not convinced we need to land this patch, but
wins in balancer_ingress test are appealing.

// progs from selftests
./veristat -C -e prog,insns,verdict -f 'insns_pct>5' before after
Program                             Insns (A)  Insns (B)  Insns       (DIFF)  Verdict (A)  Verdict (B)  Verdict (DIFF)
----------------------------------  ---------  ---------  ------------------  -----------  -----------  --------------
iter_err_too_permissive2                   39         61       +22 (+56.41%)  failure      failure      MATCH
iter_err_too_permissive3                   31         54       +23 (+74.19%)  failure      failure      MATCH
iter_tricky_but_fine                       56         50        -6 (-10.71%)  success      success      MATCH
raw_tracepoint__sched_process_exit       3138       3315       +177 (+5.64%)  success      success      MATCH
kprobe__vfs_link                        10272      11000       +728 (+7.09%)  success      success      MATCH
kprobe__vfs_symlink                      5781       6311       +530 (+9.17%)  success      success      MATCH
kprobe_ret__do_filp_open                 5891       6421       +530 (+9.00%)  success      success      MATCH
on_event                               116096     877289  +761193 (+655.66%)  failure      success      MISMATCH
   // mainly due to BPF_COMPLEXITY_LIMIT_JMP_SEQ increase
on_event                                 4595       6332     +1737 (+37.80%)  success      success      MATCH
on_event                                 7187       6801       -386 (-5.37%)  success      success      MATCH
balancer_ingress                         4489       3257     -1232 (-27.44%)  success      success      MATCH
balancer_ingress                         4865       3168     -1697 (-34.88%)  success      success      MATCH
balancer_ingress                         1508       1060      -448 (-29.71%)  success      success      MATCH
balancer_ingress_v4                      3666       2819      -847 (-23.10%)  success      success      MATCH
balancer_ingress_v6                      3453       2523      -930 (-26.93%)  success      success      MATCH
syncookie_tc                             5549       5884       +335 (+6.04%)  success      success      MATCH

// production progs
./veristat -C -e prog,insns -f 'insns_pct>5' before after
Program                                   Insns (A)  Insns (B)  Insns      (DIFF)
----------------------------------------  ---------  ---------  -----------------
on_switch                                      3789       5585    +1796 (+47.40%)
balancer_ingress                               8389       6820    -1569 (-18.70%)
balancer_ingress                              12477      10735    -1742 (-13.96%)
balancer_ingress                              12989      11658    -1331 (-10.25%)
balancer_ingress                              12989      11658    -1331 (-10.25%)
balancer_ingress                              12477      10735    -1742 (-13.96%)
balancer_ingress                              16400      15415      -985 (-6.01%)
balancer_ingress                              17893      16775     -1118 (-6.25%)
balancer_ingress                              17311      16305     -1006 (-5.81%)
balancer_ingress                              18042      17137      -905 (-5.02%)
balancer_ingress                               9253       7728    -1525 (-16.48%)
balancer_ingress                               9865       8143    -1722 (-17.46%)
balancer_ingress                               8870       7182    -1688 (-19.03%)
balancer_ingress                             321972     164530  -157442 (-48.90%)
balancer_ingress                             322701     165237  -157464 (-48.80%)
balancer_ingress                             344833     176948  -167885 (-48.69%)
balancer_ingress                             344833     176948  -167885 (-48.69%)
balancer_ingress                             322701     165237  -157464 (-48.80%)
balancer_ingress                             343872     176031  -167841 (-48.81%)
balancer_ingress                             343665     175732  -167933 (-48.87%)
prog_block_rq_complete_raw                      803        884      +81 (+10.09%)
sm_tc_writer                                    200        214       +14 (+7.00%)
tc_scope_lookup                                 214        240      +26 (+12.15%)
ned_hwtstamp                                    133        162      +29 (+21.80%)
ned_skop_timestamp                              528        574       +46 (+8.71%)
ned_skop_pacing                                 113        124       +11 (+9.73%)
ned_scope_resolver                              262        307      +45 (+17.18%)
ned_skop_selcca                                 223        282      +59 (+26.46%)
ned_tcpopt_sr                                   660        721       +61 (+9.24%)
ned_skop_timeout                                218        244      +26 (+11.93%)
nat64                                          1337       1463      +126 (+9.42%)
dctcp_update_alpha                              113        123       +10 (+8.85%)
dctcp_update_alpha                              113        123       +10 (+8.85%)
ned_ts_func                                     592        655      +63 (+10.64%)
filtering                                       362        459      +97 (+26.80%)
mitigate_rwnd                                   314        441     +127 (+40.45%)
privacy_setoskopt                               100        106        +6 (+6.00%)
sslwall_sockops                                 511        451      -60 (-11.74%)
on_event                                        260        275       +15 (+5.77%)
on_event                                        260        275       +15 (+5.77%)
read_async_py_stack                           24723      22404     -2319 (-9.38%)
on_event                                        260        275       +15 (+5.77%)
read_async_py_stack                           24723      22404     -2319 (-9.38%)
read_async_py_stack                           24723      22404     -2319 (-9.38%)
read_async_py_stack                           24723      22404     -2319 (-9.38%)
bash_reader                                   19475      21980    +2505 (+12.86%)
syar_cgroup_mkdir                             10276      11532    +1256 (+12.22%)
accept_protect                                 9776      11037    +1261 (+12.90%)
syar_pci_enable_device                          156        164        +8 (+5.13%)
python3_detect                                11545      12447      +902 (+7.81%)
bpf_prog_detect                                 217        241      +24 (+11.06%)
syar_task_kill                                10223      11522    +1299 (+12.71%)
syar_task_enter_process_vm_writev             19531      20775     +1244 (+6.37%)
milli_sampler                                   497        554      +57 (+11.47%)
cubictcp_cong_avoid                           57380      61292     +3912 (+6.82%)
tcp_reno_cong_avoid                           57380      61292     +3912 (+6.82%)
tracepoint__tcp__tcp_destroy_sock                43         46        +3 (+6.98%)
tracepoint__tcp__tcp_receive_reset              156        199      +43 (+27.56%)
tracepoint__tcp__tcp_retransmit_skb            3471       2781     -690 (-19.88%)
tracepoint__tcp__tcp_retransmit_synack         3164       2293     -871 (-27.53%)
bbr_set_state                                 12594       5207    -7387 (-58.65%)
cubictcp_state                                12594       5207    -7387 (-58.65%)
kprobe__bbr_set_state                          8207       3940    -4267 (-51.99%)
kprobe__bictcp_state                           8207       3940    -4267 (-51.99%)
tcp_receive_reset                               206        227      +21 (+10.19%)
tcp_retransmit_skb                             7709       5557    -2152 (-27.92%)
tcp_retransmit_synack                          4706       3295    -1411 (-29.98%)
tw_netbw_cg_eg                                  196        215       +19 (+9.69%)
tw_egress                                      1190       1447     +257 (+21.60%)
tw_ingress                                     1180       1437     +257 (+21.78%)
ned_cgrp_dctcp                                  285        328      +43 (+15.09%)
tw_ipt_connect                                  165        177       +12 (+7.27%)
tw_ipt_ingress                                  101        112      +11 (+10.89%)
tw_ipt_listen                                   157        173      +16 (+10.19%)
tw_ns_phy2veth                                 2516       2288      -228 (-9.06%)
tw_tproxy_router                               1852       2110     +258 (+13.93%)
ttls_tc_egress                                  519        572      +53 (+10.21%)
ttls_tc_ingress                                7651       8137      +486 (+6.35%)
ttls_nat_ingress                                356        383       +27 (+7.58%)
tw_twfw_egress                               205149     239977   +34828 (+16.98%)
tw_twfw_ingress                              205153     239987   +34834 (+16.98%)
tw_twfw_tc_eg                                205147     239983   +34836 (+16.98%)
tw_twfw_tc_in                                205151     239987   +34836 (+16.98%)
tw_twfw_egress                                 5964       5530      -434 (-7.28%)
tw_twfw_ingress                                6110       5558      -552 (-9.03%)
tw_twfw_tc_eg                                  6109       5424     -685 (-11.21%)
tw_twfw_tc_in                                  6108       5558      -550 (-9.00%)
twfw_connect4                                 32715      17994   -14721 (-45.00%)
twfw_sendmsg4                                 32715      17994   -14721 (-45.00%)

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 31e0d33498ac..73b5cc767d25 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -186,7 +186,7 @@ struct bpf_verifier_stack_elem {
 	u32 log_pos;
 };
 
-#define BPF_COMPLEXITY_LIMIT_JMP_SEQ	8192
+#define BPF_COMPLEXITY_LIMIT_JMP_SEQ	(8192 * 4)
 #define BPF_COMPLEXITY_LIMIT_STATES	64
 
 #define BPF_MAP_KEY_POISON	(1ULL << 63)
@@ -11206,6 +11206,16 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		regs[BPF_REG_0].map_ptr = meta.map_ptr;
 		regs[BPF_REG_0].map_uid = meta.map_uid;
 		regs[BPF_REG_0].type = PTR_TO_MAP_VALUE | ret_flag;
+		if (ret_flag == PTR_MAYBE_NULL && !get_loop_entry(env->cur_state)) {
+			struct bpf_verifier_state *st;
+			struct bpf_reg_state *other_regs;
+
+			st = push_stack(env, insn_idx + 1, insn_idx, false);
+			other_regs = st->frame[st->curframe]->regs;
+			__mark_reg_const_zero(env, &other_regs[BPF_REG_0]);
+
+			mark_ptr_not_null_reg(&regs[BPF_REG_0]);
+		}
 		if (!type_may_be_null(ret_type) &&
 		    btf_record_has_field(meta.map_ptr->record, BPF_SPIN_LOCK)) {
 			regs[BPF_REG_0].id = ++env->id_gen;
-- 
2.43.5


