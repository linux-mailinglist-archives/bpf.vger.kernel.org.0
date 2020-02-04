Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55034152216
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2020 22:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbgBDVuq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Feb 2020 16:50:46 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:1632 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727445AbgBDVuq (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 4 Feb 2020 16:50:46 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 014LfomI012161
        for <bpf@vger.kernel.org>; Tue, 4 Feb 2020 13:50:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=sWtCMIu2dw3xtKwjP+MOwVfsEnqHf1b34zTxqO2z/Eg=;
 b=bna+k5tgd0DTdedjgzodoCM6YPuIXF22WaAYN6OZvPS6a4wrGJWtCHwoiW+XvUjXG125
 Vhj86CAFHkxGR1AkkVlhh8L7+8CnOa6Tepqv3Wn9IODVhI+FlfWoAGsFmKSvzVoQupmM
 0n2UoNZs3zPHLDtsNCwcQVf00+jfL0xs5co= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2xy4dnbmjf-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 04 Feb 2020 13:50:45 -0800
Received: from intmgw003.03.ash8.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 4 Feb 2020 13:50:44 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 05C3062E4598; Tue,  4 Feb 2020 13:50:39 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Song Liu <songliubraving@fb.com>, Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v2 bpf] tools/bpf/runqslower: Rebuild libbpf.a on libbpf source change
Date:   Tue, 4 Feb 2020 13:50:37 -0800
Message-ID: <20200204215037.2258698-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-04_08:2020-02-04,2020-02-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 suspectscore=13 lowpriorityscore=0 malwarescore=0 spamscore=0
 impostorscore=0 bulkscore=0 adultscore=0 mlxlogscore=600
 priorityscore=1501 clxscore=1015 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-1911200001
 definitions=main-2002040149
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add missing dependency of $(BPFOBJ) to $(LIBBPF_SRC), so that running make
in runqslower/ will rebuild libbpf.a when there is change in libbpf/.

Fixes: 9c01546d26d2 ("tools/bpf: Add runqslower tool to tools/bpf")
Acked-by: Andrii Nakryiko <andriin@fb.com>
Cc: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 tools/bpf/runqslower/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/runqslower/Makefile b/tools/bpf/runqslower/Makefile
index 87eae5be9bcd..39edd68afa8e 100644
--- a/tools/bpf/runqslower/Makefile
+++ b/tools/bpf/runqslower/Makefile
@@ -75,7 +75,7 @@ $(OUTPUT)/vmlinux.h: $(VMLINUX_BTF_PATH) | $(OUTPUT) $(BPFTOOL)
 	fi
 	$(Q)$(BPFTOOL) btf dump file $(VMLINUX_BTF_PATH) format c > $@
 
-$(BPFOBJ): | $(OUTPUT)
+$(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(OUTPUT)
 	$(Q)$(MAKE) $(submake_extras) -C $(LIBBPF_SRC)			       \
 		    OUTPUT=$(abspath $(dir $@))/ $(abspath $@)
 
-- 
2.17.1

