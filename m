Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E004E4231F7
	for <lists+bpf@lfdr.de>; Tue,  5 Oct 2021 22:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236403AbhJEU3H (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 5 Oct 2021 16:29:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56638 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229805AbhJEU3H (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 5 Oct 2021 16:29:07 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 195JaMaV008528;
        Tue, 5 Oct 2021 16:26:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=cEBd0rRKrwX5Xm+40An6D0lsc77GM2bw/ksyLqF5hcg=;
 b=LL1mtsvSBJywWnFwZ0aRQuQKiJxxMANn0mrg/Sr5O2lID7lXSRtS5IlNICx1CihdCa67
 QOLg7J+FwzUFVG77FnbZuzhXOLkHySeVFeLx7t82Belg1acNCNeEMt9Zkzr1xMDv4ACz
 gB30CEgvIci82fEMU85JjiCPA8MfbVSkgmtT6/eLo8mYOv99BpI/KvKdvpyKpCNRq2WR
 IleHC4HDdvaIc36+28A6Gvrc5GK+8+VI7M/CGBa3y7XMohJoSifxMIqNjCdBOCDcSTP9
 k0KbbPaGqRZkpYiTN3ld2eQAelQVkYe9fZpbOqmUk6MyRoZu1N12CEcbSaCNkyGAdkxa lQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bgvgpstwr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Oct 2021 16:26:35 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 195KK3JV003499;
        Tue, 5 Oct 2021 16:26:34 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bgvgpstwa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Oct 2021 16:26:34 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 195KIfEt024942;
        Tue, 5 Oct 2021 20:26:33 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04fra.de.ibm.com with ESMTP id 3bef2a3rdq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Oct 2021 20:26:32 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 195KLCeQ61538762
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Oct 2021 20:21:12 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 28395AE045;
        Tue,  5 Oct 2021 20:26:30 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B755DAE051;
        Tue,  5 Oct 2021 20:26:26 +0000 (GMT)
Received: from naverao1-tp.ibm.com (unknown [9.43.5.112])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  5 Oct 2021 20:26:26 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Jordan Niethe <jniethe5@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>,
        Song Liu <songliubraving@fb.com>
Cc:     <bpf@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v2 09/10] powerpc/bpf ppc32: Do not emit zero extend instruction for 64-bit BPF_END
Date:   Wed,  6 Oct 2021 01:55:28 +0530
Message-Id: <b4e3c3546121315a8e2059b19a1bda84971816e4.1633464148.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1633464148.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1633464148.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RTxDfzNweyCkI_1roq1iaGgzDowTOHIr
X-Proofpoint-GUID: BqlRp2GTMF-cKFiZj8cF9A0NHbk8chjH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-05_04,2021-10-04_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 adultscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110050117
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Suppress emitting zero extend instruction for 64-bit BPF_END_FROM_[L|B]E
operation.

Fixes: 51c66ad849a703 ("powerpc/bpf: Implement extended BPF on PPC32")
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/net/bpf_jit_comp32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit_comp32.c
index 7c65de9ed4fa64..68dc8a8231de04 100644
--- a/arch/powerpc/net/bpf_jit_comp32.c
+++ b/arch/powerpc/net/bpf_jit_comp32.c
@@ -1107,7 +1107,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 			return -EOPNOTSUPP;
 		}
 		if (BPF_CLASS(code) == BPF_ALU && !fp->aux->verifier_zext &&
-		    !insn_is_zext(&insn[i + 1]))
+		    !insn_is_zext(&insn[i + 1]) && !(BPF_OP(code) == BPF_END && imm == 64))
 			EMIT(PPC_RAW_LI(dst_reg_h, 0));
 	}
 
-- 
2.33.0

