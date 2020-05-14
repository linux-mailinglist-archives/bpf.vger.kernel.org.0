Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27E4F1D26AA
	for <lists+bpf@lfdr.de>; Thu, 14 May 2020 07:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725806AbgENFcO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 May 2020 01:32:14 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:20950 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725788AbgENFcO (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 14 May 2020 01:32:14 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04E5UtBt012375
        for <bpf@vger.kernel.org>; Wed, 13 May 2020 22:32:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=K/Nc+atuo6mzFtmzPUMQemH8xif4oEJf2QKTpVnKE5g=;
 b=WLbuqcrDq/OLNoqO4uDoteGqjWQrt4deN4t7OLZiZJMgnqeRPBz2vdLZ32/DBSjhkGGG
 aYy94aHdH1979Jvl5XpHd9bFx/gW2lZYfhRjnsuJNCB9w3YeYTg34hAEiGVlIilbmdBv
 Lg0LOY2sLVWyrp43Gh39B9KrkfcC+IJ9pvM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3100y1scy1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 13 May 2020 22:32:13 -0700
Received: from intmgw003.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Wed, 13 May 2020 22:32:12 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 03BFD37028F2; Wed, 13 May 2020 22:32:06 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf v2 1/2] bpf: enforce returning 0 for fentry/fexit progs
Date:   Wed, 13 May 2020 22:32:05 -0700
Message-ID: <20200514053206.1298415-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200514053205.1298315-1-yhs@fb.com>
References: <20200514053205.1298315-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-13_09:2020-05-13,2020-05-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 suspectscore=13 phishscore=0 cotscore=-2147483648 mlxscore=0 spamscore=0
 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=747 clxscore=1015
 impostorscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005140049
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, tracing/fentry and tracing/fexit prog
return values are not enforced. In trampoline codes,
the fentry/fexit prog return values are ignored.
Let us enforce it to be 0 to avoid confusion and
allows potential future extension.

This patch also explicitly added return value
checking for tracing/raw_tp, tracing/fmod_ret,
and freplace programs such that these program
return values can be anything. The purpose are
two folds:
 1. to make it explicit about return value expectations
    for these programs in verifier.
 2. for tracing prog_type, if a future attach type
    is added, the default is -ENOTSUPP which will
    enforce to specify return value ranges explicitly.

Fixes: fec56f5890d9 ("bpf: Introduce BPF trampoline")
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 kernel/bpf/verifier.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

 bpf-next Commit 15d83c4d7cef ("bpf: Allow loading of a bpf
 iter program") contains the following change:

  --- a/kernel/bpf/verifier.c
  +++ b/kernel/bpf/verifier.c
  @@ -7101,6 +7101,10 @@ static int check_return_code(struct bpf_verifier=
_env *env)
                        return 0;
                range =3D tnum_const(0);
                break;
  +       case BPF_PROG_TYPE_TRACING:
  +               if (env->prog->expected_attach_type !=3D BPF_TRACE_ITER=
)
  +                       return 0;
  +               break;
        default:
                return 0;
        }

  If this patch is accepted, it will have a merge conflict when syncing t=
he change
  back to net-next/bpf-next, To resolve it, we can change to something li=
ke below:
                case BPF_TRACE_RAW_TP:
                case BPF_MODIFY_RETURN:
                        return 0;
		case BPF_TRACE_ITER:
			break;
                default:
                        return -ENOTSUPP;

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fa1d8245b925..2d80cce0a28a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7059,6 +7059,24 @@ static int check_return_code(struct bpf_verifier_e=
nv *env)
 			return 0;
 		range =3D tnum_const(0);
 		break;
+	case BPF_PROG_TYPE_TRACING:
+		switch ((env->prog->expected_attach_type)) {
+		case BPF_TRACE_FENTRY:
+		case BPF_TRACE_FEXIT:
+			range =3D tnum_const(0);
+			break;
+		case BPF_TRACE_RAW_TP:
+		case BPF_MODIFY_RETURN:
+			return 0;
+		default:
+			return -ENOTSUPP;
+		}
+
+		break;
+	case BPF_PROG_TYPE_EXT:
+		/* freplace program can return anything as its return value
+		 * depends on the to-be-replaced kernel func or bpf program.
+		 */
 	default:
 		return 0;
 	}
--=20
2.24.1

