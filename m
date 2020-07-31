Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A837A233D58
	for <lists+bpf@lfdr.de>; Fri, 31 Jul 2020 04:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731285AbgGaCmw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Jul 2020 22:42:52 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:40258 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731227AbgGaCmv (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 30 Jul 2020 22:42:51 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06V2cpVg029037
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2020 19:42:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=F2tolseWpM+siodrLcDQmpDthwMCbsWv2KzoR8Z14eY=;
 b=IdiWGRXRUFdFcVyj1O/KWmTvWkvoNTDodTF+ASFrCLtd5O17c4aNSR+bJHfdAiuZvgLu
 c0WMk8MGSNaaE+KKQgD+Sem6FF6K62WdG58DveGJVc6zi2Q0U7wrbkFS1lMGxxgWebbw
 ydt3yDqMC6INCZhlylr27yyPGIEJFbPiUAA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 32m01ckdtm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2020 19:42:51 -0700
Received: from intmgw002.08.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 30 Jul 2020 19:42:50 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id AA4482EC4E67; Thu, 30 Jul 2020 19:42:46 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next] tools build: propagate build failures from tools/build/Makefile.build
Date:   Thu, 30 Jul 2020 19:42:44 -0700
Message-ID: <20200731024244.872574-1-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-30_19:2020-07-30,2020-07-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 suspectscore=9 mlxlogscore=513
 phishscore=0 clxscore=1015 impostorscore=0 bulkscore=0 mlxscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007310017
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The '&&' command seems to have a bad effect when $(cmd_$(1)) exits with
non-zero effect: the command failure is masked (despite `set -e`) and all=
 but
the first command of $(dep-cmd) is executed (successfully, as they are mo=
stly
printfs), thus overall returning 0 in the end.

This means in practice that despite compilation errors, tools's build Mak=
efile
will return success. We see this very reliably with libbpf's Makefile, wh=
ich
doesn't get compilation error propagated properly. This in turns causes i=
ssues
with selftests build, as well as bpftool and other projects that rely on
building libbpf.

The fix is simple: don't use &&. Given `set -e`, we don't need to chain
commands with &&. The shell will exit on first failure, giving desired
behavior and propagating error properly.

Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Fixes: 275e2d95591e ("tools build: Move dependency copy into function")
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---

I'm sending this against bpf-next tree, given libbpf is affected enough f=
or me
to debug this fun problem that no one seemed to notice (or care, at least=
) in
almost 5 years. If there is a better kernel tree, please let me know.

 tools/build/Build.include | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/build/Build.include b/tools/build/Build.include
index 9ec01f4454f9..585486e40995 100644
--- a/tools/build/Build.include
+++ b/tools/build/Build.include
@@ -74,7 +74,8 @@ dep-cmd =3D $(if $(wildcard $(fixdep)),
 #                   dependencies in the cmd file
 if_changed_dep =3D $(if $(strip $(any-prereq) $(arg-check)),         \
                   @set -e;                                         \
-                  $(echo-cmd) $(cmd_$(1)) && $(dep-cmd))
+                  $(echo-cmd) $(cmd_$(1));                         \
+                  $(dep-cmd))
=20
 # if_changed      - execute command if any prerequisite is newer than
 #                   target, or command line has changed
--=20
2.24.1

