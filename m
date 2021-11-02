Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3E8C44273E
	for <lists+bpf@lfdr.de>; Tue,  2 Nov 2021 07:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhKBGsV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Nov 2021 02:48:21 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:34228 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229612AbhKBGsU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 2 Nov 2021 02:48:20 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A22Uamb021496
        for <bpf@vger.kernel.org>; Mon, 1 Nov 2021 23:45:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=jiZSuAjxw8wAEoAAAg3m9VOQn3KaOfWY4DmV2Qm+zYw=;
 b=ST7/0YRBM0z56WNe+xBE3mb0lSriMUgpDbsIRUDM+21aXJYFxktkBXy+yRCEtHghHZJ1
 6q0tySQq11qjtokLVJPfaCPMic8aQ6deA2LSG3KAJneZticybjovSBL/K94MKawdVseY
 5nIy9X7eg14emfe4aLkzarP1IXF0nVqJyig= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3c2jjkn31n-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 01 Nov 2021 23:45:46 -0700
Received: from intmgw001.06.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 1 Nov 2021 23:45:45 -0700
Received: by devbig005.ftw2.facebook.com (Postfix, from userid 6611)
        id 6EC871C668A3; Mon,  1 Nov 2021 23:45:35 -0700 (PDT)
From:   Martin KaFai Lau <kafai@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Yonghong Song <yhs@fb.com>,
        Hengqi Chen <hengqi.chen@gmail.com>,
        Yonghong Song <yhs@gmail.com>
Subject: [PATCH bpf-next 1/2] bpf: Do not reject when the stack read size is different from the tracked scalar size
Date:   Mon, 1 Nov 2021 23:45:35 -0700
Message-ID: <20211102064535.316018-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211102064528.315637-1-kafai@fb.com>
References: <20211102064528.315637-1-kafai@fb.com>
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: UIm3Zw9P1N9nOgiMEdEVwdXCI7ABAvje
X-Proofpoint-ORIG-GUID: UIm3Zw9P1N9nOgiMEdEVwdXCI7ABAvje
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-02_05,2021-11-01_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxlogscore=751 impostorscore=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111020038
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Below is a simplified case from a report in bcc [0]:
r4 =3D 20
*(u32 *)(r10 -4) =3D r4
*(u32 *)(r10 -8) =3D r4  /* r4 state is tracked */
r4 =3D *(u64 *)(r10 -8)  /* Read more than the tracked 32bit scalar.
			* verifier rejects as 'corrupted spill memory'.
			*/

After commit 354e8f1970f8 ("bpf: Support <8-byte scalar spill and refill"),
the 8-byte aligned 32bit spill is also tracked by the verifier
and the reg state is stored.

However, if 8 bytes are read from the stack instead of the tracked
4 byte scalar, the verifier currently rejects as "corrupted spill memory".

This patch fixes this case by allowing it to read but marks the reg as
unknown.

Also note that, if the prog is trying to corrupt/leak an
earlier spilled pointer by spilling another <8 bytes register on top,
this has already been rejected in the check_stack_write_fixed_off().

[0]: https://github.com/iovisor/bcc/pull/3683

Fixes: 354e8f1970f8 ("bpf: Support <8-byte scalar spill and refill")
Reported-by: Hengqi Chen <hengqi.chen@gmail.com>
Reported-by: Yonghong Song <yhs@gmail.com>
Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 kernel/bpf/verifier.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3c8aa7df1773..d8012775831d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3088,9 +3088,12 @@ static int check_stack_read_fixed_off(struct bpf_ver=
ifier_env *env,
 	reg =3D &reg_state->stack[spi].spilled_ptr;
=20
 	if (is_spilled_reg(&reg_state->stack[spi])) {
-		if (size !=3D BPF_REG_SIZE) {
-			u8 scalar_size =3D 0;
+		u8 spill_size =3D 1;
+
+		for (i =3D BPF_REG_SIZE - 1; i > 0 && stype[i - 1] =3D=3D STACK_SPILL; i=
--)
+			spill_size++;
=20
+		if (size !=3D BPF_REG_SIZE || spill_size !=3D BPF_REG_SIZE) {
 			if (reg->type !=3D SCALAR_VALUE) {
 				verbose_linfo(env, env->insn_idx, "; ");
 				verbose(env, "invalid size of register fill\n");
@@ -3101,10 +3104,7 @@ static int check_stack_read_fixed_off(struct bpf_ver=
ifier_env *env,
 			if (dst_regno < 0)
 				return 0;
=20
-			for (i =3D BPF_REG_SIZE; i > 0 && stype[i - 1] =3D=3D STACK_SPILL; i--)
-				scalar_size++;
-
-			if (!(off % BPF_REG_SIZE) && size =3D=3D scalar_size) {
+			if (!(off % BPF_REG_SIZE) && size =3D=3D spill_size) {
 				/* The earlier check_reg_arg() has decided the
 				 * subreg_def for this insn.  Save it first.
 				 */
@@ -3128,12 +3128,6 @@ static int check_stack_read_fixed_off(struct bpf_ver=
ifier_env *env,
 			state->regs[dst_regno].live |=3D REG_LIVE_WRITTEN;
 			return 0;
 		}
-		for (i =3D 1; i < BPF_REG_SIZE; i++) {
-			if (stype[(slot - i) % BPF_REG_SIZE] !=3D STACK_SPILL) {
-				verbose(env, "corrupted spill memory\n");
-				return -EACCES;
-			}
-		}
=20
 		if (dst_regno >=3D 0) {
 			/* restore register state from stack */
--=20
2.30.2

