Return-Path: <bpf+bounces-7686-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E29BF77B11A
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 08:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C93D280FB8
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 06:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B8B5671;
	Mon, 14 Aug 2023 06:07:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6A75237
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 06:07:40 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8321AA;
	Sun, 13 Aug 2023 23:07:38 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37E5wGo8008597;
	Mon, 14 Aug 2023 06:07:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=+m5E0ort8uLDB//je7UqdQDP2mIAZ9xlBWCe8OC2AK0=;
 b=C7SbOWCgovIxo4SwWmO292UXFHY3cLt1XtEFpjVwZ4uT7eomzSIZhy8pufaCw0PmqMKf
 Edb0w3w5+9PwEcc4rNHFX7mC7nqderF7wNnfMCZi9ck9DxAMdyF/vHyhlri3I8lGXN1/
 aYLM7JO3ZM8zUDoBZz9P1PBh+BNsdN6gYcJSkaOMWaT7ldGxp6gr/udA1DGu+Pf3xYcb
 YPg4gEOW0bS4E4bF6pL0FFsVyD2wU2TOdduHLPO26c503EyCHoLK328vu89rDlgF0fBP
 yaASpF1CqBDlma6FfoA0UpJ3j5vlzTHRnfPRBhdB6/ThylCUNZAFlNt656zqKrZuYPhc yg== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sfekc04f2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Aug 2023 06:07:24 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37E4jMsh003576;
	Mon, 14 Aug 2023 06:07:23 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3semds2542-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Aug 2023 06:07:23 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37E67LN223855836
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Aug 2023 06:07:21 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E64B320043;
	Mon, 14 Aug 2023 06:07:20 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6640D2004D;
	Mon, 14 Aug 2023 06:07:20 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 14 Aug 2023 06:07:20 +0000 (GMT)
Received: from bgray-lenovo-p15.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id AD16C60571;
	Mon, 14 Aug 2023 16:07:17 +1000 (AEST)
From: Benjamin Gray <bgray@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-doc@vger.kernel.org, bpf@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc: abbotti@mev.co.uk, hsweeten@visionengravers.com, jan.kiszka@siemens.com,
        kbingham@kernel.org, mykolal@fb.com,
        Benjamin Gray <bgray@linux.ibm.com>
Subject: [PATCH 3/8] drivers/comedi: fix Python string escapes
Date: Mon, 14 Aug 2023 16:06:59 +1000
Message-ID: <20230814060704.79655-4-bgray@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230814060704.79655-1-bgray@linux.ibm.com>
References: <20230814060704.79655-1-bgray@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MZdZaOUs75wAymN1BJng2lpBtFubrPHw
X-Proofpoint-ORIG-GUID: MZdZaOUs75wAymN1BJng2lpBtFubrPHw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-13_24,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308140055
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Python 3.6 introduced a DeprecationWarning for invalid escape sequences.
This is upgraded to a SyntaxWarning in Python 3.12, and will eventually
be a syntax error.

Fix these now to get ahead of it before it's an error.

Signed-off-by: Benjamin Gray <bgray@linux.ibm.com>
---
 drivers/comedi/drivers/ni_routing/tools/convert_csv_to_c.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/comedi/drivers/ni_routing/tools/convert_csv_to_c.py b/drivers/comedi/drivers/ni_routing/tools/convert_csv_to_c.py
index 90378fb50580..3d124a887be9 100755
--- a/drivers/comedi/drivers/ni_routing/tools/convert_csv_to_c.py
+++ b/drivers/comedi/drivers/ni_routing/tools/convert_csv_to_c.py
@@ -44,7 +44,7 @@ def routedict_to_structinit_single(name, D, return_name=False):
 
     lines.append('\t\t[B({})] = {{'.format(D0_sig))
     for D1_sig, value in D1:
-      if not re.match('[VIU]\([^)]*\)', value):
+      if not re.match('[VIU]\\([^)]*\\)', value):
         sys.stderr.write('Invalid register format: {}\n'.format(repr(value)))
         sys.stderr.write(
           'Register values should be formatted with V(),I(),or U()\n')
-- 
2.41.0


