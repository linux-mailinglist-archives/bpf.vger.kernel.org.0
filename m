Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A026315624
	for <lists+bpf@lfdr.de>; Tue,  9 Feb 2021 19:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbhBISiq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Feb 2021 13:38:46 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:28134 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233516AbhBISfg (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 9 Feb 2021 13:35:36 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 119IPeBo012109
        for <bpf@vger.kernel.org>; Tue, 9 Feb 2021 10:34:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=iLpjtR2apKknZa9JJ0IOCrDk1p4qgiT/j6k9vaqSdkU=;
 b=cimiw0OVJqiHyjIHakRBr2e91e7UFhy7EwrRsxUjqM/oF1RAomtMLMWE6gPS8g+d0Xc1
 VqTFNRjoi0acIB1h/8x+PwsYQVAZSANNCVcIfz9JTDrbQefTCADtiEj7v/LMcWMRTKXg
 aBFDiUl8KLf2vO/6NT9KdPIXokJP0DAOYNE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36jc1umt23-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 09 Feb 2021 10:34:08 -0800
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 9 Feb 2021 10:33:56 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 23D7362E0A43; Tue,  9 Feb 2021 10:33:46 -0800 (PST)
From:   Song Liu <songliubraving@fb.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <bpf@vger.kernel.org>, Song Liu <songliubraving@fb.com>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>
Subject: [PATCH v3] checkpatch: do not apply "initialise globals to 0" check to BPF progs
Date:   Tue, 9 Feb 2021 10:33:43 -0800
Message-ID: <20210209183343.3929160-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-09_06:2021-02-09,2021-02-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1015 mlxlogscore=821
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102090088
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BPF programs explicitly initialise global variables to 0 to make sure
clang (v10 or older) do not put the variables in the common section.
Skip "initialise globals to 0" check for BPF programs to elimiate error
messages like:

    ERROR: do not initialise globals to 0
    #19: FILE: samples/bpf/tracex1_kern.c:21:

Cc: Andy Whitcroft <apw@canonical.com>
Cc: Joe Perches <joe@perches.com>
Signed-off-by: Song Liu <songliubraving@fb.com>

---
Changes v2 =3D> v3:
  1. Fix regex.
Changes v1 =3D> v2:
  1. Add function exclude_global_initialisers() to keep the code clean.
---
 scripts/checkpatch.pl | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 1afe3af1cc097..967ff2a0b3899 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2428,6 +2428,15 @@ sub get_raw_comment {
 	return $comment;
 }
=20
+sub exclude_global_initialisers {
+	my ($realfile) =3D @_;
+
+	# Do not check for BPF programs (tools/testing/selftests/bpf/progs/*.c,=
 samples/bpf/*_kern.c, *.bpf.c).
+	return $realfile =3D~ m@/^tools\/testing\/selftests\/bpf\/progs\/.*\.c@=
 ||
+		$realfile =3D~ m@^samples\/bpf\/.*_kern.c@ ||
+		$realfile =3D~ m@/bpf/.*\.bpf\.c$@;
+}
+
 sub process {
 	my $filename =3D shift;
=20
@@ -4323,7 +4332,8 @@ sub process {
 		}
=20
 # check for global initialisers.
-		if ($line =3D~ /^\+$Type\s*$Ident(?:\s+$Modifier)*\s*=3D\s*($zero_init=
ializer)\s*;/) {
+		if ($line =3D~ /^\+$Type\s*$Ident(?:\s+$Modifier)*\s*=3D\s*($zero_init=
ializer)\s*;/ &&
+		    !exclude_global_initialisers($realfile)) {
 			if (ERROR("GLOBAL_INITIALISERS",
 				  "do not initialise globals to $1\n" . $herecurr) &&
 			    $fix) {
--=20
2.24.1

