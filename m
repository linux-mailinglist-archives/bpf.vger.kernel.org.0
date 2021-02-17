Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDF031DEF8
	for <lists+bpf@lfdr.de>; Wed, 17 Feb 2021 19:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234779AbhBQSTL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Feb 2021 13:19:11 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:19076 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234246AbhBQSTK (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 17 Feb 2021 13:19:10 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 11HIA4MH014867
        for <bpf@vger.kernel.org>; Wed, 17 Feb 2021 10:18:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=12ZzA+1KiDfe+NubQD/DITm8o+yhSi70KJWqurmWPzc=;
 b=fvOx/+JClDmxCgA5f9TXVp/Qw/ofhJORB0yv6sj6Fzpjx6peS8pVNG7e5MTMt30BKWRF
 sZ0gP6rBYWfF7Pwza0+Qhq+TBC+dY44CISWnz6tQKP0KKbFYq5RuxBZUEjErsNMrSvQQ
 vGlxeUn1zf69AcjCT9d0g6rl6EqhWLcpaFY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 36quthwxsw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 17 Feb 2021 10:18:28 -0800
Received: from intmgw002.06.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 17 Feb 2021 10:18:21 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id C40ED3704F7A; Wed, 17 Feb 2021 10:18:13 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v2 09/11] bpftool: print local function pointer properly
Date:   Wed, 17 Feb 2021 10:18:13 -0800
Message-ID: <20210217181813.3191699-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210217181803.3189437-1-yhs@fb.com>
References: <20210217181803.3189437-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-17_13:2021-02-16,2021-02-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 impostorscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=597 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102170133
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

With later hashmap example, using bpftool xlated output may
look like:
  int dump_task(struct bpf_iter__task * ctx):
  ; struct task_struct *task =3D ctx->task;
     0: (79) r2 =3D *(u64 *)(r1 +8)
  ; if (task =3D=3D (void *)0 || called > 0)
  ...
    19: (18) r2 =3D subprog[+18]
    30: (18) r2 =3D subprog[+26]
  ...
  36: (95) exit
  __u64 check_hash_elem(struct bpf_map * map, __u32 * key, __u64 * val,
                        struct callback_ctx * data):
  ; struct bpf_iter__task *ctx =3D data->ctx;
    37: (79) r5 =3D *(u64 *)(r4 +0)
  ...
    55: (95) exit
  __u64 check_percpu_elem(struct bpf_map * map, __u32 * key,
                          __u64 * val, void * unused):
  ; check_percpu_elem(struct bpf_map *map, __u32 *key, __u64 *val, void *=
unused)
    56: (bf) r6 =3D r3
  ...
    83: (18) r2 =3D subprog[-46]

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/bpf/bpftool/xlated_dumper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/bpf/bpftool/xlated_dumper.c b/tools/bpf/bpftool/xlated=
_dumper.c
index 8608cd68cdd0..b87caae2e7da 100644
--- a/tools/bpf/bpftool/xlated_dumper.c
+++ b/tools/bpf/bpftool/xlated_dumper.c
@@ -196,6 +196,9 @@ static const char *print_imm(void *private_data,
 	else if (insn->src_reg =3D=3D BPF_PSEUDO_MAP_VALUE)
 		snprintf(dd->scratch_buff, sizeof(dd->scratch_buff),
 			 "map[id:%u][0]+%u", insn->imm, (insn + 1)->imm);
+	else if (insn->src_reg =3D=3D BPF_PSEUDO_FUNC)
+		snprintf(dd->scratch_buff, sizeof(dd->scratch_buff),
+			 "subprog[%+d]", insn->imm + 1);
 	else
 		snprintf(dd->scratch_buff, sizeof(dd->scratch_buff),
 			 "0x%llx", (unsigned long long)full_imm);
--=20
2.24.1

