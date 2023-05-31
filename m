Return-Path: <bpf+bounces-1495-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 095B3717A98
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 10:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7F2C280CDB
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 08:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D44BE5A;
	Wed, 31 May 2023 08:48:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF3F139F
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 08:48:29 +0000 (UTC)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9815A122
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 01:48:25 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230531084821epoutp04dff754429acf2bc12a865e342d2d182f~kLiX1K2KR3232332323epoutp04k
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 08:48:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230531084821epoutp04dff754429acf2bc12a865e342d2d182f~kLiX1K2KR3232332323epoutp04k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1685522901;
	bh=baxG0r+ENYpq+lI/FYBiiMgnvFDrHXtZq7+5iYd8pQA=;
	h=From:To:Cc:Subject:Date:References:From;
	b=dQiR9FnQ6W+elEKOya0d4D5rWQ8y2UVrjrskw9f36r/PkSkjB2EQWnfbilQkP7ykG
	 BY5NtLuYjAVb522SDZFQg/wbLO/6GbCsPyrTtRO1lPP8aPTNI4+g+J715GISjfdbSA
	 qmYsp2IM4NtpQLPAPEIaZHfQasx0a9WjcBeHwSuI=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20230531084820epcas5p1d2dece3895cef198664d199ceef27cb2~kLiW_u3dk0967909679epcas5p1_;
	Wed, 31 May 2023 08:48:20 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A3.E4.44881.4D907746; Wed, 31 May 2023 17:48:20 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20230531084800epcas5p1c02d5a7ffcef2bb7cf626bf52beb0eee~kLiFCk88D0492504925epcas5p16;
	Wed, 31 May 2023 08:48:00 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20230531084800epsmtrp1fdad5e72796891bef08c9f54f5f6e3cd~kLiFAGqYa1155311553epsmtrp1y;
	Wed, 31 May 2023 08:48:00 +0000 (GMT)
X-AuditID: b6c32a4a-c47ff7000001af51-33-647709d4ec87
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	7A.37.28392.0C907746; Wed, 31 May 2023 17:48:00 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.44]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20230531084755epsmtip1167910a1f8408e3d75b735c30e9abd8b~kLiAQ9o2Z2274722747epsmtip1J;
	Wed, 31 May 2023 08:47:55 +0000 (GMT)
From: Maninder Singh <maninder1.s@samsung.com>
To: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
	thunder.leizhen@huawei.com, mcgrof@kernel.org, boqun.feng@gmail.com,
	vincenzopalazzodev@gmail.com, ojeda@kernel.org, jgross@suse.com,
	brauner@kernel.org, michael.christie@oracle.com, samitolvanen@google.com,
	glider@google.com, peterz@infradead.org, keescook@chromium.org,
	stephen.s.brennan@oracle.com, alan.maguire@oracle.com, pmladek@suse.com
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Maninder Singh
	<maninder1.s@samsung.com>, Onkarnath <onkarnath.1@samsung.com>
Subject: [PATCH v2 1/2] bpf: make defination of bpf_dump_raw_ok based on
 CONFIG_KALLSYMS
Date: Wed, 31 May 2023 14:17:44 +0530
Message-Id: <20230531084745.877337-1-maninder1.s@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf1CTdRzH+z7Ps2c/avGI3vUVC7x1HOeKIVr2vSvCuwgfuSs6u6uL8Grn
	Hn5cbK5NROmqDdaGGAQemtsItogYxIlOyDnZcGM1QQxleAJdSjE1JD1hCJgisT3j8r/X5/N5
	v7/v7+d7Xx4e20jG8QoVexiVQlokIgXEz70bkpKH+SWyjZMaEo14tQSaf2DG0ez937movVOL
	oZDPT6Kp3hmAmqxzODJMu3Dk9fdwUf3oJlTmsGHIV2fC0cBBObrprsJQwFlPot5GPYHaD7Ry
	0EjNdYAWD41wUGtjC0C2r+9ykL/qLIaWJu5xULPtNgcNLUwRyN+ySKJFnwdDwX9nSFR9YQf6
	+4ejYGs8bdZcIuja8jtc+rTpDy5tsRfTOt9tDn3SJqYrR4Zw2t52gKStmsM4PX19jKCrO9sA
	3dF5maBD9vh3hDmC12RMUeFeRpXy+seCAl3TAlC6hPsqzn5LaoD1yUrA50HqJWgpm8XDHEud
	AbDVH18JBMs8A+D4mJZgixCA7l+0nBVHm3+awzqcABpO7GdFswAeM96PDEhKAtuc3RH3GspB
	wIsnxrFwgVN6AM0NHiKsWk3lwIkefSScoBKh9585bpiFVBq8OujB2bgEaByaj/ZXwT5jMOLF
	l/vlXWY8fCikWvjwpv3HqCED6hvqCJZXw1v+Ti7LcXDyG/0y85a5BHbVfMl6dQD21NeRrCYd
	Bi9ZOWENTm2AHc4Utv0cPNx/DGNzn4ZVD4IY2xdCR8MKJ0Ld6PHoE62Doenp6BVoGGpqjz7X
	Thh0zZM1IMH02Dqmx9Yx/Z9sAXgbWMso1fJ8Rv2ycpOCKZGopXJ1sSJfsmu33A4if1ic5QB/
	jt+VeAHGA14AebhojTBNqpbFCmXS/aWMavdHquIiRu0F63iE6BlhUlrfrlgqX7qH+YRhlIxq
	ZYrx+HEabGtfxYvKmEGl9Yg45dzAaFeCR61dJX54Uued1KQ3b48prt5i1IjWfyXfXPpFxatl
	eZ+mpzyPXHU3lizn+8nBM/JsFe+UZVt2bukbOecyZ56If7dBkOluRoKDR9uXFIfeHk4cuzcV
	s+XqI4v7lcvvy7O6a2+FFNmytaK5oItfZbgBU6843H/9+jBoaCjo23fx2b0B4WbznQHPepf1
	Pa9ampNRP9pa6LLNncJ/+1AWeKouQ1PrPHLlO3DB6rtWnjz8VhzXss3mGcoOCLoCx2cncnMz
	C2Mebax9Ifk8NJUYcz/3ZSyd7i4wmL9P1e0syzLnSZLy3rw2UP1Zx46FD/prHYk/iQh1gTRV
	jKvU0v8A+j2A0jIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Rf0yMcRzH+z7Pc889xdnTYR5lF2c22jpFs6+RheEhomxW+iPHPUp153ZP
	KfmxSkqlk0R1l+mUXXdrk+uy63eucgyli+2S/JhC5Uc/FKU7VGz+e31e7/dnnz8+BMpvxdyI
	Y7JYRiETxwhxF+xus1Dg1eQcL/FuLRJBmzkZg99/qlH4baKbC8uNyQgcbbHgcLB5BMASzTgK
	04frUWi2NHJhUdcamGIqQ2BLngqFj7Ok8ENDNgI7a4pw2HwjDYPlGToOtOX0AWjPtXGg7oYW
	wLKLQxxoyW5C4K93Yxx4q+wzB1p/DGLQorXj0N5yD4G9kyM4VD4Jhh9LC4C/gFYndWD05XNf
	uHS1qodLFxvi6NSWzxy6ssyTzrRZUdqgz8BpTdJVlB7ue4HRSqMe0LeNzzF61CDYxzvoslHC
	xBw7wShWbzrkEpla8gPI63kJF5ry8SSgmZMJnAmK9KX0lmHONPNJE6AmO+JnvTs14fiKzfJ8
	Suf4wJ3tjACqTrd0mnFSROlr6v50XIgF5EuMaui/w50eUDITUG/fl89szCdDqIvaTmSaMXIF
	Zf40PuN5pB/1qv0eOnvBgyq0fv/rXamHhb0zl9E//lyVGs0B81T/Rar/omKA6MFiRs5KI6Ss
	j3yNjIkXsWIpGyeLEB05LjWAmU97eppAnX5IZAYIAcyAIlDhAp6fmJXweRLxyURGcTxcERfD
	sGbgTmDCRbynmQ/D+WSEOJaJZhg5o/iXIoSzWxKyJHpl7fbEDbU30yLD5hkdzGHNMutQ2ph3
	4OaxTbkSrTK/o21Kd7+G7CvtDmUPXN9zaqf7fkNQ/9quPl82Vxmu13VPqrPPxvJrU+xR96nY
	Z4LTb9AKXJaFVa7yf1tKPKutruh1ei+fzKvIja9+cPdl1Y7qttNng323pXVZg6SvjY9Kh3ne
	oYd7dqqrtr56wwycd/IIPnW0EzfkuJoaFaMBX5vzEjKm0gPc0B4jwSkaX1eQHrY88gzbfk2n
	8obi3dn8vZ09UfYOv8aKAqVbnMChidi3cL2tLiOs5op/oFdjg8BJckl2qX5uiCPQuD7kXf+o
	tnKs5Kg9IHXLwGuT6y4hxkaKfTxRBSv+DblvRytYAwAA
X-CMS-MailID: 20230531084800epcas5p1c02d5a7ffcef2bb7cf626bf52beb0eee
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20230531084800epcas5p1c02d5a7ffcef2bb7cf626bf52beb0eee
References: <CGME20230531084800epcas5p1c02d5a7ffcef2bb7cf626bf52beb0eee@epcas5p1.samsung.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

No functional change with this commit.

As of now bpf_dump_raw_ok() is dependent on kallsyms_show_value().
Rearranging the code to return false directly in defination of
bpf_dump_raw_ok() based on CONFIG_KALLSYMS.

@reason: next patch will make kallsyms_show_value() defination
generic and bpf_dump_raw_ok() will return true otherwise.

Thus make decision based on CONFIG rather than kallsyms_show_value(),
as bpf functionality is heavily dependent on KALLSYMS.

Co-developed-by: Onkarnath <onkarnath.1@samsung.com>
Signed-off-by: Onkarnath <onkarnath.1@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
---
v1 -> v2 : made separate patches for kallsyms and bpf

 include/linux/filter.h | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index bbce89937fde..1f237a3bb11a 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -923,13 +923,21 @@ bool bpf_jit_supports_kfunc_call(void);
 bool bpf_jit_supports_far_kfunc_call(void);
 bool bpf_helper_changes_pkt_data(void *func);
 
+/*
+ * Reconstruction of call-sites is dependent on kallsyms,
+ * thus make dump the same restriction.
+ */
+#ifdef CONFIG_KALLSYMS
 static inline bool bpf_dump_raw_ok(const struct cred *cred)
 {
-	/* Reconstruction of call-sites is dependent on kallsyms,
-	 * thus make dump the same restriction.
-	 */
 	return kallsyms_show_value(cred);
 }
+#else
+static inline bool bpf_dump_raw_ok(const struct cred *cred)
+{
+	return false;
+}
+#endif
 
 struct bpf_prog *bpf_patch_insn_single(struct bpf_prog *prog, u32 off,
 				       const struct bpf_insn *patch, u32 len);
-- 
2.17.1


