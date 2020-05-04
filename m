Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D00701C32C1
	for <lists+bpf@lfdr.de>; Mon,  4 May 2020 08:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgEDGZ6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 4 May 2020 02:25:58 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:5908 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726330AbgEDGZ5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 4 May 2020 02:25:57 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0446DIrr010054
        for <bpf@vger.kernel.org>; Sun, 3 May 2020 23:25:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=DW0XdxoLXhkZ4dTQlGlgVUqbJKaz70cCOFccKPNNn4A=;
 b=Nqxs6hlbhMLebkRrNoVgGvxmS7e/xhMAat0sLRGz/bHrltl68b/Vy0t9Ho5I/gLA47Vu
 PQ1R3h3bMd58CSdsN3NROumJnODxfiemN0cHIKhL80iNwU5dK0DormOYJLnkVns4Jx5z
 t9CM/4FMmQWASs8UEdV3J5NZHKk8OGMuP1w= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 30srse3cp5-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 03 May 2020 23:25:57 -0700
Received: from intmgw001.03.ash8.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Sun, 3 May 2020 23:25:56 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 4E1223702037; Sun,  3 May 2020 23:25:52 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     Andrii Nakryiko <andriin@fb.com>, <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, <netdev@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next v2 05/20] bpf: implement bpf_seq_read() for bpf iterator
Date:   Sun, 3 May 2020 23:25:52 -0700
Message-ID: <20200504062552.2047789-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200504062547.2047304-1-yhs@fb.com>
References: <20200504062547.2047304-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-04_02:2020-05-01,2020-05-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=711
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005040054
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf iterator uses seq_file to provide a lossless
way to transfer data to user space. But we want to call
bpf program after all objects have been traversed, and
bpf program may write additional data to the
seq_file buffer. The current seq_read() does not work
for this use case.

Besides allowing stop() function to write to the buffer,
the bpf_seq_read() also fixed the buffer size to one page.
If any single call of show() or stop() will emit data
more than one page to cause overflow, -E2BIG error code
will be returned to user space.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 kernel/bpf/bpf_iter.c | 128 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 128 insertions(+)

diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index 05ae04ac1eca..2674c9cbc3dc 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -26,6 +26,134 @@ static DEFINE_MUTEX(targets_mutex);
 /* protect bpf_iter_link changes */
 static DEFINE_MUTEX(link_mutex);
=20
+/* bpf_seq_read, a customized and simpler version for bpf iterator.
+ * no_llseek is assumed for this file.
+ * The following are differences from seq_read():
+ *  . fixed buffer size (PAGE_SIZE)
+ *  . assuming no_llseek
+ *  . stop() may call bpf program, handling potential overflow there
+ */
+static ssize_t bpf_seq_read(struct file *file, char __user *buf, size_t =
size,
+			    loff_t *ppos)
+{
+	struct seq_file *seq =3D file->private_data;
+	size_t n, offs, copied =3D 0;
+	int err =3D 0;
+	void *p;
+
+	mutex_lock(&seq->lock);
+
+	if (!seq->buf) {
+		seq->size =3D PAGE_SIZE;
+		seq->buf =3D kmalloc(seq->size, GFP_KERNEL);
+		if (!seq->buf)
+			goto Enomem;
+	}
+
+	if (seq->count) {
+		n =3D min(seq->count, size);
+		err =3D copy_to_user(buf, seq->buf + seq->from, n);
+		if (err)
+			goto Efault;
+		seq->count -=3D n;
+		seq->from +=3D n;
+		copied =3D n;
+		goto Done;
+	}
+
+	seq->from =3D 0;
+	p =3D seq->op->start(seq, &seq->index);
+	if (!p || IS_ERR(p))
+		goto Stop;
+
+	err =3D seq->op->show(seq, p);
+	if (seq_has_overflowed(seq)) {
+		err =3D -E2BIG;
+		goto Error_show;
+	} else if (err) {
+		/* < 0: go out, > 0: skip */
+		if (likely(err < 0))
+			goto Error_show;
+		seq->count =3D 0;
+	}
+
+	while (1) {
+		loff_t pos =3D seq->index;
+
+		offs =3D seq->count;
+		p =3D seq->op->next(seq, p, &seq->index);
+		if (pos =3D=3D seq->index) {
+			pr_info_ratelimited("buggy seq_file .next function %ps "
+				"did not updated position index\n",
+				seq->op->next);
+			seq->index++;
+		}
+
+		if (!p || IS_ERR(p)) {
+			err =3D PTR_ERR(p);
+			break;
+		}
+		if (seq->count >=3D size)
+			break;
+
+		err =3D seq->op->show(seq, p);
+		if (seq_has_overflowed(seq)) {
+			if (offs =3D=3D 0) {
+				err =3D -E2BIG;
+				goto Error_show;
+			}
+			seq->count =3D offs;
+			break;
+		} else if (err) {
+			/* < 0: go out, > 0: skip */
+			seq->count =3D offs;
+			if (likely(err < 0)) {
+				if (offs =3D=3D 0)
+					goto Error_show;
+				break;
+			}
+		}
+	}
+Stop:
+	offs =3D seq->count;
+	/* may call bpf program */
+	seq->op->stop(seq, p);
+	if (seq_has_overflowed(seq)) {
+		if (offs =3D=3D 0)
+			goto Error_stop;
+		seq->count =3D offs;
+	}
+
+	n =3D min(seq->count, size);
+	err =3D copy_to_user(buf, seq->buf, n);
+	if (err)
+		goto Efault;
+	copied =3D n;
+	seq->count -=3D n;
+	seq->from =3D n;
+Done:
+	if (!copied)
+		copied =3D err;
+	else
+		*ppos +=3D copied;
+	mutex_unlock(&seq->lock);
+	return copied;
+
+Error_show:
+	seq->op->stop(seq, p);
+Error_stop:
+	seq->count =3D 0;
+	goto Done;
+
+Enomem:
+	err =3D -ENOMEM;
+	goto Done;
+
+Efault:
+	err =3D -EFAULT;
+	goto Done;
+}
+
 int bpf_iter_reg_target(struct bpf_iter_reg *reg_info)
 {
 	struct bpf_iter_target_info *tinfo;
--=20
2.24.1

