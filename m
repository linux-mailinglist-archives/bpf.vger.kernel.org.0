Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0F1C3FE345
	for <lists+bpf@lfdr.de>; Wed,  1 Sep 2021 21:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344401AbhIATpy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Sep 2021 15:45:54 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:8304 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1344065AbhIATpx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 1 Sep 2021 15:45:53 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 181JiDBb013538
        for <bpf@vger.kernel.org>; Wed, 1 Sep 2021 12:44:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=6FZ1y9HK4dEBXSOD/iD4y7QxwAu2bTYeixuvk8S1xPM=;
 b=Ou1FC+NdZMXPSuHF9Da37sdGowF0W2saKHMQic1g+576TvkO+QxmEtso3/efm3UF9jSI
 NZjHYFc+39ILuumrtnYa8khe7KqDzXAwEQz8i9sTRH2a96p2aVrhbnctnC1npVnlGXr3
 HQCVm7IgH+VE7rPApztAFjn8P5MLynqcbWk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 3atdyh2smq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 01 Sep 2021 12:44:56 -0700
Received: from intmgw006.03.ash8.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 1 Sep 2021 12:44:54 -0700
Received: by devvm3431.ftw0.facebook.com (Postfix, from userid 239838)
        id AAC4E9CDE3FF; Wed,  1 Sep 2021 12:44:44 -0700 (PDT)
From:   Matt Smith <alastorze@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <andriin@kernel.org>,
        <daniel@iogearbox.net>, <kernel-team@fb.com>
CC:     Matt Smith <alastorze@fb.com>
Subject: [PATCH v2 bpf-next 2/3] bpftool: Provide a helper method for accessing bpf binary data
Date:   Wed, 1 Sep 2021 12:44:38 -0700
Message-ID: <20210901194439.3853238-3-alastorze@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210901194439.3853238-1-alastorze@fb.com>
References: <20210901194439.3853238-1-alastorze@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: 2L25q7sqdIXsTdlJMFt_EEBjAT4Ps9Zj
X-Proofpoint-ORIG-GUID: 2L25q7sqdIXsTdlJMFt_EEBjAT4Ps9Zj
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-01_05:2021-09-01,2021-09-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 clxscore=1015 suspectscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109010114
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This adds a binary method X_elf_bytes() which returns the binary data of
the compiled bpf object.  It additionally sets the size of the return
data to the provided size_t pointer argument.

The assignment to s->data is cast to void * to ensure no warning is
issued if compiled with a previous version of libbpf where the
bpf_object_skeleton field is void * instead of const void *

Signed-off-by: Matt Smith <alastorze@fb.com>
---
 tools/bpf/bpftool/gen.c | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index d40d92bbf0e4..f54dc4792fce 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -238,8 +238,8 @@ static void codegen(const char *template, ...)
 		} else if (c =3D=3D '\n') {
 			break;
 		} else {
-			p_err("unrecognized character at pos %td in template '%s'",
-			      src - template - 1, template);
+			p_err("unrecognized character at pos %td in template '%s': '%c'",
+			      src - template - 1, template, c);
 			free(s);
 			exit(-1);
 		}
@@ -406,7 +406,7 @@ static void codegen_destroy(struct bpf_object *obj, c=
onst char *obj_name)
 	}
=20
 	bpf_object__for_each_map(map, obj) {
-		const char * ident;
+		const char *ident;
=20
 		ident =3D get_map_ident(map);
 		if (!ident)
@@ -787,6 +787,9 @@ static int do_skeleton(int argc, char **argv)
 			free(obj);					    \n\
 		}							    \n\
 									    \n\
+		static inline const void *		\n\
+		%1$s__elf_bytes(size_t *sz);	\n\
+										\n\
 		static inline int					    \n\
 		%1$s__create_skeleton(struct %1$s *obj);		    \n\
 									    \n\
@@ -943,25 +946,31 @@ static int do_skeleton(int argc, char **argv)
 	codegen("\
 		\n\
 									    \n\
-			s->data_sz =3D %d;				    \n\
-			s->data =3D (void *)\"\\				    \n\
-		",
-		file_sz);
-
-	/* embed contents of BPF object file */
-	print_hex(obj_data, file_sz);
-
-	codegen("\
+			s->data =3D (void *)%2$s__elf_bytes(&s->data_sz);			    \n\
 		\n\
-		\";							    \n\
 									    \n\
 			return 0;					    \n\
 		err:							    \n\
 			bpf_object__destroy_skeleton(s);		    \n\
 			return -ENOMEM;					    \n\
 		}							    \n\
-									    \n\
-		#endif /* %s */						    \n\
+										\n\
+		static inline const void *		\n\
+		%2$s__elf_bytes(size_t *sz)		\n\
+		{								\n\
+			*sz =3D %1$d;					\n\
+			return (const void *)\"\\	\n\
+		"
+		, file_sz, obj_name);
+
+	/* embed contents of BPF object file */
+	print_hex(obj_data, file_sz);
+
+	codegen("\
+		\n\
+		\";								\n\
+		}								\n\
+		#endif /* %s */					\n\
 		",
 		header_guard);
 	err =3D 0;
--=20
2.30.2

