Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D27A311EDE0
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2019 23:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfLMWcp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Dec 2019 17:32:45 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:52014 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726865AbfLMWcn (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 13 Dec 2019 17:32:43 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id xBDMV3n2022555
        for <bpf@vger.kernel.org>; Fri, 13 Dec 2019 14:32:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=kiJoSNaLITP5X1DNa6vIvQh09AsZOnyR8HLzZQRorF8=;
 b=YPjIST3qAgt1zWqGuCj0UQ9eMCWatrkEw5astVy32TSsRrQWgmeOse62PuL03JB5mrSN
 sUym06zImKtYHtUucjR0LcIF6ecdUzQbh0WX1PGJVamduq8fDlEfSnMn9MBfdeS7vFxX
 8p5zx283x218FOCuAh8fy1x17zkR4qSlTXU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 2wv8b032rn-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 13 Dec 2019 14:32:42 -0800
Received: from intmgw002.05.ash5.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 13 Dec 2019 14:32:41 -0800
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 149582EC1C8E; Fri, 13 Dec 2019 14:32:41 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v3 bpf-next 11/17] libbpf: reduce log level of supported section names dump
Date:   Fri, 13 Dec 2019 14:32:08 -0800
Message-ID: <20191213223214.2791885-12-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191213223214.2791885-1-andriin@fb.com>
References: <20191213223214.2791885-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-13_08:2019-12-13,2019-12-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 phishscore=0 priorityscore=1501 mlxlogscore=856 clxscore=1015 mlxscore=0
 adultscore=0 bulkscore=0 suspectscore=25 spamscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912130159
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It's quite spammy. And now that bpf_object__open() is trying to determine
program type from its section name, we are getting these verbose messages all
the time. Reduce their log level to DEBUG.

Acked-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 2ffd132aa8d6..6546a9dbfc14 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -5193,7 +5193,7 @@ int libbpf_prog_type_by_name(const char *name, enum bpf_prog_type *prog_type,
 	pr_warn("failed to guess program type from ELF section '%s'\n", name);
 	type_names = libbpf_get_type_names(false);
 	if (type_names != NULL) {
-		pr_info("supported section(type) names are:%s\n", type_names);
+		pr_debug("supported section(type) names are:%s\n", type_names);
 		free(type_names);
 	}
 
-- 
2.17.1

