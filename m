Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3F232239C
	for <lists+bpf@lfdr.de>; Tue, 23 Feb 2021 02:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbhBWBXJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Feb 2021 20:23:09 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:24062 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230446AbhBWBW3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 22 Feb 2021 20:22:29 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11N19TS4022990
        for <bpf@vger.kernel.org>; Mon, 22 Feb 2021 17:21:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=Pwq65nqqbYxmTJqwHg/JCNC3z7EZwINCn/e8mevwsJE=;
 b=nWeoRBvSF3WLqUj9fr99VwiQZFOyzpb60nuhTKm7Dlho4ei83HOX2fIx+/M0xVU/qnvk
 D/ehVenUWoMxouUjZHlTUlSvwgvGjzs8I5EnRnYOWy6zo8nKOsvAtkUc42fOALft0TW3
 X/qQGMDAbmDUE8S3xFCCRNxXP3B+xebmd9c= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36u14q3fqy-15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 22 Feb 2021 17:21:47 -0800
Received: from intmgw001.05.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 22 Feb 2021 17:21:23 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 3F8C062E0887; Mon, 22 Feb 2021 17:21:19 -0800 (PST)
From:   Song Liu <songliubraving@fb.com>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <peterz@infradead.org>, Song Liu <songliubraving@fb.com>
Subject: [PATCH v4 bpf-next 5/6] bpf: runqslower: prefer using local vmlimux to generate vmlinux.h
Date:   Mon, 22 Feb 2021 17:20:13 -0800
Message-ID: <20210223012014.2087583-6-songliubraving@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210223012014.2087583-1-songliubraving@fb.com>
References: <20210223012014.2087583-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-22_08:2021-02-22,2021-02-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 clxscore=1015 mlxlogscore=546
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102230006
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Update the Makefile to prefer using $(O)/mvlinux, $(KBUILD_OUTPUT)/vmlinu=
x
(for selftests) or ../../../vmlinux. These two files should have latest
definitions for vmlinux.h.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 tools/bpf/runqslower/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/runqslower/Makefile b/tools/bpf/runqslower/Makefil=
e
index 9d9fb6209be1b..c96ba90c6f018 100644
--- a/tools/bpf/runqslower/Makefile
+++ b/tools/bpf/runqslower/Makefile
@@ -16,7 +16,10 @@ CFLAGS :=3D -g -Wall
=20
 # Try to detect best kernel BTF source
 KERNEL_REL :=3D $(shell uname -r)
-VMLINUX_BTF_PATHS :=3D /sys/kernel/btf/vmlinux /boot/vmlinux-$(KERNEL_RE=
L)
+VMLINUX_BTF_PATHS :=3D $(if $(O),$(O)/vmlinux)		\
+	$(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux) \
+	../../../vmlinux /sys/kernel/btf/vmlinux	\
+	/boot/vmlinux-$(KERNEL_REL)
 VMLINUX_BTF_PATH :=3D $(or $(VMLINUX_BTF),$(firstword			       \
 					  $(wildcard $(VMLINUX_BTF_PATHS))))
=20
--=20
2.24.1

