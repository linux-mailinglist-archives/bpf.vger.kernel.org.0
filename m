Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1EB27DF79
	for <lists+bpf@lfdr.de>; Wed, 30 Sep 2020 06:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725554AbgI3E2M (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Sep 2020 00:28:12 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:6750 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725779AbgI3E2L (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 30 Sep 2020 00:28:11 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08U4S9BE011182
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2020 21:28:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=M5XsswESoN5QpJOP7+ChINqAxLa5bOaOdk2gegAIBRA=;
 b=gVBa+kbbRk3a4tPpTJalPApEBuL+MGs7TwVWYsGbztUvONgfyuQJS5FtxlR2gAxElAyA
 I9FK6kK7xOePDMCnHFFgEmqdh8MTuSZvNHqDmTUqY9rPNKjrEpNaVsMNK2X3+wMJeBFd
 1p6Zqp3zMtVNEMC6ctHgntjMb1LDs4D2qV8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 33v1ndd3ve-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2020 21:28:11 -0700
Received: from intmgw001.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 29 Sep 2020 21:28:02 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 58C9E2EC77F1; Tue, 29 Sep 2020 21:27:58 -0700 (PDT)
From:   Andrii Nakryiko <andriin@fb.com>
To:     <dwarves@vger.kernel.org>
CC:     <bpf@vger.kernel.org>, Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH dwarves 03/11] dwarves: expose and maintain active debug info loader operations
Date:   Tue, 29 Sep 2020 21:27:34 -0700
Message-ID: <20200930042742.2525310-4-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200930042742.2525310-1-andriin@fb.com>
References: <20200930042742.2525310-1-andriin@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-30_01:2020-09-29,2020-09-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 mlxlogscore=696 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=38 phishscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009300033
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Maintain a pointer to debug_fmt_ops corresponding to currently used debug=
 info
format loader (DWARF, BTF, or CTF), to allow various parts of libdwarves =
to do
things like resolve string offset to actual string pointer in
a format-agnostic format. This allows to, say, load DWARF debug info, and=
 use
it for BTF generation, without either of them making assumptions about ho=
w
strings are actually stored internally.

This is going to be used in the next patch to allow BTF loader and encode=
r to
use a very different way of storing strings (not a global shared gobuffer=
).

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 dwarves.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/dwarves.c b/dwarves.c
index 8cb359fd1586..528caf23e76d 100644
--- a/dwarves.c
+++ b/dwarves.c
@@ -1901,6 +1901,8 @@ static struct debug_fmt_ops *debug_fmt_table[] =3D =
{
 	NULL,
 };
=20
+struct debug_fmt_ops *active_loader;
+
 static int debugging_formats__loader(const char *name)
 {
 	int i =3D 0;
@@ -1938,6 +1940,7 @@ int cus__load_file(struct cus *cus, struct conf_loa=
d *conf,
 				conf->conf_fprintf->has_alignment_info =3D debug_fmt_table[loader]->=
has_alignment_info;
=20
 			err =3D 0;
+			active_loader =3D debug_fmt_table[loader];
 			if (debug_fmt_table[loader]->load_file(cus, conf,
 							       filename) =3D=3D 0)
 				break;
@@ -1949,17 +1952,20 @@ int cus__load_file(struct cus *cus, struct conf_l=
oad *conf,
 			fp =3D sep + 1;
 		}
 		free(fpath);
+		active_loader =3D NULL;
 		return err;
 	}
=20
 	while (debug_fmt_table[i] !=3D NULL) {
 		if (conf && conf->conf_fprintf)
 			conf->conf_fprintf->has_alignment_info =3D debug_fmt_table[i]->has_al=
ignment_info;
+		active_loader =3D debug_fmt_table[i];
 		if (debug_fmt_table[i]->load_file(cus, conf, filename) =3D=3D 0)
 			return 0;
 		++i;
 	}
=20
+	active_loader =3D NULL;
 	return -EINVAL;
 }
=20
@@ -2283,8 +2289,10 @@ static int cus__load_running_kernel(struct cus *cu=
s, struct conf_load *conf)
 		if (conf && conf->conf_fprintf)
 			conf->conf_fprintf->has_alignment_info =3D debug_fmt_table[loader]->h=
as_alignment_info;
=20
+		active_loader =3D debug_fmt_table[loader];
 		if (debug_fmt_table[loader]->load_file(cus, conf, "/sys/kernel/btf/vml=
inux") =3D=3D 0)
 			return 0;
+		active_loader =3D NULL;
 	}
 try_elf:
 	elf_version(EV_CURRENT);
--=20
2.24.1

