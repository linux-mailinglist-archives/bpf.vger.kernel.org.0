Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6584F1E71C8
	for <lists+bpf@lfdr.de>; Fri, 29 May 2020 02:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438131AbgE2AsS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 May 2020 20:48:18 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:6552 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2438114AbgE2AsR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 28 May 2020 20:48:17 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 04T0iQkq018064
        for <bpf@vger.kernel.org>; Thu, 28 May 2020 17:48:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=XKaNCUf4aWfVxow/sVN7utvio0I/teUXWg+FJPTB7ys=;
 b=Mh1rhlb4PIve3IbnuPTXHwOn/Ox0oWd2IWDTu+DoYk6x7hyeSvURkoGHRePqn+F+JStc
 zOSio62x/co/4AXyRQhrxnUUro1tWXCPSmlWmSOXBP+fFspRdCEhOzs3SKFVukPGAPKz
 ITTe2XcZzX3rM9tSGf+4asHsS3g6jTdwVNE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 31a24ubyfx-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 28 May 2020 17:48:15 -0700
Received: from intmgw004.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 28 May 2020 17:48:14 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id C61D23704D0A; Thu, 28 May 2020 17:48:10 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Christoph Hellwig <hch@lst.de>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next] bpf: use strncpy_from_unsafe_strict() in bpf_seq_printf() helper
Date:   Thu, 28 May 2020 17:48:10 -0700
Message-ID: <20200529004810.3352219-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-28_08:2020-05-28,2020-05-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 bulkscore=0 phishscore=0 spamscore=0 clxscore=1015 suspectscore=1
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 cotscore=-2147483648
 adultscore=0 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005290003
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In bpf_seq_printf() helper, when user specified a "%s" in the
format string, strncpy_from_unsafe() is used to read the actual string
to a buffer. The string could be a format string or a string in
the kernel data structure. It is really unlikely that the string
will reside in the user memory.

This is different from Commit b2a5212fb634 ("bpf: Restrict bpf_trace_prin=
tk()'s %s
usage and add %pks, %pus specifier") which still used
strncpy_from_unsafe() for "%s" to preserve the old behavior.

If in the future, bpf_seq_printf() indeed needs to read user
memory, we can implement "%pus" format string.

Based on discussion in [1], if the intent is to read kernel memory,
strncpy_from_unsafe_strict() should be used. So this patch
changed to use strncpy_from_unsafe_strict().

[1]: https://lore.kernel.org/bpf/20200521152301.2587579-1-hch@lst.de/T/

Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 kernel/trace/bpf_trace.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 187cd6995bbb..3a4afbc7f0bc 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -585,9 +585,9 @@ BPF_CALL_5(bpf_seq_printf, struct seq_file *, m, char=
 *, fmt, u32, fmt_size,
 				goto out;
 			}
=20
-			err =3D strncpy_from_unsafe(bufs->buf[memcpy_cnt],
-						  (void *) (long) args[fmt_cnt],
-						  MAX_SEQ_PRINTF_STR_LEN);
+			err =3D strncpy_from_unsafe_strict(bufs->buf[memcpy_cnt],
+							 (void *) (long) args[fmt_cnt],
+							 MAX_SEQ_PRINTF_STR_LEN);
 			if (err < 0)
 				bufs->buf[memcpy_cnt][0] =3D '\0';
 			params[fmt_cnt] =3D (u64)(long)bufs->buf[memcpy_cnt];
--=20
2.24.1

