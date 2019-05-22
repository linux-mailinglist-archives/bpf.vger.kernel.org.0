Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C22026EC1
	for <lists+bpf@lfdr.de>; Wed, 22 May 2019 21:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388006AbfEVTv1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 May 2019 15:51:27 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43348 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732477AbfEVTvU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 22 May 2019 15:51:20 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4MJlQea028378
        for <bpf@vger.kernel.org>; Wed, 22 May 2019 12:51:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=AsDvLBZU1SWFkqR/OC0wH/KfUVSFTHKxsataFqcf92o=;
 b=hNY5D1aEf63/vsARuzln6z+fW8R6mPGu5Xw+JnAWeiHlI1HzjiX/wSdGelco/bdxC2y8
 10uJmocXN9cgKhlTCaQZXTpJhwvW3A6V2K50wCSH9GTW0WY87+/r862MUUvsegGmNVyC
 e7s8nespS0viY6riynZqdkpu5ixI1btxTcs= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2sn9bgrysk-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 22 May 2019 12:51:20 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Wed, 22 May 2019 12:51:18 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id 83ED2862334; Wed, 22 May 2019 12:51:17 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <andrii.nakryiko@gmail.com>, <ast@fb.com>, <daniel@iogearbox.net>,
        <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
        <kernel-team@fb.com>
CC:     Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next 11/12] bpftool/docs: add description of btf dump C option
Date:   Wed, 22 May 2019 12:50:52 -0700
Message-ID: <20190522195053.4017624-12-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190522195053.4017624-1-andriin@fb.com>
References: <20190522195053.4017624-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-22_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=833 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905220138
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Document optional **c** option for btf dump subcommand.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/bpf/bpftool/Documentation/bpftool-btf.rst | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-btf.rst b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
index 2dbc1413fabd..3d0bdb90383b 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-btf.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
@@ -19,7 +19,7 @@ SYNOPSIS
 BTF COMMANDS
 =============
 
-|	**bpftool** **btf dump** *BTF_SRC*
+|	**bpftool** **btf dump** *BTF_SRC* [**c**]
 |	**bpftool** **btf help**
 |
 |	*BTF_SRC* := { **id** *BTF_ID* | **prog** *PROG* | **map** *MAP* [{**key** | **value** | **kv** | **all**}] | **file** *FILE* }
@@ -49,6 +49,9 @@ DESCRIPTION
                   .BTF section with well-defined BTF binary format data,
                   typically produced by clang or pahole.
 
+                  If **c** option is specified, BTF contents will be output in
+                  compilable C syntax.
+
 	**bpftool btf help**
 		  Print short help message.
 
-- 
2.17.1

