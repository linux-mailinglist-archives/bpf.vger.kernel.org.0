Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B57831FD6E9
	for <lists+bpf@lfdr.de>; Wed, 17 Jun 2020 23:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbgFQVQI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Jun 2020 17:16:08 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:27980 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727021AbgFQVQH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 17 Jun 2020 17:16:07 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05HLFwlB009938
        for <bpf@vger.kernel.org>; Wed, 17 Jun 2020 14:16:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=sEokPxbrh8VkvHLu4inshXJCmTuknOiFnqnWFTcFPN8=;
 b=cvq9exfBmZlPnsl3fRTbv8oXeaF9j4JEyh/4lQ6MZ4AgypTvxrNE3Ugg027O3J91VB4J
 RSpMj+OdAvI2zokdpefenrsxIkFmnITILzi4Yeka1XetCyozoW2FLR+SOWFtxxesIpUE
 AKDVnFcPR4mNGTdufIKmiLqgvl+tbVShXOk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 31q8u6fkyg-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 17 Jun 2020 14:16:07 -0700
Received: from intmgw001.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 17 Jun 2020 14:15:42 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id B43113704EF2; Wed, 17 Jun 2020 14:15:39 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <kafai@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 03/13] bpf: support 'X' in bpf_seq_printf() helper
Date:   Wed, 17 Jun 2020 14:15:39 -0700
Message-ID: <20200617211539.1855882-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200617211536.1854348-1-yhs@fb.com>
References: <20200617211536.1854348-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-17_12:2020-06-17,2020-06-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 cotscore=-2147483648 malwarescore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=819 mlxscore=0 suspectscore=13 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006170159
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

'X' tells kernel to print hex with upper case letters.
/proc/net/tcp{4,6} seq_file show() used this, and
supports it in bpf_seq_printf() helper too.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 kernel/trace/bpf_trace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index e729c9e587a0..dbee30e2ad91 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -681,7 +681,8 @@ BPF_CALL_5(bpf_seq_printf, struct seq_file *, m, char=
 *, fmt, u32, fmt_size,
 		}
=20
 		if (fmt[i] !=3D 'i' && fmt[i] !=3D 'd' &&
-		    fmt[i] !=3D 'u' && fmt[i] !=3D 'x') {
+		    fmt[i] !=3D 'u' && fmt[i] !=3D 'x' &&
+		    fmt[i] !=3D 'X') {
 			err =3D -EINVAL;
 			goto out;
 		}
--=20
2.24.1

