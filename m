Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEE3711EE0E
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2019 23:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbfLMW5K (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Dec 2019 17:57:10 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:32518 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725948AbfLMW5K (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 13 Dec 2019 17:57:10 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBDMt521022771
        for <bpf@vger.kernel.org>; Fri, 13 Dec 2019 14:57:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=1dJG8uMwcBDrpwgMjW91dzs8cFo6UiMu8gULn0pA6II=;
 b=hLa3xH3h+rgeSx4UjMInPee2k5RQ0dBbZNN+3BaRtdkpnqEywoEX8mEPvIqFR2CMj0Ol
 LAlheDq0iZ5+yAyxSgaIpD3BOrz5Ojqe07uVemb4jn+8YyQQNobQKalCNmn1pITsGYcG
 Ryco+kdylxNOMA4PPia+cIAFbUmUhgB3fkY= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2wvdw4hrp6-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 13 Dec 2019 14:57:08 -0800
Received: from intmgw001.41.prn1.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Fri, 13 Dec 2019 14:56:38 -0800
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 7A4BB2EC1C8E; Fri, 13 Dec 2019 14:32:54 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v3 bpf-next 17/17] bpftool: add `gen skeleton` BASH completions
Date:   Fri, 13 Dec 2019 14:32:14 -0800
Message-ID: <20191213223214.2791885-18-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191213223214.2791885-1-andriin@fb.com>
References: <20191213223214.2791885-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-13_08:2019-12-13,2019-12-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 suspectscore=8 mlxscore=0 mlxlogscore=725 phishscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912130163
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add BASH completions for gen sub-command.

Cc: Quentin Monnet <quentin.monnet@netronome.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/bpf/bpftool/bash-completion/bpftool | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index 70493a6da206..986519cc58d1 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -716,6 +716,17 @@ _bpftool()
                     ;;
             esac
             ;;
+        gen)
+            case $command in
+                skeleton)
+                    _filedir
+		    ;;
+                *)
+                    [[ $prev == $object ]] && \
+                        COMPREPLY=( $( compgen -W 'skeleton help' -- "$cur" ) )
+                    ;;
+            esac
+            ;;
         cgroup)
             case $command in
                 show|list|tree)
-- 
2.17.1

