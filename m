Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4A12AFD23
	for <lists+bpf@lfdr.de>; Thu, 12 Nov 2020 02:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbgKLBcJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Nov 2020 20:32:09 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:10828 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728045AbgKLATZ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 11 Nov 2020 19:19:25 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0AC0HeeH012124
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2020 16:19:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=Qs9jNaqAwvSALFjazs9WYcTGypE8uqVViyOuYjRO6go=;
 b=i0GBKvzwgrbp9XzpHHUL/BDNqmS6+ziIiHMARSDyzCcP40sbTK1E48D9L3m2M26nGtW+
 KxNUSJDaHklRI+KmTHWZqOmHYl2lNvZwi0Mp6PRUpCFZKyJtPc3CaLLShtRxB99ENCKP
 fWLsgkP5JK/oae+wAKs/n+Ul5t7jPx00pA8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 34r580f033-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2020 16:19:23 -0800
Received: from intmgw002.08.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 11 Nov 2020 16:19:21 -0800
Received: by devbig005.ftw2.facebook.com (Postfix, from userid 6611)
        id C666A2946698; Wed, 11 Nov 2020 16:19:19 -0800 (PST)
From:   Martin KaFai Lau <kafai@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>, KP Singh <kpsingh@chromium.org>
Subject: [PATCH bpf-next] bpf: Fix NULL dereference in bpf_task_storage
Date:   Wed, 11 Nov 2020 16:19:19 -0800
Message-ID: <20201112001919.2028357-1-kafai@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-11_12:2020-11-10,2020-11-11 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=13
 spamscore=0 mlxlogscore=761 malwarescore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 mlxscore=0
 impostorscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011120000
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In bpf_pid_task_storage_update_elem(), it missed to
test the !task_storage_ptr(task) which then could trigger a NULL
pointer exception in bpf_local_storage_update().

Fixes: 4cf1bc1f1045 ("bpf: Implement task local storage")
Tested-by: Roman Gushchin <guro@fb.com>
Cc: KP Singh <kpsingh@chromium.org>
Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 kernel/bpf/bpf_task_storage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.=
c
index 39a45fba4fb0..4ef1959a78f2 100644
--- a/kernel/bpf/bpf_task_storage.c
+++ b/kernel/bpf/bpf_task_storage.c
@@ -150,7 +150,7 @@ static int bpf_pid_task_storage_update_elem(struct bp=
f_map *map, void *key,
 	 */
 	WARN_ON_ONCE(!rcu_read_lock_held());
 	task =3D pid_task(pid, PIDTYPE_PID);
-	if (!task) {
+	if (!task || !task_storage_ptr(task)) {
 		err =3D -ENOENT;
 		goto out;
 	}
--=20
2.24.1

