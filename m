Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A545A29EAF
	for <lists+bpf@lfdr.de>; Fri, 24 May 2019 20:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404102AbfEXS7j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 May 2019 14:59:39 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:32946 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404010AbfEXS7j (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 24 May 2019 14:59:39 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4OIwZro026959
        for <bpf@vger.kernel.org>; Fri, 24 May 2019 11:59:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=YRgZqxCbn0fM+3mMzWXVoho+/Srtm72NQfHQJHQDULw=;
 b=aK5rKqu94FvbJht85zCihN5nVGG7hOZUX8L71+EjbKVvLviPSHq0L8yJea09wyHN1RNT
 yDzly1KRZKqSFcpzOAsGzmhkGorXmkAS95zCfnFhX839//ERNQRlhZlgFhmeWc6lLVq4
 WKLYYlCkTnwbqogteinTZDs2gGQzx20I9t4= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2spmbjgfu8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 24 May 2019 11:59:37 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Fri, 24 May 2019 11:59:36 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id 4A14D8613DC; Fri, 24 May 2019 11:59:36 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <andrii.nakryiko@gmail.com>, <ast@fb.com>, <daniel@iogearbox.net>,
        <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
        <kernel-team@fb.com>
CC:     Andrii Nakryiko <andriin@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v3 bpf-next 12/12] bpftool: update bash-completion w/ new c option for btf dump
Date:   Fri, 24 May 2019 11:59:07 -0700
Message-ID: <20190524185908.3562231-13-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190524185908.3562231-1-andriin@fb.com>
References: <20190524185908.3562231-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-24_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=884 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905240123
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add bash completion for new C btf dump option.

Cc: Quentin Monnet <quentin.monnet@netronome.com>
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/bpf/bpftool/bash-completion/bpftool | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index 50e402a5a9c8..75c01eafd3a1 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -638,11 +638,24 @@ _bpftool()
                             esac
                             return 0
                             ;;
+                        format)
+                            COMPREPLY=( $( compgen -W "c raw" -- "$cur" ) )
+                            ;;
                         *)
-                            if [[ $cword == 6 ]] && [[ ${words[3]} == "map" ]]; then
-                                 COMPREPLY+=( $( compgen -W 'key value kv all' -- \
-                                     "$cur" ) )
-                            fi
+                            # emit extra options
+                            case ${words[3]} in
+                                id|file)
+                                    _bpftool_once_attr 'format'
+                                    ;;
+                                map|prog)
+                                    if [[ ${words[3]} == "map" ]] && [[ $cword == 6 ]]; then
+                                        COMPREPLY+=( $( compgen -W "key value kv all" -- "$cur" ) )
+                                    fi
+                                    _bpftool_once_attr 'format'
+                                    ;;
+                                *)
+                                    ;;
+                            esac
                             return 0
                             ;;
                     esac
-- 
2.17.1

