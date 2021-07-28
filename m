Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4E83D954E
	for <lists+bpf@lfdr.de>; Wed, 28 Jul 2021 20:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbhG1Saa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Jul 2021 14:30:30 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:13850 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229542AbhG1Sa3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 28 Jul 2021 14:30:29 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16SIRL2G007676
        for <bpf@vger.kernel.org>; Wed, 28 Jul 2021 11:30:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=a0eWNq2CIQKCp6IcVJET2F/fhsJDpk3GTN+W49PG/OQ=;
 b=jdyK6Ia2csp4j2fIV7G9xn7yl0X3ezgksaWymvLdY2dOP9YlxGXFg8MRF6E5qgLkBQUE
 VdfCbPnip/LEkPViy5k5gHmZzZtjhOkmnkHyRbvNZbK3E5LhyrtvMWxYXucuxiShTAk3
 3tipBhzR7cO/zMbXCoh5kGSekaxLeWlQdDQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3a38tpht45-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 28 Jul 2021 11:30:27 -0700
Received: from intmgw001.06.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 28 Jul 2021 11:30:26 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id EA17555A5DA8; Wed, 28 Jul 2021 11:30:25 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next] bpf: emit better log message if bpf_iter ctx arg btf_id == 0
Date:   Wed, 28 Jul 2021 11:30:25 -0700
Message-ID: <20210728183025.1461750-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: BQGr0W-U9qye3zCPD8Dp6A2p-cTKcUWb
X-Proofpoint-ORIG-GUID: BQGr0W-U9qye3zCPD8Dp6A2p-cTKcUWb
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-28_09:2021-07-27,2021-07-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 mlxlogscore=934 impostorscore=0 phishscore=36
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107280105
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

To avoid kernel build failure due to some missing .BTF-ids referenced
functions/types, the patch ([1]) tries to fill btf_id 0 for
these types.

In bpf verifier, for percpu variable and helper returning btf_id cases,
verifier already emitted proper warning with something like
  verbose(env, "Helper has invalid btf_id in R%d\n", regno);
  verbose(env, "invalid return type %d of func %s#%d\n",
          fn->ret_type, func_id_name(func_id), func_id);

But this is not the case for bpf_iter context arguments.
I hacked resolve_btfids to encode btf_id 0 for struct task_struct.
With `./test_progs -n 7/5`, I got,
  0: (79) r2 =3D *(u64 *)(r1 +0)
  func 'bpf_iter_task' arg0 has btf_id 29739 type STRUCT 'bpf_iter_meta'
  ; struct seq_file *seq =3D ctx->meta->seq;
  1: (79) r6 =3D *(u64 *)(r2 +0)
  ; struct task_struct *task =3D ctx->task;
  2: (79) r7 =3D *(u64 *)(r1 +8)
  ; if (task =3D=3D (void *)0) {
  3: (55) if r7 !=3D 0x0 goto pc+11
  ...
  ; BPF_SEQ_PRINTF(seq, "%8d %8d\n", task->tgid, task->pid);
  26: (61) r1 =3D *(u32 *)(r7 +1372)
  Type '(anon)' is not a struct

Basically, verifier will return btf_id 0 for task_struct.
Later on, when the code tries to access task->tgid, the
verifier correctly complains the type is '(anon)' and it is
not a struct. Users still need to backtrace to find out
what is going on.

Let us catch the invalid btf_id 0 earlier
and provide better message indicating btf_id is wrong.
The new error message looks like below:
  R1 type=3Dctx expected=3Dfp
  ; struct seq_file *seq =3D ctx->meta->seq;
  0: (79) r2 =3D *(u64 *)(r1 +0)
  func 'bpf_iter_task' arg0 has btf_id 29739 type STRUCT 'bpf_iter_meta'
  ; struct seq_file *seq =3D ctx->meta->seq;
  1: (79) r6 =3D *(u64 *)(r2 +0)
  ; struct task_struct *task =3D ctx->task;
  2: (79) r7 =3D *(u64 *)(r1 +8)
  invalid btf_id for context argument offset 8
  invalid bpf_context access off=3D8 size=3D8

[1] https://lore.kernel.org/bpf/20210727132532.2473636-1-hengqi.chen@gmail.=
com/

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 kernel/bpf/btf.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 7780131f710e..c395024610ed 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -4825,6 +4825,11 @@ bool btf_ctx_access(int off, int size, enum bpf_acce=
ss_type type,
 		const struct bpf_ctx_arg_aux *ctx_arg_info =3D &prog->aux->ctx_arg_info[=
i];
=20
 		if (ctx_arg_info->offset =3D=3D off) {
+			if (!ctx_arg_info->btf_id) {
+				bpf_log(log,"invalid btf_id for context argument offset %u\n", off);
+				return false;
+			}
+
 			info->reg_type =3D ctx_arg_info->reg_type;
 			info->btf =3D btf_vmlinux;
 			info->btf_id =3D ctx_arg_info->btf_id;
--=20
2.30.2

